<%@ Page Language="C#" AutoEventWireup="true" CodeFile="NotLoggedIn.aspx.cs" Inherits="ErrorPages_NotLoggedIn" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous" />
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
        .btn{
            margin-top:20px;
            width:200px;
            height:70px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <div class="jumbotron">
        <h1>You have to be logged in to access this page!</h1>
        <asp:Button ID="btnLogin" runat="server" Text="Log in" CssClass="btn btn-lg btn-info" OnClick="btnLogin_Click" Font-Bold="true" Font-Size="20"/>
    </div>
        
    </form>
</body>
</html>
