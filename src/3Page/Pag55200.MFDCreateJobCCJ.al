page 55200 "MFD Create Job CCJ"
{
    //13:47 17:34
    PageType = StandardDialog;
    ApplicationArea = All;
    UsageCategory = Administration;
    Caption = 'Crear Proyecto';

    layout
    {
        area(Content)
        {
            group("Cost Control Service create Job")
            {
                Caption = 'Crear Proyecto Control Costes Servicios';

                field(ItemJobNo; ItemJobNo)
                {
                    ApplicationArea = All;
                    Caption = 'Nº Producto';
                    ToolTip = 'Indicar el número del producto, que generará un nuevo proyecto para cotrolar sus costes';
                    TableRelation = Item;

                    trigger OnValidate()
                    begin
                        UpdateDescription();
                    end;
                }
                field(JobCustomerNo; JobCustomerNo)
                {
                    ApplicationArea = All;
                    Caption = 'Nº Cliente';
                    ToolTip = 'Indicar el número del cliente que se cumplimentará en el nuevo proyecto';
                    TableRelation = Customer;
                }

            }
            group("New Job")
            {
                Caption = 'Nuevo Proyecto';

                field(NewJobNo; NewJobNo)
                {
                    ApplicationArea = All;
                    Caption = 'Nº nuevo Proyecto';
                    ToolTip = 'Indicar el nuevo número de proyecto. En caso de numeración manual';
                }
                field(DescriptionNewJob; DescriptionNewJob)
                {
                    ApplicationArea = All;
                    Caption = 'Descripción nuevo Proyecto';
                    ToolTip = 'Indicar la descripción del nuevo proyecto vinculado al producto';
                }
            }
            group(Options)
            {
                Caption = 'Opciones';

                field(CopyDimension; CopyDimension)
                {
                    ApplicationArea = All;
                    Caption = 'Copiar Dimensiones';
                    ToolTip = 'Copia las dimensiones del producto al nuevo proyecto';
                }
            }
        }
    }


    var
        ItemJobNo: Code[20];
        JobCustomerNo: Code[20];
        NewJobNo: Code[20];
        DescriptionNewJob: Text[100];

        Item: Record Item;
        CreateJob: Codeunit "MFD Create Service Job CCJ";

        CopyDimension: Boolean;



        Text001Err: Label 'Proporcinar un número correcto de %1', Comment = '%1=Item ';
        Text002Qst: Label 'El Proyecto %1 se va a crear. ¿Desea continuar?', Comment = '%1=Job';
        Text003Msg: Label 'El Proyecto se genero adecuadamente';
        Text004Qst: Label 'Ya existe %1 Proyecto de Control de Costes para el Producto %2 ¿Desea continuar?', Comment = '%1=Job;%2=Item';
        Text005Err: Label 'El Producto debe ser de tipo Servicios';
        Text006Qst: Label 'Ya existe %1 Proyectos de Control de Costes para el Producto %2 ¿Desea continuar?', Comment = '%1=Jobs;%2=Item';
        Text007Err: Label 'Se debe cumplimentar el producto o no existe';
        Text008Err: Label 'Ya existe un proyecto para el producto y no se permiten Multi-proyectos';


    trigger OnOpenPage()
    var
        JobSetup: Record "Jobs Setup";

    begin

        UpdateDescription();

        JobSetup.Get();
        JobCustomerNo := JobSetup."Customer No. CCJ";


    end;

    trigger OnQueryClosePage(CloseAction: Action): Boolean
    var


    begin
        if CloseAction in [Action::OK, Action::LookupOK] then begin
            ValidateUserInput();
            CreateJob.SetCopyOptions(CopyDimension);
            CreateJob.CreateServiceJob(Item, ItemJobNo, NewJobNo, DescriptionNewJob, JobCustomerNo);

            Message(Text003Msg);


        end;

    end;

    procedure SetFromItem(Item2: Record Item)
    begin
        Item := Item2;
        ItemJobNo := Item."No.";

    end;

    local procedure ValidateUserInput()
    var
        JobSetup: Record "Jobs Setup";
        Customer: Record Customer;
        Job: Record Job;
        NoSeriesManagement: Codeunit NoSeriesManagement;

    begin
        If (ItemJobNo = '') or not Item.Get(ItemJobNo) then
            Error(Text007Err);
        if Item.Type <> Item.Type::Service then
            Error(Text005Err);

        //Customer.Init();
        if (JobCustomerNo = '') or not Customer.Get(JobCustomerNo) then
            Error(Text001Err, Customer.TableCaption);

        //Job.Init(); 
        JobSetup.Get();

        Job.SetRange("Item Job No.", ItemJobNo);
        if Job.FindFirst() then begin
            Job.CalcFields("Jobs of Item");
            if (Job."Jobs of Item" >= 1) and JobSetup."Multi-Jobs per Item CCJ" then begin
                if Job."Jobs of Item" = 1 then begin
                    if not Confirm(Text004Qst, false, Job."Jobs of Item", ItemJobNo) then
                        Error('')//rglh comentar porque sale
                end else
                    if not Confirm(Text006Qst, false, Job."Jobs of Item", ItemJobNo) then
                        Error('');
            end;
            if (Job."Jobs of Item" >= 1) and not JobSetup."Multi-Jobs per Item CCJ" then
                Error(Text008Err);


        end;

        JobSetup.Get();
        JobSetup.TestField("Job Nos.");
        if NewJobNo = '' then begin
            NewJobNo := NoSeriesManagement.GetNextNo(JobSetup."Job Nos.", 0D, true);
            if not Confirm(Text002Qst, false, NewJobNo) then begin
                NewJobNo := '';
                Error('');
            end;

        end else
            NoSeriesManagement.TestManual(JobSetup."Job Nos.");

    end;

    local procedure UpdateDescription();
    begin
        if Item.Get(ItemJobNo) then
            DescriptionNewJob := ('CCS' + ' ' + ItemJobNo + ' ' + Item.Description);

    end;

}