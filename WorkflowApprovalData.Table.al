table 50031 "Workflow Approval Data"
{
    fields
    {
        field(1; "Record Id"; Guid)
        {
        }
        field(10; Status; Text[100])
        {
        }
        field(20; "Prev Status"; Text[100])
        {
        }
        field(30; "Rejection Reason"; Text[255])
        {
        }
        field(40; "Handled"; Boolean)
        {
        }
        field(100; "Workflow Context"; Text[100])
        {
        }
    }
    keys
    {
        key(key1; "Record Id")
        {
            Clustered = true;
        }
    }
}
