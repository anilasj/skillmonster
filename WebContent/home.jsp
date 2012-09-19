<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <title>Bootstrap, from Twitter</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="">
    <meta name="author" content="">

    <!-- Le styles -->
    <link href="./css/style.css" rel="stylesheet">
    <link href="./css/tipTip.css" rel="stylesheet">
    <link href="./css/datepicker.css" rel="stylesheet">
    
    <style type="text/css">
      body {
        padding-top: 60px;
        padding-bottom: 40px;
      }
      .sidebar-nav {
        padding: 9px 0; 
      }
      .subsection {
      	padding: 10px 15px;
      	}
      .labelmargin {
      	padding:5px 5px 7px;
      	margin-right:10px;
      	margin-bottom:15px;
      	text-shadow:none;
      }
      .sklmg {background-color:#FFEBC2;color:#331F00;}
      .sklmg-disabled {background-color:#E6E6E6;color:#331F00;}

    </style>
    <link href="./css/bootstrap-responsive.css" rel="stylesheet">
    <style type="text/css">
    	.thumbnails > li {
			width:100%;
			margin-left: 0px;
		}
    </style>
    <!-- Le HTML5 shim, for IE6-8 support of HTML5 elements -->
    <!--[if lt IE 9]>
      <script src="http://html5shim.googlecode.com/svn/trunk/html5.js"></script>
    <![endif]-->

    <!-- Le fav and touch icons -->
    <link rel="shortcut icon" href="./ico/favicon.ico">
    <link rel="apple-touch-icon-precomposed" sizes="144x144" href="./ico/apple-touch-icon-144-precomposed.png">
    <link rel="apple-touch-icon-precomposed" sizes="114x114" href="./ico/apple-touch-icon-114-precomposed.png">
    <link rel="apple-touch-icon-precomposed" sizes="72x72" href="./ico/apple-touch-icon-72-precomposed.png">
    <link rel="apple-touch-icon-precomposed" href="./ico/apple-touch-icon-57-precomposed.png">
    <script src="./js/lib/json2.js"></script>
 	<script src="./js/lib/jquery-1.7.2.min.js"></script>


   </head>
  <body>
  <% com.skm.User user = (com.skm.User) request.getSession().getAttribute("User");
     java.util.List<com.skm.Skill> skills = user.getSkills();
	 java.util.List<com.skm.SkillJob> skillJobs = (java.util.List<com.skm.SkillJob>) request.getSession().getAttribute("SkilledJobs");
	 java.util.List<com.skm.Skill> selSkills = (java.util.List<com.skm.Skill>) request.getAttribute("selSkills");
%>
   <div class="navbar navbar-fixed-top">
      <div class="navbar-inner">
        <div class="container-fluid">
          <a class="brand" href="#">SkillMonster</a>
   
   		<div class="nav pull-right">
          <ul class="dropdown fatmenu">
          <li id="fatli">
          	<a class="btn dropdown-toggle" href="#" id="signIn">
        	<%= user.getFirstName() %> <%= user.getLastName()%></b>
      		</a>
            
          </li>
        </ul>
        </div>  
        </div>
      </div>
    </div>

    <div class="container-fluid">
      <div class="row-fluid">

        <div class="span12">
        	<h3>Your Skills </h3>
        	<section class="subsection">
        		<form action="main.do" id="skform" name="skform">
          		<input type="hidden" name="ac" value="jobs">
        		<% if (!skills.isEmpty()){%>   
        		<% for (com.skm.Skill skill: skills){%>
        		<span class="label labelmargin"> <input type="checkbox" value="<%=skill.getName()%>" name="skillSel" <%=user.doesSkillExist(skill, selSkills)?"CHECKED":""%>>
					<%= skill.getName()%> </span>
        		<%}}%>
        		<a class="btn btn-small" href="#" id="addSkill1"><i class="icon-plus icon-white"></i> Add a Skill</a>
        		<span id="addSkillInp" style="display:none;"><input type="text" name="addSkill1Inp" id="addSkill1Inp" placeholder="Type something..."></span>
        		
        		<a class="btn btn-small btn-warning " href="javascript:document.skform.submit();">Apply Skills</a>
				</form>
        	</section>
        	
            <div style="margin-top:20px;">
        	<h3>Jobs matching your skills</h3>
        	</div>
        	<table class="table cleartop" width="100%">
        	<tbody id="msg-list">
        	<% if (skillJobs.isEmpty()){%>
        	<tr><td colspan=2><center>No jobs found today.</center>
        	</td></tr>
        	<%}else { 
			 int ind= 0;
			 for (com.skm.SkillJob job: skillJobs){
					String progressStyle="width:" + job.getMatchPercent() + "%;";
					String desc = job.getJob().getDesc();
					if (desc != null && desc.length() > 100){
						desc = desc.substring(0, 100) + "...";
					}
				  	if (ind % 4 == 0){
				%>
				<tr><%}%>
				<td><h4><%=job.getJob().getTitle()%></h4>
					<table style="border:none;">
					<tr><td width="10px"><img src="<%=job.getJob().getCreatorThumbnail()%>" title="<%=job.getJob().getCreatorName()%>">
					<p><h3><small><%=job.getMatchPercent()%>%</small></h3></p>
					</td>
					<td><a href="<%=job.getJob().getUrl()%>" target="blank"><%=job.getJob().getCreatorName()%></a>
					<p><%=desc%></p>
					<% for (com.skm.Skill jsk: job.getJob().getSkills()){
						  String style = "label labelmargin sklmg-disabled";
						  if (user.doesSkillExist(jsk, null)){
							style = "label labelmargin label-warning";
						  }
							%>
							<div style="margin-top:10px;"><span class="<%=style%>"><%= jsk.getName()%></span></div>
						<%}%>
					
					<div style="margin-top:15px;"><a href="<%=job.getJob().getUrl()%>" target="blank" class="btn btn-inverse">Apply For Job</a></div>
					</td>
					</tr>
					</table>
				</td>
        		
        		<%if ((ind + 1) % 4 == 0){%>
        		</tr>
				<%}%>
        	<% ind++;}}%>
		 	</tbody></table>
        </div>
      </div><!--/row-->

      <hr>
	<form name="addSkillForm" id="addSkillForm" action="main.do">
		<input type="hidden" name="ac" value="add">
		<input type="hidden" name="skill" value="">
	</form>
      <footer>
        <p>&copy; Company 2012</p>
      </footer>
    </div><!--/.fluid-container-->
	
    <!-- Le javascript
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster -->
   
    <script src="./js/lib/jquery.tipTip.minified.js"></script>
    <script src="./js/lib/jquery.url.js"></script>
    <script src="./js/lib/bootstrap.js"></script>
    <script src="./js/lib/bootstrap-datepicker.js"></script>
    <script src="./js/lib/underscore-min.js"></script>
    <script src="./js/lib/backbone-min.js"></script>
    <script src="./js/lib/backbone-relational.js"></script>
	<script src="./js/lib/moment.min.js"></script>
	<script src="./js/form.js"></script>
 </body>
</html>
