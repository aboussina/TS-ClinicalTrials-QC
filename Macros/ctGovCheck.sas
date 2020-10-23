%*=========================================================;
%* Title:  ctGovCheck.sas                                  ;
%*                                                         ;
%* Author:  Aaron Boussina, Hedral Inc.                    ;
%*                                                         ;
%* Purpose: Compare the TS dataset against                 ;
%*          ClinicalTrials.gov to ensure they are aligned. ;
%*          Output a diagnostics sas7bdat dataset of any   ;
%*          mismatches as well as the raw query resuls.    ;
%*                                                         ;
%* Input:   SDTM.TS and ClinicalTrials.gov                 ;
%*          Optionally, the name of a STANAG 1059          ;
%*          SAS format to verify the countries of          ;
%*          investigational sites.                         ;
%*                                                         ;
%*                                                         ;
%* Output:  ctGovMismatch.sas7bdat                         ;
%*          ctGovMismatch.html                             ;
%*          ctGovOutput.json                               ;
%*                                                         ;
%* Revisions:                                              ;
%* AB 22OCT2020:  N/A, initial release.                    ;
%*=========================================================;

%macro ctGovCheck(outLib = WORK /* SAS library for output file */,
                  srcLib = /* SAS library for SDTM inputs */,
                  stanagFormat = /* OPTIONAL - Name of STANAG 1059 SAS format */);


%*=========================================================;
%* Verify User Inputs;
%*=========================================================;

%if ^%symexist(srcLib) %then %do;
  %put %str(Error:  Source library for SDTM.TS not provided);
  %goto exit;
%end;

%if ^%symexist(stanagFormat) %then %let stanagFormat = ;


%*=========================================================;
%* Bring in Source Data;
%*=========================================================;

%*  Check if source data is present.  If not, quit the program;
%if ^%sysfunc(exist(&srcLib..ts)) %then %do;
  %put %str(Error:  No TS dataset found.);
  %goto exit;
%end;

data ts;
  set &srcLib..ts;
run;


%*=========================================================;
%* Get Registry Identifier ;
%*=========================================================;

proc sql noprint;
  SELECT TSVAL INTO :REGID
  FROM TS WHERE UPCASE(TSVAL) LIKE 'NCT%';
quit;

%*  Check if Registry ID was found.  If not, quit the program;
%if ^(%symexist(regid)) %then %do;
  %put Error:  No Registry ID found for this study.;
  %goto exit;
%end;


%*=========================================================;
%* Select Parameters of Interest to compare against CT.gov; 
%*=========================================================;

%let parmList = %str("ACTSUB", "AGEMAX", "AGEMIN", "FCNTRY", "HLTSUBJI", 
                     "INDIC", "INTMODEL", "INTTYPE", "RANDOM", "SEXPOP", 
                     "SPONSOR", "STYPE", "TINDTP", "TITLE", "TPHASE", 
                     "STUDYID",  "TRT");


%*=========================================================;
%* Query ClinicalTrials.gov for Info;
%*=========================================================;

%* Create fileref for output JSON based on outLib argument;
%* JSON format is preferred to XML due to stronger hierarchical support in SAS;

%let ctGovOutput = "%sysfunc(pathname(&outLib))/ctGovOutput.json";
filename clinOut &ctGovOutput;

proc http
  url = "ClinicalTrials.gov/api/query/full_studies?expr=&regID%nrstr(&fmt)=json"
  method = "get"
  out = clinOut;
quit;

%* Process output JSON as a SAS library;
libname clinRes JSON fileref = clinOut;

%*  Check if Study was found.  If not, quit the program;
proc sql noprint;
  SELECT VALUE INTO :STUDYFOUND FROM CLINRES.ALLDATA
  WHERE P2 = 'NStudiesReturned';
quit;

%* Cast integer to bool.  If no study was found then ;
%* studyFound macro variable resolves to 0 ;
%if ^&studyFound %then %do;
  %put %str(Error:  Study not found on ClinicalTrials.gov);
  %goto exit;
%end;


%*=========================================================;
%* Process JSON Response Data; 
%*=========================================================;

%* Create a format to rename keys and values of interest from;
%* ClinicalTrials.gov to the expected CDISC Terminology;
proc format;
  value $key
  "EnrollmentCount" = "ACTSUB"
  "MaximumAge" = "AGEMAX"
  "MinimumAge" = "AGEMIN"
  "LocationCountry" = "FCNTRY"
  "HealthyVolunteers" = "HLTSUBJI"
  "Condition" = "INDIC"
  "DesignInterventionModel" = "INTMODEL"
  "InterventionType" = "INTTYPE"
  "DesignAllocation" = "RANDOM"
  "Gender" = "SEXPOP"
  "LeadSponsorName" = "SPONSOR"
  "StudyType" = "STYPE"
  "DesignPrimaryPurpose" = "TINDTP"
  "OfficialTitle" = "TITLE"
  "Phase1" = "TPHASE"
  "OrgStudyId" = "STUDYID"
  "InterventionName" = "TRT"
  OTHER = 'DELETE'
  ;
  
  value $sex
  "All" = "BOTH"
  "Male" = 'M'
  "Female" = 'F'
  ;
  
  value $phase
  "Phase 0" = "PHASE 0 TRIAL"
  "Phase 1" = "PHASE I TRIAL"
  "Phase 2" = "PHASE II TRIAL"
  "Phase 3" = "PHASE III TRIAL"
  "Phase 4" = "PHASE IV TRIAL"
  "Phase 5" = "PHASE V TRIAL"
  "Not Applicable" = "NOT APPLICABLE"
  ;
  
  value $INTTYPE
  "Biological" = "BIOLOGIC"
  "Behavioral" = "BEHAVIORAL THERAPY"
  "Radiation" = "RADIATION THERAPY"
  "Procedure" = "PROCEDURE"
  "Drug" = "DRUG"
  "Device" = "DEVICE"
  "Dietary Supplement" = "DIETARY SUPPLEMENT"
  "Genetic" = "GENETIC"
  OTHER = "OTHER"
  ;
run;

%* Create Keys for the dataset based on the expected TS;
%* value-level items; 
data allData00;
  set clinRes.alldata;
  %* Set variable lengths to max to avoid truncation;
  length _key key $32767;

  %* Flatten the hierarchy into a single value-key pair;
  _key = coalescec(p10, p9, p8, p7, p6, p5, p4, p3, p2, p1);

  %* Multiple indications will be named Condition1, Condition2, ... ;
  %* due to the SAS interpretation of the JSON file.  This order may not;
  %* correspond to the TSSEQ from the TS domain, so "ConditionN" values; 
  %* will be renamed to "Condition";
  if compress(_key,, 'D') = "Condition" then _key = "Condition";
  
  %* Rename keys of interest to expected CDISC terminology;
  key = put(_key, $key.);
run;

%* Convert values from ClinicalTrial.gov to CDISC format;
data allData01;
  set allData00;

  if value ^= '' then do;
    %*  Convert Ages to CDISC format, e.g. 'P18Y';
    if key in ("AGEMAX", "AGEMIN") then do;
      value = transtrn(value, " Years", 'Y');
      value = transtrn(value, " Months", 'M');
      value = transtrn(value, " Days", 'D');
      value = cats('P', value);
    end;
    
    %* Convert HLTSUBJI to 'Y'/'N';
    if key = "HLTSUBJI" then do;
      if value = 'No' then value = 'N';
      else value = 'Y';
    end;
    
    %* Convert Intervention Models to CDISC terminology C99076;
    if key = "INTMODEL" then value = upcase(transtrn(value, " Assignment", trimn('')));

    %* Convert Intervention Type to CDISC terminology C99078;    
    if key = "INTTYPE" then value = put(value, $INTTYPE.);

    
    %* Convert Randomized to 'Y'/'N';
    if key = "RANDOM" then do;
      if value = "Randomized" then value = 'Y';
      else value = 'N';
    end;
    
    %* Convert Gender to CDISC terminology C66731;
    if key = "SEXPOP" then value = put(value, $sex.);
    
    %* Convert StudyType and Purpose to Uppercase;
    if key in ("STYPE", "TINDTP") then value = upcase(value);
    
    %* Remove Placebo from InterventionName;
    if key = "TRT" and index(upcase(value), "PLACEBO") then key = 'DELETE';
    
    %* Convert Phase to CDISC terminology C66737;
    %* The first trial listed ("Phase1") is typically used for TS;
    if key = "TPHASE" then value = put(value, $phase.); 
  end;
  
  if key ^= 'DELETE' and Value ^= '';
  
run;
 
%* Verify value-key pairs of interest are present;
%let rc = %sysfunc(open(allData01));
%let nObs = %sysfunc(attrn(&rc, nobs));
%let rc = %sysfunc(close(&rc));
 
%if &nObs = 0 %then %do;
  %put %str(Error:  Necessary data not found on ClinicalTrials.gov);
  %goto exit;
%end;
 
 
%*=========================================================;
%* Remove specific JSON elements based on their neighboring ;
%* elements.  ;
%*=========================================================;

proc sql noprint;
  %* Remove ACTSUBJ when the enrollment type is "Anticipated";
  SELECT COUNT(KEY) INTO :NANTICIPATED FROM ALLDATA00
  WHERE _KEY = "EnrollmentType" and VALUE = "Anticipated";
quit;

%if &nAnticipated > 0 %then %do;
  data allData01;
    set allData01;
    where key ^= "ACTSUBJ";
  run;
%end;


%*=========================================================;
%* Convert Countries to Country Codes;
%* CT.gov appears to use STANAG 1059 rather than ISO3166 or GENC;
%* CDISC expects the value as an ISO3166 3 letter code;
%* STANAG formats are not necessarily standard, so countries;
%* will only be proceessed if a format name is provided;
%*=========================================================;

%if "&stanagFormat" ^= "" %then %do;
   data allData02;
     set allData01;
     if key = "FCNTRY" then value = put(value, $&stanagFormat..);
   run;
%end;

 
%*=========================================================;
%* Handle Multiple Values per Key by sorting by key and;
%* value and collapsing to a concatenated string;
%* This can occur for FCNTRY, TRT, and INDIC; 
%*=========================================================;

proc sort data = allData02 out = allData03 (keep = key value) nodupkey;
  by key value;
run;

data allData04 (rename = (_value = value));
  
  %* Create new _value variable for concatenated values to;
  %* prevent potential truncation;
  length _value $32767; 
  set allData03;
  by key value;
  retain _value;
  
  if first.key then _value = value;
  else _value = catx(',', _value, value);
  
  if last.key;
  keep _value key;
run;

 
%*  Repeat the steps above for TS; 
proc sort data = ts out = ts00;
  by TSPARMCD TSVAL;
run;

data ts01 (rename = (_TSVAL = TSVAL));
  
  %* Create new _value variable for concatenated values to;
  %* prevent potential truncation;
  length _TSVAL $32767; 
  set ts00;
  by TSPARMCD TSVAL;
  retain _TSVAL;
  
  if first.TSPARMCD then _TSVAL = TSVAL;
  else _TSVAL = catx(',', _TSVAL, TSVAL);
  
  if last.TSPARMCD;
  drop TSVAL;
run;


%*=========================================================;
%* Prepare TS for a Merge with the processed JSON response (allData);
%* Mismatches from this merge will form the diagnostics output.;
%*=========================================================;

data ts02;
  
  %* Set variable lengths to max to avoid truncation;
  length value key $32767;
  set ts01;
  key = TSPARMCD;
  value = TSVAL;
  if TSPARMCD in (&parmList);
  output;
  
  %* Create an extra value-level record for the STUDYID variable;
  if _N_ = 1 then do;
    key = "STUDYID";
    value = STUDYID;
    output;
  end;
  
  keep key value;
run;

   
%*=========================================================;
%* Merge processed TS and JSON Response;
%* Output diagnostics file.;
%*=========================================================;

proc sql;
  CREATE TABLE ctGovMismatch as
  SELECT COALESCEC(TS.KEY, CTGOV.KEY) AS TSPARMCD, TS.VALUE AS TSVAL, CTGOV.VALUE AS CTGVAL
  FROM TS02 TS
  FULL OUTER JOIN ALLDATA04 CTGOV ON TS.KEY = CTGOV.KEY
  WHERE TSVAL ^= CTGVAL;
quit;

%if "&stanagFormat" = "" %then %do;
  data ctGovMismatch;
    set ctGovMismatch;
    where TSPARMCD ^= "FCNTRY";
  run;
%end;

data &outLib..ctGovMismatch (label = "Mismatches with ClinicalTrial.gov");
  label TSPARMCD = "Trial Summary Parameter Short Name"
  TSVAL = "TS Parameter Value"
  CTGVAL = "ClinicalTrials.gov Parameter Value";
  set ctGovMismatch;
run;

ods html path="%sysfunc(pathname(&outLib))" body="ctGovMismatch.htm";
proc print label;
run;
ods html close;

%exit:
%mend ctGovCheck;
