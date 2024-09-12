defmodule ProxEx.Api do
  @moduledoc """
    Documentation for `ProxEx.Api`.

    TODO - Add description
    TODO - Add example
    TODO - Add types
  """


  # Just a request_get wrapper for api requests
  @spec request_get(String.t(), String.t(), String.t()) :: {:ok, Req.Response.t()} | {:error, term()}
  defp request_get(host, token, path) do
    Req.get("#{host}/api2/json/#{path}",
      headers: [Authorization: "PVEAPIToken=" <> token],
      connect_options: [transport_opts: [verify: :verify_none]] # The instruction for Req is not to verify the authenticity of the certificate
    )
  end

  @spec request_post(String.t(), String.t(), String.t()) :: {:ok, Req.Response.t()} | {:error, term()}
  defp request_post(host, token, path) do
    Req.post("#{host}/api2/json/#{path}",
      headers: [Authorization: "PVEAPIToken=" <> token],
      connect_options: [transport_opts: [verify: :verify_none]] # The instruction for Req is not to verify the authenticity of the certificate
    )
  end

  @type proxnode() :: %{
          id: String.t(),
          level: String.t(),
          node: String.t(),
          ssl_fingerptint: String.t(),
          type: String.t()
        }

  @type proxdisk() :: %{
          by_id_link: String,
          devpath: String,
          gpt: Integer,
          health: String,
          model: String,
          osdid: Integer,
          "osdid-list": String,
          rpm: Integer,
          serial: String,
          size: Integer,
          type: String,
          used: String,
          vendor: String,
          wearout: Integer,
          wwn: String
        }

  @type proxvm() :: %{
      cpu: non_neg_integer(),
      cpus: non_neg_integer(),
      disk: non_neg_integer(),
      diskread: non_neg_integer(),
      diskwrite: non_neg_integer(),
      maxdisk: non_neg_integer(),
      maxmem: non_neg_integer(),
      mem: non_neg_integer(),
      name: String.t(),
      netin: non_neg_integer(),
      netout: non_neg_integer(),
      status: String.t(),
      uptime: non_neg_integer(),
      vmid: non_neg_integer()
  }

  @type proxvm_info() :: %{
      vmgenid: String.t(),
      scsi0: String.t(),
      meta: String.t(),
      memory: String.t(),
      agent: String.t(),
      description: String.t(),
      scsihw: String.t(),
      boot: String.t(),
      ide2: String.t(),
      onboot: integer(),
      name: String.t(),
      digest: String.t(),
      sockets: integer(),
      net0: String.t(),
      smbios1: String.t(),
      ostype: String.t(),
      balloon: integer(),
      cores: integer(),
      numa: integer()
  }

  @type proxvm_status_alive() :: %{
    agent: 1,
      blockstat: %{
        ide2: %{
          idle_time_ns: integer(),
          rd_total_time_ns: integer(),
          timed_stats: [],
          wr_total_time_ns: integer(),
          rd_bytes: integer(),
          rd_merged: integer(),
          zone_append_total_time_ns: integer(),
          failed_wr_operations: integer(),
          unmap_total_time_ns: integer(),
          invalid_rd_operations: integer(),
          wr_bytes: integer(),
          unmap_operations: integer(),
          wr_merged: integer(),
          flush_operations: integer(),
          failed_flush_operations: integer(),
          wr_operations: integer(),
          account_invalid: boolean(),
          unmap_bytes: integer(),
          zone_append_operations: integer(),
          zone_append_merged: integer(),
          invalid_wr_operations: integer(),
          zone_append_bytes: integer(),
          invalid_flush_operations: integer(),
          failed_zone_append_operations: integer(),
          flush_total_time_ns: integer(),
          failed_rd_operations: integer(),
          unmap_merged: integer(),
          wr_highest_offset: integer(),
          invalid_unmap_operations: integer(),
          invalid_zone_append_operations: integer(),
          account_failed: boolean(),
          failed_unmap_operations: integer(),
          rd_operations: integer()
        },
        scsi0: %{
          idle_time_ns: integer(),
          rd_total_time_ns: integer(),
          timed_stats: [],
          wr_total_time_ns: integer(),
          rd_bytes: integer(),
          rd_merged: integer(),
          zone_append_total_time_ns: integer(),
          failed_wr_operations: integer(),
          unmap_total_time_ns: integer(),
          invalid_rd_operations: integer(),
          wr_bytes: integer(),
          unmap_operations: integer(),
          wr_merged: integer(),
          flush_operations: integer(),
          failed_flush_operations: integer(),
          wr_operations: integer(),
          account_invalid: boolean(),
          unmap_bytes: integer(),
          zone_append_operations: integer(),
          zone_append_merged: integer(),
          invalid_wr_operations: integer(),
          zone_append_bytes: integer(),
          invalid_flush_operations: integer(),
          failed_zone_append_operations: integer(),
          flush_total_time_ns: integer(),
          failed_rd_operations: integer(),
          unmap_merged: integer(),
          wr_highest_offset: integer(),
          invalid_unmap_operations: integer(),
          invalid_zone_append_operations: integer(),
          account_failed: boolean(),
          failed_unmap_operations: integer(),
          rd_operations: integer()
        }
      },
      cpu: float(),
      cpus: integer(),
      disk: integer(),
      diskread: integer(),
      diskwrite: integer(),
      ha: %{managed: integer()},
      maxdisk: integer(),
      maxmem: integer(),
      mem: integer(),
      name: String.t(),
      netin: integer(),
      netout: integer(),
      nics: %{optional(String.t()) => %{netin: integer(), netout: integer()}},
      pid: integer(),
      proxmox_support: %{
        "backup-max-workers": boolean(),
        "pbs-dirty-bitmap": boolean(),
        "pbs-dirty-bitmap-migration": boolean(),
        "pbs-dirty-bitmap-savevm": boolean(),
        "pbs-library-version": String.t(),
        "pbs-masterkey": boolean(),
        "query-bitmap-info": boolean()
      },
      qmpstatus: String.t(),
      running_machine: String.t(),
      running_qemu: String.t(),
      status: String.t(),
      uptime: integer(),
      vmid: integer()
  }

  @type proxvm_status_stopped() :: %{
    agent: integer(),
    cpu: float(),
    cpus: integer(),
    disk: integer(),
    diskread: integer(),
    diskwrite: integer(),
    ha: %{managed: integer()},
    maxdisk: integer(),
    maxmem: integer(),
    mem: integer(),
    name: String.t(),
    netin: integer(),
    netout: integer(),
    qmpstatus: String.t(),
    status: String.t(),
    uptime: integer(),
    vmid: integer()
  }

  @type proxvm_network_intefraces() :: %{
    hardware_address: String.t(),
    ip_addresses: [
      %{
        ip_address: String.t(),
        ip_address_type: String.t(),
        prefix: integer()
      }
    ],
    name: String.t(),
    statistics: %{
      rx_bytes: integer(),
      rx_dropped: integer(),
      rx_errs: integer(),
      rx_packets: integer(),
      tx_bytes: integer(),
      tx_dropped: integer(),
      tx_errs: integer(),
      tx_packets: integer()
    }
  }

  @type proxvm_fs_info() :: %{
    disk: [
      %{
        bus: integer(),
        bus_type: String.t(),
        dev: String.t(),
        pci_controller: %{
          bus: integer(),
          domain: integer(),
          function: integer(),
          slot: integer()
        },
        serial: String.t(),
        target: integer(),
        unit: integer()
      }
    ],
    mountpoint: String.t(),
    name: String.t(),
    total_bytes: integer(),
    type: String.t(),
    used_bytes: integer()
  }

  @doc """
  Get a list of nodes in a cluster

  ## Example

      iex> ProxEx.Api.nodes({"https://127.0.0.1:8006", "*secret token*"})
      {:ok, %{
        "cpu" => 0.339869826435247,
        "disk" => 7491584,
        "id" => "node/v1",
        "level" => "",
        "maxcpu" => 24,
        "maxdisk" => 44760915968,
        "maxmem" => 135148740608,
        "mem" => 88237096960,
        "node" => "v1",
        "ssl_fingerprint" => "12:18:4D:...:87:B8:68",
        "status" => "online",
        "type" => "node",
        "uptime" => 3303049
      }}
  """
  @spec nodes({String.t(), String.t()}) :: {:ok, [proxnode()]}
  def nodes({addr, token}) do
    case request_get(addr, token, "nodes") do
      {:ok, %{body: %{"data" => data}}} -> {:ok, data}
      {:error, error} -> {:error, error}
    end
  end

  @doc """
  Get a list of disks in a node

  ## Example

      iex> node_disks({"https://127.0.0.1:8006", "*secret token*"}, "node")
      {:ok, [
        %{
          "by_id_link" => "/dev/disk/by-id/scsi-3600508b1001cf85bbf0924e1f842e4e8",
          "devpath" => "/dev/sdb",
          "gpt" => 1,
          "health" => "UNKNOWN",
          "model" => "LOGICAL_VOLUME",
          "osdid" => -1,
          "osdid-list" => nil,
          "rpm" => -1,
          "serial" => "600508b1001cf85bbf0924e1f842e4e8",
          "size" => 8001461248000,
          "type" => "unknown",
          "used" => "ext4",
          "vendor" => "HP      ",
          "wearout" => "N/A",
          "wwn" => "0x600508b1001cf85b"
        }
      ]}
  """
  @spec node_disks({String.t(), String.t()}, String.t()) :: {:ok, [proxdisk()]} | {:error, term()}
  def node_disks({addr, token}, node) do
    case request_get(addr, token, "nodes/#{node}/disks/list") do
      {:ok, %{body: %{"data" => data}}} -> {:ok, data}
      {:error, error} -> {:error, error}
    end
  end

  @doc """
  Get a list of VMs in a node

  ## Example

      iex> vm_list({"https://127.0.0.1:8006", "*secret token*"}, "node")
      {:ok, [
        %{
          "cpu" => 0,
          "cpus" => 4,
          "disk" => 0,
          "diskread" => 0,
          "diskwrite" => 0,
          "maxdisk" => 128849018880,
          "maxmem" => 17179869184,
          "mem" => 0,
          "name" => "517-A0238",
          "netin" => 0,
          "netout" => 0,
          "status" => "stopped",
          "uptime" => 0,
          "vmid" => 4001
        },
        %{...}
      ]}
  """
  @spec vm_list({String.t(), String.t()}, String.t()) :: {:ok, [proxvm()]} | {:error, term()}
  def vm_list({addr, token}, node) do
    case request_get(addr, token, "nodes/#{node}/qemu") do
      {:ok, %{body: %{"data" => data}}} -> {:ok, data}
      {:error, error} -> {:error, error}
    end
  end

  @doc """
  Get VM info by node and VMID

  ## Example

      iex> vm_info({"https://127.0.0.1:8006", "*secret token*"}, "node", 123)
      {:ok, %{
        "vmgenid": "a539fd39-dd24-4c6c-b987-eb455a90a727",
        "scsi0": "RAID5.2-v118:110/vm-110-disk-0.raw,discard=on,size=100G,ssd=1",
        "meta": "creation-qemu=6.1.0,ctime=1644400056",
        "memory": "16384",
        "agent": "1",
        "description": "test",
        "scsihw": "virtio-scsi-single",
        "boot": "order=scsi0;ide2;net0",
        "ide2": "none,media=cdrom",
        "onboot": 1,
        "name": "a0014test",
        "digest": "77c1b3d00ef4c43ba61f42c1c085a519d3d93434",
        "sockets": 2,
        "net0": "virtio=72:85:57:9D:4C:A7,bridge=vmbr0",
        "smbios1": "uuid=34e7fb13-a824-4910-9459-492bf2553e40",
        "ostype": "l26",
        "balloon": 0,
        "cores": 2,
        "numa": 1
      }}
  """
  @spec vm_info({String.t(), String.t()}, String.t(), integer()) :: {:ok, proxvm_info()} | {:error, term()}
  def vm_info({addr, token}, node, vmid) do
    path = "nodes/#{node}/qemu/#{vmid}/config"

    case request_get(addr, token, path) do
      {:ok, %{body: %{"data" => data}}} -> {:ok, data}
      {:error, error} -> {:error, error}
    end
  end

  @doc """
  Get VM status by node and VMID

  Running and stopped virtual machines will give different results. You can parse the "status" key, it is present in both JSON at the first level

  ## Example

    ### If VM **alive**

      iex> vm_status({"https://127.0.0.1:8006", "*secret token*"}, "node", 123)
      {:ok, %{
      "agent" => 1,
      "blockstat" => %{
        "ide2" => %{
          "idle_time_ns" => 1311026953884124,
          "rd_total_time_ns" => 92013,
          "timed_stats" => [],
          "wr_total_time_ns" => 0,
          "rd_bytes" => 152,
          "rd_merged" => 0,
          "zone_append_total_time_ns" => 0,
          "failed_wr_operations" => 0,
          "unmap_total_time_ns" => 0,
          "invalid_rd_operations" => 0,
          "wr_bytes" => 0,
          "unmap_operations" => 0,
          "wr_merged" => 0,
          "flush_operations" => 0,
          "failed_flush_operations" => 0,
          "wr_operations" => 0,
          "account_invalid" => true,
          "unmap_bytes" => 0,
          "zone_append_operations" => 0,
          "zone_append_merged" => 0,
          "invalid_wr_operations" => 0,
          "zone_append_bytes" => 0,
          "invalid_flush_operations" => 0,
          "failed_zone_append_operations" => 0,
          "flush_total_time_ns" => 0,
          "failed_rd_operations" => 0,
          "unmap_merged" => 0,
          "wr_highest_offset" => 0,
          "invalid_unmap_operations" => 0,
          "invalid_zone_append_operations" => 0,
          "account_failed" => true,
          "failed_unmap_operations" => 0,
          "rd_operations" => 4
        },
        "scsi0" => %{
          "idle_time_ns" => 25901663463,
          "rd_total_time_ns" => 151069382112,
          "timed_stats" => [],
          "wr_total_time_ns" => 11587046527,
          "rd_bytes" => 495474176,
          "rd_merged" => 0,
          "zone_append_total_time_ns" => 0,
          "failed_wr_operations" => 0,
          "unmap_total_time_ns" => 0,
          "invalid_rd_operations" => 0,
          "wr_bytes" => 193690624,
          "unmap_operations" => 0,
          "wr_merged" => 0,
          "flush_operations" => 101576,
          "failed_flush_operations" => 0,
          "wr_operations" => 56429,
          "account_invalid" => true,
          "unmap_bytes" => 0,
          "zone_append_operations" => 0,
          "zone_append_merged" => 0,
          "invalid_wr_operations" => 0,
          "zone_append_bytes" => 0,
          "invalid_flush_operations" => 0,
          "failed_zone_append_operations" => 0,
          "flush_total_time_ns" => 3842172242,
          "failed_rd_operations" => 0,
          "unmap_merged" => 0,
          "wr_highest_offset" => 73333604352,
          "invalid_unmap_operations" => 0,
          "invalid_zone_append_operations" => 0,
          "account_failed" => true,
          "failed_unmap_operations" => 0,
          "rd_operations" => 13900
        }
      },
      "cpu" => 0.434993927411383,
      "cpus" => 4,
      "disk" => 0,
      "diskread" => 495474328,
      "diskwrite" => 193690624,
      "ha" => %{"managed" => 0},
      "maxdisk" => 107374182400,
      "maxmem" => 17179869184,
      "mem" => 3483015408,
      "name" => "a0014test",
      "netin" => 680817698,
      "netout" => 44656287,
      "nics" => %{"tap110i0" => %{"netin" => 680817698, "netout" => 44656287}},
      "pid" => 3961,
      "proxmox-support" => %{
        "backup-max-workers" => true,
        "pbs-dirty-bitmap" => true,
        "pbs-dirty-bitmap-migration" => true,
        "pbs-dirty-bitmap-savevm" => true,
        "pbs-library-version" => "1.4.1 (UNKNOWN)",
        "pbs-masterkey" => true,
        "query-bitmap-info" => true
      },
      "qmpstatus" => "running",
      "running-machine" => "pc-i440fx-8.1+pve0",
      "running-qemu" => "8.1.2",
      "status" => "running",
      "uptime" => 1311053,
      "vmid" => 110
      }}


    And if VM **is stopped**

      {:ok, %{
        "agent" => 1,
        "cpu" => 0,
        "cpus" => 20,
        "disk" => 0,
        "diskread" => 0,
        "diskwrite" => 0,
        "ha" => %{"managed" => 0},
        "maxdisk" => 1503238553600,
        "maxmem" => 68719476736,
        "mem" => 0,
        "name" => "517-SGB",
        "netin" => 0,
        "netout" => 0,
        "qmpstatus" => "stopped",
        "status" => "stopped",
        "uptime" => 0,
        "vmid" => 4037
      }}

  """
  @spec vm_status({String.t(), String.t()}, String.t(), integer()) ::
  {:ok, proxvm_status_alive()}
  | {:ok, proxvm_status_stopped()}
  | {:error, term()}
  def vm_status({addr, token}, node, vmid) do
    path = "nodes/#{node}/qemu/#{vmid}/status/current"
    case request_get(addr, token, path) do
      {:ok, %{body: %{"data" => data}}} -> {:ok, data}
      {:error, error} -> {:error, error}
    end
  end


  @doc """
  Get VM network interfaces
  ## Example

      iex> vm_network_interfaces({"https://127.0.0.1:8006", "*secret token*"}, "node", 123)
      {:ok, [
        %{
          "hardware-address" => "00:00:00:00:00:00",
          "ip-addresses" => [
            %{
              "ip-address" => "127.0.0.1",
              "ip-address-type" => "ipv4",
              "prefix" => 8
            }
          ],
          "name" => "lo",
          "statistics" => %{
            "rx-bytes" => 324095518,
            "rx-dropped" => 0,
            "rx-errs" => 0,
            "rx-packets" => 1938412,
            "tx-bytes" => 324095518,
            "tx-dropped" => 0,
            "tx-errs" => 0,
            "tx-packets" => 1938412
          }
        }, %{...}
      ]}
  """
  @spec vm_network_interfaces({String.t(), String.t()}, String.t(), integer()) :: {:ok, [proxvm_network_intefraces()]} | {:error, term()}
  def vm_network_interfaces({addr, token}, node, vmid) do
    path = "nodes/#{node}/qemu/#{vmid}/agent/network-get-interfaces"
    case request_get(addr, token, path) do
      {:ok, %{body: %{"data" => %{"result" => data}}}} -> {:ok, data}
      {:error, error} -> {:error, error}
    end
  end


  @doc """
  Start a VM
  ## Example

      iex> vm_start({"https://127.0.0.1:8006", "*secret token*"}, "node", 123)
      {:ok, "UPID:nodename:001DE27E:083A591A:66E28BF4:qmstart:vmid:username@pve!token_name:"}
  """
  @spec vm_start({String.t(), String.t()}, String.t(), integer()) :: {:ok, String.t()} | {:error, term()}
  def vm_start({addr, token}, node, vmid) do
    path = "nodes/#{node}/qemu/#{vmid}/status/start"
    case request_post(addr, token, path) do
      {:ok, %{body: %{"data" => data}}} -> {:ok, data}
      {:error, error} -> {:error, error}
    end
  end

  @doc """

  Stop a VM
  ## Example

      iex> vm_stop({"https://127.0.0.1:8006", "*secret token*"}, "node", 123)
      {:ok, "UPID:nodename:001DE27E:083A591A:66E28BF4:qmstop:vmid:username@pve!token_name:"}
  """
  @spec vm_stop({String.t(), String.t()}, String.t(), integer()) :: {:ok, String.t()} | {:error, term()}
  def vm_stop({addr, token}, node, vmid) do
    path = "nodes/#{node}/qemu/#{vmid}/status/stop"
    case request_post(addr, token, path) do
      {:ok, %{body: %{"data" => data}}} -> {:ok, data}
      {:error, error} -> {:error, error}
    end
  end


  @doc """
  ## Example

      iex> vm_fs_info({"https://127.0.0.1:8006", "*secret token*"}, "node", 123)
      {:ok, [
        %{
          "disk" => [
            %{
              "bus" => 0,
              "bus-type" => "scsi",
              "dev" => "/dev/sda3",
              "pci-controller" => %{
                "bus" => 1,
                "domain" => 0,
                "function" => 0,
                "slot" => 1
              },
              "serial" => "0QEMU_QEMU_HARDDISK_drive-scsi0",
              "target" => 0,
              "unit" => 0
            }
          ],
          "mountpoint" => "/boot/efi",
          "name" => "sda3",
          "total-bytes" => 44378112,
          "type" => "vfat",
          "used-bytes" => 14391296
        },
        %{ ... }
      ]}
  """
  @spec vm_fs_info({String.t(), String.t()}, String.t(), integer()) :: {:ok, [proxvm_fs_info()]} | {:error, term()}
  def vm_fs_info({addr, token}, node, vmid) do
    path = "nodes/#{node}/qemu/#{vmid}/agent/get-fsinfo"
    case request_get(addr, token, path) do
      {:ok, %{body: %{"data" => %{"result" => data}}}} -> {:ok, data}
      {:error, error} -> {:error, error}
    end
  end
end
