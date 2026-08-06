import unittest
from core_module_v2 import UpgradedDataProcessor, ModuleUpgradeError

class TestUpgradedDataProcessor(unittest.TestCase):
    def setUp(self):
        self.processor = UpgradedDataProcessor()

    def test_successful_processing(self):
        sample_data = ["packet_alpha", "packet_beta", "   "]
        result = self.processor.process_payload(sample_data)
        self.assertEqual(result["status"], "success")
        self.assertEqual(result["total_processed"], 2)
        self.assertEqual(self.processor.state, "COMPLETED")

    def test_strict_mode_failure(self):
        strict_processor = UpgradedDataProcessor(config={"mode": "strict", "retry_limit": 1})
        invalid_data = [None, "valid_packet"]
        with self.assertRaises(ModuleUpgradeError):
            strict_processor.process_payload(invalid_data)

if __name__ == "__main__":
    unittest.main()
