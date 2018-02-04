<%@ Page Language="C#" AutoEventWireup="true" CodeFile="NotLoggedIn.aspx.cs" Inherits="ErrorPages_NotLoggedIn" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous" />
    <style>
        body {
            background: url('../Images/img3.jpg') no-repeat fixed 100%;
            background-size: cover;
        }
        h1 {
            margin-top:200px;
            margin-left:300px
        }
        span {
            background-color: white;
            padding: 10px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <h1><span>You have to be logged in to access this page!</span></h1>
        <p>
            <asp:Button ID="btnLogin" runat="server" OnClick="btnLogin_Click" Text="Најава" CssClass="btn btn-info" Font-Size="16"/>
        </p>
    </div>
    </form>
</body>
</html>
