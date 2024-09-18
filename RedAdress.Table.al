#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 82014 "Red Adress"
{
    //DrillDownPageID = UnknownPage82021;

    fields
    {
        field(1; "Code"; Code[10])
        {
            Caption = 'Code';
            TableRelation = if (Table = const("Business Relation")) "Business Relation"
            else
            if (Table = const("Business Condition")) "Contact Business Condition";
        }
        field(2; "Table"; Option)
        {
            Caption = 'Table';
            OptionCaption = 'Business Relation,Business Condition';
            OptionMembers = "Business Relation","Business Condition";
        }
    }

    keys
    {
        key(Key1; "Table", "Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}