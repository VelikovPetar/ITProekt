<%@ Page Language="C#" AutoEventWireup="true" CodeFile="PatientHomePage.aspx.cs" Inherits="Home_PatientDefaultPage" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style type="text/css">
        .auto-style1 {
            width: 100%;
            height: 83px;
        }

        .auto-style2 {
            width: 134px;
        }

        .auto-style3 {
            width: 146px;
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

        .auto-style4 {
            width: 100%;
        }

        .auto-style5 {
            width: 142px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div>

            <table class="auto-style1">
                <tr>
                    <td class="auto-style2">
                        <asp:Button ID="tabPersonalInfo" runat="server" Text="Personal Info" CssClass="initial" BorderStyle="None" OnClick="tabPersonalInfo_Click" />
                    </td>
                    <td class="auto-style3">
                        <asp:Button ID="tabPastAppointments" runat="server" Text="Past appointments" CssClass="initial" BorderStyle="None" OnClick="tabPastAppointments_Click" />
                    </td>
                    <td>
                        <asp:Button ID="tabUpcomingAppointments" runat="server" Text="Upcoming appointments" CssClass="initial" BorderStyle="None" OnClick="tabUpcomingAppointments_Click" />
                    </td>
                </tr>
                <tr>
                    <td colspan="3">
                        <asp:MultiView ID="multiView" runat="server">
                            <asp:View ID="viewPersonalInfo" runat="server">
                                <h4>Personal info</h4>
                                <table class="auto-style4">
                                    <tr>
                                        <td class="auto-style5">
                                            <asp:Label ID="Label1" runat="server" Text="Name:"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:Label ID="lblName" runat="server" Font-Bold="true"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="auto-style5">
                                            <asp:Label ID="Label2" runat="server" Text="Surname:"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:Label ID="lblSurname" runat="server" Font-Bold="true"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="auto-style5">
                                            <asp:Label ID="Label3" runat="server" Text="Ssn:"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:Label ID="lblSsn" runat="server" Font-Bold="true"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="auto-style5">
                                            <asp:Label ID="Label4" runat="server" Text="Address:"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:Label ID="lblAddress" runat="server" Font-Bold="true"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="auto-style5">
                                            <asp:Label ID="Label5" runat="server" Text="Email:"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:Label ID="lblEmail" runat="server" Font-Bold="true"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="auto-style5">
                                            <asp:Label ID="Label6" runat="server" Text="Date of birth:"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:Label ID="lblDateOfBirth" runat="server" Font-Bold="true"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="auto-style5">
                                            <asp:Label ID="Label7" runat="server" Text="General practioner:"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:Label ID="lblDoctor" runat="server" Font-Bold="true"></asp:Label>
                                        </td>
                                    </tr>
                                </table>
                            </asp:View>
                            <asp:View ID="viewPastAppointments" runat="server">
                                <h4>Past appointments</h4>
                                <p>
                                    <asp:GridView ID="gvPastAppointments" runat="server" AutoGenerateColumns="False" DataKeyNames="id" OnSelectedIndexChanged="gvPastAppointments_SelectedIndexChanged" AllowPaging="True" OnPageIndexChanging="gvPastAppointments_PageIndexChanging" PageSize="1">
                                        <Columns>
                                            <asp:BoundField DataField="id" HeaderText="Appointment Id" />
                                            <asp:BoundField DataField="date_time" HeaderText="Date and time" />
                                            <asp:BoundField DataField="full_name" HeaderText="Doctor" />
                                            <asp:CheckBoxField DataField="has_report" HeaderText="Report"/>
                                            <asp:CommandField SelectText="Details" ShowSelectButton="True" />
                                        </Columns>
                                    </asp:GridView>
                                </p>
                            </asp:View>
                            <asp:View ID="viewUpcomingAppointments" runat="server">
                                <h4>Upcoming appointments</h4>
                                <p>
                                    <asp:GridView ID="gvUpcomingAppointments" runat="server" AutoGenerateColumns="False" OnSelectedIndexChanged="gvUpcomingAppointments_SelectedIndexChanged" AllowPaging="True" DataKeyNames="id" OnPageIndexChanging="gvUpcomingAppointments_PageIndexChanging" PageSize="1">
                                        <Columns>
                                            <asp:BoundField DataField="id" HeaderText="AppointmentId" />
                                            <asp:BoundField DataField="date_time" HeaderText="Date and time" />
                                            <asp:BoundField DataField="full_name" HeaderText="Doctor" />
                                            <asp:CheckBoxField DataField="has_report" HeaderText="Report" />
                                            <asp:CommandField SelectText="Details" ShowSelectButton="True" />
                                        </Columns>
                                    </asp:GridView>
                                </p>
                            </asp:View>
                        </asp:MultiView>
                    </td>
                </tr>
            </table>

        </div>
        <asp:Label ID="lblInfo" runat="server"></asp:Label>
    </form>
</body>
</html>
