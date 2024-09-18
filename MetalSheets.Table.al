table 50028 "Metal Sheet"
{
    fields
    {
        field(1; "Entry No."; Integer)
        {
            AutoIncrement = true;
        }
        field(2; Locked; Boolean)
        {
        }
        field(10; "Item No."; Code[20])
        {
            TableRelation = Item."No." where("Item Category Code" = const('BLECH'));
        }
        field(20; "Lot No."; Code[50])
        {
        }
        field(21; "Original Lot No."; Code[50])
        {
        }
        field(30; "Description"; Text[100])
        {
        }
        field(40; "Format"; Text[100])
        {
        }
        field(50; "Length A"; Decimal)
        {
        }
        field(51; "Length B"; Decimal)
        {
        }
        field(60; "Width A"; Decimal)
        {
        }
        field(61; "Width B"; Decimal)
        {
        }
        field(70; "Circle Diameter"; Decimal)
        {
        }
        field(80; "Area"; Decimal)
        {
        }
        field(90; "Weight"; Decimal)
        {
        }
        field(100; "Is Punched"; Boolean)
        {
        }
        field(110; "Is Nipped"; Boolean)
        {
        }
        field(120; "From Location"; Code[10])
        {
            TableRelation = Location;
        }
        field(121; "From Bin"; Code[20])
        {
            TableRelation = Bin.Code where("Location Code" = field("From Location"));
        }
        field(130; "To Location"; Code[10])
        {
            TableRelation = Location;
        }
        field(131; "To Bin"; Code[20])
        {
            TableRelation = Bin.Code where("Location Code" = field("To Location"));
        }
        field(140; "Quantity"; Decimal)
        {
            BlankZero = false;
            DecimalPlaces = 0 : 5;
        }
    }

    keys
    {
        key(key1; "Entry No.", "Item No.")
        {
            Clustered = true;
        }
    }

}