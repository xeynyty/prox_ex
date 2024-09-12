defmodule ProxEx do
  @moduledoc """
  Documentation for `ProxEx`.
  """

  alias ProxEx.Api


  @spec nodes({String.t(), String.t()}) :: {:ok, [Api.proxnode()]} | {:error, term()}
  def nodes({host, token}) do
    Api.nodes({host, token})
  end

  @spec node_disks({String.t(), String.t()}, String.t()) :: {:ok, [Api.proxdisk()]} | {:error, term()}
  def node_disks({host, token}, node) do
    Api.node_disks({host, token}, node)
  end

  @spec vm_list({String.t(), String.t()}, String.t()) :: {:ok, [Api.proxvm()]} | {:error, term()}
  def vm_list({host, token}, node) do
    Api.vm_list({host, token}, node)
  end

  @spec vm_status({String.t(), String.t()}, String.t(), integer()) ::
  {:ok, Api.proxvm_status_alive()} |
  {:ok, Api.proxvm_status_stopped()} |
  {:error, term()}
  def vm_status({host, token}, node, vmid) do
    Api.vm_status({host, token}, node, vmid)
  end

  @spec vm_network_interfaces({String.t(), String.t()}, String.t(), integer()) :: {:ok, list()} | {:error, term()}
  def vm_network_interfaces({host, token}, node, vmid) do
    Api.vm_network_interfaces({host, token}, node, vmid)
  end

  @spec vm_start({String.t(), String.t()}, String.t(), integer()) :: {:ok, String.t()} | {:error, term()}
  def vm_start({host, token}, node, vmid) do
    Api.vm_start({host, token}, node, vmid)
  end

  @spec vm_stop({String.t(), String.t()}, String.t(), integer()) :: {:ok, String.t()} | {:error, term()}
  def vm_stop({host, token}, node, vmid) do
    Api.vm_stop({host, token}, node, vmid)
  end

  @spec vm_info({String.t(), String.t()}, String.t(), integer()) :: {:ok, Api.proxvm_info()} | {:error, term()}
  def vm_info({host, token}, node, vmid) do
    Api.vm_info({host, token}, node, vmid)
  end

  def vm_fs_info({host, token}, node, vmid) do
    Api.vm_fs_info({host, token}, node, vmid)
  end
end
