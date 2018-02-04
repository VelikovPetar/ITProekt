<%@ Page Language="C#" AutoEventWireup="true" CodeFile="PageNotFound.aspx.cs" Inherits="ErrorPages_PageNotFound" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style>
        body {
            background: url('../Images/img3.jpg') no-repeat fixed 100%;
            background-size: cover;
        }
        .jumbotron {
            margin-top:150px;
            margin-left:200px;
            padding-left:50px;
            width:50%;
            
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <div class="jumbotron">
        <h1><span>This page does not exist!</span></h1>
        <p>We're sorry but it appears the website adress entered was incorrect.</p>
    </div>
    </form>
</body>
</html>
