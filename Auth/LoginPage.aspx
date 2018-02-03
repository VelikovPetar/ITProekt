<%@ Page Language="C#" AutoEventWireup="true" EnableEventValidation="false" CodeFile="LoginPage.aspx.cs" Inherits="Auth_LoginPage" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="css/bootstrap.min.css" rel="stylesheet" />
    <link rel="stylesheet" type="text/css" sr="css/start_style.css" />
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous" />
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    <script src="../Scripts/jquery-3.2.1.js" type="text/javascript"></script>
    <meta charset="utf-8" />

    <style>
        body {
            height: 1000px;
            max-width: 100%;
            background-image: url(img/img4.jpg);
            background-size: 100% 100%
        }

        .start {
            text-align: center;
            padding-top: 450px;
        }

        .bt1 {
            margin-left: 72px;
            margin-right: 40px;
            margin-top: -115px;
        }

        .bt2 {
            margin-left: 60px;
            margin-top: -75px;
            color: #3399ff;
        }

        #login {
            padding-top: 50px
        }

            #login .form-wrap {
                display: none;
                width: 30%;
                margin: 0 auto;
                background-color: white;
                border-radius: 15px;
                padding-top: 10px;
                padding-bottom: 20px;
                padding-left: 20px;
                padding-right: 20px;
            }

            #login .form-wrap2 {
                display: none;
                width: 30%;
                margin: 0 auto;
                background-color: white;
                border-radius: 15px;
                padding-top: 10px;
                padding-bottom: 20px;
                padding-left: 20px;
                padding-right: 20px;
            }

            #login .form-wrap3 {
                display: none;
                width: 30%;
                margin: 0 auto;
                background-color: white;
                border-radius: 15px;
                padding-top: 10px;
                padding-bottom: 20px;
                padding-left: 20px;
                padding-right: 20px;
            }

            #login h1 {
                color: #3385ff;
                font-size: 18px;
                text-align: center;
                font-weight: bold;
                padding-bottom: 20px;
            }

            #login .form-group {
                margin-bottom: 25px;
            }

            #login .checkbox {
                margin-bottom: 20px;
                position: relative;
                -webkit-user-select: none;
                -moz-user-select: none;
                -ms-user-select: none;
                -o-user-select: none;
                user-select: none;
            }

                #login .checkbox.show:before {
                    content: '\e013';
                    color: #3385ff;
                    font-size: 17px;
                    margin: 1px 0 0 3px;
                    position: absolute;
                    pointer-events: none;
                    font-family: 'Glyphicons Halflings';
                }

                #login .checkbox .character-checkbox {
                    width: 25px;
                    height: 25px;
                    cursor: pointer;
                    border-radius: 3px;
                    border: 1px solid #ccc;
                    vertical-align: middle;
                    display: inline-block;
                }

                #login .checkbox .label {
                    color: #6d6d6d;
                    font-size: 13px;
                    font-weight: normal;
                }

            #login .btn.btn-custom {
                font-size: 14px;
                margin-bottom: 20px;
            }

            #login .forget {
                font-size: 13px;
                text-align: center;
                display: block;
            }

        .form-control {
            color: #212121;
        }

        .btn-custom {
            color: #fff;
            background-color: #3385ff;
        }

            .btn-custom:hover,
            .btn-custom:focus {
                color: #fff;
            }
    </style>

    <script type="text/javascript">
        $(document).ready(function () {
            $("#najava").click(function () {
                $(".form-wrap").show(1000);
                $("#najava").hide(1000);
                $("#registracija").hide(1000);
                $("#registracija_dok").hide(1000);
            });
            $("#registracija").click(function () {
                $(".form-wrap2").show(1000);
                $("#najava").hide(1000);
                $("#registracija").hide(1000);
                $("#registracija_dok").hide(1000);
            });
            $("#registracija_dok").click(function () {
                $(".form-wrap3").show(1000);
                $("#najava").hide(1000);
                $("#registracija").hide(1000);
            });
            $("#nazad").click(function () {
                $(".form-wrap2").hide(1000);
                $("#najava").show(1000);
                $("#registracija").show(1000);
                $("#registracija_dok").show(1000);
            });
            $("#nazad1").click(function () {
                $(".form-wrap").hide(1000);
                $("#najava").show(1000);
                $("#registracija").show(1000);
                $("#registracija_dok").show(1000);
            });
            $("#nazad2").click(function () {
                $(".form-wrap3").hide(1000);
                $("#najava").show(1000);
                $("#registracija").show(1000);
                $("#registracija_dok").show(1000);
            });
        });



        function getGpsForHospital(hospitalId) {
            $.getJSON("/api/services/GetDoctorsForHospital?hospitalId=" + hospitalId,
                function (data) {
                    console.log(data);
                    $('#ddlGeneralPractioner').find('option').remove();
                    if (data.length == 0) {
                        var option = '<option value="-----">-----</option>';
                        $('#ddlGeneralPractioner').append(option);
                    } else {
                        $.each(data, function (key, value) {
                            var id = value.Id;
                            var name = value.Name;
                            var surname = value.Surname;
                            var option = '<option value="' + id + '">' + "Dr. " + name + " " + surname + '</option>';
                            $('#ddlGeneralPractioner').append(option);
                        });
                    }
                });
        }

        function saveHospitalToHiddenField() {
            var id = $('#ddlGeneralPractioner').find(':selected').val();
            var name = $('#ddlGeneralPractioner').find(':selected').text();
            $('#hiddenFieldDoctorId').val(id);
            $('#hiddenFieldDoctorName').val(name);
        }

        $(document).ready(function () {
            $('#ddlHospitalPatient').change(function () {
                var hospitalId = $('#ddlHospitalPatient').find(':selected').val();
                getGpsForHospital(hospitalId);
            });

            $('#btnRegisterPatient').click(function () {
                console.log("trigs");
                saveHospitalToHiddenField();
            });
        });
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <asp:Label ID="lblInfo" runat="server"></asp:Label>
        <section id="login">
            <div class="container">
                <div class="row">
                    <div class="col-xs-12">
                        <div class="form-wrap">
                            <h1>Најавете се</h1>
                            <%--<form role="form" method="post" id="login-form" autocomplete="off">--%>
                            <div class="form-group">
                                <asp:Label ID="lblEmail" for="email" runat="server" class="sr-only" Text="Email"></asp:Label>
                                <asp:TextBox ID="txtEmail" type="email" name="email" placeholder="Е-маил" class="form-control" runat="server" ValidationGroup="loginGroup"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtEmail" Display="None" ErrorMessage="You must enter email!" ValidationGroup="loginGroup"></asp:RequiredFieldValidator>
                                <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="txtEmail" Display="None" ErrorMessage="You must enter a valid email!" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" ValidationGroup="loginGroup"></asp:RegularExpressionValidator>
                            </div>
                            <div class="form-group">
                                <asp:Label ID="lblPassword" for="key" class="sr-only" runat="server" Text="Password"></asp:Label>
                                <asp:TextBox ID="txtPassword" type="password" name="key" runat="server" class="form-control" placeholder="Лозинка" TextMode="Password" ValidationGroup="loginGroup"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtPassword" Display="None" ErrorMessage="You must enter password!" ValidationGroup="loginGroup"></asp:RequiredFieldValidator>
                            </div>
                            <asp:Button ID="btnLogin" class="btn btn-custom btn-lg btn-block" runat="server" Text="Најава" OnClick="btnLogin_Click" ValidationGroup="loginGroup" />
                            <asp:ValidationSummary ID="ValidationSummary3" runat="server"  ValidationGroup="loginGroup" ForeColor="#CC0000" />
                            
                            <%--</form>--%>
                            <hr>
                            <button class="btn btn-danger btn-sm" id="nazad1"><span class="glyphicon glyphicon-chevron-left">&nbsp;Назад</span></button>
                        </div>
                    </div>
                    <!-- /.col-xs-12 -->
                </div>
                <!-- /.row -->
            </div>
            <!-- /.container -->
        </section>
        <section id="login">
            <div class="container">
                <div class="row">
                    <div class="col-xs-12">
                        <div class="form-wrap2">
                            <h1>Регистрирајте се</h1>
                            <%--<form role="form" method="post" id="login-form1" autocomplete="off">--%>
                            <div class="form-group">
                                <asp:HiddenField ID="hiddenFieldDoctorId" runat="server" />
                                <asp:HiddenField ID="hiddenFieldDoctorName" runat="server" />

                                <asp:Label ID="lblName" for="name" class="sr-only" runat="server" Text="Name"></asp:Label>
                                <asp:TextBox ID="txtNamePatient" ValidationGroup="patientGroup" type="text" name="name" class="form-control" placeholder="Име" runat="server"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator3"  ValidationGroup="patientGroup" runat="server" ControlToValidate="txtNamePatient" Display="None" ErrorMessage="You must enter your name!"></asp:RequiredFieldValidator>
                            </div>
                            <div class="form-group">
                                <asp:Label ID="lblSurname" for="surname" class="sr-only" runat="server" Text="Surname"></asp:Label>
                                <asp:TextBox ID="txtSurnamePatient"  ValidationGroup="patientGroup" type="text" name="surname" class="form-control" placeholder="Презиме" runat="server"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator4" ValidationGroup="patientGroup"  runat="server" ControlToValidate="txtSurnamePatient" Display="None" ErrorMessage="You must enter your surname!"></asp:RequiredFieldValidator>
                            </div>
                            <div class="form-group">
                                <asp:Label ID="lblEmail2" for="email" class="sr-only" runat="server" Text="Email"></asp:Label>
                                <asp:TextBox ID="txtEmailPatient"  ValidationGroup="patientGroup" type="email" name="email" class="form-control" placeholder="Е-маил" runat="server"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator5"  ValidationGroup="patientGroup" runat="server" ControlToValidate="txtEmailPatient" Display="None" ErrorMessage="You must enter your email!"></asp:RequiredFieldValidator>
                                <asp:RegularExpressionValidator ID="RegularExpressionValidator2"  ValidationGroup="patientGroup" runat="server" ControlToValidate="txtEmailPatient" Display="None" ErrorMessage="You must enter a valid email!" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"></asp:RegularExpressionValidator>
                            </div>
                            <div class="form-group">
                                <asp:Label ID="lblDateOfBirth" for="dateOfBirth" class="sr-only" runat="server" Text="Date of birth"></asp:Label>
                                <asp:TextBox ID="txtDateOfBirthPatient"  ValidationGroup="patientGroup" name="DoB" class="form-control" placeholder="Датум на раѓање" runat="server" TextMode="Date"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator6"  ValidationGroup="patientGroup" runat="server" ControlToValidate="txtDateOfBirthPatient" Display="None" ErrorMessage="You must enter your date of birth!"></asp:RequiredFieldValidator>

                            </div>
                            <div class="form-group">
                                <asp:Label ID="lblSsn" for="ssn" class="sr-only" runat="server" Text="SSN"></asp:Label>
                                <asp:TextBox ID="txtSsnPatient" name="ssn"  ValidationGroup="patientGroup" class="form-control" placeholder="Матичен број" runat="server" TextMode="Number"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator7"  ValidationGroup="patientGroup" runat="server" ControlToValidate="txtSsnPatient" Display="None" ErrorMessage="You must enter your SSN!"></asp:RequiredFieldValidator>
                                <asp:RegularExpressionValidator ID="RegularExpressionValidator3"  ValidationGroup="patientGroup" runat="server" ControlToValidate="txtSsnPatient" Display="None" ErrorMessage="You must enter a valid Ssn(13 digits)!" ValidationExpression="^[0-9]{13}$"></asp:RegularExpressionValidator>
                            </div>
                            <div class="form-group">
                                <asp:Label ID="lblPhoneNumber" class="sr-only" runat="server" Text="Phone number"></asp:Label>
                                <asp:TextBox ID="txtPhoneNumberPatient" runat="server" class="form-control" placeholder="Телефонски број"></asp:TextBox>
                            </div>
                            <div class="form-group">
                                <asp:Label ID="lblPassword2" for="key" class="sr-only" runat="server" Text="Password"></asp:Label>
                                <asp:TextBox ID="txtPasswordPatient"  ValidationGroup="patientGroup" name="key" runat="server" class="form-control" placeholder="Лозинка" TextMode="Password"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator8"  ValidationGroup="patientGroup" runat="server" ControlToValidate="txtPasswordPatient" Display="None" ErrorMessage="You must enter a password!"></asp:RequiredFieldValidator>
                            </div>
                            <div class="form-group">
                                <asp:Label ID="lblConfirmPassword" for="key" class="sr-only" runat="server" Text="Confirm password"></asp:Label>
                                <asp:TextBox ID="txtConfirmPasswordPatient"  ValidationGroup="patientGroup" class="form-control" placeholder="Потврди лозинка" runat="server" TextMode="Password"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator9"  ValidationGroup="patientGroup" runat="server" ControlToValidate="txtConfirmPasswordPatient" Display="None" ErrorMessage="You must confirm your password!"></asp:RequiredFieldValidator>
                                <asp:CompareValidator ID="CompareValidator1"  ValidationGroup="patientGroup" runat="server" ControlToCompare="txtPasswordPatient" ControlToValidate="txtConfirmPasswordPatient" Display="None" ErrorMessage="Passwords must match!"></asp:CompareValidator>

                            </div>
                            <div class="form-group">
                                <asp:Label ID="lblHospital" runat="server" Text="Болница"></asp:Label>
                                <asp:DropDownList ID="ddlHospitalPatient" runat="server">
                                </asp:DropDownList>
                            </div>
                            <div class="form-group">
                                <asp:Label ID="lblGeneralPractitioner" runat="server" Text="Матичен доктор"></asp:Label>
                                <asp:DropDownList ID="ddlGeneralPractioner" runat="server">
                                </asp:DropDownList>
                            </div>
                            <asp:Button ID="btnRegisterPatient"  ValidationGroup="patientGroup" class="btn btn-custom btn-lg btn-block" runat="server" OnClick="btnRegisterPatient_Click" Text="Регистрација" />
                            <asp:ValidationSummary ID="ValidationSummary2" runat="server"  ValidationGroup="patientGroup" ForeColor="#CC0000" />
                            
                            <%--</form>--%>
                            <hr>
                            <button class="btn btn-danger btn-sm" id="nazad"><span class="glyphicon glyphicon-chevron-left">&nbsp;Назад</span></button>
                        </div>
                    </div>
                    <!-- /.col-xs-12 -->
                </div>
                <!-- /.row -->
            </div>
            <!-- /.container -->
        </section>
        <section id="login">
            <div class="container">
                <div class="row">
                    <div class="col-xs-12">
                        <div class="form-wrap3">
                            <h1>Регистрирајте се</h1>
                            <%--<form role="form" method="post" id="login-form2" autocomplete="off">--%>
                            <div class="form-group">
                                <asp:Label ID="lblName2" for="name" class="sr-only" runat="server" Text="Name"></asp:Label>
                                <asp:TextBox ID="txtNameDoctor"  ValidationGroup="doctorGroup" name="name" class="form-control" placeholder="Име" runat="server"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator10"  ValidationGroup="doctorGroup" runat="server" ControlToValidate="txtNameDoctor" Display="None" ErrorMessage="You must enter your name!"></asp:RequiredFieldValidator>
                            </div>
                            <div class="form-group">
                                <asp:Label ID="lblSurname2" for="surname" class="sr-only" runat="server" Text="Surname"></asp:Label>
                                <asp:TextBox ID="txtSurnameDoctor"  ValidationGroup="doctorGroup" name="surname" class="form-control" placeholder="Презиме" runat="server"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator11"  ValidationGroup="doctorGroup" runat="server" ControlToValidate="txtSurnameDoctor" Display="None" ErrorMessage="You must enter your surname!"></asp:RequiredFieldValidator>
                            </div>
                            <div class="form-group">
                                <asp:Label ID="lblEmail3" for="email" class="sr-only" runat="server" Text="Email"></asp:Label>
                                <asp:TextBox ID="txtEmailDoctor"  ValidationGroup="doctorGroup" name="email" class="form-control" placeholder="Е-маил" runat="server"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator12"  ValidationGroup="doctorGroup" runat="server" ControlToValidate="txtEmailDoctor" Display="None" ErrorMessage="You must enter your email!"></asp:RequiredFieldValidator>
                                <asp:RegularExpressionValidator ID="RegularExpressionValidator4"  ValidationGroup="doctorGroup" runat="server" ControlToValidate="txtEmailDoctor" Display="None" ErrorMessage="You must enter a valid email!" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"></asp:RegularExpressionValidator>
                            </div>
                            <div class="form-group">
                                <asp:Label ID="lblHospital2" runat="server" Text="Болница"></asp:Label>
                                <asp:DropDownList ID="ddlHospitalDoctor"  ValidationGroup="doctorGroup" runat="server">
                                </asp:DropDownList>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator13"  ValidationGroup="doctorGroup" runat="server" ControlToValidate="ddlHospitalDoctor" Display="None" ErrorMessage="You must select a hospital!"></asp:RequiredFieldValidator>
                            </div>
                            <div class="form-group">
                                <asp:Label ID="lblGeneralPractioner" runat="server" Text="Матичен доктор"></asp:Label>
                                <asp:CheckBox ID="chkIsGeneralPractitioner" runat="server" />
                            </div>
                            <div class="form-group">
                                <asp:Label ID="lblPassword3" for="key" class="sr-only" runat="server" Text="Password"></asp:Label>
                                <asp:TextBox ID="txtPasswordDoctor" ValidationGroup="doctorGroup"  name="key" runat="server" class="form-control" placeholder="Лозинка" TextMode="Password"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator14"  ValidationGroup="doctorGroup" runat="server" ControlToValidate="txtPasswordDoctor" Display="None" ErrorMessage="You must enter a password!"></asp:RequiredFieldValidator>
                            </div>
                            <div class="form-group">
                                <asp:Label ID="lblConfirmPassword2" runat="server" class="sr-only" Text="Confirm Password"></asp:Label>
                                <asp:TextBox ID="txtConfirmPasswordDoctor"  ValidationGroup="doctorGroup" runat="server" class="form-control" placeholder="Потврди лозинка" TextMode="Password"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator15"  ValidationGroup="doctorGroup" runat="server" ControlToValidate="txtConfirmPasswordDoctor" Display="None" ErrorMessage="You must confirm your password!"></asp:RequiredFieldValidator>
                                <asp:CompareValidator ID="CompareValidator2"  ValidationGroup="doctorGroup" runat="server" ControlToCompare="txtPasswordDoctor" ControlToValidate="txtConfirmPasswordDoctor" Display="None" ErrorMessage="Passwords must match!"></asp:CompareValidator>
                            </div>
                            <asp:Button ID="btnRegisterDoctor"  ValidationGroup="doctorGroup" class="btn btn-custom btn-lg btn-block" runat="server" Text="Регистрација" OnClick="btnRegisterDoctor_Click" />
                            <asp:ValidationSummary ID="doctorSummary" runat="server"  ValidationGroup="doctorGroup" ForeColor="#CC0000" />
                            <%--</form>--%>
                            <hr>
                            <button class="btn btn-danger btn-sm" id="nazad2"><span class="glyphicon glyphicon-chevron-left">&nbsp;Назад</span></button>
                        </div>
                    </div>
                    <!-- /.col-xs-12 -->
                </div>
                <!-- /.row -->
            </div>
            <!-- /.container -->
            <div class="container">
                <div class="row">
                    <div class="col-lg-6 col-lg-offset-2 start">
                        <input type="button" class="btn btn-info btn-lg btn-block bt1" id="najava" value="Најавете се" />
                    </div>
                </div>
                <div class="row">
                    <div class="col-lg-9 col-lg-offset-2 start1">
                        <input type="button" class="btn btn-default btn-lg bt2" id="registracija_dok" value="Регистрирајте се -&nbsp; Доктор" />
                        <input type="button" class="btn btn-default btn-lg bt2" id="registracija" value="Регистрирајте се -&nbsp; Пациент" />
                    </div>
                </div>
            </div>
            <script src="js/jquery.js" type="text/javascript"></script>
            <script src="js/bootstrap.min.js" type="text/javascript"></script>
            <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
            <script src="//maxcdn.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"></script>
            <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    </form>
</body>
</html>
