<%@ Page Language="C#" AutoEventWireup="true" CodeFile="GeneralPractitionerHomePage.aspx.cs" Inherits="Home_GeneralPractionerDefaultPage" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style type="text/css">
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
        <table class="auto-style1">
            <tr>
                <td>
                    <asp:Button ID="tabPersonalInfo" runat="server" BorderStyle="None" CssClass="initial" OnClick="tabPersonalInfo_Click" Text="PersonalInfo" />
                </td>
                <td>
                    <asp:Button ID="tabGpPatients" runat="server" BorderStyle="None" CssClass="initial" OnClick="tabGpPatients_Click" Text="Your patients" />
                </td>
                <td>
                    <asp:Button ID="tabFreePatients" runat="server" BorderStyle="None" CssClass="initial" OnClick="tabFreePatients_Click" Text="Free patients" />
                </td>
                <td>
                    <asp:Button ID="tabAllAppointments" runat="server" BorderStyle="None" CssClass="initial" OnClick="tabAllAppointments_Click" Text="All appointments" />
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
                                        <asp:Label ID="lblName" runat="server"></asp:Label>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="auto-style2">
                                        <asp:Label ID="Label2" runat="server" Text="Surname:"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:Label ID="lblSurname" runat="server"></asp:Label>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="auto-style2">
                                        <asp:Label ID="Label3" runat="server" Text="Email:"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:Label ID="lblEmail" runat="server"></asp:Label>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="auto-style2">
                                        <asp:Label ID="Label4" runat="server" Text="Hospital:"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:Label ID="lblHospital" runat="server"></asp:Label>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="auto-style2">
                                        <asp:Label ID="Label5" runat="server" Text="Doctor type:"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:Label ID="lblDoctorType" runat="server"></asp:Label>
                                    </td>
                                </tr>
                            </table>

                        </asp:View>
                        <asp:View ID="viewGpPatients" runat="server">
                            <h4>Your patients<asp:Label ID="lblGpPatientsInfo" runat="server" ForeColor="#CC0000"></asp:Label></h4>
                            <asp:GridView ID="gvGpPatients" runat="server" AllowPaging="True" AutoGenerateColumns="False" DataKeyNames="id" OnPageIndexChanging="gvGpPatients_PageIndexChanging" OnSelectedIndexChanged="gvGpPatients_SelectedIndexChanged" PageSize="5">
                                <Columns>
                                    <asp:BoundField DataField="full_name" HeaderText="Name and surname" />
                                    <asp:BoundField DataField="ssn" HeaderText="Ssn" />
                                    <asp:BoundField DataField="email" HeaderText="Email" />
                                    <asp:BoundField DataField="date_of_birth" HeaderText="Date of birth" />
                                    <asp:CommandField SelectText="Patient details" ShowSelectButton="True" />
                                </Columns>
                            </asp:GridView>
                        </asp:View>
                        <asp:View ID="viewFreePatients" runat="server">
                            <h4>Patients without general practitioner<asp:Label ID="lblNoGpPatientsInfo" runat="server" ForeColor="#CC0000"></asp:Label>
                            </h4>
                            <p>
                                <asp:GridView ID="gvPatientWithoutGp" runat="server" AllowPaging="True" AutoGenerateColumns="False" DataKeyNames="id" OnPageIndexChanging="gvPatientWithoutGp_PageIndexChanging" OnSelectedIndexChanged="gvPatientWithoutGp_SelectedIndexChanged" PageSize="5">
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
                        <asp:View ID="viewAllAppointments" runat="server">
                            <h4>All appointments<asp:Label ID="lblAllAppointmentsInfo" runat="server" ForeColor="#CC0000"></asp:Label>
                            </h4>
                            <p>
                                <asp:Button ID="btnNewAppointment" runat="server" Text="Enter new appointment" />
                            </p>
                            <p>
                                <asp:GridView ID="gvAllAppointments" runat="server" AllowPaging="True" AutoGenerateColumns="False" DataKeyNames="id" OnPageIndexChanging="gvAllAppointments_PageIndexChanging" OnSelectedIndexChanged="gvAllAppointments_SelectedIndexChanged" PageSize="5">
                                    <Columns>
                                        <asp:BoundField DataField="full_name" HeaderText="Name and surname" />
                                        <asp:BoundField DataField="ssn" HeaderText="Ssn" />
                                        <asp:BoundField DataField="date_time" HeaderText="Date and time" />
                                        <asp:CommandField SelectText="Appointment details" ShowSelectButton="True" />
                                    </Columns>
                                </asp:GridView>
                            </p>
                        </asp:View>
                    </asp:MultiView>
                </td>
            </tr>
        </table>
        <asp:Button ID="btnSpecialistAppointment" runat="server" Text="Make appointment with specialist" />
    </form>
</body>
</html>
