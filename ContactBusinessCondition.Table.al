#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 82002 "Contact Business Condition"
{
    Caption = 'Contact Business Condition';
    //LookupPageID = UnknownPage82004;

    fields
    {
        field(1; "Business Condition"; Code[10])
        {
            Caption = 'Business Condition';
            NotBlank = true;
        }
        field(2; Description; Text[50])
        {
            Caption = 'Description';
        }
    }

    keys
    {
        key(Key1; "Business Condition")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        rContact.SetRange("Business Condition", "Business Condition");
        if rContact.Find('-') then
            Error(Text001, "Business Condition");
    end;

    var
        rContact: Record Contact;
        Text001: label 'You cannot delete %1, because there are records.';
}

