package pageobjects;

import java.util.List;

import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;

import com.provar.core.testapi.annotations.*;

@Page( title="account"                                
     , summary=""
     , relativeUrl=""
     , connection="SalesForce"
     )             
public class account {

	@TextType()
	@FindBy(xpath = "//div[contains(@class, 'active') and contains(@class, 'open') and (contains(@class, 'forceModal') or contains(@class, 'uiModal'))][last()]//input[@id='combobox-input-344']")
	public WebElement AccountId;
	@TextType()
	@FindBy(xpath = "//span[text()='Phone Inquiry' and normalize-space(.)='Phone Inquiry']")
	public WebElement LeadSource;
	@TextType()
	@FindBy(xpath = "//div[contains(@class, 'active') and contains(@class, 'open') and (contains(@class, 'forceModal') or contains(@class, 'uiModal'))][last()]//input[@id='input-220']")
	public WebElement CloseDate;
	@LinkType()
	@FindBy(xpath = "//li[1]/a[normalize-space(.)='Download sample txt file']")
	public WebElement downloadSampleTxtFile;
	@TextType()
	@FindBy(xpath = "//div[@id='sfdc_username_container']//input")
	public WebElement renderFacet1060;
	@TextType()
	@FindBy(xpath = "//span[normalize-space(.)='DYNAMO X2']/slot[@name='outputField']/lightning-formatted-text")
	public WebElement productName;
	@TextType() @FindBy(xpath="//span[normalize-space(.)='DYNAMO X2']") public WebElement _;
	@ButtonType()
	@FindBy(xpath = "//a[@input]")
	public WebElement save;
	@TextType()
	@FindBy(xpath = "//div[@input='a']")
	public WebElement reg;
			
}
