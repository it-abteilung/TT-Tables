#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 82017 "My Contact"
{
    Caption = 'My Contact';

    fields
    {
        field(1; "User ID"; Code[20])
        {
            Caption = 'User ID';
            TableRelation = User;
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(2; "Contact No."; Code[20])
        {
            Caption = 'Contact No.';
            NotBlank = true;
            TableRelation = Contact;
        }
    }

    keys
    {
        key(Key1; "User ID", "Contact No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

