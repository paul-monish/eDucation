<%@page import="org.postgresql.jdbc.PgResultSet"%>
<%@page import="com.SPASM.DAO.*"%>
<%@page import="java.sql.DriverManager"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.SPASM.model.Teacher"%>
<%@page import="java.sql.*"%>
<%@page import="java.text.*"%>
<%@page import="java.io.*"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">

<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">

<link rel="stylesheet" href="Custom CSS/CreateTeacher.css">

<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<link rel="stylesheet" type="text/css"
	href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
	<style>
	
  	.comment textarea
  	{
  		box-sizing: border-box;
  		border-radius: 0px;
  		padding-top:23px;
  		padding-left:17px;
  		padding-right:17px;
  		font-size: 19px;
  		font-weight:500;
  		font-family:sans-serif;
  	}
  	.comment form div 
  	{
		position: relative;

  	}
  	.comment form div label
  	{
  		
  		position: absolute;
  		top: 15px;
  		left:16px;
  		color: black;
  		font-size: 16px;
  		font-family:sans-serif;
  		transition: .3s;
  		pointer-events: none;
  		
  		
  		
  		
  	}
  	.comment textarea:focus ~ label,.comment textarea:valid ~ label
  	{
  		top:8px;
  		left: 16px;
  		font-size: 12px;
  		font-family:sans-serif;
  		color: gray;
  	

  	}
  
  .bar
  {
  	position: relative;
  	display:block;
  }
  
  .bar:after, .bar:before
  {
  	content:"";
  	width:0;
  	height:1px;
  	bottom:1px;
  	background:black;
  	position: absolute;
  	transition: .5s;
  	
  	
  }
  .bar:before
  {
  	left:50%;
  } .bar:after
  {
  	right:50%;
  }
  .comment textarea:focus ~ .bar:before, .comment textarea:focus ~ .bar:after
  	{
  		width:50%;
  	}
	#children:hover{
	background:#f7f7f7;
	}
	.com:hover{
	background:#f7f7f7;
	}
	
	@media (min-width: 768px) {
  .navbar-nav.navbar-center {
    position: absolute;
    left: 50%;
    transform: translatex(-50%);
  }
}
	</style>

<title><%out.println(request.getParameter("classname"));%></title>
<link rel="icon" type="image/x-icon" href="favicon.ico">
</head>

<body>
<%!int i; int ii; String id;String com;String dt; String title; 
String authorStudent; %>
<% 
//session=request.getSession();
//if((Object)session.getAttribute("classcode")==null)
//{
	
	//response.sendRedirect("JoinClass.jsp");
//}
//out.println(session.getAttribute("classcode"));
%>
	<!-- get session -->
	<%
		if (request.getParameter("code") == null) {
			

		response.sendRedirect("StartingPage.jsp");
		}
	authorStudent=request.getParameter("author");
	System.out.println("author:"+authorStudent);
	%>

<!-- declaration.... -->


		<% Db_Connection  dbconn=new Db_Connection () ;%>
		<%
			
		String code = request.getParameter("code");
		String classname=request.getParameter("classname");
		String section=request.getParameter("section");
		session.setAttribute("classcode", code);
		session.setAttribute("classname", classname);
		System.out.println("classcode in CreateTeacher.jsp:" + code);
		String mailId=request.getParameter("mailId");
		System.out.println("It has"+ mailId+ "session");
		session.setAttribute("mailId", mailId);
		%>
		<!-- creationj of fixed nav bar -->
		
		<nav class="navbar navbar-expand-lg navbar-light bg-light fixed-top "  style="font-family: sans-serif; font-size: 14px; font-weight: 600;">

  <div class="navbar-header">
    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNavDropdown" aria-controls="navbarNavDropdown" aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button>
</div>
  
  

  <div class="collapse navbar-collapse" id="navbarNavDropdown">

    <ul class="nav navbar-nav">
      <li><a class="navbar-brand" href="#">
             <i class="fa fa-graduation-cap text-info" aria-hidden="true"></i>
        <%=classname%>
        </a></li>
  </ul>
    <ul class="nav navbar-nav navbar-center" >
      <li class="nav-item">
        <a class="nav-link" href="CreateStudent.jsp?code=<%out.print(code);%>&classname=<%out.print(classname);%>&author=<%=request.getParameter("author")%>&mailId=<%=mailId%>">Stream</a>
      </li>
      <li class="nav-item">
        <a class="nav-link" href="StudentAssignment.jsp?code=<%out.print(code);%>&classname=<%out.print(classname);%>&author=<%=request.getParameter("author")%>&mailId=<%=mailId%>">Classwork</a>
      </li>
      <li class="nav-item">
        <a class="nav-link" href="PeopleShowInStudent.jsp?code=<%out.print(code);%>&classname=<%out.print(classname);%>&author=<%=request.getParameter("author")%>&mailId=<%=mailId%>">People</a>
      </li>

    </ul>
    <ul class="nav navbar-nav navbar-right ml-auto">
      <li><a class="btn btn-light" href="StartingPage.jsp?mail=<%=mailId%>"><i class="fa fa-2x fa-arrow-circle-left text-info" aria-hidden="true"></i></a></li>
  </ul>
  </div>
</nav>
		
		<!-- end of nav bar -->
	
			
		<div class="container-fluid"> <!-- 1st div.... -->
		
		
		
		<!--database connectivity for select teacher class-->
		
		<%
			String quary = "select * from teacher where classcode=?";
				//Class.forName("com.mysql.cj.jdbc.Driver");
				try {
			//Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/virtualclassroom", "root", "");

			//Db_Connection  dbconn=new Db_Connection () ;
			Connection con= dbconn.Connection();
			
			System.out.println("connected create teacher..");//connection

			PreparedStatement st = con.prepareStatement(quary);
			st.setString(1, code);
			ResultSet rs = st.executeQuery();

			if (!rs.isBeforeFirst()) {
		%>

		<div>
			<%
				out.print("");
			%>
		</div>


		<%
			}
				while (rs.next()) {
		%>
		<div class="container pl-md-5 pr-md-5 ">
			<div class="container  bg-info   shadow-sm first-div-radius p-4"
				id="div1" style="height: 220px;margin-top:86px;">

				<h5 class="text-white">
					<%
						out.println(rs.getString("subject"));
					%>
				</h5>

				<p class="text-white">
					<%
						out.println(rs.getString("section"));
					%>
				</p>

				<div class="d-inline-block">
					<p class="text-white">Class Code</p>
				</div>

				<div class="d-inline-block">
					<p class="text-white">
						<%
							out.println(rs.getString("classcode"));
						%>
						<svg width="2em" height="1em" viewBox="0 0 16 16" class="bi bi-fullscreen" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
  <path fill-rule="evenodd" d="M1.5 1a.5.5 0 0 0-.5.5v4a.5.5 0 0 1-1 0v-4A1.5 1.5 0 0 1 1.5 0h4a.5.5 0 0 1 0 1h-4zM10 .5a.5.5 0 0 1 .5-.5h4A1.5 1.5 0 0 1 16 1.5v4a.5.5 0 0 1-1 0v-4a.5.5 0 0 0-.5-.5h-4a.5.5 0 0 1-.5-.5zM.5 10a.5.5 0 0 1 .5.5v4a.5.5 0 0 0 .5.5h4a.5.5 0 0 1 0 1h-4A1.5 1.5 0 0 1 0 14.5v-4a.5.5 0 0 1 .5-.5zm15 0a.5.5 0 0 1 .5.5v4a1.5 1.5 0 0 1-1.5 1.5h-4a.5.5 0 0 1 0-1h4a.5.5 0 0 0 .5-.5v-4a.5.5 0 0 1 .5-.5z"/>
</svg>
					</p>
				</div>




				<div class="text-center text-white ">

					<div class=" fa fa-chevron-down" id="down-arrow"
						style="cursor: pointer; margin-top: 3vh;"></div>

				</div>

			</div>

                                <!-- end -->
                                
			<div class="container bg-white shadow-sm" id="div2"
				style="display: none;">
				<div class="d-inline-block">
					<p class="text-black font-weight-bold">Subject: </p>
				</div>
				<div class="d-inline-block">
					<p class="text-black ">
						<%
							out.println(rs.getString("subject"));
						%>
					</p>
				</div >
				<br>
				<div class="d-inline-block">
					<p class="text-black font-weight-bold">Teacher Name: </p>
				</div>
				<div class="d-inline-block">
					<p class="text-black">
						<%
							out.println(rs.getString("name"));
						%>
					</p>
				</div>
			</div>
		</div>
		
					 <!-- end -->
		
		<div class="container mt-4 ">
			<div class="row">
				<div class="col-md-3 col-sm-12 pl-md-5">
					<div class="card    d-md-block d-none d-sm-none pl-4 pt-4" style="border-radius:8px; height: 130px;">
						<h6 class=" card-text ">Upcoming</h6>
						<p class=" position-static card-text">No work due soon</p>
						<div class="clearfix ">
							<h6 class="float-right card-text mr-2 " >
								<a href="#" class="text-dark" >View all</a>
							</h6>

						</div>
					</div>
				</div>
 						 <!-- end -->
 						 
				<div class="col-md-9 pr-md-5 col-12 ">
					<div class="card    p-3 "
						style="height: 70px;border-radius: 8px; box-shadow: 0 2px 5px 0 rgba(0, 0, 0, 0.2);" id="text_something">
						
						<span >
						<span class="fa fa-user-circle fa-2x float-left " style="line-height:39px;color:gray;" aria-hidden="true"></span>
						<span class="text-gray  " style="line-height:2vw;margin-left:14px;" >say with your class...</span>
						</span>
						
					</div>
					
					
					
					
					
					
					
						<!--database connectivity for post msg-- "SELECT id,post,date FROM upload WHERE classcode=?"-->
		<%
			String sql ="SELECT name,post,msg_author,document,filename,upload.date,upload.id from upload INNER JOIN teacher ON upload.classcode=teacher.classcode WHERE upload.classcode=?" ;
			
				//Class.forName("com.mysql.cj.jdbc.Driver");
				try {
			//Connection co = DriverManager.getConnection("jdbc:mysql://localhost:3306/virtualclassroom", "root", "");
			//Db_Connection dbconn1=new Db_Connection () ;
			Connection co= dbconn.Connection();
			
			PreparedStatement s=co.prepareStatement(sql);
			
			s.setString(1,code);
		
			ResultSet r=s.executeQuery();
			

			if (!r.isBeforeFirst()) {
		%>

		<div>
			<%
				out.print("");
			%>
		</div>


		<%
			}
		%>
			
			
				<!-- post msg and file upload manupulation in form -->



					<div class="card  p-4 "
						style="display: none; box-shadow: 0 2px 5px 0 rgba(0, 0, 0, 0.2);border-radius: 8px;" id="post_something">
						<p>for</p>
						<div class="container comment">

							<form  method="post" id="comment" name="comment" enctype="multipart/form-data">
								<div class="form-group" >
								<textarea class="form-control" id="comment_post"
									 rows="4" cols="60" name="msg" required="required" 
									style=" resize:none;overflow:hidden;background:#EDEDED;outline:none;border:none;border-bottom:1px solid black;box-shadow: none!important;"></textarea>
									<label>Share with your class</label>
									<div class="bar"></div>
								</div>
								
								<input type="file" name="file_uploaded" id="file" onchange="return fileValidation()" hidden="hidden">
								<!-- --added -->
								<button type="button" id="custom-button" class="btn btn-outline-secondary"><i class="fa fa-paperclip" aria-hidden="true"></i>  Add</button>
								<span id="custom-text">No file chosen, yet.</span>
								<!-- e -->
								<input type="hidden" name="authorName" value="<%=authorStudent %>">
								
							</form>
							<div class="clearfix">
							<button type="submit" class="btn btn-dark float-right ml-3" id="post_btn" name="post_btn" disabled onclick="servletCall('post')" style="box-shadow: none!important;">Post</button>
							<button class="btn btn-light float-right" id="close_btn">close</button>
							</div>
						</div>

					</div>


					<!-- end -->




					<%
						while (r.next()) {
						//text=rs.getString("post");
						i = r.getInt("id");
						
					%>

					<!-- design card for upload msg and file -->
					
					<%//Format f=new SimpleDateFormat("dd-mmm-yyyy");
					//String ss=f.format(r.getDate("date")); %>
					    
					 <div class="card  comment mt-4" id="<%out.println(i);%>" style="border-radius: 8px;">
						<div class="card-header bg-white" style="border-radius:  8px 8px 0px 0px;">
					  
    						
    							<div>
    								<span class="fa fa-user-circle fa-2x float-left " style="line-height:40px;color:gray;" aria-hidden="true"></span>
    								<span class="float-left">
    								<div class="ml-3" style="line-height:21px;"><%out.println(r.getString("msg_author")); %></div>
    								<div class=" ml-3" style="line-height:12px; font-size: 11px;"><%out.println(r.getDate("date").toLocaleString().subSequence(0, 7));%></div>
    								</span>
    							</div>
    							
    							<div class=" float-bottom mt-5">
    							
    						 		<%out.println(r.getString("post"));%>
    						 	</div>
    						 	<% if(r.getBlob("document").length()!=0){
    						 		
    						 				//Clob c=r.getBlob("file");              
    						 				//Reader rea=c.getCharacterStream();
    						 		//FileWriter fw=new FileWriter("d:\\retrivefile.txt");  
    						 		              
    						 		//int i;  
    						 		//while((i=rea.read())!=-1)  
    						 		//fw.write((char)i);  
    						 		              
    						 		//fw.close();  
    						 		//int l=r.getString("filename").length();
    						 	if(r.getString("filename").endsWith("pdf")){
    						 	%>
    						 	
							<a href="view_file.jsp?id=<%out.println(i);%>"
								style="" class="text-decoration-none text-dark">

								<div class="media mt-3 w-50 border rounded ">
									<i
										class=" text-decoration-none fa fa-file-pdf-o fa-4x  border p-1"
										style=""></i>
									<div class="media-body text-truncate mt-3 ml-3">
										
											<%
												out.println(r.getString("filename"));
											%><br>
										pdf

									</div>
								</div>

							</a>
						
							<%
    						 	}
    						 	else if(r.getString("filename").endsWith("docx") || r.getString("filename").endsWith("doc"))
    						 	
    						 	{%>
    						 	
    						 	<a href="view_file.jsp?id=<%out.println(i);%>"
								style="" class="text-decoration-none text-dark">

								<div class="media mt-3 w-50 border rounded ">
									<i
										class=" text-decoration-none fa fa-file-text fa-4x  border p-1"
										style=""></i>
									<div class="media-body text-truncate mt-3 ml-3">
										
											<%
												out.println(r.getString("filename"));
											%><br>
										docx

									</div>
								</div>

							</a>
							
							<%}else if(r.getString("filename").endsWith("txt")) {%>
    						 	
    						 	<a href="view_file.jsp?id=<%out.println(i);%>"
								style="" class="text-decoration-none text-dark">

								<div class="media mt-3 w-50 border rounded ">
									<i
										class=" text-decoration-none fa fa-file-text-o fa-4x  border p-1"
										style=""></i>
									<div class="media-body text-truncate mt-3 ml-3">
										
											<%
												out.println(r.getString("filename"));
											%><br>
										txt

									</div>
								</div>

							</a>
							<%} %>
    						<%  	} %>
    					</div>
    						
    				
    				<!-- view_file.jsp?id="<%//out.println(i);%> -->
						
						
						
				<%!int child_row_count; %>		
						
						
						<!--database connectivity for comment reply-->
		<%
			String sql1 = "SELECT * FROM upload_comment WHERE msg_id=?";
				//String sq="SELECT * FROM upload_comment WHERE id=(select max(id) from upload_comment where msg_id="142")
			try {
			//Connection co1 = DriverManager.getConnection("jdbc:mysql://localhost:3306/virtualclassroom", "root", "");
			//Db_Connection  dbconn2=new Db_Connection () ;
			Connection co1= dbconn.Connection();
			
			PreparedStatement s1=co1.prepareStatement(sql1);
				//PreparedStatement p=co.prepareStatement(sql1);
			s1.setInt(1, i);
			   //p.setString(1,code);
			ResultSet r1=s1.executeQuery();
			    //ResultSet o=p.executeQuery();
		

%>
	
<%
			if (r1.isBeforeFirst()) {
		%>

		<div>
			<%
				//out.print("");
			%>
		</div>


		<%
			//}

			//if(child_row_count==2){
				
			//}else{
			%>
			
			
					<div class=" card-body child-comments "  id="accordionExample"> 
					<%
					//r1.afterLast();
		    		//System.out.println(r1.getString("comment"));
					child_row_count=0;
		    		
		    		
		    		
		    		
		while (r1.next()) {
		%>
						<%//com=r1.getString("comment"); 
						 //dt=r1.getDate("date_cmnt").toLocaleString();
						%>
						
					
					<!-- reply-list -->
								
								<div class="child  collapse in" id="collapse-<%=i%>"  aria-labelledby="heading-<%=i%>" data-parent="#accordionExample"> 
								
    								<span class="fa fa-user-circle fa-2x float-left " style="line-height:40px;color:gray;" aria-hidden="true"></span>
    								<span class="text-left">
    			
    								<div   style="line-height:16px;margin-left:45px;font-size: 13px;"><%=r1.getString("reply_author")%> &nbsp<%out.println(r1.getDate("date_cmnt").toLocaleString().subSequence(0, 7)); %></div>
    								<div  style="line-height:35px;margin-left:45px;"><%out.println(r1.getString("comment")); %>   </div>
    								</span>
    								
    							</div>
    							
    		<%child_row_count++;}
    		
    		
    		%>
    		
    								
    							
					</div>
					<div class=" border-0 " style="">
						<a class=" btn btn-white  ml-3 mb-2 collapsed com " data-toggle="collapse" href="#collapse-<%=i %>" aria-expanded="false" aria-controls="collapse-<%=i %>" style="box-shadow:none;" role="button"   name="<%out.println(i);%>" id="heading-<%=i%>" > <span class="card-text" style="margin:0;"><%out.println(child_row_count);%>class comment</span></a>
					</div>     
							  <!--  	<div class="child" id="<%//out.println(i); %>-C">
									<span class="fa fa-user-circle fa-2x float-left " style="line-height:40px;color:gray;margin-left: 19px;" aria-hidden="true"></span>
    								<span class="text-left">
    			
    									<div   style="line-height:16px;margin-left:64px;font-size: 13px;">Monish Paul &nbsp<%//out.println(dt.subSequence(0, 7)); %></div>
    									<div  style="line-height:35px;margin-left:64px;"><%//out.println(com); %>   </div>
    								</span>
    							</div>-->
    							
    							
    				<% } %>				
					<!-- from for reply -->
					  <div class="card-footer  bg-white rep" style="border-radius:  0px 0px 8px 8px;"> 
    				   <form >
						 <!--   <div class="input-group" >-->
						
						
						  <!--  <textarea class="form-control md-textarea"  aria-label="With textarea" style="height:3vw;border-radius:50px 0px 0px 50px;" id="cmnt" ></textarea>
						  <div class="input-group-prepend  ">  input-group-text  css height:3vw;border-radius:0px 50px 50px 0px;-->
						  <div class="text-center">
    						<a class="btn btn-light btn-block text-primary" value="<%=authorStudent %>" id="reply" name="<%out.println(i); %>" class="link-reply bg-white" role="button" style="">Reply</a>
  						</div>
						
						 </form>
						 
						<!-- <form >
						 <div class="input-group" >
						<div id="first" style="margin-top:30px;">
						<textarea class="form-control md-textarea"  aria-label="With textarea" style="height:3vw;border-radius:50px 0px 0px 50px;" id="cmnt" ></textarea>
						
						<div class="input-group-prepend  ">
						<a class="link-reply input-group-text bg-white" id="reply" name="<%//out.println(i); %>"  style="height:3vw;border-radius:0px 50px 50px 0px;"><i  class="fa fa-paper-plane-o"  id=<%//out.println(rs.getInt("id")); %> aria-hidden="true"></i></a>
						</div>
						</div>
						</form>-->

						</div>
					
					
					
					
				
				</div>
			<%
			
		} catch (Exception e) {
		e.printStackTrace();
		}
		%>	
				
		<!-- end  -->
		
		
		<%} %>
		
		
				<%
			
		} catch (Exception e) {
		e.printStackTrace();
		}
		%>	

			
			
			
			
			
					<!-- assignment -->
		<%
			String quary1 = "select * from assignment where classcode=?";
			
			try {
			Connection con3= dbconn.Connection();
			
			System.out.println("connected create teacher..");//connection

			PreparedStatement st3 = con3.prepareStatement(quary1);
			st3.setString(1, code);
			ResultSet rs3 = st3.executeQuery();

			if (!rs3.isBeforeFirst()) {
	%>
		<div>
		
		<%
				out.print("");
		%>
		</div>
		<%} %>
			<%
			
				while (rs3.next()) {
		%>		<%id=rs3.getString("id") ;
		
				title=rs3.getString("title");
		//if(rs.getString("topic")!=null)
		//{
		%>
		
				<div class="card mt-3 " style="border-radius:8px;overflow:hidden;">
				<a href="StudentAssignmentView.jsp?code=<%out.print(code);%>&classname=<%out.print(classname);%>&author=<%=request.getParameter("author")%>&id=<%=id %>&mailId=<%=mailId%>" class="text-decoration-none" >
					<div class="card-header  bg bg-white p-3 " style="height:73px;">
    				
      					
        					 <span class="float-left ml-1 border rounded-circle pl-2 pr-2 pt-1 pb-1 bg-primary text-light " style="position:relative;">  <svg width="27px" height="2em" viewBox="0 0 16 16" class="bi bi-menu-down " fill="currentColor" xmlns="http://www.w3.org/2000/svg">
  <path fill-rule="evenodd" d="M15 13V4a1 1 0 0 0-1-1h-3.586A2 2 0 0 1 9 2.414l-1-1-1 1A2 2 0 0 1 5.586 3H2a1 1 0 0 0-1 1v9a1 1 0 0 0 1 1h12a1 1 0 0 0 1-1zM2 2a2 2 0 0 0-2 2v9a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V4a2 2 0 0 0-2-2h-3.586a1 1 0 0 1-.707-.293L8.354.354a.5.5 0 0 0-.708 0L6.293 1.707A1 1 0 0 1 5.586 2H2z"/>
  <path fill-rule="evenodd" d="M15 11H1v-1h14v1zm0-4H1V6h14v1zM2 12.5a.5.5 0 0 1 .5-.5h6a.5.5 0 0 1 0 1h-6a.5.5 0 0 1-.5-.5zm0-4a.5.5 0 0 1 .5-.5h11a.5.5 0 0 1 0 1h-11a.5.5 0 0 1-.5-.5zm0-4a.5.5 0 0 1 .5-.5h8a.5.5 0 0 1 0 1h-8a.5.5 0 0 1-.5-.5z"/>
</svg></span>
       	 				<span class="float-left ">
       	 				<div class="text-dark font-weight-bold ml-3 " style=" sans-serif;font-size:15px;position:absolute;">
       	 					<%=rs3.getString("author")%> posted a new assignment: <%=rs3.getString("title") %> 
       	 				</div>
       	 				
       	 				<div class="text-muted ml-3 mt-4" style="font-family: sans-serif;font-size:13px;position:absolute;"><%=rs3.getString("due_date") %> 
       	 					<%=rs3.getString("due_time") %>
       	 					</div>
       	 				</span>
     	 				
    					
    				</div>
    				
    			</a>	<!-- comment assignment student -->
    				
    					<%
			String quary6 = "SELECT * FROM student_assignment_reply WHERE assign_classcode=? and assign_id=?";
			
			try {
			Connection con6= dbconn.Connection();
			
			System.out.println("connected create teacher..");//connection

			PreparedStatement st6 = con6.prepareStatement(quary6);
			st6.setString(1, code);
			st6.setString(2, id);
			ResultSet rs6 = st6.executeQuery();

			if (!rs6.isBeforeFirst()) {
	%>
		<div>
		
		<%
				out.print("");
		%>
		</div>
		<%} %>
		<%ii=0; %>
			<%
			
				while (rs6.next()) {
					//String id=rs3.getString("id") ;
					%>
					
					
					<!-- modal -->
					
					<!-- Button trigger modal -->


<!-- Modal -->
<div class="modal fade" id="staticBackdrop<%=id%>" data-backdrop="static" data-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered  modal-lg">
    <div class="modal-content">
      <div class="modal-header border-0">
        
        
        				<div class="row">
	       	 				<h5 class="modal-title ml-3" id="staticBackdropLabel">Class comments</h5>
	       	 				<div class="col-lg-9 col-md-12 col-sm-12 col-12 mt-2 ">
	       	 						<div class="child  collapses in" id="collapse-<%=id%>"  aria-labelledby="heading-<%=id%>" data-parent="#accordionExample"> 
									
	    								<span class="fa fa-user-circle fa-2x float-left " style="line-height:40px;color:gray;" aria-hidden="true"></span>
	    								<span class="text-left">
	    			
	    								<div   style="line-height:16px;margin-left:45px;font-size: 13px;"><%=rs6.getString("author")%> &nbsp<%out.println(rs6.getDate("date").toLocaleString().subSequence(0, 7)); %></div>
	    								<div  style="line-height:35px;margin-left:45px;"><%out.println(rs6.getString("asign_comment")); %>   </div>
	    								</span>
	    								
	    							</div>
	    							
	       	 				</div>
       	 				</div>
       	 				
        
        
        
        
        <button type="button" class="close" data-dismiss="modal" style="box-shadow:none;!important" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      
      <div class="modal-body">
        	
			
			
			
		    
		    				<form action='StudentAssignmentReplyServlet' method='post' id='comment'>
		       	 				<div class='input-group input-group-sm rounded-lg ml-2 float-left ' style="width: 100%;"> 
		       	 				 <textarea class='form-control ' aria-label='Example text with two button addons' aria-describedby='button-addon3'  style='display:bloxk;resize:none;overflow:hidden;box-shadow:none;!important'  name='assign_comment' id='new-reply' rows='2' ></textarea>
		       	 				 <input type='hidden' name='id' value='<%=id%>'>
		       	 				 <input type='hidden' name='author' value='<%=authorStudent%>'>
		       	 				 <input type='hidden' name='title' value='<%=rs3.getString("title")%>'>
		       	 				  <input type='hidden' name='code' value='<%=code%>'>
		       	 				<div class='input-group-append' id='button-addon3'>
			       					<input type='submit' class='btn btn-primary btn-block'  id='reply-btn' value='Send'  style='box-shadow:none;!important'>
			     				</div>
		       	 				 </div>
	       	 				 </form>
		    
	   
      </div>
    </div>
  </div>
</div>
					
					
					
					
					
					
    				<%ii++;%>
    				
    				
    				
   <%
		
} if(ii>0){%>
<div class="card-footer border-0 bg bg-white" style="">
    	<a href="#staticBackdrop<%=id%>" data-toggle="modal" ><%=ii %> class comment</a>		
 </div>
<% 
}		rs6.close();
			st6.close();
			con6.close();
			} catch (Exception e) {
			e.printStackTrace();
			}
					
%>
</div>
			
				
<%
		//}
}
			rs3.close();
			st3.close();
			con3.close();
			} catch (Exception e) {
			e.printStackTrace();
			}
					
%>
				
					<!-- end of assignment -->			
				
					
					
				
					
					
					<div id ="previous_content" class=" border-muted card mt-4 p-3  "
						style="border-radius:8px; height: 30vh; margin-bottom:12px;">
						<h3 class="card-title">Communicate with your class here</h3>

						<h6 class="card-text">Join and see scheduled announcements</h6>
						<h6 class="card-text">Respond to teacher posts</h6>
					</div>





				</div>

			</div>
	<%
			}
		%>

		</div>

		

<%
			rs.close();
		st.close();
		con.close();
		} catch (Exception e) {
		e.printStackTrace();
		}
		%>
		
		
		
	


		
	

	</div>

</body>

<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

<script src="https://code.jquery.com/jquery-3.5.1.js"
	integrity="sha256-QWo7LDvxbWT2tbbQ97B53yJnYU3WhH/C8ycbRAkjPDc="
	crossorigin="anonymous"></script>

<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>	

	<!-- clint side manupulation using jquery and js.... -->
	
	
<script type="text/javascript">
<!-- --added -->
const realFileBtn = document.getElementById("file");
const customBtn = document.getElementById("custom-button");
const customTxt = document.getElementById("custom-text");

customBtn.addEventListener("click", function() {
  realFileBtn.click();
});

realFileBtn.addEventListener("change", function() {
  if (realFileBtn.value) {
    customTxt.innerHTML = realFileBtn.value.split("\\").pop();
    	//realFileBtn.value.match(
  		      ///[\/\\]([\w\d\s\.\-\(\)]+)$/
  		    //)[1];
  } else {
    customTxt.innerHTML = "No file chosen, yet.";
  }
});



function fileValidation(){
	//alert();
    var fileInput = document.getElementById('file');
    var filePath = fileInput.value;
    var allowedExtensions = /(\.pdf)$/i;
    if(!allowedExtensions.exec(filePath)){
       
        Swal.fire('Oops...', 'Please upload file having extensions .pdf only.!', 'error');
        fileInput.value ='';
        filePath='';
        return false;
    }else{
        	if(fileInput.files[0].size/(1024*1024)>=8){
        		Swal.fire('Oops...', 'File size must be smaller than 8..!', 'error');
        		fileInput.value ='';
                filePath='';
                return false;
        	}
        	else{
        		return true;
        	}
        }
    }
<!-- --end -->
	$(document).ready(function() {

		

	//$(".child-comments").hide();
		//$("a#children").click(function(){
			//var section=$(this).attr("name");
			//alert(section);
			//$("#C"+section).toggle();
			//$(".child-comment").show();
			//$(".child").empty();
			//});
	$("textarea").on("keyup input",function(){
		
		
		var empty1=false;
		$(this).css('height','auto').css('height',this.scrollHeight+(this.offsetHeight-this.clientHeight));

		$("#new-reply").each(function(){
		if($(this).val()=='')
			{
		
				empty1=true;
			}
		});
		if(empty1)
			{
				$('#reply-btn').attr('disabled', 'disabled');
			}
		else{
			$('#reply-btn').removeAttr('disabled');
			}
		
		});								
						
						$("#down-arrow").click(function() {
							$("#down-arrow").addClass("fa fa-chevron-up");
								$("#div2").toggle();
								$("#div1").toggleClass("second-div-radius");
								//$("#down-arrow").toggleClass(" container-fluid > container> text-center> fa fa-chevron-up")
											//$("#up").children('.fa').toggleClass('fa-chevron-up fa-chevron-down');
								
								
										});

						$("#text_something").click(function() {

							$("#post_something").show();
							$("#text_something").hide();
						});

						$("#close_btn").click(function() {

							$("#post_something").hide();
							$("#text_something").show();
						});

						$("#post_btn").click(function() {

							$("#previous_content").remove();
							
						});
						
						$("a#reply").one("click",function() {
							//$(".rep").remove();                                                                                          
							var comCode = $(this).attr("name");
							var parent = $(this).parent();
							var author=$(this).attr("value");
							var data = "<br> <form action='StudentReplyServlet' method='post' id='comment'> <div class='input-group input-group-sm rounded-lg '> <textarea class='form-control ' aria-label='Example text with two button addons' aria-describedby='button-addon3'  style='resize:none;overflow:hidden;box-shadow:none;!important'  name='new-reply' id='new-reply' rows='2' ></textarea><input type='hidden' name='code' value='"+comCode+"'><input type='hidden' name='author' value='"+author+"'><div class='input-group-append' id='button-addon3'><input type='submit' class='btn btn-primary' disabled id='reply-btn' value='Send'  style='box-shadow:none;!important'></div></div></form>";
							parent.append(data);
																	
																	
						    alert(author+comCode);

							//auto increasing of textarea for reply
							$("#new-reply").on("keyup input",function(){
								
								
								var empty1=false;
								$(this).css('height','auto').css('height',this.scrollHeight+(this.offsetHeight-this.clientHeight));

								$("#new-reply").each(function(){
								if($(this).val()=='')
									{
								
										empty1=true;
									}
								});
								if(empty1)
									{
										$('#reply-btn').attr('disabled', 'disabled');
									}
								else{
									$('#reply-btn').removeAttr('disabled');
									}
								
								});								
												
						
						//$("#bo").click(function(){
						//$(".reply_list").css('display','none');
						//});

						});


						//auto increasing of textarea for comment

						$("#comment_post").on("keyup input",function(){
							//var x=$(this).val;
							//alert(x);
							var empty=false;
							$(this).css('height','auto').css('height',this.scrollHeight+(this.offsetHeight-this.clientHeight));

							$("#comment_post").each(function(){
							if($(this).val()=='')
								{
							//document.getElementById("post_btn").disabled=false;
									empty=true;
								}
							});
							if(empty)
								{
									$('#post_btn').attr('disabled', 'disabled');
								}
							else{
								$('#post_btn').removeAttr('disabled');
								}
							
							});

					

					});
		
			//call PostServlet using js
			
			
			function servletCall(methodType)
			{
				
				
				var textarea=document.forms["comment"]["msg"].value;
				if(textarea=="")
					{
						
					//document.getElementById("post_btn").disabled=true;
					}
				else{
					
				document.getElementById("comment").action="StudentPostServlet";
				document.getElementById("comment").method=methodType;
				document.getElementById("comment").submit();
				}
				//var content=document.getElementById("previous_content");
				//content.remove();
				//const parent=previous_content.getElementByTagName("h3");
				//alert(parent);
				//document.getElementById("demo")
				
				}

//function call(type)
//{
	//document.getElementById("post_cmnt").action="PostServlet";
	///document.getElementById("post_cmnt").method=type;
	//document.getElementById("post_cmnt").submit();
	//}

	
</script>

</html>




