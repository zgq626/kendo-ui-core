<%@taglib prefix="kendo" uri="http://www.kendoui.com/jsp/tags"%>
<%@taglib prefix="demo" tagdir="/WEB-INF/tags"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<demo:header />

<kendo:notification name="centeredNotification" stacking="down" show="onShow" button="true"></kendo:notification>
<kendo:notification name="configurableNotification"></kendo:notification>
 
 <div class="demo-section">
     <h3>Centered notification:</h3>
     <p>
         <button id="showNotification" class="k-button">Show centered notification</button>
     </p>
         <h3>Custom positioning:</h3>
     <p>
         <label for="left">Left position:</label> <input type="number" id="left" class="num" />
         <label for="left">Top position:</label> <input type="number" id="top" class="num" />
         <br />
         <label for="left">Right position:</label> <input type="number" id="right" class="num" value="20" />
         <label for="left">Bottom position:</label> <input type="number" id="bottom" class="num" value="20" />
         <br />
         <label for="stacking">Notification stacking:</label>
         <select id="stacking" style="width:6em"><option selected="selected">up</option><option>right</option><option>down</option><option>left</option></select>
         <br />
         Top / Left position settings take precedence over Bottom / Right, if both pairs are set.
     </p>
     <p>
         <button id="showConfigurable" class="k-button">Show notification</button>
     </p>
     <h3>Hide notification:</h3>
     <p>
         <button id="hideAllNotifications" class="k-button">Hide all notifications</button>
     </p>
 </div>

 <script>

     function onShow(e) {
         if (!$("." + e.sender._guid)[1]) {
             var element = e.element.parent(),
                 eWidth = element.width(),
                 eHeight = element.height(),
                 wWidth = $(window).width(),
                 wHeight = $(window).height(),
                 newTop, newLeft;
             
             newLeft = Math.floor(wWidth / 2 - eWidth / 2);
             newTop = Math.floor(wHeight / 2 - eHeight / 2);

             e.element.parent().css({top: newTop, left: newLeft});
         }
     }

     $(document).ready(function() {
         var centered = $("#centeredNotification").data("kendoNotification");

         $("#showNotification").click(function(){
             centered.show(new Date().toLocaleTimeString());
         });

         var configurable = $("#configurableNotification").data("kendoNotification");

         $("#hideAllNotifications").click(function(){
             centered.hide();
             configurable.hide();
         });

         function applyConfiguration() {
             configurable.hide();
             configurable.setOptions({
                 position: {
                     top: $("#top").data("kendoNumericTextBox").value(),
                     left: $("#left").data("kendoNumericTextBox").value(),
                     bottom: $("#bottom").data("kendoNumericTextBox").value(),
                     right: $("#right").data("kendoNumericTextBox").value()
                 },
                 stacking: $("#stacking").data("kendoDropDownList").value()
             });
         }

         var config = {
             decimals: 0,
             min: 0,
             format: "n0",
             change: applyConfiguration
         };

         $(".num").each(function(){
             $(this).kendoNumericTextBox(config);
         });

         $("#stacking").kendoDropDownList({
             change: applyConfiguration
         });

         $("#showConfigurable").click(function(){
             configurable.show(new Date().toLocaleTimeString());
         });
     });
 </script>

 <style scoped>

 .demo-section {
     width: 600px;
     padding: 20px 30px;
 }
 .demo-section p {
     margin: 3px 0 15px;
     line-height: 36px;
 }

 .demo-section label {
     display: inline-block;
     width: 12em;
     padding-right: .8em;
     text-align: right;
 }

 .num {
     width: 6em;
 }

 </style>

<demo:footer />