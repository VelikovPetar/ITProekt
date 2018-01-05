<%@ Page Language="C#" AutoEventWireup="true" CodeFile="AddAppointment.aspx.cs" Inherits="Appointments_AddAppointment" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style type="text/css">
        .auto-style1 {
            width: 100%;
        }

        .auto-style2 {
            width: 98px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <h4>Add new appointment:<asp:Label ID="lblInfo" runat="server"></asp:Label>
            </h4>
            <table class="auto-style1">
                <tr>
                    <td class="auto-style2">
                        <asp:Label ID="Label1" runat="server" Text="Patient:"></asp:Label>
                    </td>
                    <td>
                        <asp:DropDownList ID="ddlPatient" runat="server">
                        </asp:DropDownList>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="ddlPatient" Display="None" ErrorMessage="You must select a patient"></asp:RequiredFieldValidator>
                    </td>
                </tr>
                <tr>
                    <td class="auto-style2">
                        <asp:Label ID="Label2" runat="server" Text="Hospital:"></asp:Label>
                    </td>
                    <td>
                        <asp:DropDownList ID="ddlHospital" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddlHospital_SelectedIndexChanged">
                        </asp:DropDownList>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="ddlHospital" Display="None" ErrorMessage="You must select a hospital!"></asp:RequiredFieldValidator>
                    </td>
                </tr>
                <tr>
                    <td class="auto-style2">
                        <asp:Label ID="Label3" runat="server" Text="Doctor:"></asp:Label>
                    </td>
                    <td>
                        <asp:DropDownList ID="ddlDoctor" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddlDoctor_SelectedIndexChanged">
                        </asp:DropDownList>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="ddlDoctor" Display="None" ErrorMessage="You must select a doctor!"></asp:RequiredFieldValidator>
                    </td>
                </tr>
                <tr>
                    <td class="auto-style2">
                        <asp:Label ID="Label4" runat="server" Text="Date:"></asp:Label>
                    </td>
                    <td>
                        <asp:DropDownList ID="ddlDate" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddlDate_SelectedIndexChanged">
                        </asp:DropDownList>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="ddlDate" Display="None" ErrorMessage="You must pick a date!"></asp:RequiredFieldValidator>
                    </td>
                </tr>
                <tr>
                    <td class="auto-style2">
                        <asp:Label ID="Label5" runat="server" Text="Time:"></asp:Label>
                    </td>
                    <td>
                        <asp:DropDownList ID="ddlTime" runat="server">
                        </asp:DropDownList>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ControlToValidate="ddlTime" Display="None" ErrorMessage="You must pick a time!"></asp:RequiredFieldValidator>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <asp:Button ID="btnMakeAppointment" runat="server" Text="Make appointment" OnClick="btnMakeAppointment_Click" />
                    </td>
                </tr>
            </table>
        </div>
        <asp:ValidationSummary ID="ValidationSummary1" runat="server" ForeColor="#CC0000" />
    </form>
</body>
</html>
