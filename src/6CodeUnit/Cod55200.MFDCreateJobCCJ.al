codeunit 55200 "MFD Create Service Job CCJ"
{
    trigger OnRun()
    begin

    end;

    var
        CopyDimensions: Boolean;

    procedure CreateServiceJob(Item: Record Item; ItemNo: Code[20]; NewJobNo: Code[20]; NewJobDescription: Text[100]; CustomerJobNo: Code[20])
    var
        NewJob: Record Job;
        JobsSetup: Record "Jobs Setup";

    begin
        JobsSetup.Get();

        NewJob.Init();//sin el tambien funciona
        NewJob."No." := NewJobNo;
        NewJob.Description := NewJobDescription;
        //Message('no genera el Research Description por que');//otra forma de debuggear
        NewJob.Validate("Bill-to Customer No.", CustomerJobNo);
        NewJob.Validate("Item Job No.", ItemNo);

        NewJob.Validate("Job Posting Group", JobsSetup."Job Posting Group CCJ");
        NewJob.Validate("WIP Method", JobsSetup."Method WIP CCJ");
        NewJob.Insert(true);

        NewJob.Validate("Allow Schedule/Contract Lines", false);
        NewJob.Validate("Apply Usage Link", false);

        CreateJobTask(NewJob, NewJobDescription);

        NewJob.Modify();

        if CopyDimensions then
            CopyItemDimensions(Item, NewJob);

        //10:44


    end;

    local procedure CreateJobTask(CreateJob: Record Job; DescriptionJob: Text[100])
    var
        NewJobTask: Record "Job Task";
        DescriptionTask: Text[100];
        Text001Txt: Label 'COSTES';
        Text002Txt: Label 'Imputación';

    begin

        //NewJobTask.SetRange("Job No.", CreateJob."No.");
        //if NewJobTask.FindLast() then begin
        NewJobTask.Init();
        NewJobTask.Validate("Job No.", CreateJob."No.");
        NewJobTask.Validate("Job Task No.", Text001Txt);
        DescriptionTask := (Text002Txt + ' ' + DescriptionJob);
        NewJobTask.Validate(Description, DescriptionTask);
        NewJobTask.Insert();
        //end;

    end;

    procedure SetCopyOptions(CopyDimensions2: Boolean)
    begin
        CopyDimensions := CopyDimensions2;

    end;

    local procedure CopyItemDimensions(ItemDim: Record Item; NewCreateJob: Record Job)
    var
        DefaultDimension: Record "Default Dimension";
        NewDefaultDimension: Record "Default Dimension";
        DimMgt: Codeunit DimensionManagement;

    begin
        DefaultDimension.SetRange("Table ID", Database::Job);
        DefaultDimension.SetRange("No.", NewCreateJob."No.");
        if DefaultDimension.FindSet() then
            repeat
                DimMgt.DefaultDimOnDelete(DefaultDimension);
                DefaultDimension.Delete();
            until DefaultDimension.Next() = 0;

        DefaultDimension.SetRange("Table ID", Database::Item);
        DefaultDimension.SetRange("No.", ItemDim."No.");
        if DefaultDimension.FindSet() then
            repeat
                NewDefaultDimension.Init();
                NewDefaultDimension."Table ID" := Database::Job;
                NewDefaultDimension."No." := NewCreateJob."No.";
                NewDefaultDimension."Dimension Code" := DefaultDimension."Dimension Code";
                NewDefaultDimension.TransferFields(DefaultDimension, false);
                NewDefaultDimension.Insert();
                DimMgt.DefaultDimOnInsert(DefaultDimension);
            until DefaultDimension.Next() = 0;

        DimMgt.UpdateDefaultDim(Database::Job, NewCreateJob."No.", NewCreateJob."Global Dimension 1 Code", NewCreateJob."Global Dimension 2 Code");


    end;

    local procedure gitfuntion()
    begin

    end;








}