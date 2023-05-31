#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 82006 Organisation
{
    Caption = 'Organisation';
    //DrillDownPageID = UnknownPage82006;

    fields
    {
        field(1; Organisation; Code[20])
        {
            Caption = 'Organisation';
            NotBlank = true;
            TableRelation = Contact."No.";
        }
        field(2; Member; Code[20])
        {
            Caption = 'Member';
            TableRelation = Contact."No.";
        }
        field(3; "Search Name Organisation"; Code[100])
        {
            CalcFormula = lookup(Contact."Search Name" where("No." = field(Organisation)));
            Caption = 'Search Name Organisation';
            Editable = false;
            FieldClass = FlowField;
        }
        field(4; "Search Name Member"; Code[100])
        {
            CalcFormula = lookup(Contact."Search Name" where("No." = field(Member)));
            Caption = 'Search Name Member';
            Editable = false;
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; Organisation, Member)
        {
            Clustered = true;
        }
        key(Key2; Member)
        {
        }
    }

    fieldgroups
    {
    }
}

