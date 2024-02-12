#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 50005 Materialanforderungzeile
{
    // 001 HF  17.10.19  new fields
    // 120LieferterminDate
    // 130zusätzliche AnforderungenText100


    fields
    {
        field(1; "Projekt Nr"; Code[20])
        {
            TableRelation = Job."No.";
        }
        field(2; "Lfd Nr"; Integer)
        {
            Caption = 'Entry No.';
        }
        field(3; "Zeilen Nr"; Integer)
        {
        }
        field(20; "Artikel Nr"; Code[20])
        {
            TableRelation = Item where(Blocked = const(false));
            ValidateTableRelation = false;

            trigger OnValidate()
            begin
                if Rec."Artikel Nr" <> xRec."Artikel Nr" then begin
                    Rec."Is Item No." := false;
                    if Item.Get(Rec."Artikel Nr") then begin
                        Rec."Is Item No." := true;
                        Rec.Beschreibung := Item.Description;
                        Rec."Beschreibung 2" := Item."Description 2";
                        Rec."Beschreibung 3" := Item."Description 3";
                        Rec.Validate(Einheit, Item."Base Unit of Measure");
                    end
                end
            end;
        }
        field(21; "Is Item No."; Boolean)
        {
        }
        field(30; Beschreibung; Text[50])
        {
        }
        field(40; "Beschreibung 2"; Text[50])
        {
        }
        field(41; "Beschreibung 3"; Text[50])
        {
        }
        field(42; "Beschreibung 4"; Text[250])
        {
        }
        field(43; "Beschreibung 5"; Text[250])
        {
        }
        field(50; Menge; Decimal)
        {

            trigger OnValidate()
            begin
                if Menge <> xRec.Menge then begin
                    Clear(MaterialanforderungZeile);
                    MaterialanforderungZeile.SetRange("Projekt Nr", "Projekt Nr");
                    MaterialanforderungZeile.SetRange("Lfd Nr", "Lfd Nr");
                    MaterialanforderungZeile.SetRange("Gehört zu Zeilen Nr", "Zeilen Nr");
                    if (MaterialanforderungZeile.FindFirst) then begin
                        MaterialanforderungZeile.DeleteAll;
                    end;

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
                                        Clear(MaterialanforderungZeile);
                                        MaterialanforderungZeile := Rec;
                                        if Rec."Zeilen Nr" > 0 then
                                            ct_steps := 10
                                        else
                                            ct_steps := 10000;
                                        lfdnr += ct_steps;
                                        MaterialanforderungZeile."Zeilen Nr" := lfdnr;
                                        MaterialanforderungZeile.Validate("Artikel Nr", BOMComp_tmp."No.");
                                        MaterialanforderungZeile.Menge := BOMComp_tmp."Quantity per";
                                        MaterialanforderungZeile."Gehört zu Zeilen Nr" := Rec."Zeilen Nr";
                                        MaterialanforderungZeile.Insert;
                                    end;
                                until BOMComp_tmp.Next = 0;
                            end;
                        end;
                    end;
                end;
                Rec."Quoted Quantity" := Rec.Menge;
            end;
        }
        field(51; "Quoted Quantity"; Decimal)
        {
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
        field(120; Liefertermin; Date)
        {
        }
        field(130; "zusätzliche Anforderungen"; Text[100])
        {
        }
        field(140; "Has Substitute"; Boolean)
        {
        }
        field(141; "Is Substitute"; Boolean)
        {
        }
        field(142; "Substitute To Line No."; Integer)
        {
        }
        field(150; "Serial Quote No."; Code[20])
        {
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
        Clear(MaterialanforderungZeile);
        MaterialanforderungZeile.SetRange("Projekt Nr", "Projekt Nr");
        MaterialanforderungZeile.SetRange("Lfd Nr", "Lfd Nr");
        MaterialanforderungZeile.SetRange("Gehört zu Zeilen Nr", "Zeilen Nr");
        if (MaterialanforderungZeile.FindFirst) then begin
            MaterialanforderungZeile.DeleteAll;
        end;
        Clear(MaterialanforderungZeile);
        if MaterialanforderungZeile.Get(Rec."Projekt Nr", Rec."Lfd Nr", Rec."Substitute To Line No.") then begin
            MaterialanforderungZeile."Has Substitute" := false;
            MaterialanforderungZeile."Quoted Quantity" := Rec.Menge;
            MaterialanforderungZeile.Modify();
        end;
    end;

    var
        Item: Record Item;
        MaterialanforderungZeile: Record Materialanforderungzeile;
        Materialanforderung2: Record Materialanforderungzeile;
        BOMComp: Record "BOM Component";
        BOMComp_tmp: Record "BOM Component" temporary;
        lfdnr: Integer;
        BOMComp2: Record "BOM Component";
        ct_steps: Integer;
}

