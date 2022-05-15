<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.* " %>
<%@ page import="java.io.*" %>
<%@ page import="java.util.*" %>
<%@ page trimDirectiveWhitespaces="true" %>
<HTML>

<style type="text/css" media="screen">
#container {
    height: 265px;
    margin-left: 10 px;
}

.highcharts-figure,
.highcharts-data-table table {
    min-width: 310px;
    max-width: 800px;
    margin: 1em auto;
}

.highcharts-data-table table {
    font-family: Verdana, sans-serif;
    border-collapse: collapse;
    border: 1px solid #ebebeb;
    margin: 10px auto;
    text-align: center;
    width: 100%;
    max-width: 500px;
}

.highcharts-data-table caption {
    padding: 1em 0;
    font-size: 1.2em;
    color: #555;
}

.highcharts-data-table th {
    font-weight: 600;
    padding: 0.5em;
}

.highcharts-data-table td,
.highcharts-data-table th,
.highcharts-data-table caption {
    padding: 0.5em;
}

.highcharts-data-table thead tr,
.highcharts-data-table tr:nth-child(even) {
    background: #f8f8f8;
}

.highcharts-data-table tr:hover {
    background: #f1f7ff;
}


</style>

<figure class="highcharts-figure">
    <div id="container"></div>
    <p class="highcharts-description">
    </p>
</figure>
<table id="jqGrid01">
</table>
<div id="jQGridDemoPager" style="height: 25px;">
</div>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jqueryui/1.11.4/themes/redmond/jquery-ui.min.css" />
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/free-jqgrid/4.15.2/css/ui.jqgrid.min.css" />
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/free-jqgrid/4.15.2/jquery.jqgrid.min.js"></script>

<script src="https://code.highcharts.com/highcharts.js"></script>
<script src="https://code.highcharts.com/highcharts-3d.js"></script>
<script src="https://code.highcharts.com/modules/exporting.js"></script>
<script src="https://code.highcharts.com/modules/export-data.js"></script>
<script src="https://code.highcharts.com/modules/accessibility.js"></script>

<script type="text/javascript">
    $(function () {
     <%
	
		String driver = "org.postgresql.Driver";
		String url = "jdbc:postgresql://localhost:5432/testdb";
		String username = "postgres";
		String password = "suguna";
		String myDataField = null;
		Connection myConnection = null;
		ResultSet myResultSet = null;
		PreparedStatement myPreparedStatement = null;
				
		String myQuery = "SELECT * FROM beneficiary";
		Class.forName(driver).newInstance();
		myConnection = DriverManager.getConnection(url,username,password);
		myPreparedStatement = myConnection.prepareStatement(myQuery);
		myResultSet = myPreparedStatement.executeQuery();
		ArrayList idList = new ArrayList();
		ArrayList BeneficiaryList = new ArrayList();
		ArrayList RelationList = new ArrayList();
		ArrayList AssetList = new ArrayList();
		ArrayList PercentList = new ArrayList();
		//ArrayList DiffCountList = new ArrayList();
		
		ArrayList assetList=new ArrayList();
		ArrayList assetValueList=new ArrayList();
		
		int ctr=0;
		while(myResultSet.next())
		{
			idList.add(myResultSet.getString(1));
			BeneficiaryList.add(myResultSet.getString(2));
			RelationList.add(myResultSet.getString(3));
			AssetList.add(myResultSet.getString(4));
			PercentList.add(myResultSet.getString(5));
			//DiffCountList.add(myResultSet.getString(6));
			
		}
		
		myQuery = "SELECT * FROM assets";
		Class.forName(driver).newInstance();
		myConnection = DriverManager.getConnection(url,username,password);
		myPreparedStatement = myConnection.prepareStatement(myQuery);
		myResultSet = myPreparedStatement.executeQuery();
		while(myResultSet.next())
		{
			assetList.add(myResultSet.getString(1));
			assetValueList.add(myResultSet.getString(2));
		}

		
		
	%>

var customers = [
<%for(int j=0;j<idList.size();j++)
	{
	  String strToolsDetails="";
	  strToolsDetails= idList.get(j).toString();
		
	  out.println("{ id: \""+idList.get(j).toString()+"\", Beneficiary: \""+BeneficiaryList.get(j).toString()+"\", Relation: \""+RelationList.get(j).toString()+"\" , Asset: \""+AssetList.get(j).toString()+"\", Percent: \""+PercentList.get(j).toString()+"\"},");}%>
];



		var customers1 = [
                        { id: "1", Beneficiary: "Sanjay", Relation: "Son", Asset: "MutualFund", Percent: "10" },
                        { id: "2", Beneficiary: "Anil", Relation: "Son", Asset: "MutualFund", Percent: "50" },
				{ id: "3", Beneficiary: "Neeta", Relation: "Wife", Asset: "MutualFund", Percent: "20" },
				{ id: "4", Beneficiary: "Sharada", Relation: "Mother", Asset: "MutualFund", Percent: "20" },
				{ id: "5", Beneficiary: "Suman", Relation: "Daughter", Asset: "RealEstate", Percent: "30" }
                        ];

        $("#jqGrid01").jqGrid({
            datatype: "jsonstring",
            datastr: customers,
            colNames: ["Id", "Beneficiary", "Relation","Asset","Percentage"],
            colModel: [
                        { name: 'id', index: 'id', hidden: false, key: true },
                        { name: 'Beneficiary', index: 'Beneficiary', align: 'center', editable: true,
				    formatter: 'select', editable: true, edittype: 'select', stype: 'select',
                            editoptions: { value: <%
									String globalStr="\"";
									String str="";
								for(int k1=0;k1<BeneficiaryList.size()-1;k1++)
								{ 
								 str=BeneficiaryList.get(k1)+":"+BeneficiaryList.get(k1)+";";
								 globalStr=globalStr.concat(str);
								}
								globalStr=globalStr.substring(0,globalStr.length()-1);
								globalStr=globalStr.concat("\"");
								out.print(globalStr);
								
								%>}
							 
				},
				{ name: 'Relation', index: 'Relation', align: 'center', editable: true,
				    formatter: 'select', editable: true, edittype: 'select', stype: 'select',
                            editoptions: { value: "Son:Son;Daughter:Daughter;Spouse:Spouse;Mother:Mother" }
				},
                        { name: 'Asset', index: 'Asset', align: 'center', sortable: true, cellEdit: true,
                            formatter: 'select', editable: true, edittype: 'select', stype: 'select',
                            editoptions: { value: "MutualFund:MutualFund;BankDeposit:BankDeposit;RealEstate:RealEstate;Stocks:Stocks" }
                        },
				{ name: 'Percent', index: 'Percent', align: 'center', editable: true,sorttype:"float", formatter:"number", summaryType:'sum'}
                    ],
            height: '200',
            width: '1250',
            rowNum: 10,
            editable: true,
            loadonce: true,
            rowList: [30, 40, 50],
            pager: "#jQGridDemoPager",
            sortname: 'id',
            viewrecords: true,
            sortorder: 'desc',
            gridview: true,
		grouping:true,
   		groupingView : {
   		groupField : ['Asset'],
		groupSummary : [true],
   		groupColumnShow : [true],
   		groupText : ['<b>{0}</b>'],
   		groupCollapse : false,
		groupOrder: ['asc']
		},
            treeGrid: false,
            treeGridModel: 'adjacency',
            treedatatype: "local",
            ExpandColumn: 'name',
            add: true,
            edit: true,
            addtext: 'Add',
            edittext: 'Edit',
            caption: "Digital Will Service",
		
        });
 
        $("#jqGrid01").jqGrid('navGrid', '#jQGridDemoPager',
                                { edit: true, add: true, del: true, search: true },
                                { height: 300, reloadAfterSubmit: true }
                            );
        $("#jqGrid01").jqGrid('setGridWidth', $(".content").width(), true);

	 
    });
</script>

<script type="text/javascript">
Highcharts.chart('container', {
    chart: {
        type: 'pie',
        options3d: {
            enabled: true,
            alpha: 45
        }
    },
    title: {
        text: 'Digital Will Service\'s Asset Allocation'
    },
    subtitle: {
        text: 'I here by Execute my will as follows'
    },
    plotOptions: {
        pie: {
            innerSize: 100,
            depth: 45
        }
    },
    series: [{
        name: 'Share',
        data: [
           <%for(int j1=0;j1<assetList.size();j1++)
							{ out.println("['"+assetList.get(j1).toString()+"', "+assetValueList.get(j1)+"],");}%>
        ]
    }]
});
</script>



</HTML>