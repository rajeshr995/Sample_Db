
/****** Object:  StoredProcedure [dbo].[csp_GetAllReportingCounties]    Script Date: 05/10/2019 11:52:16 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[csp_GetAllReportingCounties]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[csp_GetAllReportingCounties]
GO

/****** Object:  StoredProcedure [dbo].[csp_GetAllReportingCounties]    Script Date: 05/10/2019 11:52:16 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[csp_GetAllReportingCounties] 

AS 

/*********************************************************************                                                                                          
File Procedure: dbo.csp_GetAllReportingCounties

Customer: Streamline

Input Parameters:	

Called By:

**  Date:			Author:				Description:
**  --------		--------			------------------------------------------- 
**	13/Nov/2020		Rajesh		    What/Why: Created stored procedure to get the list of County used for the filters on the report 'LevelofCare Report'
											  as part of Engineering Improvement Initiatives- NBL(I)#1146.
*********************************************************************/

  BEGIN 
      BEGIN TRY
	    	   
		SELECT CountyFIPS,CountyName FROM Counties
		WHERE CountyFIPS IN (SELECT IntegerCodeId FROM ssf_RecodeValuesCurrent('XReportingCounties') RC)
		
	END TRY 

  BEGIN CATCH 
          DECLARE @Error VARCHAR(8000) 

      SET @Error = CONVERT(VARCHAR, ERROR_NUMBER()) + '*****' + CONVERT(VARCHAR(4000), ERROR_MESSAGE()) + '*****' 
                   + ISNULL(CONVERT(VARCHAR, ERROR_PROCEDURE()), 'csp_GetAllReportingCounties') + '*****' + CONVERT(VARCHAR, ERROR_LINE()) 
                   + '*****' + CONVERT(VARCHAR, ERROR_SEVERITY()) + '*****' + CONVERT(VARCHAR, ERROR_STATE()) 
      RAISERROR ( @Error, 
                  -- Message text.                                                                      
                  16, 
                  -- Severity.                                                             
                  1 
      -- State.                                                          
      ); 
  END CATCH 
END 


GO
