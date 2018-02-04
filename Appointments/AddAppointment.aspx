<%@ Page Language="C#" AutoEventWireup="true" CodeFile="AddAppointment.aspx.cs" Inherits="Appointments_AddAppointment" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="UTF-8" />
    <title>Внеси Преглед</title>
    <link href="css/bootstrap.min.css" rel="stylesheet" />
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous" />

    <style>
        .form-group {
            margin-top: 20px;
        }

        .doktor {
            width: 65%;
            text-align: center;
        }

        .container {
            margin-top: 50px;
            height: 100%;
        }

        #iz {
            text-align: center;
        }

        .btn {
            margin-top: 30px;
            margin-right: 20px;
        }

        .panel-body {
        }

        body {
            background: url('../Images/img7.jpg') no-repeat fixed 100%;
            background-size: cover;
        }

        control-label {
            font-size: 1.3em;
        }
    </style>
</head>
<body>
    <div class="container col-xs-6 col-xs-offset-1">
        <div class="panel panel-primary">
            <div class="panel-heading">
                <h2 style="text-align: left">Закажи преглед</h2>
            </div>

            <div class="panel-body">
                <div class="row">
                    <div class="col-xs-10 col-xs-offset-1">
                        <form class=" form-horizontal" runat="server" id="form1">
                            <asp:Label runat="server" ID="lblInfo" Font-Size="16" />

                            <div class="form-group">
                                <asp:Label ID="Label1" class="control-label col-xs-4" runat="server" Font-Bold="true" Font-Size="16" Text="Избери пациент:"></asp:Label>
                                <div class="col-xs-8">
                                    <asp:DropDownList ID="ddlPatient" class="form-control doktor" Font-Bold="true" Font-Size="16" runat="server"></asp:DropDownList>
                                </div>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="ddlPatient" Display="None" ErrorMessage="You must select a patient"></asp:RequiredFieldValidator>
                            </div>

                            <div class="form-group">
                                <asp:Label ID="Label2" class="control-label col-xs-4" runat="server" Font-Bold="true" Font-Size="16" Text="Избери Болница:"></asp:Label>
                                <div class="col-xs-8">
                                    <asp:DropDownList ID="ddlHospital" class="form-control doktor" runat="server" Font-Bold="true" Font-Size="16" AutoPostBack="True" OnSelectedIndexChanged="ddlHospital_SelectedIndexChanged"></asp:DropDownList>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="ddlHospital" Display="None" ErrorMessage="You must select a hospital!"></asp:RequiredFieldValidator>
                                </div>
                            </div>

                            <div class="form-group">
                                <asp:Label ID="Label3" runat="server" class="control-label col-xs-4" Font-Bold="true" Font-Size="16" Text="Избери Доктор:"></asp:Label>
                                <div class="col-xs-8">
                                    <asp:DropDownList ID="ddlDoctor" runat="server" class="form-control doktor" Font-Bold="true" Font-Size="16" AutoPostBack="True" OnSelectedIndexChanged="ddlDoctor_SelectedIndexChanged">
                                    </asp:DropDownList>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="ddlDoctor" Display="None" ErrorMessage="You must select a doctor!"></asp:RequiredFieldValidator>
                                </div>
                            </div>

                            <div class="form-group">
                                <asp:Label ID="Label4" runat="server" class="control-label col-xs-4" Font-Bold="true" Font-Size="16" Text="Избери Датум:"></asp:Label>
                                <div class="col-xs-8">
                                    <asp:DropDownList ID="ddlDate" runat="server" class="form-control doktor" Font-Bold="true" Font-Size="16" AutoPostBack="True" OnSelectedIndexChanged="ddlDate_SelectedIndexChanged">
                                    </asp:DropDownList>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="ddlDate" Display="None" ErrorMessage="You must pick a date!"></asp:RequiredFieldValidator>

                                </div>
                            </div>

                            <div class="form-group">
                                <asp:Label ID="Label5" runat="server" class="control-label col-xs-4" Font-Bold="true" Font-Size="16" Text="Избери Време:"></asp:Label>
                                <div class="col-xs-8">
                                    <asp:DropDownList ID="ddlTime" class="form-control doktor" Font-Bold="true" Font-Size="16" runat="server">
                                    </asp:DropDownList>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ControlToValidate="ddlTime" Display="None" ErrorMessage="You must pick a time!"></asp:RequiredFieldValidator>

                                </div>

                            </div>
                            <div class=" col-xs-6  ">
                                <asp:Button ID="btnMakeAppointment" runat="server" class="btn btn-success btn-block btn-lg" Font-Size="16" Text="Внеси Преглед" OnClick="btnMakeAppointment_Click" />

                            </div>
                            <div class=" col-xs-6  ">
                                <asp:Button ID="btnHome" runat="server" class="btn btn-info btn-block btn-lg" Font-Size="16" Text="Дома" OnClick="btnHome_Click" CausesValidation="false"/>

                            </div>

                            <asp:ValidationSummary ID="ValidationSummary1" runat="server" ForeColor="#CC0000" />
                        </form>

                    </div>
                </div>

                <hr>
            </div>
        </div>
    </div>
    </div>

    <script src="js/jquery.js" type="text/javascript"></script>
    <script src="js/bootstrap.min.js" type="text/javascript"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
    <script src="//maxcdn.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"></script>

</body>
</html>
