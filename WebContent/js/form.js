$(document).ready(function(){
	$("#addSkill1").click(function(e){
        e.preventDefault();
        $("#addSkillInp").val("");
        $("#addSkillInp").show();
        $("#addSkill1").hide();
	});
	$("#addSkill1Inp").keypress(function(e){
		if (e.keyCode == 13){
			var input = $("#skform input[name=addSkill1Inp]").val();
			$("#skform input[name=ac]").val("add");
			$("#addSkill1").show();
			$("#addSkillInp").hide();
			document.skform.submit();
			
		}
	});

});