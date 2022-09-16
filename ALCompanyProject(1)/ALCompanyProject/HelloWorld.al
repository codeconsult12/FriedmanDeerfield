table 50101 CompanywiseProjectDetails
{
    Caption = 'CompanywiseProjectDetails';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; ID; Integer)
        {
            Caption = 'ID';
            DataClassification = ToBeClassified;
            AutoIncrement = true;
        }
        /*      field(2; CompanyId; Code[20])
              {
                  Caption = 'Company Id';
                  DataClassification = ToBeClassified;
                  TableRelation = "Company Information".SystemId;
              }
          */
        field(2; CompanyName; Text[150])
        {
            Caption = 'Company Name';
            FieldClass = FlowField;
            TableRelation = Company;
            //            CalcFormula = lookup("Company Information".Name where(SystemId = field(CompanyId)));
        }

        field(3; "Account No."; Code[20])
        {
            Caption = 'Account No.';
            TableRelation = "G/L Account"."No.";
        }
        field(4; "AccountName"; Text[150])
        {
            Caption = 'Account Name';
            FieldClass = FlowField;
            CalcFormula = lookup("G/L Account".Name where("No." = field("Account No.")));

        }

        /*        field(6; ProjectId; Integer)
                {
                    Caption = 'ProjectName';
                    DataClassification = ToBeClassified;
                }
          */
        field(5; ProjectName; Text[100])
        {
            Caption = 'ProjectName';
            DataClassification = ToBeClassified;
        }

    }
    keys
    {
        key(PK; ID)
        {
            Clustered = true;
        }
        /*    key(Key1; CompanyId, ProjectId) //secondary key
            {

            }*/
    }

}
page 50102 CompanyWiseProjects
{

    AutoSplitKey = true;

    DelayedInsert = true;
    PageType = Worksheet;
    PromotedActionCategories = 'New,Process,Report,Page,Post/Print,Line,Account';
    SaveValues = true;

    UsageCategory = Tasks;

    ApplicationArea = All;


    SourceTable = CompanywiseProjectDetails;

    AdditionalSearchTerms = 'Company, projects, companywiseproject, Company Wise Projects';

    layout
    {
        area(content)
        {
            repeater(General)
            {

                field(ID; Rec.ID)
                {
                    ApplicationArea = All;
                    ToolTip = 'It will auto increment';

                }
                /*       field(CompanyId; Rec.CompanyId)
                       {
                           ApplicationArea = All;
                           ToolTip = 'Select Company Id';

                       }
       */
                field(CompanyName; Rec.CompanyName)
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the name of company';

                }
                field("Account No."; Rec."Account No.")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the account number that the entry on the journal line will be posted to.';


                }
                field("Account Name"; Rec.AccountName)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Account Name';
                    Editable = false;
                    ToolTip = 'Specifies the name of the vendor.';
                }
                /*              field(ProjectId; Rec.ProjectId)
                              {
                                  ApplicationArea = All;
                                  ToolTip = 'Please specify project Id';
                              }
                  */
                field(ProjectName; Rec.ProjectName)
                {
                    ApplicationArea = All;
                    ToolTip = 'Please specify project name';
                }
            }
        }
    }

}
