table 50058 "Employee To Job Type"
{
    fields
    {
        field(1; "User ID"; Code[50])
        {
            TableRelation = User."User Name";
            ValidateTableRelation = false;

            trigger OnValidate()
            var
                User: Record User;
            begin
                User.SetRange("User Name", Rec."User ID");
                if User.IsEmpty() then Error('Benutzer nicht gefunden.');
            end;
        }
        field(10; "Job Type"; Code[10])
        {
            TableRelation = "Job Type";
        }
    }
    keys
    {
        key(key1; "User ID", "Job Type")
        {
            Clustered = true;
        }
    }
}