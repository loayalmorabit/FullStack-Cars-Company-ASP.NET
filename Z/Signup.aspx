<%@ Page Language="C#"  AutoEventWireup="true" CodeBehind="Signup.aspx.cs" Inherits="Z.Signup" %>

<!DOCTYPE html>
<html lang="en">
<head runat="server">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>DealerShop</title>
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Lemonada:wght@400;700&display=swap" rel="stylesheet">
    <style>
        .form-wrapper {
            animation: hideLayer 0.3s ease-out forwards;
        }

        .form-wrapper.is-active {
            animation: showLayer 0.3s ease-in forwards;
        }

        @keyframes showLayer {
            50% {
                z-index: 1;
            }

            100% {
                z-index: 1;
            }
        }

        @keyframes hideLayer {
            0% {
                z-index: 1;
            }

            49.999% {
                z-index: 1;
            }
        }

        .form-login {
            animation: hideLogin 0.3s ease-out forwards;
        }

        .form-wrapper.is-active .form-login {
            animation: showLogin 0.3s ease-in forwards;
        }

        @keyframes showLogin {
            0% {
                background: #d7e7f1;
                transform: translate(40%, 10px);
            }

            50% {
                transform: translate(0, 0);
            }

            100% {
                background-color: #fff;
                transform: translate(35%, -20px);
            }
        }

        @keyframes hideLogin {
            0% {
                background-color: #fff;
                transform: translate(35%, -20px);
            }

            50% {
                transform: translate(0, 0);
            }

            100% {
                background: #d7e7f1;
                transform: translate(40%, 10px);
            }
        }

        .form-signup {
            animation: hideSignup 0.3s ease-out forwards;
        }

        .form-wrapper.is-active .form-signup {
            animation: showSignup 0.3s ease-in forwards;
        }

        @keyframes showSignup {
            0% {
                background: #d7e7f1;
                transform: translate(-40%, 10px) scaleY(.8);
            }

            50% {
                transform: translate(0, 0) scaleY(.8);
            }

            100% {
                background-color: #fff;
                transform: translate(-35%, -20px) scaleY(1);
            }
        }

        @keyframes hideSignup {
            0% {
                background-color: #fff;
                transform: translate(-35%, -20px) scaleY(1);
            }

            50% {
                transform: translate(0, 0) scaleY(.8);
            }

            100% {
                background: #d7e7f1;
                transform: translate(-40%, 10px) scaleY(.8);
            }
        }

        .form-wrapper.is-active fieldset {
            opacity: 1;
            transform: translateX(0);
            transition: opacity 0.4s ease-in, transform 0.35s ease-in;
        }

        .form [type='submit'] {
            opacity: 0;
            transition: all 0.3s ease-out;
        }

        .form-wrapper.is-active .form [type='submit'] {
            opacity: 1;
            transform: translateX(0);
            transition: all 0.4s ease-in;
        }

        .form-login fieldset {
            transform: translateX(-50%);
        }

        .form-signup fieldset {
            transform: translateX(50%);
        }

        .section-title {
            font-family: 'Lemonada', sans-serif;
        }

    </style>
</head>

<body class="bg-gray-900 text-white min-h-screen flex items-center justify-center">
    <form id="form1" runat="server">
        <section class="forms-section flex flex-col items-center">
            <h1 class="section-title text-4xl font-semibold">! المرابط والمهايني ديلر شوب</h1>
            <div class="forms flex mt-8">
                <div class="form-wrapper is-active">
                    <button type="button" class="switcher switcher-login uppercase block mx-auto mb-20 text-lg text-gray-500 transition-all duration-300 ease-out transform">
                        Login
                    </button>
                    <asp:Panel ID="LoginPanel" runat="server" CssClass="form form-login bg-white p-8 rounded shadow-lg transform-origin-top">
                        <fieldset class="opacity-0 transform transition-all duration-300 ease-out">
                            <legend class="sr-only">Please, enter your email and password for login.</legend>
                            <div class="input-block mb-4">
                                <label for="login-email" class="block text-sm text-gray-700">E-mail</label>
                                <asp:TextBox ID="LoginEmail" runat="server" CssClass="w-full mt-2 p-2 border border-gray-300 rounded focus:outline-none focus:ring-2 focus:ring-indigo-500 text-black" TextMode="Email" />
                                <asp:RequiredFieldValidator ID="LoginEmailRequired" runat="server" ControlToValidate="LoginEmail" ErrorMessage="Email is required" CssClass="text-red-500" ValidationGroup="Login" />
                                <asp:RegularExpressionValidator ID="LoginEmailRegEx" runat="server" ControlToValidate="LoginEmail" ErrorMessage="Invalid email format" CssClass="text-red-500" ValidationExpression="\w+@[a-zA-Z_]+?\.[a-zA-Z]{2,3}" ValidationGroup="Login" />
                            </div>
                            <div class="input-block mb-4">
                                <label for="login-password" class="block text-sm text-gray-700">Password</label>
                                <asp:TextBox ID="LoginPassword" runat="server" CssClass="w-full mt-2 p-2 border border-gray-300 rounded focus:outline-none focus:ring-2 focus:ring-indigo-500 text-black" TextMode="Password" />
                                <asp:RequiredFieldValidator ID="LoginPasswordRequired" runat="server" ControlToValidate="LoginPassword" ErrorMessage="Password is required" CssClass="text-red-500" ValidationGroup="Login" />
                            </div>
                        </fieldset>
                        <asp:Label ID="ErrorMessage" runat="server" CssClass="text-red-500 mt-4" />
                        <asp:Button ID="LoginButton" runat="server" CssClass="btn-login bg-green-500 text-white py-2 px-4 rounded mt-4 transform transition-transform duration-300 ease-out" Text="Login" OnClick="LoginButton_Click" ValidationGroup="Login" />
                    </asp:Panel>
                </div>
                <div class="form-wrapper">
                    <button type="button" class="switcher switcher-signup uppercase block mx-auto mb-20 text-lg text-gray-500 transition-all duration-300 ease-out transform">
                        Sign Up
                    </button>
                    <asp:Panel ID="SignupPanel" runat="server" CssClass="form form-signup bg-white p-8 rounded shadow-lg transform-origin-top">
                        <fieldset class="opacity-0 transform transition-all duration-300 ease-out">
                            <legend class="sr-only">Please, enter your email, password and password confirmation for sign up.</legend>
                            <div class="input-block mb-4">
                                <label for="signup-username" class="block text-sm text-gray-700">Username</label>
                                <asp:TextBox ID="SignupUsername" runat="server" CssClass="w-full mt-2 p-2 border border-gray-300 rounded focus:outline-none focus:ring-2 focus:ring-indigo-500 text-black" />
                                <asp:RequiredFieldValidator ID="SignupUsernameRequired" runat="server" ControlToValidate="SignupUsername" ErrorMessage="Username is required" CssClass="text-red-500" ValidationGroup="Signup" />
                            </div>
                            <div class="input-block mb-4">
                                <label for="signup-email" class="block text-sm text-gray-700">E-mail</label>
                                <asp:TextBox ID="SignupEmail" runat="server" CssClass="w-full mt-2 p-2 border border-gray-300 rounded focus:outline-none focus:ring-2 focus:ring-indigo-500 text-black" TextMode="Email" />
                                <asp:RequiredFieldValidator ID="SignupEmailRequired" runat="server" ControlToValidate="SignupEmail" ErrorMessage="Email is required" CssClass="text-red-500" ValidationGroup="Signup" />
                                <asp:RegularExpressionValidator ID="SignupEmailRegEx" runat="server" ControlToValidate="SignupEmail" ErrorMessage="Invalid email format" CssClass="text-red-500" ValidationExpression="\w+@[a-zA-Z_]+?\.[a-zA-Z]{2,3}" ValidationGroup="Signup" />
                            </div>
                            <div class="input-block mb-4">
                                <label for="signup-password" class="block text-sm text-gray-700">Password</label>
                                <asp:TextBox ID="SignupPassword" runat="server" CssClass="w-full mt-2 p-2 border border-gray-300 rounded focus:outline-none focus:ring-2 focus:ring-indigo-500 text-black" TextMode="Password" />
                                <asp:RequiredFieldValidator ID="SignupPasswordRequired" runat="server" ControlToValidate="SignupPassword" ErrorMessage="Password is required" CssClass="text-red-500" ValidationGroup="Signup" />
                            </div>
                            <div class="input-block mb-4">
                                <label for="signup-password-confirm" class="block text-sm text-gray-700">Confirm Password</label>
                                <asp:TextBox ID="SignupPasswordConfirm" runat="server" CssClass="w-full mt-2 p-2 border border-gray-300 rounded focus:outline-none focus:ring-2 focus:ring-indigo-500 text-black" TextMode="Password" />
                                <asp:RequiredFieldValidator ID="SignupPasswordConfirmRequired" runat="server" ControlToValidate="SignupPasswordConfirm" ErrorMessage="Password confirmation is required" CssClass="text-red-500" ValidationGroup="Signup" />
                                <asp:CompareValidator ID="ComparePasswords" runat="server" ControlToValidate="SignupPasswordConfirm" ControlToCompare="SignupPassword" ErrorMessage="Passwords do not match" CssClass="text-red-500" ValidationGroup="Signup" />
                            </div>
                            <div class="input-block mb-4">
                                <label for="signup-country" class="block text-sm text-gray-700">Country</label>
                                <asp:TextBox ID="SignupCountry" runat="server" CssClass="w-full mt-2 p-2 border border-gray-300 rounded focus:outline-none focus:ring-2 focus:ring-indigo-500 text-black" />
                                <asp:RequiredFieldValidator ID="SignupCountryRequired" runat="server" ControlToValidate="SignupCountry" ErrorMessage="Country is required" CssClass="text-red-500" ValidationGroup="Signup" />
                            </div>
                        </fieldset>
                        <asp:Label ID="ErrorMessageSignup" runat="server" CssClass="text-red-500 mt-4" />
                        <asp:Button ID="SignupButton" runat="server" CssClass="btn-signup bg-green-500 text-white py-2 px-4 rounded mt-4 transform transition-transform duration-300 ease-out" Text="Sign Up" OnClick="SignupButton_Click" ValidationGroup="Signup" />
                    </asp:Panel>
                </div>
            </div>
        </section>
    </form>
    <script>
        document.addEventListener('DOMContentLoaded', function () {
            var switchers = document.querySelectorAll('.switcher');
            switchers.forEach(function (switcher) {
                switcher.addEventListener('click', function () {
                    switchers.forEach(function (el) { el.parentElement.classList.remove('is-active'); });
                    this.parentElement.classList.add('is-active');
                });
            });
        });
    </script>
</body>
</html>
