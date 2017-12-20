<%@ Page Language="C#" AutoEventWireup="true" CodeFile="LoginPage.aspx.cs" Inherits="Auth_LoginPage" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style type="text/css">
        .auto-style1 {
            width: 100%;
        }
        .auto-style2 {
            width: 112px;
        }
        .auto-style3 {
            width: 245px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    <h5>You have to be logged in to use the services!</h5>
        <table class="auto-style1">
            <tr>
                <td class="auto-style2">
                    <asp:Label ID="lblEmail" runat="server" Text="Email"></asp:Label>
                </td>
                <td>
                    <asp:TextBox ID="txtEmail" runat="server" ValidationGroup="loginGroup"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtEmail" Display="None" ErrorMessage="You must enter email!" ValidationGroup="loginGroup"></asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="txtEmail" Display="None" ErrorMessage="You must enter a valid email!" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" ValidationGroup="loginGroup"></asp:RegularExpressionValidator>
                </td>
            </tr>
            <tr>
                <td class="auto-style2">
                    <asp:Label ID="lblPassword" runat="server" Text="Password"></asp:Label>
                </td>
                <td>
                    <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" ValidationGroup="loginGroup"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtPassword" Display="None" ErrorMessage="You must enter password!" ValidationGroup="loginGroup"></asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td class="auto-style2">
                    <asp:Button ID="btnLogin" runat="server" Text="Login" OnClick="btnLogin_Click" ValidationGroup="loginGroup" />
                </td>
                <td>&nbsp;</td>
            </tr>
        </table>
    </div>
        <asp:ValidationSummary ID="ValidationSummary1" runat="server" ForeColor="Red" ValidationGroup="loginGroup" />
        <asp:Label ID="lblInfo" runat="server"></asp:Label>
        <br />
        <asp:Label ID="lblQuery" runat="server"></asp:Label>
        <br />
        <table class="auto-style1">
            <tr>
                <td class="auto-style3">
                    <asp:Button ID="btnRegisterPatient" runat="server" OnClick="btnRegisterPatient_Click" Text="Register as Patient" ValidationGroup="noValidationGroup" />
                </td>
                <td>
                    <asp:Button ID="btnRegisterDoctor" runat="server" OnClick="btnRegisterDoctor_Click" Text="Register as Doctor" ValidationGroup="noValidationGroup" />
                </td>
            </tr>
        </table>
    </form>
</body>
</html>

