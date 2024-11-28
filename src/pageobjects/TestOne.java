package pageobjects;

import java.util.List;

import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;

import com.provar.core.testapi.annotations.*;

@Page( title="Test One"                                
     , summary="aa"
     , relativeUrl=""
     , connection="SalesForce"
     )             
public class TestOne {

	@TextType() @FindBy(xpath="//h2[normalize-space(.)='We hit a snag.']") public WebElement _;
			
}
