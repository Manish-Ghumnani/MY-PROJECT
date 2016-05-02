<%@page errorPage="error.jsp" contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.LinkedList" %>
<jsp:useBean id="sub" scope="page" class="onlineexams.Subject"/>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Manage Subjects</title>
        <link rel="stylesheet" href="allstyles.css"/>

        <script>

            function setSelection()
            {
                var flag;
                if(document.f.bttnSelect.value == "Select All")
                {
                    flag = true;
                    document.f.bttnSelect.value = "UnSelect All"; 
                }
                else
                {
                    flag = false;                        
                    document.f.bttnSelect.value = "Select All"; 
                }

                
                if(document.f.chkBx.length == undefined)              
                {//1 check box
                    document.f.chkBx.checked = flag ;
                }
                else
                {// array of check box
                    var i;
                    for(i =0; i< document.f.chkBx.length; i++)
                    {
                        document.f.chkBx[i].checked = flag;
                    }
                }
            }
            
            
            function check()
            {
                var flag = false;
                
                if(document.f.chkBx.length == undefined)              
                {//1 check box
                    if(document.f.chkBx.checked)
                    {
                        flag = true;
                    }
                }
                else
                {// array of check box
                    var i;
                    for(i =0; i< document.f.chkBx.length; i++)
                    {
                        if(document.f.chkBx[i].checked)
                        {
                            flag = true;
                            break;
                        }
                    }
                }
                if(flag == false)
                {
                    alert("Select A Subject To Delete");
                    return false;
                }
                else
                {
                    return true;                   
                }
            }
        </script>
    </head>
    <body>
    <%
    String userId= "";
    String loginType= "";
    try
    {
        userId = session.getAttribute("userId").toString();
        loginType = session.getAttribute("loginType").toString();
    }
    catch(Exception ex)
    {}
    
    if(userId.length() == 0 || loginType.length() == 0)
    {
        response.sendRedirect("login.jsp");
        return;
    }
    if(!loginType.equalsIgnoreCase("Teacher"))
    {
        response.sendRedirect("login.jsp");
        return;
    }
    
    try
    {
        String ids[] = request.getParameterValues("chkBx");
        if(ids != null)
        {
            //delete these subjects
            sub.deleteSubjects(ids);
        }
    }
    catch(Exception ex)
    {}
    
    %>    
        
    <div id ="outer">
        <div id = "titlebar">
            <jsp:include page="titlebar.jsp"/>
        </div>
        <div id ="navbar">
            <jsp:include page="navbar2.jsp"/>
        </div>
        <div id="pagecontent">
<%
LinkedList<LinkedList<Object>> allSubjects;
LinkedList<Object> current;
LinkedList<String> header;
int i;
boolean flag;

header = sub.getHeader();
allSubjects = sub.getAllSubjects();

if(allSubjects.size() > 0)
{
    out.println("<form name = \"f\" method = \"post\" action = \"manageSubjects.jsp\" onsubmit= \"return check()\" >");
    //table
    out.println("<table width=\"100%\" >");
    //write the header
    out.println("<tr bgcolor = \"#CBCACF\">");
    for(i =0; i< header.size(); i++)
    {
        if(i == 0)
        {
            out.println("<td width=\"15\" > <b>Select</b></td>");            
        }
        else
        {
            out.println("<td> <b>" + header.get(i) +"</b> </td>");
        }
    }
    out.println("</tr>");
    //write the body

    flag = true;
    while(allSubjects.size() > 0)
    {
        current = allSubjects.remove(0);
        if(flag == true)
        {
            out.println("<tr>");
            flag = false;
        }
        else
        {
            out.println("<tr bgcolor= \"#EBEAEF\">");
            flag = true;
        }
        for(i =0; i< current.size(); i++)
        {
            if(i == 0)
            {//checkbox
                out.println("<td> <input type = \"checkbox\" value = \""+ current.get(i).toString()  + "\" name = \"chkBx\" /> </td>");
            }
            else
            {
                out.println("<td> " + current.get(i).toString() + " </td>");
            }
        }
        out.println("</tr>");
    }
    
    out.println("<tr>");
    out.println("<td> <input type = \"button\" name = \"bttnSelect\" value = \"Select All\" onclick = \"setSelection()\"/>  </td>");
    out.println("<td> <input type = \"submit\" name = \"bttnDelete\" value = \"Delete\" />  </td>");
    
    out.println("<tr>");
    //close the table
    out.println("</table>");
    
    
    out.println("</form>");
    
}   

else
{
    out.println("Subjects Not Added");
}

%>            
            
            
        </div>
    </div>  
    </body>
</html>
