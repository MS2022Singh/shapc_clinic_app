class ModuleUpgradeError(Exception):
    """Custom exception raised for module upgrade and processing errors."""
    pass

class UpgradedDataProcessor:
    def __init__(self, config=None):
        self.config = config or {"mode": "standard", "retry_limit": 3}
        self.state = "IDLE"

    def process_payload(self, payload_data):
        self.state = "PROCESSING"
        if not payload_data:
            self.state = "FAILED"
            raise ModuleUpgradeError("Payload data cannot be empty.")
            
        processed_count = 0
        for item in payload_data:
            if self.config.get("mode") == "strict" and item is None:
                self.state = "FAILED"
                raise ModuleUpgradeError("Strict mode failure: Invalid null item encountered.")
            if item is not None and str(item).strip() != "":
                processed_count += 1

        self.state = "COMPLETED"
        return {
            "status": "success",
            "total_processed": processed_count,
            "config_mode": self.config.get("mode")
        }
