<%@ Page Language="C#" AutoEventWireup="true" CodeFile="PatientDetails.aspx.cs" Inherits="Home_PatientDetails" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style type="text/css">
        .auto-style1 {
            width: 100%;
        }

        .auto-style2 {
            width: 192px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div>

            <p>
                <asp:Button ID="btnAssignGp" runat="server" OnClick="btnAssignGp_Click" Text="Assign self as general practioner" />
                <asp:Button ID="btnRemoveGp" runat="server" OnClick="btnRemoveGp_Click" Text="Remove self as general practioner" />
                <asp:Label ID="lblGpInfo" runat="server" ForeColor="#CC0000"></asp:Label>
            </p>
            <h4>Personal info:<asp:Label ID="lblPersonalInfo" runat="server" ForeColor="#CC0000"></asp:Label>
            </h4>

            <table class="auto-style1">
                <tr>
                    <td class="auto-style2">
                        <asp:Label ID="Label1" runat="server" Text="Name:"></asp:Label>
                    </td>
                    <td>
                        <asp:Label ID="lblName" runat="server" Font-Bold="True"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td class="auto-style2">
                        <asp:Label ID="Label2" runat="server" Text="Surname:"></asp:Label>
                    </td>
                    <td>
                        <asp:Label ID="lblSurname" runat="server" Font-Bold="True"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td class="auto-style2">
                        <asp:Label ID="Label3" runat="server" Text="Ssn:"></asp:Label>
                    </td>
                    <td>
                        <asp:Label ID="lblSsn" runat="server" Font-Bold="True"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td class="auto-style2">
                        <asp:Label ID="Label4" runat="server" Text="Address:"></asp:Label>
                    </td>
                    <td>
                        <asp:Label ID="lblAddress" runat="server" Font-Bold="True"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td class="auto-style2">
                        <asp:Label ID="Label5" runat="server" Text="Email:"></asp:Label>
                    </td>
                    <td>
                        <asp:Label ID="lblEmail" runat="server" Font-Bold="True"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td class="auto-style2">
                        <asp:Label ID="Label6" runat="server" Text="Date of birth:"></asp:Label>
                    </td>
                    <td>
                        <asp:Label ID="lblDateOfBirth" runat="server" Font-Bold="True"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td class="auto-style2">
                        <asp:Label ID="Label7" runat="server" Text="General practitioner:"></asp:Label>
                    </td>
                    <td>
                        <asp:Label ID="lblGeneralPractitioner" runat="server" Font-Bold="True"></asp:Label>
                    </td>
                </tr>
            </table>

            <h4>Past appointments:<asp:Label ID="lblPastAppointmentsInfo" runat="server" ForeColor="#CC0000"></asp:Label>
            </h4>
            <p>
                <asp:GridView ID="gvPastAppointments" runat="server" AllowPaging="True" AutoGenerateColumns="False" DataKeyNames="id" OnPageIndexChanging="gvPastAppointments_PageIndexChanging" OnSelectedIndexChanged="gvPastAppointments_SelectedIndexChanged" PageSize="5">
                    <Columns>
                        <asp:BoundField DataField="id" HeaderText="Appointment Id" />
                        <asp:BoundField DataField="date_time" HeaderText="Date and time" />
                        <asp:BoundField DataField="full_name" HeaderText="Doctor" />
                        <asp:CheckBoxField DataField="has_report" HeaderText="Has report" />
                        <asp:CommandField SelectText="Details" ShowSelectButton="True" />
                    </Columns>
                </asp:GridView>
            </p>

            <h4>Upcoming appointments:<asp:Label ID="lblUpcomingAppointmentsInfo" runat="server" ForeColor="#CC0000"></asp:Label>
            </h4>
            <p>
                <asp:GridView ID="gvUpcomingAppointments" runat="server" AllowPaging="True" AutoGenerateColumns="False" DataKeyNames="id" OnPageIndexChanging="gvUpcomingAppointments_PageIndexChanging" OnSelectedIndexChanged="gvUpcomingAppointments_SelectedIndexChanged" PageSize="5">
                    <Columns>
                        <asp:BoundField DataField="id" HeaderText="Appointment Id" />
                        <asp:BoundField DataField="date_time" HeaderText="Date and time" />
                        <asp:BoundField DataField="full_name" HeaderText="Doctor" />
                        <asp:CheckBoxField DataField="has_report" HeaderText="Has report" />
                        <asp:CommandField SelectText="Details" ShowSelectButton="True" />
                    </Columns>
                </asp:GridView>
            </p>
        </div>
    </form>
</body>
</html>
