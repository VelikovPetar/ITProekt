<%@ Page Language="C#" AutoEventWireup="true" CodeFile="GeneralPractitionerHomePage.aspx.cs" Inherits="Home_GeneralPractionerDefaultPage" %>

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
            padding: 10px;
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

        .prtab {
            margin-top: 35px;
            margin-left: 30px;
        }

        tr:nth-child(even) {
            background-color: #f2f2f2;
        }

        tr:nth-child(odd) {
            background-color: #b3d9ff;
        }

        .but1 {
            margin-top: 10px;
        }

        .but2 {
            margin-top: -50px;
        }

        .tabovi {
            background: none;
            border: none;
            font-size: 1.2em;
        }

        .tab-pane {
            font-size: 1.1em;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div id="tabb" class="container">
            <ul class="nav nav-pills">
                <li class="active bt">
                    <a href="#tab1" data-toggle="tab">
                        <asp:Button ID="tabPersonalInfo" class="btn btn-primary tabovi" runat="server" Text="Лични информации" /></a>
                </li>
                <li class="bt">
                    <a href="#tab2" data-toggle="tab">
                        <asp:Button ID="tabGpPatients" class="btn btn-primary tabovi" runat="server" Text="Пациенти" /></a>
                </li>
                <li class="bt">
                    <a href="#tab3" data-toggle="tab">
                        <asp:Button ID="tabFreePatients" class="btn btn-primary tabovi" runat="server" Text="Слободни пациенти" /></a>
                </li>
                <li class="bt">
                    <a href="#tab4" data-toggle="tab">
                        <asp:Button ID="tabAllAppointments" class="btn btn-primary tabovi" runat="server" Text="Прегледи" /></a>
                </li>
            </ul>

            <div class="tab-content clearfix">
                <div class="tab-pane active" id="tab1">
                    <asp:Label ID="Label1" runat="server" Font-Bold="True" Text="Име:"></asp:Label>
                    <asp:Label ID="lblName" runat="server" Font-Bold="True"></asp:Label><br />
                    <asp:Label ID="Label2" runat="server" Font-Bold="True" Text="Презиме:"></asp:Label>
                    <asp:Label ID="lblSurname" runat="server" Font-Bold="True"></asp:Label><br />
                    <asp:Label ID="Label3" runat="server" Font-Bold="True" Text="Е-маил:"></asp:Label>
                    <asp:Label ID="lblEmail" runat="server" Font-Bold="True"></asp:Label>
                    <br />
                    <asp:Label ID="Label4" runat="server" Font-Bold="True" Text="Болница:"></asp:Label>
                    <asp:Label ID="lblHospital" runat="server" Font-Bold="True"></asp:Label>
                    <br />
                    <asp:Label ID="Label5" runat="server" Font-Bold="True" Text="Тип на доктор:"></asp:Label>
                    <asp:Label ID="lblDoctorType" runat="server" Font-Bold="True"></asp:Label>
                </div>
                <div class="tab-pane" id="tab2">
                    <div class="prtab">
                        <div class="row">
                            <asp:Label ID="lblGpPatientsInfo" runat="server" ForeColor="#CC0000"></asp:Label>
                        </div>
                        <div class="row">
                            <asp:GridView ID="gvGpPatients" runat="server" AutoGenerateColumns="False" DataKeyNames="id" OnSelectedIndexChanged="gvGpPatients_SelectedIndexChanged">
                                <Columns>
                                    <asp:BoundField DataField="full_name" HeaderText="Име и презиме" />
                                    <asp:BoundField DataField="ssn" HeaderText="Матичен број" />
                                    <asp:BoundField DataField="email" HeaderText="Е-маил" />
                                    <asp:BoundField DataField="date_of_birth" HeaderText="Датум на раѓање" />
                                    <asp:CommandField SelectText="Детали" ShowSelectButton="True" />
                                </Columns>
                            </asp:GridView>
                        </div>
                    </div>
                </div>
                <div class="tab-pane" id="tab3">
                    <div class="prtab">
                        <div class="row">
                            <asp:Label ID="lblNoGpPatientsInfo" runat="server" ForeColor="#CC0000"></asp:Label>
                        </div>
                        <div class="row">
                            <asp:GridView ID="gvPatientWithoutGp" runat="server" AutoGenerateColumns="False" DataKeyNames="id" OnSelectedIndexChanged="gvPatientWithoutGp_SelectedIndexChanged">
                                <Columns>
                                    <asp:BoundField DataField="full_name" HeaderText="Име и презиме" />
                                    <asp:BoundField DataField="ssn" HeaderText="Матичен број" />
                                    <asp:BoundField DataField="email" HeaderText="Е-маил" />
                                    <asp:BoundField DataField="date_of_birth" HeaderText="Датум на раѓање" />
                                    <asp:CommandField SelectText="Детали" ShowSelectButton="True" />
                                </Columns>
                            </asp:GridView>
                        </div>
                    </div>
                </div>
                <div class="tab-pane" id="tab4">
                    <div class="prtab">
                        <asp:Button ID="btnNewAppointment" class="btn btn-success but2" runat="server" Text="Нов преглед" OnClick="btnNewAppointment_Click" />
                        <asp:Label ID="lblAllAppointmentsInfo" class="pull-right" runat="server" ForeColor="#CC0000"></asp:Label>
                        <asp:GridView ID="gvAllAppointments" runat="server" AutoGenerateColumns="False" DataKeyNames="id" OnSelectedIndexChanged="gvAllAppointments_SelectedIndexChanged">
                            <Columns>
                                <asp:BoundField DataField="full_name" HeaderText="Име и презиме" />
                                <asp:BoundField DataField="ssn" HeaderText="Матичен број" />
                                <asp:BoundField DataField="date_time" HeaderText="Датум и време" />
                                <asp:CommandField SelectText="Детали" ShowSelectButton="True" />
                            </Columns>
                        </asp:GridView>
                    </div>
                </div>
            </div>
            <asp:Button ID="btnSpecialistAppointment" class="btn btn-primary but1" runat="server" Text="Закажете преглед со специјалист" OnClick="btnSpecialistAppointment_Click" />
            <asp:Button ID="btnLogout" CssClass="btn btn-danger but1" runat="server" Text="Одјавете се" OnClick="btnLogout_Click"/>
            <script src="js/jquery.js" type="text/javascript"></script>
            <script src="js/bootstrap.min.js" type="text/javascript"></script>
            <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
            <script src="//maxcdn.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"></script>
    </form>
</body>
</html>
