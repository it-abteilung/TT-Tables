#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 82011 "CRM+ Agreement Type"
{
    Caption = 'Agreement Type';
    //LookupPageID = UnknownPage82015;

    fields
    {
        field(1; "Agreement Type"; Code[10])
        {
            Caption = 'Agreement Type';
            NotBlank = true;
        }
        field(2; Description; Text[50])
        {
            Caption = 'Description';
        }
    }

    keys
    {
        key(Key1; "Agreement Type")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        Contact.SetRange("Agreement Type", "Agreement Type");
        if Contact.Find('-') then
            Error(Text001, "Agreement Type");
    end;

    var
        Contact: Record Contact;
        Text001: label '%1 cannot be deleted, because records exist.';
}

