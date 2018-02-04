<%@ Page Language="C#" AutoEventWireup="true" CodeFile="NotAuthorized.aspx.cs" Inherits="ErrorPages_NotAuthorized" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
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
            <h1><span>You are not authorized to see this page!</span></h1>
        </div>
    </form>
</body>
</html>
