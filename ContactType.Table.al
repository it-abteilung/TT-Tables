#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 82010 "Contact Type"
{
    Caption = 'Contact Type';
    //LookupPageID = UnknownPage82014;

    fields
    {
        field(1; "Contact Type"; Code[10])
        {
            Caption = 'Contact Type';
            NotBlank = true;
        }
        field(2; Description; Text[50])
        {
            Caption = 'Description';
        }
    }

    keys
    {
        key(Key1; "Contact Type")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        Contact.SetRange(Source, "Contact Type");
        if Contact.Find('-') then
            Error(Text001, "Contact Type");
    end;

    var
        Contact: Record Contact;
        Text001: label '%1 cannot be deleted, because records exist.';
}

