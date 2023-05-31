#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
TableExtension 50014 tableextension50014 extends "Item Vendor"
{
    fields
    {
        field(50000; Description; Text[50])
        {
            Caption = 'Description';
            Description = 'G-ERP';
        }
        field(50001; "Description 2"; Text[50])
        {
            Caption = 'Description 2';
            Description = 'G-ERP';
        }
        field(50010; "Vendor Name"; Text[100])
        {
            CalcFormula = lookup(Vendor.Name where("No." = field("Vendor No.")));
            Caption = 'Kreditor Name';
            Description = 'G-ERP';
            FieldClass = FlowField;
        }
        field(50011; "Vendor Name 2"; Text[50])
        {
            CalcFormula = lookup(Vendor."Name 2" where("No." = field("Vendor No.")));
            Caption = 'Kreditor Name 2';
            Description = 'G-ERP';
            FieldClass = FlowField;
        }
    }
}

