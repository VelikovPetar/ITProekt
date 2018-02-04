<%@ Page Language="C#" AutoEventWireup="true" CodeFile="AppointmentDetails.aspx.cs" Inherits="Appointments_AppointmentDetails" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="UTF-8" />
    <title>Детали за преглед</title>
    <link href="css/bootstrap.min.css" rel="stylesheet" />
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous" />

    <style>
        body {
            background: url('../Images/img7.jpg') no-repeat fixed 100%;
            background-size: cover;
        }

        .container {
            margin-top: 50px;
        }

        .pac {
            margin-left: -80px;
            font-size: 1.2em;
            font-style: oblique;
        }

        .det {
            margin-top: 50px;
            margin-bottom: 50px;
            font-size: 1.5em;
        }

        hr {
            margin-top: 100px;
            margin-bottom: 50px;
        }

        .izvb {
            margin-top: 21px;
        }

        #btnPatientDetails {
            margin-top: 10px;
        }
    </style>
</head>
<body>

    <div class="container col-xs-6 col-xs-offset-1">
        <div class="panel panel-primary">
            <div class="panel-heading">
                <h2 style="text-align: left">Детали за преглед</h2>
            </div>

            <div class="panel-body">
                <div class="row">
                    <div class="col-xs-10 col-xs-offset-1">
                        <form class=" form-horizontal" runat="server" id="form1">
                            <div class="pac">
                                <div class="form-group">
                                    <asp:Label ID="Label1" runat="server" class="control-label col-xs-3" Font-Bold="true" Font-Size="16" Text="Име на пациент:"></asp:Label>
                                    <asp:Label ID="lblPatientName" class="control-label col-xs-3" Font-Bold="true" Font-Size="16" runat="server"></asp:Label>
                                </div>

                                <div class="form-group">
                                    <asp:Label ID="Label2" runat="server" class="control-label col-xs-3" Font-Bold="true" Font-Size="16" Text="Презиме на пациент:"></asp:Label>
                                    <asp:Label ID="lblPatientSurname" class="control-label col-xs-3" Font-Bold="true" Font-Size="16" runat="server"></asp:Label>
                                </div>

                                <div class="form-group">
                                    <asp:Label ID="Label3" runat="server" class="control-label col-xs-3" Font-Bold="true" Font-Size="16" Text="МБР на пациент:"></asp:Label>
                                    <asp:Label ID="lblPatientSsn" class="control-label col-xs-3" Font-Bold="true" Font-Size="16" runat="server"></asp:Label>
                                </div>

                                <div class="form-group">
                                    <asp:Label ID="Label4" runat="server" class="control-label col-xs-3" Font-Bold="true" Font-Size="16" Text="Име на доктор:"></asp:Label>
                                    <asp:Label ID="lblDoctorName" class="control-label col-xs-3" Font-Bold="true" Font-Size="16" runat="server"></asp:Label>
                                </div>

                                <div class="form-group">
                                    <asp:Label ID="Label5" runat="server" class="control-label col-xs-3" Font-Bold="true" Font-Size="16" Text="Презиме на доктор:"></asp:Label>
                                    <asp:Label ID="lblDoctorSurname" class="control-label col-xs-3" Font-Bold="true" Font-Size="16" runat="server"></asp:Label>

                                </div>

                                <div class="form-group">
                                    <asp:Label ID="Label11" class="control-label col-xs-3" runat="server" Font-Bold="true" Font-Size="16" Text="Датум:"></asp:Label>
                                    <asp:Label ID="lblDate" class="control-label col-xs-3" runat="server" Font-Bold="true" Font-Size="16"></asp:Label>
                                </div>

                                <div class="form-group">
                                    <asp:Label ID="Label13" runat="server" class="control-label col-xs-3" Font-Bold="true" Font-Size="16" Text="Време:"></asp:Label>
                                    <asp:Label ID="lblTime" runat="server" class="control-label col-xs-3" Font-Bold="true" Font-Size="16"></asp:Label>
                                </div>

                                <div class="form-group">
                                    <asp:Label ID="lblReport" runat="server" class="control-label col-xs-3" Font-Bold="true" Font-Size="16" Text="Извештај:"></asp:Label>
                                    <asp:Label ID="lblReportInfo" runat="server" class="control-label col-xs-3" Font-Bold="true" Font-Size="16" ForeColor="#CC0000"></asp:Label>
                                </div>
                                <div class=" col-xs-10 col-xs-offset-1 ">
                                    <asp:Button ID="btnPatientDetails" runat="server" OnClick="btnPatientDetails_Click" Font-Size="16" class="btn btn-info btn-lg" Text="Детали на пациент" Font-Italic="False" />
                                </div>

                            </div>
                            <hr />
                            <div class="det" id="tableReport" runat="server">
                                <div class="form-group">
                                    <asp:Label ID="Label7" runat="server" class="control-label col-xs-3" Font-Bold="true" Font-Size="16" Text="Дијагноза:"></asp:Label>
                                    <div class="col-xs-8">
                                        <asp:TextBox ID="txtDiagnosis" runat="server" Rows="4" Height="100px" TextMode="MultiLine" CssClass="TextBox" Width="90%"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtDiagnosis" Display="None" ErrorMessage="Diagnosis field cannot be empty!"></asp:RequiredFieldValidator>
                                    </div>
                                </div>

                                <div class="form-group">
                                    <asp:Label ID="Label6" runat="server" class="control-label col-xs-3" Font-Bold="true" Font-Size="16" Text="Терапија:"></asp:Label>
                                    <div class="col-xs-8">
                                        <asp:TextBox ID="txtTherapy" runat="server" Rows="4" Height="100px" TextMode="MultiLine" CssClass="TextBox" Width="90%"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtTherapy" Display="None" ErrorMessage="Therapy field cannot be empty!"></asp:RequiredFieldValidator>
                                    </div>
                                </div>

                                <div class="form-group">
                                    <asp:Label ID="Label8" runat="server" class="control-label col-xs-3" Font-Bold="true" Font-Size="16" Text="Забелешка:"></asp:Label>
                                    <div class="col-xs-8">
                                        <asp:TextBox ID="txtRemark" runat="server" Rows="7" Height="130px" TextMode="MultiLine" CssClass="TextBox" Width="90%"></asp:TextBox>
                                    </div>
                                </div>

                            </div>
                            <asp:ValidationSummary ID="ValidationSummary" runat="server" ForeColor="#CC0000" />

                            <div class=" col-xs-6  ">
                                <asp:Button ID="btnSave" runat="server" OnClick="btnSave_Click" class="btn btn-success  btn-block btn-lg" Font-Size="16" Text="Зачувај" />
                            </div>
                            <div class=" col-xs-6  ">
                                <asp:Button ID="btnDelete" runat="server" class="btn btn-danger  btn-block btn-lg" Font-Size="16" OnClick="btnDelete_Click" Text="Избриши" />
                            </div>
                            <div class=" col-xs-12 izvb">
                                <asp:Button ID="btnAdd" runat="server" class="btn btn-primary  btn-block btn-lg" Font-Size="16" OnClick="btnAdd_Click" Text="Внеси извештај" />
                            </div>
                            <div class=" col-xs-12 home">
                                <asp:Button ID="btnHome" runat="server" class="btn btn-info  btn-block btn-lg" Font-Size="16" Text="Дома" CausesValidation="false" OnClick="btnHome_Click" />
                            </div>
                        </form>
                    </div>
                </div>

                <hr />
            </div>
        </div>
    </div>

    <script src="js/jquery.js" type="text/javascript"></script>
    <script src="js/bootstrap.min.js" type="text/javascript"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
    <script src="//maxcdn.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"></script>

</body>
</html>
