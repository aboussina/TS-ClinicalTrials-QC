%*=========================================================;
%* Title:  makeDummyTS.sas                                 ;
%*                                                         ;
%* Author:  Aaron Boussina, Hedral Inc.                    ;
%*                                                         ;
%* Purpose: Create a fake TS dataset to allow testing of   ;
%*          ctGovCheck.sas.  The resulting incomplete      ;
%*          TS is based on publicly available data from    ;
%*          ClinicalTrials.gov for NCT04573270.            ;
%*                                                         ;
%* Input:  The output Libref                               ;
%*                                                         ;
%* Output:  TS.sas7bdat                                    ;
%*                                                         ;
%* Revisions:                                              ;
%* AB 22OCT2020:  N/A, initial release.                    ;
%*=========================================================;

%macro makeDummyTS (outLib = WORK /* SAS library for output file */);

%*  Assign values from ClinicalTrials.gov to TS Variables;
%*  Use a numeric suffix for multiple values per item (eg INDIC2);
data TS00;
	ACTSUB = "40";
	ADAPT = 'N';
	ADDON = 'N';
	AGEMAX = "";
	AGEMIN = "P18Y";
	DCUTDESC = "DATABASE LOCK";
	DCUTDTC =  "2020-09-01";
	EXTTIND = 'N';
	FCNTRY = 'USA';
	HLTSUBJI = 'Y';
	INDIC = "Covid19";
	INDIC2 = "Prophylaxis";
	INTMODEL = "SINGLE GROUP";
	INTTYPE = "BIOLOGIC";
	LENGTH = "P4M";
	NARMS = '4';
	NCOHORT = '1';	
	OBJPRIM = "Survival Rate in COVID-19 infected patients admitted to hospital for complications";
	OBJPRIM2 = "Contraction Rate of COVID-19 in healthy healthcare workers following patients admitted to hospital for complications due to COVID-19";
	OBJSEC = "";
	OUTMSPRI = "Survival Rate in COVID-19 infected patients admitted to hospital for complications";
	PCLAS = "Mesenchymal Stem Cell Solution";
	PLANSUB = "50";
	RANDOM = 'Y';
	RANDQT = "0.67";
	REGID = "NCT04573270";
	SDTIGVER = "3.2";
	SDTMVER = "1.4";
	SEXPOP = "BOTH";
	SPONSOR = "Thomas Advanced Medical LLC";
	SSTDTC = "2020-04-24";
	SENDTC = "2020-09-01";
	STOPRULE = "INTERIM ANALYSIS FOR FUTILITY";
	STYPE = "INTERVENTIONAL";
	TBLIND = "DOUBLE BLIND";
	TCNTRL = "PLACEBO";
	TDIGRP = "";
	TINDTP = "TREATMENT";
	TITLE = "A Pilot Phase Study Evaluating the Effects of a Single Mesenchymal Stem Cell Injection in Patients With Suspected or Confirmed COVID-19 Infection and Healthcare Providers Exposed to Coronavirus Patients";
	TPHASE = "PHASE I TRIAL";
	TRT = "PrimePro";
	TTYPE = "EFFICACY";
	TTYPE2= "SAFETY";
	output;
run;


%* Convert Variables to Value-Level items;
data TS01 (keep = TSSEQ TSPARMCD TSVAL);
  length TSPARMCD TSVAL $200.;
  set TS00;
  
  %* Create array of all variables and output the variable name as;
  %* TSPARMCD and the variable value as TSVAL;
  array AllVars{*} _ALL_;
  do i = 1 to dim(AllVars);
    TSSEQ = 1;
    TSPARMCD = vname(AllVars{i});
    
    %* Account for Multiple Values per TSPARMCD;
    if input(substr(reverse(strip(TSPARMCD)), 1, 1), ??8.) ^= . then do;
      TSSEQ = input(substr(reverse(strip(TSPARMCD)), 1, 1), ??8.);
      TSPARMCD = substr(TSPARMCD, 1, length(strip(TSPARMCD))-1);
    end;
    
    TSVAL = AllVars{i};
    if TSVAL ^in ("TSPARMCD", "TSVAL") then output;
  end;
run;

proc sort data = TS01;
  by TSPARMCD TSSEQ;
run;

%*  Assign TSPARM from TSPARMCD.;
%*  Not needed for ctGovCheck, just included for completeness.;
proc format;
  value $TSPARM
	"ACTSUB" = "Actual Number of Subjects"
	"ADAPT" = "Adaptive Design"
	"ADDON" = "Added on to Existing Treatments"
	"AGEMAX" = "Planned Maximum Age of Subjects"	
	"AGEMIN" = "Planned Minimum Age of Subjects"
	"DCUTDESC" = "Data Cutoff Description"
	"DCUTDTC" =  "Data Cutoff Date"
	"EXTTIND" = "Extension Trial Indicator"
	"FCNTRY" = "Planned Country of Investigational Sites"
	"HLTSUBJI" = "Healthy Subject Indicator"
	"INDIC" = "Trial Disease/Condition Indication"
	"INTMODEL" = "Intervention Model"
	"INTTYPE" = "Intervention Type"
	"LENGTH" = "Trial Length"
	"NARMS" = "Planned Number of Arms"
	"NCOHORT" = "Number of Groups/Cohorts"
	"OBJPRIM" = "Trial Primary Objective"
	"OBJSEC" = "Trial Secondary Objective"
	"OUTMSPRI" = "Primary Outcome Measure"
	"PCLAS" = "Pharmacologic Class"
	"PLANSUB" = "Planned Number of Subjects"
	"RANDOM" = "Trial is Randomized"
	"RANDQT" = "Randomization Quotient"
	"REGID" = "Registry Identifier"
	"SDTIGVER" = "SDTM IG Version"
	"SDTMVER" = "SDTM Version"
	"SSTDTC" = "Study Start Date"
	"SENDTC" = "Study End Date"
	"SEXPOP" = "Sex of Participants"
	"SPONSOR" = "Clinical Study Sponsor"
	"STOPRULE" = "Study Stop Rules"
	"STYPE" = "Study Type"
	"TBLIND" = "Trial Blinding Schema"
	"TCNTRL" = "Control Type"
	"TDIGRP" = "Diagnosis Group"
	"TINDTP" = "Trial Intent Type"
	"TITLE" = "Trial Title"
	"TPHASE" = "Trial Phase Classification"
	"TRT" =  "Investigational Therapy or Treatment"
	"TTYPE" = "Trial Type"
  ;
run;

data &outLib..TS (label = "Trial Summary");
  label STUDYID = "Study Identifier"
  DOMAIN = "Domain Abbreviation"
  TSSEQ = "Sequence Number"
  TSGRPID = "Group ID"
  TSPARMCD = "Trial Summary Parameter Short Name"
  TSPARM = "Trial Summary Parameter"
  TSVAL = "Parameter Value"
  TSVALNF = "Parameter Null Flavor"
  TSVALCD = "Parameter Value Code"
  TSVCDREF = "Name of the Reference Terminology"
  TSVCDVER = "Version of the Reference Terminology"
  ;
  
  length TSVCDREF $20.;
  
  set TS01;
  TSPARM = put(TSPARMCD, $TSPARM.);
  STUDYID = "Pro00043080";
  DOMAIN = "TS";
  
  %* Set TSVCDREF with appropriate terminology;
  %* Again, not needed for ctGovCheck.sas but
     will be included for completeness;
  if TSPARMCD = "INDIC" then TSVCDREF = "SNOMED";
  if TSPARMCD = "TRT" then  TSVCDREF = "UNII";
  if TSPARMCD = "FCNTRY" then TSVCDREF = "ISO 3166";
  if TSPARMCD = "PCLAS" then TSVCDREF = "NDF-RT";
  if TSPARMCD = "TDIGRP" then TSVCDREF = "SNOMED";
  
  if TSVAL = '' then TSVALNF = "NA";
  
  %* Set additional variables to null/arbitrary values since they are not;
  %* needed for ctGovCheck.sas;
  TSGRPID = '';
  TSVALCD = '';
  if TSVCDREF ^= '' then TSVCDVER = '2020-01-01';
run;
  
%mend makeDummyTS;

%makeDummyTS(outLib = myData); /* Change the libref as appropriate */
