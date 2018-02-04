<%@ Page Language="C#" AutoEventWireup="true" CodeFile="NotAuthorized.aspx.cs" Inherits="ErrorPages_NotAuthorized" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style>
        body {
            background: url('../Images/img7.jpg') no-repeat fixed 100%;
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
        <h1>You are not authorized to see this page!</h1>
        <p>We're sorry but you should not be here.</p>
    </div>
    </form>
</body>
</html>
