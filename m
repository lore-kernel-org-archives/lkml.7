Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2E66C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:51:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE8AD20830
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:51:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554141081;
	bh=ligoVCaaHaCAkIsnzJ9H0kd4GdPS18KVmEkNT07FMJY=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=kowEluFc2PVXHJvLUThyZoA8r0QgRbjEphaemC+HmvM3XP+eSL1OlIUsVZ4aI4mG7
	 taNaXXyH/nIoR6+51WdXg1lDPF2gV6P1NP72zJFdoyHalnvAkaOxbmIkJVq6kBko4/
	 pSpngJwOP2R32EwM9Zi0TxeL69GoUnlg4k07msgQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732959AbfDARvU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:51:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:33710 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728763AbfDAR2D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:28:03 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B0B1220830;
        Mon,  1 Apr 2019 17:28:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554139682;
        bh=ligoVCaaHaCAkIsnzJ9H0kd4GdPS18KVmEkNT07FMJY=;
        h=From:To:Cc:Subject:Date:From;
        b=jsX7HuHoIvKL2QaXuqzaZptZvOV0njCUcvUMunOusFOVo9GYtuVU4lJYbAZv4DNP0
         7lnnYHfrleKRlegq5qUQDteOrqJhWsVZ5cL38vMueQBwLhooHjTAPPb760CdKjzLlT
         kAn6nDABrpFeftQQm4ys3tshbO+aGhVoNguND9LI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: [PATCH 4.9 00/56] 4.9.167-stable review
Date:   Mon,  1 Apr 2019 19:02:16 +0200
Message-Id: <20190401170103.398401360@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.167-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.9.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.9.167-rc1
X-KernelTest-Deadline: 2019-04-03T17:01+00:00
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the start of the stable review cycle for the 4.9.167 release.
There are 56 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Wed Apr  3 17:00:20 UTC 2019.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.167-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.9.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 4.9.167-rc1

Eric Biggers <ebiggers@google.com>
    arm64: support keyctl() system call in 32-bit mode

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Revert "USB: core: only clean up what we allocated"

Mathias Nyman <mathias.nyman@linux.intel.com>
    xhci: Fix port resume done detection for SS ports with LPM enabled

Radoslav Gerganov <rgerganov@vmware.com>
    USB: gadget: f_hid: fix deadlock in f_hidg_write()

Sean Christopherson <sean.j.christopherson@intel.com>
    KVM: x86: Emulate MSR_IA32_ARCH_CAPABILITIES on AMD hosts

Sean Christopherson <sean.j.christopherson@intel.com>
    KVM: Reject device ioctls from processes other than the VM's creator

Thomas Gleixner <tglx@linutronix.de>
    x86/smp: Enforce CONFIG_HOTPLUG_CPU when SMP=y

Thomas Gleixner <tglx@linutronix.de>
    cpu/hotplug: Prevent crash when CPU bringup fails on CONFIG_HOTPLUG_CPU=n

Adrian Hunter <adrian.hunter@intel.com>
    perf intel-pt: Fix TSC slip

Yasushi Asano <yasano@jp.adit-jv.com>
    usb: host: xhci-rcar: Add XHCI_TRUST_TX_LENGTH quirk

Fabrizio Castro <fabrizio.castro@bp.renesas.com>
    usb: common: Consider only available nodes for dr_mode

Axel Lin <axel.lin@ingics.com>
    gpio: adnp: Fix testing wrong value in adnp_gpio_direction_input

YueHaibing <yuehaibing@huawei.com>
    fs/proc/proc_sysctl.c: fix NULL pointer dereference in put_links

Wentao Wang <witallwang@gmail.com>
    Disable kgdboc failed by echo space to /sys/module/kgdboc/parameters/kgdboc

Bjørn Mork <bjorn@mork.no>
    USB: serial: option: add Olicard 600

Mans Rullgard <mans@mansr.com>
    USB: serial: option: set driver_info for SIM5218 and compatibles

Lin Yi <teroincn@163.com>
    USB: serial: mos7720: fix mos_parport refcount imbalance on error path

George McCollister <george.mccollister@gmail.com>
    USB: serial: ftdi_sio: add additional NovaTech products

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    USB: serial: cp210x: add new device id

Hoan Nguyen An <na-hoan@jinso.co.jp>
    serial: sh-sci: Fix setting SCSCR_TIE while transferring data

Aditya Pakki <pakki001@umn.edu>
    serial: max310x: Fix to avoid potential NULL pointer dereference

Malcolm Priestley <tvboxspy@gmail.com>
    staging: vt6655: Fix interrupt race condition on device start up.

Malcolm Priestley <tvboxspy@gmail.com>
    staging: vt6655: Remove vif check from vnt_interrupt

Ian Abbott <abbotti@mev.co.uk>
    staging: comedi: ni_mio_common: Fix divide-by-zero for DIO cmdtest

Kangjie Lu <kjlu@umn.edu>
    tty: atmel_serial: fix a potential NULL pointer dereference

Steffen Maier <maier@linux.ibm.com>
    scsi: zfcp: fix scsi_eh host reset with port_forced ERP for non-NPIV FCP devices

Steffen Maier <maier@linux.ibm.com>
    scsi: zfcp: fix rport unblock if deleted SCSI devices on Scsi_Host

Martin K. Petersen <martin.petersen@oracle.com>
    scsi: sd: Quiesce warning if device does not report optimal I/O size

Bart Van Assche <bvanassche@acm.org>
    scsi: sd: Fix a race between closing an sd device and sd I/O

Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
    fs/open.c: allow opening only regular files during execve()

Takashi Iwai <tiwai@suse.de>
    ALSA: pcm: Don't suspend stream in unrecoverable PCM state

Takashi Iwai <tiwai@suse.de>
    ALSA: pcm: Fix possible OOB access in PCM oss plugins

Gustavo A. R. Silva <gustavo@embeddedor.com>
    ALSA: seq: oss: Fix Spectre v1 vulnerability

Gustavo A. R. Silva <gustavo@embeddedor.com>
    ALSA: rawmidi: Fix potential Spectre v1 vulnerability

Christian Lamparter <chunkeey@gmail.com>
    net: dsa: qca8k: remove leftover phy accessors

Olga Kornievskaia <kolga@netapp.com>
    NFSv4.1 don't free interrupted slot on open

Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
    powerpc: bpf: Fix generation of load/store DW instructions

Kohji Okuno <okuno.kohji@jp.panasonic.com>
    ARM: imx6q: cpuidle: fix bug that CPU might not wake up at expected time

Andrea Righi <andrea.righi@canonical.com>
    btrfs: raid56: properly unmap parity page in finish_parity_scrub()

Josef Bacik <josef@toxicpanda.com>
    btrfs: remove WARN_ON in log_dir_items

Eric Dumazet <edumazet@google.com>
    tun: add a missing rcu_read_unlock() in error path

Eric Dumazet <edumazet@google.com>
    tun: properly test for IFF_UP

Finn Thain <fthain@telegraphics.com.au>
    mac8390: Fix mmio access size probe

Xin Long <lucien.xin@gmail.com>
    sctp: get sctphdr by offset in sctp_compute_cksum

Zhiqiang Liu <liuzhiqiang26@huawei.com>
    vxlan: Don't call gro_cells_destroy() before device is unregistered

Eric Dumazet <edumazet@google.com>
    tcp: do not use ipv6 header for ipv4 flow

Maxime Chevallier <maxime.chevallier@bootlin.com>
    packets: Always register packet sk in the same order

Eric Dumazet <edumazet@google.com>
    net: rose: fix a possible stack overflow

Christoph Paasch <cpaasch@apple.com>
    net/packet: Set __GFP_NOWARN upon allocation in alloc_pg_vec

Bjorn Helgaas <bhelgaas@google.com>
    mISDN: hfcpci: Test both vendor & device ID for Digium HFC4S

Eric Dumazet <edumazet@google.com>
    dccp: do not use ipv6 header for ipv4 flow

Bhadram Varka <vbhadram@nvidia.com>
    stmmac: copy unicast mac address to MAC registers

Johannes Berg <johannes.berg@intel.com>
    cfg80211: size various nl80211 messages correctly

Christoffer Dall <christoffer.dall@linaro.org>
    video: fbdev: Set pixclock = 0 in goldfishfb

Marcel Holtmann <marcel@holtmann.org>
    Bluetooth: Verify that l2cap_get_conf_opt provides large enough buffer

Marcel Holtmann <marcel@holtmann.org>
    Bluetooth: Check L2CAP option sizes returned from l2cap_get_conf_opt


-------------

Diffstat:

 Documentation/virtual/kvm/api.txt                  | 16 +++--
 Makefile                                           |  4 +-
 arch/arm/mach-imx/cpuidle-imx6q.c                  | 27 +++----
 arch/arm64/Kconfig                                 |  4 ++
 arch/powerpc/include/asm/ppc-opcode.h              |  2 +
 arch/powerpc/net/bpf_jit.h                         | 17 ++---
 arch/powerpc/net/bpf_jit32.h                       |  4 ++
 arch/powerpc/net/bpf_jit64.h                       | 20 ++++++
 arch/powerpc/net/bpf_jit_comp64.c                  | 12 ++--
 arch/x86/Kconfig                                   |  8 +--
 arch/x86/include/asm/kvm_host.h                    |  1 +
 arch/x86/kvm/vmx.c                                 | 14 ----
 arch/x86/kvm/x86.c                                 | 12 ++++
 drivers/gpio/gpio-adnp.c                           |  6 +-
 drivers/isdn/hardware/mISDN/hfcmulti.c             |  3 +-
 drivers/net/dsa/qca8k.c                            | 18 -----
 drivers/net/ethernet/8390/mac8390.c                | 19 +++--
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c  | 16 ++++-
 drivers/net/tun.c                                  | 16 +++--
 drivers/net/vxlan.c                                |  4 +-
 drivers/s390/scsi/zfcp_erp.c                       | 17 +++++
 drivers/s390/scsi/zfcp_ext.h                       |  2 +
 drivers/s390/scsi/zfcp_scsi.c                      |  4 ++
 drivers/scsi/sd.c                                  | 22 ++++--
 drivers/staging/comedi/comedidev.h                 |  2 +
 drivers/staging/comedi/drivers.c                   | 33 +++++++--
 drivers/staging/comedi/drivers/ni_mio_common.c     | 10 ++-
 drivers/staging/vt6655/device_main.c               | 11 ++-
 drivers/tty/serial/atmel_serial.c                  |  4 ++
 drivers/tty/serial/kgdboc.c                        |  4 +-
 drivers/tty/serial/max310x.c                       |  2 +
 drivers/tty/serial/sh-sci.c                        | 12 +---
 drivers/usb/common/common.c                        |  2 +
 drivers/usb/core/config.c                          |  9 +--
 drivers/usb/gadget/function/f_hid.c                |  6 +-
 drivers/usb/host/xhci-rcar.c                       |  1 +
 drivers/usb/host/xhci-ring.c                       |  9 ++-
 drivers/usb/host/xhci.h                            |  1 +
 drivers/usb/serial/cp210x.c                        |  1 +
 drivers/usb/serial/ftdi_sio.c                      |  2 +
 drivers/usb/serial/ftdi_sio_ids.h                  |  4 +-
 drivers/usb/serial/mos7720.c                       |  4 +-
 drivers/usb/serial/option.c                        | 13 ++--
 drivers/video/fbdev/goldfishfb.c                   |  2 +-
 fs/btrfs/raid56.c                                  |  3 +-
 fs/btrfs/tree-log.c                                | 11 ++-
 fs/nfs/nfs4proc.c                                  |  3 +-
 fs/open.c                                          |  6 ++
 fs/proc/proc_sysctl.c                              |  3 +-
 include/net/sctp/checksum.h                        |  2 +-
 include/net/sock.h                                 |  6 ++
 kernel/cpu.c                                       | 20 +++++-
 net/bluetooth/l2cap_core.c                         | 83 ++++++++++++++--------
 net/dccp/ipv6.c                                    |  4 +-
 net/ipv6/tcp_ipv6.c                                |  8 +--
 net/packet/af_packet.c                             |  4 +-
 net/rose/rose_subr.c                               | 21 +++---
 net/wireless/nl80211.c                             | 16 ++---
 sound/core/oss/pcm_oss.c                           | 43 +++++------
 sound/core/pcm_native.c                            |  9 ++-
 sound/core/rawmidi.c                               |  2 +
 sound/core/seq/oss/seq_oss_synth.c                 |  7 +-
 .../perf/util/intel-pt-decoder/intel-pt-decoder.c  | 20 +++---
 virt/kvm/kvm_main.c                                |  3 +
 64 files changed, 422 insertions(+), 252 deletions(-)


