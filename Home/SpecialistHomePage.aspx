<%@ Page Language="C#" AutoEventWireup="true" CodeFile="SpecialistHomePage.aspx.cs" Inherits="Home_SpecialistDefaultPage" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style>
        .auto-style1 {
            width: 100%;
        }

        .initial {
            display: block;
            padding: 4px 18px 4px 18px;
            float: left;
            background: url("../Images/Tab.png") no-repeat right top;
            color: Black;
            font-weight: bold;
        }

            .initial:hover {
                color: White;
                background: url("../Images/TabSelected.png") no-repeat right top;
            }

        .clicked {
            float: left;
            display: block;
            background: url("../Images/TabSelected.png") no-repeat right top;
            padding: 4px 18px 4px 18px;
            color: Black;
            font-weight: bold;
            color: White;
        }

        .auto-style2 {
            width: 162px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <table class="auto-style1">
                <tr>
                    <td>
                        <asp:Button ID="tabPersonalInfo" runat="server" BorderStyle="None" CssClass="initial" Text="Personal Info" OnClick="tabPersonalInfo_Click" />
                    </td>
                    <td>
                        <asp:Button ID="tabPastAppointments" runat="server" BorderStyle="None" CssClass="initial" Text="Past Appointments" OnClick="tabPastAppointments_Click" />
                    </td>
                    <td>
                        <asp:Button ID="tabUpcomingAppointments" runat="server" BorderStyle="None" CssClass="initial" Text="Upcoming appointments" OnClick="tabUpcomingAppointments_Click" />
                    </td>
                    <td>
                        <asp:Button ID="tabAllPatients" runat="server" BorderStyle="None" CssClass="initial" Text="All patients" OnClick="tabAllPatients_Click" />
                    </td>
                </tr>
                <tr>
                    <td colspan="4">
                        <asp:MultiView ID="multiView" runat="server">
                            <asp:View ID="viewPersonalInfo" runat="server">
                                <h4>Personal info</h4>
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
                                        <asp:Label ID="Label3" runat="server" Text="Email:"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:Label ID="lblEmail" runat="server" Font-Bold="True"></asp:Label>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="auto-style2">
                                        <asp:Label ID="Label4" runat="server" Text="Hospital:"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:Label ID="lblHospital" runat="server" Font-Bold="True"></asp:Label>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="auto-style2">
                                        <asp:Label ID="Label5" runat="server" Text="Doctor type:"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:Label ID="lblDoctorType" runat="server" Font-Bold="True"></asp:Label>
                                    </td>
                                </tr>
                            </table>
                            </asp:View>
                            <asp:View ID="viewPastAppointments" runat="server">
                                <h4>Past appointments<asp:Label ID="lblPastAppointmentsInfo" runat="server" ForeColor="#CC0000"></asp:Label>
                                </h4>
                                <p>
                                    <asp:GridView ID="gvPastAppointments" runat="server" AllowPaging="True" AutoGenerateColumns="False" DataKeyNames="id" OnPageIndexChanging="gvPastAppointments_PageIndexChanging" OnSelectedIndexChanged="gvPastAppointments_SelectedIndexChanged" PageSize="5">
                                        <Columns>
                                            <asp:BoundField DataField="full_name" HeaderText="Name and surname" />
                                            <asp:BoundField DataField="ssn" HeaderText="Ssn" />
                                            <asp:BoundField DataField="date_time" HeaderText="Date and time" />
                                            <asp:CommandField SelectText="Appointment details" ShowSelectButton="True" />
                                        </Columns>
                                    </asp:GridView>
                                </p>
                            </asp:View>
                            <asp:View ID="viewUpcomingAppointmets" runat="server">
                                <h4>Upcoming appointments<asp:Label ID="lblUpcomingAppointmentsInfo" runat="server" ForeColor="#CC0000"></asp:Label>
                                </h4>
                                <p>
                                    <asp:GridView ID="gvUpcomingAppointments" runat="server" AllowPaging="True" AutoGenerateColumns="False" DataKeyNames="id" OnPageIndexChanging="gvUpcomingAppointments_PageIndexChanging" OnSelectedIndexChanged="gvUpcomingAppointments_SelectedIndexChanged" PageSize="5">
                                        <Columns>
                                            <asp:BoundField DataField="full_name" HeaderText="Name and surname" />
                                            <asp:BoundField DataField="ssn" HeaderText="Ssn" />
                                            <asp:BoundField DataField="date_time" HeaderText="Date and time" />
                                            <asp:CommandField SelectText="Appointment details" ShowSelectButton="True" />
                                        </Columns>
                                    </asp:GridView>
                                </p>
                            </asp:View>
                            <asp:View ID="viewAllPatients" runat="server">
                                <h4>All patients<asp:Label ID="lblAllPatientsInfo" runat="server" ForeColor="#CC0000"></asp:Label>
                                </h4>
                                <p>
                                    <asp:GridView ID="gvAllPatients" runat="server" AllowPaging="True" AutoGenerateColumns="False" DataKeyNames="id" OnPageIndexChanging="gvAllPatients_PageIndexChanging" OnSelectedIndexChanged="gvAllPatients_SelectedIndexChanged" PageSize="5">
                                        <Columns>
                                            <asp:BoundField DataField="full_name" HeaderText="Name and surname" />
                                            <asp:BoundField DataField="ssn" HeaderText="Ssn" />
                                            <asp:BoundField DataField="email" HeaderText="Email" />
                                            <asp:BoundField DataField="date_of_birth" HeaderText="Date of birth" />
                                            <asp:CommandField SelectText="Patient details" ShowSelectButton="True" />
                                        </Columns>
                                    </asp:GridView>
                                </p>
                            </asp:View>
                        </asp:MultiView>
                    </td>
                </tr>
            </table>
        </div>
    </form>
</body>
</html>
