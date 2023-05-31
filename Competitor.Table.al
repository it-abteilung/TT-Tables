#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 82005 Competitor
{
    Caption = 'Competitor';
    //LookupPageID = UnknownPage82009;

    fields
    {
        field(1; "Code"; Code[10])
        {
            NotBlank = true;
        }
        field(2; Desription; Text[50])
        {
            Caption = 'Description';
        }
    }

    keys
    {
        key(Key1; "Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    var
        ErrorFound: Boolean;
    begin
        Contact.SetRange("Actual 6", Code);
        if Contact.Find('-') then
            ErrorFound := true;
        Contact.SetRange("Actual 6");

        Contact.SetRange("Nominal 6", Code);
        if Contact.Find('-') then
            ErrorFound := true;
        Contact.SetRange("Nominal 6");

        Contact.SetRange("Competitor 1", Code);
        if Contact.Find('-') then
            ErrorFound := true;
        Contact.SetRange("Competitor 1");

        Contact.SetRange("Competitor 2", Code);
        if Contact.Find('-') then
            ErrorFound := true;
        Contact.SetRange("Competitor 2");

        Contact.SetRange("Competitor 3", Code);
        if Contact.Find('-') then
            ErrorFound := true;
        Contact.SetRange("Competitor 3");

        if ErrorFound then
            Error(Text001, Code);
    end;

    var
        Contact: Record Contact;
        Text001: label '%1 cannot be deleted, because records exist.';
}

