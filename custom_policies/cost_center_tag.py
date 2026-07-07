from checkov.common.models.enums import CheckResult, CheckCategories
from checkov.terraform.checks.resource.base_resource_check import BaseResourceCheck

class ResourceGroupCostCenterTag(BaseResourceCheck):
    def __init__(self):
        name = "Ensure all Azure Resource Groups have a 'CostCenter' tag for auditing"
        id = "CUSTOM_AZURE_100" # Your custom enterprise rule ID
        supported_resources = ['azurerm_resource_group']
        categories = [CheckCategories.CONVENTION]
        super().__init__(name=name, id=id, categories=categories, supported_resources=supported_resources)

    def scan_resource_conf(self, conf):
        if 'tags' in conf.keys():
            tags = conf['tags'][0]
            # Check if 'CostCenter' is one of the keys within the tags block
            if isinstance(tags, dict) and 'CostCenter' in tags:
                return CheckResult.PASSED
        
        # If no tags exist, or CostCenter is missing, fail the deployment
        return CheckResult.FAILED

check = ResourceGroupCostCenterTag()