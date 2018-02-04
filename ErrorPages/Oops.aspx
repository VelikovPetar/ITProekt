<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Oops.aspx.cs" Inherits="ErrorPages_Oops" %>

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
        <h1>Oops. Something went wrong!</h1>
        <p>We're sorry but it appears the website adress entered was incorrect.</p>
    </div>
    </form>
</body>
</html>
