#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 82000 "Distance Zone"
{
    Caption = 'Distance Zone';
    //LookupPageID = UnknownPage82002;

    fields
    {
        field(1; Zone; Integer)
        {
            Caption = 'Zone';
            MinValue = 1;
        }
        field(2; "Distance up to km"; Integer)
        {
            Caption = 'Distance up to km';
        }
    }

    keys
    {
        key(Key1; Zone)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        contact.SetRange("Distance Zone", Zone);
        if contact.Find('-') then
            Error(Text100, FieldCaption(Zone), Zone);
    end;

    var
        contact: Record Contact;
        Text100: label 'You cannot delete %1 %2 because there are one or more contacts with this value.';
}

