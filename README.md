# LazeeTK
 NexusTK Scripting Framework

<strong>Project is still in Alpha and many features are still broken or are undergoing testing</strong>

<strong>Usage:</strong>
   <ol>
     <li>update clients array with the username of your logged in character.</li>
     <li>subscribe to an event</li>   
   </ol>
   
   <span>
   subscription := new Subscription("My-Subscription-Name", BoundMethodOrFuncCall, 1, -1)<br />
   client.subscribeTo("EVENT-NAME", subscription)<br />
   <br />
   When the event is triggered, that event object is passed to the call back method or function.
   
   
   
   
