Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23193C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:12:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDE362192D
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:12:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553256760;
	bh=MJaiJHKCS179iCF1hOcLZBFOnR4/OAkn86VuxwZkxco=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=RztueDzby/2eH3Q9OUBDfQS3/B5mVacyQxz2I6U4hGUsx4ETZnFpGzQHZC7j+AO1V
	 qtRQoQ62WtTpjCTYtiseVTirHtpKepqMw0/f2kamcACeUlr4dRhQeIpfbJHejsjcr+
	 A543CEgGmYDBTQukS1GcULAzlncb2jgFZLVL/X6I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388996AbfCVMMi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 08:12:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:50736 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388696AbfCVMMe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 08:12:34 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EC4602083D;
        Fri, 22 Mar 2019 12:12:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553256752;
        bh=MJaiJHKCS179iCF1hOcLZBFOnR4/OAkn86VuxwZkxco=;
        h=From:To:Cc:Subject:Date:From;
        b=q45HudykzBN+T7/dXmLdpT7gpm4je5Q3O4/qs5KfF7/iX3IHPSgVosQZMDz7L5kei
         9yGIY4lP13rrNGCQRuoJdpgJIJlt8WY9mgk6bg7vp/PSt17A9+dWMPsEGwNxqqNW+l
         PfBDBmrh42qt99Cl1tciFZwNuFWwOi5hxRFQ3CMA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: [PATCH 5.0 000/238] 5.0.4-stable review
Date:   Fri, 22 Mar 2019 12:13:39 +0100
Message-Id: <20190322111258.383569278@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-5.0.4-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-5.0.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 5.0.4-rc1
X-KernelTest-Deadline: 2019-03-24T11:13+00:00
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the start of the stable review cycle for the 5.0.4 release.
There are 238 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Sun Mar 24 11:11:13 UTC 2019.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.0.4-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.0.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 5.0.4-rc1

Trond Myklebust <trond.myklebust@hammerspace.com>
    SUNRPC: Respect RPC call timeouts when retrying transmission

Trond Myklebust <trond.myklebust@hammerspace.com>
    SUNRPC: Fix up RPC back channel transmission

Trond Myklebust <trond.myklebust@hammerspace.com>
    SUNRPC: Prevent thundering herd when the socket is not connected

Martin Schwidefsky <schwidefsky@de.ibm.com>
    s390/setup: fix boot crash for machine without EDAT-1

Johan Hovold <johan@kernel.org>
    net: dsa: lantiq_gswip: fix OF child-node lookups

Johan Hovold <johan@kernel.org>
    net: dsa: lantiq_gswip: fix use-after-free on failed probe

Sean Christopherson <sean.j.christopherson@intel.com>
    KVM: nVMX: Check a single byte for VMCS "launched" in nested early checks

Sean Christopherson <sean.j.christopherson@intel.com>
    KVM: nVMX: Ignore limit checks on VMX instructions using flat segments

Sean Christopherson <sean.j.christopherson@intel.com>
    KVM: nVMX: Apply addr size mask to effective address for VMX instructions

Sean Christopherson <sean.j.christopherson@intel.com>
    KVM: nVMX: Sign extend displacements of VMX instr's mem operands

Sean Christopherson <sean.j.christopherson@intel.com>
    KVM: x86/mmu: Do not cache MMIO accesses while memslots are in flux

Sean Christopherson <sean.j.christopherson@intel.com>
    KVM: x86/mmu: Detect MMIO generation wrap in any address space

Sean Christopherson <sean.j.christopherson@intel.com>
    KVM: VMX: Zero out *all* general purpose registers after VM-Exit

Sean Christopherson <sean.j.christopherson@intel.com>
    KVM: VMX: Compare only a single byte for VMCS' "launched" in vCPU-run

Sean Christopherson <sean.j.christopherson@intel.com>
    KVM: Call kvm_arch_memslots_updated() before updating memslots

Harry Wentland <harry.wentland@amd.com>
    drm/amd/display: don't call dm_pp_ function from an fpu block

Evan Quan <evan.quan@amd.com>
    drm/amd/powerplay: correct power reading on fiji

Gustavo A. R. Silva <gustavo@embeddedor.com>
    drm/radeon/evergreen_cs: fix missing break in switch statement

Noralf Trønnes <noralf@tronnes.org>
    drm/fb-helper: generic: Fix drm_fbdev_client_restore()

Steve Longerbeam <slongerbeam@gmail.com>
    media: imx: csi: Stop upstream before disabling IDMA channel

Steve Longerbeam <slongerbeam@gmail.com>
    media: imx: csi: Disable CSI immediately after last EOF

Steve Longerbeam <slongerbeam@gmail.com>
    media: imx-csi: Input connections to CSI should be optional

Lucas A. M. Magalhães <lucmaga@gmail.com>
    media: vimc: Add vimc-streamer for stream control

Sakari Ailus <sakari.ailus@linux.intel.com>
    media: uvcvideo: Avoid NULL pointer dereference at the end of streaming

Chen-Yu Tsai <wens@csie.org>
    media: sun6i: Fix CSI regmap's max_register

French, Nicholas A <naf@ou.edu>
    media: lgdt330x: fix lock status reporting

Steve Longerbeam <slongerbeam@gmail.com>
    media: imx: prpencvf: Stop upstream before disabling IDMA channel

Zhang, Jun <jun.zhang@intel.com>
    rcu: Do RCU GP kthread self-wakeup from softirq and interrupt

Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
    tpm: Unify the send callback behaviour

Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
    tpm/tpm_crb: Avoid unaligned reads in crb_recv()

Steven Rostedt (VMware) <rostedt@goodmis.org>
    x86/ftrace: Fix warning and considate ftrace_jmp_replace() and ftrace_call_replace()

Pavel Tatashin <pasha.tatashin@soleen.com>
    x86/kvmclock: set offset for kvm unstable clock

Aditya Pakki <pakki001@umn.edu>
    md: Fix failed allocation of md_register_thread

Adrian Hunter <adrian.hunter@intel.com>
    perf intel-pt: Fix divide by zero when TSC is not available

Kan Liang <kan.liang@linux.intel.com>
    perf/x86/intel/uncore: Fix client IMC events return huge result

Adrian Hunter <adrian.hunter@intel.com>
    perf intel-pt: Fix overlap calculation for padding

Adrian Hunter <adrian.hunter@intel.com>
    perf auxtrace: Define auxtrace record alignment

Adrian Hunter <adrian.hunter@intel.com>
    perf tools: Fix split_kallsyms_for_kcore() for trampoline symbols

Adrian Hunter <adrian.hunter@intel.com>
    perf intel-pt: Fix CYC timestamp calculation after OVF

Josh Poimboeuf <jpoimboe@redhat.com>
    x86/unwind/orc: Fix ORC unwind table alignment

Nicolas Pitre <nicolas.pitre@linaro.org>
    vt: perform safe console erase in the right order

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    stable-kernel-rules.rst: add link to networking patch queue

Coly Li <colyli@suse.de>
    bcache: use (REQ_META|REQ_PRIO) to indicate bio for metadata

Tang Junhui <tang.junhui.linux@gmail.com>
    bcache: treat stale && dirty keys as bad keys

Daniel Axtens <dja@axtens.net>
    bcache: never writeback a discard operation

Viresh Kumar <viresh.kumar@linaro.org>
    PM / OPP: Update performance state when freq == old_freq

Viresh Kumar <viresh.kumar@linaro.org>
    PM / wakeup: Rework wakeup source timer cancellation

J. Bruce Fields <bfields@redhat.com>
    svcrpc: fix UDP on servers with lots of threads

Trond Myklebust <trond.myklebust@hammerspace.com>
    NFSv4.1: Reinitialise sequence results before retransmitting a request

Yihao Wu <wuyihao@linux.alibaba.com>
    nfsd: fix wrong check in write_v4_end_grace()

NeilBrown <neilb@suse.com>
    nfsd: fix memory corruption caused by readdir

J. Bruce Fields <bfields@redhat.com>
    nfsd: fix performance-limiting session calculation

Trond Myklebust <trond.myklebust@hammerspace.com>
    NFS: Don't recoalesce on error in nfs_pageio_complete_mirror()

Trond Myklebust <trond.myklebust@hammerspace.com>
    NFS: Fix an I/O request leakage in nfs_do_recoalesce

Trond Myklebust <trond.myklebust@hammerspace.com>
    NFS: Fix I/O request leakages

Rafael J. Wysocki <rafael.j.wysocki@intel.com>
    cpuidle: governor: Add new governors to cpuidle_governors again

Pavel Machek <pavel@ucw.cz>
    cpcap-charger: generate events for userspace

Gustavo A. R. Silva <gustavo@embeddedor.com>
    mfd: sm501: Fix potential NULL pointer dereference

Cody P Schafer <dev@codyps.com>
    media: cx25840: mark pad sig_types to fix cx231xx init

Mikulas Patocka <mpatocka@redhat.com>
    dm integrity: limit the rate of error messages

NeilBrown <neil@brown.name>
    dm: fix to_sector() for 32bit

Yang Yingliang <yangyingliang@huawei.com>
    ipmi_si: fix use-after-free of resource->name

Corey Minyard <cminyard@mvista.com>
    ipmi_si: Fix crash when using hard-coded device

Ben Gardon <bgardon@google.com>
    Revert "KVM/MMU: Flush tlb directly in the kvm_zap_gfn_range()"

Dave Martin <Dave.Martin@arm.com>
    arm64: KVM: Fix architecturally invalid reset value for FPEXC32_EL2

Will Deacon <will.deacon@arm.com>
    arm64: debug: Ensure debug handlers check triggering exception level

Will Deacon <will.deacon@arm.com>
    arm64: debug: Don't propagate UNKNOWN FAR into si_code for debug signals

Julien Thierry <julien.thierry@arm.com>
    arm64: Fix HCR.TGE status for NMI contexts

Gustavo A. R. Silva <gustavo@embeddedor.com>
    ARM: s3c24xx: Fix boolean expressions in osiris_dvs_notify

Christophe Leroy <christophe.leroy@c-s.fr>
    powerpc/traps: Fix the message printed when stack overflows

Christophe Leroy <christophe.leroy@c-s.fr>
    powerpc/traps: fix recoverability of machine check handling on book3s/32

Nicholas Piggin <npiggin@gmail.com>
    powerpc/smp: Fix NMI IPI xmon timeout

Nicholas Piggin <npiggin@gmail.com>
    powerpc/smp: Fix NMI IPI timeout

Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
    powerpc/hugetlb: Don't do runtime allocation of 16G pages in LPAR configuration

Michael Ellerman <mpe@ellerman.id.au>
    powerpc/ptrace: Simplify vr_get/set() to avoid GCC warning

Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
    powerpc: Fix 32-bit KVM-PR lockup and host crash with MacOS guest

Nicholas Piggin <npiggin@gmail.com>
    powerpc/64s/hash: Fix assert_slb_presence() use of the slbfee. instruction

Paul Mackerras <paulus@ozlabs.org>
    powerpc/powernv: Don't reprogram SLW image on every KVM guest entry/exit

Michael Ellerman <mpe@ellerman.id.au>
    powerpc/kvm: Save and restore host AMR/IAMR/UAMOR

Christophe Leroy <christophe.leroy@c-s.fr>
    powerpc/83xx: Also save/restore SPRG4-7 during suspend

Jordan Niethe <jniethe5@gmail.com>
    powerpc/powernv: Make opal log only readable by root

Christophe Leroy <christophe.leroy@c-s.fr>
    powerpc/wii: properly disable use of BATs when requested.

Christophe Leroy <christophe.leroy@c-s.fr>
    powerpc/32: Clear on-stack exception marker upon exception return

J. Bruce Fields <bfields@redhat.com>
    security/selinux: fix SECURITY_LSM_NATIVE_LABELS on reused superblock

Xin Long <lucien.xin@gmail.com>
    selinux: add the missing walk_size + len check in selinux_sctp_bind_connect

zhangyi (F) <yi.zhang@huawei.com>
    jbd2: fix compile warning when using JBUFFER_TRACE

zhangyi (F) <yi.zhang@huawei.com>
    jbd2: clear dirty flag when revoking a buffer from an older transaction

Jay Dolan <jay.dolan@accesio.com>
    serial: 8250_pci: Have ACCES cards that use the four port Pericom PI7C9X7954 chip use the pci_pericom_setup()

Jay Dolan <jay.dolan@accesio.com>
    serial: 8250_pci: Fix number of ports for ACCES serial cards

Lubomir Rintel <lkundrak@v3.sk>
    serial: 8250_of: assume reg-shift of 2 for mrvl,mmp-uart

Anssi Hannula <anssi.hannula@bitwise.fi>
    serial: uartps: Fix stuck ISR if RX disabled with non-empty FIFO

Phuong Nguyen <phuong.nguyen.xw@renesas.com>
    dmaengine: usb-dmac: Make DMAC system sleep callbacks explicit

Nikolaus Voss <nikolaus.voss@loewensteinmedical.de>
    usb: typec: tps6598x: handle block writes separately with plain-I2C adapters

Dmitry Osipenko <digetx@gmail.com>
    usb: chipidea: tegra: Fix missed ci_hdrc_remove_device()

Paul Cercueil <paul@crapouillou.net>
    clk: ingenic: Fix doc of ingenic_cgu_div_info

Paul Cercueil <paul@crapouillou.net>
    clk: ingenic: Fix round_rate misbehaving with non-integer dividers

Krzysztof Kozlowski <krzk@kernel.org>
    clk: samsung: exynos5: Fix kfree() of const memory on setting driver_override

Krzysztof Kozlowski <krzk@kernel.org>
    clk: samsung: exynos5: Fix possible NULL pointer exception on platform_device_alloc() failure

Tony Lindgren <tony@atomide.com>
    clk: clk-twl6040: Fix imprecise external abort for pdmclk

Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
    clk: uniphier: Fix update register for CPU-gear

Jan Kara <jack@suse.cz>
    ext2: Fix underflow in ext2_max_size()

Vaibhav Jain <vaibhav@linux.ibm.com>
    cxl: Wrap iterations over afu slices inside 'afu_list_lock'

Michael J. Ruhl <michael.j.ruhl@intel.com>
    IB/rdmavt: Fix concurrency panics in QP post_send and modify to error

Mike Marciniszyn <mike.marciniszyn@intel.com>
    IB/rdmavt: Fix loopback send with invalidate ordering

Michael J. Ruhl <michael.j.ruhl@intel.com>
    IB/hfi1: Close race condition on user context disable and close

Thomas Petazzoni <thomas.petazzoni@bootlin.com>
    PCI: pci-bridge-emul: Extend pci_bridge_emul_init() with flags

Thomas Petazzoni <thomas.petazzoni@bootlin.com>
    PCI: pci-bridge-emul: Create per-bridge copy of register behavior

Mika Westerberg <mika.westerberg@linux.intel.com>
    PCI: pciehp: Disable Data Link Layer State Changed event on suspend

Lucas Stach <l.stach@pengutronix.de>
    PCI: dwc: skip MSI init if MSIs have been explicitly disabled

Bjorn Andersson <bjorn.andersson@linaro.org>
    PCI: qcom: Don't deassert reset GPIO during probe

Dongdong Liu <liudongdong3@huawei.com>
    PCI/DPC: Fix print AER status in DPC event handling

Bjorn Helgaas <bhelgaas@google.com>
    PCI/ASPM: Use LTR if already enabled by platform

Joerg Roedel <jroedel@suse.de>
    swiotlb: Add is_swiotlb_active() function

Joerg Roedel <jroedel@suse.de>
    swiotlb: Introduce swiotlb_max_mapping_size()

Joerg Roedel <jroedel@suse.de>
    dma: Introduce dma_max_mapping_size()

Jan Kara <jack@suse.cz>
    ext4: fix crash during online resizing

yangerkun <yangerkun@huawei.com>
    ext4: add mask of ext4 flags to swap

yangerkun <yangerkun@huawei.com>
    ext4: update quota information while swapping boot loader inode

Mark Walton <mark.walton@serialtek.com>
    gpio: pca953x: Fix dereference of irq data in shutdown

Loic Poulain <loic.poulain@linaro.org>
    media: i2c: ov5640: Fix post-reset delay

Sowjanya Komatineni <skomatineni@nvidia.com>
    i2c: tegra: update maximum transfer size

Sowjanya Komatineni <skomatineni@nvidia.com>
    i2c: tegra: fix maximum transfer size

QiaoChong <qiaochong@loongson.cn>
    parport_pc: fix find_superio io compare code, should use equal test.

Alexander Shishkin <alexander.shishkin@linux.intel.com>
    intel_th: Don't reference unassigned outputs

Heikki Krogerus <heikki.krogerus@linux.intel.com>
    device property: Fix the length used in PROPERTY_ENTRY_STRING()

Bartosz Golaszewski <bgolaszewski@baylibre.com>
    nvmem: core: don't check the return value of notifier chain call

Zev Weiss <zev@bewilderbeest.net>
    kernel/sysctl.c: add missing range check in do_proc_dointvec_minmax_conv

Jan Stancek <jstancek@redhat.com>
    mm/memory.c: do_fault: avoid usage of stale vm_area_struct

Roman Penyaev <rpenyaev@suse.de>
    mm/vmalloc: fix size check for remap_vmalloc_range_partial()

zhongjiang <zhongjiang@huawei.com>
    mm: hwpoison: fix thp split handing in soft_offline_in_use_page()

yangerkun <yangerkun@huawei.com>
    ext4: cleanup pagecache before swap i_data

yangerkun <yangerkun@huawei.com>
    ext4: fix check of inode in swap_inode_boot_loader

Arnd Bergmann <arnd@arndb.de>
    cpufreq: pxa2xx: remove incorrect __init annotation

Yangtao Li <tiny.windzz@gmail.com>
    cpufreq: tegra124: add missing of_node_put()

Viresh Kumar <viresh.kumar@linaro.org>
    cpufreq: kryo: Release OPP tables on module removal

Masami Hiramatsu <mhiramat@kernel.org>
    x86/kprobes: Prohibit probing on optprobe template code

Doug Berger <opendmb@gmail.com>
    irqchip/brcmstb-l2: Use _irqsave locking variants in non-interrupt code

Zenghui Yu <yuzenghui@huawei.com>
    irqchip/gic-v3-its: Avoid parsing _indirect_ twice for Device table

Lubomir Rintel <lkundrak@v3.sk>
    libertas_tf: don't set URB_ZERO_PACKET on IN USB transfer

Stephen Boyd <swboyd@chromium.org>
    soc: qcom: rpmh: Avoid accessing freed memory from batch API

Filipe Manana <fdmanana@suse.com>
    Btrfs: fix deadlock between clone/dedupe and rename

Filipe Manana <fdmanana@suse.com>
    Btrfs: fix corruption reading shared and compressed extents after hole punching

Dan Robertson <dan@dlrobertson.com>
    btrfs: init csum_list before possible free

Johannes Thumshirn <jthumshirn@suse.de>
    btrfs: ensure that a DUP or RAID1 block group has exactly two stripes

Dan Carpenter <dan.carpenter@oracle.com>
    btrfs: drop the lock on error in btrfs_dev_replace_cancel

Anand Jain <anand.jain@oracle.com>
    btrfs: scrub: fix circular locking dependency warning

Filipe Manana <fdmanana@suse.com>
    Btrfs: setup a nofs context for memory allocation at __btrfs_set_acl

Filipe Manana <fdmanana@suse.com>
    Btrfs: setup a nofs context for memory allocation at btrfs_create_tree()

Finn Thain <fthain@telegraphics.com.au>
    m68k: Add -ffreestanding to CFLAGS

Vivek Goyal <vgoyal@redhat.com>
    ovl: Do not lose security.capability xattr over metadata file copy-up

Vivek Goyal <vgoyal@redhat.com>
    ovl: During copy up, first copy up data and then xattrs

Jann Horn <jannh@google.com>
    splice: don't merge into linked buffers

Varad Gautam <vrd@amazon.de>
    fs/devpts: always delete dcache dentry-s in dput()

Quinn Tran <qtran@marvell.com>
    scsi: qla2xxx: Use complete switch scan for RSCN events

Giridhar Malavali <gmalavali@marvell.com>
    scsi: qla2xxx: Avoid PCI IRQ affinity mapping when multiqueue is not supported

Himanshu Madhani <hmadhani@marvell.com>
    scsi: qla2xxx: Fix LUN discovery if loop id is not assigned yet by firmware

Bart Van Assche <bvanassche@acm.org>
    scsi: target/iscsi: Avoid iscsit_release_commands_from_conn() deadlock

Martin K. Petersen <martin.petersen@oracle.com>
    scsi: sd: Optimal I/O size should be a multiple of physical block size

Sagar Biradar <sagar.biradar@microchip.com>
    scsi: aacraid: Fix performance issue on logical drives

Felipe Franciosi <felipe@nutanix.com>
    scsi: virtio_scsi: don't send sc payload with tmfs

Halil Pasic <pasic@linux.ibm.com>
    s390/virtio: handle find on invalid queue gracefully

Martin Schwidefsky <schwidefsky@de.ibm.com>
    s390/setup: fix early warning messages

Pierre Morel <pmorel@linux.ibm.com>
    s390: vfio_ap: link the vfio_ap devices to the vfio_ap bus subsystem

Samuel Holland <samuel@sholland.org>
    clocksource/drivers/arch_timer: Workaround for Allwinner A64 timer instability

Stuart Menefy <stuart.menefy@mathembedded.com>
    clocksource/drivers/exynos_mct: Clear timer interrupt when shutdown

Stuart Menefy <stuart.menefy@mathembedded.com>
    clocksource/drivers/exynos_mct: Move one-shot check from tick clear to ISR

Felix Fietkau <nbd@nbd.name>
    mt76: fix corrupted software generated tx CCMP PN

Stuart Menefy <stuart.menefy@mathembedded.com>
    regulator: s2mpa01: Fix step values for some LDOs

Mark Zhang <markz@nvidia.com>
    regulator: max77620: Initialize values for DT properties

Krzysztof Kozlowski <krzk@kernel.org>
    regulator: s2mps11: Fix steps for buck7, buck8 and LDO35

Russell King <rmk+kernel@armlinux.org.uk>
    spi: spi-gpio: fix SPI_CS_HIGH capability

Vignesh R <vigneshr@ti.com>
    spi: omap2-mcspi: Fix DMA and FIFO event trigger size mismatch

Andy Shevchenko <andriy.shevchenko@linux.intel.com>
    spi: pxa2xx: Setup maximum supported DMA transfer length

Vignesh R <vigneshr@ti.com>
    spi: ti-qspi: Fix mmap read when more than one CS in use

Jiong Wu <lohengrin1024@gmail.com>
    mmc:fix a bug when max_discard is 0

Takeshi Saito <takeshi.saito.xv@renesas.com>
    mmc: renesas_sdhi: Fix card initialization failure in high speed mode

BOUGH CHEN <haibo.chen@nxp.com>
    mmc: sdhci-esdhc-imx: fix HS400 timing issue

Andy Shevchenko <andriy.shevchenko@linux.intel.com>
    ACPI / device_sysfs: Avoid OF modalias creation for removed device

Juergen Gross <jgross@suse.com>
    xen: fix dom0 boot on huge systems

Dan Carpenter <dan.carpenter@oracle.com>
    vmw_balloon: release lock on error in vmballoon_reset()

Jann Horn <jannh@google.com>
    tracing/perf: Use strndup_user() instead of buggy open-coded version

zhangyi (F) <yi.zhang@huawei.com>
    tracing: Do not free iter->trace in fail path of tracing_open_pipe()

Tom Zanussi <tom.zanussi@linux.intel.com>
    tracing: Use strncpy instead of memcpy for string keys in hist triggers

Steve French <stfrench@microsoft.com>
    smb3: make default i/o size for smb3 mounts larger

Pavel Shilovsky <piastryyy@gmail.com>
    CIFS: Fix read after write for files with read caching

Pavel Shilovsky <piastryyy@gmail.com>
    CIFS: Do not skip SMB2 message IDs on send failures

Pavel Shilovsky <piastryyy@gmail.com>
    CIFS: Do not reset lease state to NONE on lease break

Pavel Shilovsky <pshilov@microsoft.com>
    CIFS: Fix leaking locked VFS cache pages in writeback retry

Ard Biesheuvel <ard.biesheuvel@linaro.org>
    crypto: arm64/aes-ccm - fix bugs in non-NEON fallback routine

Ard Biesheuvel <ard.biesheuvel@linaro.org>
    crypto: arm64/aes-ccm - fix logical bug in AAD MAC handling

Eric Biggers <ebiggers@google.com>
    crypto: x86/morus - fix handling chunked inputs and MAY_SLEEP

Eric Biggers <ebiggers@google.com>
    crypto: x86/aesni-gcm - fix crash on empty plaintext

Eric Biggers <ebiggers@google.com>
    crypto: x86/aegis - fix handling chunked inputs and MAY_SLEEP

Eric Biggers <ebiggers@google.com>
    crypto: testmgr - skip crc32c context test for ahash algorithms

Eric Biggers <ebiggers@google.com>
    crypto: skcipher - set CRYPTO_TFM_NEED_KEY if ->setkey() fails

Eric Biggers <ebiggers@google.com>
    crypto: pcbc - remove bogus memcpy()s with src == dest

Eric Biggers <ebiggers@google.com>
    crypto: morus - fix handling chunked inputs

Eric Biggers <ebiggers@google.com>
    crypto: hash - set CRYPTO_TFM_NEED_KEY if ->setkey() fails

Ard Biesheuvel <ard.biesheuvel@linaro.org>
    crypto: arm64/crct10dif - revert to C code for short inputs

Eric Biggers <ebiggers@google.com>
    crypto: arm64/aes-neonbs - fix returning final keystream block

Ard Biesheuvel <ard.biesheuvel@linaro.org>
    crypto: arm/crct10dif - revert to C code for short inputs

Eric Biggers <ebiggers@google.com>
    crypto: aegis - fix handling chunked inputs

Eric Biggers <ebiggers@google.com>
    crypto: aead - set CRYPTO_TFM_NEED_KEY if ->setkey() fails

Al Viro <viro@zeniv.linux.org.uk>
    fix cgroup_do_mount() handling of failure exits

Oliver O'Halloran <oohall@gmail.com>
    libnvdimm: Fix altmap reservation size calculation

Dan Williams <dan.j.williams@intel.com>
    libnvdimm/pmem: Honor force_raw for legacy pmem regions

Wei Yang <richardw.yang@linux.intel.com>
    libnvdimm, pfn: Fix over-trim in trim_pfn_device()

Dan Williams <dan.j.williams@intel.com>
    libnvdimm/label: Clear 'updating' flag after label-set update

Dan Williams <dan.j.williams@intel.com>
    nfit/ars: Attempt short-ARS even in the no_init_ars case

Dan Williams <dan.j.williams@intel.com>
    nfit/ars: Attempt a short-ARS whenever the ARS state is idle at boot

Dan Williams <dan.j.williams@intel.com>
    acpi/nfit: Fix bus command validation

Dexuan Cui <decui@microsoft.com>
    nfit: acpi_nfit_ctl(): Check out_obj->type in the right place

Dan Williams <dan.j.williams@intel.com>
    nfit: Fix nfit_intel_shutdown_status() command submission

Matthew Wilcox <willy@infradead.org>
    dax: Flush partial PMDs correctly

Zhang Zhijie <zhangzj@rock-chips.com>
    crypto: rockchip - update new iv to device in multiple operations

Zhang Zhijie <zhangzj@rock-chips.com>
    crypto: rockchip - fix scatterlist nents error

Eric Biggers <ebiggers@google.com>
    crypto: ahash - fix another early termination in hash walk

Eric Biggers <ebiggers@google.com>
    crypto: ofb - fix handling partial blocks and make thread-safe

Eric Biggers <ebiggers@google.com>
    crypto: cfb - remove bogus memcpy() with src == dest

Eric Biggers <ebiggers@google.com>
    crypto: cfb - add missing 'chunksize' property

Gilad Ben-Yossef <gilad@benyossef.com>
    crypto: ccree - don't copy zero size ciphertext

Gilad Ben-Yossef <gilad@benyossef.com>
    crypto: ccree - unmap buffer before copying IV

Hadar Gat <hadar.gat@arm.com>
    crypto: ccree - fix free of unallocated mlli buffer

Horia Geantă <horia.geanta@nxp.com>
    crypto: caam - fix DMA mapping of stack memory

Pankaj Gupta <pankaj.gupta@nxp.com>
    crypto: caam - fixed handling of sg list

Gustavo A. R. Silva <gustavo@embeddedor.com>
    crypto: ccree - fix missing break in switch statement

Franck LENORMAND <franck.lenormand@nxp.com>
    crypto: caam - fix hash context DMA unmap size

Zhi Jin <zhi.jin@intel.com>
    stm class: Fix an endless loop in channel allocation

Alexander Shishkin <alexander.shishkin@linux.intel.com>
    stm class: Prevent division by zero

Alexander Usyskin <alexander.usyskin@intel.com>
    mei: bus: move hw module get/put to probe/release

Alexander Usyskin <alexander.usyskin@intel.com>
    mei: hbm: clean the feature flags on link reset

Krzysztof Kozlowski <krzk@kernel.org>
    iio: adc: exynos-adc: Use proper number of channels for Exynos4x12

Krzysztof Kozlowski <krzk@kernel.org>
    iio: adc: exynos-adc: Fix NULL pointer exception on unbind

Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
    ASoC: codecs: pcm186x: Fix energysense SLEEP bit

Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
    ASoC: codecs: pcm186x: fix wrong usage of DECLARE_TLV_DB_SCALE()

S.j. Wang <shengjiu.wang@nxp.com>
    ASoC: fsl_esai: fix register setting issue in RIGHT_J mode

zhengbin <zhengbin13@huawei.com>
    9p/net: fix memory leak in p9_client_create

Hou Tao <houtao1@huawei.com>
    9p: use inode->i_lock to protect i_size_write() under 32-bit


-------------

Diffstat:

 Documentation/DMA-API.txt                          |   8 +
 Documentation/arm64/silicon-errata.txt             |   2 +
 .../bindings/iio/adc/samsung,exynos-adc.txt        |   4 +-
 Documentation/process/stable-kernel-rules.rst      |   3 +
 Makefile                                           |   4 +-
 arch/arm/crypto/crct10dif-ce-core.S                |  14 +-
 arch/arm/crypto/crct10dif-ce-glue.c                |  23 +-
 arch/arm/mach-s3c24xx/mach-osiris-dvs.c            |   8 +-
 arch/arm64/crypto/aes-ce-ccm-core.S                |   5 +-
 arch/arm64/crypto/aes-ce-ccm-glue.c                |   4 +-
 arch/arm64/crypto/aes-neonbs-core.S                |   8 +-
 arch/arm64/crypto/crct10dif-ce-glue.c              |  25 +--
 arch/arm64/include/asm/hardirq.h                   |  31 +++
 arch/arm64/kernel/irq.c                            |   3 +
 arch/arm64/kernel/kgdb.c                           |  14 +-
 arch/arm64/kernel/probes/kprobes.c                 |   6 +
 arch/arm64/kvm/sys_regs.c                          |   2 +-
 arch/arm64/mm/fault.c                              |   9 +-
 arch/m68k/Makefile                                 |   5 +-
 arch/mips/include/asm/kvm_host.h                   |   2 +-
 arch/powerpc/include/asm/book3s/64/hugetlb.h       |   8 +
 arch/powerpc/include/asm/kvm_host.h                |   2 +-
 arch/powerpc/include/asm/powernv.h                 |   2 +
 arch/powerpc/kernel/entry_32.S                     |   9 +
 arch/powerpc/kernel/process.c                      |   2 +-
 arch/powerpc/kernel/ptrace.c                       |  10 +-
 arch/powerpc/kernel/smp.c                          |  90 +++-----
 arch/powerpc/kernel/traps.c                        |  12 +-
 arch/powerpc/kvm/book3s_hv_rmhandlers.S            |  26 ++-
 arch/powerpc/mm/slb.c                              |   5 +
 arch/powerpc/platforms/83xx/suspend-asm.S          |  34 ++-
 arch/powerpc/platforms/embedded6xx/wii.c           |   4 +
 arch/powerpc/platforms/powernv/idle.c              |  27 +--
 arch/powerpc/platforms/powernv/opal-msglog.c       |   2 +-
 arch/powerpc/platforms/powernv/smp.c               |  25 +++
 arch/s390/include/asm/kvm_host.h                   |   2 +-
 arch/s390/kernel/setup.c                           |  31 ++-
 arch/x86/crypto/aegis128-aesni-glue.c              |  38 ++--
 arch/x86/crypto/aegis128l-aesni-glue.c             |  38 ++--
 arch/x86/crypto/aegis256-aesni-glue.c              |  38 ++--
 arch/x86/crypto/aesni-intel_glue.c                 |  13 +-
 arch/x86/crypto/morus1280_glue.c                   |  40 ++--
 arch/x86/crypto/morus640_glue.c                    |  39 ++--
 arch/x86/events/intel/uncore.c                     |   1 +
 arch/x86/events/intel/uncore.h                     |  12 +-
 arch/x86/events/intel/uncore_snb.c                 |   4 +-
 arch/x86/include/asm/kvm_host.h                    |   2 +-
 arch/x86/kernel/ftrace.c                           |  42 ++--
 arch/x86/kernel/kprobes/opt.c                      |   5 +
 arch/x86/kernel/kvmclock.c                         |   6 +-
 arch/x86/kvm/mmu.c                                 |  39 ++--
 arch/x86/kvm/vmx/nested.c                          |  43 +++-
 arch/x86/kvm/vmx/vmx.c                             |  16 +-
 arch/x86/kvm/x86.c                                 |   4 +-
 arch/x86/kvm/x86.h                                 |   7 +-
 arch/x86/xen/mmu_pv.c                              |  13 +-
 crypto/aead.c                                      |   4 +-
 crypto/aegis128.c                                  |  14 +-
 crypto/aegis128l.c                                 |  14 +-
 crypto/aegis256.c                                  |  14 +-
 crypto/ahash.c                                     |  42 ++--
 crypto/cfb.c                                       |  14 +-
 crypto/morus1280.c                                 |  13 +-
 crypto/morus640.c                                  |  13 +-
 crypto/ofb.c                                       |  91 ++++----
 crypto/pcbc.c                                      |  14 +-
 crypto/shash.c                                     |  18 +-
 crypto/skcipher.c                                  |  27 ++-
 crypto/testmgr.c                                   |  14 +-
 crypto/testmgr.h                                   |  53 ++++-
 drivers/acpi/device_sysfs.c                        |   6 +-
 drivers/acpi/nfit/core.c                           |  84 ++++----
 drivers/base/power/wakeup.c                        |   8 +-
 drivers/char/ipmi/ipmi_si.h                        |   4 +-
 drivers/char/ipmi/ipmi_si_hardcode.c               | 236 +++++++++++++++------
 drivers/char/ipmi/ipmi_si_intf.c                   |  28 ++-
 drivers/char/ipmi/ipmi_si_mem_io.c                 |   5 +-
 drivers/char/ipmi/ipmi_si_platform.c               |  29 ++-
 drivers/char/ipmi/ipmi_si_port_io.c                |   5 +-
 drivers/char/tpm/st33zp24/st33zp24.c               |   2 +-
 drivers/char/tpm/tpm-interface.c                   |  11 +-
 drivers/char/tpm/tpm_atmel.c                       |   2 +-
 drivers/char/tpm/tpm_crb.c                         |  22 +-
 drivers/char/tpm/tpm_i2c_atmel.c                   |   6 +-
 drivers/char/tpm/tpm_i2c_infineon.c                |   2 +-
 drivers/char/tpm/tpm_i2c_nuvoton.c                 |   2 +-
 drivers/char/tpm/tpm_ibmvtpm.c                     |   8 +-
 drivers/char/tpm/tpm_infineon.c                    |   2 +-
 drivers/char/tpm/tpm_nsc.c                         |   2 +-
 drivers/char/tpm/tpm_tis_core.c                    |   2 +-
 drivers/char/tpm/tpm_vtpm_proxy.c                  |   3 +-
 drivers/char/tpm/xen-tpmfront.c                    |   2 +-
 drivers/clk/clk-twl6040.c                          |  53 ++++-
 drivers/clk/ingenic/cgu.c                          |  10 +-
 drivers/clk/ingenic/cgu.h                          |   2 +-
 drivers/clk/samsung/clk-exynos5-subcmu.c           |  13 +-
 drivers/clk/uniphier/clk-uniphier-cpugear.c        |   2 +-
 drivers/clocksource/Kconfig                        |  10 +
 drivers/clocksource/arm_arch_timer.c               |  55 +++++
 drivers/clocksource/exynos_mct.c                   |  23 +-
 drivers/cpufreq/pxa2xx-cpufreq.c                   |   4 +-
 drivers/cpufreq/qcom-cpufreq-kryo.c                |  20 +-
 drivers/cpufreq/tegra124-cpufreq.c                 |   2 +
 drivers/cpuidle/governor.c                         |   1 +
 drivers/crypto/caam/caamalg.c                      |   1 +
 drivers/crypto/caam/caamhash.c                     |  93 +++-----
 drivers/crypto/ccree/cc_buffer_mgr.c               |   8 +-
 drivers/crypto/ccree/cc_cipher.c                   |   7 +-
 drivers/crypto/rockchip/rk3288_crypto.c            |   2 +-
 drivers/crypto/rockchip/rk3288_crypto.h            |   4 +-
 drivers/crypto/rockchip/rk3288_crypto_ablkcipher.c |  39 +++-
 drivers/crypto/rockchip/rk3288_crypto_ahash.c      |   2 +-
 drivers/dma/sh/usb-dmac.c                          |   2 +
 drivers/gpio/gpio-pca953x.c                        |   3 +-
 drivers/gpu/drm/amd/display/dc/calcs/dcn_calcs.c   |   8 +-
 drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c   |   6 +-
 drivers/gpu/drm/drm_fb_helper.c                    |   4 +-
 drivers/gpu/drm/radeon/evergreen_cs.c              |   1 +
 drivers/hwtracing/intel_th/gth.c                   |   4 +
 drivers/hwtracing/stm/core.c                       |  11 +-
 drivers/i2c/busses/i2c-tegra.c                     |   8 +-
 drivers/iio/adc/exynos_adc.c                       |  19 +-
 drivers/infiniband/hw/hfi1/hfi.h                   |   2 +-
 drivers/infiniband/hw/hfi1/init.c                  |  14 +-
 drivers/infiniband/sw/rdmavt/qp.c                  |  59 ++++--
 drivers/irqchip/irq-brcmstb-l2.c                   |  10 +-
 drivers/irqchip/irq-gic-v3-its.c                   |   2 +
 drivers/md/bcache/extents.c                        |  13 +-
 drivers/md/bcache/request.c                        |   7 +-
 drivers/md/bcache/writeback.h                      |   3 +
 drivers/md/dm-integrity.c                          |   8 +-
 drivers/md/raid10.c                                |   2 +
 drivers/md/raid5.c                                 |   2 +
 drivers/media/dvb-frontends/lgdt330x.c             |   2 +-
 drivers/media/i2c/cx25840/cx25840-core.c           |   3 +-
 drivers/media/i2c/cx25840/cx25840-core.h           |   1 -
 drivers/media/i2c/ov5640.c                         |   2 +-
 drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c |   2 +-
 drivers/media/platform/vimc/Makefile               |   3 +-
 drivers/media/platform/vimc/vimc-capture.c         |  18 +-
 drivers/media/platform/vimc/vimc-common.c          |  35 ---
 drivers/media/platform/vimc/vimc-common.h          |  15 +-
 drivers/media/platform/vimc/vimc-debayer.c         |  26 +--
 drivers/media/platform/vimc/vimc-scaler.c          |  28 +--
 drivers/media/platform/vimc/vimc-sensor.c          |  56 ++---
 drivers/media/platform/vimc/vimc-streamer.c        | 188 ++++++++++++++++
 drivers/media/platform/vimc/vimc-streamer.h        |  38 ++++
 drivers/media/usb/uvc/uvc_video.c                  |   8 +
 drivers/mfd/sm501.c                                |   3 +
 drivers/misc/cxl/guest.c                           |   2 +
 drivers/misc/cxl/pci.c                             |  39 +++-
 drivers/misc/mei/bus.c                             |  21 +-
 drivers/misc/mei/hbm.c                             |   7 +
 drivers/misc/vmw_balloon.c                         |   5 +-
 drivers/mmc/core/core.c                            |   4 +-
 drivers/mmc/host/renesas_sdhi_core.c               |  11 +-
 drivers/mmc/host/sdhci-esdhc-imx.c                 |   1 +
 drivers/net/dsa/lantiq_gswip.c                     |  21 +-
 drivers/net/wireless/marvell/libertas_tf/if_usb.c  |   2 -
 drivers/net/wireless/mediatek/mt76/mt76x02_mac.c   |   2 +-
 drivers/nvdimm/label.c                             |  23 +-
 drivers/nvdimm/namespace_devs.c                    |   4 +
 drivers/nvdimm/pfn_devs.c                          |   4 +-
 drivers/nvmem/core.c                               |   4 +-
 drivers/opp/core.c                                 |   2 +-
 drivers/parport/parport_pc.c                       |   2 +-
 drivers/pci/controller/dwc/pcie-designware-host.c  |   2 +-
 drivers/pci/controller/dwc/pcie-qcom.c             |   2 +-
 drivers/pci/controller/pci-aardvark.c              |   2 +-
 drivers/pci/controller/pci-mvebu.c                 |   2 +-
 drivers/pci/hotplug/pciehp_hpc.c                   |  17 +-
 drivers/pci/pci-bridge-emul.c                      |  86 +++++---
 drivers/pci/pci-bridge-emul.h                      |  13 +-
 drivers/pci/pcie/dpc.c                             |  27 ++-
 drivers/pci/probe.c                                |  36 ++--
 drivers/power/supply/cpcap-charger.c               |   1 +
 drivers/regulator/max77620-regulator.c             |  10 +-
 drivers/regulator/s2mpa01.c                        |  10 +-
 drivers/regulator/s2mps11.c                        |   6 +-
 drivers/s390/crypto/vfio_ap_drv.c                  |  44 +++-
 drivers/s390/crypto/vfio_ap_ops.c                  |   4 +-
 drivers/s390/crypto/vfio_ap_private.h              |   1 +
 drivers/s390/virtio/virtio_ccw.c                   |   4 +-
 drivers/scsi/aacraid/linit.c                       |  13 +-
 drivers/scsi/qla2xxx/qla_init.c                    |  99 +--------
 drivers/scsi/qla2xxx/qla_isr.c                     |   2 +-
 drivers/scsi/qla2xxx/qla_os.c                      |   2 +-
 drivers/scsi/sd.c                                  |  59 +++++-
 drivers/scsi/virtio_scsi.c                         |   2 -
 drivers/soc/qcom/rpmh.c                            |  34 +--
 drivers/spi/spi-gpio.c                             |   4 +-
 drivers/spi/spi-omap2-mcspi.c                      |   4 +-
 drivers/spi/spi-pxa2xx.c                           |   1 +
 drivers/spi/spi-ti-qspi.c                          |   6 +-
 drivers/staging/media/imx/imx-ic-prpencvf.c        |  26 ++-
 drivers/staging/media/imx/imx-media-csi.c          |  44 ++--
 drivers/target/iscsi/iscsi_target.c                |   4 +-
 drivers/tty/serial/8250/8250_of.c                  |   4 +
 drivers/tty/serial/8250/8250_pci.c                 | 141 ++++++++++--
 drivers/tty/serial/xilinx_uartps.c                 |   8 +-
 drivers/tty/vt/vt.c                                |  15 +-
 drivers/usb/chipidea/ci_hdrc_tegra.c               |   1 +
 drivers/usb/typec/tps6598x.c                       |  26 ++-
 fs/9p/v9fs_vfs.h                                   |  23 +-
 fs/9p/vfs_file.c                                   |   6 +-
 fs/9p/vfs_inode.c                                  |  23 +-
 fs/9p/vfs_inode_dotl.c                             |  27 +--
 fs/9p/vfs_super.c                                  |   4 +-
 fs/btrfs/acl.c                                     |   9 +
 fs/btrfs/dev-replace.c                             |   1 +
 fs/btrfs/disk-io.c                                 |   8 +
 fs/btrfs/extent_io.c                               |   4 +-
 fs/btrfs/ioctl.c                                   |  21 +-
 fs/btrfs/scrub.c                                   |  24 +--
 fs/btrfs/volumes.c                                 |   4 +-
 fs/cifs/cifs_fs_sb.h                               |   1 +
 fs/cifs/cifsfs.c                                   |   1 +
 fs/cifs/cifsglob.h                                 |  20 ++
 fs/cifs/cifssmb.c                                  |  17 +-
 fs/cifs/connect.c                                  |  26 ++-
 fs/cifs/file.c                                     |  12 +-
 fs/cifs/inode.c                                    |   2 +-
 fs/cifs/smb2misc.c                                 |  17 +-
 fs/cifs/smb2ops.c                                  |  28 ++-
 fs/cifs/smb2transport.c                            |  14 +-
 fs/cifs/transport.c                                |   6 +-
 fs/dax.c                                           |  19 +-
 fs/devpts/inode.c                                  |   1 +
 fs/ext2/super.c                                    |  39 ++--
 fs/ext4/ext4.h                                     |   3 +
 fs/ext4/ioctl.c                                    | 100 ++++++---
 fs/ext4/resize.c                                   |   3 +-
 fs/jbd2/transaction.c                              |  33 +--
 fs/kernfs/mount.c                                  |   8 +-
 fs/nfs/nfs4proc.c                                  |  12 +-
 fs/nfs/pagelist.c                                  |  29 ++-
 fs/nfsd/nfs3proc.c                                 |  16 +-
 fs/nfsd/nfs3xdr.c                                  |   1 +
 fs/nfsd/nfs4state.c                                |   8 +-
 fs/nfsd/nfsctl.c                                   |   2 +-
 fs/overlayfs/copy_up.c                             |  59 ++++--
 fs/overlayfs/overlayfs.h                           |   2 +
 fs/overlayfs/util.c                                |  55 +++--
 fs/pipe.c                                          |  14 ++
 fs/splice.c                                        |   4 +
 include/asm-generic/vmlinux.lds.h                  |   2 +-
 include/linux/device-mapper.h                      |   2 +-
 include/linux/dma-mapping.h                        |   8 +
 include/linux/hardirq.h                            |   7 +
 include/linux/kvm_host.h                           |   2 +-
 include/linux/pipe_fs_i.h                          |   1 +
 include/linux/property.h                           |   2 +-
 include/linux/swiotlb.h                            |  11 +
 kernel/cgroup/cgroup.c                             |   9 +-
 kernel/dma/direct.c                                |  11 +
 kernel/dma/mapping.c                               |  14 ++
 kernel/dma/swiotlb.c                               |  14 ++
 kernel/rcu/tree.c                                  |  19 +-
 kernel/sysctl.c                                    |  11 +-
 kernel/trace/trace.c                               |   1 -
 kernel/trace/trace_event_perf.c                    |  16 +-
 kernel/trace/trace_events_hist.c                   |   5 +-
 mm/memory-failure.c                                |  14 +-
 mm/memory.c                                        |   5 +-
 mm/vmalloc.c                                       |   2 +-
 net/9p/client.c                                    |   2 +-
 net/sunrpc/clnt.c                                  | 124 ++++++-----
 net/sunrpc/svcsock.c                               |  20 +-
 security/selinux/hooks.c                           |   8 +-
 sound/soc/codecs/pcm186x.c                         |   8 +-
 sound/soc/fsl/fsl_esai.c                           |   7 +-
 tools/perf/util/auxtrace.c                         |   4 +-
 tools/perf/util/auxtrace.h                         |   3 +
 .../perf/util/intel-pt-decoder/intel-pt-decoder.c  |  37 +++-
 tools/perf/util/intel-pt.c                         |   2 +
 tools/perf/util/symbol.c                           |   2 +
 virt/kvm/arm/mmu.c                                 |   2 +-
 virt/kvm/kvm_main.c                                |   7 +-
 278 files changed, 3049 insertions(+), 1609 deletions(-)


