#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 50022 Werkzeuganforderungzeile
{
    // ACO1 DAP 11.10.2021 Can not create lines without Item No. - Barcode error message.


    fields
    {
        field(1; "Projekt Nr"; Code[20])
        {
            TableRelation = Job."No.";
        }
        field(2; "Lfd Nr"; Integer)
        {
        }
        field(3; "Zeilen Nr"; Integer)
        {
            AutoIncrement = true;
        }
        field(20; "Artikel Nr"; Code[20])
        {

            trigger OnValidate()
            begin
                Item.Get("Artikel Nr");
                Beschreibung := Item.Description;
                "Beschreibung 2" := Item."Description 2";
            end;
        }
        field(30; Beschreibung; Text[50])
        {
        }
        field(40; "Beschreibung 2"; Text[50])
        {
        }
        field(50; Menge; Decimal)
        {

            trigger OnValidate()
            begin
                if Menge <> xRec.Menge then begin
                    //  CLEAR(WerkzeuganforderungZeile);
                    //  WerkzeuganforderungZeile.SETRANGE("Projekt Nr", "Projekt Nr");
                    //  WerkzeuganforderungZeile.SETRANGE("Lfd Nr", "Lfd Nr");
                    //  WerkzeuganforderungZeile.SETRANGE("Gehört zu Zeilen Nr", "Zeilen Nr");
                    //  IF (WerkzeuganforderungZeile.FINDFIRST) THEN BEGIN
                    //    WerkzeuganforderungZeile.DELETEALL;
                    //  END;

                    BOMComp.Reset;
                    BOMComp_tmp.Reset;
                    BOMComp_tmp.DeleteAll;

                    BOMComp.SetRange("Parent Item No.", "Artikel Nr");

                    if BOMComp.FindSet then begin
                        repeat
                            //1. Ebene
                            BOMComp_tmp := BOMComp;
                            BOMComp_tmp."Quantity per" := BOMComp."Quantity per" * Menge;
                            BOMComp_tmp.Insert;
                            //2. Ebene
                            BOMComp2.Reset;
                            BOMComp2.SetRange("Parent Item No.", BOMComp."No.");
                            if BOMComp2.FindSet then begin
                                repeat
                                    BOMComp_tmp := BOMComp2;
                                    BOMComp_tmp."Quantity per" := BOMComp2."Quantity per" * Menge * BOMComp."Quantity per";
                                    BOMComp_tmp.Insert;
                                until BOMComp2.Next = 0;
                            end;
                        until BOMComp.Next = 0;
                    end;

                    lfdnr := Rec."Zeilen Nr";
                    if BOMComp_tmp.FindFirst then begin
                        Commit;
                        if Page.RunModal(50067, BOMComp_tmp) = Action::LookupOK then begin
                            if BOMComp_tmp.FindSet then begin
                                repeat
                                    if BOMComp_tmp.Auswahl then begin
                                        Clear(WerkzeuganforderungZeile);
                                        WerkzeuganforderungZeile := Rec;
                                        if Rec."Zeilen Nr" > 0 then
                                            ct_steps := 10
                                        else
                                            ct_steps := 10000;
                                        lfdnr += ct_steps;
                                        WerkzeuganforderungZeile."Zeilen Nr" := lfdnr;
                                        WerkzeuganforderungZeile.Validate("Artikel Nr", BOMComp_tmp."No.");
                                        WerkzeuganforderungZeile.Menge := BOMComp_tmp."Quantity per";
                                        WerkzeuganforderungZeile."Gehört zu Zeilen Nr" := Rec."Zeilen Nr";
                                        WerkzeuganforderungZeile.Insert;
                                    end;
                                until BOMComp_tmp.Next = 0;
                            end;
                        end;
                    end;
                end;
            end;
        }
        field(60; Abgehakt; Boolean)
        {
        }
        field(70; Anforderungsdatum; Date)
        {
        }
        field(80; Einheit; Code[10])
        {
            TableRelation = "Item Unit of Measure".Code where("Item No." = field("Artikel Nr"));
        }
        field(90; "Anfrage erstellt"; Boolean)
        {
        }
        field(100; "Anfrage Nr"; Code[20])
        {
        }
        field(110; "Gehört zu Zeilen Nr"; Integer)
        {
        }
        field(61011; "Delta"; Decimal)
        {
        }
        field(61020; "Contains Hazardous Substance"; Boolean)
        {
            Caption = 'Contains Hazardous Substance';
        }
        field(61030; "Hazard Accepted By"; Text[100])
        {
            Caption = 'Hazard Accepted By';
        }
    }

    keys
    {
        key(Key1; "Projekt Nr", "Lfd Nr", "Zeilen Nr")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        Clear(WerkzeuganforderungZeile);
        WerkzeuganforderungZeile.SetRange("Projekt Nr", "Projekt Nr");
        WerkzeuganforderungZeile.SetRange("Lfd Nr", "Lfd Nr");
        WerkzeuganforderungZeile.SetRange("Gehört zu Zeilen Nr", "Zeilen Nr");
        if (WerkzeuganforderungZeile.FindFirst) then begin
            WerkzeuganforderungZeile.DeleteAll;
        end;
    end;

    trigger OnInsert()
    begin
        // ACO1 B
        if not Item.Get("Artikel Nr") then
            FieldError("Artikel Nr");
        // ACO1 E
    end;

    var
        Item: Record Item;
        WerkzeuganforderungZeile: Record Werkzeuganforderungzeile;
        BOMComp: Record "BOM Component";
        BOMComp_tmp: Record "BOM Component" temporary;
        lfdnr: Integer;
        BOMComp2: Record "BOM Component";
        ct_steps: Integer;
}

