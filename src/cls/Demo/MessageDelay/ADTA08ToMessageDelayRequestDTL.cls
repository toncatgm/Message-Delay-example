Class Demo.MessageDelay.ADTA08ToMessageDelayRequestDTL Extends Ens.DataTransformDTL [ DependsOn = (EnsLib.HL7.Message, Demo.MessageDelay.Request) ]
{

Parameter IGNOREMISSINGSOURCE = 1;

Parameter REPORTERRORS = 1;

Parameter TREATEMPTYREPEATINGFIELDASNULL = 0;

XData DTL [ XMLNamespace = "http://www.intersystems.com/dtl" ]
{
<transform sourceClass='EnsLib.HL7.Message' targetClass='Demo.MessageDelay.Request' sourceDocType='2.5:ADT_A01' create='new' language='objectscript' >
<assign value='source.%Id()' property='target.MessageId' action='set' />
<assign value='source.{PID:PatientID.IDNumber}' property='target.NHSNumber' action='set' />
<assign value='source.{PV1:PreadmitNumber}' property='target.AccountNumber' action='set' />
</transform>
}

}
