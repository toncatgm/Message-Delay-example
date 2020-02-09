# Message-Delay-example
 Interoperability example of delaying a message

## Disclaimer
Use or operation of this code is subject to acceptance of the license 
available in the code repository for this code. This code is provided for 
demonstration purposes only, is unsupported and should not be put directly 
into production. If you use any of this demonstration code, you need to modify, 
harden and thoroughly test it as your own solution.

## About   
Consists of code examples of a persistent delayed class, inbound adapter, 
request, business service and operation, a demo production, message router and 
associated routing rules and transformation to transform an ADT_A08 into the 
message delay request, and an example 
[ADT_A08](https://github.com/toncatgm/Message-Delay-example/tree/master/msg).

The code is supplied in 
[XML](https://github.com/toncatgm/Message-Delay-example/tree/master/src/xml) and 
[UDL](https://github.com/toncatgm/Message-Delay-example/tree/master/src/cls/Demo/MessageDelay) 
format.

## Basic instructions 
Once you have imported and compiled the classes, 
configure the HL7 File Operation to use an existing folder 
and optionally change the File Name setting to something more useable. 
Start the production and select the MsgRouter business process, 
then select the Actions tab and then click on the Test button 
to open the testing service dialog. 
Copy the contents of the example ADT_A08 into the “HL7 document content:” 
text area, scroll down and then click on the Invoke Testing Service button.

View the trace and query the Demo_MessageDelay.Delayed table to see the delayed 
record. Then select the Demo.MessageDelay.Service and change the Delay setting 
to 1 minute, wait a minute, the check the message trace from the business 
service to the business operation to see if the message was sent to the file 
operation. You should find that the delayed record has been deleted and the 
folder should contain the file with the ADT_A08 message in it.      
 
