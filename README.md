# Objective

The accuracy of the Trial Summary (TS) dataset is a key requirement for FDA technical conformance.  Often, however, verification of this trial information is done manually, creating the potential for inaccuracies.  The ctGovCheck SAS macro verifies the Registry ID (REGID) against ClinicalTrials.gov and cross checks the reported values against the TS dataset.  This ensures that the REGID is accurate and assists with identifying potential errors.

# ctGovCheck.sas

ctGovCheck.sas uses the ClinicalTrials.gov API (https://clinicaltrials.gov/api/gui) with the TS REGID in the query URL and parses the JSON response.  The following elements are extracted and processed to match CDISC controlled terminology:

ClinicalTrials.gov Term | CDISC TS Term
------------------------|--------------
EnrollmentCount | ACTSUB  (when EnrollmentType = "Actual")
MaximumAge | AGEMAX
MinimumAge | AGEMIN
LocationCountry | FCNTRY (Note: the country values in ClinicalTrials.gov appear to utilize the STANAG 1059 coding standard instead of ISO 3166 or GENC, so a SAS format needs to be used to convert the LocationCountry values to the ISO 3166 3 letter code)
HealthyVolunteers | HLTSUBJI
Condition | INDIC
DesignInterventionModel | INTMODEL
InterventionType | INTTYPE
DesignAllocation | RANDOM
Gender | SEXPOP
LeadSponsorName | SPONSOR
StudyType | STYPE
DesignPrimaryPurpose | TINDTP
OfficialTitle | TITLE
Phase1 | TPHASE
OrgStudyId | STUDYID
InterventionName | TRT

<br/>
The program then merges these elements with the TS dataset to create an output diagnostic file (in html and sas7bdat).
<br/>
<br/>
<html>
<head>
<meta name="Generator" content="SAS Software Version 9.4, see www.sas.com">
<meta http-equiv="Content-type" content="text/html; charset=utf-8">
<!--
.accessiblecaption
{
  background-color: #FAFBFE;
  color: #112277;
  font-family: Arial, 'Albany AMT', Helvetica, Helv;
  font-size: x-small;
  font-style: normal;
  font-weight: bold;
}
.activelink
{
  color: #800080;
}
.aftercaption
{
  background-color: #FAFBFE;
  border-spacing: 0px;
  color: #112277;
  font-family: Arial, 'Albany AMT', Helvetica, Helv;
  font-size: x-small;
  font-style: normal;
  font-weight: bold;
  padding-top: 4pt;
}
.batch
{
  background-color: #FAFBFE;
  border: 1px solid #C1C1C1;
  border-collapse: separate;
  border-spacing: 1px;
  color: #000000;
  font-family: 'SAS Monospace', 'Courier New', Courier, monospace;
  font-size: x-small;
  font-style: normal;
  font-weight: normal;
  padding: 7px;
}
.beforecaption
{
  background-color: #FAFBFE;
  border-spacing: 0px;
  color: #112277;
  font-family: Arial, 'Albany AMT', Helvetica, Helv;
  font-size: x-small;
  font-style: normal;
  font-weight: bold;
}
.body
{
  background-color: #FAFBFE;
  color: #000000;
  font-family: Arial, 'Albany AMT', Helvetica, Helv;
  font-size: x-small;
  font-style: normal;
  font-weight: normal;
  margin-left: 8px;
  margin-right: 8px;
}
.bodydate
{
  background-color: #FAFBFE;
  border-spacing: 0px;
  color: #000000;
  font-family: Arial, 'Albany AMT', Helvetica, Helv;
  font-size: x-small;
  font-style: normal;
  font-weight: normal;
  text-align: right;
  vertical-align: top;
  width: 100%;
}
.bycontentfolder
{
  color: #000000;
  font-family: Arial, 'Albany AMT', Helvetica, Helv;
  font-size: x-small;
  font-style: normal;
  font-weight: normal;
  list-style-type: none;
  margin-left: 6pt;
}
.byline
{
  background-color: #FAFBFE;
  border-spacing: 0px;
  color: #112277;
  font-family: Arial, 'Albany AMT', Helvetica, Helv;
  font-size: x-small;
  font-style: normal;
  font-weight: bold;
}
.bylinecontainer
{
  background-color: #FAFBFE;
  border: 0px solid #000000;
  border-spacing: 1px;
  color: #000000;
  font-family: Arial, 'Albany AMT', Helvetica, Helv;
  font-size: x-small;
  font-style: normal;
  font-weight: normal;
  width: 100%;
}
.caption
{
  background-color: #FAFBFE;
  border-spacing: 0px;
  color: #112277;
  font-family: Arial, 'Albany AMT', Helvetica, Helv;
  font-size: x-small;
  font-style: normal;
  font-weight: bold;
}
.cell
{
  background-color: #FAFBFE;
  color: #000000;
  font-family: Arial, 'Albany AMT', Helvetica, Helv;
  font-size: x-small;
  font-style: normal;
  font-weight: normal;
}
.container
{
  background-color: #FAFBFE;
  color: #000000;
  font-family: Arial, 'Albany AMT', Helvetica, Helv;
  font-size: x-small;
  font-style: normal;
  font-weight: normal;
}
.contentfolder
{
  color: #000000;
  font-family: Arial, 'Albany AMT', Helvetica, Helv;
  font-size: x-small;
  font-style: normal;
  font-weight: normal;
  list-style-type: none;
  margin-left: 6pt;
}
.contentitem
{
  color: #000000;
  font-family: Arial, 'Albany AMT', Helvetica, Helv;
  font-size: x-small;
  font-style: normal;
  font-weight: normal;
  list-style-type: none;
  margin-left: 6pt;
}
.contentproclabel
{
  background-color: #FAFBFE;
  color: #112277;
  font-family: Arial, 'Albany AMT', Helvetica, Helv;
  font-size: x-small;
  font-style: normal;
  font-weight: bold;
}
.contentprocname
{
  background-color: #FAFBFE;
  color: #112277;
  font-family: Arial, 'Albany AMT', Helvetica, Helv;
  font-size: x-small;
  font-style: normal;
  font-weight: bold;
}
.contents
{
  background-color: #FAFBFE;
  color: #000000;
  font-family: Arial, 'Albany AMT', Helvetica, Helv;
  font-size: x-small;
  font-style: normal;
  font-weight: normal;
  list-style-type: decimal;
  margin-left: 8px;
  margin-right: 8px;
}
.contentsdate
{
  background-color: #FAFBFE;
  color: #000000;
  font-family: Arial, 'Albany AMT', Helvetica, Helv;
  font-size: x-small;
  font-style: normal;
  font-weight: normal;
  width: 100%;
}
.contenttitle
{
  background-color: #FAFBFE;
  color: #112277;
  font-family: Arial, 'Albany AMT', Helvetica, Helv;
  font-size: x-small;
  font-style: italic;
  font-weight: bold;
}
.continued
{
  background-color: #FAFBFE;
  border-spacing: 0px;
  color: #112277;
  font-family: Arial, 'Albany AMT', Helvetica, Helv;
  font-size: x-small;
  font-style: normal;
  font-weight: bold;
  width: 100%;
}
.data
{
  background-color: #FFFFFF;
  border-bottom-width: 1px;
  border-color: #C1C1C1;
  border-left-width: 0px;
  border-right-width: 1px;
  border-style: solid;
  border-top-width: 0px;
  font-family: Arial, 'Albany AMT', Helvetica, Helv;
  font-size: x-small;
  font-style: normal;
  font-weight: normal;
}
.dataemphasis
{
  background-color: #FFFFFF;
  border-bottom-width: 1px;
  border-color: #C1C1C1;
  border-left-width: 0px;
  border-right-width: 1px;
  border-style: solid;
  border-top-width: 0px;
  font-family: Arial, 'Albany AMT', Helvetica, Helv;
  font-size: x-small;
  font-style: normal;
  font-weight: normal;
}
.dataemphasisfixed
{
  background-color: #FFFFFF;
  border-bottom-width: 1px;
  border-color: #C1C1C1;
  border-left-width: 0px;
  border-right-width: 1px;
  border-style: solid;
  border-top-width: 0px;
  font-family: 'Courier New', Courier, monospace;
  font-size: x-small;
  font-style: italic;
  font-weight: normal;
}
.dataempty
{
  background-color: #FFFFFF;
  border-bottom-width: 1px;
  border-color: #C1C1C1;
  border-left-width: 0px;
  border-right-width: 1px;
  border-style: solid;
  border-top-width: 0px;
  font-family: Arial, 'Albany AMT', Helvetica, Helv;
  font-size: x-small;
  font-style: normal;
  font-weight: normal;
}
.datafixed
{
  background-color: #FFFFFF;
  border-bottom-width: 1px;
  border-color: #C1C1C1;
  border-left-width: 0px;
  border-right-width: 1px;
  border-style: solid;
  border-top-width: 0px;
  font-family: 'Courier New', Courier;
  font-size: x-small;
  font-style: normal;
  font-weight: normal;
}
.datastrong
{
  background-color: #FFFFFF;
  border-bottom-width: 1px;
  border-color: #C1C1C1;
  border-left-width: 0px;
  border-right-width: 1px;
  border-style: solid;
  border-top-width: 0px;
  color: #000000;
  font-family: Arial, 'Albany AMT', Helvetica, Helv;
  font-size: x-small;
  font-style: normal;
  font-weight: bold;
}
.datastrongfixed
{
  background-color: #FFFFFF;
  border-bottom-width: 1px;
  border-color: #C1C1C1;
  border-left-width: 0px;
  border-right-width: 1px;
  border-style: solid;
  border-top-width: 0px;
  color: #000000;
  font-family: 'Courier New', Courier, monospace;
  font-size: x-small;
  font-style: normal;
  font-weight: bold;
}
.date
{
  background-color: #FAFBFE;
  color: #000000;
  font-family: Arial, 'Albany AMT', Helvetica, Helv;
  font-size: x-small;
  font-style: normal;
  font-weight: normal;
  width: 100%;
}
.document
{
  background-color: #FAFBFE;
  color: #000000;
  font-family: Arial, 'Albany AMT', Helvetica, Helv;
  font-size: x-small;
  font-style: normal;
  font-weight: normal;
}
a:link {
color:#0000FF
}
a:visited {
color:#800080
}
a:active {
color:#800080
}
.errorbanner
{
  background-color: #FAFBFE;
  color: #112277;
  font-family: Arial, 'Albany AMT', Helvetica, Helv;
  font-size: x-small;
  font-style: normal;
  font-weight: bold;
}
.errorcontent
{
  background-color: #FAFBFE;
  color: #112277;
  font-family: Arial, 'Albany AMT', Helvetica, Helv;
  font-size: x-small;
  font-style: normal;
  font-weight: normal;
}
.errorcontentfixed
{
  background-color: #FAFBFE;
  color: #112277;
  font-family: 'Courier New', Courier;
  font-size: x-small;
  font-style: normal;
  font-weight: normal;
}
.extendedpage
{
  background-color: #FAFBFE;
  border: 1pt solid #000000;
  color: #112277;
  font-family: Arial, 'Albany AMT', Helvetica, Helv;
  font-size: x-small;
  font-style: italic;
  font-weight: normal;
  text-align: center;
}
.fatalbanner
{
  background-color: #FAFBFE;
  color: #112277;
  font-family: Arial, 'Albany AMT', Helvetica, Helv;
  font-size: x-small;
  font-style: normal;
  font-weight: bold;
}
.fatalcontent
{
  background-color: #FAFBFE;
  color: #112277;
  font-family: Arial, 'Albany AMT', Helvetica, Helv;
  font-size: x-small;
  font-style: normal;
  font-weight: normal;
}
.fatalcontentfixed
{
  background-color: #FAFBFE;
  color: #112277;
  font-family: 'Courier New', Courier;
  font-size: x-small;
  font-style: normal;
  font-weight: normal;
}
.folderaction
{
  color: #000000;
  font-family: Arial, 'Albany AMT', Helvetica, Helv;
  font-size: x-small;
  font-style: normal;
  font-weight: normal;
  list-style-type: none;
  margin-left: 6pt;
}
.footer
{
  background-color: #EDF2F9;
  border-bottom-width: 1px;
  border-color: #B0B7BB;
  border-left-width: 0px;
  border-right-width: 1px;
  border-style: solid;
  border-top-width: 0px;
  color: #112277;
  font-family: Arial, 'Albany AMT', Helvetica, Helv;
  font-size: x-small;
  font-style: normal;
  font-weight: bold;
}
.footeremphasis
{
  background-color: #EDF2F9;
  border-bottom-width: 1px;
  border-color: #B0B7BB;
  border-left-width: 0px;
  border-right-width: 1px;
  border-style: solid;
  border-top-width: 0px;
  color: #112277;
  font-family: Arial, 'Albany AMT', Helvetica, Helv;
  font-size: x-small;
  font-style: italic;
  font-weight: normal;
}
.footeremphasisfixed
{
  background-color: #EDF2F9;
  border-bottom-width: 1px;
  border-color: #B0B7BB;
  border-left-width: 0px;
  border-right-width: 1px;
  border-style: solid;
  border-top-width: 0px;
  color: #112277;
  font-family: 'Courier New', Courier, monospace;
  font-size: x-small;
  font-style: italic;
  font-weight: normal;
}
.footerempty
{
  background-color: #EDF2F9;
  border-bottom-width: 1px;
  border-color: #B0B7BB;
  border-left-width: 0px;
  border-right-width: 1px;
  border-style: solid;
  border-top-width: 0px;
  color: #112277;
  font-family: Arial, 'Albany AMT', Helvetica, Helv;
  font-size: x-small;
  font-style: normal;
  font-weight: bold;
}
.footerfixed
{
  background-color: #EDF2F9;
  border-bottom-width: 1px;
  border-color: #B0B7BB;
  border-left-width: 0px;
  border-right-width: 1px;
  border-style: solid;
  border-top-width: 0px;
  color: #112277;
  font-family: 'Courier New', Courier;
  font-size: x-small;
  font-style: normal;
  font-weight: normal;
}
.footerstrong
{
  background-color: #EDF2F9;
  border-bottom-width: 1px;
  border-color: #B0B7BB;
  border-left-width: 0px;
  border-right-width: 1px;
  border-style: solid;
  border-top-width: 0px;
  color: #112277;
  font-family: Arial, 'Albany AMT', Helvetica, Helv;
  font-size: x-small;
  font-style: normal;
  font-weight: bold;
}
.footerstrongfixed
{
  background-color: #EDF2F9;
  border-bottom-width: 1px;
  border-color: #B0B7BB;
  border-left-width: 0px;
  border-right-width: 1px;
  border-style: solid;
  border-top-width: 0px;
  color: #112277;
  font-family: 'Courier New', Courier, monospace;
  font-size: x-small;
  font-style: normal;
  font-weight: bold;
}
.frame
{
  background-color: #FAFBFE;
  color: #000000;
  font-family: Arial, 'Albany AMT', Helvetica, Helv;
  font-size: x-small;
  font-style: normal;
  font-weight: normal;
}
.graph
{
  background-color: #FAFBFE;
  border: 1px solid #C1C1C1;
  border-collapse: separate;
  border-spacing: 1px;
  color: #000000;
  font-family: Arial, 'Albany AMT', Helvetica, Helv;
  font-size: x-small;
  font-style: normal;
  font-weight: normal;
}
.header
{
  background-color: #EDF2F9;
  border-bottom-width: 1px;
  border-color: #B0B7BB;
  border-left-width: 0px;
  border-right-width: 1px;
  border-style: solid;
  border-top-width: 0px;
  color: #112277;
  font-family: Arial, 'Albany AMT', Helvetica, Helv;
  font-size: x-small;
  font-style: normal;
  font-weight: bold;
}
.headeremphasis
{
  background-color: #D8DBD3;
  border-bottom-width: 1px;
  border-color: #B0B7BB;
  border-left-width: 0px;
  border-right-width: 1px;
  border-style: solid;
  border-top-width: 0px;
  color: #000000;
  font-family: Arial, 'Albany AMT', Helvetica, Helv;
  font-size: x-small;
  font-style: italic;
  font-weight: normal;
}
.headeremphasisfixed
{
  background-color: #D8DBD3;
  border-bottom-width: 1px;
  border-color: #B0B7BB;
  border-left-width: 0px;
  border-right-width: 1px;
  border-style: solid;
  border-top-width: 0px;
  color: #000000;
  font-family: 'Courier New', Courier, monospace;
  font-size: x-small;
  font-style: italic;
  font-weight: normal;
}
.headerempty
{
  background-color: #EDF2F9;
  border-bottom-width: 1px;
  border-color: #B0B7BB;
  border-left-width: 0px;
  border-right-width: 1px;
  border-style: solid;
  border-top-width: 0px;
  color: #112277;
  font-family: Arial, 'Albany AMT', Helvetica, Helv;
  font-size: x-small;
  font-style: normal;
  font-weight: bold;
}
.headerfixed
{
  background-color: #EDF2F9;
  border-bottom-width: 1px;
  border-color: #B0B7BB;
  border-left-width: 0px;
  border-right-width: 1px;
  border-style: solid;
  border-top-width: 0px;
  color: #112277;
  font-family: 'Courier New', Courier;
  font-size: x-small;
  font-style: normal;
  font-weight: normal;
}
.headersandfooters
{
  background-color: #EDF2F9;
  color: #000000;
  font-family: Arial, 'Albany AMT', Helvetica, Helv;
  font-size: x-small;
  font-style: normal;
  font-weight: bold;
}
.headerstrong
{
  background-color: #D8DBD3;
  border-bottom-width: 1px;
  border-color: #B0B7BB;
  border-left-width: 0px;
  border-right-width: 1px;
  border-style: solid;
  border-top-width: 0px;
  color: #000000;
  font-family: Arial, 'Albany AMT', Helvetica, Helv;
  font-size: x-small;
  font-style: normal;
  font-weight: bold;
}
.headerstrongfixed
{
  background-color: #D8DBD3;
  border-bottom-width: 1px;
  border-color: #B0B7BB;
  border-left-width: 0px;
  border-right-width: 1px;
  border-style: solid;
  border-top-width: 0px;
  color: #000000;
  font-family: 'Courier New', Courier, monospace;
  font-size: x-small;
  font-style: normal;
  font-weight: bold;
}
.heading1
{
  font-family: Arial, Helvetica, sans-serif;
}
.heading2
{
  font-family: Arial, Helvetica, sans-serif;
}
.heading3
{
  font-family: Arial, Helvetica, sans-serif;
}
.heading4
{
  font-family: Arial, Helvetica, sans-serif;
}
.heading5
{
  font-family: Arial, Helvetica, sans-serif;
}
.heading6
{
  font-family: Arial, Helvetica, sans-serif;
}
.index
{
  background-color: #FAFBFE;
  color: #000000;
  font-family: Arial, 'Albany AMT', Helvetica, Helv;
  font-size: x-small;
  font-style: normal;
  font-weight: normal;
}
.indexaction
{
  color: #000000;
  font-family: Arial, 'Albany AMT', Helvetica, Helv;
  font-size: x-small;
  font-style: normal;
  font-weight: normal;
  list-style-type: none;
  margin-left: 6pt;
}
.indexitem
{
  color: #000000;
  font-family: Arial, 'Albany AMT', Helvetica, Helv;
  font-size: x-small;
  font-style: normal;
  font-weight: normal;
  list-style-type: none;
  margin-left: 6pt;
}
.indexprocname
{
  background-color: #FAFBFE;
  color: #112277;
  font-family: Arial, 'Albany AMT', Helvetica, Helv;
  font-size: x-small;
  font-style: normal;
  font-weight: bold;
}
.indextitle
{
  background-color: #FAFBFE;
  color: #112277;
  font-family: Arial, 'Albany AMT', Helvetica, Helv;
  font-size: x-small;
  font-style: italic;
  font-weight: bold;
}
.layoutcontainer
{
  border: 0px solid #000000;
  border-spacing: 30px;
}
.layoutregion
{
  border: 0px solid #000000;
  border-spacing: 30px;
}
.linecontent
{
  background-color: #FAFBFE;
  border-bottom-width: 1px;
  border-color: #C1C1C1;
  border-left-width: 0px;
  border-right-width: 1px;
  border-style: solid;
  border-top-width: 0px;
  color: #112277;
  font-family: Arial, 'Albany AMT', Helvetica, Helv;
  font-size: x-small;
  font-style: normal;
  font-weight: normal;
}
.link
{
  color: #0000FF;
}
.list
{
  background-color: #FAFBFE;
  color: #000000;
  font-family: Arial, 'Albany AMT', Helvetica, Helv;
  font-size: x-small;
  font-style: normal;
  font-weight: normal;
  list-style-type: disc;
}
.list10
{
  background-color: #FAFBFE;
  color: #000000;
  font-family: Arial, 'Albany AMT', Helvetica, Helv;
  font-size: x-small;
  font-style: normal;
  font-weight: normal;
  list-style-type: square;
}
.list2
{
  background-color: #FAFBFE;
  color: #000000;
  font-family: Arial, 'Albany AMT', Helvetica, Helv;
  font-size: x-small;
  font-style: normal;
  font-weight: normal;
  list-style-type: circle;
}
.list3
{
  background-color: #FAFBFE;
  color: #000000;
  font-family: Arial, 'Albany AMT', Helvetica, Helv;
  font-size: x-small;
  font-style: normal;
  font-weight: normal;
  list-style-type: square;
}
.list4
{
  background-color: #FAFBFE;
  color: #000000;
  font-family: Arial, 'Albany AMT', Helvetica, Helv;
  font-size: x-small;
  font-style: normal;
  font-weight: normal;
  list-style-type: square;
}
.list5
{
  background-color: #FAFBFE;
  color: #000000;
  font-family: Arial, 'Albany AMT', Helvetica, Helv;
  font-size: x-small;
  font-style: normal;
  font-weight: normal;
  list-style-type: square;
}
.list6
{
  background-color: #FAFBFE;
  color: #000000;
  font-family: Arial, 'Albany AMT', Helvetica, Helv;
  font-size: x-small;
  font-style: normal;
  font-weight: normal;
  list-style-type: square;
}
.list7
{
  background-color: #FAFBFE;
  color: #000000;
  font-family: Arial, 'Albany AMT', Helvetica, Helv;
  font-size: x-small;
  font-style: normal;
  font-weight: normal;
  list-style-type: square;
}
.list8
{
  background-color: #FAFBFE;
  color: #000000;
  font-family: Arial, 'Albany AMT', Helvetica, Helv;
  font-size: x-small;
  font-style: normal;
  font-weight: normal;
  list-style-type: square;
}
.list9
{
  background-color: #FAFBFE;
  color: #000000;
  font-family: Arial, 'Albany AMT', Helvetica, Helv;
  font-size: x-small;
  font-style: normal;
  font-weight: normal;
  list-style-type: square;
}
.listitem
{
  background-color: #FAFBFE;
  color: #000000;
  font-family: Arial, 'Albany AMT', Helvetica, Helv;
  font-size: x-small;
  font-style: normal;
  font-weight: normal;
  list-style-type: disc;
}
.listitem10
{
  background-color: #FAFBFE;
  color: #000000;
  font-family: Arial, 'Albany AMT', Helvetica, Helv;
  font-size: x-small;
  font-style: normal;
  font-weight: normal;
  list-style-type: square;
}
.listitem2
{
  background-color: #FAFBFE;
  color: #000000;
  font-family: Arial, 'Albany AMT', Helvetica, Helv;
  font-size: x-small;
  font-style: normal;
  font-weight: normal;
  list-style-type: circle;
}
.listitem3
{
  background-color: #FAFBFE;
  color: #000000;
  font-family: Arial, 'Albany AMT', Helvetica, Helv;
  font-size: x-small;
  font-style: normal;
  font-weight: normal;
  list-style-type: square;
}
.listitem4
{
  background-color: #FAFBFE;
  color: #000000;
  font-family: Arial, 'Albany AMT', Helvetica, Helv;
  font-size: x-small;
  font-style: normal;
  font-weight: normal;
  list-style-type: square;
}
.listitem5
{
  background-color: #FAFBFE;
  color: #000000;
  font-family: Arial, 'Albany AMT', Helvetica, Helv;
  font-size: x-small;
  font-style: normal;
  font-weight: normal;
  list-style-type: square;
}
.listitem6
{
  background-color: #FAFBFE;
  color: #000000;
  font-family: Arial, 'Albany AMT', Helvetica, Helv;
  font-size: x-small;
  font-style: normal;
  font-weight: normal;
  list-style-type: square;
}
.listitem7
{
  background-color: #FAFBFE;
  color: #000000;
  font-family: Arial, 'Albany AMT', Helvetica, Helv;
  font-size: x-small;
  font-style: normal;
  font-weight: normal;
  list-style-type: square;
}
.listitem8
{
  background-color: #FAFBFE;
  color: #000000;
  font-family: Arial, 'Albany AMT', Helvetica, Helv;
  font-size: x-small;
  font-style: normal;
  font-weight: normal;
  list-style-type: square;
}
.listitem9
{
  background-color: #FAFBFE;
  color: #000000;
  font-family: Arial, 'Albany AMT', Helvetica, Helv;
  font-size: x-small;
  font-style: normal;
  font-weight: normal;
  list-style-type: square;
}
.note
{
  background-color: #FAFBFE;
  color: #112277;
  font-family: Arial, 'Albany AMT', Helvetica, Helv;
  font-size: x-small;
  font-style: normal;
  font-weight: normal;
}
.notebanner
{
  background-color: #FAFBFE;
  color: #112277;
  font-family: Arial, 'Albany AMT', Helvetica, Helv;
  font-size: x-small;
  font-style: normal;
  font-weight: bold;
}
.notecontent
{
  background-color: #FAFBFE;
  color: #112277;
  font-family: Arial, 'Albany AMT', Helvetica, Helv;
  font-size: x-small;
  font-style: normal;
  font-weight: normal;
}
.notecontentfixed
{
  background-color: #FAFBFE;
  color: #112277;
  font-family: 'Courier New', Courier;
  font-size: x-small;
  font-style: normal;
  font-weight: normal;
}
.output
{
  background-color: #FAFBFE;
  border: 1px solid #C1C1C1;
  border-collapse: separate;
  border-spacing: 1px;
  color: #000000;
  font-family: Arial, 'Albany AMT', Helvetica, Helv;
  font-size: x-small;
  font-style: normal;
  font-weight: normal;
}
.pageno
{
  background-color: #FAFBFE;
  border-spacing: 0px;
  color: #112277;
  font-family: Arial, 'Albany AMT', Helvetica, Helv;
  font-size: x-small;
  font-style: normal;
  font-weight: bold;
  text-align: right;
  vertical-align: top;
}
.pages
{
  background-color: #FAFBFE;
  color: #000000;
  font-family: Arial, 'Albany AMT', Helvetica, Helv;
  font-size: x-small;
  font-style: normal;
  font-weight: normal;
  list-style-type: decimal;
  margin-left: 8px;
  margin-right: 8px;
}
.pagesdate
{
  background-color: #FAFBFE;
  color: #000000;
  font-family: Arial, 'Albany AMT', Helvetica, Helv;
  font-size: x-small;
  font-style: normal;
  font-weight: normal;
  width: 100%;
}
.pagesitem
{
  color: #000000;
  font-family: Arial, 'Albany AMT', Helvetica, Helv;
  font-size: x-small;
  font-style: normal;
  font-weight: normal;
  list-style-type: none;
  margin-left: 6pt;
}
.pagesproclabel
{
  background-color: #FAFBFE;
  color: #112277;
  font-family: Arial, 'Albany AMT', Helvetica, Helv;
  font-size: x-small;
  font-style: normal;
  font-weight: bold;
}
.pagesprocname
{
  background-color: #FAFBFE;
  color: #112277;
  font-family: Arial, 'Albany AMT', Helvetica, Helv;
  font-size: x-small;
  font-style: normal;
  font-weight: bold;
}
.pagestitle
{
  background-color: #FAFBFE;
  color: #112277;
  font-family: Arial, 'Albany AMT', Helvetica, Helv;
  font-size: x-small;
  font-style: italic;
  font-weight: bold;
}
.paragraph
{
  background-color: #FAFBFE;
  color: #000000;
  font-family: Arial, 'Albany AMT', Helvetica, Helv;
  font-size: x-small;
  font-style: normal;
  font-weight: normal;
}
.parskip
{
  border: 0px solid #000000;
  border-spacing: 0px;
  font-family: Arial, 'Albany AMT', Helvetica, Helv;
  font-size: x-small;
  font-style: normal;
  font-weight: bold;
}
.prepage
{
  background-color: #FAFBFE;
  color: #112277;
  font-family: Arial, 'Albany AMT', Helvetica, Helv;
  font-size: x-small;
  font-style: normal;
  font-weight: normal;
  text-align: left;
}
.proctitle
{
  background-color: #FAFBFE;
  color: #112277;
  font-family: Arial, 'Albany AMT', Helvetica, Helv;
  font-size: x-small;
  font-style: normal;
  font-weight: bold;
}
.proctitlefixed
{
  background-color: #FAFBFE;
  color: #112277;
  font-family: 'Courier New', Courier, monospace;
  font-size: x-small;
  font-style: normal;
  font-weight: bold;
}
.rowfooter
{
  background-color: #EDF2F9;
  border-bottom-width: 1px;
  border-color: #B0B7BB;
  border-left-width: 0px;
  border-right-width: 1px;
  border-style: solid;
  border-top-width: 0px;
  color: #112277;
  font-family: Arial, 'Albany AMT', Helvetica, Helv;
  font-size: x-small;
  font-style: normal;
  font-weight: bold;
}
.rowfooteremphasis
{
  background-color: #EDF2F9;
  border-bottom-width: 1px;
  border-color: #B0B7BB;
  border-left-width: 0px;
  border-right-width: 1px;
  border-style: solid;
  border-top-width: 0px;
  color: #112277;
  font-family: Arial, 'Albany AMT', Helvetica, Helv;
  font-size: x-small;
  font-style: italic;
  font-weight: normal;
}
.rowfooteremphasisfixed
{
  background-color: #EDF2F9;
  border-bottom-width: 1px;
  border-color: #B0B7BB;
  border-left-width: 0px;
  border-right-width: 1px;
  border-style: solid;
  border-top-width: 0px;
  color: #112277;
  font-family: 'Courier New', Courier, monospace;
  font-size: x-small;
  font-style: italic;
  font-weight: normal;
}
.rowfooterempty
{
  background-color: #EDF2F9;
  border-bottom-width: 1px;
  border-color: #B0B7BB;
  border-left-width: 0px;
  border-right-width: 1px;
  border-style: solid;
  border-top-width: 0px;
  color: #112277;
  font-family: Arial, 'Albany AMT', Helvetica, Helv;
  font-size: x-small;
  font-style: normal;
  font-weight: bold;
}
.rowfooterfixed
{
  background-color: #EDF2F9;
  border-bottom-width: 1px;
  border-color: #B0B7BB;
  border-left-width: 0px;
  border-right-width: 1px;
  border-style: solid;
  border-top-width: 0px;
  color: #112277;
  font-family: 'Courier New', Courier;
  font-size: x-small;
  font-style: normal;
  font-weight: normal;
}
.rowfooterstrong
{
  background-color: #EDF2F9;
  border-bottom-width: 1px;
  border-color: #B0B7BB;
  border-left-width: 0px;
  border-right-width: 1px;
  border-style: solid;
  border-top-width: 0px;
  color: #112277;
  font-family: Arial, 'Albany AMT', Helvetica, Helv;
  font-size: x-small;
  font-style: normal;
  font-weight: bold;
}
.rowfooterstrongfixed
{
  background-color: #EDF2F9;
  border-bottom-width: 1px;
  border-color: #B0B7BB;
  border-left-width: 0px;
  border-right-width: 1px;
  border-style: solid;
  border-top-width: 0px;
  color: #112277;
  font-family: 'Courier New', Courier, monospace;
  font-size: x-small;
  font-style: normal;
  font-weight: bold;
}
.rowheader
{
  background-color: #EDF2F9;
  border-bottom-width: 1px;
  border-color: #B0B7BB;
  border-left-width: 0px;
  border-right-width: 1px;
  border-style: solid;
  border-top-width: 0px;
  color: #112277;
  font-family: Arial, 'Albany AMT', Helvetica, Helv;
  font-size: x-small;
  font-style: normal;
  font-weight: bold;
}
.rowheaderemphasis
{
  background-color: #EDF2F9;
  border-bottom-width: 1px;
  border-color: #B0B7BB;
  border-left-width: 0px;
  border-right-width: 1px;
  border-style: solid;
  border-top-width: 0px;
  color: #112277;
  font-family: Arial, 'Albany AMT', Helvetica, Helv;
  font-size: x-small;
  font-style: italic;
  font-weight: normal;
}
.rowheaderemphasisfixed
{
  background-color: #EDF2F9;
  border-bottom-width: 1px;
  border-color: #B0B7BB;
  border-left-width: 0px;
  border-right-width: 1px;
  border-style: solid;
  border-top-width: 0px;
  color: #112277;
  font-family: 'Courier New', Courier, monospace;
  font-size: x-small;
  font-style: italic;
  font-weight: normal;
}
.rowheaderempty
{
  background-color: #EDF2F9;
  border-bottom-width: 1px;
  border-color: #B0B7BB;
  border-left-width: 0px;
  border-right-width: 1px;
  border-style: solid;
  border-top-width: 0px;
  color: #112277;
  font-family: Arial, 'Albany AMT', Helvetica, Helv;
  font-size: x-small;
  font-style: normal;
  font-weight: bold;
}
.rowheaderfixed
{
  background-color: #EDF2F9;
  border-bottom-width: 1px;
  border-color: #B0B7BB;
  border-left-width: 0px;
  border-right-width: 1px;
  border-style: solid;
  border-top-width: 0px;
  color: #112277;
  font-family: 'Courier New', Courier;
  font-size: x-small;
  font-style: normal;
  font-weight: normal;
}
.rowheaderstrong
{
  background-color: #EDF2F9;
  border-bottom-width: 1px;
  border-color: #B0B7BB;
  border-left-width: 0px;
  border-right-width: 1px;
  border-style: solid;
  border-top-width: 0px;
  color: #112277;
  font-family: Arial, 'Albany AMT', Helvetica, Helv;
  font-size: x-small;
  font-style: normal;
  font-weight: bold;
}
.rowheaderstrongfixed
{
  background-color: #EDF2F9;
  border-bottom-width: 1px;
  border-color: #B0B7BB;
  border-left-width: 0px;
  border-right-width: 1px;
  border-style: solid;
  border-top-width: 0px;
  color: #112277;
  font-family: 'Courier New', Courier, monospace;
  font-size: x-small;
  font-style: normal;
  font-weight: bold;
}
.systemfooter
{
  background-color: #FAFBFE;
  color: #112277;
  font-family: Arial, 'Albany AMT', Helvetica, Helv;
  font-size: x-small;
  font-style: normal;
  font-weight: normal;
}
.systemfooter10
{
  background-color: #FAFBFE;
  color: #112277;
  font-family: Arial, 'Albany AMT', Helvetica, Helv;
  font-size: x-small;
  font-style: normal;
  font-weight: normal;
}
.systemfooter2
{
  background-color: #FAFBFE;
  color: #112277;
  font-family: Arial, 'Albany AMT', Helvetica, Helv;
  font-size: x-small;
  font-style: normal;
  font-weight: normal;
}
.systemfooter3
{
  background-color: #FAFBFE;
  color: #112277;
  font-family: Arial, 'Albany AMT', Helvetica, Helv;
  font-size: x-small;
  font-style: normal;
  font-weight: normal;
}
.systemfooter4
{
  background-color: #FAFBFE;
  color: #112277;
  font-family: Arial, 'Albany AMT', Helvetica, Helv;
  font-size: x-small;
  font-style: normal;
  font-weight: normal;
}
.systemfooter5
{
  background-color: #FAFBFE;
  color: #112277;
  font-family: Arial, 'Albany AMT', Helvetica, Helv;
  font-size: x-small;
  font-style: normal;
  font-weight: normal;
}
.systemfooter6
{
  background-color: #FAFBFE;
  color: #112277;
  font-family: Arial, 'Albany AMT', Helvetica, Helv;
  font-size: x-small;
  font-style: normal;
  font-weight: normal;
}
.systemfooter7
{
  background-color: #FAFBFE;
  color: #112277;
  font-family: Arial, 'Albany AMT', Helvetica, Helv;
  font-size: x-small;
  font-style: normal;
  font-weight: normal;
}
.systemfooter8
{
  background-color: #FAFBFE;
  color: #112277;
  font-family: Arial, 'Albany AMT', Helvetica, Helv;
  font-size: x-small;
  font-style: normal;
  font-weight: normal;
}
.systemfooter9
{
  background-color: #FAFBFE;
  color: #112277;
  font-family: Arial, 'Albany AMT', Helvetica, Helv;
  font-size: x-small;
  font-style: normal;
  font-weight: normal;
}
.systemtitle
{
  background-color: #FAFBFE;
  color: #112277;
  font-family: Arial, 'Albany AMT', Helvetica, Helv;
  font-size: small;
  font-style: normal;
  font-weight: bold;
}
.systemtitle10
{
  background-color: #FAFBFE;
  color: #112277;
  font-family: Arial, 'Albany AMT', Helvetica, Helv;
  font-size: small;
  font-style: normal;
  font-weight: bold;
}
.systemtitle2
{
  background-color: #FAFBFE;
  color: #112277;
  font-family: Arial, 'Albany AMT', Helvetica, Helv;
  font-size: small;
  font-style: normal;
  font-weight: bold;
}
.systemtitle3
{
  background-color: #FAFBFE;
  color: #112277;
  font-family: Arial, 'Albany AMT', Helvetica, Helv;
  font-size: small;
  font-style: normal;
  font-weight: bold;
}
.systemtitle4
{
  background-color: #FAFBFE;
  color: #112277;
  font-family: Arial, 'Albany AMT', Helvetica, Helv;
  font-size: small;
  font-style: normal;
  font-weight: bold;
}
.systemtitle5
{
  background-color: #FAFBFE;
  color: #112277;
  font-family: Arial, 'Albany AMT', Helvetica, Helv;
  font-size: small;
  font-style: normal;
  font-weight: bold;
}
.systemtitle6
{
  background-color: #FAFBFE;
  color: #112277;
  font-family: Arial, 'Albany AMT', Helvetica, Helv;
  font-size: small;
  font-style: normal;
  font-weight: bold;
}
.systemtitle7
{
  background-color: #FAFBFE;
  color: #112277;
  font-family: Arial, 'Albany AMT', Helvetica, Helv;
  font-size: small;
  font-style: normal;
  font-weight: bold;
}
.systemtitle8
{
  background-color: #FAFBFE;
  color: #112277;
  font-family: Arial, 'Albany AMT', Helvetica, Helv;
  font-size: small;
  font-style: normal;
  font-weight: bold;
}
.systemtitle9
{
  background-color: #FAFBFE;
  color: #112277;
  font-family: Arial, 'Albany AMT', Helvetica, Helv;
  font-size: small;
  font-style: normal;
  font-weight: bold;
}
.systitleandfootercontainer
{
  background-color: #FAFBFE;
  border: 0px solid #000000;
  border-spacing: 1px;
  color: #000000;
  font-family: Arial, 'Albany AMT', Helvetica, Helv;
  font-size: x-small;
  font-style: normal;
  font-weight: normal;
  width: 100%;
}
.table
{
  border-bottom-width: 0px;
  border-collapse: collapse;
  border-color: #C1C1C1;
  border-left-width: 1px;
  border-right-width: 0px;
  border-spacing: 0px;
  border-style: solid;
  border-top-width: 1px;
}
.top_stacked_value
{
  padding-bottom: 1px;
  border: 0;
}
.middle_stacked_value
{
  padding-top: 1px;
  padding-bottom: 1px;
  border: 0;
}
.bottom_stacked_value
{
  padding-top: 1px;
  border: 0;
}
.titleandnotecontainer
{
  background-color: #FAFBFE;
  border: 0px solid #000000;
  border-spacing: 1px;
  color: #000000;
  font-family: Arial, 'Albany AMT', Helvetica, Helv;
  font-size: x-small;
  font-style: normal;
  font-weight: normal;
  width: 100%;
}
.titlesandfooters
{
  background-color: #FAFBFE;
  color: #112277;
  font-family: Arial, 'Albany AMT', Helvetica, Helv;
  font-size: x-small;
  font-style: normal;
  font-weight: bold;
}
.usertext
{
  background-color: #FAFBFE;
  color: #112277;
  font-family: Arial, 'Albany AMT', Helvetica, Helv;
  font-size: x-small;
  font-style: normal;
  font-weight: normal;
}
.visitedlink
{
  color: #800080;
}
.warnbanner
{
  background-color: #FAFBFE;
  color: #112277;
  font-family: Arial, 'Albany AMT', Helvetica, Helv;
  font-size: x-small;
  font-style: normal;
  font-weight: bold;
}
.warncontent
{
  background-color: #FAFBFE;
  color: #112277;
  font-family: Arial, 'Albany AMT', Helvetica, Helv;
  font-size: x-small;
  font-style: normal;
  font-weight: normal;
}
.warncontentfixed
{
  background-color: #FAFBFE;
  color: #112277;
  font-family: 'Courier New', Courier;
  font-size: x-small;
  font-style: normal;
  font-weight: normal;
}
.l {text-align: left }
.c {text-align: center }
.r {text-align: right }
.d {text-align: right }
.j {text-align: justify }
.t {vertical-align: top }
.m {vertical-align: middle }
.b {vertical-align: bottom }
TD, TH {vertical-align: top }
.stacked_cell{padding: 0 }
-->



<div class="branch">
<a name="IDX"></a>
<div>
<div align="center">
<table class="table" cellspacing="0" cellpadding="5" rules="all" frame="box" bordercolor="#C1C1C1" summary="Procedure Print: Data Set MYDATA.CTGOVMISMATCH">
<colgroup>
<col>
</colgroup>
<colgroup>
<col>
<col>
<col>
</colgroup>
<thead>
<tr>
<th class="r header" scope="col">Obs</th>
<th class="l header" scope="col">Trial Summary<br/>Parameter Short<br/>Name</th>
<th class="l header" scope="col">TS Parameter Value</th>
<th class="l header" scope="col">ClinicalTrials.gov Parameter Value</th>
</tr>
</thead>
<tbody>
<tr>
<th class="r rowheader" scope="row">1</th>
<td class="l data">INTTYPE</td>
<td class="l data">BIOLOGIC</td>
<td class="l data">BIOLOGIC,OTHER</td>
</tr>
<tr>
<th class="r rowheader" scope="row">2</th>
<td class="l data">TITLE</td>
<td class="l data">A Pilot Phase Study Evaluating the Effects of a Single Mesenchymal Stem Cell Injection in Patients With Suspected or Confirmed COVID-19 Infection and Healthcare Providers Exposed to Coronavirus Patien</td>
<td class="l data">A Pilot Phase Study Evaluating the Effects of a Single Mesenchymal Stem Cell Injection in Patients With Suspected or Confirmed COVID-19 Infection and Healthcare Providers Exposed to Coronavirus Patients</td>
</tr>
</tbody>
</table>
</div>
</div>
<br>
</div>
</body>
</html>


# Usage

The ctGovCheck macro can be called with arguments for the Libref of the source TS, the Libref for the outputs, and the name of a STANAG format.  See the runCtGovCheck.sas program for an example.  Included in this repo is a STANAG 1059 SAS format (STANAG1059.sas) and a synthetic TS dataset that can be used.  Also included is the program used to generate this synthetic TS which can be modified for testing.

To run, clone this repo and run runCtGovCheck.sas with batch submit or in SAS interactive.  The synthetic TS in the SDTM folder can be replaced with real trial data for production use. 
