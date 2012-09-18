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
        <div class="span2" >
          <div class="thumbnail well" style=" height:300px;">
          <form action="main.do" id="skform">
          <div style="padding:5px 15px;"><h4>My Skills</h4></div>
          <% if (!skills.isEmpty()){%>          
          <ul class="nav nav-list" style="margin-top:10px;">
          	<% for (com.skm.Skill skill: skills){%>
          	<li><label class="checkbox">
  					<input type="checkbox" value="<%=skill.getName()%>" name="skillSel" CHECKED>
					<%= skill.getName()%>
				 </label>
			</li>
			<%}%>
			</ul>
         <p style="padding-top:5px;"> </p>
		  <div style="margin-left:10px;"><a class="btn btn-warning span11" href="javascript:document.skform.submit();">Apply Skills</a>	
         </div>
          <%}%>
          </form>
          </div>
        </div><!--/span-->
        <div class="span10">
        	<h2>Jobs that match your skills</h2>
        	<table class="table cleartop" width="100%">
        	<tbody id="msg-list">
        	<% if (skillJobs.isEmpty()){%>
        	<tr><td colspan=2><center>No jobs found today.</center>
        	</td></tr>
        	<%}else {
			 for (com.skm.SkillJob job: skillJobs){
					String progressStyle="width:" + job.getMatchPercent() + "%;";
				%>
        		<tr><td width="50px"><img src="<%=job.getJob().getCreatorThumbnail()%>" title="<%=job.getJob().getCreatorName()%>"></td>
        		<td><a href="<%=job.getJob().getUrl()%>" target="blank"><%=job.getJob().getTitle()%></a>
        		<div class="progress">
  					<div class="bar" style="<%=progressStyle%>"></div>
				</div>
        		<p><%=job.getJob().getDesc()%></p>
        		<div><a href="<%=job.getJob().getUrl()%>" target="blank" class="btn btn-inverse">Apply For Job</a></div>
        		</td></tr>
        	<%}}%>
		 	</tbody></table>
        </div>
      </div><!--/row-->

      <hr>

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
