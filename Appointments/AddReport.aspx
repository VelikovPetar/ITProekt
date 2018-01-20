<%@ Page Language="C#" AutoEventWireup="true" CodeFile="AddReport.aspx.cs" Inherits="Appointments_AddReport" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style type="text/css">
        .auto-style1 {
            width: 100%;
        }
        .auto-style2 {
            width: 133px;
        }
        .auto-style3 {
            width: 133px;
            height: 26px;
        }
        .auto-style4 {
            height: 26px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <h4>Report:</h4>
        <table class="auto-style1">
            <tr>
                <td class="auto-style2">
                    <asp:Label ID="Label1" runat="server" Text="For patient:"></asp:Label>
                </td>
                <td>
                    <asp:Label ID="lblPatientName" runat="server"></asp:Label>
                </td>
            </tr>
            <tr>
                <td class="auto-style2">
                    <asp:Label ID="Label2" runat="server" Text="Performed by:"></asp:Label>
                </td>
                <td>
                    <asp:Label ID="lblDoctorName" runat="server"></asp:Label>
                </td>
            </tr>
            <tr>
                <td class="auto-style3">
                    <asp:Label ID="Label3" runat="server" Text="Held on:"></asp:Label>
                </td>
                <td class="auto-style4">
                    <asp:Label ID="lblDateTime" runat="server"></asp:Label>
                </td>
            </tr>
            <tr>
                <td class="auto-style2">&nbsp;</td>
                <td>&nbsp;</td>
            </tr>
            <tr>
                <td class="auto-style2">
                    <asp:Label ID="Label4" runat="server" Text="Diagnosis:"></asp:Label>
                </td>
                <td>
                    <asp:TextBox ID="txtDiagnosis" runat="server" Height="48px" TextMode="MultiLine" Width="344px"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtDiagnosis" Display="None" ErrorMessage="Diagnosis field cannot be empty!"></asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td class="auto-style2">
                    <asp:Label ID="Label5" runat="server" Text="Therapy:"></asp:Label>
                </td>
                <td>
                    <asp:TextBox ID="txtTherapy" runat="server" Height="48px" TextMode="MultiLine" Width="344px"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtTherapy" Display="None" ErrorMessage="Therapy field cannot be empty!"></asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td class="auto-style2">
                    <asp:Label ID="Label6" runat="server" Text="Remark:"></asp:Label>
                </td>
                <td>
                    <asp:TextBox ID="txtRemark" runat="server" Height="96px" TextMode="MultiLine" Width="344px"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td class="auto-style2">
                    <asp:ValidationSummary ID="ValidationSummary1" runat="server" ForeColor="#CC0000" />
                    <br />
                    <asp:Label ID="lblError" runat="server" ForeColor="#CC0000"></asp:Label>
                </td>
                <td>&nbsp;</td>
            </tr>
            <tr>
                <td class="auto-style2">
                    <asp:Button ID="btnAddReport" runat="server" OnClick="btnAddReport_Click" Text="Add report" />
                </td>
                <td>&nbsp;</td>
            </tr>
        </table>
    </div>
    </form>
</body>
</html>
