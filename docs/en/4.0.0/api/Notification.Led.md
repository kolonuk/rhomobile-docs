#Notification.Led
<div class="btn-group"><a href="#Methods" class="btn"><i class="icon-cog"></i> Methods<sup>&nbsp;4</sub></a><a class="btn dropdown-toggle" data-toggle="dropdown" data-target="#" href="#Methods" >  <span class="caret"></span>&nbsp;</a><ul class="dropdown-menu" style="max-height: 500px;overflow: auto;"><li class="disabled"><a tabindex="-1" href="#"><b><i>Methods - Class</i></b></a><li><a href="#menumerateSTATIC" data-target="cMethodenumerate" class="autouncollapse">enumerate</a></li></li><li class="divider"></li><li class="disabled"><a tabindex="-1" href="#"><b><i>Methods - Instance</i></b></a><li><a href="#mextinguish" data-target="cMethodextinguish" class="autouncollapse">extinguish</a></li><li><a href="#mflash" data-target="cMethodflash" class="autouncollapse">flash</a></li><li><a href="#milluminate" data-target="cMethodilluminate" class="autouncollapse">illuminate</a></li></li></ul></div><div class="btn-group"><a href="#Properties" class="btn"><i class="icon-list"></i> Properties<sup>&nbsp;1</sup></a><button href="#" class="btn dropdown-toggle" data-toggle="dropdown">  <span class="caret"></span>&nbsp;</button><ul class="dropdown-menu" style="max-height: 500px;overflow: auto;"><li class="disabled"><a tabindex="-1" href="#"><b><i>Instance Properties</i></b></a><li><a href="#pname" data-target="cPropertyname" class="autouncollapse">name</a></li></li></ul></div><div class="btn-group"><a href="#Examples" class="btn"><i class="icon-edit"></i> Examples<sup>&nbsp;1</sup></a><button href="#" class="btn dropdown-toggle" data-toggle="dropdown">  <span class="caret"></span>&nbsp;</button><ul class="dropdown-menu" style="max-height: 500px;overflow: auto;"><li><a href="#e0" data-target="eExample0" class="autouncollapse">Flash a specific LED</a></li></ul></div><div class="btn-group"><a href="#Remarks" class="btn"><i class="icon-warning-sign"></i> Remarks<sup>&nbsp;1</sup></a><button href="#" class="btn dropdown-toggle" data-toggle="dropdown">  <span class="caret"></span>&nbsp;</button><ul class="dropdown-menu" style="max-height: 500px;overflow: auto;"><li><a href="#r0" data-target="rRemark0" class="autouncollapse">Underlying hardware</a></li></ul></div><div class="btn-group pull-right"><button class="btn dropdown-toggle" id="apiFilterBtn" data-toggle="dropdown" href="#" title="Filter Properties and Methods"><i class="icon-filter "></i>Show</button><select id="apiFilter" class="dropdown-menu apiFilter"><option value="all">All</option><option value="js">JavaScript</option><option value="ruby">Ruby</option><option value="android">Android</option><option value="ios">iOS</option><option value="wm">Windows Mobile</option><option value="wp8">Windows Phone 8</option><option value="w32">Windows Desktop</option><option value="msi">MSI Only</option></select></div><div  id="apibody" style="overflow:auto;padding-right: 5px;">
<p>The LED API is a child of the Notification API and allows access to the LEDs on your device</p>
<h2>Enabling the API</h2>

<p>This API is part of the <code>coreapi</code> extension that is included automatically.</p>

<pre><code>:::ruby
extensions: ["coreapi"]
</code></pre>

<h2>JavaScript Usage</h2>

<p>Be sure to review the <a href="/guide/api_js">JavaScript API Usage</a> guide for important information about using this API in JavaScript</p>

<h2>Ruby Usage</h2>

<p>Be sure to review the <a href="/guide/api_ruby">Ruby API Usage</a> guide for important information about using this API in Ruby</p>


<a name='Methods'></a>
<h2><i class='icon-cog'></i>Methods</h2>

<div class="accordion" id="accordion"><a name ='menumerateSTATIC'/><div class=' method  js ruby android ios' id='menumerateSTATIC'><h3><strong  >enumerate</strong><span style='font-size:.7em;font-weight:normal;'>(<span class='text-info'>CallBackHandler</span> callback)</span></h3><ul class="nav nav-tabs" style="padding-left:8px"><li class='active'><a href="#menumerateSTATIC1" data-toggle="tab">Description</a></li><li ><a href="#menumerateSTATIC2" data-toggle="tab">Parameters</a></li><li ><a href="#menumerateSTATIC3" data-toggle="tab">Callback</a></li><li ><a href="#menumerateSTATIC4" data-toggle="tab">Return</a></li><li ><a href="#menumerateSTATIC6" data-toggle="tab">Access</a></li></ul><div class='tab-content' style='padding-left:8px' id='tc-enumerateSTATIC'><div class="tab-pane fade active in" id="menumerateSTATIC1"><p>Used to return the LEDs present on the device, you can then subsequently illuminate or extinguish them.</p>
<p><div><p><img src="/img/js.png" style="width: 20px;padding-top: 8px" rel="tooltip" title="JavaScript"><img src="/img/ruby.png" style="width: 20px;padding-top: 8px" rel="tooltip" title="Ruby"><img src="/img/android.png" style="width: 20px;padding-top: 8px" rel="tooltip" title="Android"><img src="/img/ios.png" style="width: 20px;padding-top: 8px" rel="tooltip" title="iphone, ipod touch, ipad"><img src="/img/windowsmobile.png" style="height: 20px;padding-top: 8px" rel="tooltip" title="Windows Mobile, Windows CE, Windows Embedded"></p></div></p></div><div class="tab-pane fade" id="menumerateSTATIC2"><div><p><strong>Parameters</strong></p><ul><li>callback : <span class='text-info'>CallBackHandler</span> <span class='label label-info'>Optional</span> </li></ul></div></div><div class="tab-pane fade" id="menumerateSTATIC3"><div><p><strong>Async Callback Returning Parameters: <span class='text-info'>ARRAY</span></strong></p><ul><ul><li><i>Object<i> : <span class='text-info'>SELF_INSTANCE: Rho.Notification.Led</span><p> </p></li></ul></ul></div></div><div class="tab-pane fade" id="menumerateSTATIC4"><div><p><strong>Synchronous Return:</strong></p><ul><li>Void : this method also supports async callbacks - check the Callback tab for callback return parameters.</li></ul></div></div><div class="tab-pane fade" id="menumerateSTATIC6"><div><p><strong>Method Access:</strong></p><ul><li><i class="icon-book"></i>Class Method: This method can only be accessed via the API class object. <ul><li>JavaScript: <code>Rho.Notification.Led.enumerate(<span class='text-info'>CallBackHandler</span> callback)</code> </li><li>Ruby: <code>Rho::Notification.Led.enumerate(<span class='text-info'>CallBackHandler</span> callback)</code></li></ul></li></ul></div></div></div>  </div><a name ='mextinguish'/><div class=' method  js ruby android ios' id='mextinguish'><h3><strong  >extinguish</strong><span style='font-size:.7em;font-weight:normal;'>()</span></h3><ul class="nav nav-tabs" style="padding-left:8px"><li class='active'><a href="#mextinguish1" data-toggle="tab">Description</a></li><li ><a href="#mextinguish4" data-toggle="tab">Return</a></li><li ><a href="#mextinguish6" data-toggle="tab">Access</a></li></ul><div class='tab-content' style='padding-left:8px' id='tc-extinguish'><div class="tab-pane fade active in" id="mextinguish1"><p>Called on an LED object returned from the enumerate method, the specified LED will be extinguished.</p>
<p><div><p><img src="/img/js.png" style="width: 20px;padding-top: 8px" rel="tooltip" title="JavaScript"><img src="/img/ruby.png" style="width: 20px;padding-top: 8px" rel="tooltip" title="Ruby"><img src="/img/android.png" style="width: 20px;padding-top: 8px" rel="tooltip" title="Android"><img src="/img/ios.png" style="width: 20px;padding-top: 8px" rel="tooltip" title="iphone, ipod touch, ipad"><img src="/img/windowsmobile.png" style="height: 20px;padding-top: 8px" rel="tooltip" title="Windows Mobile, Windows CE, Windows Embedded"></p></div></p></div><div class="tab-pane fade" id="mextinguish2"></div><div class="tab-pane fade" id="mextinguish3"></div><div class="tab-pane fade" id="mextinguish4"><div><p><strong>Synchronous Return:</strong></p><ul><li>Void</li></ul></div></div><div class="tab-pane fade" id="mextinguish6"><div><p><strong>Method Access:</strong></p><ul><li><i class="icon-file"></i>Instance Method: This method can be accessed via an instance object of this class: <ul><li><code>myObject.extinguish()</code></li></ul></li></ul></div></div></div>  </div><a name ='mflash'/><div class=' method  js ruby android ios' id='mflash'><h3><strong  >flash</strong><span style='font-size:.7em;font-weight:normal;'>(<span class="text-info">HASH</span> propertyMap)</span></h3><ul class="nav nav-tabs" style="padding-left:8px"><li class='active'><a href="#mflash1" data-toggle="tab">Description</a></li><li ><a href="#mflash2" data-toggle="tab">Parameters</a></li><li ><a href="#mflash4" data-toggle="tab">Return</a></li><li ><a href="#mflash6" data-toggle="tab">Access</a></li></ul><div class='tab-content' style='padding-left:8px' id='tc-flash'><div class="tab-pane fade active in" id="mflash1"><p>Called on an LED object returned from the enumerate method, the specified LED will be flashed.</p>
<p><div><p><img src="/img/js.png" style="width: 20px;padding-top: 8px" rel="tooltip" title="JavaScript"><img src="/img/ruby.png" style="width: 20px;padding-top: 8px" rel="tooltip" title="Ruby"><img src="/img/android.png" style="width: 20px;padding-top: 8px" rel="tooltip" title="Android"><img src="/img/ios.png" style="width: 20px;padding-top: 8px" rel="tooltip" title="iphone, ipod touch, ipad"><img src="/img/windowsmobile.png" style="height: 20px;padding-top: 8px" rel="tooltip" title="Windows Mobile, Windows CE, Windows Embedded"></p></div></p></div><div class="tab-pane fade" id="mflash2"><div><p><strong>Parameters</strong></p><ul><li>propertyMap : <span class='text-info'>HASH</span><p><p>The properties associated with the LED flash.</p>
 </p></li><ul><li>onDuration : <span class='text-info'>Integer</span><span class='label '> Default: 1000</span><p><p>When flashing, the LED will remain on for this number of milliseconds</p>
 </p></li><li>offDuration : <span class='text-info'>Integer</span><span class='label '> Default: 1000</span><p><p>When flashing, the LED will remain off for this number of milliseconds</p>
 </p></li><li>numberOfCycles : <span class='text-info'>Integer</span><span class='label '> Default: 1</span><p><p>The LED will flash this number of times.</p>
 </p></li></ul></ul></div></div><div class="tab-pane fade" id="mflash3"></div><div class="tab-pane fade" id="mflash4"><div><p><strong>Synchronous Return:</strong></p><ul><li>Void</li></ul></div></div><div class="tab-pane fade" id="mflash6"><div><p><strong>Method Access:</strong></p><ul><li><i class="icon-file"></i>Instance Method: This method can be accessed via an instance object of this class: <ul><li><code>myObject.flash(<span class="text-info">HASH</span> propertyMap)</code></li></ul></li></ul></div></div></div>  </div><a name ='milluminate'/><div class=' method  js ruby android ios' id='milluminate'><h3><strong  >illuminate</strong><span style='font-size:.7em;font-weight:normal;'>()</span></h3><ul class="nav nav-tabs" style="padding-left:8px"><li class='active'><a href="#milluminate1" data-toggle="tab">Description</a></li><li ><a href="#milluminate4" data-toggle="tab">Return</a></li><li ><a href="#milluminate6" data-toggle="tab">Access</a></li></ul><div class='tab-content' style='padding-left:8px' id='tc-illuminate'><div class="tab-pane fade active in" id="milluminate1"><p>Called on an LED object returned from the enumerate method, the specified LED will be illuminated.</p>
<p><div><p><img src="/img/js.png" style="width: 20px;padding-top: 8px" rel="tooltip" title="JavaScript"><img src="/img/ruby.png" style="width: 20px;padding-top: 8px" rel="tooltip" title="Ruby"><img src="/img/android.png" style="width: 20px;padding-top: 8px" rel="tooltip" title="Android"><img src="/img/ios.png" style="width: 20px;padding-top: 8px" rel="tooltip" title="iphone, ipod touch, ipad"><img src="/img/windowsmobile.png" style="height: 20px;padding-top: 8px" rel="tooltip" title="Windows Mobile, Windows CE, Windows Embedded"></p></div></p></div><div class="tab-pane fade" id="milluminate2"></div><div class="tab-pane fade" id="milluminate3"></div><div class="tab-pane fade" id="milluminate4"><div><p><strong>Synchronous Return:</strong></p><ul><li>Void</li></ul></div></div><div class="tab-pane fade" id="milluminate6"><div><p><strong>Method Access:</strong></p><ul><li><i class="icon-file"></i>Instance Method: This method can be accessed via an instance object of this class: <ul><li><code>myObject.illuminate()</code></li></ul></li></ul></div></div></div>  </div></div>
<a name='Properties'></a>
<h2><i class='icon-list'></i>Properties</h2>

<a name='pname'></a><div class=' method  js ruby android ios' id='pname'><h3><strong  >name</strong><span style='font-size:.7em;font-weight:normal;'> : <span class='text-info'>STRING</span> <span class='label'>Read Only</span> <span class='muted pull-right'>1.0.0</span></span></h3><ul class="nav nav-tabs" style="padding-left:8px"><li class='active'><a href="#pname1" data-toggle="tab">Description</a></li><li ><a href="#pname6" data-toggle="tab">Access</a></li></ul><div class='tab-content' style='padding-left:8px' id='tc-name'><div class="tab-pane fade active in" id="pname1"><p>Human readable name for the notification object, e.g. &lsquo;Green LED&rsquo;.</p>
<p><div><p><img src="/img/js.png" style="width: 20px;padding-top: 8px" rel="tooltip" title="JavaScript"><img src="/img/ruby.png" style="width: 20px;padding-top: 8px" rel="tooltip" title="Ruby"><img src="/img/android.png" style="width: 20px;padding-top: 8px" rel="tooltip" title="Android"><img src="/img/ios.png" style="width: 20px;padding-top: 8px" rel="tooltip" title="iphone, ipod touch, ipad"><img src="/img/windowsmobile.png" style="height: 20px;padding-top: 8px" rel="tooltip" title="Windows Mobile, Windows CE, Windows Embedded"> </p></div></p></div><div class="tab-pane fade" id="pname2"></div><div class="tab-pane fade" id="pname5"></div><div class="tab-pane fade" id="pname6"><div><p><strong>Property Access:</strong></p><ul><li><i class="icon-file"></i>Instance: This property can be accessed via an instance object of this class: <ul><li><code>myObject.name</code></li></ul></li></ul></div></div></div>  </div>
<a name='Examples'></a>
<h2><i class='icon-edit'></i>Examples</h2>

<a name='e0'></a><div class=' example' id='e0'><div class="accordion-group"><div class="accordion-heading"><span class="accordion-toggle"   href="#cExample0"><strong>Flash a specific LED</strong></div><div id="cExample0" class="accordion-body">  <div class="accordion-inner">
<p>Enumerating the LEDs will return an array objects which will map to the real LEDs on the device, using these returned objects you can control the device LEDs</p>
<ul class='nav nav-tabs' id='exI0-S0Tab'><li class='active'><a href='#exI0-S0RUBY' data-toggle='tab'>Ruby</a></li></ul><div class='tab-content'><div class='tab-pane active' id='exI0-S0RUBY'><pre class='CodeRay'><code>:::ruby

           
# ---------------
# controller.rb  
# ---------------
         
def choose_led
  # Obtain list of available leds on the device. 
  $leds = Rho::Notification::Led.enumerate
  render
end

def flash_led
  # receive an integer as parameter, which represents the number of the LED we wish to use
  led = $leds[@params["ledIndex"].to_i]
  led.numberOfCycles = 4
  led.flash({})
end


# ---------------
# choose_led.erb
# ---------------
&lt;ul data-role="listview"&gt;
  &lt;% $leds.each_with_index do |led, index| %&gt;
    &lt;li&gt;&lt;a href="&lt;%= url_for(:action =&gt; :flash_led, :query =&gt; {:ledIndex =&gt; index}) %&gt;"&gt;&lt;%= led.name %&gt;&lt;/li&gt; 
  &lt;% end %&gt;
&lt;/ul&gt;
                   
                 </code></pre></div></div>  </div></div></div></div>
<a name='Remarks'></a>
<h2><i class='icon-warning-sign'></i>Remarks</h2>

<a name='r0'></a><div class=' remarks' id='r0'><div class="accordion-group"><div class="accordion-heading"><span class="accordion-toggle"  href="#cRemark0"><strong>Underlying hardware</strong></div><div id="cRemark0" class="accordion-body">  <div class="accordion-inner"><p>The LED API relies on Motorola drivers on Windows Mobile / CE and therefore will not work on non-Motorola platforms.  Depending on your device configuration, not all LEDs reported by the API may exist physically on the device.</p>
  </div></div></div></div></div>