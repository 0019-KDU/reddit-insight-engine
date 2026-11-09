from importlib import import_module, metadata

import pytest

import reddit_insight


def test_version_matches_distribution_metadata() -> None:
    assert reddit_insight.__version__ == metadata.version("reddit-insight-engine")


@pytest.mark.parametrize("layer", ["domain", "application", "infrastructure", "interfaces"])
def test_layer_package_is_importable(layer: str) -> None:
    module_name = f"reddit_insight.{layer}"

    assert import_module(module_name).__name__ == module_name
