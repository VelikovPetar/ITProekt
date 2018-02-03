<%@ Page Language="C#" AutoEventWireup="true" CodeFile="AddReport.aspx.cs" Inherits="Appointments_AddReport" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="UTF-8"/>
    <title>Внеси извештај</title>
    <link rel="stylesheet" href="css/styleRep.css"/>
    <link href="css/bootstrap.min.css" rel="stylesheet"/>
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous" />

            <style>
        body{
            background: url('Resources/img7.jpg') no-repeat fixed 100%;
            background-size: cover ;

        }
        .container
        {
            margin-top: 50px;
        }
        .pac{
            margin-left: -100px;
            font-size: 1.2em;
            font-style: oblique;

        }
        .det{
            margin-top: 50px;
            margin-bottom: 50px;

            font-size: 1.5em;
        }
        hr{
            margin-bottom: 50px;
        }

    </style>
</head>
<body>
       <div class="container col-xs-6 col-xs-offset-1">
        <div class="panel panel-primary">
            <div class="panel-heading">
                <h2 style="padding-left:2em">Извештај</h2>
            </div>

            <div class="panel-body">
                <div class="row">
                    <div class="col-xs-10 col-xs-offset-1">
                        <form class=" form-horizontal" runat="server">
                            <asp:Label ID="lblError" runat="server" ForeColor="#CC0000" Font-Size="16"></asp:Label>
                            <div>
                          <asp:Button CssClass="btn btn-info" runat="server" Text="Дома" ID="btnHome" Font-Size="16" OnClick="btnHome_Click" CausesValidation="false"/>
                      </div>
                            <div class="pac">
                                <div class="form-group">
                                    <asp:Label ID="Label1" runat="server" class="control-label col-xs-3 lb" Font-Bold="true" Font-Size="16" Text="Пациент:"></asp:Label>
                                    <asp:Label ID="lblPatientName" class="control-label col-xs-3" Font-Bold="true" Font-Size="16" runat="server"></asp:Label>
                                </div>

                                <div class="form-group">
                                    <asp:Label ID="Label2" runat="server" class="control-label col-xs-3" Font-Bold="true" Font-Size="16" Text="Доктор:"></asp:Label>
                                    <asp:Label ID="lblDoctorName"  class="control-label col-xs-3" Font-Bold="true" Font-Size="16" runat="server"></asp:Label>
                                </div>

                                <div class="form-group">
                                    <asp:Label ID="Label3" runat="server" class="control-label col-xs-3" Font-Bold="true" Font-Size="16" Text="Датум:"></asp:Label>
                                    <asp:Label ID="lblDateTime"  class="control-label col-xs-3" Font-Bold="true" Font-Size="16" runat="server"></asp:Label>
                                </div>
                            </div>
                            <hr/>
                            <div class="det">
                            <div class="form-group">
                                <asp:Label ID="Label4" runat="server"  class="control-label col-xs-3" Font-Bold="true" Font-Size="16" Text="Дијагноза:"></asp:Label>
                                <div class="col-xs-8">
                                     <asp:TextBox ID="txtDiagnosis" runat="server" Rows="4" Height="100px" TextMode="MultiLine" CssClass="TextBox" Width="90%"></asp:TextBox>
                                     <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtDiagnosis" Display="None" ErrorMessage="Diagnosis field cannot be empty!"></asp:RequiredFieldValidator>
                                </div>
                            </div>

                            <div class="form-group">
                                <asp:Label ID="Label5" runat="server" class="control-label col-xs-3" Font-Bold="true" Font-Size="16" Text="Терапија:"></asp:Label>
                                <div class="col-xs-8">
                                    <asp:TextBox ID="txtTherapy" runat="server" Rows="4" Height="100px" TextMode="MultiLine" CssClass="TextBox" Width="90%"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtTherapy" Display="None" ErrorMessage="Therapy field cannot be empty!"></asp:RequiredFieldValidator>
                                 </div>
                            </div>

                            <div class="form-group">
                                <asp:Label ID="Label6" runat="server" class="control-label col-xs-3" Font-Bold="true" Font-Size="16" Text="Забелешка:"></asp:Label>
                                <div class="col-xs-8">
                                    <asp:TextBox ID="txtRemark" runat="server" Rows="6" Height="130px" TextMode="MultiLine" CssClass="TextBox" Width="90%"></asp:TextBox>
                                </div>
                            </div>
                            </div>

                            <asp:ValidationSummary ID="ValidationSummary1" runat="server" ForeColor="#CC0000" />
                            <br />
                        
                        <div class=" col-xs-6  ">
                            <asp:Button ID="btnAddReport" runat="server"  class="btn btn-success  btn-block btn-lg" Font-Size="16" OnClick="btnAddReport_Click" Text="Внеси извештај" />
                        </div>
                        </form>
                    </div>
                </div>

                <hr>
            </div>
        </div>
    </div>


<script src="js/jquery.js" type="text/javascript"></script>
<script src="js/bootstrap.min.js" type="text/javascript"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
<script src="//maxcdn.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"></script>
    
</body>
</html>
