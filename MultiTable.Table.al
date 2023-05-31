#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 50000 "Multi Table"
{

    fields
    {
        field(1; Kennzeichen; Code[20])
        {
            Caption = 'Kennzeichen';
        }
        field(2; "Code"; Code[20])
        {
            Caption = 'Code';
            SQLDataType = Variant;
        }
        field(10; Description; Text[100])
        {
            Caption = 'Beschreibung';
        }
        field(20; "Description 2"; Text[100])
        {
            Caption = 'Beschreibung 2';
        }
        field(30; Baujahr; Code[4])
        {
            Caption = 'Baujahr';
        }
        field(40; Hersteller; Text[50])
        {
            Caption = 'Hersteller';
        }
        field(50; Owner; Code[20])
        {
            Caption = 'Besitzer';
            TableRelation = Contact."No." where(Type = const(Company));
        }
        field(60; Info; Text[250])
        {
            Caption = 'Info';
        }
        field(70; Sachbearbeiter; Code[20])
        {
            Caption = 'Sachbearbeiter';
            TableRelation = Contact."No." where(Type = const(Person));
        }
        field(80; Abteilungsleiter; Code[20])
        {
            Caption = 'Abteilungsleiter';
            TableRelation = Contact."No." where(Type = const(Person));
        }
        field(90; "Technische Info"; Text[250])
        {
            Caption = 'Technische Info';
        }
        field(100; City; Text[250])
        {
            Caption = 'Ort';
        }
        field(110; Type; Code[10])
        {
            Caption = 'Typ';
        }
        field(120; TDW; Decimal)
        {
            Caption = 'TDW';
            DecimalPlaces = 2 : 2;
        }
        field(130; Length; Decimal)
        {
            Caption = 'Länge';
            DecimalPlaces = 1 : 1;
        }
        field(140; Width; Decimal)
        {
            Caption = 'Breite';
            DecimalPlaces = 1 : 1;
        }
        field(150; Depth; Decimal)
        {
            Caption = 'Tiefgang';
            DecimalPlaces = 1 : 1;
        }
        field(160; "Area"; Text[250])
        {
            Caption = 'Fahrgebiet';
        }
        field(170; "Main Engine"; Text[100])
        {
            Caption = 'Hauptmaschine';
        }
        field(180; "Main Engine Type"; Code[20])
        {
            Caption = 'Hauptmaschine Typ';
        }
        field(190; "ME Turbo"; Text[100])
        {
            Caption = 'ME Turbo';
        }
        field(200; "AUX Engine"; Text[100])
        {
            Caption = 'Hilfsmaschine';
        }
        field(210; "AUX Engine Type"; Code[30])
        {
            Caption = 'Hilfsmaschine Typ';
        }
        field(220; "Seal Maker"; Text[100])
        {
            Caption = 'Dichtungshersteller';
        }
        field(230; "Seal Type"; Code[20])
        {
            Caption = 'Dichtungstyp';
        }
        field(240; "Ex Name"; Text[100])
        {
            Caption = 'Ex Name';
        }
        field(250; "LLoyds No."; Code[20])
        {
            Caption = 'LLoyds Nr.';
        }
        field(260; "Hull No."; Code[20])
        {
            Caption = 'Baunr.';
        }
        field(270; NRT; Decimal)
        {
            Caption = 'NRT';
            DecimalPlaces = 1 : 1;
        }
        field(280; GRT; Decimal)
        {
            Caption = 'GRT';
            DecimalPlaces = 1 : 1;
        }
        field(290; Class; Code[20])
        {
            Caption = 'Klasse';
            TableRelation = "Multi Table".Code where(Kennzeichen = const('CLASS'));

            trigger OnLookup()
            var
                ClassRec: Record "Multi Table";
            begin
                ClassRec.SetRange(Kennzeichen, 'CLASS');
                if ClassRec.Get('CLASS', Class) then;
                if Page.RunModal(50008, ClassRec) = Action::LookupOK then
                    Class := ClassRec.Code;
            end;
        }
        field(300; Flag; Code[10])
        {
            Caption = 'Flagge';
            TableRelation = "Country/Region".Code;
        }
        field(310; Propeller; Code[40])
        {
            Caption = 'Propeller';
        }
        field(320; Agent; Code[20])
        {
            Caption = 'Agentur';
            TableRelation = Contact."No." where(Type = const(Company));
        }
        field(330; Superintendent; Code[20])
        {
            Caption = 'Superintendent';
            TableRelation = Contact."No." where(Type = const(Person));
        }
        field(340; Fleetmanager; Code[20])
        {
            Caption = 'Fleetmanager';
            TableRelation = Contact."No." where(Type = const(Person));
        }
        field(350; Manager; Code[20])
        {
            Caption = 'Manager';
            TableRelation = Contact."No." where(Type = const(Person));
        }
        field(360; Charterer; Code[20])
        {
            Caption = 'Charterer';
            TableRelation = Contact."No." where(Type = const(Person));
        }
        field(400; "Unit Price"; Decimal)
        {
            AutoFormatType = 2;
            Caption = 'Unit Price';
        }
        field(410; "Extra Charge %"; Decimal)
        {
            Caption = 'Extra Charge %';
            DecimalPlaces = 0 : 5;
            Description = '0:5';
        }
        field(450; "E-Mail"; Text[100])
        {
            Caption = 'E-Mail';
        }
        field(460; "User ID"; Code[20])
        {
            Caption = 'User ID';
            NotBlank = true;
            TableRelation = User;
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;

            // trigger OnLookup()
            // var
            //     LoginMgt: Codeunit "User Management";
            // begin
            //     LoginMgt.LookupUserID("User ID");
            // end;

            // trigger OnValidate()
            // var
            //     LoginMgt: Codeunit "User Management";
            // begin
            //     LoginMgt.ValidateUserID("User ID");
            // end;
        }
        field(500; "Owner Name"; Text[100])
        {
            CalcFormula = lookup(Contact.Name where("No." = field(Owner)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(510; "Superintendent Name"; Text[100])
        {
            CalcFormula = lookup(Contact.Name where("No." = field(Superintendent)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(520; "Fleetmanager Name"; Text[100])
        {
            CalcFormula = lookup(Contact.Name where("No." = field(Fleetmanager)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(530; "Manager Name"; Text[100])
        {
            CalcFormula = lookup(Contact.Name where("No." = field(Manager)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(540; "Bareboat Charterer Name"; Text[100])
        {
            CalcFormula = lookup(Contact.Name where("No." = field(Charterer)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(600; "Aufschlag %"; Decimal)
        {
        }
        field(610; "Einkaufsrabatt %"; Decimal)
        {
        }
        field(620; "Currency Code"; Code[10])
        {
            Caption = 'Currency Code';
            TableRelation = Currency;

            trigger OnValidate()
            begin
                //Währungskurs := CurrExchRate.ExchangeRate(TODAY,"Currency Code")
            end;
        }
        field(630; "Währungskurs"; Decimal)
        {
            DecimalPlaces = 0 : 15;
        }
        field(50000; Gesamt; Decimal)
        {
            CalcFormula = sum("Job Planning Line"."Total Price" where("Job No." = field(Code)));
            Editable = false;
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; Kennzeichen, "Code")
        {
            Clustered = true;
        }
        key(Key2; Description)
        {
        }
    }

    fieldgroups
    {
    }
}

