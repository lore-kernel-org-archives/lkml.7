Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6354AC4360F
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 18:03:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E54F20880
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 18:03:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554141824;
	bh=ThoSkZHFedi3nQA3P/c47GUuc/0S6LmBNUtJcDBOOIE=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=qJj0PIHNapP+dSmPiTky4VhFjzTN7eo83cO1z3T22dyvkCpCfGIelj0XXAvmwJCfD
	 RV0Kh5aXLlcSmuLL5J05XMFhh3Mgu7+URmZBJareAwo6Kdv+fmqpgykwlC1QDZqwR5
	 7bi8FeXzDc4jEIkLXaX1v2P/BaJ9K095IoVGFXGQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730964AbfDASDn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 14:03:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:37016 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730662AbfDAROC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:14:02 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B0FC321934;
        Mon,  1 Apr 2019 17:13:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554138840;
        bh=ThoSkZHFedi3nQA3P/c47GUuc/0S6LmBNUtJcDBOOIE=;
        h=From:To:Cc:Subject:Date:From;
        b=XIhhI4wp4VjKudrY3WZkvcE3UqUOhPWDYS8BppkfHdoj1nRLhrcq/aPQoK2vzmV77
         /4pAA1U/+Na+24Gu8ZS0Vs1ChzEqiHEo7rrdfMSqriZ5OU9ZSGWAsVGCswcT3b3N/K
         OnZyK4k8alsZAWiKvJ7bGdaBiw5QKQjZQRVXsbOI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: [PATCH 4.19 000/134] 4.19.33-stable review
Date:   Mon,  1 Apr 2019 19:00:36 +0200
Message-Id: <20190401170044.243719205@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.33-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.19.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.19.33-rc1
X-KernelTest-Deadline: 2019-04-03T17:00+00:00
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the start of the stable review cycle for the 4.19.33 release.
There are 134 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Wed Apr  3 16:59:23 UTC 2019.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.33-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.19.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 4.19.33-rc1

Heikki Krogerus <heikki.krogerus@linux.intel.com>
    platform: x86: intel_cht_int33fe: Remove the old connections for the muxes

Heikki Krogerus <heikki.krogerus@linux.intel.com>
    usb: typec: class: Don't use port parent for getting mux handles

Heikki Krogerus <heikki.krogerus@linux.intel.com>
    platform: x86: intel_cht_int33fe: Add connections for the USB Type-C port

Heikki Krogerus <heikki.krogerus@linux.intel.com>
    platform: x86: intel_cht_int33fe: Add connection for the DP alt mode

Heikki Krogerus <heikki.krogerus@linux.intel.com>
    platform: x86: intel_cht_int33fe: Register all connections at once

Heikki Krogerus <heikki.krogerus@linux.intel.com>
    drivers: base: Helpers for adding device connection descriptions

Xu Yu <xuyu@linux.alibaba.com>
    bpf: do not restore dst_reg when cur_state is freed

Gao Xiang <gaoxiang25@huawei.com>
    staging: erofs: keep corrupted fs from crashing kernel in erofs_readdir()

Gao Xiang <gaoxiang25@huawei.com>
    staging: erofs: fix error handling when failed to read compresssed data

Sean Christopherson <sean.j.christopherson@intel.com>
    KVM: x86: Emulate MSR_IA32_ARCH_CAPABILITIES on AMD hosts

Sean Christopherson <sean.j.christopherson@intel.com>
    KVM: x86: update %rip after emulating IO

Sean Christopherson <sean.j.christopherson@intel.com>
    KVM: Reject device ioctls from processes other than the VM's creator

Thomas Gleixner <tglx@linutronix.de>
    x86/smp: Enforce CONFIG_HOTPLUG_CPU when SMP=y

Thomas Gleixner <tglx@linutronix.de>
    cpu/hotplug: Prevent crash when CPU bringup fails on CONFIG_HOTPLUG_CPU=n

Thomas Gleixner <tglx@linutronix.de>
    watchdog: Respect watchdog cpumask on CPU hotplug

Michael Ellerman <mpe@ellerman.id.au>
    powerpc/64: Fix memcmp reading past the end of src/dest

Gautham R. Shenoy <ego@linux.vnet.ibm.com>
    powerpc/pseries/energy: Use OF accessor functions to read ibm,drc-indexes

Rolf Eike Beer <eb@emlix.com>
    objtool: Query pkg-config for libelf location

Adrian Hunter <adrian.hunter@intel.com>
    perf intel-pt: Fix TSC slip

Kan Liang <kan.liang@linux.intel.com>
    perf pmu: Fix parser error for uncore event alias

Lars Persson <lars.persson@axis.com>
    mm/migrate.c: add missing flush_dcache_page for non-mapped page migrate

Yang Shi <yang.shi@linux.alibaba.com>
    mm: mempolicy: make mbind() return -EIO when MPOL_MF_STRICT is specified

Nicolas Boichat <drinkcat@chromium.org>
    iommu/io-pgtable-arm-v7s: request DMA32 memory, and improve debugging

Nicolas Boichat <drinkcat@chromium.org>
    mm: add support for kmem caches in DMA32 zone

Romain Izard <romain.izard.pro@gmail.com>
    usb: cdc-acm: fix race during wakeup blocking TX traffic

Mathias Nyman <mathias.nyman@linux.intel.com>
    xhci: Don't let USB3 ports stuck in polling state prevent suspend

Mathias Nyman <mathias.nyman@linux.intel.com>
    usb: xhci: dbc: Don't free all memory with spinlock held

Mathias Nyman <mathias.nyman@linux.intel.com>
    xhci: Fix port resume done detection for SS ports with LPM enabled

Yasushi Asano <yasano@jp.adit-jv.com>
    usb: host: xhci-rcar: Add XHCI_TRUST_TX_LENGTH quirk

Fabrizio Castro <fabrizio.castro@bp.renesas.com>
    usb: common: Consider only available nodes for dr_mode

Radoslav Gerganov <rgerganov@vmware.com>
    USB: gadget: f_hid: fix deadlock in f_hidg_write()

Arnd Bergmann <arnd@arndb.de>
    usb: mtu3: fix EXTCON dependency

Chen-Yu Tsai <wens@csie.org>
    phy: sun4i-usb: Support set_mode to USB_HOST for non-OTG PHYs

Axel Lin <axel.lin@ingics.com>
    gpio: adnp: Fix testing wrong value in adnp_gpio_direction_input

Kangjie Lu <kjlu@umn.edu>
    gpio: exar: add a check for the return value of ida_simple_get fails

Zhenyu Wang <zhenyuw@linux.intel.com>
    drm/i915/gvt: Fix MI_FLUSH_DW parsing with correct index check

Eric Biggers <ebiggers@google.com>
    drm/vkms: fix use-after-free when drm_gem_handle_create() fails

Eric Biggers <ebiggers@google.com>
    drm/vgem: fix use-after-free when drm_gem_handle_create() fails

YueHaibing <yuehaibing@huawei.com>
    fs/proc/proc_sysctl.c: fix NULL pointer dereference in put_links

Wentao Wang <witallwang@gmail.com>
    Disable kgdboc failed by echo space to /sys/module/kgdboc/parameters/kgdboc

Bjørn Mork <bjorn@mork.no>
    USB: serial: option: add Olicard 600

Kristian Evensen <kristian.evensen@gmail.com>
    USB: serial: option: add support for Quectel EM12

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
    serial: mvebu-uart: Fix to avoid a potential NULL pointer dereference

Aditya Pakki <pakki001@umn.edu>
    serial: max310x: Fix to avoid potential NULL pointer dereference

Chao Yu <yuchao0@huawei.com>
    staging: erofs: fix to handle error path of erofs_vmap()

Malcolm Priestley <tvboxspy@gmail.com>
    staging: vt6655: Fix interrupt race condition on device start up.

Malcolm Priestley <tvboxspy@gmail.com>
    staging: vt6655: Remove vif check from vnt_interrupt

Samuel Thibault <samuel.thibault@ens-lyon.org>
    staging: speakup_soft: Fix alternate speech with other synths

Ian Abbott <abbotti@mev.co.uk>
    staging: comedi: ni_mio_common: Fix divide-by-zero for DIO cmdtest

Nathan Chancellor <natechancellor@gmail.com>
    tty: serial: qcom_geni_serial: Initialize baud in qcom_geni_console_setup

Kangjie Lu <kjlu@umn.edu>
    tty: atmel_serial: fix a potential NULL pointer dereference

Kangjie Lu <kjlu@umn.edu>
    tty: mxs-auart: fix a potential NULL pointer dereference

Jonas Karlman <jonas@kwiboo.se>
    drm/rockchip: vop: reset scale mode when win is disabled

Steffen Maier <maier@linux.ibm.com>
    scsi: zfcp: fix scsi_eh host reset with port_forced ERP for non-NPIV FCP devices

Steffen Maier <maier@linux.ibm.com>
    scsi: zfcp: fix rport unblock if deleted SCSI devices on Scsi_Host

Martin K. Petersen <martin.petersen@oracle.com>
    scsi: sd: Quiesce warning if device does not report optimal I/O size

Bart Van Assche <bvanassche@acm.org>
    scsi: sd: Fix a race between closing an sd device and sd I/O

Darrick J. Wong <darrick.wong@oracle.com>
    ocfs2: fix inode bh swapping mixup in ocfs2_reflink_inodes_lock

Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
    fs/open.c: allow opening only regular files during execve()

Fredrik Noring <noring@nocrew.org>
    kbuild: modversions: Fix relative CRC byte order interpretation

Bernhard Rosenkraenzer <bero@lindev.ch>
    ALSA: hda/realtek - Fix speakers on Acer Predator Helios 500 Ryzen laptops

Jian-Hong Pan <jian-hong@endlessm.com>
    ALSA: hda/realtek: Enable headset MIC of ASUS X430UN and X512DK with ALC256

Chris Chiu <chiu@endlessm.com>
    ALSA: hda/realtek: Enable headset mic of ASUS P5440FF with ALC256

Jian-Hong Pan <jian-hong@endlessm.com>
    ALSA: hda/realtek: Enable ASUS X441MB and X705FD headset MIC with ALC256

Chris Chiu <chiu@endlessm.com>
    ALSA: hda/realtek - Add support for Acer Aspire E5-523G/ES1-432 headset mic

Jian-Hong Pan <jian-hong@endlessm.com>
    ALSA: hda/realtek: Enable headset MIC of Acer Aspire Z24-890 with ALC286

Jian-Hong Pan <jian-hong@endlessm.com>
    ALSA: hda/realtek: Enable headset MIC of Acer AIO with ALC286

Kailang Yang <kailang@realtek.com>
    ALSA: hda/realtek - Add support headset mode for New DELL WYSE NB

Kailang Yang <kailang@realtek.com>
    ALSA: hda/realtek - Add support headset mode for DELL WYSE AIO

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

NeilBrown <neilb@suse.com>
    NFS: fix mount/umount race in nlmclnt.

Cornelia Huck <cohuck@redhat.com>
    vfio: ccw: only free cp on final interrupt

Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
    powerpc: bpf: Fix generation of load/store DW instructions

Kohji Okuno <okuno.kohji@jp.panasonic.com>
    ARM: imx6q: cpuidle: fix bug that CPU might not wake up at expected time

Filipe Manana <fdmanana@suse.com>
    Btrfs: fix assertion failure on fsync with NO_HOLES enabled

Nikolay Borisov <nborisov@suse.com>
    btrfs: Avoid possible qgroup_rsv_size overflow in btrfs_calculate_inode_block_rsv_size

Andrea Righi <andrea.righi@canonical.com>
    btrfs: raid56: properly unmap parity page in finish_parity_scrub()

David Sterba <dsterba@suse.com>
    btrfs: don't report readahead errors and don't update statistics

Josef Bacik <josef@toxicpanda.com>
    btrfs: remove WARN_ON in log_dir_items

Filipe Manana <fdmanana@suse.com>
    Btrfs: fix incorrect file size after shrinking truncate and fsync

Michael Ellerman <mpe@ellerman.id.au>
    powerpc/security: Fix spectre_v2 reporting

Christophe Leroy <christophe.leroy@c-s.fr>
    powerpc/fsl: Fix the flush of branch predictor.

Diana Craciun <diana.craciun@nxp.com>
    powerpc/fsl: Fixed warning: orphan section `__btb_flush_fixup'

Diana Craciun <diana.craciun@nxp.com>
    powerpc/fsl: Update Spectre v2 reporting

Diana Craciun <diana.craciun@nxp.com>
    powerpc/fsl: Enable runtime patching if nospectre_v2 boot arg is used

Diana Craciun <diana.craciun@nxp.com>
    powerpc/fsl: Flush branch predictor when entering KVM

Diana Craciun <diana.craciun@nxp.com>
    powerpc/fsl: Flush the branch predictor at each kernel entry (32 bit)

Diana Craciun <diana.craciun@nxp.com>
    powerpc/fsl: Flush the branch predictor at each kernel entry (64bit)

Diana Craciun <diana.craciun@nxp.com>
    powerpc/fsl: Add nospectre_v2 command line argument

Diana Craciun <diana.craciun@nxp.com>
    powerpc/fsl: Emulate SPRN_BUCSR register

Diana Craciun <diana.craciun@nxp.com>
    powerpc/fsl: Add macro to flush the branch predictor

Diana Craciun <diana.craciun@nxp.com>
    powerpc/fsl: Add infrastructure to fixup branch predictor flush

Eric Dumazet <edumazet@google.com>
    tun: add a missing rcu_read_unlock() in error path

Dean Nelson <dnelson@redhat.com>
    thunderx: eliminate extra calls to put_page() for pages held for recycling

Dean Nelson <dnelson@redhat.com>
    thunderx: enable page recycling for non-XDP case

John Hurley <john.hurley@netronome.com>
    net: sched: fix cleanup NULL pointer exception in act_mirr

Herbert Xu <herbert@gondor.apana.org.au>
    ila: Fix rhashtable walker list corruption

Zhiqiang Liu <liuzhiqiang26@huawei.com>
    vxlan: Don't call gro_cells_destroy() before device is unregistered

Sabrina Dubroca <sd@queasysnail.net>
    vrf: prevent adding upper devices

Eric Dumazet <edumazet@google.com>
    tun: properly test for IFF_UP

Erik Hugne <erik.hugne@gmail.com>
    tipc: fix cancellation of topology subscriptions

Xin Long <lucien.xin@gmail.com>
    tipc: change to check tipc_own_id to return in tipc_net_stop

Erik Hugne <erik.hugne@gmail.com>
    tipc: allow service ranges to be connect()'ed on RDM/DGRAM

Eric Dumazet <edumazet@google.com>
    tcp: do not use ipv6 header for ipv4 flow

Xin Long <lucien.xin@gmail.com>
    sctp: use memdup_user instead of vmemdup_user

Xin Long <lucien.xin@gmail.com>
    sctp: get sctphdr by offset in sctp_compute_cksum

Herbert Xu <herbert@gondor.apana.org.au>
    rhashtable: Still do rehash when we get EEXIST

Maxime Chevallier <maxime.chevallier@bootlin.com>
    packets: Always register packet sk in the same order

YueHaibing <yuehaibing@huawei.com>
    net-sysfs: call dev_hold if kobject_init_and_add success

Aaro Koskinen <aaro.koskinen@nokia.com>
    net: stmmac: fix memory corruption with large MTUs

Eric Dumazet <edumazet@google.com>
    net: rose: fix a possible stack overflow

Jerome Brunet <jbrunet@baylibre.com>
    net: phy: meson-gxl: fix interrupt support

Christoph Paasch <cpaasch@apple.com>
    net/packet: Set __GFP_NOWARN upon allocation in alloc_pg_vec

Paolo Abeni <pabeni@redhat.com>
    net: datagram: fix unbounded loop in __skb_try_recv_datagram()

Dmitry Bogdanov <dmitry.bogdanov@aquantia.com>
    net: aquantia: fix rx checksum offload for UDP/TCP over IPv6

Bjorn Helgaas <bhelgaas@google.com>
    mISDN: hfcpci: Test both vendor & device ID for Digium HFC4S

Finn Thain <fthain@telegraphics.com.au>
    mac8390: Fix mmio access size probe

Xin Long <lucien.xin@gmail.com>
    ipv6: make ip6_create_rt_rcu return ip6_null_entry instead of NULL

Matteo Croce <mcroce@redhat.com>
    gtp: change NET_UDP_TUNNEL dependency to select

YueHaibing <yuehaibing@huawei.com>
    genetlink: Fix a memory leak on error path

Eric Dumazet <edumazet@google.com>
    dccp: do not use ipv6 header for ipv4 flow

Corey Minyard <cminyard@mvista.com>
    ipmi_si: Fix crash when using hard-coded device

Marcel Holtmann <marcel@holtmann.org>
    Bluetooth: Verify that l2cap_get_conf_opt provides large enough buffer

Marcel Holtmann <marcel@holtmann.org>
    Bluetooth: Check L2CAP option sizes returned from l2cap_get_conf_opt


-------------

Diffstat:

 Documentation/virtual/kvm/api.txt                  |  16 +-
 Makefile                                           |   8 +-
 arch/arm/mach-imx/cpuidle-imx6q.c                  |  27 +--
 arch/powerpc/include/asm/feature-fixups.h          |  12 ++
 arch/powerpc/include/asm/ppc-opcode.h              |   2 +
 arch/powerpc/include/asm/ppc_asm.h                 |  10 +
 arch/powerpc/include/asm/setup.h                   |   7 +
 arch/powerpc/kernel/entry_64.S                     |   5 +
 arch/powerpc/kernel/exceptions-64e.S               |  27 ++-
 arch/powerpc/kernel/head_booke.h                   |  12 ++
 arch/powerpc/kernel/head_fsl_booke.S               |  15 ++
 arch/powerpc/kernel/security.c                     |  49 +++--
 arch/powerpc/kernel/setup-common.c                 |   1 +
 arch/powerpc/kernel/vmlinux.lds.S                  |   8 +
 arch/powerpc/kvm/bookehv_interrupts.S              |   4 +
 arch/powerpc/kvm/e500_emulate.c                    |   7 +
 arch/powerpc/lib/feature-fixups.c                  |  23 ++
 arch/powerpc/lib/memcmp_64.S                       |  17 +-
 arch/powerpc/mm/tlb_low_64e.S                      |   7 +
 arch/powerpc/net/bpf_jit.h                         |  17 +-
 arch/powerpc/net/bpf_jit32.h                       |   4 +
 arch/powerpc/net/bpf_jit64.h                       |  20 ++
 arch/powerpc/net/bpf_jit_comp64.c                  |  12 +-
 arch/powerpc/platforms/pseries/pseries_energy.c    |  27 ++-
 arch/x86/Kconfig                                   |   8 +-
 arch/x86/include/asm/kvm_host.h                    |   2 +
 arch/x86/kvm/vmx.c                                 |  14 --
 arch/x86/kvm/x86.c                                 |  48 ++++-
 drivers/char/ipmi/ipmi_si.h                        |   4 +-
 drivers/char/ipmi/ipmi_si_hardcode.c               | 236 +++++++++++++++------
 drivers/char/ipmi/ipmi_si_intf.c                   |  22 +-
 drivers/char/ipmi/ipmi_si_platform.c               |  30 ++-
 drivers/gpio/gpio-adnp.c                           |   6 +-
 drivers/gpio/gpio-exar.c                           |   2 +
 drivers/gpu/drm/i915/gvt/cmd_parser.c              |   2 +-
 drivers/gpu/drm/rockchip/rockchip_drm_vop.c        |  18 +-
 drivers/gpu/drm/vgem/vgem_drv.c                    |   6 +-
 drivers/gpu/drm/vkms/vkms_gem.c                    |   5 +-
 drivers/iommu/io-pgtable-arm-v7s.c                 |  19 +-
 drivers/isdn/hardware/mISDN/hfcmulti.c             |   3 +-
 drivers/net/Kconfig                                |   4 +-
 drivers/net/dsa/qca8k.c                            |  18 --
 drivers/net/ethernet/8390/mac8390.c                |  19 +-
 drivers/net/ethernet/aquantia/atlantic/aq_ring.c   |   5 +-
 drivers/net/ethernet/cavium/thunder/nicvf_queues.c |  30 ++-
 drivers/net/ethernet/stmicro/stmmac/ring_mode.c    |   5 +-
 drivers/net/phy/meson-gxl.c                        |   6 +
 drivers/net/tun.c                                  |  16 +-
 drivers/net/vrf.c                                  |   1 +
 drivers/net/vxlan.c                                |   4 +-
 drivers/phy/allwinner/phy-sun4i-usb.c              |   5 +-
 drivers/platform/x86/intel_cht_int33fe.c           |  27 ++-
 drivers/s390/cio/vfio_ccw_drv.c                    |   8 +-
 drivers/s390/scsi/zfcp_erp.c                       |  17 ++
 drivers/s390/scsi/zfcp_ext.h                       |   2 +
 drivers/s390/scsi/zfcp_scsi.c                      |   4 +
 drivers/scsi/sd.c                                  |  22 +-
 drivers/staging/comedi/comedidev.h                 |   2 +
 drivers/staging/comedi/drivers.c                   |  33 ++-
 drivers/staging/comedi/drivers/ni_mio_common.c     |  10 +-
 drivers/staging/erofs/dir.c                        |  45 ++--
 drivers/staging/erofs/unzip_vle.c                  |  46 ++--
 drivers/staging/erofs/unzip_vle_lz4.c              |   7 +-
 drivers/staging/speakup/speakup_soft.c             |  16 +-
 drivers/staging/speakup/spk_priv.h                 |   1 +
 drivers/staging/speakup/synth.c                    |   6 +
 drivers/staging/vt6655/device_main.c               |  11 +-
 drivers/tty/serial/atmel_serial.c                  |   4 +
 drivers/tty/serial/kgdboc.c                        |   4 +-
 drivers/tty/serial/max310x.c                       |   2 +
 drivers/tty/serial/mvebu-uart.c                    |   3 +
 drivers/tty/serial/mxs-auart.c                     |   4 +
 drivers/tty/serial/qcom_geni_serial.c              |   2 +-
 drivers/tty/serial/sh-sci.c                        |  12 +-
 drivers/usb/class/cdc-acm.c                        |   4 +-
 drivers/usb/common/common.c                        |   2 +
 drivers/usb/gadget/function/f_hid.c                |   6 +-
 drivers/usb/host/xhci-dbgcap.c                     |   5 +-
 drivers/usb/host/xhci-hub.c                        |  19 +-
 drivers/usb/host/xhci-rcar.c                       |   1 +
 drivers/usb/host/xhci-ring.c                       |   9 +-
 drivers/usb/host/xhci.h                            |   8 +
 drivers/usb/mtu3/Kconfig                           |   1 +
 drivers/usb/serial/cp210x.c                        |   1 +
 drivers/usb/serial/ftdi_sio.c                      |   2 +
 drivers/usb/serial/ftdi_sio_ids.h                  |   4 +-
 drivers/usb/serial/mos7720.c                       |   4 +-
 drivers/usb/serial/option.c                        |  17 +-
 drivers/usb/typec/class.c                          |  38 ++--
 fs/btrfs/extent-tree.c                             |   2 +-
 fs/btrfs/raid56.c                                  |   3 +-
 fs/btrfs/tree-log.c                                |  33 ++-
 fs/btrfs/volumes.c                                 |   2 +-
 fs/lockd/host.c                                    |   3 +-
 fs/nfs/nfs4proc.c                                  |   3 +-
 fs/ocfs2/refcounttree.c                            |  42 ++--
 fs/open.c                                          |   6 +
 fs/proc/proc_sysctl.c                              |   3 +-
 include/linux/device.h                             |  24 +++
 include/linux/slab.h                               |   2 +
 include/net/sctp/checksum.h                        |   2 +-
 include/net/sock.h                                 |   6 +
 kernel/bpf/verifier.c                              |   2 +-
 kernel/cpu.c                                       |  20 +-
 kernel/watchdog.c                                  |   6 +-
 lib/rhashtable.c                                   |   8 +-
 mm/mempolicy.c                                     |  40 +++-
 mm/migrate.c                                       |  11 +-
 mm/slab.c                                          |   2 +
 mm/slab.h                                          |   3 +-
 mm/slab_common.c                                   |   2 +-
 mm/slub.c                                          |   5 +
 net/bluetooth/l2cap_core.c                         |  83 +++++---
 net/core/datagram.c                                |   2 +-
 net/core/net-sysfs.c                               |   6 +-
 net/dccp/ipv6.c                                    |   4 +-
 net/ipv6/ila/ila_xlat.c                            |   1 +
 net/ipv6/route.c                                   |  18 +-
 net/ipv6/tcp_ipv6.c                                |   8 +-
 net/netlink/genetlink.c                            |   3 +-
 net/packet/af_packet.c                             |   4 +-
 net/rose/rose_subr.c                               |  21 +-
 net/sched/act_mirred.c                             |   3 +
 net/sctp/socket.c                                  |  12 +-
 net/tipc/net.c                                     |   5 +-
 net/tipc/socket.c                                  |  20 +-
 net/tipc/topsrv.c                                  |   1 +
 scripts/mod/modpost.c                              |   2 +-
 sound/core/oss/pcm_oss.c                           |  43 ++--
 sound/core/pcm_native.c                            |   9 +-
 sound/core/rawmidi.c                               |   2 +
 sound/core/seq/oss/seq_oss_synth.c                 |   7 +-
 sound/pci/hda/patch_realtek.c                      |  79 ++++++-
 tools/objtool/Makefile                             |   7 +-
 .../perf/util/intel-pt-decoder/intel-pt-decoder.c  |  20 +-
 tools/perf/util/pmu.c                              |  10 +
 virt/kvm/kvm_main.c                                |   3 +
 137 files changed, 1323 insertions(+), 564 deletions(-)


