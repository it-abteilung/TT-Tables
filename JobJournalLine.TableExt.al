TableExtension 50029 tableextension50029 extends "Job Journal Line"
{
    fields
    {
        field(50000; Normalstunden; Decimal)
        {
            DecimalPlaces = 0 : 1;

            trigger OnValidate()
            begin
                VKPreisErmitteln();
            end;
        }
        field(50001; "25% Zuschlag"; Decimal)
        {
            DecimalPlaces = 0 : 1;

            trigger OnValidate()
            begin
                VKPreisErmitteln();
            end;
        }
        field(50002; "50% Zuschlag"; Decimal)
        {
            DecimalPlaces = 0 : 1;

            trigger OnValidate()
            begin
                VKPreisErmitteln();
            end;
        }
        field(50003; "100% Zuschlag"; Decimal)
        {
            DecimalPlaces = 0 : 1;

            trigger OnValidate()
            begin
                VKPreisErmitteln();
            end;
        }
        field(50010; Baugruppe; Code[20])
        {
            TableRelation = "Job Planning Line".Baugruppe where("Job No." = field("Job No."),
                                                                 "Baugruppe Tree" = filter(0));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;

            trigger OnLookup()
            var
                JobPlanningLine: Record "Job Planning Line";
            begin
                Clear(JobPlanningLine);
                JobPlanningLine.SetRange("Job No.", "Job No.");
                JobPlanningLine.SetRange(Baugruppe, Baugruppe);
                JobPlanningLine.SetRange("Baugruppe Tree", 0);
                if JobPlanningLine.FindFirst then;
                JobPlanningLine.SetRange(Baugruppe);
                if Page.RunModal(50056, JobPlanningLine) = Action::LookupOK then
                    Baugruppe := JobPlanningLine.Baugruppe;
            end;

            trigger OnValidate()
            var
                JobPlanningLine: Record "Job Planning Line";
            begin
                Clear(JobPlanningLine);
                JobPlanningLine.SetRange("Job No.", "Job No.");
                JobPlanningLine.SetRange(Baugruppe, Baugruppe);
                if not JobPlanningLine.FindFirst then
                    Error('Baugruppe nicht vorhanden');
            end;
        }
        field(50020; "Mitarbeiter Nr"; Code[20])
        {
        }
        field(50030; Pos; Code[20])
        {
            Description = 'G-ERP';
            TableRelation = "Job Planning Line".Pos where("Job No." = field("Job No."),
                                                           Baugruppe = field(Baugruppe));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(50100; Stundensatz; Option)
        {
            OptionMembers = " ",Reparatur,"Gütesicherung",Brandwache;

            trigger OnValidate()
            begin
                VKPreisErmitteln();
            end;
        }
    }

    var
        Job: Record Job;

    procedure "***G-ERP***"()
    begin
    end;

    procedure VKPreisErmitteln()
    var
        Mengestundensatz: Decimal;
        l_JobsSetup: Record "Jobs Setup";
    begin
        Job.Get("Job No.");
        l_JobsSetup.Get();
        Quantity := Normalstunden + "25% Zuschlag" + "50% Zuschlag" + "100% Zuschlag";
        Mengestundensatz := Normalstunden + ("25% Zuschlag" * 1.25) + ("50% Zuschlag" * 1.5) + ("100% Zuschlag" * 2);

        case Stundensatz of
            Stundensatz::Reparatur:
                begin
                    Validate("Direct Unit Cost (LCY)", ROUND(Mengestundensatz * l_JobsSetup."Reparatur intern ░" / Quantity, 0.01));
                    Validate("Unit Price (LCY)", ROUND(Mengestundensatz * Job."Reparatur  in Euro" / Quantity, 0.01));
                end;
            Stundensatz::Gütesicherung:
                begin
                    Validate("Direct Unit Cost (LCY)", ROUND((Mengestundensatz + (Mengestundensatz / 100 * l_JobsSetup."Gütesicherung intern ░")) /
                                                            Quantity, 0.01));
                    Validate("Unit Price (LCY)", ROUND((Mengestundensatz + (Mengestundensatz / 100 * Job."Gütesicherung  in Euro")) / Quantity, 0.01));
                end;
            Stundensatz::Brandwache:
                begin
                    Validate("Direct Unit Cost (LCY)", ROUND((Mengestundensatz + (Mengestundensatz / 100 * l_JobsSetup."Brandwache intern ░")) /
                                                            Quantity, 0.01));
                    Validate("Unit Price (LCY)", ROUND((Mengestundensatz + (Mengestundensatz / 100 * Job."Brandwache  in Euro")) / Quantity, 0.01));
                end;
        end;
    end;
}

