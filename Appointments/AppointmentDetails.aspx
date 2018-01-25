<%@ Page Language="C#" AutoEventWireup="true" CodeFile="AppointmentDetails.aspx.cs" Inherits="Appointments_AppointmentDetails" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style type="text/css">
        .auto-style1 {
            width: 100%;
        }

        .auto-style2 {
            width: 215px;
        }

        .auto-style3 {
            width: 216px;
        }

        .auto-style4 {
            width: 60%;
        }

        .auto-style5 {
            width: 216px;
            height: 58px;
        }

        .auto-style6 {
            height: 58px;
            width: 634px;
        }
        .auto-style7 {
            width: 634px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <table class="auto-style1">
                <tr>
                    <td class="auto-style2">
                        <asp:Label ID="Label1" runat="server" Text="Patient name:"></asp:Label>
                    </td>
                    <td>
                        <asp:Label ID="lblPatientName" runat="server"></asp:Label>
                    </td>
                    <td>
                        <asp:Button ID="btnPatientDetails" runat="server" OnClick="btnPatientDetails_Click" Text="Patient details" />
                    </td>
                </tr>
                <tr>
                    <td class="auto-style2">
                        <asp:Label ID="Label2" runat="server" Text="Patient surname:"></asp:Label>
                    </td>
                    <td>
                        <asp:Label ID="lblPatientSurname" runat="server"></asp:Label>
                    </td>
                    <td>
                        &nbsp;</td>
                </tr>
                <tr>
                    <td class="auto-style2">
                        <asp:Label ID="Label3" runat="server" Text="Patient ssn:"></asp:Label>
                    </td>
                    <td>
                        <asp:Label ID="lblPatientSsn" runat="server"></asp:Label>
                    </td>
                    <td>
                        &nbsp;</td>
                </tr>
                <tr>
                    <td class="auto-style2">
                        <asp:Label ID="Label4" runat="server" Text="Doctor name:"></asp:Label>
                    </td>
                    <td>
                        <asp:Label ID="lblDoctorName" runat="server"></asp:Label>
                    </td>
                    <td>
                        &nbsp;</td>
                </tr>
                <tr>
                    <td class="auto-style2">
                        <asp:Label ID="Label5" runat="server" Text="Doctor surname:"></asp:Label>
                    </td>
                    <td>
                        <asp:Label ID="lblDoctorSurname" runat="server"></asp:Label>
                    </td>
                    <td>
                        &nbsp;</td>
                </tr>
                <tr>
                    <td class="auto-style2">
                        <asp:Label ID="Label11" runat="server" Text="Date:"></asp:Label>
                    </td>
                    <td>
                        <asp:Label ID="lblDate" runat="server"></asp:Label>
                    </td>
                    <td>
                        &nbsp;</td>
                </tr>
                <tr>
                    <td class="auto-style2">
                        <asp:Label ID="Label13" runat="server" Text="Time:"></asp:Label>
                    </td>
                    <td>
                        <asp:Label ID="lblTime" runat="server"></asp:Label>
                    </td>
                    <td>
                        &nbsp;</td>
                </tr>
            </table>
            <h4>
                <asp:Label ID="lblReport" runat="server" Text="Report"></asp:Label>
                <asp:Label ID="lblReportInfo" runat="server" ForeColor="#CC0000"></asp:Label>
            </h4>
            <table class="auto-style4" id="tableReport" runat="server">
                <tr>
                    <td class="auto-style3">Diagnosis:</td>
                    <td class="auto-style7">
                        <asp:TextBox ID="txtDiagnosis" runat="server" Height="48px" Width="344px" TextMode="MultiLine" ValidationGroup="ReportGroup"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtDiagnosis" Display="None" ErrorMessage="Diagnosis field cannot be empty!" ForeColor="Black" ValidationGroup="ReportGroup"></asp:RequiredFieldValidator>
                    </td>
                </tr>
                <tr>
                    <td class="auto-style5">Therapy:</td>
                    <td class="auto-style6">
                        <asp:TextBox ID="txtTherapy" runat="server" Height="48px" Width="344px" TextMode="MultiLine" ValidationGroup="ReportGroup"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtTherapy" Display="None" ErrorMessage="Therapy field cannot be empty!" ForeColor="Black" ValidationGroup="ReportGroup"></asp:RequiredFieldValidator>
                    </td>
                </tr>
                <tr>
                    <td class="auto-style3">Remark:</td>
                    <td class="auto-style7">
                        <asp:TextBox ID="txtRemark" runat="server" Height="96px" Width="344px" TextMode="MultiLine" ValidationGroup="ReportGroup"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td class="auto-style3">
                        <asp:ValidationSummary ID="ValidationSummary1" runat="server" ForeColor="#CC0000" ValidationGroup="ReportGroup" />
                    </td>
                    <td class="auto-style7">
                        &nbsp;</td>
                </tr>
            </table>
        </div>
        <asp:Button ID="btnSave" runat="server" OnClick="btnSave_Click" Text="Save changes" ValidationGroup="ReportGroup" />
&nbsp;&nbsp;&nbsp;
        <asp:Button ID="btnDelete" runat="server" OnClick="btnDelete_Click" Text="Delete report" />
        <br />
        <asp:Button ID="btnAdd" runat="server" OnClick="btnAdd_Click" Text="Add report" />
    </form>
</body>
</html>
