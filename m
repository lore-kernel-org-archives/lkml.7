Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CE6EC4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:45:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE017206B7
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:45:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554371107;
	bh=pBeubIUhGImJ93ogaliTw0ND3OmTu4HBXt6oL0u54+c=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=fitF8zjy9CrMkHH7LdYmGKQhMnSU6szDYMqD3jQbreU3mP7P+M4GaaKg4J6g+W/ng
	 C2uW97CPPZbKTFPHmi5sZKSJLJuWIHt+04W9UJ/aleMcyIwN3EVVdvhwb9vmEAXviv
	 IfISKY8eRJ9yZbQIk2kNneKMjgQ9V8ifQCinhXTw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730466AbfDDI7U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 04:59:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:35458 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731067AbfDDI7R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 04:59:17 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8DCFC21741;
        Thu,  4 Apr 2019 08:59:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554368355;
        bh=pBeubIUhGImJ93ogaliTw0ND3OmTu4HBXt6oL0u54+c=;
        h=From:To:Cc:Subject:Date:From;
        b=n/NAKrLr18pFSYOyfhni95nIbI3aALJFgRrz2nVXaRk9z2UcVGaYNx/4Jan2Ct9Cp
         lgoEQBZmDI+nBKwsrb/FV90gc1/weT9ZFOha7QqCDUBZc7WNixbyzF5vUddY2tAoAr
         CUvQP/C8y5vSf/qQQ1F+YaTFh4urVr0lGy28BHDg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: [PATCH 4.19 000/187] 4.19.34-stable review
Date:   Thu,  4 Apr 2019 10:45:37 +0200
Message-Id: <20190404084603.119654039@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.34-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.19.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.19.34-rc1
X-KernelTest-Deadline: 2019-04-06T08:46+00:00
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the start of the stable review cycle for the 4.19.34 release.
There are 187 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Sat Apr  6 08:44:30 UTC 2019.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.34-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.19.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 4.19.34-rc1

Andrea Righi <righi.andrea@gmail.com>
    kprobes/x86: Blacklist non-attachable interrupt functions

Coly Li <colyli@suse.de>
    bcache: fix potential div-zero error of writeback_rate_p_term_inverse

Hans de Goede <hdegoede@redhat.com>
    ACPI / video: Extend chassis-type detection with a "Lunch Box" check

Nathan Chancellor <natechancellor@gmail.com>
    net: stmmac: Avoid one more sometimes uninitialized Clang warning

Ville Syrjälä <ville.syrjala@linux.intel.com>
    drm/dp/mst: Configure no_stop_bit correctly for remote i2c xfers

Hans de Goede <hdegoede@redhat.com>
    Input: soc_button_array - fix mapping of the 5th GPIO in a PNP0C40 device

Ben Dooks <ben.dooks@codethink.co.uk>
    dmaengine: tegra: avoid overflow of byte tracking

Katsuhiro Suzuki <katsuhiro@katsuster.net>
    clk: rockchip: fix frac settings of GPLL clock for rk3328

Jerome Brunet <jbrunet@baylibre.com>
    clk: meson: clean-up clock registration

Peter Wu <peter@lekensteyn.nl>
    drm/fb-helper: fix leaks in error path of drm_fb_helper_fbdev_setup

Rafael Ávila de Espíndola <rafael@espindo.la>
    x86/build: Mark per-CPU symbols as absolute explicitly for LLD

Zumeng Chen <zumeng.chen@gmail.com>
    wlcore: Fix memory leak in case wl12xx_fetch_firmware failure

Hans de Goede <hdegoede@redhat.com>
    brcmfmac: Use firmware_request_nowarn for the clm_blob

Ondrej Mosnacek <omosnace@redhat.com>
    selinux: do not override context on context mounts

George Rimar <grimar@accesssoftek.com>
    x86/build: Specify elf_i386 linker emulation explicitly for i386 objects

Daniel Vetter <daniel.vetter@ffwll.ch>
    drm/nouveau: Stop using drm_crtc_force_disable

Paul Kocialkowski <paul.kocialkowski@bootlin.com>
    drm: Auto-set allow_fb_modifiers when given modifiers at plane init

Martin Blumenstingl <martin.blumenstingl@googlemail.com>
    pinctrl: meson: meson8b: add the eth_rxd2 and eth_rxd3 pins

Axel Lin <axel.lin@ingics.com>
    regulator: act8865: Fix act8600_sudcdc_voltage_ranges setting

Pawe? Chmiel <pawel.mikolaj.chmiel@gmail.com>
    media: s5p-jpeg: Check for fmt_ver_flag when doing fmt enumeration

Steve Longerbeam <slongerbeam@gmail.com>
    media: rcar-vin: Allow independent VIN link enablement

Florian Westphal <fw@strlen.de>
    netfilter: physdev: relax br_netfilter dependency

Shunyong Yang <shunyong.yang@hxt-semitech.com>
    dmaengine: qcom_hidma: initialize tx flags in hidma_prep_dma_*

Shunyong Yang <shunyong.yang@hxt-semitech.com>
    dmaengine: qcom_hidma: assign channel cookie correctly

Anders Roxell <anders.roxell@linaro.org>
    dmaengine: imx-dma: fix warning comparison of distinct pointer types

Valentin Schneider <valentin.schneider@arm.com>
    cpu/hotplug: Mute hotplug lockdep during init

Buland Singh <bsingh@redhat.com>
    hpet: Fix missing '=' character in the __setup() code of hpet_mmap_enable

Sheng Yong <shengyong1@huawei.com>
    f2fs: UBSAN: set boolean value iostat_enable correctly

Song Hongyan <hongyan.song@intel.com>
    HID: intel-ish: ipc: handle PIMR before ish_wakeup also clear PISR busy_clear bit

Timo Alho <talho@nvidia.com>
    soc/tegra: fuse: Fix illegal free of IO base address

David Tolnay <dtolnay@gmail.com>
    hwrng: virtio - Avoid repeated init of completion

Akinobu Mita <akinobu.mita@gmail.com>
    media: mt9m111: set initial frame size other than 0x0

Tony Jones <tonyj@suse.de>
    perf script python: Add trace_context extension module to sys.modules

Tony Jones <tonyj@suse.de>
    perf script python: Use PyBytes for attr in trace-event-python

Jérôme de Bretagne <jerome.debretagne@gmail.com>
    platform/x86: intel-hid: Missing power button release on some Dell models

Roger Quadros <rogerq@ti.com>
    usb: dwc3: gadget: Fix OTG events when gadget driver isn't loaded

Takashi Sakamoto <o-takashi@sakamocchi.jp>
    ALSA: dice: add support for Solid State Logic Duende Classic/Mini

Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
    drm/amd/display: Enable vblank interrupt during CRC capture

Nathan Fontenot <nfont@linux.vnet.ibm.com>
    powerpc/pseries: Perform full re-add of CPU for topology update post-migration

Manfred Schlaegl <manfred.schlaegl@ginzinger.com>
    tty: increase the default flip buffer limit to 2*640K

Chen-Yu Tsai <wens@csie.org>
    backlight: pwm_bl: Use gpiod_get_value_cansleep() to get initial state

Oleg Nesterov <oleg@redhat.com>
    cgroup/pids: turn cgroup_subsys->free() into cgroup_subsys->release() to fix the accounting

Nicolai Stange <nstange@suse.de>
    powerpc/64s: Clear on-stack exception marker upon exception return

Stanislav Fomichev <sdf@google.com>
    selftests/bpf: skip verifier tests for unsupported program types

Valdis Kletnieks <valdis.kletnieks@vt.edu>
    bpf: fix missing prototype warnings

Paolo Valente <paolo.valente@linaro.org>
    block, bfq: fix in-service-queue check for queue merging

Russell King <rmk+kernel@armlinux.org.uk>
    ARM: avoid Cortex-A9 livelock on tight dmb loops

Vladimir Murzin <vladimir.murzin@arm.com>
    ARM: 8830/1: NOMMU: Toggle only bits in EXC_RETURN we are really care of

Stanislaw Gruszka <sgruszka@redhat.com>
    mt7601u: bump supported EEPROM version

Alexey Khoroshilov <khoroshilov@ispras.ru>
    soc: qcom: gsbi: Fix error handling in gsbi_probe()

Ard Biesheuvel <ard.biesheuvel@linaro.org>
    efi/arm/arm64: Allow SetVirtualAddressMap() to be omitted

Mathieu Malaterre <malat@debian.org>
    ARM: dts: lpc32xx: Remove leading 0x and 0s from bindings notation

Shayenne Moura <shayenneluzmoura@gmail.com>
    drm/vkms: Bugfix extra vblank frame

Andrea Parri <andrea.parri@amarulasolutions.com>
    sched/core: Use READ_ONCE()/WRITE_ONCE() in move_queued_task()/task_rq_lock()

Ard Biesheuvel <ard.biesheuvel@linaro.org>
    efi/memattr: Don't bail on zero VA if it equals the region's PA

Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>
    sched/debug: Initialize sd_sysctl_cpus if !CONFIG_CPUMASK_OFFSTACK

wen yang <yellowriver2010@hotmail.com>
    ASoC: fsl-asoc-card: fix object reference leaks in fsl_asoc_card_probe

Johannes Berg <johannes.berg@intel.com>
    iwlwifi: mvm: fix RFH config command with >=10 CPUs

Stefan Roese <sr@denx.de>
    staging: spi: mt7621: Add return code check on device_reset()

Thierry Reding <treding@nvidia.com>
    i2c: of: Try to find an I2C adapter matching the parent

Rajneesh Bhardwaj <rajneesh.bhardwaj@linux.intel.com>
    platform/x86: intel_pmc_core: Fix PCH IP sts reading

Kai-Heng Feng <kai.heng.feng@canonical.com>
    e1000e: Exclude device from suspend direct complete optimization

Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
    e1000e: fix cyclic resets at link up with active tx

Mathieu Poirier <mathieu.poirier@linaro.org>
    perf/aux: Make perf_event accessible to setup_aux()

Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
    drm/amd/display: Disconnect mpcc when changing tg

Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
    drm/amd/display: Don't re-program planes for DPMS changes

Julia Lawall <julia.lawall@lip6.fr>
    drm: rcar-du: add missing of_node_put

Guenter Roeck <linux@roeck-us.net>
    cdrom: Fix race condition in cdrom_sysctl_register

Manfred Schlaegl <manfred.schlaegl@ginzinger.com>
    fbdev: fbmem: fix memory access if logo is bigger than the screen

Heiner Kallweit <hkallweit1@gmail.com>
    net: phy: consider latched link-down status in polling mode

Raju Rangoju <rajur@chelsio.com>
    iw_cxgb4: fix srqidx leak during connection abort

Russell King <rmk+kernel@armlinux.org.uk>
    net: marvell: mvpp2: fix stuck in-band SGMII negotiation

Thomas Gleixner <tglx@linutronix.de>
    genirq: Avoid summation loops for /proc/stat

Coly Li <colyli@suse.de>
    bcache: improve sysfs_strtoul_clamp()

Coly Li <colyli@suse.de>
    bcache: fix potential div-zero error of writeback_rate_i_term_inverse

Coly Li <colyli@suse.de>
    bcache: fix input overflow to sequential_cutoff

Coly Li <colyli@suse.de>
    bcache: fix input overflow to cache set sysfs file io_error_halflife

Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
    sched/topology: Fix percpu data types in struct sd_data & struct s_data

John Stultz <john.stultz@linaro.org>
    usb: f_fs: Avoid crash due to out-of-scope stack ptr access

Rakesh Pillai <pillair@codeaurora.org>
    ath10k: fix shadow register implementation for WCN3990

Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
    ALSA: PCM: check if ops are defined before suspending PCM

Martin Blumenstingl <martin.blumenstingl@googlemail.com>
    ARM: dts: meson8b: fix the Ethernet data line signals in eth_rgmii_pins

Nathan Chancellor <natechancellor@gmail.com>
    ARM: 8833/1: Ensure that NEON code always compiles with Clang

Chieh-Min Wang <chiehminw@synology.com>
    netfilter: conntrack: fix cloned unconfirmed skb->_nfct race in __nf_conntrack_confirm

Masami Hiramatsu <mhiramat@kernel.org>
    kprobes: Prohibit probing on RCU debug routine

Andrea Righi <righi.andrea@gmail.com>
    kprobes: Prohibit probing on bsearch()

Tycho Andersen <tycho@tycho.ws>
    selftests: skip seccomp get_metadata test if not real root

Hans de Goede <hdegoede@redhat.com>
    ACPI / video: Refactor and fix dmi_is_desktop()

Sara Sharon <sara.sharon@intel.com>
    iwlwifi: pcie: fix emergency path

Thomas Richter <tmricht@linux.ibm.com>
    perf report: Add s390 diagnosic sampling descriptor size

Michal Kazior <michal@plume.com>
    leds: lp55xx: fix null deref on firmware load failure

Theodore Ts'o <tytso@mit.edu>
    jbd2: fix race when writing superblock

Tejun Heo <tj@kernel.org>
    cgroup, rstat: Don't flush subtree root unless necessary

Hong Liu <hong.liu@intel.com>
    HID: intel-ish-hid: avoid binding wrong ishtp_cl_device

Aurelien Jarno <aurelien@aurel32.net>
    vfs: fix preadv64v2 and pwritev64v2 compat syscalls with offset == -1

Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
    xen/gntdev: Do not destroy context while dma-bufs are in use

Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
    mt76: usb: do not run mt76u_queues_deinit twice

Ezequiel Garcia <ezequiel@collabora.com>
    media: mtk-jpeg: Correct return type for mem2mem buffer helpers

Ezequiel Garcia <ezequiel@collabora.com>
    media: mx2_emmaprp: Correct return type for mem2mem buffer helpers

Ezequiel Garcia <ezequiel@collabora.com>
    media: s5p-g2d: Correct return type for mem2mem buffer helpers

Ezequiel Garcia <ezequiel@collabora.com>
    media: rockchip/rga: Correct return type for mem2mem buffer helpers

Ezequiel Garcia <ezequiel@collabora.com>
    media: s5p-jpeg: Correct return type for mem2mem buffer helpers

Ezequiel Garcia <ezequiel@collabora.com>
    media: sh_veu: Correct return type for mem2mem buffer helpers

Akinobu Mita <akinobu.mita@gmail.com>
    media: ov7740: fix runtime pm initialization

Wen Yang <yellowriver2010@hotmail.com>
    SoC: imx-sgtl5000: add missing put_device()

He Kuang <hekuang@huawei.com>
    perf report: Don't shadow inlined symbol with different addr range

Brian Norris <briannorris@chromium.org>
    mwifiex: don't advertise IBSS features without FW support

Thomas Richter <tmricht@linux.ibm.com>
    perf test: Fix failure of 'evsel-tp-sched' test on s390

Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
    drm/amd/display: Clear stream->mode_changed after commit

Sedat Dilek <sedat.dilek@gmail.com>
    scsi: fcoe: make use of fip_mode enum complete

Jason Yan <yanaijie@huawei.com>
    scsi: megaraid_sas: return error when create DMA pool failed

Sebastian Ott <sebott@linux.ibm.com>
    s390/ism: ignore some errors during deregistration

Ross Lagerwall <ross.lagerwall@citrix.com>
    efi: cper: Fix possible out-of-bounds access

Erwan Velu <erwanaliasr1@gmail.com>
    cpufreq: acpi-cpufreq: Report if CPU doesn't support boost technologies

Takashi Iwai <tiwai@suse.de>
    ASoC: qcom: Fix of-node refcount unbalance in qcom_snd_parse_of()

Wei Li <liwei391@huawei.com>
    perf annotate: Fix getting source line failure

Katsuhiro Suzuki <katsuhiro@katsuster.net>
    clk: fractional-divider: check parent rate only if flag is set

Håkon Bugge <haakon.bugge@oracle.com>
    IB/mlx4: Increase the timeout for CM cache

Dongli Zhang <dongli.zhang@oracle.com>
    loop: set GENHD_FL_NO_PART_SCAN after blkdev_reread_part()

Vadim Pasternak <vadimp@mellanox.com>
    platform/mellanox: mlxreg-hotplug: Fix KASAN warning

Yang Fan <nullptr.cpp@gmail.com>
    platform/x86: ideapad-laptop: Fix no_hw_rfkill_list for Lenovo RESCUER R720-15IKBN

Florian Fainelli <f.fainelli@gmail.com>
    mlxsw: spectrum: Avoid -Wformat-truncation warnings

Florian Fainelli <f.fainelli@gmail.com>
    e1000e: Fix -Wformat-truncation warnings

Andrew Lunn <andrew@lunn.ch>
    net: dsa: mv88e6xxx: Add lockdep classes to fix false positive splat

Aaro Koskinen <aaro.koskinen@iki.fi>
    mmc: omap: fix the maximum timeout setting

Qu Wenruo <wqu@suse.com>
    btrfs: qgroup: Make qgroup async transaction commit more aggressive

Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
    powerpc/hugetlb: Handle mmap_min_addr correctly in get_unmapped_area callback

Nicolas Boichat <drinkcat@chromium.org>
    iommu/io-pgtable-arm-v7s: Only kmemleak_ignore L2 tables

Sebastian Andrzej Siewior <bigeasy@linutronix.de>
    ARM: 8840/1: use a raw_spinlock_t in unwind

Lubomir Rintel <lkundrak@v3.sk>
    serial: 8250_pxa: honor the port number from devicetree

Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
    coresight: etm4x: Add support to enable ETMv4.2

Nathan Chancellor <natechancellor@gmail.com>
    powerpc/xmon: Fix opcode being uninitialized in print_insn_powerpc

Masahiro Yamada <yamada.masahiro@socionext.com>
    kbuild: invoke syncconfig if include/config/auto.conf.cmd is missing

Benjamin Block <bblock@linux.ibm.com>
    scsi: core: replace GFP_ATOMIC with GFP_KERNEL in scsi_scan.c

Alexey Kardashevskiy <aik@ozlabs.ru>
    powerpc/powernv/ioda: Fix locked_vm counting for memory used by IOMMU tables

Paul Kocialkowski <paul.kocialkowski@bootlin.com>
    usb: chipidea: Grab the (legacy) USB PHY by phandle first

Eric Biggers <ebiggers@google.com>
    crypto: cavium/zip - fix collision with generic cra_driver_name

Julia Lawall <Julia.Lawall@lip6.fr>
    crypto: crypto4xx - add missing of_node_put after of_device_is_available

Wen Yang <wen.yang99@zte.com.cn>
    mt76: fix a leaked reference by adding a missing of_node_put

Alexei Avshalom Lazar <ailizaro@codeaurora.org>
    wil6210: check null pointer in _wil_cfg80211_merge_extra_ies

Rafael J. Wysocki <rafael.j.wysocki@intel.com>
    PCI/PME: Fix hotplug/sysfs remove deadlock in pcie_pme_remove()

Tony Jones <tonyj@suse.de>
    tools lib traceevent: Fix buffer overflow in arg_eval

Carlos Maiolino <cmaiolino@redhat.com>
    fs: fix guard_bio_eod to check for real EOD errors

luojiajun <luojiajun3@huawei.com>
    jbd2: fix invalid descriptor block checksum

Florian Westphal <fw@strlen.de>
    netfilter: conntrack: tcp: only close if RST matches exact sequence

Li RongQing <lirongqing@baidu.com>
    netfilter: nf_tables: check the result of dereferencing base_chain->stats

Slavomir Kaslev <kaslevs@vmware.com>
    fs: Make splice() and tee() take into account O_NONBLOCK flag on pipes

Yao Liu <yotta.liu@ucloud.cn>
    cifs: Fix NULL pointer dereference of devname

Namjae Jeon <linkinjeon@gmail.com>
    cifs: Accept validate negotiate if server return NT_STATUS_NOT_SUPPORTED

Chao Yu <yuchao0@huawei.com>
    f2fs: fix to check inline_xattr_size boundary correctly

Jason Cai (Xiang Feng) <jason.cai.kern@gmail.com>
    dm thin: add sanity checks to thin-pool and external snapshot creation

Louis Taylor <louis@kragniz.eu>
    cifs: use correct format characters

Qian Cai <cai@lca.pw>
    page_poison: play nicely with KASAN

Shuriyc Chu <sureeju@gmail.com>
    fs/file.c: initialize init_files.resize_wait

Sahitya Tummala <stummala@codeaurora.org>
    f2fs: do not use mutex lock in atomic context

Jia Guo <guojia12@huawei.com>
    ocfs2: fix a panic problem caused by o2cb_ctl

Qian Cai <cai@lca.pw>
    mm/slab.c: kmemleak no scan alien caches

Uladzislau Rezki (Sony) <urezki@gmail.com>
    mm/vmalloc.c: fix kernel BUG at mm/vmalloc.c:512!

Vlastimil Babka <vbabka@suse.cz>
    mm, mempolicy: fix uninit memory access

Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
    memcg: killed threads should not invoke memcg OOM killer

Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
    mm,oom: don't kill global init via memory.oom.group

Daniel Jordan <daniel.m.jordan@oracle.com>
    mm, swap: bounds check swap_info array accesses to avoid NULL derefs

Qian Cai <cai@lca.pw>
    mm/page_ext.c: fix an imbalance with kmemleak

Peng Fan <peng.fan@nxp.com>
    mm/cma.c: cma_declare_contiguous: correct err handling

Qian Cai <cai@lca.pw>
    mm/sparse: fix a bad comparison

Jiri Olsa <jolsa@redhat.com>
    perf c2c: Fix c2c report for empty numa node

Kairui Song <kasong@redhat.com>
    x86/hyperv: Fix kernel panic when kexec on HyperV

Linus Torvalds <torvalds@linux-foundation.org>
    iio: adc: fix warning in Qualcomm PM8xxx HK/XOADC driver

Xiang Chen <chenxiang66@hisilicon.com>
    scsi: hisi_sas: Fix a timeout race of driver internal and SMP IO

John Garry <john.garry@huawei.com>
    scsi: hisi_sas: Set PHY linkrate when disconnected

Stanislav Fomichev <sdf@google.com>
    libbpf: force fixdep compilation at the start of the build

Arnd Bergmann <arnd@arndb.de>
    enic: fix build warning without CONFIG_CPUMASK_OFFSTACK

Nathan Chancellor <natechancellor@gmail.com>
    net: stmmac: Avoid sometimes uninitialized Clang warnings

Christian Brauner <christian@brauner.io>
    sysctl: handle overflow for file-max

Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
    include/linux/relay.h: fix percpu annotation in struct rchan

Russell King <rmk+kernel@armlinux.org.uk>
    gpio: gpio-omap: fix level interrupt idling

Tonghao Zhang <xiangxia.m.yue@gmail.com>
    net/mlx5: Avoid panic when setting vport mac, getting vport config

Tonghao Zhang <xiangxia.m.yue@gmail.com>
    net/mlx5: Avoid panic when setting vport rate

Douglas Anderson <dianders@chromium.org>
    tracing: kdb: Fix ftdump to not sleep

Chao Yu <yuchao0@huawei.com>
    f2fs: fix to avoid deadlock in f2fs_read_inline_dir()

Chao Yu <yuchao0@huawei.com>
    f2fs: fix to adapt small inline xattr space in __find_inline_xattr()

Masahiro Yamada <yamada.masahiro@socionext.com>
    h8300: use cc-cross-prefix instead of hardcoding h8300-unknown-linux-

Aurelien Aptel <aaptel@suse.com>
    CIFS: fix POSIX lock leak and invalid ptr deref

Razvan Stefanescu <razvan.stefanescu@microchip.com>
    tty/serial: atmel: RS485 HD w/DMA: enable RX after TX is stopped

Razvan Stefanescu <razvan.stefanescu@microchip.com>
    tty/serial: atmel: Add is_half_duplex helper

zhangyi (F) <yi.zhang@huawei.com>
    ext4: cleanup bh release code in ext4_ind_remove_space()

Will Deacon <will.deacon@arm.com>
    arm64: debug: Don't propagate UNKNOWN FAR into si_code for debug signals


-------------

Diffstat:

 Documentation/arm/kernel_mode_neon.txt             |  4 +-
 Makefile                                           | 11 +++--
 arch/arm/boot/dts/lpc32xx.dtsi                     | 18 +++----
 arch/arm/boot/dts/meson8b.dtsi                     |  6 +--
 arch/arm/include/asm/barrier.h                     |  2 +
 arch/arm/include/asm/processor.h                   |  6 ++-
 arch/arm/include/asm/v7m.h                         |  2 +-
 arch/arm/kernel/entry-header.S                     |  3 +-
 arch/arm/kernel/entry-v7m.S                        |  4 ++
 arch/arm/kernel/machine_kexec.c                    |  5 +-
 arch/arm/kernel/smp.c                              |  4 +-
 arch/arm/kernel/unwind.c                           | 14 +++---
 arch/arm/lib/Makefile                              |  2 +-
 arch/arm/lib/xor-neon.c                            |  2 +-
 arch/arm/mach-omap2/prm_common.c                   |  4 +-
 arch/arm/mm/proc-v7m.S                             |  3 ++
 arch/arm64/mm/fault.c                              |  9 ++--
 arch/h8300/Makefile                                |  2 +-
 arch/powerpc/include/asm/topology.h                |  2 +
 arch/powerpc/kernel/entry_64.S                     |  7 +++
 arch/powerpc/mm/hugetlbpage-radix.c                |  5 +-
 arch/powerpc/mm/numa.c                             |  9 +---
 arch/powerpc/platforms/powernv/pci-ioda-tce.c      |  1 -
 arch/powerpc/platforms/powernv/pci-ioda.c          |  7 ++-
 arch/powerpc/platforms/pseries/hotplug-cpu.c       | 19 ++++++++
 arch/powerpc/xmon/ppc-dis.c                        |  2 +-
 arch/s390/kernel/perf_cpum_sf.c                    |  6 +--
 arch/x86/boot/Makefile                             |  2 +-
 arch/x86/entry/entry_64.S                          |  4 ++
 arch/x86/events/intel/bts.c                        |  4 +-
 arch/x86/events/intel/pt.c                         |  5 +-
 arch/x86/hyperv/hv_init.c                          |  7 +++
 arch/x86/kernel/vmlinux.lds.S                      |  2 +-
 arch/x86/realmode/rm/Makefile                      |  2 +-
 block/bfq-iosched.c                                |  5 +-
 block/bfq-iosched.h                                |  3 ++
 drivers/acpi/acpi_video.c                          | 20 +++++---
 drivers/block/loop.c                               | 21 ++++++--
 drivers/cdrom/cdrom.c                              |  7 ++-
 drivers/char/hpet.c                                |  2 +-
 drivers/char/hw_random/virtio-rng.c                |  2 +-
 drivers/clk/clk-fractional-divider.c               |  2 +-
 drivers/clk/meson/meson-aoclk.c                    | 15 ++++--
 drivers/clk/rockchip/clk-rk3328.c                  | 12 ++---
 drivers/cpufreq/acpi-cpufreq.c                     |  4 +-
 drivers/crypto/amcc/crypto4xx_trng.c               |  4 +-
 drivers/crypto/cavium/zip/zip_main.c               |  6 ++-
 drivers/dma/imx-dma.c                              |  2 +-
 drivers/dma/qcom/hidma.c                           | 19 +++++---
 drivers/dma/tegra20-apb-dma.c                      |  5 +-
 drivers/firmware/efi/cper.c                        | 13 +++--
 drivers/firmware/efi/libstub/arm-stub.c            |  5 ++
 drivers/firmware/efi/libstub/efi-stub-helper.c     | 10 ++++
 drivers/firmware/efi/libstub/efistub.h             |  1 +
 drivers/firmware/efi/libstub/fdt.c                 |  3 ++
 drivers/firmware/efi/memattr.c                     |  2 +-
 drivers/gpio/gpio-omap.c                           | 14 +++---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  | 17 ++++++-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c  | 42 ++++++++--------
 drivers/gpu/drm/amd/display/dc/core/dc.c           |  3 ++
 .../drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c  |  7 +--
 drivers/gpu/drm/drm_dp_mst_topology.c              |  1 +
 drivers/gpu/drm/drm_fb_helper.c                    |  2 +-
 drivers/gpu/drm/drm_plane.c                        |  3 ++
 drivers/gpu/drm/nouveau/dispnv04/tvnv17.c          |  4 +-
 drivers/gpu/drm/rcar-du/rcar_du_kms.c              |  2 +
 drivers/gpu/drm/vkms/vkms_crtc.c                   |  3 ++
 drivers/hid/intel-ish-hid/ipc/ipc.c                |  9 ++--
 drivers/hid/intel-ish-hid/ishtp/bus.c              |  4 +-
 drivers/hwtracing/coresight/coresight-etm-perf.c   |  6 +--
 drivers/hwtracing/coresight/coresight-etm4x.c      |  3 +-
 drivers/i2c/i2c-core-of.c                          | 14 +++++-
 drivers/iio/adc/qcom-pm8xxx-xoadc.c                | 10 ++--
 drivers/infiniband/hw/cxgb4/cm.c                   |  5 +-
 drivers/infiniband/hw/mlx4/cm.c                    |  2 +-
 drivers/input/misc/soc_button_array.c              |  2 +-
 drivers/iommu/io-pgtable-arm-v7s.c                 |  3 +-
 drivers/leds/leds-lp55xx-common.c                  |  4 +-
 drivers/md/bcache/sysfs.c                          | 25 ++++++++--
 drivers/md/bcache/sysfs.h                          | 13 +++--
 drivers/md/dm-thin.c                               | 13 +++++
 drivers/media/i2c/mt9m111.c                        |  2 +
 drivers/media/i2c/ov7740.c                         |  7 ++-
 drivers/media/platform/mtk-jpeg/mtk_jpeg_core.c    | 40 +++++++--------
 drivers/media/platform/mx2_emmaprp.c               |  6 +--
 drivers/media/platform/rcar-vin/rcar-core.c        |  8 ++-
 drivers/media/platform/rockchip/rga/rga.c          |  6 +--
 drivers/media/platform/s5p-g2d/g2d.c               |  6 +--
 drivers/media/platform/s5p-jpeg/jpeg-core.c        | 57 ++++++++++++----------
 drivers/media/platform/sh_veu.c                    |  4 +-
 drivers/mmc/host/omap.c                            |  2 +-
 drivers/net/dsa/mv88e6xxx/chip.c                   |  8 +++
 drivers/net/ethernet/cisco/enic/enic_main.c        |  6 +--
 drivers/net/ethernet/intel/e1000e/netdev.c         | 21 ++++----
 drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c    | 17 ++++---
 drivers/net/ethernet/mellanox/mlx5/core/eswitch.c  | 17 ++++---
 drivers/net/ethernet/mellanox/mlxsw/spectrum.c     |  4 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c  |  6 +--
 drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c   |  2 +-
 drivers/net/phy/phy-c45.c                          | 10 +++-
 drivers/net/phy/phy_device.c                       | 13 +++--
 drivers/net/wireless/ath/ath10k/ce.c               | 26 +++++-----
 drivers/net/wireless/ath/ath10k/ce.h               |  2 +-
 drivers/net/wireless/ath/wil6210/cfg80211.c        | 14 ++++--
 .../wireless/broadcom/brcm80211/brcmfmac/common.c  |  2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c        | 20 +++++---
 drivers/net/wireless/intel/iwlwifi/pcie/rx.c       | 11 +++--
 drivers/net/wireless/marvell/mwifiex/cfg80211.c    | 10 ++--
 drivers/net/wireless/mediatek/mt76/eeprom.c        | 24 ++++++---
 drivers/net/wireless/mediatek/mt76/usb.c           | 11 +----
 drivers/net/wireless/mediatek/mt7601u/eeprom.h     |  2 +-
 drivers/net/wireless/ti/wlcore/main.c              |  7 ++-
 drivers/pci/pcie/pme.c                             | 22 ++++++---
 drivers/perf/arm_spe_pmu.c                         |  6 +--
 drivers/pinctrl/meson/pinctrl-meson8b.c            |  6 ++-
 drivers/platform/mellanox/mlxreg-hotplug.c         |  5 +-
 drivers/platform/x86/ideapad-laptop.c              |  2 +-
 drivers/platform/x86/intel-hid.c                   |  7 ++-
 drivers/platform/x86/intel_pmc_core.c              |  3 +-
 drivers/platform/x86/intel_pmc_core.h              |  2 +-
 drivers/regulator/act8865-regulator.c              |  5 +-
 drivers/s390/net/ism_drv.c                         | 12 +++--
 drivers/scsi/bnx2fc/bnx2fc_fcoe.c                  |  2 +-
 drivers/scsi/fcoe/fcoe.c                           |  2 +-
 drivers/scsi/fcoe/fcoe_ctlr.c                      |  7 ++-
 drivers/scsi/fcoe/fcoe_transport.c                 |  2 +-
 drivers/scsi/hisi_sas/hisi_sas_main.c              | 13 ++++-
 drivers/scsi/megaraid/megaraid_sas_base.c          |  1 +
 drivers/scsi/qedf/qedf_main.c                      |  2 +-
 drivers/scsi/scsi_scan.c                           |  6 +--
 drivers/soc/qcom/qcom_gsbi.c                       |  7 ++-
 drivers/soc/tegra/fuse/fuse-tegra.c                | 12 +++--
 drivers/staging/mt7621-spi/spi-mt7621.c            |  7 ++-
 drivers/tty/serial/8250/8250_pxa.c                 |  4 ++
 drivers/tty/serial/atmel_serial.c                  | 43 +++++++++++-----
 drivers/tty/tty_buffer.c                           |  2 +-
 drivers/usb/chipidea/core.c                        |  9 +++-
 drivers/usb/dwc3/gadget.c                          |  2 +
 drivers/usb/gadget/function/f_fs.c                 |  1 +
 drivers/video/backlight/pwm_bl.c                   |  2 +-
 drivers/video/fbdev/core/fbmem.c                   |  3 ++
 drivers/xen/gntdev-dmabuf.c                        | 12 ++++-
 drivers/xen/gntdev-dmabuf.h                        |  2 +-
 drivers/xen/gntdev.c                               |  2 +-
 fs/btrfs/qgroup.c                                  | 28 +++++------
 fs/buffer.c                                        |  7 +++
 fs/cifs/cifs_dfs_ref.c                             |  4 +-
 fs/cifs/connect.c                                  |  5 ++
 fs/cifs/file.c                                     | 14 +++++-
 fs/cifs/smb1ops.c                                  |  2 +-
 fs/cifs/smb2pdu.c                                  | 10 +++-
 fs/ext4/indirect.c                                 | 47 +++++++++---------
 fs/f2fs/f2fs.h                                     |  1 -
 fs/f2fs/inline.c                                   |  8 ++-
 fs/f2fs/super.c                                    | 13 ++---
 fs/f2fs/sysfs.c                                    | 12 +++--
 fs/f2fs/trace.c                                    | 20 +++++---
 fs/f2fs/xattr.c                                    | 13 +++--
 fs/file.c                                          |  1 +
 fs/jbd2/commit.c                                   |  6 ++-
 fs/jbd2/journal.c                                  | 52 ++++++++++----------
 fs/ocfs2/cluster/nodemanager.c                     | 14 +++---
 fs/read_write.c                                    |  6 +++
 fs/splice.c                                        | 12 +++++
 include/linux/cgroup-defs.h                        |  2 +-
 include/linux/cgroup.h                             |  2 +
 include/linux/clk-provider.h                       |  3 ++
 include/linux/f2fs_fs.h                            | 13 ++---
 include/linux/filter.h                             |  4 +-
 include/linux/irqdesc.h                            |  1 +
 include/linux/perf_event.h                         |  2 +-
 include/linux/relay.h                              |  2 +-
 include/linux/ring_buffer.h                        |  2 +-
 include/linux/sched.h                              |  4 +-
 include/linux/sched/topology.h                     |  8 +--
 include/net/netfilter/br_netfilter.h               |  1 -
 include/scsi/libfcoe.h                             |  4 +-
 kernel/cgroup/cgroup.c                             | 15 +++---
 kernel/cgroup/pids.c                               |  4 +-
 kernel/cgroup/rstat.c                              | 10 ++--
 kernel/cpu.c                                       |  9 ++++
 kernel/events/ring_buffer.c                        |  2 +-
 kernel/exit.c                                      |  1 +
 kernel/irq/chip.c                                  | 12 ++++-
 kernel/irq/internals.h                             |  8 ++-
 kernel/irq/irqdesc.c                               |  7 ++-
 kernel/rcu/update.c                                |  2 +
 kernel/sched/core.c                                |  9 ++--
 kernel/sched/debug.c                               |  4 ++
 kernel/sched/sched.h                               |  6 +--
 kernel/sched/topology.c                            |  2 +-
 kernel/sysctl.c                                    |  3 ++
 kernel/trace/ring_buffer.c                         |  5 +-
 kernel/trace/trace.c                               |  6 ++-
 kernel/trace/trace_kdb.c                           |  6 ++-
 lib/bsearch.c                                      |  2 +
 lib/raid6/Makefile                                 |  2 +-
 mm/cma.c                                           |  4 +-
 mm/memcontrol.c                                    | 19 ++++++--
 mm/mempolicy.c                                     |  2 +-
 mm/oom_kill.c                                      |  3 +-
 mm/page_alloc.c                                    |  2 +-
 mm/page_ext.c                                      |  1 +
 mm/page_poison.c                                   |  4 ++
 mm/slab.c                                          | 17 ++++---
 mm/sparse.c                                        |  2 +-
 mm/swapfile.c                                      | 51 ++++++++++---------
 mm/vmalloc.c                                       |  6 ++-
 net/bridge/br_netfilter_hooks.c                    |  5 --
 net/netfilter/nf_conntrack_core.c                  | 14 ++++--
 net/netfilter/nf_conntrack_proto_tcp.c             | 50 +++++++++++++++----
 net/netfilter/nf_tables_core.c                     | 14 +++---
 net/netfilter/xt_physdev.c                         |  9 +++-
 security/selinux/hooks.c                           |  9 +++-
 sound/core/pcm_native.c                            |  8 +++
 sound/firewire/dice/dice.c                         | 12 ++++-
 sound/soc/fsl/fsl-asoc-card.c                      |  1 +
 sound/soc/fsl/imx-sgtl5000.c                       |  1 +
 sound/soc/qcom/common.c                            | 10 +++-
 tools/lib/bpf/Makefile                             |  3 +-
 tools/lib/traceevent/event-parse.c                 |  2 +-
 tools/perf/builtin-c2c.c                           |  8 ++-
 tools/perf/tests/evsel-tp-sched.c                  |  6 +--
 tools/perf/util/annotate.c                         |  4 +-
 tools/perf/util/s390-cpumsf.c                      |  5 ++
 .../util/scripting-engines/trace-event-python.c    | 15 ++++--
 tools/perf/util/sort.c                             | 10 +++-
 tools/perf/util/srcline.c                          |  2 +-
 tools/testing/selftests/bpf/test_verifier.c        |  9 +++-
 tools/testing/selftests/seccomp/seccomp_bpf.c      |  6 +++
 230 files changed, 1275 insertions(+), 620 deletions(-)


