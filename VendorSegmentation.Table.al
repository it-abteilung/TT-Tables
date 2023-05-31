#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 50017 "Vendor Segmentation"
{
    Caption = 'Kreditor Segmentierung';

    fields
    {
        field(1; Vendor; Code[20])
        {
            Caption = 'Kreditor';
        }
        field(2; Segmentation; Code[20])
        {
            Caption = 'Kategorie';
            TableRelation = "Item Category".Code;
        }
        field(3; Group; Code[20])
        {
            Caption = 'Gruppe';
            TableRelation = "Item Category".Code where(Code = field(Segmentation));
        }
    }

    keys
    {
        key(Key1; Vendor, Segmentation, Group)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

