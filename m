Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 741FCC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:49:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 142F92183E
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:49:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553258999;
	bh=iuWSUxpda/jurb6TiAol+Ut0rrUw+289DpQNYJAkrJg=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=v5SqjXqjPa7LJXKuEOG97BCpsygZHvEyZFYRE+hBHvRB5zMqMj0FLnnsZNtGDLmiM
	 BIetacs+cpsWrR25Anyz8hio1J73yLGqe1lb0NtIGyYdowuhno4MfGomLC1RpxPm4K
	 CQnNrb3afWRAzxyzlbmyKxsKw0xKXdCesSXE5BSc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387507AbfCVL4R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 07:56:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:60840 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733000AbfCVL4K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 07:56:10 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D41E72192C;
        Fri, 22 Mar 2019 11:56:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553255768;
        bh=iuWSUxpda/jurb6TiAol+Ut0rrUw+289DpQNYJAkrJg=;
        h=From:To:Cc:Subject:Date:From;
        b=y07G+vK9YkLRc0SRTwILMhidFKEzO9NcuMt0jkKEk1+4ZVAneCZsd1QtkISELaV0h
         KmV/YgbO6s4PRFIFzva7Lo/JfIPnV5Lk8mtvjjaPzFo8s1vU2suwxxaBRfCpULLrpb
         p3cCBYsQ3iQ0VmuWH3Razsol8MMeiwMfBP/1DqF4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: [PATCH 4.19 000/280] 4.19.31-stable review
Date:   Fri, 22 Mar 2019 12:12:33 +0100
Message-Id: <20190322111306.356185024@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.31-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.19.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.19.31-rc1
X-KernelTest-Deadline: 2019-03-24T11:13+00:00
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the start of the stable review cycle for the 4.19.31 release.
There are 280 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Sun Mar 24 11:11:09 UTC 2019.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.31-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.19.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 4.19.31-rc1

Martin Schwidefsky <schwidefsky@de.ibm.com>
    s390/setup: fix boot crash for machine without EDAT-1

Coly Li <colyli@suse.de>
    bcache: use (REQ_META|REQ_PRIO) to indicate bio for metadata

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

Lucas A. M. Magalhães <lucmaga@gmail.com>
    media: vimc: Add vimc-streamer for stream control

Sakari Ailus <sakari.ailus@linux.intel.com>
    media: uvcvideo: Avoid NULL pointer dereference at the end of streaming

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

Daniel Axtens <dja@axtens.net>
    bcache: never writeback a discard operation

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

Pavel Machek <pavel@ucw.cz>
    cpcap-charger: generate events for userspace

Gustavo A. R. Silva <gustavo@embeddedor.com>
    mfd: sm501: Fix potential NULL pointer dereference

Mikulas Patocka <mpatocka@redhat.com>
    dm integrity: limit the rate of error messages

NeilBrown <neil@brown.name>
    dm: fix to_sector() for 32bit

Yang Yingliang <yangyingliang@huawei.com>
    ipmi_si: fix use-after-free of resource->name

Dave Martin <Dave.Martin@arm.com>
    arm64: KVM: Fix architecturally invalid reset value for FPEXC32_EL2

Will Deacon <will.deacon@arm.com>
    arm64: debug: Ensure debug handlers check triggering exception level

Julien Thierry <julien.thierry@arm.com>
    arm64: Fix HCR.TGE status for NMI contexts

Gustavo A. R. Silva <gustavo@embeddedor.com>
    ARM: s3c24xx: Fix boolean expressions in osiris_dvs_notify

Christophe Leroy <christophe.leroy@c-s.fr>
    powerpc/traps: Fix the message printed when stack overflows

Christophe Leroy <christophe.leroy@c-s.fr>
    powerpc/traps: fix recoverability of machine check handling on book3s/32

Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
    powerpc/hugetlb: Don't do runtime allocation of 16G pages in LPAR configuration

Michael Ellerman <mpe@ellerman.id.au>
    powerpc/ptrace: Simplify vr_get/set() to avoid GCC warning

Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
    powerpc: Fix 32-bit KVM-PR lockup and host crash with MacOS guest

Paul Mackerras <paulus@ozlabs.org>
    powerpc/powernv: Don't reprogram SLW image on every KVM guest entry/exit

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

Willem de Bruijn <willemb@google.com>
    bpf: only test gso type on gso packets

Tvrtko Ursulin <tvrtko.ursulin@intel.com>
    drm/i915: Relax mmap VMA check

Marc Kleine-Budde <mkl@pengutronix.de>
    can: flexcan: FLEXCAN_IFLAG_MB: add () around macro argument

Mark Walton <mark.walton@serialtek.com>
    gpio: pca953x: Fix dereference of irq data in shutdown

Loic Poulain <loic.poulain@linaro.org>
    media: i2c: ov5640: Fix post-reset delay

Sowjanya Komatineni <skomatineni@nvidia.com>
    i2c: tegra: fix maximum transfer size

QiaoChong <qiaochong@loongson.cn>
    parport_pc: fix find_superio io compare code, should use equal test.

Alexander Shishkin <alexander.shishkin@linux.intel.com>
    intel_th: Don't reference unassigned outputs

Heikki Krogerus <heikki.krogerus@linux.intel.com>
    device property: Fix the length used in PROPERTY_ENTRY_STRING()

Zev Weiss <zev@bewilderbeest.net>
    kernel/sysctl.c: add missing range check in do_proc_dointvec_minmax_conv

Jan Stancek <jstancek@redhat.com>
    mm/memory.c: do_fault: avoid usage of stale vm_area_struct

Roman Penyaev <rpenyaev@suse.de>
    mm/vmalloc: fix size check for remap_vmalloc_range_partial()

zhongjiang <zhongjiang@huawei.com>
    mm: hwpoison: fix thp split handing in soft_offline_in_use_page()

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
    IB/hfi1: Close race condition on user context disable and close

Lucas Stach <l.stach@pengutronix.de>
    PCI: dwc: skip MSI init if MSIs have been explicitly disabled

Dongdong Liu <liudongdong3@huawei.com>
    PCI/DPC: Fix print AER status in DPC event handling

Bjorn Helgaas <bhelgaas@google.com>
    PCI/ASPM: Use LTR if already enabled by platform

Jan Kara <jack@suse.cz>
    ext4: fix crash during online resizing

yangerkun <yangerkun@huawei.com>
    ext4: add mask of ext4 flags to swap

yangerkun <yangerkun@huawei.com>
    ext4: update quota information while swapping boot loader inode

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
    Btrfs: fix corruption reading shared and compressed extents after hole punching

Johannes Thumshirn <jthumshirn@suse.de>
    btrfs: ensure that a DUP or RAID1 block group has exactly two stripes

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

Samuel Holland <samuel@sholland.org>
    clocksource/drivers/arch_timer: Workaround for Allwinner A64 timer instability

Stuart Menefy <stuart.menefy@mathembedded.com>
    clocksource/drivers/exynos_mct: Clear timer interrupt when shutdown

Stuart Menefy <stuart.menefy@mathembedded.com>
    clocksource/drivers/exynos_mct: Move one-shot check from tick clear to ISR

Stuart Menefy <stuart.menefy@mathembedded.com>
    regulator: s2mpa01: Fix step values for some LDOs

Mark Zhang <markz@nvidia.com>
    regulator: max77620: Initialize values for DT properties

Krzysztof Kozlowski <krzk@kernel.org>
    regulator: s2mps11: Fix steps for buck7, buck8 and LDO35

Andy Shevchenko <andriy.shevchenko@linux.intel.com>
    spi: pxa2xx: Setup maximum supported DMA transfer length

Vignesh R <vigneshr@ti.com>
    spi: ti-qspi: Fix mmap read when more than one CS in use

Anders Roxell <anders.roxell@linaro.org>
    netfilter: ipt_CLUSTERIP: fix warning unused variable cn

Jiong Wu <lohengrin1024@gmail.com>
    mmc:fix a bug when max_discard is 0

BOUGH CHEN <haibo.chen@nxp.com>
    mmc: sdhci-esdhc-imx: fix HS400 timing issue

Andy Shevchenko <andriy.shevchenko@linux.intel.com>
    ACPI / device_sysfs: Avoid OF modalias creation for removed device

Juergen Gross <jgross@suse.com>
    xen: fix dom0 boot on huge systems

Jann Horn <jannh@google.com>
    tracing/perf: Use strndup_user() instead of buggy open-coded version

zhangyi (F) <yi.zhang@huawei.com>
    tracing: Do not free iter->trace in fail path of tracing_open_pipe()

Tom Zanussi <tom.zanussi@linux.intel.com>
    tracing: Use strncpy instead of memcpy for string keys in hist triggers

Pavel Shilovsky <piastryyy@gmail.com>
    CIFS: Fix read after write for files with read caching

Pavel Shilovsky <piastryyy@gmail.com>
    CIFS: Do not skip SMB2 message IDs on send failures

Pavel Shilovsky <piastryyy@gmail.com>
    CIFS: Do not reset lease state to NONE on lease break

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

Alexander Shishkin <alexander.shishkin@linux.intel.com>
    stm class: Prevent division by zero

Darrick J. Wong <darrick.wong@oracle.com>
    tmpfs: fix uninitialized return value in shmem_link

Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
    selftests: fib_tests: sleep after changing carrier. again.

Mao Wenan <maowenan@huawei.com>
    net: set static variable an initial value in atl2_probe()

Michael Chan <michael.chan@broadcom.com>
    bnxt_en: Wait longer for the firmware message response to complete.

Michael Chan <michael.chan@broadcom.com>
    bnxt_en: Fix typo in firmware message timeout logic.

Jiong Wang <jiong.wang@netronome.com>
    nfp: bpf: fix ALU32 high bits clearance bug

Jiong Wang <jiong.wang@netronome.com>
    nfp: bpf: fix code-gen bug on BPF_ALU | BPF_XOR | BPF_K

Vadim Lomovtsev <vlomovtsev@marvell.com>
    net: thunderx: add nicvf_send_msg_to_pf result check for set_rx_mode_task

Vadim Lomovtsev <vlomovtsev@marvell.com>
    net: thunderx: make CFG_DONE message to run through generic send-ack sequence

Alban Crequy <alban@kinvolk.io>
    bpf, lpm: fix lookup bug in map_delete_elem

Li RongQing <lirongqing@baidu.com>
    mac80211_hwsim: propagate genlmsg_reply return code

Arnd Bergmann <arnd@arndb.de>
    phonet: fix building with clang

Vineet Gupta <vgupta@synopsys.com>
    ARCv2: don't assume core 0x54 has dual issue

Vineet Gupta <vgupta@synopsys.com>
    ARCv2: support manual regfile save on interrupts

Vineet Gupta <vgupta@synopsys.com>
    ARC: uacces: remove lp_start, lp_end from clobber list

Eugeniy Paltsev <eugeniy.paltsev@synopsys.com>
    ARCv2: lib: memcpy: fix doing prefetchw outside of buffer

Jeff Kirsher <jeffrey.t.kirsher@intel.com>
    ixgbe: fix older devices that do not support IXGBE_MRQC_L3L4TXSWEN

Darrick J. Wong <darrick.wong@oracle.com>
    tmpfs: fix link accounting when a tmpfile is linked in

Michal Hocko <mhocko@suse.com>
    mm: handle lru_add_drain_all for UP properly

Russell King <rmk+kernel@armlinux.org.uk>
    net: marvell: mvneta: fix DMA debug warning

Thierry Reding <treding@nvidia.com>
    ARM: tegra: Restore DT ABI on Tegra124 Chromebooks

Vladimir Murzin <vladimir.murzin@arm.com>
    arm64: Relax GIC version check during early boot

Thomas Petazzoni <thomas.petazzoni@bootlin.com>
    ARM: dts: armada-xp: fix Armada XP boards NAND description

Michal Kalderon <michal.kalderon@marvell.com>
    qed: Fix iWARP syn packet mac address validation.

Michal Kalderon <michal.kalderon@marvell.com>
    qed: Fix iWARP buffer size provided for syn packet processing.

Bard liao <yung-chuan.liao@linux.intel.com>
    ASoC: topology: free created components in tplg load error

Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
    mailbox: bcm-flexrm-mailbox: Fix FlexRM ring flush timeout issue

Tobias Brunner <tobias@strongswan.org>
    xfrm: Fix inbound traffic via XFRM interfaces across network namespaces

Alexey Khoroshilov <khoroshilov@ispras.ru>
    net: mv643xx_eth: disable clk on error path in mv643xx_eth_shared_probe()

Beniamino Galvani <bgalvani@redhat.com>
    qmi_wwan: apply SET_DTR quirk to Sierra WP7607

Martin Blumenstingl <martin.blumenstingl@googlemail.com>
    pinctrl: meson: meson8b: fix the sdxc_a data 1..3 pins

Florian Fainelli <f.fainelli@gmail.com>
    net: dsa: bcm_sf2: Do not assume DSA master supports WoL

Florian Fainelli <f.fainelli@gmail.com>
    net: systemport: Fix reception of BPDUs

Anoob Soman <anoob.soman@citrix.com>
    scsi: libiscsi: Fix race between iscsi_xmit_task and iscsi_complete_task

David Howells <dhowells@redhat.com>
    keys: Fix dependency loop between construction record and auth key

David Howells <dhowells@redhat.com>
    assoc_array: Fix shortcut creation

Robin Murphy <robin.murphy@arm.com>
    ARM: 8835/1: dma-mapping: Clear DMA ops on teardown

Sean Tranchetti <stranche@codeaurora.org>
    af_key: unconditionally clone on broadcast

Alexei Starovoitov <ast@kernel.org>
    bpf: fix lockdep false positive in stackmap

Willem de Bruijn <willemb@google.com>
    bpf: only adjust gso_size on bytestream protocols

Dietmar Eggemann <dietmar.eggemann@arm.com>
    ARM: 8824/1: fix a migrating irq bug when hotplug cpu

Martin Willi <martin@strongswan.org>
    esp: Skip TX bytes accounting when sending from a request socket

Andre Przywara <andre.przywara@arm.com>
    clk: sunxi: A31: Fix wrong AHB gate number

Eugene Loh <eugene.loh@oracle.com>
    kallsyms: Handle too long symbols in kallsyms.c

Paul Kocialkowski <paul.kocialkowski@bootlin.com>
    clk: sunxi-ng: v3s: Fix TCON reset de-assert bit

Gabriel Fernandez <gabriel.fernandez@st.com>
    Input: st-keyscan - fix potential zalloc NULL dereference

Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
    auxdisplay: ht16k33: fix potential user-after-free on module unload

Paul Kocialkowski <paul.kocialkowski@bootlin.com>
    i2c: bcm2835: Clear current buffer pointers and counts after a transfer

Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
    i2c: cadence: Fix the hold bit setting

Huang Zijiang <huang.zijiang@zte.com.cn>
    net: hns: Fix object reference leaks in hns_dsaf_roce_reset()

Jann Horn <jannh@google.com>
    mm: page_alloc: fix ref bias in page_frag_alloc() for 1-byte allocs

Rajneesh Bhardwaj <rajneesh.bhardwaj@linux.intel.com>
    x86/CPU: Add Icelake model number

Dan Carpenter <dan.carpenter@oracle.com>
    net: dsa: bcm_sf2: potential array overflow in bcm_sf2_sw_suspend()

Bill Kuzeja <William.Kuzeja@stratus.com>
    scsi: qla2xxx: Fix panic from use after free in qla2x00_async_tm_cmd

Qian Cai <cai@lca.pw>
    Revert "mm: use early_pfn_to_nid in page_ext_init"

Yu Zhao <yuzhao@google.com>
    mm/gup: fix gup_pmd_range() for dax

Benjamin Coddington <bcodding@redhat.com>
    NFS: Don't use page_file_mapping after removing the page

Nicolas Morey-Chaisemartin <nmoreychaisemartin@suse.com>
    xprtrdma: Make sure Send CQ is allocated on an existing compvec

Yufen Yu <yuyufen@huawei.com>
    floppy: check_events callback should not return a negative number

Andrea Claudi <aclaudi@redhat.com>
    ipvs: fix dependency on nf_defrag_ipv6

Jianchao Wang <jianchao.w.wang@oracle.com>
    blk-mq: insert rq with DONTPREP to hctx dispatch list when requeue

Francesco Ruggeri <fruggeri@arista.com>
    netfilter: compat: initialize all fields in xt_init

Ilan Peer <ilan.peer@intel.com>
    mac80211: Fix Tx aggregation session tear down with ITXQs

Johannes Berg <johannes.berg@intel.com>
    mac80211: call drv_ibss_join() on restart

Dmitry Torokhov <dmitry.torokhov@gmail.com>
    Input: matrix_keypad - use flush_delayed_work()

Dmitry Torokhov <dmitry.torokhov@gmail.com>
    Input: ps2-gpio - flush TX work when closing port

Dmitry Torokhov <dmitry.torokhov@gmail.com>
    Input: cap11xx - switch to using set_brightness_blocking()

Russell King <rmk+kernel@armlinux.org.uk>
    ARM: OMAP2+: fix lack of timer interrupts on CPU1 after hotplug

Sylwester Nawrocki <s.nawrocki@samsung.com>
    ASoC: samsung: Prevent clk_get_rate() calls in atomic context

James Morse <james.morse@arm.com>
    KVM: arm64: Forbid kprobing of the VHE world-switch code

Christoffer Dall <christoffer.dall@arm.com>
    KVM: arm/arm64: vgic: Always initialize the group of private IRQs

Marc Zyngier <marc.zyngier@arm.com>
    arm/arm64: KVM: Don't panic on failure to properly reset system registers

Marc Zyngier <marc.zyngier@arm.com>
    arm/arm64: KVM: Allow a VCPU to fully reset itself

Christoffer Dall <christoffer.dall@arm.com>
    KVM: arm/arm64: Reset the VCPU without preemption and vcpu state loaded

Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
    ASoC: rsnd: fixup rsnd_ssi_master_clk_start() user count check

Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
    ASoC: dapm: fix out-of-bounds accesses to DAPM lookup tables

Yizhuo <yzhai003@ucr.edu>
    ARM: OMAP2+: Variable "reg" in function omap4_dsi_mux_pads() could be uninitialized

Tony Lindgren <tony@atomide.com>
    ARM: dts: Configure clock parent for pwm vibra

Paweł Chmiel <pawel.mikolaj.chmiel@gmail.com>
    Input: pwm-vibra - stop regulator after disabling pwm, not before

Jonathan Bakker <xc-racer2@live.ca>
    Input: pwm-vibra - prevent unbalanced regulator

Stefan Haberland <sth@linux.ibm.com>
    s390/dasd: fix using offset into zero size array error

Enric Balletbo i Serra <enric.balletbo@collabora.com>
    arm64: dts: rockchip: fix graph_port warning on rk3399 bob kevin and excavator

Julien Thierry <julien.thierry@arm.com>
    KVM: arm/arm64: vgic: Make vgic_dist->lpi_list_lock a raw_spinlock

Tony Lindgren <tony@atomide.com>
    clocksource: timer-ti-dm: Fix pwm dmtimer usage of fck reparenting

Shuming Fan <shumingf@realtek.com>
    ASoC: rt5682: Correct the setting while select ASRC clk for AD/DA filter

Steve Longerbeam <slongerbeam@gmail.com>
    gpu: ipu-v3: Fix CSI offsets for imx53

Julia Lawall <Julia.Lawall@lip6.fr>
    drm/imx: imx-ldb: add missing of_node_puts

Alexander Shiyan <shc_work@mail.ru>
    gpu: ipu-v3: Fix i.MX51 CSI control registers offset

Philipp Zabel <p.zabel@pengutronix.de>
    drm/imx: ignore plane updates on disabled crtcs

Zhang Zhijie <zhangzj@rock-chips.com>
    crypto: rockchip - update new iv to device in multiple operations

Zhang Zhijie <zhangzj@rock-chips.com>
    crypto: rockchip - fix scatterlist nents error

Eric Biggers <ebiggers@google.com>
    crypto: ahash - fix another early termination in hash walk

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

Alexander Usyskin <alexander.usyskin@intel.com>
    mei: bus: move hw module get/put to probe/release

Alexander Usyskin <alexander.usyskin@intel.com>
    mei: hbm: clean the feature flags on link reset

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

Hans Verkuil <hverkuil-cisco@xs4all.nl>
    media: videobuf2-v4l2: drop WARN_ON in vb2_warn_zero_bytesused()


-------------

Diffstat:

 Documentation/arm64/silicon-errata.txt             |   2 +
 Documentation/process/stable-kernel-rules.rst      |   3 +
 Makefile                                           |   4 +-
 arch/arc/Kconfig                                   |   8 +
 arch/arc/include/asm/arcregs.h                     |   8 +
 arch/arc/include/asm/entry-arcv2.h                 |  54 ++++++
 arch/arc/include/asm/uaccess.h                     |   8 +-
 arch/arc/kernel/entry-arcv2.S                      |   4 +-
 arch/arc/kernel/intc-arcv2.c                       |   2 +
 arch/arc/kernel/setup.c                            |  26 ++-
 arch/arc/lib/memcpy-archs.S                        |  14 --
 arch/arc/plat-hsdk/Kconfig                         |   1 +
 arch/arm/Kconfig                                   |   1 +
 arch/arm/boot/dts/armada-xp-db.dts                 |  46 ++---
 arch/arm/boot/dts/armada-xp-gp.dts                 |  13 +-
 arch/arm/boot/dts/armada-xp-lenovo-ix4-300d.dts    |  85 +++++-----
 arch/arm/boot/dts/omap4-droid4-xt894.dts           |  11 ++
 arch/arm/boot/dts/tegra124-nyan.dtsi               |  17 +-
 arch/arm/crypto/crct10dif-ce-core.S                |  14 +-
 arch/arm/crypto/crct10dif-ce-glue.c                |  23 +--
 arch/arm/include/asm/irq.h                         |   1 -
 arch/arm/include/asm/kvm_host.h                    |  10 ++
 arch/arm/kernel/irq.c                              |  62 -------
 arch/arm/kernel/smp.c                              |   2 +-
 arch/arm/kvm/coproc.c                              |   4 +-
 arch/arm/kvm/reset.c                               |  24 +++
 arch/arm/mach-omap2/cpuidle44xx.c                  |  16 +-
 arch/arm/mach-omap2/display.c                      |   7 +-
 arch/arm/mach-s3c24xx/mach-osiris-dvs.c            |   8 +-
 arch/arm/mm/dma-mapping.c                          |   2 +
 arch/arm64/boot/dts/rockchip/rk3399-gru-bob.dts    |   2 +-
 arch/arm64/boot/dts/rockchip/rk3399-gru-kevin.dts  |   2 +-
 .../dts/rockchip/rk3399-sapphire-excavator.dts     |   2 +-
 arch/arm64/crypto/aes-ce-ccm-core.S                |   5 +-
 arch/arm64/crypto/aes-ce-ccm-glue.c                |   4 +-
 arch/arm64/crypto/aes-neonbs-core.S                |   8 +-
 arch/arm64/crypto/crct10dif-ce-glue.c              |  25 +--
 arch/arm64/include/asm/hardirq.h                   |  31 ++++
 arch/arm64/include/asm/kvm_host.h                  |  11 ++
 arch/arm64/kernel/head.S                           |   3 +-
 arch/arm64/kernel/irq.c                            |   3 +
 arch/arm64/kernel/kgdb.c                           |  14 +-
 arch/arm64/kernel/probes/kprobes.c                 |   6 +
 arch/arm64/kvm/hyp/switch.c                        |   5 +
 arch/arm64/kvm/hyp/sysreg-sr.c                     |   5 +
 arch/arm64/kvm/reset.c                             |  50 +++++-
 arch/arm64/kvm/sys_regs.c                          |  10 +-
 arch/m68k/Makefile                                 |   5 +-
 arch/mips/include/asm/kvm_host.h                   |   2 +-
 arch/powerpc/include/asm/book3s/64/hugetlb.h       |   8 +
 arch/powerpc/include/asm/kvm_host.h                |   2 +-
 arch/powerpc/include/asm/powernv.h                 |   2 +
 arch/powerpc/kernel/entry_32.S                     |   9 +
 arch/powerpc/kernel/process.c                      |   2 +-
 arch/powerpc/kernel/ptrace.c                       |  10 +-
 arch/powerpc/kernel/traps.c                        |  12 +-
 arch/powerpc/platforms/83xx/suspend-asm.S          |  34 +++-
 arch/powerpc/platforms/embedded6xx/wii.c           |   4 +
 arch/powerpc/platforms/powernv/idle.c              |  27 +--
 arch/powerpc/platforms/powernv/opal-msglog.c       |   2 +-
 arch/powerpc/platforms/powernv/smp.c               |  25 +++
 arch/s390/include/asm/kvm_host.h                   |   2 +-
 arch/s390/kernel/setup.c                           |  31 +++-
 arch/x86/crypto/aegis128-aesni-glue.c              |  38 ++---
 arch/x86/crypto/aegis128l-aesni-glue.c             |  38 ++---
 arch/x86/crypto/aegis256-aesni-glue.c              |  38 ++---
 arch/x86/crypto/aesni-intel_glue.c                 |  13 +-
 arch/x86/crypto/morus1280_glue.c                   |  40 ++---
 arch/x86/crypto/morus640_glue.c                    |  39 ++---
 arch/x86/events/intel/uncore.c                     |   1 +
 arch/x86/events/intel/uncore.h                     |  12 +-
 arch/x86/events/intel/uncore_snb.c                 |   4 +-
 arch/x86/include/asm/intel-family.h                |   2 +
 arch/x86/include/asm/kvm_host.h                    |   2 +-
 arch/x86/kernel/kprobes/opt.c                      |   5 +
 arch/x86/kvm/mmu.c                                 |  23 ++-
 arch/x86/kvm/vmx.c                                 |  41 ++++-
 arch/x86/kvm/x86.c                                 |   4 +-
 arch/x86/kvm/x86.h                                 |   7 +-
 arch/x86/xen/mmu_pv.c                              |  13 +-
 block/blk-mq.c                                     |  12 +-
 crypto/aead.c                                      |   4 +-
 crypto/aegis128.c                                  |  14 +-
 crypto/aegis128l.c                                 |  14 +-
 crypto/aegis256.c                                  |  14 +-
 crypto/ahash.c                                     |  42 +++--
 crypto/cfb.c                                       |  14 +-
 crypto/morus1280.c                                 |  13 +-
 crypto/morus640.c                                  |  13 +-
 crypto/pcbc.c                                      |  14 +-
 crypto/shash.c                                     |  18 +-
 crypto/skcipher.c                                  |  27 ++-
 crypto/testmgr.c                                   |  14 +-
 crypto/testmgr.h                                   |  25 +++
 drivers/acpi/device_sysfs.c                        |   6 +-
 drivers/acpi/nfit/core.c                           |  43 ++---
 drivers/auxdisplay/ht16k33.c                       |   2 +-
 drivers/base/power/wakeup.c                        |   8 +-
 drivers/block/floppy.c                             |   2 +-
 drivers/char/ipmi/ipmi_si_intf.c                   |   5 +
 drivers/char/ipmi/ipmi_si_mem_io.c                 |   5 +-
 drivers/char/ipmi/ipmi_si_port_io.c                |   5 +-
 drivers/char/tpm/st33zp24/st33zp24.c               |   2 +-
 drivers/char/tpm/tpm-interface.c                   |  11 +-
 drivers/char/tpm/tpm_atmel.c                       |   2 +-
 drivers/char/tpm/tpm_crb.c                         |  22 ++-
 drivers/char/tpm/tpm_i2c_atmel.c                   |   6 +-
 drivers/char/tpm/tpm_i2c_infineon.c                |   2 +-
 drivers/char/tpm/tpm_i2c_nuvoton.c                 |   2 +-
 drivers/char/tpm/tpm_ibmvtpm.c                     |   8 +-
 drivers/char/tpm/tpm_infineon.c                    |   2 +-
 drivers/char/tpm/tpm_nsc.c                         |   2 +-
 drivers/char/tpm/tpm_tis_core.c                    |   2 +-
 drivers/char/tpm/tpm_vtpm_proxy.c                  |   3 +-
 drivers/char/tpm/xen-tpmfront.c                    |   2 +-
 drivers/clk/clk-twl6040.c                          |  53 +++++-
 drivers/clk/ingenic/cgu.c                          |  10 +-
 drivers/clk/ingenic/cgu.h                          |   2 +-
 drivers/clk/samsung/clk-exynos5-subcmu.c           |  13 +-
 drivers/clk/sunxi-ng/ccu-sun6i-a31.c               |   4 +-
 drivers/clk/sunxi-ng/ccu-sun8i-v3s.c               |   2 +-
 drivers/clk/uniphier/clk-uniphier-cpugear.c        |   2 +-
 drivers/clocksource/Kconfig                        |  10 ++
 drivers/clocksource/arm_arch_timer.c               |  55 ++++++
 drivers/clocksource/exynos_mct.c                   |  23 +--
 drivers/clocksource/timer-ti-dm.c                  |   4 +
 drivers/cpufreq/pxa2xx-cpufreq.c                   |   4 +-
 drivers/cpufreq/qcom-cpufreq-kryo.c                |  20 ++-
 drivers/cpufreq/tegra124-cpufreq.c                 |   2 +
 drivers/crypto/caam/caamalg.c                      |   1 +
 drivers/crypto/caam/caamhash.c                     |  93 +++-------
 drivers/crypto/ccree/cc_buffer_mgr.c               |   8 +-
 drivers/crypto/ccree/cc_cipher.c                   |   7 +-
 drivers/crypto/rockchip/rk3288_crypto.c            |   2 +-
 drivers/crypto/rockchip/rk3288_crypto.h            |   4 +-
 drivers/crypto/rockchip/rk3288_crypto_ablkcipher.c |  39 ++++-
 drivers/crypto/rockchip/rk3288_crypto_ahash.c      |   2 +-
 drivers/dma/sh/usb-dmac.c                          |   2 +
 drivers/gpio/gpio-pca953x.c                        |   3 +-
 drivers/gpu/drm/amd/display/dc/calcs/dcn_calcs.c   |   8 +-
 drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c   |   6 +-
 drivers/gpu/drm/drm_fb_helper.c                    |   4 +-
 drivers/gpu/drm/i915/i915_gem.c                    |   3 +-
 drivers/gpu/drm/imx/imx-ldb.c                      |  25 ++-
 drivers/gpu/drm/imx/ipuv3-plane.c                  |   4 +-
 drivers/gpu/drm/radeon/evergreen_cs.c              |   1 +
 drivers/gpu/ipu-v3/ipu-common.c                    |   8 +-
 drivers/hwtracing/intel_th/gth.c                   |   4 +
 drivers/hwtracing/stm/core.c                       |  11 +-
 drivers/i2c/busses/i2c-bcm2835.c                   |  12 ++
 drivers/i2c/busses/i2c-cadence.c                   |   9 +-
 drivers/i2c/busses/i2c-tegra.c                     |   2 +-
 drivers/iio/adc/exynos_adc.c                       |   2 +-
 drivers/infiniband/hw/hfi1/hfi.h                   |   2 +-
 drivers/infiniband/hw/hfi1/init.c                  |  14 +-
 drivers/input/keyboard/cap11xx.c                   |  35 ++--
 drivers/input/keyboard/matrix_keypad.c             |   2 +-
 drivers/input/keyboard/st-keyscan.c                |   4 +-
 drivers/input/misc/pwm-vibra.c                     |  19 ++-
 drivers/input/serio/ps2-gpio.c                     |   1 +
 drivers/irqchip/irq-brcmstb-l2.c                   |  10 +-
 drivers/irqchip/irq-gic-v3-its.c                   |   2 +
 drivers/mailbox/bcm-flexrm-mailbox.c               |   4 +-
 drivers/md/bcache/request.c                        |   7 +-
 drivers/md/bcache/writeback.h                      |   3 +
 drivers/md/dm-integrity.c                          |   8 +-
 drivers/md/raid10.c                                |   2 +
 drivers/md/raid5.c                                 |   2 +
 drivers/media/common/videobuf2/videobuf2-v4l2.c    |   1 -
 drivers/media/dvb-frontends/lgdt330x.c             |   2 +-
 drivers/media/i2c/ov5640.c                         |   2 +-
 drivers/media/platform/vimc/Makefile               |   3 +-
 drivers/media/platform/vimc/vimc-capture.c         |  18 +-
 drivers/media/platform/vimc/vimc-common.c          |  35 ----
 drivers/media/platform/vimc/vimc-common.h          |  15 +-
 drivers/media/platform/vimc/vimc-debayer.c         |  26 +--
 drivers/media/platform/vimc/vimc-scaler.c          |  28 +--
 drivers/media/platform/vimc/vimc-sensor.c          |  56 ++----
 drivers/media/platform/vimc/vimc-streamer.c        | 188 +++++++++++++++++++++
 drivers/media/platform/vimc/vimc-streamer.h        |  38 +++++
 drivers/media/usb/uvc/uvc_video.c                  |   8 +
 drivers/mfd/sm501.c                                |   3 +
 drivers/misc/cxl/guest.c                           |   2 +
 drivers/misc/cxl/pci.c                             |  39 ++++-
 drivers/misc/mei/bus.c                             |  21 ++-
 drivers/misc/mei/hbm.c                             |   7 +
 drivers/mmc/core/core.c                            |   4 +-
 drivers/mmc/host/sdhci-esdhc-imx.c                 |   1 +
 drivers/net/can/flexcan.c                          |   2 +-
 drivers/net/dsa/bcm_sf2.c                          |  12 +-
 drivers/net/ethernet/atheros/atlx/atl2.c           |   4 +-
 drivers/net/ethernet/broadcom/bcmsysport.c         |   4 +
 drivers/net/ethernet/broadcom/bnxt/bnxt.c          |   4 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt.h          |   2 +-
 drivers/net/ethernet/cavium/thunder/nic_main.c     |   2 +-
 drivers/net/ethernet/cavium/thunder/nicvf_main.c   |  27 ++-
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_main.c |   2 +
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c      |   7 +-
 drivers/net/ethernet/marvell/mv643xx_eth.c         |   7 +-
 drivers/net/ethernet/marvell/mvneta.c              |   2 +-
 drivers/net/ethernet/netronome/nfp/bpf/jit.c       |  17 +-
 drivers/net/ethernet/qlogic/qed/qed_iwarp.c        |  21 ++-
 drivers/net/ethernet/qlogic/qed/qed_iwarp.h        |   1 -
 drivers/net/usb/qmi_wwan.c                         |   4 +-
 drivers/net/wireless/mac80211_hwsim.c              |   2 +-
 drivers/net/wireless/marvell/libertas_tf/if_usb.c  |   2 -
 drivers/nvdimm/label.c                             |  23 ++-
 drivers/nvdimm/namespace_devs.c                    |   4 +
 drivers/nvdimm/pfn_devs.c                          |   4 +-
 drivers/parport/parport_pc.c                       |   2 +-
 drivers/pci/controller/dwc/pcie-designware-host.c  |   2 +-
 drivers/pci/pcie/dpc.c                             |  27 ++-
 drivers/pci/probe.c                                |  36 ++--
 drivers/pinctrl/meson/pinctrl-meson8b.c            |   2 +-
 drivers/power/supply/cpcap-charger.c               |   1 +
 drivers/regulator/max77620-regulator.c             |  10 +-
 drivers/regulator/s2mpa01.c                        |  10 +-
 drivers/regulator/s2mps11.c                        |   6 +-
 drivers/s390/block/dasd_eckd.c                     |   8 +
 drivers/s390/virtio/virtio_ccw.c                   |   4 +-
 drivers/scsi/aacraid/linit.c                       |  13 +-
 drivers/scsi/libiscsi.c                            |   6 +
 drivers/scsi/qla2xxx/qla_init.c                    |  17 +-
 drivers/scsi/sd.c                                  |  59 ++++++-
 drivers/scsi/virtio_scsi.c                         |   2 -
 drivers/soc/qcom/rpmh.c                            |  34 ++--
 drivers/spi/spi-pxa2xx.c                           |   1 +
 drivers/spi/spi-ti-qspi.c                          |   6 +-
 drivers/staging/media/imx/imx-ic-prpencvf.c        |  26 ++-
 drivers/staging/media/imx/imx-media-csi.c          |  42 +++--
 drivers/target/iscsi/iscsi_target.c                |   4 +-
 drivers/tty/serial/8250/8250_of.c                  |   4 +
 drivers/tty/serial/8250/8250_pci.c                 | 141 ++++++++++++++--
 drivers/tty/serial/xilinx_uartps.c                 |   8 +-
 drivers/tty/vt/vt.c                                |  15 +-
 drivers/usb/chipidea/ci_hdrc_tegra.c               |   1 +
 drivers/usb/typec/tps6598x.c                       |  26 ++-
 fs/9p/v9fs_vfs.h                                   |  23 ++-
 fs/9p/vfs_file.c                                   |   6 +-
 fs/9p/vfs_inode.c                                  |  23 ++-
 fs/9p/vfs_inode_dotl.c                             |  27 +--
 fs/9p/vfs_super.c                                  |   4 +-
 fs/btrfs/acl.c                                     |   9 +
 fs/btrfs/disk-io.c                                 |   8 +
 fs/btrfs/extent_io.c                               |   4 +-
 fs/btrfs/volumes.c                                 |   4 +-
 fs/cifs/cifsglob.h                                 |  19 +++
 fs/cifs/file.c                                     |  12 +-
 fs/cifs/smb2misc.c                                 |  17 +-
 fs/cifs/smb2ops.c                                  |  28 ++-
 fs/cifs/smb2transport.c                            |  14 +-
 fs/cifs/transport.c                                |   6 +-
 fs/devpts/inode.c                                  |   1 +
 fs/ext2/super.c                                    |  39 +++--
 fs/ext4/ext4.h                                     |   3 +
 fs/ext4/ioctl.c                                    | 100 ++++++++---
 fs/ext4/resize.c                                   |   3 +-
 fs/jbd2/transaction.c                              |  33 ++--
 fs/kernfs/mount.c                                  |   8 +-
 fs/nfs/nfs4idmap.c                                 |  31 ++--
 fs/nfs/nfs4proc.c                                  |  12 +-
 fs/nfs/pagelist.c                                  |  29 +++-
 fs/nfs/write.c                                     |  11 +-
 fs/nfsd/nfs3proc.c                                 |  16 +-
 fs/nfsd/nfs3xdr.c                                  |   1 +
 fs/nfsd/nfs4state.c                                |   8 +-
 fs/nfsd/nfsctl.c                                   |   2 +-
 fs/overlayfs/copy_up.c                             |  59 +++++--
 fs/overlayfs/overlayfs.h                           |   2 +
 fs/overlayfs/util.c                                |  55 +++---
 fs/pipe.c                                          |  14 ++
 fs/splice.c                                        |   4 +
 include/asm-generic/vmlinux.lds.h                  |   2 +-
 include/keys/request_key_auth-type.h               |  36 ++++
 include/kvm/arm_vgic.h                             |   2 +-
 include/linux/device-mapper.h                      |   2 +-
 include/linux/hardirq.h                            |   7 +
 include/linux/key-type.h                           |  22 +--
 include/linux/kvm_host.h                           |   2 +-
 include/linux/pipe_fs_i.h                          |   1 +
 include/linux/property.h                           |   2 +-
 include/linux/skbuff.h                             |   6 +
 include/net/phonet/pep.h                           |   5 +-
 init/main.c                                        |   3 +-
 kernel/bpf/lpm_trie.c                              |   1 +
 kernel/bpf/stackmap.c                              |   8 +-
 kernel/cgroup/cgroup.c                             |   9 +-
 kernel/rcu/tree.c                                  |  20 ++-
 kernel/sysctl.c                                    |  11 +-
 kernel/trace/trace.c                               |   1 -
 kernel/trace/trace_event_perf.c                    |  16 +-
 kernel/trace/trace_events_hist.c                   |   5 +-
 lib/assoc_array.c                                  |   8 +-
 mm/gup.c                                           |   3 +-
 mm/memory-failure.c                                |  14 +-
 mm/memory.c                                        |   5 +-
 mm/page_alloc.c                                    |   8 +-
 mm/page_ext.c                                      |   4 +-
 mm/shmem.c                                         |  12 +-
 mm/swap.c                                          |  17 +-
 mm/vmalloc.c                                       |   2 +-
 net/9p/client.c                                    |   2 +-
 net/core/filter.c                                  |  12 +-
 net/ipv4/esp4.c                                    |   2 +-
 net/ipv4/netfilter/ipt_CLUSTERIP.c                 |   2 +-
 net/ipv6/esp6.c                                    |   2 +-
 net/key/af_key.c                                   |  40 ++---
 net/mac80211/agg-tx.c                              |   4 +-
 net/mac80211/util.c                                |   6 +-
 net/netfilter/ipvs/Kconfig                         |   1 +
 net/netfilter/ipvs/ip_vs_core.c                    |  10 +-
 net/netfilter/ipvs/ip_vs_ctl.c                     |  10 ++
 net/netfilter/x_tables.c                           |   2 +-
 net/phonet/pep.c                                   |  32 ++--
 net/sunrpc/svcsock.c                               |  20 +--
 net/sunrpc/xprtrdma/verbs.c                        |   3 +-
 net/xfrm/xfrm_interface.c                          |   4 +-
 net/xfrm/xfrm_policy.c                             |   4 +-
 scripts/kallsyms.c                                 |   4 +-
 security/keys/internal.h                           |  13 +-
 security/keys/keyctl.c                             |   1 +
 security/keys/process_keys.c                       |   1 +
 security/keys/request_key.c                        |  72 ++++----
 security/keys/request_key_auth.c                   |  16 +-
 security/selinux/hooks.c                           |   8 +-
 sound/soc/codecs/pcm186x.c                         |   8 +-
 sound/soc/codecs/rt5682.c                          |   2 +
 sound/soc/fsl/fsl_esai.c                           |   7 +-
 sound/soc/samsung/i2s.c                            |  10 +-
 sound/soc/sh/rcar/ssi.c                            |   2 +-
 sound/soc/soc-dapm.c                               |  24 +++
 sound/soc/soc-topology.c                           |   8 +-
 tools/perf/util/auxtrace.c                         |   4 +-
 tools/perf/util/auxtrace.h                         |   3 +
 .../perf/util/intel-pt-decoder/intel-pt-decoder.c  |  37 +++-
 tools/perf/util/intel-pt.c                         |   2 +
 tools/perf/util/symbol.c                           |   2 +
 tools/testing/selftests/bpf/test_lpm_map.c         |  10 ++
 tools/testing/selftests/net/fib_tests.sh           |   1 +
 virt/kvm/arm/arm.c                                 |  10 ++
 virt/kvm/arm/mmu.c                                 |   2 +-
 virt/kvm/arm/psci.c                                |  36 ++--
 virt/kvm/arm/vgic/vgic-init.c                      |  24 ++-
 virt/kvm/arm/vgic/vgic-its.c                       |   8 +-
 virt/kvm/arm/vgic/vgic.c                           |  10 +-
 virt/kvm/kvm_main.c                                |   7 +-
 346 files changed, 3062 insertions(+), 1580 deletions(-)


