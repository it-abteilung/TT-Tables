TableExtension 50009 tableextension50009 extends "Purchase Line"
{
    fields
    {

        // modify("No.")
        // {
        //     trigger OnAfterValidate()
        //     begin
        //         //G-ERP+
        //         "Job No." := PurchHeader."Job No.";
        //         xRec."Job No." := PurchHeader."Job No.";
        //         Leistungszeitraum := PurchHeader.Leistungszeitraum;
        //         Leistungsart := PurchHeader.Leistungsart;
        //         //G-ERP-

        //         // G-ERP.RS 2021-06-23 +++ Anfrage#2311459
        //         IF Type = Type::Item THEN BEGIN
        //             IF ("Document Type" = "Document Type"::Order) OR ("Document Type" = "Document Type"::Quote) THEN BEGIN
        //                 PurchaseHeader_l.GET("Document Type", "Document No.");
        //                 IF ItemVendor_l.GET(PurchaseHeader_l."Buy-from Vendor No.", "No.", "Variant Code") THEN BEGIN
        //                     IF (Description = '') OR ("No." <> xRec."No.") THEN
        //                         Description := ItemVendor_l.Description;
        //                     IF ("Description 2" = '') OR ("No." <> xRec."No.") THEN
        //                         "Description 2" := ItemVendor_l."Description 2";
        //                 END;
        //             END;
        //         END;
        //         // G-ERP.RS 2021-06-23 --- Anfrage#2311459
        //     end;
        // }
        // modify("quantity")
        // {
        //     trigger OnAfterValidate()
        //     begin
        //         //G-ERP.RS 2019-04-24 +++
        //         IF GUIALLOWED THEN
        //             SetzeBelegStatus(PurchHeader, Rec);
        //         //G-ERP.RS 2019-04-24 ---
        //     end;
        // }
        // modify("Qty. to Receive")
        // {
        //     trigger OnAfterValidate()
        //     begin

        //         //G-ERP.KBS 2017-09-14 + //Überlieferung
        //         IF Geliefert THEN BEGIN
        //             IF "Qty. to Receive" > "Outstanding Quantity" THEN BEGIN
        //                 PurchHeader.GET("Document Type", "Document No.");
        //                 ReleasePurchaseDocument.Reopen(PurchHeader);
        //                 IF "Qty. to Receive" > ("Outstanding Quantity" * 130 / 100) THEN
        //                     ERROR(MengeüberhöhtText)
        //                 ELSE BEGIN
        //                     IF CONFIRM(ÜberlieferungText, FALSE) THEN BEGIN
        //                         Quantity := Quantity + ("Qty. to Receive" - "Outstanding Quantity");
        //                         VALIDATE(Quantity);
        //                     END ELSE
        //                         VALIDATE("Qty. to Receive", "Outstanding Quantity");
        //                 END;
        //             END;
        //         END;
        //         //G-ERP.KBS 2017-09-14 -
        //     end;
        // }
        field(50010; Baugruppe; Code[20])
        {
            Description = 'G-ERP';
            TableRelation = "Job Planning Line".Baugruppe where("Job No." = field("Job No."));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(50020; Pos; Code[20])
        {
            Description = 'G-ERP';
            TableRelation = "Job Planning Line".Pos where("Job No." = field("Job No."));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(50040; Leistungsart; Option)
        {
            Description = 'G-ERP';
            OptionMembers = " ",Fremdlieferung,Fremdleistung,Transport,Flugkosten,Hotelkosten,Personal,Beistellung,"Auslöse";
        }
        field(50050; Leistungszeitraum; Code[7])
        {
            Description = 'G-ERP';
        }
        field(50060; "LOT-Nr. / Chargennr."; Code[20])
        {
            Caption = 'LOT-Nr. / Chargennr.';
        }
        field(50070; Geliefert; Boolean)
        {
        }
        field(50100; "Abschlag1 %"; Decimal)
        {
        }
        field(50101; "Abschlag2 %"; Decimal)
        {
        }
        field(50102; "Abschlag3 %"; Decimal)
        {
        }
        field(50103; "Abschlag1 Absolut"; Decimal)
        {
        }
        field(50104; "Abschlag2 Absolut"; Decimal)
        {
        }
        field(50105; "Abschlag3 Absolut"; Decimal)
        {
        }
        field(50106; "Abschlag1 Datum"; Date)
        {
        }
        field(50107; "Abschlag2 Datum"; Date)
        {
        }
        field(50108; "Abschlag3 Datum"; Date)
        {
        }
        field(50200; "Description 3"; Text[50])
        {
            Caption = 'Description 2';
        }
        field(50201; "Description 3 FlowField"; Text[50])
        {
            CalcFormula = lookup(Item."Description 3" where("No." = field("No.")));
            Caption = 'Description 3';
            Description = 'G-ERP';
            FieldClass = FlowField;
        }
        field(50202; "Description 4"; Text[250])
        {
            Caption = 'Beschreibung 4';
        }
        field(50203; "Description 5"; Text[250])
        {
            Caption = 'Beschreibung 5';
        }
        field(50300; "CO2 Menge in Kilogramm"; Decimal)
        {
        }
        field(82000; "Outstanding Amt.Excl.VAT (LCY)"; Decimal)
        {
            Caption = 'Outstanding Amount Excl. VAT (LCY)';
        }
    }

    protected var
        PurchHeader: Record "Purchase Header";

    local procedure SetzeBelegStatus(P_PurchaseHeader: Record "Purchase Header"; P_PurchaseLine: Record "Purchase Line")
    var
        L_PurchaseLine: Record "Purchase Line";
        L_Quantity: Decimal;
        L_Teillieferung: Boolean;
        L_Sonstiges: Boolean;
        L_Mod: Boolean;
    begin
        if (P_PurchaseHeader."Status Purchase" <> P_PurchaseHeader."status purchase"::invoiced) and
           (P_PurchaseHeader."Status Purchase" <> P_PurchaseHeader."status purchase"::"partly invoiced") and
           (P_PurchaseHeader."Status Purchase" <> P_PurchaseHeader."status purchase"::" ") then begin
            if Type = Type::Item then begin

                Clear(L_Teillieferung);

                L_PurchaseLine.SetRange("Document Type", "Document Type");
                L_PurchaseLine.SetRange("Document No.", "Document No.");
                L_PurchaseLine.SetRange(Type, Type);
                if L_PurchaseLine.FindSet then begin
                    repeat

                        if L_PurchaseLine."Line No." = P_PurchaseLine."Line No." then
                            L_Quantity := P_PurchaseLine.Quantity
                        else
                            L_Quantity := L_PurchaseLine.Quantity;

                        L_Mod := true;

                        if StrLen("No.") > 2 then
                            if CopyStr("No.", 1, 3) = '999' then
                                L_Mod := false;

                        if L_Mod and (L_Quantity > L_PurchaseLine."Quantity Received") then
                            L_Teillieferung := true;
                    until (L_PurchaseLine.Next = 0) or L_Teillieferung;
                end;

                if L_Teillieferung then begin
                    P_PurchaseHeader."Status Purchase" := P_PurchaseHeader."status purchase"::"partly delivered";
                    P_PurchaseHeader.Modify;
                end else begin
                    P_PurchaseHeader."Status Purchase" := P_PurchaseHeader."status purchase"::delivered;
                    P_PurchaseHeader.Modify;
                end;
            end;
        end;
    end;

    var
        "*** G-ERP ***": Integer;
        PurchaseHeader_l: Record "Purchase Header";
        ItemVendor_l: Record "Item Vendor";

    var
        ReleasePurchaseDocument: Codeunit "Release Purchase Document";

    var
        "MengeüberhöhtText": label 'Überhöhte Menge der aktuellen Lieferung!';
        "ÜberlieferungText": label 'Wurde wirklich mehr geliefert als erwartet wurde?';
}

