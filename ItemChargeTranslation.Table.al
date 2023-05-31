#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 50014 "Item Charge Translation"
{
    // AC01 02.02.2022 DAP Created.

    Caption = 'Item Charge Translation';

    fields
    {
        field(1;"Charge No.";Code[10])
        {
            Caption = 'Charge No.';
            TableRelation = "Item Charge";
        }
        field(2;"Language Code";Code[10])
        {
            Caption = 'Language Code';
            TableRelation = Language;
        }
        field(3;Description;Text[50])
        {
            Caption = 'Beschreibung 2';
        }
        field(4;"Description 2";Text[50])
        {
            Caption = 'Description 2';
        }
    }

    keys
    {
        key(Key1;"Charge No.","Language Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

