<%@ Page Language="C#" AutoEventWireup="true" CodeFile="RegisterGpAppointment.aspx.cs" Inherits="Appointments_RegisterGpAppointment" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server"> 
    <meta charset="UTF-8"/>
    <title>Внеси Преглед</title>
    <link rel="stylesheet" href="css/styleAddApp.css"/>
    <link href="css/bootstrap.min.css" rel="stylesheet"/>
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous" />

    <style>  
        body{
            background: url('Resources/img7.jpg') no-repeat fixed 100%;
            background-size: cover ;
        }
        control-label{
            font-size: 1.3em;
        }
    </style>
</head>

<body>
        <div class="container col-xs-6 col-xs-offset-1">
    <div class="panel panel-primary">
        <div class="panel-heading">
            <h2 style="text-align: left">Внеси информации за прегледот</h2>
        </div>

        <div class="panel-body">
           <div class="row">
               <div class="col-xs-10 col-xs-offset-1">
                  <form class=" form-horizontal" runat="server" id="form1">
                        <asp:Label ID="lblInfo" runat="server" Font-Size="16"/>
                      <div>
                          <asp:Button CssClass="btn btn-info" runat="server" Text="Дома" ID="btnHome" Font-Size="16" CausesValidation="false" OnClick="btnHome_Click"/>
                      </div>
                        <div class="form-group">
                            <asp:Label ID="Label1" class="control-label col-xs-4" runat="server"  Font-Bold="true" Font-Size="16" Text="Избери пациент:" ></asp:Label>
                            <div class="col-xs-8">
                                <asp:DropDownList ID="ddlPatient" class="form-control doktor" Width="300"  Height="40" Font-Size="16" runat="server"></asp:DropDownList>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="ddlPatient" Display="None" ErrorMessage="You must select a patient"></asp:RequiredFieldValidator>
                            </div>
                        </div>

                        <div class="form-group">
                                <asp:Label ID="Label2" class="control-label col-xs-4" runat="server"  Font-Bold="true" Font-Size="16" Text="Избери Датум:"></asp:Label>
                                <div class="col-xs-8">
                                      <asp:TextBox ID="txtDate" runat="server" Width="300"  Height="40" Font-Size="16" TextMode="Date"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtDate" Display="None" ErrorMessage="You must pick a date!"></asp:RequiredFieldValidator>
                                 </div>
                         </div>

                         <div class="form-group">
                               <asp:Label ID="Label3" runat="server" class="control-label col-xs-4"  Font-Bold="true" Font-Size="16" Text="Избери Време:"></asp:Label>
                                <div class="col-xs-8">
                                     <asp:TextBox ID="txtTime" runat="server" Width="300"  Height="40" Font-Size="16"></asp:TextBox>
                                     <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="txtTime" Display="None" ErrorMessage="You must pick a time!"></asp:RequiredFieldValidator>
                                     <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="txtTime" ErrorMessage="RegularExpressionValidator" ValidationExpression="^([0-9]|0[0-9]|1[0-9]|[0-3]):[0-5][0-9]$"></asp:RegularExpressionValidator>
                               </div>
                         </div>

                            
                       <hr/>
                       <div class=" col-xs-6  ">
                            <asp:Button ID="btnSaveAppointment" runat="server" class="btn btn-success btn-block btn-lg"  Font-Bold="true" Font-Size="16"  OnClick="btnSaveAppointment_Click" Text="Зачувај преглед" />
                       </div>
                      
                        <asp:ValidationSummary ID="ValidationSummary1" runat="server" ForeColor="#CC0000" />
                        </form>
                       
                    </div>
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
