#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
TableExtension 50001 tableextension50001 extends "Salesperson/Purchaser"
{
    fields
    {
        field(50000; "Fax No. TT"; Text[30])
        {
            Caption = 'Fax No.';
            Description = 'G-ERP';
        }
        field(50001; "User ID"; Text[119])
        {
            Caption = 'User ID';
            Description = 'G-ERP';
        }
        field(50002; Durchwahlnummer; Text[10])
        {
            Caption = 'Direct Dial Number';
            Description = 'G-ERP';
        }
        field(50010; "Allow Edit Item"; Boolean)
        {
        }
    }
}

