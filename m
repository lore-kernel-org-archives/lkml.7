Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F0A1C10F05
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 18:03:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00E442084B
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 18:03:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554141828;
	bh=kiiqRGMNS6P737wh7PjqW7T6/B7NtNwEGt6maKcf8uo=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=iAv0i5bu5eTL827VdoQV4203PGnMG/6YNy4YwgaOHX4quKsBns4bSbovuzKMrhBd6
	 fiBfK+NCvBeYCfr2cqduh869aFI95qnnGcnpnDCTql6e2xmbmyVjwVd802pTgg1srh
	 kpOFm0kyL37uz7SMvkoccbdpTC9NP+48MleztHmg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731093AbfDASDq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 14:03:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:36998 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730655AbfDAROC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:14:02 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7FA732133D;
        Mon,  1 Apr 2019 17:04:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554138251;
        bh=kiiqRGMNS6P737wh7PjqW7T6/B7NtNwEGt6maKcf8uo=;
        h=From:To:Cc:Subject:Date:From;
        b=iAQfAFAsYPRWOn+WN554Fdvrum9dBGy4MpuF1AnUtGTGKrM8syrYzNTY/s9OUDJyt
         KEhPJp0k2qp7WOMcO3mXh/QeYsBk+J+jNYD2cnj9+9sPYPSGx8RBCPzf4ZO1dIv1JI
         sE6uZlcgGzDENdiwjjDzv8jM4cVis/r/qyeMgg8I=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: [PATCH 5.0 000/146] 5.0.6-stable review
Date:   Mon,  1 Apr 2019 19:00:12 +0200
Message-Id: <20190401170048.449559024@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-5.0.6-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-5.0.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 5.0.6-rc1
X-KernelTest-Deadline: 2019-04-03T17:01+00:00
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the start of the stable review cycle for the 5.0.6 release.
There are 146 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Wed Apr  3 16:59:21 UTC 2019.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.0.6-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.0.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 5.0.6-rc1

Stanislaw Gruszka <sgruszka@redhat.com>
    mt76x02u: use usb_bulk_msg to upload firmware

Xu Yu <xuyu@linux.alibaba.com>
    bpf: do not restore dst_reg when cur_state is freed

Sean Christopherson <sean.j.christopherson@intel.com>
    KVM: x86: update %rip after emulating IO

Sean Christopherson <sean.j.christopherson@intel.com>
    KVM: x86: Emulate MSR_IA32_ARCH_CAPABILITIES on AMD hosts

Sean Christopherson <sean.j.christopherson@intel.com>
    KVM: Reject device ioctls from processes other than the VM's creator

Thomas Gleixner <tglx@linutronix.de>
    x86/smp: Enforce CONFIG_HOTPLUG_CPU when SMP=y

Thomas Gleixner <tglx@linutronix.de>
    cpu/hotplug: Prevent crash when CPU bringup fails on CONFIG_HOTPLUG_CPU=n

Thomas Gleixner <tglx@linutronix.de>
    watchdog: Respect watchdog cpumask on CPU hotplug

Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
    powerpc/pseries/mce: Fix misleading print for TLB mutlihit

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

Qian Cai <cai@lca.pw>
    mm/page_isolation.c: fix a wrong flag in set_migratetype_isolate()

Qian Cai <cai@lca.pw>
    mm/memory_hotplug.c: fix notification in offline error path

Oscar Salvador <osalvador@suse.de>
    mm/debug.c: fix __dump_page when mapping->host is not set

Yang Shi <yang.shi@linux.alibaba.com>
    mm: mempolicy: make mbind() return -EIO when MPOL_MF_STRICT is specified

Nicolas Boichat <drinkcat@chromium.org>
    iommu/io-pgtable-arm-v7s: request DMA32 memory, and improve debugging

Nicolas Boichat <drinkcat@chromium.org>
    mm: add support for kmem caches in DMA32 zone

Qian Cai <cai@lca.pw>
    mm/hotplug: fix offline undo_isolate_page_range()

Gustavo A. R. Silva <gustavo@embeddedor.com>
    usb: typec: Fix unchecked return value

Hans de Goede <hdegoede@redhat.com>
    usb: typec: tcpm: Try PD-2.0 if sink does not respond to 3.0 source-caps

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

Jan Kara <jack@suse.cz>
    mm/memory.c: fix modifying of page protection by insert_pfn()

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

Manasi Navare <manasi.d.navare@intel.com>
    drm/i915/icl: Fix the TRANS_DDI_FUNC_CTL2 bitfield macro

Zhenyu Wang <zhenyuw@linux.intel.com>
    drm/i915/gvt: Fix MI_FLUSH_DW parsing with correct index check

Ville Syrjälä <ville.syrjala@linux.intel.com>
    drm/i915: Mark AML 0x87CA as ULX

Eric Biggers <ebiggers@google.com>
    drm/vkms: fix use-after-free when drm_gem_handle_create() fails

Eric Biggers <ebiggers@google.com>
    drm/vgem: fix use-after-free when drm_gem_handle_create() fails

Vincent Stehlé <vincent.stehle@laposte.net>
    cpufreq: scpi: Fix use after free

Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
    cpufreq: intel_pstate: Also use CPPC nominal_perf for base_frequency

Jens Axboe <axboe@kernel.dk>
    blk-mq: fix sbitmap ws_active for shared tags

Minchan Kim <minchan@kernel.org>
    drivers/block/zram/zram_drv.c: fix idle/writeback string compare

YueHaibing <yuehaibing@huawei.com>
    fs/proc/proc_sysctl.c: fix NULL pointer dereference in put_links

Wentao Wang <witallwang@gmail.com>
    Disable kgdboc failed by echo space to /sys/module/kgdboc/parameters/kgdboc

Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
    ACPI / CPPC: Fix guaranteed performance handling

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

Gao Xiang <gaoxiang25@huawei.com>
    staging: erofs: keep corrupted fs from crashing kernel in erofs_readdir()

Gao Xiang <gaoxiang25@huawei.com>
    staging: erofs: fix error handling when failed to read compresssed data

Chao Yu <yuchao0@huawei.com>
    staging: erofs: fix to handle error path of erofs_vmap()

Malcolm Priestley <tvboxspy@gmail.com>
    staging: vt6655: Fix interrupt race condition on device start up.

Malcolm Priestley <tvboxspy@gmail.com>
    staging: vt6655: Remove vif check from vnt_interrupt

Samuel Thibault <samuel.thibault@ens-lyon.org>
    staging: speakup_soft: Fix alternate speech with other synths

Arnd Bergmann <arnd@arndb.de>
    staging: olpc_dcon_xo_1: add missing 'const' qualifier

Ian Abbott <abbotti@mev.co.uk>
    staging: comedi: ni_mio_common: Fix divide-by-zero for DIO cmdtest

Nathan Chancellor <natechancellor@gmail.com>
    tty: serial: qcom_geni_serial: Initialize baud in qcom_geni_console_setup

Kangjie Lu <kjlu@umn.edu>
    tty: atmel_serial: fix a potential NULL pointer dereference

Kangjie Lu <kjlu@umn.edu>
    tty: mxs-auart: fix a potential NULL pointer dereference

Razvan Stefanescu <razvan.stefanescu@microchip.com>
    tty/serial: atmel: RS485 HD w/DMA: enable RX after TX is stopped

Razvan Stefanescu <razvan.stefanescu@microchip.com>
    tty/serial: atmel: Add is_half_duplex helper

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

Jaroslav Kysela <perex@perex.cz>
    ALSA: hda/realtek: merge alc_fixup_headset_jack to alc295_fixup_chromebook

Kailang Yang <kailang@realtek.com>
    ALSA: hda/realtek - Fixed Headset Mic JD not stable

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

Catalin Marinas <catalin.marinas@arm.com>
    NFS: Fix nfs4_lock_state refcounting in nfs4_alloc_{lock,unlock}data()

Cornelia Huck <cohuck@redhat.com>
    vfio: ccw: only free cp on final interrupt

Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
    powerpc: bpf: Fix generation of load/store DW instructions

Kohji Okuno <okuno.kohji@jp.panasonic.com>
    ARM: imx6q: cpuidle: fix bug that CPU might not wake up at expected time

Frank Rowand <frank.rowand@sony.com>
    tracing: initialize variable in create_dyn_event()

Jeff Layton <jlayton@kernel.org>
    locks: wake any locks blocked on request before deadlock check

Filipe Manana <fdmanana@suse.com>
    Btrfs: fix assertion failure on fsync with NO_HOLES enabled

Nikolay Borisov <nborisov@suse.com>
    btrfs: Avoid possible qgroup_rsv_size overflow in btrfs_calculate_inode_block_rsv_size

Nikolay Borisov <nborisov@suse.com>
    btrfs: Fix bound checking in qgroup_trace_new_subtree_blocks

Andrea Righi <andrea.righi@canonical.com>
    btrfs: raid56: properly unmap parity page in finish_parity_scrub()

David Sterba <dsterba@suse.com>
    btrfs: don't report readahead errors and don't update statistics

Josef Bacik <josef@toxicpanda.com>
    btrfs: remove WARN_ON in log_dir_items

Filipe Manana <fdmanana@suse.com>
    Btrfs: fix incorrect file size after shrinking truncate and fsync

Christophe Leroy <christophe.leroy@c-s.fr>
    powerpc/fsl: Fix the flush of branch predictor.

Eric Dumazet <edumazet@google.com>
    tun: add a missing rcu_read_unlock() in error path

Herbert Xu <herbert@gondor.apana.org.au>
    ila: Fix rhashtable walker list corruption

Heiner Kallweit <hkallweit1@gmail.com>
    r8169: fix cable re-plugging issue

Heiner Kallweit <hkallweit1@gmail.com>
    net: phy: don't clear BMCR in genphy_soft_reset

Claudiu Manoil <claudiu.manoil@nxp.com>
    net: mii: Fix PAUSE cap advertisement from linkmode_adv_to_lcl_adv_t() helper

Heiner Kallweit <hkallweit1@gmail.com>
    net: dsa: mv88e6xxx: fix few issues in mv88e6390x_port_set_cmode

Dean Nelson <dnelson@redhat.com>
    thunderx: eliminate extra calls to put_page() for pages held for recycling

Dean Nelson <dnelson@redhat.com>
    thunderx: enable page recycling for non-XDP case

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

Dmitry Bezrukov <dmitry.bezrukov@aquantia.com>
    net: usb: aqc111: Extend HWID table by QNAP device

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

Pablo Neira Ayuso <pablo@netfilter.org>
    netfilter: nf_tables: fix set double-free in abort path

Marcel Holtmann <marcel@holtmann.org>
    Bluetooth: Verify that l2cap_get_conf_opt provides large enough buffer

Marcel Holtmann <marcel@holtmann.org>
    Bluetooth: Check L2CAP option sizes returned from l2cap_get_conf_opt


-------------

Diffstat:

 Documentation/virtual/kvm/api.txt                  | 16 ++--
 Makefile                                           |  8 +-
 arch/arm/mach-imx/cpuidle-imx6q.c                  | 27 +++---
 arch/powerpc/include/asm/ppc-opcode.h              |  2 +
 arch/powerpc/kernel/exceptions-64e.S               |  1 +
 arch/powerpc/lib/memcmp_64.S                       | 17 +++-
 arch/powerpc/net/bpf_jit.h                         | 17 ++--
 arch/powerpc/net/bpf_jit32.h                       |  4 +
 arch/powerpc/net/bpf_jit64.h                       | 20 +++++
 arch/powerpc/net/bpf_jit_comp64.c                  | 12 +--
 arch/powerpc/platforms/pseries/pseries_energy.c    | 27 ++++--
 arch/powerpc/platforms/pseries/ras.c               |  1 +
 arch/x86/Kconfig                                   |  8 +-
 arch/x86/include/asm/kvm_host.h                    |  2 +
 arch/x86/kvm/vmx/vmx.c                             | 13 ---
 arch/x86/kvm/vmx/vmx.h                             |  1 -
 arch/x86/kvm/x86.c                                 | 48 ++++++++---
 block/blk-mq.c                                     | 13 ++-
 drivers/acpi/cppc_acpi.c                           |  9 +-
 drivers/block/zram/zram_drv.c                      | 32 ++-----
 drivers/cpufreq/intel_pstate.c                     |  5 +-
 drivers/cpufreq/scpi-cpufreq.c                     |  2 +-
 drivers/gpio/gpio-adnp.c                           |  6 +-
 drivers/gpio/gpio-exar.c                           |  2 +
 drivers/gpu/drm/i915/gvt/cmd_parser.c              |  2 +-
 drivers/gpu/drm/i915/i915_drv.h                    |  3 +-
 drivers/gpu/drm/i915/i915_reg.h                    |  2 +-
 drivers/gpu/drm/rockchip/rockchip_drm_vop.c        | 18 +++-
 drivers/gpu/drm/vgem/vgem_drv.c                    |  6 +-
 drivers/gpu/drm/vkms/vkms_gem.c                    |  5 +-
 drivers/iommu/io-pgtable-arm-v7s.c                 | 19 ++++-
 drivers/isdn/hardware/mISDN/hfcmulti.c             |  3 +-
 drivers/net/Kconfig                                |  4 +-
 drivers/net/dsa/mv88e6xxx/port.c                   | 24 ++++--
 drivers/net/dsa/qca8k.c                            | 18 ----
 drivers/net/ethernet/8390/mac8390.c                | 19 +++--
 drivers/net/ethernet/aquantia/atlantic/aq_ring.c   |  5 +-
 drivers/net/ethernet/cavium/thunder/nicvf_queues.c | 30 +++----
 drivers/net/ethernet/realtek/r8169.c               |  2 +-
 drivers/net/ethernet/stmicro/stmmac/ring_mode.c    |  5 +-
 drivers/net/phy/meson-gxl.c                        |  6 ++
 drivers/net/phy/phy_device.c                       |  2 +-
 drivers/net/tun.c                                  | 16 +++-
 drivers/net/usb/aqc111.c                           | 15 ++++
 drivers/net/usb/cdc_ether.c                        |  8 ++
 drivers/net/vrf.c                                  |  1 +
 drivers/net/vxlan.c                                |  4 +-
 drivers/net/wireless/mediatek/mt76/mt76.h          | 13 +++
 .../net/wireless/mediatek/mt76/mt76x02_usb_mcu.c   | 52 ++++--------
 drivers/net/wireless/mediatek/mt76/usb.c           |  1 -
 drivers/phy/allwinner/phy-sun4i-usb.c              |  5 +-
 drivers/s390/cio/vfio_ccw_drv.c                    |  8 +-
 drivers/s390/scsi/zfcp_erp.c                       | 17 ++++
 drivers/s390/scsi/zfcp_ext.h                       |  2 +
 drivers/s390/scsi/zfcp_scsi.c                      |  4 +
 drivers/scsi/sd.c                                  | 22 +++--
 drivers/staging/comedi/comedidev.h                 |  2 +
 drivers/staging/comedi/drivers.c                   | 33 +++++++-
 drivers/staging/comedi/drivers/ni_mio_common.c     | 10 ++-
 drivers/staging/erofs/dir.c                        | 45 +++++-----
 drivers/staging/erofs/unzip_vle.c                  | 45 +++++++---
 drivers/staging/erofs/unzip_vle_lz4.c              |  7 +-
 drivers/staging/olpc_dcon/olpc_dcon_xo_1.c         |  2 +-
 drivers/staging/speakup/speakup_soft.c             | 16 ++--
 drivers/staging/speakup/spk_priv.h                 |  1 +
 drivers/staging/speakup/synth.c                    |  6 ++
 drivers/staging/vt6655/device_main.c               | 11 ++-
 drivers/tty/serial/atmel_serial.c                  | 52 ++++++++----
 drivers/tty/serial/kgdboc.c                        |  4 +-
 drivers/tty/serial/max310x.c                       |  2 +
 drivers/tty/serial/mvebu-uart.c                    |  3 +
 drivers/tty/serial/mxs-auart.c                     |  4 +
 drivers/tty/serial/qcom_geni_serial.c              |  2 +-
 drivers/tty/serial/sh-sci.c                        | 12 +--
 drivers/usb/class/cdc-acm.c                        |  4 +-
 drivers/usb/common/common.c                        |  2 +
 drivers/usb/gadget/function/f_hid.c                |  6 +-
 drivers/usb/host/xhci-dbgcap.c                     |  5 +-
 drivers/usb/host/xhci-hub.c                        | 19 +++--
 drivers/usb/host/xhci-rcar.c                       |  1 +
 drivers/usb/host/xhci-ring.c                       |  9 +-
 drivers/usb/host/xhci.h                            |  8 ++
 drivers/usb/mtu3/Kconfig                           |  1 +
 drivers/usb/serial/cp210x.c                        |  1 +
 drivers/usb/serial/ftdi_sio.c                      |  2 +
 drivers/usb/serial/ftdi_sio_ids.h                  |  4 +-
 drivers/usb/serial/mos7720.c                       |  4 +-
 drivers/usb/serial/option.c                        | 17 ++--
 drivers/usb/typec/tcpm/tcpm.c                      | 27 +++++-
 drivers/usb/typec/tcpm/wcove.c                     |  9 +-
 fs/btrfs/extent-tree.c                             |  2 +-
 fs/btrfs/qgroup.c                                  |  4 +-
 fs/btrfs/raid56.c                                  |  3 +-
 fs/btrfs/tree-log.c                                | 33 +++++---
 fs/btrfs/volumes.c                                 |  2 +-
 fs/lockd/host.c                                    |  3 +-
 fs/locks.c                                         |  5 ++
 fs/nfs/nfs4proc.c                                  |  5 +-
 fs/ocfs2/refcounttree.c                            | 42 +++++----
 fs/open.c                                          |  6 ++
 fs/proc/proc_sysctl.c                              |  3 +-
 include/linux/mii.h                                |  2 +-
 include/linux/page-isolation.h                     | 10 ---
 include/linux/slab.h                               |  2 +
 include/net/netfilter/nf_tables.h                  |  6 +-
 include/net/sctp/checksum.h                        |  2 +-
 include/net/sock.h                                 |  6 ++
 kernel/bpf/verifier.c                              |  2 +-
 kernel/cpu.c                                       | 20 ++++-
 kernel/trace/trace_dynevent.c                      |  2 +-
 kernel/watchdog.c                                  |  6 +-
 lib/rhashtable.c                                   |  8 +-
 mm/debug.c                                         |  2 +-
 mm/memory.c                                        | 11 +--
 mm/memory_hotplug.c                                | 19 +++--
 mm/mempolicy.c                                     | 40 +++++++--
 mm/migrate.c                                       | 11 ++-
 mm/page_alloc.c                                    |  2 +-
 mm/page_isolation.c                                | 51 ++++++-----
 mm/slab.c                                          |  2 +
 mm/slab.h                                          |  3 +-
 mm/slab_common.c                                   |  2 +-
 mm/slub.c                                          |  5 ++
 mm/sparse.c                                        |  2 +-
 net/bluetooth/l2cap_core.c                         | 83 +++++++++++-------
 net/core/datagram.c                                |  2 +-
 net/core/net-sysfs.c                               |  6 +-
 net/dccp/ipv6.c                                    |  4 +-
 net/ipv6/ila/ila_xlat.c                            |  1 +
 net/ipv6/route.c                                   | 18 ++--
 net/ipv6/tcp_ipv6.c                                |  8 +-
 net/netfilter/nf_tables_api.c                      | 17 ++--
 net/netlink/genetlink.c                            |  3 +-
 net/packet/af_packet.c                             |  4 +-
 net/rose/rose_subr.c                               | 21 +++--
 net/sctp/socket.c                                  | 12 +--
 net/tipc/net.c                                     |  5 +-
 net/tipc/socket.c                                  | 20 +++--
 net/tipc/topsrv.c                                  |  1 +
 scripts/mod/modpost.c                              |  2 +-
 sound/core/oss/pcm_oss.c                           | 43 +++++-----
 sound/core/pcm_native.c                            |  9 +-
 sound/core/rawmidi.c                               |  2 +
 sound/core/seq/oss/seq_oss_synth.c                 |  7 +-
 sound/pci/hda/patch_realtek.c                      | 99 ++++++++++++++++++++--
 tools/objtool/Makefile                             |  7 +-
 .../perf/util/intel-pt-decoder/intel-pt-decoder.c  | 20 ++---
 tools/perf/util/pmu.c                              | 10 +++
 virt/kvm/kvm_main.c                                |  3 +
 149 files changed, 1143 insertions(+), 598 deletions(-)


