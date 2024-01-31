Table 50003 "Vendor - Serienanfrage"
{
    Caption = 'Serienanfragen';

    fields
    {
        field(1; Serienanfragenr; Code[20])
        {
        }
        field(2; "No."; Code[20])
        {
            Caption = 'No.';
            NotBlank = true;
            TableRelation = Vendor;

            trigger OnValidate()
            var
                Contact_l: Record Contact;
            begin
                if Vendor.Get("No.") then;
                Name := Vendor.Name;
                "Name 2" := Vendor."Name 2";
                Address := Vendor.Address;
                "Address 2" := Vendor."Address 2";
                City := Vendor.City;
                "Post Code" := Vendor."Post Code";
                "Buy-from Contact No." := Vendor."Primary Contact No.";
                "Buy-from Contact" := Vendor.Contact;

                //G-ERP.RS 2021-05-04 +
                if Contact_l.Get("Buy-from Contact No.") then
                    "Send Mail To" := Contact_l."E-Mail";
                //G-ERP.RS 2021-05-04 -
            end;
        }
        field(3; "Line No."; Integer)
        {
        }
        field(10; Name; Text[50])
        {
            Caption = 'Name';
        }
        field(20; "Name 2"; Text[50])
        {
            Caption = 'Name 2';
        }
        field(30; Address; Text[50])
        {
            Caption = 'Address';
        }
        field(40; "Address 2"; Text[50])
        {
            Caption = 'Address 2';
        }
        field(50; City; Text[30])
        {
            Caption = 'City';
            //This property is currently not supported
            //TestTableRelation = false;
            //The property 'ValidateTableRelation' can only be set if the property 'TableRelation' is set
            //ValidateTableRelation = false;
        }
        field(91; "Post Code"; Code[20])
        {
            Caption = 'Post Code';
            //This property is currently not supported
            //TestTableRelation = false;
            //The property 'ValidateTableRelation' can only be set if the property 'TableRelation' is set
            //ValidateTableRelation = false;
        }
        field(100; Erledigt; Boolean)
        {
        }
        field(110; "Buy-from Contact No."; Code[20])
        {
            Caption = 'Eink. von Kontaktnr.';

            trigger OnLookup()
            var
                Cont: Record Contact;
                ContBusinessRelation: Record "Contact Business Relation";
            begin
                if ("No." = '73135') or ("No." = '73642') then begin
                    Clear(Cont);
                    if Page.RunModal(0, Cont) = Action::LookupOK then begin
                        Validate("Buy-from Contact No.", Cont."No.");
                    end;
                end
                else begin
                    if "No." <> '' then
                        if Cont.Get("Buy-from Contact No.") then
                            Cont.SetRange("Company No.", Cont."Company No.")
                        else begin
                            ContBusinessRelation.Reset;
                            ContBusinessRelation.SetCurrentkey("Link to Table", "No.");
                            ContBusinessRelation.SetRange("Link to Table", ContBusinessRelation."link to table"::Vendor);
                            ContBusinessRelation.SetRange("No.", "No.");
                            if ContBusinessRelation.FindFirst then
                                Cont.SetRange("Company No.", ContBusinessRelation."Contact No.")
                            else
                                Cont.SetRange("No.", '');
                        end;

                    //IF "Buy-from Contact No." <> '' THEN
                    //  IF Cont.GET("Buy-from Contact No.") THEN ;
                    Cont.SetRange(Type, Cont.Type::Person);
                    if Cont.FindFirst then begin
                        if Page.RunModal(0, Cont) = Action::LookupOK then begin
                            Validate("Buy-from Contact No.", Cont."No.");
                        end;
                    end;
                end;
            end;

            trigger OnValidate()
            var
                ContBusinessRelation: Record "Contact Business Relation";
                Cont: Record Contact;
            begin
                if ("No." <> '') and ("Buy-from Contact No." <> '') and ("No." <> '73135') and ("No." <> '73642') then begin
                    Cont.Get("Buy-from Contact No.");
                    ContBusinessRelation.Reset;
                    ContBusinessRelation.SetCurrentkey("Link to Table", "No.");
                    ContBusinessRelation.SetRange("Link to Table", ContBusinessRelation."link to table"::Vendor);
                    ContBusinessRelation.SetRange("No.", "No.");
                    if ContBusinessRelation.FindFirst then
                        if ContBusinessRelation."Contact No." <> Cont."Company No." then
                            Error(Text038, Cont."No.", Cont.Name, "No.");
                end;

                UpdateBuyFromVend("Buy-from Contact No.");
            end;
        }
        field(120; "Buy-from Contact"; Text[50])
        {
            Caption = 'Eink. von Kontakt';

            trigger OnLookup()
            var
                Contact: Record Contact;
            begin
                LookupContact("No.", "Buy-from Contact No.", Contact);
                Contact.SetRange(Type, Contact.Type::Person);
                if Contact.FindFirst then begin
                    if Page.RunModal(0, Contact) = Action::LookupOK then
                        Validate("Buy-from Contact Ansprech", Contact."No.");
                    "Buy-from Contact" := Contact.Name;
                end;
            end;
        }
        field(125; "Buy-from Contact Ansprech"; Code[20])
        {
            Caption = 'Eink. von KontaktAnsprech';

            trigger OnLookup()
            var
                Cont: Record Contact;
                ContBusinessRelation: Record "Contact Business Relation";
            begin
            end;

            trigger OnValidate()
            var
                ContBusinessRelation: Record "Contact Business Relation";
                Cont: Record Contact;
            begin
            end;
        }
        field(130; "Serienanfrage erstellt"; Boolean)
        {
        }
        field(140; "Send Mail"; Boolean)
        {
            Caption = 'E-Mail versenden';
        }
        field(150; "Mail is Send"; Boolean)
        {
            Caption = 'E-Mail wurde versendet';
        }
        field(160; "Send Mail To"; Text[80])
        {
            Caption = 'E-Mail senden an';
        }
        field(170; "Use Vendor"; Boolean)
        {
            Caption = 'Verwende Kreditor';
        }
    }

    keys
    {
        key(Key1; Serienanfragenr, "No.", "Line No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; Serienanfragenr)
        {
        }
        fieldgroup(Brick; Serienanfragenr, "No.", "Send Mail")
        {
        }
    }

    trigger OnDelete()
    var
        ItemVendor: Record "Item Vendor";
        PurchPrice: Record "Price List Line";
        PurchPrepmtPct: Record "Purchase Prepayment %";
        CustomReportSelection: Record "Custom Report Selection";
        PurchOrderLine: Record "Purchase Line";
    // VATRegistrationLogMgt: Codeunit "VAT Registration Log Mgt.";
    begin
    end;

    var
        Vendor: Record Vendor;
        HideValidationDialog: Boolean;
        Confirmed: Boolean;
        ConfirmChangeQst: label 'Do you want to change %1?', Comment = '%1 = a Field Caption like Currency Code';
        Text038: label 'Contact %1 %2 is related to a different company than vendor %3.';
        Text037: label 'Contact %1 %2 is not related to vendor %3.';
        SkipBuyFromContact: Boolean;
        Text039: label 'Contact %1 %2 is not related to a vendor.';

    local procedure LookupContact(VendorNo: Code[20]; ContactNo: Code[20]; var Contact: Record Contact)
    var
        ContactBusinessRelation: Record "Contact Business Relation";
    begin
        if ("No." = '73135') or ("No." = '73642') then begin
            Contact.SetRange("Company No.", "Buy-from Contact No.")
        end
        else begin
            ContactBusinessRelation.SetCurrentkey("Link to Table", "No.");
            ContactBusinessRelation.SetRange("Link to Table", ContactBusinessRelation."link to table"::Vendor);
            ContactBusinessRelation.SetRange("No.", VendorNo);
            if ContactBusinessRelation.FindFirst then
                Contact.SetRange("Company No.", ContactBusinessRelation."Contact No.")
            else
                Contact.SetRange("Company No.", '');
        end;
        if ContactNo <> '' then
            if Contact.Get(ContactNo) then;
    end;

    local procedure UpdateBuyFromVend(ContactNo: Code[20])
    var
        ContBusinessRelation: Record "Contact Business Relation";
        Vend: Record Vendor;
        Cont: Record Contact;
    begin
        if Cont.Get(ContactNo) then begin
            "Buy-from Contact No." := Cont."No.";
            if Cont.Type = Cont.Type::Person then begin
                "Buy-from Contact" := Cont.Name;
                //G-ERP.RS 2021-05-04 +
                "Send Mail To" := Cont."E-Mail";
                //G-ERP.RS 2021-05-04 -
            end else begin
                Name := Cont.Name;
                "Name 2" := Cont."Name 2";
                Address := Cont.Address;
                "Address 2" := Cont."Address 2";
                City := Cont.City;
                "Post Code" := Cont."Post Code";
                //G-ERP.RS 2021-05-04 +
                "Send Mail To" := Cont."E-Mail";
                //G-ERP.RS 2021-05-04 -
            end;
        end else begin
            "Buy-from Contact" := '';
            exit;
        end;
        if ("No." <> '73135') and ("No." <> '73642') then begin
            ContBusinessRelation.Reset;
            ContBusinessRelation.SetCurrentkey("Link to Table", "Contact No.");
            ContBusinessRelation.SetRange("Link to Table", ContBusinessRelation."link to table"::Vendor);
            ContBusinessRelation.SetRange("Contact No.", Cont."Company No.");
            if ContBusinessRelation.FindFirst then begin
                if ("No." <> '') and
                   ("No." <> ContBusinessRelation."No.")
                then
                    Error(Text037, Cont."No.", Cont.Name, "No.");
                if "No." = '' then begin
                    SkipBuyFromContact := true;
                    Validate("No.", ContBusinessRelation."No.");
                    SkipBuyFromContact := false;
                end;
            end else
                Error(Text039, Cont."No.", Cont.Name);
        end;
    end;
}

