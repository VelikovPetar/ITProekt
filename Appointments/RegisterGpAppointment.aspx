<%@ Page Language="C#" AutoEventWireup="true" CodeFile="RegisterGpAppointment.aspx.cs" Inherits="Appointments_RegisterGpAppointment" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style type="text/css">
        .auto-style1 {
            width: 100%;
        }
        .auto-style2 {
            width: 138px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <h4>Enter information about your appointment:<asp:Label ID="lblInfo" runat="server"></asp:Label>
        </h4>
        <table class="auto-style1">
            <tr>
                <td class="auto-style2">
                    <asp:Label ID="Label1" runat="server" Text="Patient:"></asp:Label>
                </td>
                <td>
                    <asp:DropDownList ID="ddlPatient" runat="server">
                    </asp:DropDownList>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="ddlPatient" Display="None" ErrorMessage="You must select a patient!"></asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td class="auto-style2">
                    <asp:Label ID="Label2" runat="server" Text="Date:"></asp:Label>
                </td>
                <td>
                    <asp:TextBox ID="txtDate" runat="server" TextMode="Date"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtDate" Display="None" ErrorMessage="You must pick a date!"></asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td class="auto-style2">
                    <asp:Label ID="Label3" runat="server" Text="Time:"></asp:Label>
                </td>
                <td>
                    <asp:TextBox ID="txtTime" runat="server"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="txtTime" Display="None" ErrorMessage="You must pick a time!"></asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="txtTime" ErrorMessage="RegularExpressionValidator" ValidationExpression="^([0-9]|0[0-9]|1[0-9]|[0-3]):[0-5][0-9]$"></asp:RegularExpressionValidator>
                </td>
            </tr>
            <tr>
                <td class="auto-style2">
                    <asp:Button ID="btnSaveAppointment" runat="server" OnClick="btnSaveAppointment_Click" Text="Save appointment" />
                </td>
                <td>&nbsp;</td>
            </tr>
        </table>
    </div>
        <asp:ValidationSummary ID="ValidationSummary1" runat="server" ForeColor="#CC0000" />
    </form>
</body>
</html>
