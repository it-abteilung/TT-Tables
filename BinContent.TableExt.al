#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
TableExtension 50049 tableextension50049 extends "Bin Content"
{
    fields
    {
        field(50000; "Item Description"; Text[100])
        {
            CalcFormula = lookup(Item.Description where("No." = field("Item No.")));
            Caption = 'Artikel Beschreibung';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50010; "Item Description 2"; Text[50])
        {
            CalcFormula = lookup(Item."Description 2" where("No." = field("Item No.")));
            Caption = 'Artikel Beschreibung 2';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50020; "Item Description 3"; Text[100])
        {
            CalcFormula = lookup(Item.Description where("No." = field("Item No.")));
            Caption = 'Artikel Beschreibung 3';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50030; "Tariff No."; Code[20])
        {
            CalcFormula = lookup(Item."Tariff No." where("No." = field("Item No.")));
            Caption = 'Tariff No.';
            Editable = false;
            FieldClass = FlowField;
            TableRelation = "Tariff Number";
        }
        field(50040; "Net Weight"; Decimal)
        {
            CalcFormula = lookup(Item."Net Weight" where("No." = field("Item No.")));
            Caption = 'Net Weight';
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;
            MinValue = 0;
        }
        field(50050; "Unit Cost"; Decimal)
        {
            AutoFormatType = 2;
            CalcFormula = lookup(Item."Unit Cost" where("No." = field("Item No.")));
            Caption = 'Unit Cost';
            Editable = false;
            FieldClass = FlowField;
            MinValue = 0;
        }
        field(50060; "Item Description ENU"; Text[100])
        {
            CalcFormula = lookup("Item Translation".Description where("Item No." = field("Item No."),
                                                                       "Language Code" = const('ENU')));
            Caption = 'Artikel Beschreibung ENU';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50070; "Item Description 2 ENU"; Text[50])
        {
            CalcFormula = lookup("Item Translation"."Description 2" where("Item No." = field("Item No."),
                                                                           "Language Code" = const('ENU')));
            Caption = 'Artikel Beschreibung 2 ENU';
            Editable = false;
            FieldClass = FlowField;
        }
    }
}

