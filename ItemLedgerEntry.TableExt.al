#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
TableExtension 50005 tableextension50005 extends "Item Ledger Entry"
{
    fields
    {
        field(50000; "Description 2"; Text[50])
        {
            Caption = 'Description';
        }
        field(50300; "Goods Receiving Date"; Date)
        {
            Caption = 'Goods Receiving Date';
            Description = 'G-ERP';
        }
        field(50301; Employee; Text[50])
        {
            Caption = 'Employee';
            Description = 'G-ERP';
        }
        field(50302; "Employee No."; Code[20])
        {
            Caption = 'Mitarberiter Nr.';
            Description = 'G-ERP';
            TableRelation = Employee."No.";

            trigger OnValidate()
            var
                Employee_l: Record Employee;
            begin
            end;
        }
    }

    trigger OnAfterInsert()
    var
        Matches: Record Matches;
        Regex: Codeunit Regex;
        Pattern: Text;
        ItemSerial: Record "Artikel-Seriennr";
    begin
        Pattern := '(0[1-9]|[12][0-9]|3[01])\/(0[1-9]|1[1,2])\/([0-9]{2})';
        if Regex.IsMatch("Document No.", Pattern, 0) then
            if ItemSerial.Get(Rec."Item No.", Rec."Serial No.") then begin
                ItemSerial."Last Scan Date" := Today();
                ItemSerial."Last Scan Location" := Rec."Location Code";
                ItemSerial.Modify();
            end;
    end;
}

