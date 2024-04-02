Data loader

```python
import pandas as pd


if 'data_loader' not in globals():
    from mage_ai.data_preparation.decorators import data_loader
if 'test' not in globals():
    from mage_ai.data_preparation.decorators import test


@data_loader
def load_data(*args, **kwargs):
    url_lap_times = 'https://github.com/FranciscoOrtizTena/de_zoomcamp_project_01/raw/main/raw_data_from_kaggle/lap_times.csv.zip'
    df_lap_times = pd.read_csv(url_lap_times)

    return df_lap_times


@test
def test_output(output, *args) -> None:
    """
    Template code for testing the output of the block.
    """
    assert output is not None, 'The output is undefined'
```

Transformer
```python
import numpy as np
import pandas as pd
from datetime import timedelta

if 'transformer' not in globals():
    from mage_ai.data_preparation.decorators import transformer
if 'test' not in globals():
    from mage_ai.data_preparation.decorators import test


@transformer
def transform(data, *args, **kwargs):
    def convert_to_timedelta(time_string):
        parts = time_string.split(':')
        
        # Initialize default values
        hours = 0
        minutes = 0
        seconds = 0
        milliseconds = 0
        
        # Check how many parts there are to determine if hours are included
        if len(parts) == 3: # Hours, minutes, and seconds.milliseconds
            hours, minutes, seconds_millis = parts
            seconds, milliseconds = seconds_millis.split('.')
        elif len(parts) == 2: # Minutes and seconds.milliseconds
            minutes, seconds_millis = parts
            seconds, milliseconds = seconds_millis.split('.')
        
        # Convert the values to integers
        hours = int(hours)
        minutes = int(minutes)
        seconds = int(seconds)
        milliseconds = int(milliseconds)
        
        # Convert to timedelta
        return timedelta(hours=hours, minutes=minutes, seconds=seconds, milliseconds=milliseconds)

    data['time'] = data['time'].apply(convert_to_timedelta)

    return data


@test
def test_output(output, *args) -> None:
    """
    Template code for testing the output of the block.
    """
    assert output is not None, 'The output is undefined'

```

Data exporter

```python
from mage_ai.settings.repo import get_repo_path
from mage_ai.io.config import ConfigFileLoader
from mage_ai.io.google_cloud_storage import GoogleCloudStorage
from pandas import DataFrame
from os import path

if 'data_exporter' not in globals():
    from mage_ai.data_preparation.decorators import data_exporter


@data_exporter
def export_data_to_google_cloud_storage(df: DataFrame, **kwargs) -> None:
    """
    Template for exporting data to a Google Cloud Storage bucket.
    Specify your configuration settings in 'io_config.yaml'.

    Docs: https://docs.mage.ai/design/data-loading#googlecloudstorage
    """
    config_path = path.join(get_repo_path(), 'io_config.yaml')
    config_profile = 'default'

    bucket_name = 'mage-zoomcamp-francisco-ortiz-3'
    object_key = 'project_01/lap_times.parquet'

    GoogleCloudStorage.with_config(ConfigFileLoader(config_path, config_profile)).export(
        df,
        bucket_name,
        object_key,
    )

```
