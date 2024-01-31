TableExtension 50004 tableextension50004 extends Item
{
    fields
    {
        field(50000; "Description 3"; Text[50])
        {
            Caption = 'Description 3';
            Description = 'G-ERP.RS 30 -> 50';
        }
        field(50005; "Product Group Code TT"; Code[20])
        {
            Caption = 'Produktgruppencode';
            TableRelation = "TT Product Group".Code where("Item Category Code" = field("Item Category Code"));
        }
        field(50010; DIN; Code[15])
        {
            Description = 'G-ERP';
        }
        field(50020; "TT Type"; Option)
        {
            Caption = 'Art';
            Description = 'G-ERP';
            OptionMembers = Material,Werkzeug;
        }
        field(50030; ASME; Code[15])
        {
            Description = 'G-ERP';
        }
        field(50040; ISO; Code[15])
        {
            Description = 'G-ERP';
        }
        field(50100; "Seriennr. pflichtig"; Boolean)
        {
            Description = 'G-ERP';
        }
        field(50200; "Für Inventur berücksichtigen"; Boolean)
        {
            Description = 'G-ERP';
        }
        field(51000; "Inventory complete"; Decimal)
        {
            CalcFormula = sum("Item Ledger Entry".Quantity where("Item No." = field("No."),
                                                                  "Global Dimension 1 Code" = field("Global Dimension 1 Filter"),
                                                                  "Global Dimension 2 Code" = field("Global Dimension 2 Filter"),
                                                                  "Drop Shipment" = field("Drop Shipment Filter"),
                                                                  "Variant Code" = field("Variant Filter"),
                                                                  "Lot No." = field("Lot No. Filter"),
                                                                  "Serial No." = field("Serial No. Filter")));
            Caption = 'Inventory';
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;
        }
        field(52000; Segmentation; Code[20])
        {
            Caption = 'Segmentierung';
            Description = 'G-ERP';
            TableRelation = Segmentation;
        }
        field(61013; "Blocked Tool Requirement"; Boolean)
        {
            Caption = 'Blocked Tool Requirement';
        }
    }
    fieldgroups
    {
        addlast(DropDown; "Description 2", "Description 3")
        {
        }
    }

}

