const std = @import("std");
usingnamespace std.os.windows;
usingnamespace @import("windows.zig");
usingnamespace @import("dxgicommon.zig");
usingnamespace @import("dxgitype.zig");
usingnamespace @import("dxgiformat.zig");

pub const DXGI_USAGE = packed struct {
    __reserved0: bool align(4) = false,
    __reserved1: bool = false,
    __reserved2: bool = false,
    __reserved3: bool = false,
    SHADER_INPUT: bool = false, // 0x10
    RENDER_TARGET_OUTPUT: bool = false, // 0x20
    BACK_BUFFER: bool = false, // 0x40
    SHARED: bool = false, // 0x80
    READ_ONLY: bool = false, // 0x100
    DISCARD_ON_PRESENT: bool = false, // 0x200
    UNORDERED_ACCESS: bool = false, // 0x400
    __reserved12: bool = false,
    __reserved13: bool = false,
    __reserved14: bool = false,
    __reserved15: bool = false,
    __reserved16: bool = false,
    __reserved17: bool = false,
    __reserved18: bool = false,
    __reserved19: bool = false,
    __reserved20: bool = false,
    __reserved21: bool = false,
    __reserved22: bool = false,
    __reserved23: bool = false,
    __reserved24: bool = false,
    __reserved25: bool = false,
    __reserved26: bool = false,
    __reserved27: bool = false,
    __reserved28: bool = false,
    __reserved29: bool = false,
    __reserved30: bool = false,
    __reserved31: bool = false,
};
comptime {
    std.debug.assert(@sizeOf(DXGI_USAGE) == 4);
    std.debug.assert(@alignOf(DXGI_USAGE) == 4);
}

pub const DXGI_FRAME_STATISTICS = extern struct {
    PresentCount: UINT,
    PresentRefreshCount: UINT,
    SyncRefreshCount: UINT,
    SyncQPCTime: LARGE_INTEGER,
    SyncGPUTime: LARGE_INTEGER,
};

pub const DXGI_MAPPED_RECT = extern struct {
    Pitch: INT,
    pBits: *BYTE,
};

pub const DXGI_ADAPTER_DESC = extern struct {
    Description: [128]WCHAR,
    VendorId: UINT,
    DeviceId: UINT,
    SubSysId: UINT,
    Revision: UINT,
    DedicatedVideoMemory: SIZE_T,
    DedicatedSystemMemory: SIZE_T,
    SharedSystemMemory: SIZE_T,
    AdapterLuid: LUID,
};

pub const DXGI_OUTPUT_DESC = extern struct {
    DeviceName: [32]WCHAR,
    DesktopCoordinates: RECT,
    AttachedToDesktop: BOOL,
    Rotation: DXGI_MODE_ROTATION,
    Monitor: HMONITOR,
};

pub const DXGI_SHARED_RESOURCE = extern struct {
    Handle: HANDLE,
};

pub const DXGI_RESOURCE_PRIORITY = enum(UINT) {
    MINIMUM = 0x28000000,
    LOW = 0x50000000,
    NORMAL = 0x78000000,
    HIGH = 0xa0000000,
    MAXIMUM = 0xc8000000,
};

pub const DXGI_RESIDENCY = enum(UINT) {
    FULLY_RESIDENT = 1,
    RESIDENT_IN_SHARED_MEMORY = 2,
    EVICTED_TO_DISK = 3,
};

pub const DXGI_SURFACE_DESC = extern struct {
    Width: UINT,
    Height: UINT,
    Format: DXGI_FORMAT,
    SampleDesc: DXGI_SAMPLE_DESC,
};

pub const DXGI_SWAP_EFFECT = enum(UINT) {
    DISCARD = 0,
    SEQUENTIAL = 1,
    FLIP_SEQUENTIAL = 3,
    FLIP_DISCARD = 4,
};

pub const DXGI_SWAP_CHAIN_FLAG = packed struct {
    NONPREROTATED: bool align(4) = false, // 0x1
    ALLOW_MODE_SWITCH: bool = false, // 0x2
    GDI_COMPATIBLE: bool = false, // 0x4
    RESTRICTED_CONTENT: bool = false, // 0x8
    RESTRICT_SHARED_RESOURCE_DRIVER: bool = false, // 0x10
    DISPLAY_ONLY: bool = false, // 0x20
    FRAME_LATENCY_WAITABLE_OBJECT: bool = false, // 0x40
    FOREGROUND_LAYER: bool = false, // 0x80
    FULLSCREEN_VIDEO: bool = false, // 0x100
    YUV_VIDEO: bool = false, // 0x200
    HW_PROTECTED: bool = false, // 0x400
    ALLOW_TEARING: bool = false, // 0x800
    RESTRICTED_TO_ALL_HOLOGRAPHIC_DISPLAYS: bool = false, // 0x1000
    __reserved13: bool = false,
    __reserved14: bool = false,
    __reserved15: bool = false,
    __reserved16: bool = false,
    __reserved17: bool = false,
    __reserved18: bool = false,
    __reserved19: bool = false,
    __reserved20: bool = false,
    __reserved21: bool = false,
    __reserved22: bool = false,
    __reserved23: bool = false,
    __reserved24: bool = false,
    __reserved25: bool = false,
    __reserved26: bool = false,
    __reserved27: bool = false,
    __reserved28: bool = false,
    __reserved29: bool = false,
    __reserved30: bool = false,
    __reserved31: bool = false,
};
comptime {
    std.debug.assert(@sizeOf(DXGI_SWAP_CHAIN_FLAG) == 4);
    std.debug.assert(@alignOf(DXGI_SWAP_CHAIN_FLAG) == 4);
}

pub const DXGI_SWAP_CHAIN_DESC = extern struct {
    BufferDesc: DXGI_MODE_DESC,
    SampleDesc: DXGI_SAMPLE_DESC,
    BufferUsage: DXGI_USAGE,
    BufferCount: UINT,
    OutputWindow: HWND,
    Windowed: BOOL,
    SwapEffect: DXGI_SWAP_EFFECT,
    Flags: UINT,
};

pub const IDXGIObject = extern struct {
    const Self = @This();
    v: *const extern struct {
        unknown: IUnknown.VTable(Self),
        object: VTable(Self),
    },
    usingnamespace IUnknown.Methods(Self);
    usingnamespace Methods(Self);

    fn Methods(comptime T: type) type {
        return extern struct {
            pub inline fn SetPrivateData(self: *T, guid: *const GUID, data_size: UINT, data: *const c_void) HRESULT {
                return self.v.object.SetPrivateData(self, guid, data_size, data);
            }
            pub inline fn SetPrivateDataInterface(self: *T, guid: *const GUID, data: ?*const IUnknown) HRESULT {
                return self.v.object.SetPrivateDataInterface(self, guid, data);
            }
            pub inline fn GetPrivateData(self: *T, guid: *const GUID, data_size: *UINT, data: *c_void) HRESULT {
                return self.v.object.GetPrivateData(self, guid, data_size, data);
            }
            pub inline fn GetParent(self: *T, guid: *const GUID, parent: *?*c_void) HRESULT {
                return self.v.object.GetParent(self, guid, parent);
            }
        };
    }

    fn VTable(comptime T: type) type {
        return extern struct {
            SetPrivateData: fn (*T, *const GUID, UINT, *const c_void) callconv(WINAPI) HRESULT,
            SetPrivateDataInterface: fn (*T, *const GUID, ?*const IUnknown) callconv(WINAPI) HRESULT,
            GetPrivateData: fn (*T, *const GUID, *UINT, *c_void) callconv(WINAPI) HRESULT,
            GetParent: fn (*T, *const GUID, *?*c_void) callconv(WINAPI) HRESULT,
        };
    }
};

pub const IDXGIDeviceSubObject = extern struct {
    const Self = @This();
    v: *const extern struct {
        unknown: IUnknown.VTable(Self),
        object: IDXGIObject.VTable(Self),
        devsubobj: VTable(Self),
    },
    usingnamespace IUnknown.Methods(Self);
    usingnamespace IDXGIObject.Methods(Self);
    usingnamespace Methods(Self);

    fn Methods(comptime T: type) type {
        return extern struct {
            pub inline fn GetDevice(self: *T, guid: *const GUID, parent: *?*c_void) HRESULT {
                return self.v.devsubobj.GetDevice(self, guid, parent);
            }
        };
    }

    fn VTable(comptime T: type) type {
        return extern struct {
            GetDevice: fn (*T, *const GUID, *?*c_void) callconv(WINAPI) HRESULT,
        };
    }
};

pub const IDXGIResource = extern struct {
    const Self = @This();
    v: *const extern struct {
        unknown: IUnknown.VTable(Self),
        object: IDXGIObject.VTable(Self),
        devsubobj: IDXGIDeviceSubObject.VTable(Self),
        resource: VTable(Self),
    },
    usingnamespace IUnknown.Methods(Self);
    usingnamespace IDXGIObject.Methods(Self);
    usingnamespace IDXGIDeviceSubObject.Methods(Self);
    usingnamespace Methods(Self);

    fn Methods(comptime T: type) type {
        return extern struct {
            pub inline fn GetSharedHandle(self: *T, handle: *HANDLE) HRESULT {
                return self.v.resource.GetSharedHandle(self, handle);
            }
            pub inline fn GetUsage(self: *T, usage: *DXGI_USAGE) HRESULT {
                return self.v.resource.GetUsage(self, usage);
            }
            pub inline fn SetEvictionPriority(self: *T, priority: UINT) HRESULT {
                return self.v.resource.SetEvictionPriority(self, priority);
            }
            pub inline fn GetEvictionPriority(self: *T, priority: *UINT) HRESULT {
                return self.v.resource.GetEvictionPriority(self, priority);
            }
        };
    }

    fn VTable(comptime T: type) type {
        return extern struct {
            GetSharedHandle: fn (*T, *HANDLE) callconv(WINAPI) HRESULT,
            GetUsage: fn (*T, *DXGI_USAGE) callconv(WINAPI) HRESULT,
            SetEvictionPriority: fn (*T, UINT) callconv(WINAPI) HRESULT,
            GetEvictionPriority: fn (*T, *UINT) callconv(WINAPI) HRESULT,
        };
    }
};

pub const IDXGIKeyedMutex = extern struct {
    const Self = @This();
    v: *const extern struct {
        unknown: IUnknown.VTable(Self),
        object: IDXGIObject.VTable(Self),
        devsubobj: IDXGIDeviceSubObject.VTable(Self),
        mutex: VTable(Self),
    },
    usingnamespace IUnknown.Methods(Self);
    usingnamespace IDXGIObject.Methods(Self);
    usingnamespace IDXGIDeviceSubObject.Methods(Self);
    usingnamespace Methods(Self);

    fn Methods(comptime T: type) type {
        return extern struct {
            pub inline fn AcquireSync(self: *T, key: UINT64, milliseconds: DWORD) HRESULT {
                return self.v.mutex.AcquireSync(self, key, milliseconds);
            }
            pub inline fn ReleaseSync(self: *T, key: UINT64) HRESULT {
                return self.v.mutex.ReleaseSync(self, key);
            }
        };
    }

    fn VTable(comptime T: type) type {
        return extern struct {
            AcquireSync: fn (*T, UINT64, DWORD) callconv(WINAPI) HRESULT,
            ReleaseSync: fn (*T, UINT64) callconv(WINAPI) HRESULT,
        };
    }
};

pub const DXGI_MAP = packed struct {
    READ: bool align(4) = false, // 0x1
    WRITE: bool = false, // 0x2
    DISCARD: bool = false, // 0x4
    __reserved3: bool = false,
    __reserved4: bool = false,
    __reserved5: bool = false,
    __reserved6: bool = false,
    __reserved7: bool = false,
    __reserved8: bool = false,
    __reserved9: bool = false,
    __reserved10: bool = false,
    __reserved11: bool = false,
    __reserved12: bool = false,
    __reserved13: bool = false,
    __reserved14: bool = false,
    __reserved15: bool = false,
    __reserved16: bool = false,
    __reserved17: bool = false,
    __reserved18: bool = false,
    __reserved19: bool = false,
    __reserved20: bool = false,
    __reserved21: bool = false,
    __reserved22: bool = false,
    __reserved23: bool = false,
    __reserved24: bool = false,
    __reserved25: bool = false,
    __reserved26: bool = false,
    __reserved27: bool = false,
    __reserved28: bool = false,
    __reserved29: bool = false,
    __reserved30: bool = false,
    __reserved31: bool = false,
};
comptime {
    std.debug.assert(@sizeOf(DXGI_MAP) == 4);
    std.debug.assert(@alignOf(DXGI_MAP) == 4);
}

pub const IDXGISurface = extern struct {
    const Self = @This();
    v: *const extern struct {
        unknown: IUnknown.VTable(Self),
        object: IDXGIObject.VTable(Self),
        devsubobj: IDXGIDeviceSubObject.VTable(Self),
        surface: VTable(Self),
    },
    usingnamespace IUnknown.Methods(Self);
    usingnamespace IDXGIObject.Methods(Self);
    usingnamespace IDXGIDeviceSubObject.Methods(Self);
    usingnamespace Methods(Self);

    fn Methods(comptime T: type) type {
        return extern struct {
            pub inline fn GetDesc(self: *T, desc: *DXGI_SURFACE_DESC) HRESULT {
                return self.v.surface.GetDesc(self, desc);
            }
            pub inline fn Map(self: *T, locked_rect: *DXGI_MAPPED_RECT, flags: DXGI_MAP) HRESULT {
                return self.v.surface.Map(self, locked_rect, flags);
            }
            pub inline fn Unmap(self: *T) HRESULT {
                return self.v.surface.Unmap(self);
            }
        };
    }

    fn VTable(comptime T: type) type {
        return extern struct {
            GetDesc: fn (*T, *DXGI_SURFACE_DESC) callconv(WINAPI) HRESULT,
            Map: fn (*T, *DXGI_MAPPED_RECT, DXGI_MAP) callconv(WINAPI) HRESULT,
            Unmap: fn (*T) callconv(WINAPI) HRESULT,
        };
    }
};

pub const IDXGIAdapter = extern struct {
    const Self = @This();
    v: *const extern struct {
        unknown: IUnknown.VTable(Self),
        object: IDXGIObject.VTable(Self),
        adapter: VTable(Self),
    },
    usingnamespace IUnknown.Methods(Self);
    usingnamespace IDXGIObject.Methods(Self);
    usingnamespace Methods(Self);

    fn Methods(comptime T: type) type {
        return extern struct {
            pub inline fn EnumOutputs(self: *T, index: UINT, output: *?*IDXGIOutput) HRESULT {
                return self.v.adapter.EnumOutputs(self, index, output);
            }
            pub inline fn GetDesc(self: *T, desc: *DXGI_ADAPTER_DESC) HRESULT {
                return self.v.adapter.GetDesc(self, desc);
            }
            pub inline fn CheckInterfaceSupport(self: *T, guid: *const GUID, umd_ver: *LARGE_INTEGER) HRESULT {
                return self.v.adapter.CheckInterfaceSupport(self, guid, umd_ver);
            }
        };
    }

    fn VTable(comptime T: type) type {
        return extern struct {
            EnumOutputs: fn (*T, UINT, *?*IDXGIOutput) callconv(WINAPI) HRESULT,
            GetDesc: fn (*T, *DXGI_ADAPTER_DESC) callconv(WINAPI) HRESULT,
            CheckInterfaceSupport: fn (*T, *const GUID, *LARGE_INTEGER) callconv(WINAPI) HRESULT,
        };
    }
};
