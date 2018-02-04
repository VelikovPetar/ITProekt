<%@ Page Language="C#" AutoEventWireup="true" CodeFile="PatientHomePage.aspx.cs" Inherits="Home_PatientDefaultPage" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="css/bootstrap.min.css" rel="stylesheet" />
    <link rel="stylesheet" type="text/css" href="../css/hp_mat.css" />
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous" />

    <meta charset="utf-8" />

    <style>
        body {
            background: url('../Images/img1.jpg') no-repeat fixed 100%;
            background-size: cover;
        }

        .container {
            margin-left: 10px;
            margin-top: 80px;
        }

        #exTab1 .tab-content {
            color: white;
            background-color: #428bca;
            padding: 5px 15px;
        }

        #exTab2 h3 {
            color: white;
            background-color: #428bca;
            padding: 5px 15px;
        }

        /* remove border radius for the tab */

        #exTab1 .nav-pills > li > a {
            border-radius: 0;
        }

        /* change border radius for the tab , apply corners on top*/

        #tabb .nav-pills > li > a {
            border-radius: 4px 4px 0 0;
            background-color: #80ccff;
            color: white;
        }

        #tabb .nav-pills > li.active > a {
            background-color: #0099ff;
        }

        #tabb .tab-content {
            background-color: white;
            padding: 5px 15px;
            border-style: solid;
            border-color: #0099ff;
            border-width: 3px;
            border-bottom-left-radius: 10px;
            border-bottom-right-radius: 10px;
        }

        .table {
            border: 1px solid black;
            width: 100%
        }

            .table th {
                border-color: black;
            }

            .table td {
            }

        #table1 td, #table1 th {
            border: 2px inset #999999;
            border-bottom-left-radius: 5px;
        }

        #prtab {
            margin-top: 35px;
            margin-left: 30px;
        }

        tr:nth-child(even) {
            background-color: #f2f2f2;
        }

        tr:nth-child(odd) {
            background-color: #b3d9ff;
        }

        .tabovi {
            background: none;
            border: none;
        }
    </style>

</head>
<body>
    <form runat="server">
        <div id="tabb" class="container">
            <ul class="nav nav-pills">
                <li class="active" id="bt">
                    <a href="#tab1" data-toggle="tab">
                        <asp:Button ID="tabPersonalInfo" runat="server" class="btn btn-primary tabovi" Text="Лични информации"></asp:Button></a>
                </li>
                <li id="bt">
                    <a href="#tab2" data-toggle="tab">
                        <asp:Button ID="tabPastAppointments" runat="server" class="btn btn-primary tabovi" Text="Минати Прегледи"></asp:Button></a>
                </li>
                <li id="bt">
                    <a href="#tab3" data-toggle="tab">
                        <asp:Button ID="tabUpcomingAppointments" runat="server" class="btn btn-primary tabovi" Text="Идни Прегледи"></asp:Button></a>
                </li>
            </ul>

            <div class="tab-content clearfix">
                <div class="tab-pane active" id="tab1">
                    <br />
                    <asp:Label ID="Label1" runat="server" Text="Име:"></asp:Label>
                    <asp:Label ID="lblName" runat="server" Font-Bold="true"></asp:Label>
                    <br />
                    <asp:Label ID="Label2" runat="server" Text="Презиме:"></asp:Label>
                    <asp:Label ID="lblSurname" runat="server" Font-Bold="true"></asp:Label>
                    <br />
                    <asp:Label ID="Label4" runat="server" Text="Матичен број:"></asp:Label>
                    <asp:Label ID="lblSsn" runat="server" Font-Bold="true"></asp:Label>
                    <br />
                    <asp:Label ID="Label6" runat="server" Text="Адреса:"></asp:Label>
                    <asp:Label ID="lblAddress" runat="server" Font-Bold="true"></asp:Label>
                    <br />
                    <asp:Label ID="Label8" runat="server" Text="Е-маил:"></asp:Label>
                    <asp:Label ID="lblEmail" runat="server" Font-Bold="true"></asp:Label>
                    <br />
                    <asp:Label ID="Label10" runat="server" Text="Датум на раѓање:"></asp:Label>
                    <asp:Label ID="lblDateOfBirth" runat="server" Font-Bold="true"></asp:Label>
                    <br />
                    <asp:Label ID="Label12" runat="server" Text="Матичен доктор:"></asp:Label>
                    <asp:Label ID="lblDoctor" runat="server" Font-Bold="true"></asp:Label>
                    <br />

                </div>
                <div class="tab-pane" id="tab2">
                    <div id="prtab">
                        <asp:Label ID="lblPastAppointmentsInfo" runat="server" ForeColor="#CC0000"></asp:Label>

                        <asp:GridView ID="gvPastAppointments" runat="server" AutoGenerateColumns="False" DataKeyNames="id" OnSelectedIndexChanged="gvPastAppointments_SelectedIndexChanged">
                            <Columns>
                                <asp:BoundField DataField="id" HeaderText="Appointment Id" />
                                <asp:BoundField DataField="date_time" HeaderText="Date and time" />
                                <asp:BoundField DataField="full_name" HeaderText="Doctor" />
                                <asp:CheckBoxField DataField="has_report" HeaderText="Report" />
                                <asp:CommandField SelectText="Details" ShowSelectButton="True" />
                            </Columns>
                        </asp:GridView>

                    </div>
                </div>
                <div class="tab-pane" id="tab3">
                    <div id="prtab">
                        <asp:Label ID="lblUpcomingAppointmentsInfo" runat="server" ForeColor="#CC0000"></asp:Label>
                        <asp:GridView ID="gvUpcomingAppointments" runat="server" AutoGenerateColumns="False" OnSelectedIndexChanged="gvUpcomingAppointments_SelectedIndexChanged" DataKeyNames="id">
                            <Columns>
                                <asp:BoundField DataField="id" HeaderText="Appointment Id" />
                                <asp:BoundField DataField="date_time" HeaderText="Date and time" />
                                <asp:BoundField DataField="full_name" HeaderText="Doctor" />
                                <asp:CheckBoxField DataField="has_report" HeaderText="Report" />
                                <asp:CommandField SelectText="Details" ShowSelectButton="True" />
                            </Columns>
                        </asp:GridView>

                    </div>
                </div>
            </div>
        </div>
        <asp:Button ID="btnLogout" CssClass="btn btn-danger but1" runat="server" Text="Одјавете се" OnClick="btnLogout_Click" />

        <script src="js/jquery.js" type="text/javascript"></script>
        <script src="js/bootstrap.min.js" type="text/javascript"></script>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
        <script src="//maxcdn.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"></script>
    </form>
</body>
</html>
