<%@ Page Language="C#" AutoEventWireup="true" CodeFile="PatientDetails.aspx.cs" Inherits="Home_PatientDetails" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
        <link href="css/bootstrap.min.css" rel="stylesheet"/>
        <link rel="stylesheet" type="text/css" href="css/pat_details.css"/>
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous"/>
	    <meta charset="utf-8"/>

    <style>
        body {
  padding : 10px ;
  background-image: url('img/img7.jpg');
  background-repeat: no-repeat;
  background-size: 100%
  
}
.container{
  margin-left: 20px;
  margin-top: 25px;
}
.panel-heading div {
  margin-top: -18px;
  font-size: 15px;
}
.panel-title{
  font-size: 1.8em;
}
.panel-heading div span{
  margin-left:5px;
}
.panel-body{
   background-color: #e6f7ff;
}
.pi{
  font-size: 1.3em;
}
hr{
  border-color: #a6a6a6;
  height: 2px;
}
.but3{
  margin-top: -420px;
}
.but4{
  margin-top: -460px;
}

    </style>
</head>
<body>
    <form id="form1" runat="server">
 <div id="tabb" class="container">	
		<div class="row">
			<div class="col-xs-12">
				<div class="panel panel-primary">
					<div class="panel-heading">
						<h3 class="panel-title">Детали за пациентот</h3>
					</div>
					<div class="panel-body">
						<div class="row">	
							<div class="col-xs-6">
								<asp:Label id="pi" runat="server" text="Лични информации:"></asp:Label><asp:Label ID="lblPersonalInfo" runat="server" ForeColor="#CC0000"></asp:Label><br/><br/>
								<asp:Label ID="Label1" runat="server" Text="Име:"></asp:Label>
                                <asp:Label ID="lblName" runat="server" Font-Bold="True"></asp:Label><br />
				          		<asp:Label ID="Label2" runat="server" Text="Презиме:"></asp:Label>
                                <asp:Label ID="lblSurname" runat="server" Font-Bold="True"></asp:Label><br/>
				          		<asp:Label ID="Label3" runat="server" Text="Матичен број:"></asp:Label>
                                <asp:Label ID="lblSsn" runat="server" Font-Bold="True"></asp:Label><br/>
				          		<asp:Label ID="Label4" runat="server" Text="Адреса:"></asp:Label>
                                <asp:Label ID="lblAddress" runat="server" Font-Bold="True"></asp:Label><br/>
				          		<asp:Label ID="Label5" runat="server" Text="Е-маил:"></asp:Label>
                                <asp:Label ID="lblEmail" runat="server" Font-Bold="True"></asp:Label><br/>
				          		<asp:Label ID="Label6" runat="server" Text="Датум на раѓање:"></asp:Label>
                                <asp:Label ID="lblDateOfBirth" runat="server" Font-Bold="True"></asp:Label><br/>
				          		<asp:Label ID="Label7" runat="server" Text="Матичен доктор:"></asp:Label>
                                <asp:Label ID="lblGeneralPractitioner" runat="server" Font-Bold="True"></asp:Label>
				          	</div>
				          	<div class="col-xs-3 col-xs-offset-4">
                                  <asp:Button ID="btnAssignGp" class="btn btn-md btn-success but3" runat="server" OnClick="btnAssignGp_Click" Text="Додади во свои пациенти" />
							</div>
							<div class="col-xs-3 col-xs-offset-7">
                                <asp:Button ID="btnRemoveGp" class="btn btn-md btn-danger but4" runat="server" OnClick="btnRemoveGp_Click" Text="Отстрани од свои пациенти" />
							</div>
                            <div class="col-xs-3 col-xs-offset-10">
                                <asp:Button CssClass="btn btn-info btn4" runat="server" Text="Дома" ID="btnHome" Font-Size="16" CausesValidation="false" OnClick="btnHome_Click" />
                            </div>
                        </div>
						<hr id="hr"/>
						<div class="row">
							<div class="col-xs-6">
								<asp:Label runat="server" class="pi" Text="Минати прегледи:"></asp:Label><asp:Label ID="lblPastAppointmentsInfo" runat="server" ForeColor="#CC0000"></asp:Label><br/><br/>
								 <asp:GridView ID="gvPastAppointments" runat="server" AllowPaging="True" AutoGenerateColumns="False" DataKeyNames="id" OnPageIndexChanging="gvPastAppointments_PageIndexChanging" OnSelectedIndexChanged="gvPastAppointments_SelectedIndexChanged" PageSize="5">
                                    <Columns>
                                        <asp:BoundField DataField="id" HeaderText="Преглед" />
                                        <asp:BoundField DataField="date_time" HeaderText="Датум и време" />
                                        <asp:BoundField DataField="full_name" HeaderText="Доктор" />
                                        <asp:CheckBoxField DataField="has_report" HeaderText="Извештај" />
                                        <asp:CommandField SelectText="Детали" ShowSelectButton="True" />
                                    </Columns>
                                </asp:GridView>
							</div>
							<div class="col-xs-6">
								<asp:Label class="pi" runat="server" Text="Идни прегледи:"></asp:Label><asp:Label ID="lblUpcomingAppointmentsInfo" runat="server" ForeColor="#CC0000"></asp:Label><br/><br/>
								<asp:GridView ID="gvUpcomingAppointments" runat="server" AllowPaging="True" AutoGenerateColumns="False" DataKeyNames="id" OnPageIndexChanging="gvUpcomingAppointments_PageIndexChanging" OnSelectedIndexChanged="gvUpcomingAppointments_SelectedIndexChanged" PageSize="5">
                                    <Columns>
                                        <asp:BoundField DataField="id" HeaderText="Преглед" />
                                        <asp:BoundField DataField="date_time" HeaderText="Датум и време" />
                                        <asp:BoundField DataField="full_name" HeaderText="Доктор" />
                                        <asp:CheckBoxField DataField="has_report" HeaderText="Извештај" />
                                        <asp:CommandField SelectText="Детали" ShowSelectButton="True" />
                                    </Columns>
                                </asp:GridView>
							</div>
						</div>
						<hr>
					</div>
				</div>
				</div>
			</div>
  		</div>
	<script src="js/jquery.js" type="text/javascript"></script>
	  <script src="js/bootstrap.min.js" type="text/javascript"></script>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
	<script src="//maxcdn.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"></script>
    </form>
</body>
</html>