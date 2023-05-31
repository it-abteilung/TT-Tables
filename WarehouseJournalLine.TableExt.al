#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
TableExtension 50050 tableextension50050 extends "Warehouse Journal Line"
{
    fields
    {
        field(50000; "Description 2"; Text[50])
        {
            Caption = 'Description';
        }
        field(50010; Employee; Text[50])
        {
            Caption = 'Mitarbeiter';
            Description = 'G-ERP';
        }
        field(50020; "Employee No."; Code[20])
        {
            Caption = 'Mitarbeiter Nr.';
            Description = 'G-ERP';
            TableRelation = Employee;
        }
    }
}

