#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 82001 "Contact Homepage"
{
    Caption = 'Contact Homepage';

    fields
    {
        field(1; "Contact No."; Code[20])
        {
            Caption = 'Contact No.';
        }
        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.';
        }
        field(3; Homepage; Text[210])
        {
        }
        field(4; Description; Text[50])
        {
            Caption = 'Description';
        }
        field(5; "E-Mail"; Text[200])
        {
        }
        field(6; "created from"; Code[20])
        {
            Caption = 'Created from';
            Editable = false;
            TableRelation = User;
        }
    }

    keys
    {
        key(Key1; "Contact No.", "Line No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        "created from" := UserId;
    end;
}

