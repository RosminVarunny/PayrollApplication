<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="PayrollApplication._Default" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <div class="jumbotron">
        <h1>Payroll Application</h1>
        <p class="lead">An application to manage employee payroll</p>
        <p><a href="/" class="btn btn-primary btn-lg">Go &raquo;</a></p>
    </div>

    <div class="row">
        <div class="col-md-4">
            <h2>JobTitle</h2>
            <p>
               A form where Job Profile is defined. 
            </p>
            <p>
                <a class="btn btn-default" style="background-color:darkgoldenrod;color:white;font:bolder" href="JobTitle">Go &raquo;</a>
            </p>
        </div>
        <div class="col-md-4">
            <h2>Employee</h2>
            <p>
                This page is used to manage an Employee details with his job profile.
            </p>
            <p>
                <a class="btn btn-default" style="background-color:darkgoldenrod;color:white;font:bolder" href="Employee">Go &raquo;</a>
            </p>
        </div>
        <div class="col-md-4">
            <h2>Payroll Calculation</h2>
            <p>
                Here we can get the payroll of each employee in month wise and also payslip report.
            </p>
            <p>
                <a class="btn btn-default" style="background-color:darkgoldenrod;color:white;font:bolder" href="Payroll">Go &raquo;</a>
            </p>
        </div>
        <%--<div class="col-md-3">
            <h2>Pay Slip</h2>
            <p>
               Pay Slip report will be generated here
            </p>
            <p>
                <a class="btn btn-default" href="PaySlip">Go &raquo;</a>
            </p>
        </div>--%>
    </div>

</asp:Content>
