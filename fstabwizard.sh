<!DOCTYPE html>
<!-- Server: sfs-forge-6 -->


    

















<!--[if lt IE 7 ]> <html lang="en" class="no-js ie6"> <![endif]-->
<!--[if IE 7 ]>    <html lang="en" class="no-js ie7"> <![endif]-->
<!--[if IE 8 ]>    <html lang="en" class="no-js ie8"> <![endif]-->
<!--[if IE 9 ]>    <html lang="en" class="no-js ie9"> <![endif]-->
<!--[if (gt IE 9)|!(IE)]>-->
<html lang="en" class="no-js"> <!--<![endif]-->
<head>
    <meta content="text/html; charset=UTF-8" http-equiv="content-type"/>
    <title>
  FSTAB wizard / Code /
  [c8d817]
  /fstabwizard.sh
</title>
    


<script type="text/javascript">
  var _paq = _paq || [];
  _paq.push(['trackPageView', document.title, {
        dimension1: 'fstabwizard',
        dimension2: 'git'
  }]);
  _paq.push(['enableLinkTracking']);
  (function() {
    var u="//analytics.slashdotmedia.com/";
    _paq.push(['setTrackerUrl', u+'sf.php']);
    _paq.push(['setSiteId', 39]);
    var d=document, g=d.createElement('script'), s=d.getElementsByTagName('script')[0];
    g.type='text/javascript'; g.async=true; g.defer=true; g.src=u+'sf.js'; s.parentNode.insertBefore(g,s);
  })();
</script>
<noscript><p><img src="//analytics.slashdotmedia.com/sf.php?idsite=39" style="border:0;" alt="" /></p></noscript>

<meta id="project_name" name="project_name" content='fstabwizard' />
<!--[if lt IE 7 ]>
  <script src="https://a.fsdn.com/allura/nf/1509379571/_ew_/theme/sftheme/js/sftheme/vendor/dd_belatedpng.js"></script>
  <script> DD_belatedPNG.fix('img, .png_bg'); //fix any <img> or .png_bg background-images </script>
<![endif]-->
<link href='//fonts.googleapis.com/css?family=Ubuntu:regular' rel='stylesheet' type='text/css'>
<script>
if (!window.SF) { window.SF = {}; }
SF.sandiego = false;
SF.sandiego_chrome = false;
</script>
    
        <!-- ew:head_css -->

    
        <link rel="stylesheet"
                type="text/css"
                href="https://a.fsdn.com/allura/nf/1509379571/_ew_/_slim/css?href=allura%2Fcss%2Fforge%2Fhilite.css%3Ballura%2Fcss%2Fforge%2Ftooltipster.css"
                >
    
        <link rel="stylesheet"
                type="text/css"
                href="https://a.fsdn.com/allura/nf/1509379571/_ew_/allura/css/font-awesome.min.css"
                >
    
        <link rel="stylesheet"
                type="text/css"
                href="https://a.fsdn.com/allura/nf/1509379571/_ew_/theme/sftheme/css/forge.css"
                >
    
        
<!-- /ew:head_css -->

    
    
        <!-- ew:head_js -->

    
        <script type="text/javascript" src="https://a.fsdn.com/allura/nf/1509379571/_ew_/_slim/js?href=allura%2Fjs%2Fjquery-base.js%3Btheme%2Fsftheme%2Fjs%2Fsftheme%2Fvendor%2Fmodernizr.3.3.1.custom.js%3Btheme%2Fsftheme%2Fjs%2Fsftheme%2Fshared_head.js%3Btheme%2Fsftheme%2Fjs%2Fsftheme%2Ftypescript%2Fcompliance.js"></script>
    
        
<!-- /ew:head_js -->

    

    
        <style type="text/css">
            #page-body.project---init-- #top_nav { display: none; }

#page-body.project---init-- #nav_menu_holder { display: none; margin-bottom: 0; }

#page-body.project---init-- #content_base {margin-top: 0; }
        </style>
    
    
    <link rel="alternate" type="application/rss+xml" title="RSS" href="/p/fstabwizard/code/feed.rss"/>
    <link rel="alternate" type="application/atom+xml" title="Atom" href="/p/fstabwizard/code/feed.atom"/>
    <style type="text/css">
        #access_urls .btn-set {
            
            min-width: 14em;
        }
    </style>

    <style>.XRALJwMqoixJNCazMiLU {
        display: none
    }</style>

    
    
    
    


<script type="text/javascript">
    (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
            (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
        m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
    })(window,document,'script','//www.google-analytics.com/analytics.js','ga');

    function _add_tracking(prefix, tracking_id) {
        ga('create', tracking_id, {cookieDomain: 'auto', 'name': prefix,'sampleRate': 9});
        
        ga(prefix+'.set', 'dimension9', 'fstabwizard');
        ga(prefix+'.set', 'dimension10', 'git');
        
        ga(prefix+'.set', 'dimension13', 'Logged Out');
        ga(prefix+'.send', 'pageview');
    }
      _add_tracking('sfnt1', 'UA-32013-6');
      _add_tracking('sfnt2', 'UA-36130941-1');
    
</script>
</head>

<body class="body_class

" id="forge">

    
        <!-- ew:body_top_js -->

    
        
<!-- /ew:body_top_js -->

    




<header id="site-header">
    <div class="wrapper">
        <a href="/" class="logo">
            <span>SourceForge</span>
        </a>
        
        <form method="get" action="/directory/">
            <input type="text" id="words" name="q" placeholder="Search">
        </form>
        
        <!--Switch to {language}-->
        <nav id="nav-site">
            <a href="/directory/" title="Browse our software.">Browse</a>
            <a href="/directory/enterprise" title="Browse our Enterprise software.">Enterprise</a>
            <a href="/blog/" title="Read the latest news from the SF HQ.">Blog</a>
            <a href="/articles/" title="Read the latest industry news about products and updates from leading cloud, network, and developer tool service providers">Articles</a>
            <a href="//deals.sourceforge.net/?utm_source=sourceforge&amp;utm_medium=navbar&amp;utm_campaign=homepage" title="Discover and Save on the Best Gear, Gadgets, and Software" class="featured-link" target="_blank">Deals</a>
            <a href="/support" title="Contact us for help and feedback.">Help</a>
            <a href="/create"  class="featured-link blue"  style="" title="Create and publish Open Source software for free.">Create</a>
        </nav>
        <nav id="nav-account">
            
              <div class="logged_out">
                <a href="/auth/">Log In</a>
                <span>or</span>
                <a href="https://sourceforge.net/user/registration/">Join</a>
              </div>
            
        </nav>
    </div>
</header>
<header id="site-sec-header">
    <div class="wrapper">
        <nav id="nav-hubs">
            <h4>Solution Centers</h4>
            
        </nav>
        <nav id="nav-collateral">
            <a href="https://library.slashdotmedia.com/">Resources</a>
            <a href="/user/newsletters?source=sfnet_header">Newsletters</a>
            <a href="/cloud-storage-providers/?source=sfnet_header">Cloud Storage Providers</a>
            <a href="/business-voip/?source=sfnet_header">Business VoIP Providers</a>
            
            <a href="/speedtest/?source=sfnet_header">Internet Speed Test</a>
            
            <a href="/call-center-providers/?source=sfnet_header">Call Center Providers</a>
        </nav>
        <nav id="nav-social">
            
<span></span>
<a href="https://twitter.com/sourceforge" class="twitter" rel="nofollow" target="_blank">

<svg  viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M1684 408q-67 98-162 167 1 14 1 42 0 130-38 259.5t-115.5 248.5-184.5 210.5-258 146-323 54.5q-271 0-496-145 35 4 78 4 225 0 401-138-105-2-188-64.5t-114-159.5q33 5 61 5 43 0 85-11-112-23-185.5-111.5t-73.5-205.5v-4q68 38 146 41-66-44-105-115t-39-154q0-88 44-163 121 149 294.5 238.5t371.5 99.5q-8-38-8-74 0-134 94.5-228.5t228.5-94.5q140 0 236 102 109-21 205-78-37 115-142 178 93-10 186-50z"/></svg></a>
<a href="https://www.facebook.com/sourceforgenet/" class="facebook" rel="nofollow" target="_blank">

<svg  viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M1343 12v264h-157q-86 0-116 36t-30 108v189h293l-39 296h-254v759h-306v-759h-255v-296h255v-218q0-186 104-288.5t277-102.5q147 0 228 12z"/></svg></a>
<a href="https://plus.google.com/+sourceforge" class="google" rel="nofollow publisher" target="_blank">

<svg   viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M896 786h725q12 67 12 128 0 217-91 387.5t-259.5 266.5-386.5 96q-157 0-299-60.5t-245-163.5-163.5-245-60.5-299 60.5-299 163.5-245 245-163.5 299-60.5q300 0 515 201l-209 201q-123-119-306-119-129 0-238.5 65t-173.5 176.5-64 243.5 64 243.5 173.5 176.5 238.5 65q87 0 160-24t120-60 82-82 51.5-87 22.5-78h-436v-264z"/></svg></a>
<a href="https://www.linkedin.com/company/sourceforge.net" class="linkedin" rel="nofollow" target="_blank">

<svg  viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M477 625v991h-330v-991h330zm21-306q1 73-50.5 122t-135.5 49h-2q-82 0-132-49t-50-122q0-74 51.5-122.5t134.5-48.5 133 48.5 51 122.5zm1166 729v568h-329v-530q0-105-40.5-164.5t-126.5-59.5q-63 0-105.5 34.5t-63.5 85.5q-11 30-11 81v553h-329q2-399 2-647t-1-296l-1-48h329v144h-2q20-32 41-56t56.5-52 87-43.5 114.5-15.5q171 0 275 113.5t104 332.5z"/></svg></a>
<span></span>
        </nav>
    </div>
</header>


    
    
    




<section id="page-body" class=" neighborhood-Projects project-fstabwizard mountpoint-code 

">
<div id="nav_menu_holder">
    
        
            
    



    
    
    
        
    
    
    <nav id="breadcrumbs" class="breadcrumbs">
        <ul>
            <li itemscope itemtype="http://data-vocabulary.org/Breadcrumb"><a itemprop="url" href="/">Home</a></li>
            <li itemscope itemtype="http://data-vocabulary.org/Breadcrumb"><a itemprop="url" href="/directory">Browse</a></li>
            
            
                
                
            
            
                
            
            
            
                <li itemscope itemtype="http://data-vocabulary.org/Breadcrumb"><a itemprop="url" href="/p/fstabwizard/">FSTAB wizard</a></li>
                
            
            
                <li itemscope itemtype="http://data-vocabulary.org/Breadcrumb">Code</li>
                
            
        </ul>
    </nav>
    
    
    
  
    
        <h1 class="project_title">
            <a href="/p/fstabwizard/" class="project_link">FSTAB wizard</a>
        </h1>
    
    
    
    <h2 class="project_summary">
        FSTAB wizard - script to facilitate the setup of fstab
    </h2>
    
    <div class="brought-by">
        Brought to you by:
        
        
            
                <a href="/u/tommertom/">tommertom</a>
            </div>
    

        
    
</div>
    <div id="top_nav" class="">
        
            
<div id="top_nav_admin">
<ul class="dropdown">
  
    <li class="">
        <a href="/projects/fstabwizard/" class="tool-summary-32">
            Summary
        </a>
        
        
    </li>
  
    <li class="">
        <a href="/projects/fstabwizard/files/" class="tool-files-32">
            Files
        </a>
        
        
    </li>
  
    <li class="">
        <a href="/projects/fstabwizard/reviews" class="tool-reviews-32">
            Reviews
        </a>
        
        
    </li>
  
    <li class="">
        <a href="/projects/fstabwizard/support" class="tool-support-32">
            Support
        </a>
        
        
    </li>
  
    <li class="">
        <a href="/p/fstabwizard/wiki/" class="tool-wiki-32">
            Wiki
        </a>
        
        
    </li>
  
    <li class="selected">
        <a href="/p/fstabwizard/code/" class="tool-git-32">
            Code
        </a>
        
        
    </li>
  
  
</ul>
</div>


        
    </div>
    <div id="content_base">
        

    
            
                
                    


<div id="sidebar">
  
    <div>&nbsp;</div>
  
    
    
      
      
        
    
      <ul class="sidebarmenu">
      
    
  <li>
      
        <a class="icon" href="/p/fstabwizard/code/commit_browser" title="Browse Commits"><i class="fa fa-list"></i>
      
      <span>Browse Commits</span>
      </a>
  </li>
  
      
        
    
  <li>
      
        <a class="icon" href="/p/fstabwizard/code/fork" title="Fork"><i class="fa fa-code-fork"></i>
      
      <span>Fork</span>
      </a>
  </li>
  
      
        
    
  <li>
      
        <a href="/p/fstabwizard/code/merge-requests/"  >
      
      <span class="has_small">Merge Requests</span>
      <small>0</small></a>
  </li>
  
      
        
    
      </ul>
      
    
    
      <h3 class="">Branches</h3>
    
  
      
        
    
      <ul class="sidebarmenu">
      
    
  <li>
      
        <a href="/p/fstabwizard/code/ci/master/tree/"  >
      
      <span>master</span>
      </a>
  </li>
  
      
    
    
      </ul>
      
    
    
</div>
                
                
            
            
                
            
            <div class="grid-20 pad">
                <h2 class="dark title">
<a href="/p/fstabwizard/code/ci/c8d8175730735954c55f48a8304a6e0a9ec77842/">[c8d817]</a>:

  
  
 fstabwizard.sh

                    <!-- actions -->
                    <small>
                        

    
    <a class="icon" href="#" id="maximize-content" title="Maximize"><i class="fa fa-expand"></i>&nbsp;Maximize</a>
    <a class="icon" href="#" id="restore-content" title="Restore"><i class="fa fa-compress"></i>&nbsp;Restore</a>
<a class="icon" href="/p/fstabwizard/code/ci/c8d8175730735954c55f48a8304a6e0a9ec77842/log/?path=/fstabwizard.sh" title="History"><i class="fa fa-calendar"></i>&nbsp;History</a>

                    </small>
                    <!-- /actions -->
                </h2>
                
                <div>
                    
  

                    
  
    <p><a rel="nofollow" href="?format=raw">Download this file</a></p>
    <div class="clip grid-19 codebrowser">
      <h3>
        240 lines (203 with data), 8.9 kB
      </h3>
      
        <table class="codehilitetable"><tr><td class="linenos"><div class="linenodiv"><pre>  1
  2
  3
  4
  5
  6
  7
  8
  9
 10
 11
 12
 13
 14
 15
 16
 17
 18
 19
 20
 21
 22
 23
 24
 25
 26
 27
 28
 29
 30
 31
 32
 33
 34
 35
 36
 37
 38
 39
 40
 41
 42
 43
 44
 45
 46
 47
 48
 49
 50
 51
 52
 53
 54
 55
 56
 57
 58
 59
 60
 61
 62
 63
 64
 65
 66
 67
 68
 69
 70
 71
 72
 73
 74
 75
 76
 77
 78
 79
 80
 81
 82
 83
 84
 85
 86
 87
 88
 89
 90
 91
 92
 93
 94
 95
 96
 97
 98
 99
100
101
102
103
104
105
106
107
108
109
110
111
112
113
114
115
116
117
118
119
120
121
122
123
124
125
126
127
128
129
130
131
132
133
134
135
136
137
138
139
140
141
142
143
144
145
146
147
148
149
150
151
152
153
154
155
156
157
158
159
160
161
162
163
164
165
166
167
168
169
170
171
172
173
174
175
176
177
178
179
180
181
182
183
184
185
186
187
188
189
190
191
192
193
194
195
196
197
198
199
200
201
202
203
204
205
206
207
208
209
210
211
212
213
214
215
216
217
218
219
220
221
222
223
224
225
226
227
228
229
230
231
232
233
234
235
236
237
238
239</pre></div></td><td class="code"><div class="codehilite"><pre><div id="l1" class="code_block"><span class="ch">#!/bin/bash</span>
</div><div id="l2" class="code_block"><span class="c1"># NAZverryPie FSTABwizard - Copyright (c) 2014 TomGrun</span>
</div><div id="l3" class="code_block"><span class="c1">#</span>
</div><div id="l4" class="code_block"><span class="c1"># Permission is hereby granted, free of charge, to any person</span>
</div><div id="l5" class="code_block"><span class="c1"># obtaining a copy of this software and associated documentation</span>
</div><div id="l6" class="code_block"><span class="c1"># files (the &quot;Software&quot;), to deal in the Software without</span>
</div><div id="l7" class="code_block"><span class="c1"># restriction, including without limitation the rights to use,</span>
</div><div id="l8" class="code_block"><span class="c1"># copy, modify, merge, publish, distribute, sublicense, and/or sell</span>
</div><div id="l9" class="code_block"><span class="c1"># copies of the Software, and to permit persons to whom the</span>
</div><div id="l10" class="code_block"><span class="c1"># Software is furnished to do so, subject to the following</span>
</div><div id="l11" class="code_block"><span class="c1"># conditions:</span>
</div><div id="l12" class="code_block"><span class="c1">#</span>
</div><div id="l13" class="code_block"><span class="c1"># The above copyright notice and this permission notice shall be</span>
</div><div id="l14" class="code_block"><span class="c1"># included in all copies or substantial portions of the Software.</span>
</div><div id="l15" class="code_block"><span class="c1">#</span>
</div><div id="l16" class="code_block"><span class="c1"># THE SOFTWARE IS PROVIDED &quot;AS IS&quot;, WITHOUT WARRANTY OF ANY KIND,</span>
</div><div id="l17" class="code_block"><span class="c1"># EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES</span>
</div><div id="l18" class="code_block"><span class="c1"># OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND</span>
</div><div id="l19" class="code_block"><span class="c1"># NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT</span>
</div><div id="l20" class="code_block"><span class="c1"># HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,</span>
</div><div id="l21" class="code_block"><span class="c1"># WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING</span>
</div><div id="l22" class="code_block"><span class="c1"># FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR</span>
</div><div id="l23" class="code_block"><span class="c1"># OTHER DEALINGS IN THE SOFTWARE.</span>
</div><div id="l24" class="code_block"><span class="c1">#</span>
</div><div id="l25" class="code_block"><span class="c1">#</span>
</div><div id="l26" class="code_block"><span class="c1">#  FSTAB wizard - a friendlier installation of partitions</span>
</div><div id="l27" class="code_block"><span class="c1">#  Will also create SAMBA entries if neede</span>
</div><div id="l28" class="code_block"><span class="c1">#</span>
</div><div id="l29" class="code_block"><span class="c1">#</span>
</div><div id="l30" class="code_block"><span class="c1"># Tested against:</span>
</div><div id="l31" class="code_block"><span class="c1">#   Raspberry Pi B+</span>
</div><div id="l32" class="code_block"><span class="c1">#	Debian Wheezy</span>
</div><div id="l33" class="code_block"><span class="c1">#</span>
</div><div id="l34" class="code_block"><span class="c1"># Prerequisites:</span>
</div><div id="l35" class="code_block"><span class="c1">#	- Raspberry Pi</span>
</div><div id="l36" class="code_block"><span class="c1">#	- Debian Wheezy installed from raspberrypi.org image repository and rapi-config completed (FS expanded)</span>
</div><div id="l37" class="code_block"><span class="c1">#	- Internet connection for the Pi</span>
</div><div id="l38" class="code_block"><span class="c1">#</span>
</div><div id="l39" class="code_block"><span class="c1">#	Probably also usable on other Debian based systems (Ubuntu etc?)</span>
</div><div id="l40" class="code_block"><span class="c1">#</span>
</div><div id="l41" class="code_block"><span class="c1"># How to use:</span>
</div><div id="l42" class="code_block"><span class="c1">#	- wget  https://sourceforge.net/p/fstabwizard/code/ci/master/tree/fstabwizard.sh?format=raw -O fstabwizard.sh</span>
</div><div id="l43" class="code_block"><span class="c1">#	- run bash fstabwizard.sh &lt;optional:file to add smbconfigitems as argument&gt; </span>
</div><div id="l44" class="code_block"><span class="c1">#	- enter the parameters requested</span>
</div><div id="l45" class="code_block"><span class="c1">#</span>
</div><div id="l46" class="code_block"><span class="c1"># Future plans: </span>
</div><div id="l47" class="code_block"><span class="c1">#		None yet</span>
</div><div id="l48" class="code_block"><span class="c1">#</span>
</div><div id="l49" class="code_block"><span class="c1">#	C R E D I T S</span>
</div><div id="l50" class="code_block"><span class="c1">#	</span>
</div><div id="l51" class="code_block"><span class="c1"># This software uses many goodies out there on the web. Many well constructed and documented software provided.</span>
</div><div id="l52" class="code_block"><span class="c1"># Special thanks to all the dedicated developers and users sharing their knowledge. During the construction</span>
</div><div id="l53" class="code_block"><span class="c1"># of this software I tried to include the relevant websources as much as possible. If you feel like I have</span>
</div><div id="l54" class="code_block"><span class="c1"># been using your knowledge, but have forgotten to acknowledge this: apologies and please let me know through the </span>
</div><div id="l55" class="code_block"><span class="c1"># forum on raspberrypie.org.</span>
</div><div id="l56" class="code_block"><span class="c1">#</span>
</div><div id="l57" class="code_block"><span class="c1"># Special thank you for all the users, experts and noobs on stackoverflow.com. I have been a regular visitor</span>
</div><div id="l58" class="code_block"><span class="c1"># of this extremely useful site. So often, that it is not doable to include this in the source code.</span>
</div><div id="l59" class="code_block"><span class="c1">#</span>
</div><div id="l60" class="code_block"><span class="c1"># THANK YOU ALL!!!</span>
</div><div id="l61" class="code_block"><span class="c1">#</span>
</div><div id="l62" class="code_block"><span class="c1"># -- Tom</span>
</div><div id="l63" class="code_block"><span class="c1">#	</span>
</div><div id="l64" class="code_block"><span class="c1">#</span>
</div><div id="l65" class="code_block"><span class="c1">#</span>
</div><div id="l66" class="code_block">
</div><div id="l67" class="code_block"><span class="c1">############# begin script ##############</span>
</div><div id="l68" class="code_block"><span class="c1"># Welcome message</span>
</div><div id="l69" class="code_block"><span class="nv">FUN</span><span class="o">=</span><span class="k">$(</span>cat <span class="s">&lt;&lt;EOF</span>
</div><div id="l70" class="code_block"><span class="s">N A Z v e r r y P i e  - fstab wizard a friendlier installation script for partitions</span>
</div><div id="l71" class="code_block"><span class="s">\n</span>
</div><div id="l72" class="code_block"><span class="s">A simple wizard to configure your fstab for all connected devices (automatic detection).</span>
</div><div id="l73" class="code_block"><span class="s">\n</span>
</div><div id="l74" class="code_block"><span class="s">THE SOFTWARE IS PROVIDED &quot;AS IS&quot;, WITHOUT WARRANTY OF ANY KIND</span>
</div><div id="l75" class="code_block"><span class="s">\n</span>
</div><div id="l76" class="code_block"><span class="s">(C) TomGrun - MIT License</span>
</div><div id="l77" class="code_block"><span class="s">\n</span>
</div><div id="l78" class="code_block"><span class="s">Please select your next step. </span>
</div><div id="l79" class="code_block"><span class="s">EOF</span>
</div><div id="l80" class="code_block"><span class="k">)</span>
</div><div id="l81" class="code_block">
</div><div id="l82" class="code_block">whiptail --yesno <span class="s2">&quot;</span><span class="nv">$FUN</span><span class="s2">&quot;</span> --title <span class="s2">&quot;fstab installation wizard&quot;</span> --yes-button <span class="s2">&quot;Continue&quot;</span> --no-button <span class="s2">&quot;Exit&quot;</span> <span class="m">20</span> <span class="m">70</span> 
</div><div id="l83" class="code_block"><span class="nv">input</span><span class="o">=</span><span class="nv">$?</span>
</div><div id="l84" class="code_block"><span class="k">if</span> <span class="o">[</span> <span class="s2">&quot;</span><span class="nv">$input</span><span class="s2">&quot;</span> <span class="o">=</span> <span class="s2">&quot;255&quot;</span> <span class="o">]</span><span class="p">;</span> <span class="k">then</span> exit<span class="p">;</span> <span class="k">fi</span>
</div><div id="l85" class="code_block"><span class="k">if</span> <span class="o">[</span> <span class="s2">&quot;</span><span class="nv">$input</span><span class="s2">&quot;</span> <span class="o">=</span> <span class="s2">&quot;1&quot;</span> <span class="o">]</span><span class="p">;</span> <span class="k">then</span> exit<span class="p">;</span> <span class="k">fi</span>
</div><div id="l86" class="code_block">
</div><div id="l87" class="code_block"><span class="c1">#</span>
</div><div id="l88" class="code_block"><span class="c1"># Preparations: Set the mount points</span>
</div><div id="l89" class="code_block"><span class="c1">#</span>
</div><div id="l90" class="code_block"><span class="c1"># http://stackoverflow.com/questions/13565658/right-tool-to-filter-the-uuid-from-the-output-of-blkid-program-using-grep-cut</span>
</div><div id="l91" class="code_block"><span class="c1"># http://www.thegeekstuff.com/2010/06/bash-array-tutorial/</span>
</div><div id="l92" class="code_block"><span class="c1"># http://stackoverflow.com/questions/8821970/store-grep-output-containing-whitespaces-in-an-array</span>
</div><div id="l93" class="code_block"><span class="c1"># http://blog.famzah.net/2013/02/17/bash-split-a-string-into-columns-by-white-space-without-invoking-sub-shells/</span>
</div><div id="l94" class="code_block"><span class="c1"># Read all volumes in array</span>
</div><div id="l95" class="code_block"><span class="c1"># blkid will output /dev/sdb1: LABEL=&quot;ARCH_201108&quot; TYPE=&quot;udf&quot;</span>
</div><div id="l96" class="code_block">
</div><div id="l97" class="code_block"><span class="c1"># dos fs tools in order to detect FAT/NTFS type of systems</span>
</div><div id="l98" class="code_block">sudo apt-get -y install ntfs-3g dosfstools <span class="p">&amp;</span>&gt; /dev/null
</div><div id="l99" class="code_block">
</div><div id="l100" class="code_block"><span class="c1"># initiate variables and settings</span>
</div><div id="l101" class="code_block"><span class="nv">mountcounter</span><span class="o">=</span><span class="m">1</span>
</div><div id="l102" class="code_block">sudo mkdir /media/_tmpmount <span class="p">&amp;</span>&gt; /dev/null
</div><div id="l103" class="code_block">
</div><div id="l104" class="code_block"><span class="c1"># open up fstab</span>
</div><div id="l105" class="code_block"><span class="nv">permissions</span><span class="o">=</span><span class="k">$(</span>stat -c %a /etc/fstab<span class="k">)</span>
</div><div id="l106" class="code_block">sudo chmod <span class="m">666</span> /etc/fstab
</div><div id="l107" class="code_block">
</div><div id="l108" class="code_block"><span class="c1"># create ram drive for /var/tmp (taken from domoticz page) - only do so if there is no entry yet </span>
</div><div id="l109" class="code_block"><span class="nv">temp</span><span class="o">=</span><span class="k">$(</span>grep <span class="s2">&quot;/var/tmp&quot;</span> /etc/fstab<span class="k">)</span>
</div><div id="l110" class="code_block"><span class="k">if</span> <span class="o">[</span> -z <span class="s2">&quot;</span><span class="nv">$temp</span><span class="s2">&quot;</span> <span class="o">]</span><span class="p">;</span> <span class="k">then</span>
</div><div id="l111" class="code_block">	sudo mkdir /var/tmp 
</div><div id="l112" class="code_block">	<span class="nb">echo</span> -e <span class="s2">&quot;tmpfs\t/var/tmp\ttmpfs\tnodev,nosuid,size=1M\t0\t0&quot;</span>     &gt;&gt; /etc/fstab
</div><div id="l113" class="code_block"><span class="k">fi</span>
</div><div id="l114" class="code_block">
</div><div id="l115" class="code_block"><span class="c1">#</span>
</div><div id="l116" class="code_block"><span class="c1"># The main loop: will iterate through all devices listed in blkid and try to add mountpoint</span>
</div><div id="l117" class="code_block"><span class="c1">#</span>
</div><div id="l118" class="code_block"><span class="c1">#IFS_backup=$IFS</span>
</div><div id="l119" class="code_block"><span class="c1">#IFS=$&#39;\n&#39;</span>
</div><div id="l120" class="code_block"><span class="nb">echo</span> <span class="s2">&quot;</span><span class="k">$(</span>sudo blkid <span class="p">|</span> egrep <span class="s1">&#39;^/dev/sd[a-z]&#39;</span> <span class="p">|</span> cut -c <span class="m">1</span>-9<span class="k">)</span><span class="s2">&quot;</span> <span class="p">|</span> 
</div><div id="l121" class="code_block"><span class="o">{</span>
</div><div id="l122" class="code_block">	<span class="k">while</span> <span class="nb">read</span> i<span class="p">;</span> <span class="k">do</span>
</div><div id="l123" class="code_block">
</div><div id="l124" class="code_block">		<span class="nb">echo</span> <span class="s2">&quot;FSTAB wizard&quot;</span> <span class="s2">&quot;Processing </span><span class="nv">$i</span><span class="s2"> for mounting&quot;</span>
</div><div id="l125" class="code_block">
</div><div id="l126" class="code_block">		<span class="c1"># try to mount it</span>
</div><div id="l127" class="code_block">		sudo umount <span class="nv">$i</span> <span class="p">&amp;</span>&gt; /dev/null <span class="c1"># first umount because it may have been mounted b4</span>
</div><div id="l128" class="code_block">		sudo mount <span class="nv">$i</span> /media/_tmpmount <span class="p">&amp;</span>&gt; /dev/null
</div><div id="l129" class="code_block">		<span class="nv">mountflag</span><span class="o">=</span><span class="nv">$?</span>
</div><div id="l130" class="code_block">
</div><div id="l131" class="code_block">		<span class="c1"># if mounting is possible, add it to fstab and use it further</span>
</div><div id="l132" class="code_block">		<span class="k">if</span> <span class="o">[</span> <span class="s2">&quot;</span><span class="nv">$mountflag</span><span class="s2">&quot;</span> <span class="o">=</span> <span class="s2">&quot;0&quot;</span> <span class="o">]</span><span class="p">;</span> <span class="k">then</span>
</div><div id="l133" class="code_block">
</div><div id="l134" class="code_block">				<span class="c1"># get the relevant data for the mount</span>
</div><div id="l135" class="code_block">				<span class="nv">sizepartition</span><span class="o">=</span><span class="k">$(</span>df -h <span class="p">|</span> grep <span class="nv">$i</span> <span class="p">|</span> cut -c <span class="m">16</span>-22 <span class="p">|</span> tr -d <span class="s1">&#39; &#39;</span><span class="k">)</span>
</div><div id="l136" class="code_block">				<span class="nv">uuid</span><span class="o">=</span><span class="k">$(</span>sudo blkid <span class="p">|</span> grep <span class="nv">$i</span> <span class="p">|</span> sed -n <span class="s1">&#39;s/.*UUID=\&quot;\([^\&quot;]*\)\&quot;.*/\1/p&#39;</span><span class="k">)</span>
</div><div id="l137" class="code_block">				<span class="nv">parttype</span><span class="o">=</span><span class="k">$(</span>sudo blkid <span class="p">|</span> grep <span class="nv">$i</span> <span class="p">|</span> sed -n <span class="s1">&#39;s/.*TYPE=\&quot;\([^\&quot;]*\)\&quot;.*/\1/p&#39;</span><span class="k">)</span>
</div><div id="l138" class="code_block">
</div><div id="l139" class="code_block">				<span class="c1"># check ntfs</span>
</div><div id="l140" class="code_block">				<span class="k">if</span> <span class="o">[</span> <span class="s2">&quot;</span><span class="nv">$parttype</span><span class="s2">&quot;</span> <span class="o">=</span> <span class="s2">&quot;ntfs&quot;</span> <span class="o">]</span><span class="p">;</span> <span class="k">then</span>
</div><div id="l141" class="code_block">					<span class="nv">parttype</span><span class="o">=</span><span class="s2">&quot;ntfs-3g&quot;</span>
</div><div id="l142" class="code_block">				<span class="k">fi</span>
</div><div id="l143" class="code_block">				
</div><div id="l144" class="code_block">				<span class="nb">echo</span> <span class="s2">&quot;</span><span class="nv">$i</span><span class="s2"> mountable, size: </span><span class="nv">$sizepartition</span><span class="s2">, uuid:</span><span class="nv">$uuid</span><span class="s2">, type </span><span class="nv">$parttype</span><span class="s2">&quot;</span> 
</div><div id="l145" class="code_block">
</div><div id="l146" class="code_block">				<span class="c1"># initiate the default position: we want to add an entry</span>
</div><div id="l147" class="code_block">				<span class="nv">requiredmountpoint</span><span class="o">=</span><span class="s2">&quot;/media/mnt</span><span class="nv">$mountcounter</span><span class="s2">&quot;</span>
</div><div id="l148" class="code_block">				<span class="nv">wantsoverride</span><span class="o">=</span><span class="m">0</span>
</div><div id="l149" class="code_block">
</div><div id="l150" class="code_block">				<span class="c1"># ask user if he wants to override in case there is already a mountpoint for this uuid</span>
</div><div id="l151" class="code_block">				<span class="nv">temp</span><span class="o">=</span><span class="k">$(</span>grep <span class="s2">&quot;</span><span class="nv">$uuid</span><span class="s2">&quot;</span> /etc/fstab<span class="k">)</span>
</div><div id="l152" class="code_block">				<span class="k">if</span> <span class="o">[</span> -n <span class="s2">&quot;</span><span class="nv">$temp</span><span class="s2">&quot;</span> <span class="o">]</span><span class="p">;</span> <span class="k">then</span>
</div><div id="l153" class="code_block">
</div><div id="l154" class="code_block">					<span class="c1"># read the fstab entry into variable</span>
</div><div id="l155" class="code_block">					<span class="nv">FSTAB</span><span class="o">=(</span> <span class="k">$(</span>grep <span class="nv">$uuid</span> /etc/fstab<span class="k">)</span> <span class="o">)</span>
</div><div id="l156" class="code_block">					<span class="nv">FSTAB_UUID</span><span class="o">=</span><span class="s2">&quot;</span><span class="si">${</span><span class="nv">FSTAB</span><span class="p">[0]</span><span class="si">}</span><span class="s2">&quot;</span>
</div><div id="l157" class="code_block">					<span class="nv">FSTAB_MOUNT</span><span class="o">=</span><span class="s2">&quot;</span><span class="si">${</span><span class="nv">FSTAB</span><span class="p">[1]</span><span class="si">}</span><span class="s2">&quot;</span>
</div><div id="l158" class="code_block">					<span class="nv">FSTAB_FSTYPE</span><span class="o">=</span><span class="s2">&quot;</span><span class="si">${</span><span class="nv">FSTAB</span><span class="p">[2]</span><span class="si">}</span><span class="s2">&quot;</span>
</div><div id="l159" class="code_block">					<span class="nv">FSTAB_OPTIONS</span><span class="o">=</span><span class="s2">&quot;</span><span class="si">${</span><span class="nv">FSTAB</span><span class="p">[3]</span><span class="si">}</span><span class="s2">&quot;</span>
</div><div id="l160" class="code_block">	
</div><div id="l161" class="code_block">					<span class="c1"># do the dialog</span>
</div><div id="l162" class="code_block">					whiptail --yesno --title <span class="s2">&quot;FSTAB wizard&quot;</span> <span class="s2">&quot;A mountpoint for </span><span class="nv">$i</span><span class="s2"> (size: </span><span class="nv">$sizepartition</span><span class="s2">) is found. Do you want to override the settings (</span><span class="nv">$FSTAB_MOUNT</span><span class="s2">)?&quot;</span> --yes-button <span class="s2">&quot;Yes, override&quot;</span> --no-button <span class="s2">&quot;Skip </span><span class="nv">$i</span><span class="s2">&quot;</span> <span class="m">10</span> <span class="m">50</span> 
</div><div id="l163" class="code_block">					<span class="nv">wantsoverride</span><span class="o">=</span><span class="nv">$?</span>
</div><div id="l164" class="code_block">					<span class="k">if</span> <span class="o">[</span> <span class="s2">&quot;</span><span class="nv">$wantsoverride</span><span class="s2">&quot;</span> <span class="o">=</span> <span class="s2">&quot;0&quot;</span> <span class="o">]</span><span class="p">;</span> <span class="k">then</span> 
</div><div id="l165" class="code_block">						<span class="nv">requiredmountpoint</span><span class="o">=</span><span class="s2">&quot;</span><span class="nv">$FSTAB_MOUNT</span><span class="s2">&quot;</span>
</div><div id="l166" class="code_block">					<span class="k">fi</span>
</div><div id="l167" class="code_block">				<span class="k">fi</span>
</div><div id="l168" class="code_block">					
</div><div id="l169" class="code_block">				<span class="c1"># if user wants to override or there is no mountpoint found, then ask for it</span>
</div><div id="l170" class="code_block">				<span class="k">if</span> <span class="o">[</span> <span class="s2">&quot;</span><span class="nv">$wantsoverride</span><span class="s2">&quot;</span> <span class="o">=</span> <span class="m">0</span> <span class="o">]</span><span class="p">;</span> <span class="k">then</span> 
</div><div id="l171" class="code_block">						<span class="nv">requiredmountpoint</span><span class="o">=</span><span class="k">$(</span>whiptail --inputbox --title <span class="s2">&quot;FSTAB wizard&quot;</span> <span class="s2">&quot;Enter mountpoint for </span><span class="nv">$i</span><span class="s2"> (size: </span><span class="nv">$sizepartition</span><span class="s2">)&quot;</span> <span class="m">10</span> <span class="m">40</span> <span class="s2">&quot;</span><span class="nv">$requiredmountpoint</span><span class="s2">&quot;</span> <span class="m">3</span>&gt;<span class="p">&amp;</span><span class="m">1</span> <span class="m">1</span>&gt;<span class="p">&amp;</span><span class="m">2</span> <span class="m">2</span>&gt;<span class="p">&amp;</span><span class="m">3</span><span class="k">)</span>
</div><div id="l172" class="code_block">				
</div><div id="l173" class="code_block">					<span class="c1"># temp will be filled if there is an uuid with the requested mountpoint</span>
</div><div id="l174" class="code_block">					<span class="nv">temp</span><span class="o">=</span><span class="k">$(</span>grep <span class="nv">$requiredmountpoint</span> /etc/fstab <span class="p">|</span> grep -v <span class="nv">$uuid</span><span class="k">)</span> 
</div><div id="l175" class="code_block">			
</div><div id="l176" class="code_block">					<span class="c1"># if the $uuid does not link to the $requiredmount point, then there is a conflict. Ask user to resolve or accept conflict</span>
</div><div id="l177" class="code_block">					<span class="k">if</span> <span class="o">[</span> -n <span class="s2">&quot;</span><span class="nv">$temp</span><span class="s2">&quot;</span> <span class="o">]</span><span class="p">;</span> <span class="k">then</span>
</div><div id="l178" class="code_block">							<span class="nv">requiredmountpoint</span><span class="o">=</span><span class="k">$(</span>whiptail --inputbox --title <span class="s2">&quot;FSTAB wizard&quot;</span> <span class="s2">&quot;Mountpoint </span><span class="nv">$requiremedmountpoint</span><span class="s2"> is in use enter new one or accept possible conflict in /etc/fstab (and fix manually)&quot;</span> <span class="m">10</span> <span class="m">40</span> <span class="s2">&quot;</span><span class="nv">$requiredmountpoint</span><span class="s2">&quot;</span> <span class="m">3</span>&gt;<span class="p">&amp;</span><span class="m">1</span> <span class="m">1</span>&gt;<span class="p">&amp;</span><span class="m">2</span> <span class="m">2</span>&gt;<span class="p">&amp;</span><span class="m">3</span><span class="k">)</span>
</div><div id="l179" class="code_block">					<span class="k">fi</span>
</div><div id="l180" class="code_block">		
</div><div id="l181" class="code_block">					<span class="c1"># add the counter if the mountpoint is new</span>
</div><div id="l182" class="code_block">					<span class="nv">temp</span><span class="o">=</span><span class="k">$(</span>grep <span class="nv">$uuid</span> /etc/fstab<span class="k">)</span>
</div><div id="l183" class="code_block">					<span class="k">if</span> <span class="o">[</span> -z <span class="s2">&quot;</span><span class="nv">$temp</span><span class="s2">&quot;</span> <span class="o">]</span><span class="p">;</span> <span class="k">then</span>
</div><div id="l184" class="code_block">						<span class="nv">mountcounter</span><span class="o">+=</span><span class="m">1</span>
</div><div id="l185" class="code_block">					<span class="k">fi</span>
</div><div id="l186" class="code_block">		
</div><div id="l187" class="code_block">					<span class="c1"># check if mountpoint is available and if not, create directory</span>
</div><div id="l188" class="code_block">					sudo mkdir -p <span class="s2">&quot;</span><span class="nv">$requiredmountpoint</span><span class="s2">&quot;</span> <span class="p">&amp;</span>&gt; /dev/null
</div><div id="l189" class="code_block">					<span class="nv">actionresult</span><span class="o">=</span><span class="nv">$?</span>
</div><div id="l190" class="code_block">	
</div><div id="l191" class="code_block">					<span class="k">if</span> <span class="o">[</span> <span class="s2">&quot;</span><span class="nv">$actionresult</span><span class="s2">&quot;</span> -ne <span class="m">0</span> <span class="o">]</span><span class="p">;</span> <span class="k">then</span>
</div><div id="l192" class="code_block">						whiptail --msgbox --title <span class="s2">&quot;FSTAB wizard&quot;</span> <span class="s2">&quot;Cannot make </span><span class="nv">$requiredmountpoint</span><span class="s2">. Please fix this manually. Skipping this entry.&quot;</span> <span class="m">10</span> <span class="m">40</span>
</div><div id="l193" class="code_block">					<span class="k">fi</span>
</div><div id="l194" class="code_block">
</div><div id="l195" class="code_block">					<span class="c1"># only create the entry if the directory exists</span>
</div><div id="l196" class="code_block">					<span class="k">if</span> <span class="o">[</span> -d <span class="s2">&quot;</span><span class="nv">$requiredmountpoint</span><span class="s2">&quot;</span> <span class="o">]</span><span class="p">;</span> <span class="k">then</span>
</div><div id="l197" class="code_block">
</div><div id="l198" class="code_block">						sudo chmod <span class="m">777</span> <span class="s2">&quot;</span><span class="nv">$requiredmountpoint</span><span class="s2">&quot;</span>
</div><div id="l199" class="code_block">
</div><div id="l200" class="code_block">						<span class="c1"># Clear /etc/fstab for this UUID (if any)</span>
</div><div id="l201" class="code_block">						sudo sed -i <span class="s2">&quot;/</span><span class="nv">$uuid</span><span class="s2">/d&quot;</span> /etc/fstab <span class="p">&amp;</span>&gt; /dev/null
</div><div id="l202" class="code_block">
</div><div id="l203" class="code_block">						<span class="c1"># add the entry</span>
</div><div id="l204" class="code_block">						<span class="nb">echo</span> -e <span class="s2">&quot;UUID=</span><span class="nv">$uuid</span><span class="s2">\t</span><span class="nv">$requiredmountpoint</span><span class="s2">\t</span><span class="nv">$parttype</span><span class="s2">\tnoatime,users,permissions\t0\t0&quot;</span>     &gt;&gt; /etc/fstab
</div><div id="l205" class="code_block">					<span class="k">fi</span>
</div><div id="l206" class="code_block">				<span class="k">fi</span> <span class="c1"># wants override</span>
</div><div id="l207" class="code_block">
</div><div id="l208" class="code_block">				<span class="c1"># unmount for the next entry</span>
</div><div id="l209" class="code_block">				sudo umount <span class="nv">$i</span>
</div><div id="l210" class="code_block">
</div><div id="l211" class="code_block">				<span class="c1"># write samba entry to provided argument (if any)</span>
</div><div id="l212" class="code_block">				<span class="k">if</span> <span class="o">[</span> ! -z <span class="s2">&quot;</span><span class="nv">$1</span><span class="s2">&quot;</span> <span class="o">]</span><span class="p">;</span> <span class="k">then</span>	
</div><div id="l213" class="code_block">					<span class="nb">echo</span> -e <span class="s2">&quot;\n[</span><span class="nv">$uuid</span><span class="s2">]\npath = </span><span class="nv">$requiredmountpoint</span><span class="s2">\nbrowseable=Yes\nwriteable=Yes\nonly guest=no\ncreate mask=0777\ndirectory mask=0777\npublic=yes\n\n&quot;</span> &gt;&gt; <span class="nv">$1</span>
</div><div id="l214" class="code_block">				<span class="k">fi</span>
</div><div id="l215" class="code_block">		<span class="k">else</span> <span class="c1"># can mount</span>
</div><div id="l216" class="code_block">			whiptail --msgbox --title <span class="s2">&quot;FSTAB wizard&quot;</span> <span class="s2">&quot;Cannot mount </span><span class="nv">$i</span><span class="s2">.\n\nDon&#39;t worry about that, unless you really want this partition. \n\nThen you need to do the mounting and editing of /etc/fstab yourself.&quot;</span> <span class="m">15</span> <span class="m">40</span>
</div><div id="l217" class="code_block">			sleep <span class="m">5</span>
</div><div id="l218" class="code_block">		<span class="k">fi</span> <span class="c1"># can mount</span>
</div><div id="l219" class="code_block">	<span class="k">done</span>
</div><div id="l220" class="code_block"><span class="o">}</span>
</div><div id="l221" class="code_block">
</div><div id="l222" class="code_block"><span class="c1"># closing actions</span>
</div><div id="l223" class="code_block"><span class="c1">#	IFS=$IFS_backup</span>
</div><div id="l224" class="code_block">
</div><div id="l225" class="code_block"><span class="c1"># remove temp mount point</span>
</div><div id="l226" class="code_block">sudo rmdir /media/_tmpmount <span class="p">&amp;</span>&gt; /dev/null
</div><div id="l227" class="code_block">
</div><div id="l228" class="code_block"><span class="c1"># and revert permissions on fstab</span>
</div><div id="l229" class="code_block">sudo chmod <span class="nv">$permissions</span> /etc/fstab
</div><div id="l230" class="code_block">
</div><div id="l231" class="code_block"><span class="c1"># mount all, so we can use these directories. This should always work because we tested it before</span>
</div><div id="l232" class="code_block">sudo mount -a <span class="p">&amp;</span>&gt; /dev/null
</div><div id="l233" class="code_block">
</div><div id="l234" class="code_block"><span class="c1"># final remarks</span>
</div><div id="l235" class="code_block">whiptail --msgbox --title <span class="s2">&quot;FSTAB wizard&quot;</span> <span class="s2">&quot;Completed the script. You may want to check the fstab settings in /etc/fstab. If you asked for a SAMBA file, check the content of </span><span class="nv">$1</span><span class="s2"> and add this to the samba config: sudo cat </span><span class="nv">$1</span><span class="s2"> &gt;&gt; /etc/samba/smb.config.\n\nEnjoy!&quot;</span> <span class="m">10</span> <span class="m">40</span>
</div><div id="l236" class="code_block">
</div><div id="l237" class="code_block">clear
</div><div id="l238" class="code_block"><span class="nb">echo</span> <span class="s2">&quot;more /etc/fstab&quot;</span>
</div><div id="l239" class="code_block">more /etc/fstab
</div></pre></div>
</td></tr></table>
      
    </div>
  

                </div>
                
                
            </div>
        


    </div>
</section>
  


<footer id="site-footer">
    <div class="wrapper">
<nav>
            <h5>SourceForge</h5>
            <a href="/about">About</a>
            <a href="/blog/category/sitestatus/">Site Status</a>
            <a href="http://twitter.com/sfnet_ops">@sfnet_ops</a>
            <a id="allura-notice" href="http://allura.apache.org/">
                <p>Powered by</p>
                <p>Apache Allura™</p>
                <img src="https://a.fsdn.com/allura/nf/1509379571/_ew_/theme/sftheme/images/sftheme/logo-black-svg_g.png" />
            </a>
        </nav>
        <nav>
            <h5>Find and Develop Software</h5>
            <a href="/create/">Create a Project</a>
            <a href="/directory/">Software Directory</a>
            <a href="/top">Top Downloaded Projects</a>
        </nav>
        <nav>
            <h5>Community</h5>
            <a href="/blog/">Blog</a>
            <a href="http://twitter.com/sourceforge">@sourceforge</a>
            <a href="https://library.slashdotmedia.com/">Resources</a>
        </nav>
        <nav>
            <h5>Help</h5>
            <a href="http://p.sf.net/sourceforge/docs">Site Documentation</a>
            <a href="/support">Support Request</a>
        </nav>
    </div>
</footer>
<footer id="site-copyright-footer">
    <div class="wrapper">
        <div id="copyright">
            &copy; 2017 Slashdot Media. All Rights Reserved.<br />
        </div>
        <nav>
            <a href="http://slashdotmedia.com/terms-of-use">Terms</a>
            <a href="http://slashdotmedia.com/privacy-statement/">Privacy</a>
            <span id='teconsent'></span>
            <a href="http://slashdotmedia.com/opt-out-choices">Opt Out Choices</a>
            <a href="http://slashdotmedia.com">Advertise</a>
        </nav>
    </div>
</footer>



<div id="messages">
    
</div>


    <!-- ew:body_js -->


    <script type="text/javascript" src="https://a.fsdn.com/allura/nf/1509379571/_ew_/_slim/js?href=allura%2Fjs%2Fjquery.notify.js%3Ballura%2Fjs%2Fjquery.tooltipster.js%3Ballura%2Fjs%2Fsylvester.js%3Ballura%2Fjs%2Ftwemoji.min.js%3Ballura%2Fjs%2Fpb.transformie.min.js%3Ballura%2Fjs%2Fallura-base.js%3Ballura%2Fjs%2Fadmin_modal.js%3Bjs%2Fjquery.lightbox_me.js%3Btheme%2Fsftheme%2Fjs%2Fsftheme%2Fshared.js%3Btheme%2Fsftheme%2Fjs%2Fsftheme%2Fsticky.js%3Ballura%2Fjs%2Fmaximize-content.js"></script>

    
<!-- /ew:body_js -->



    <!-- ew:body_js_tail -->


    
<!-- /ew:body_js_tail -->




<script type="text/javascript">(function() {
  $('#access_urls .btn').click(function(evt){
    evt.preventDefault();
    var parent = $(this).parents('.btn-bar');
    var checkout_cmd = $(this).attr('data-url');
    $(parent).find('input').val(checkout_cmd);
    $(parent).find('span').text($(this).attr('title')+' access');
    $(this).parent().children('.btn').removeClass('active');
    $(this).addClass('active');
    if (checkout_cmd.indexOf(' http://') !== -1 || checkout_cmd.indexOf(' https://') !== -1 ) {
      $('#http-2fa-msg').show();
    } else {
      $('#http-2fa-msg').hide();
    }
  });
  $('#access_urls .btn').first().click();

  
  var repo_status = document.getElementById('repo_status');
  // The repo_status div will only be present if repo.status != 'ready'
  if (repo_status) {
    $('.spinner').show()
    var delay = 500;
    function check_status() {
        $.get('/p/fstabwizard/code/status', function(data) {
            if (data.status === 'ready') {
                $('.spinner').hide()
                $('#repo_status h2').html('Repo status: ready. <a href=".">Click here to refresh this page.</a>');
            }
            else {
                $('#repo_status h2 span').html(data.status);
                if (delay < 60000){
                    delay = delay * 2;
                }
                window.setTimeout(check_status, delay);
            }
        });
    }
    var status_checker = window.setTimeout(check_status, delay);
    
  }
}());
</script>

<script type="text/javascript">(function() {
  $(window).bind('hashchange', function(e) {
    var hash = window.location.hash.substring(1);
	if ('originalEvent' in e && 'oldURL' in e.originalEvent) {
      $('#' + e.originalEvent.oldURL.split('#')[1]).css('background-color', 'transparent');
	}
    if (hash !== '' && hash.substring(0, 1) === 'l' && !isNaN(hash.substring(1))) {
      $('#' + hash).css('background-color', '#ffff99');
    }
  }).trigger('hashchange');

  var clicks = 0;
  $('.code_block').each(function(index, element) {
    $(element).bind('click', function() {
      // Trick to ignore double and triple clicks
      clicks++;
      if (clicks == 1) {
        setTimeout(function() {
          if (clicks == 1) {
            var hash = window.location.hash.substring(1);
            if (hash !== '' && hash.substring(0, 1) === 'l' && !isNaN(hash.substring(1))) {
              $('#' + hash).css('background-color', 'transparent');
            }
            $(element).css('background-color', '#ffff99');
            window.location.href = '#' + $(element).attr('id');
          };
          clicks = 0;
        }, 500);
      };
    });
  });
}());
</script>


    


    
        <script type="text/javascript" src='//consent-st.truste.com/get?name=notice.js&domain=slashdot.org&c=teconsent&text=true'></script>
    
    

<script>
    $(document).ready(function () {
        $(".tooltip").tooltipster({
            animation: 'fade',
            delay: 200,
            theme: 'tooltipster-light',
            trigger: 'hover',
            position: 'right',
            iconCloning: false,
            maxWidth: 300
        }).focus(function () {
            $(this).tooltipster('show');
        }).blur(function () {
            $(this).tooltipster('hide');
        });
    });
</script>
</body>
</html>