from .driver_fake_io import DriverFakeIo
from .driver_std_serial import DriverStdSerial
from .driver_platform import DriverPlatform

PZA_DRIVERS_LIST=[
    DriverPlatform,
    DriverFakeIo,
    DriverStdSerial
]

