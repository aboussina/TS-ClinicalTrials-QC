%*=========================================================;
%* Title:  runCtGovCheck.sas                               ;
%*                                                         ;
%* Author:  Aaron Boussina, Hedral Inc.                    ;
%*                                                         ;
%* Purpose: Compare a clinical Study Trial Summary         ;
%*          SDTM dataset agaist the reported values in     ;
%*          ClinicalTrials.gov.                            ;
%*                                                         ;
%*          1.  Import STANAG1059.sas format for optional  ;
%*          testing of country codes.                      ;
%*                                                         ;
%*          2.  Run ctGovCheck to call the                 ;
%*          ClinicalTrials.gov API and compare the         ;
%*          response against the TS dataset.               ;
%*                                                         ;
%* Input:   SDTM.TS and ClinicalTrials.gov                 ;
%*          Optionally, the name of a STANAG 1059          ;
%*          SAS format to verify the countries of          ;
%*          investigational sites.                         ; 
%*                                                         ;
%*                                                         ;
%*                                                         ;
%* Revisions:                                              ;
%* AB 22OCT2020:  N/A, initial release.                    ;
%*=========================================================;


%INCLUDE "../Formats/STANAG1059.sas" "../Macros/ctGovCheck.sas";

libname Outputs "../Outputs"; /* Change the libref as appropriate */
libname SDTM "../SDTM"; /* Change the libref as appropriate */

%ctGovCheck(outLib = Outputs, srcLib = SDTM, stanagFormat=stanag); /* Change the librefs as appropriate */