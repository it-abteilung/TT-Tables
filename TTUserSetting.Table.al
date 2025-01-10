table 50033 "TT User Setting"
{
    fields
    {
        field(1; "User Name"; Code[50])
        {
            TableRelation = User."User Name";
            ValidateTableRelation = false;

            trigger OnValidate()
            var
                User_L: Record User;
            begin
                User_L.SetRange("User Name", Rec."User Name");
                if NOT User_L.FindFirst() then
                    Error(UserNotFoundErr);
            end;
        }
        field(10; "Profile ID"; Code[30])
        {
            TableRelation = "All Profile"."Profile ID";

            trigger OnLookup()
            var
                AllProfile_L: Record "All Profile";
                ProfileList_P: Page "Profile List";
                UserPersonalization: Record "User Personalization";
            begin
                ProfileList_P.Editable(false);
                if ProfileList_P.RunModal() = Action::OK then begin
                    ProfileList_P.GetRecord(AllProfile_L);
                    if NOT AllProfile_L.IsEmpty() then begin
                        Rec."Profile ID" := AllProfile_L."Profile ID";
                        UserPersonalization.SetRange("User ID", Rec."User Name");
                        if UserPersonalization.FindFirst() then begin
                            UserPersonalization.Validate("Profile ID", Rec."Profile ID");
                            UserPersonalization.Modify();
                        end;
                    end;
                end;
            end;
        }
        field(20; "Resource No."; Code[20])
        {
            TableRelation = Resource;
        }
        field(30; "Salesperson/Purchaser"; Code[20])
        {
            TableRelation = "Salesperson/Purchaser";
        }
        field(40; "Warehouse Locations"; Integer)
        {
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = count("Warehouse Employee" where("User ID" = field("User Name")));
        }
    }

    keys
    {
        key(key1; "User Name")
        {
            Clustered = true;
        }
    }

    var
        UserNotFoundErr: Label 'Benutzer nicht gefunden.';
}