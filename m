Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 394ACC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:20:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE90921916
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:20:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553253644;
	bh=WYS0ueB0FLJlWqb4ugAeexARuDO4ptynE24gLPyI2eY=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=WJ41TGxCKS4nt9KkaIwNaC7NGlnfhZjNjd0KhJJMqLm2dIIm9PTk7OSTmoj27kyoC
	 eoOPbbfD2HvyEef6uKGn7WOZfN98qitMgGClameWhQ5trx5hSVi/Mwe9YKqATXNx4M
	 BIikoOzgBth4W7prCFvLFidqymcaYLfT5R1rCZGw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728432AbfCVLUm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 07:20:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:47030 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728414AbfCVLUj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 07:20:39 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 45DBA218A2;
        Fri, 22 Mar 2019 11:20:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553253637;
        bh=WYS0ueB0FLJlWqb4ugAeexARuDO4ptynE24gLPyI2eY=;
        h=From:To:Cc:Subject:Date:From;
        b=OzoXE4IaEL4HVQpAn8dsPhtMNSTwUhVGW+r18yMMsc6LVourErLtONidYe0+jAyYc
         Jub8LuofFUdw3qf0k9M6drTOFMcKSXp5bU6wTmONIPa9V34JetkNqgHHvnD3JOGN4N
         O4bzKjFEVmqjBJ9Iky/lMj1Ae9NpEVwjsSp4ECFk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: [PATCH 3.18 000/134] 3.18.137-stable review
Date:   Fri, 22 Mar 2019 12:13:33 +0100
Message-Id: <20190322111210.465931067@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-3.18.137-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-3.18.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 3.18.137-rc1
X-KernelTest-Deadline: 2019-03-24T11:12+00:00
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the start of the stable review cycle for the 3.18.137 release.
There are 134 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Sun Mar 24 11:10:54 UTC 2019.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v3.x/stable-review/patch-3.18.137-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-3.18.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 3.18.137-rc1

Gustavo A. R. Silva <gustavo@embeddedor.com>
    drm/radeon/evergreen_cs: fix missing break in switch statement

Sakari Ailus <sakari.ailus@linux.intel.com>
    media: uvcvideo: Avoid NULL pointer dereference at the end of streaming

Zhang, Jun <jun.zhang@intel.com>
    rcu: Do RCU GP kthread self-wakeup from softirq and interrupt

Aditya Pakki <pakki001@umn.edu>
    md: Fix failed allocation of md_register_thread

Yihao Wu <wuyihao@linux.alibaba.com>
    nfsd: fix wrong check in write_v4_end_grace()

NeilBrown <neilb@suse.com>
    nfsd: fix memory corruption caused by readdir

Gustavo A. R. Silva <gustavo@embeddedor.com>
    ARM: s3c24xx: Fix boolean expressions in osiris_dvs_notify

Christophe Leroy <christophe.leroy@c-s.fr>
    powerpc/83xx: Also save/restore SPRG4-7 during suspend

Jordan Niethe <jniethe5@gmail.com>
    powerpc/powernv: Make opal log only readable by root

Christophe Leroy <christophe.leroy@c-s.fr>
    powerpc/wii: properly disable use of BATs when requested.

Christophe Leroy <christophe.leroy@c-s.fr>
    powerpc/32: Clear on-stack exception marker upon exception return

zhangyi (F) <yi.zhang@huawei.com>
    jbd2: clear dirty flag when revoking a buffer from an older transaction

QiaoChong <qiaochong@loongson.cn>
    parport_pc: fix find_superio io compare code, should use equal test.

Zev Weiss <zev@bewilderbeest.net>
    kernel/sysctl.c: add missing range check in do_proc_dointvec_minmax_conv

Roman Penyaev <rpenyaev@suse.de>
    mm/vmalloc: fix size check for remap_vmalloc_range_partial()

Jan Kara <jack@suse.cz>
    ext2: Fix underflow in ext2_max_size()

Jan Kara <jack@suse.cz>
    ext4: fix crash during online resizing

Arnd Bergmann <arnd@arndb.de>
    cpufreq: pxa2xx: remove incorrect __init annotation

Eric Biggers <ebiggers@google.com>
    crypto: pcbc - remove bogus memcpy()s with src == dest

Filipe Manana <fdmanana@suse.com>
    Btrfs: fix corruption reading shared and compressed extents after hole punching

Finn Thain <fthain@telegraphics.com.au>
    m68k: Add -ffreestanding to CFLAGS

Bart Van Assche <bvanassche@acm.org>
    scsi: target/iscsi: Avoid iscsit_release_commands_from_conn() deadlock

Felipe Franciosi <felipe@nutanix.com>
    scsi: virtio_scsi: don't send sc payload with tmfs

Stuart Menefy <stuart.menefy@mathembedded.com>
    regulator: s2mpa01: Fix step values for some LDOs

Krzysztof Kozlowski <krzk@kernel.org>
    regulator: s2mps11: Fix steps for buck7, buck8 and LDO35

Pavel Shilovsky <piastryyy@gmail.com>
    CIFS: Fix read after write for files with read caching

Mao Wenan <maowenan@huawei.com>
    net: set static variable an initial value in atl2_probe()

Darrick J. Wong <darrick.wong@oracle.com>
    tmpfs: fix link accounting when a tmpfile is linked in

Vladimir Murzin <vladimir.murzin@arm.com>
    arm64: Relax GIC version check during early boot

Alexey Khoroshilov <khoroshilov@ispras.ru>
    net: mv643xx_eth: disable clk on error path in mv643xx_eth_shared_probe()

Florian Fainelli <f.fainelli@gmail.com>
    net: systemport: Fix reception of BPDUs

Anoob Soman <anoob.soman@citrix.com>
    scsi: libiscsi: Fix race between iscsi_xmit_task and iscsi_complete_task

David Howells <dhowells@redhat.com>
    assoc_array: Fix shortcut creation

Gabriel Fernandez <gabriel.fernandez@st.com>
    Input: st-keyscan - fix potential zalloc NULL dereference

Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
    i2c: cadence: Fix the hold bit setting

Dmitry Torokhov <dmitry.torokhov@gmail.com>
    Input: matrix_keypad - use flush_delayed_work()

Stefan Haberland <sth@linux.ibm.com>
    s390/dasd: fix using offset into zero size array error

Eric Biggers <ebiggers@google.com>
    crypto: ahash - fix another early termination in hash walk

S.j. Wang <shengjiu.wang@nxp.com>
    ASoC: fsl_esai: fix register setting issue in RIGHT_J mode

zhengbin <zhengbin13@huawei.com>
    9p/net: fix memory leak in p9_client_create

Xiao Ni <xni@redhat.com>
    It's wrong to add len to sector_nr in raid10 reshape twice

Takashi Sakamoto <o-takashi@sakamocchi.jp>
    ALSA: bebob: use more identical mod_alias for Saffire Pro 10 I/O against Liquid Saffire 56

Eric Dumazet <edumazet@google.com>
    gro_cells: make sure device is up in gro_cells_receive()

Eric Dumazet <edumazet@google.com>
    net/hsr: fix possible crash in add_timer()

Eric Dumazet <edumazet@google.com>
    vxlan: test dev->flags & IFF_UP before calling gro_cells_receive()

Al Viro <viro@zeniv.linux.org.uk>
    missing barriers in some of unix_sock ->addr and ->path accesses

Kalash Nainwal <kalash@arista.com>
    net: Set rtm_table to RT_TABLE_COMPAT for ipv6 for tables > 255

YueHaibing <yuehaibing@huawei.com>
    mdio_bus: Fix use-after-free on device_register fails

Eric Dumazet <edumazet@google.com>
    net/x25: fix a race in x25_bind()

Jack Morgenstein <jackm@dev.mellanox.co.il>
    net/mlx4_core: Fix qp mtt size calculation

Xin Long <lucien.xin@gmail.com>
    pptp: dst_release sk_dst_cache in pptp_sock_destruct

Eric Dumazet <edumazet@google.com>
    net/x25: reset state in x25_connect()

Eric Dumazet <edumazet@google.com>
    net/x25: fix use-after-free in x25_device_event()

Miaohe Lin <linmiaohe@huawei.com>
    net: sit: fix UBSAN Undefined behaviour in check_6rd

Mao Wenan <maowenan@huawei.com>
    net: hsr: fix memory leak in hsr_dev_finalize()

Eric Dumazet <edumazet@google.com>
    l2tp: fix infoleak in l2tp_ip6_recvmsg()

Gustavo A. R. Silva <gustavo@embeddedor.com>
    iscsi_ibft: Fix missing break in switch statement

Jason Gerecke <jason.gerecke@wacom.com>
    Input: wacom_serial4 - add support for Wacom ArtPad II tablet

Jiri Olsa <jolsa@redhat.com>
    perf symbols: Filter out hidden symbols from labels

Julian Wiedmann <jwi@linux.ibm.com>
    s390/qeth: fix use-after-free in error path

Andy Shevchenko <andriy.shevchenko@linux.intel.com>
    dmaengine: dmatest: Abort test in case of mapping error

Lubomir Rintel <lkundrak@v3.sk>
    irqchip/mmp: Only touch the PJ4 IRQ & FIQ bits on enable/disable

Peng Hao <peng.hao2@zte.com.cn>
    ARM: pxa: ssp: unneeded to free devm_ allocated data

Ian Kent <raven@themaw.net>
    autofs: fix error return in autofs_fill_super()

Pan Bian <bianpan2016@163.com>
    autofs: drop dentry reference only when it is never used

Michal Hocko <mhocko@suse.com>
    mm, memory_hotplug: is_mem_section_removable do not pass the end of a zone

Kairui Song <kasong@redhat.com>
    x86/kexec: Don't setup EFI info if EFI runtime is not enabled

Ronnie Sahlberg <lsahlber@redhat.com>
    cifs: fix computation for MAX_SMB2_HDR_SIZE

Sinan Kaya <okaya@kernel.org>
    platform/x86: Fix unmet dependency warning for SAMSUNG_Q10

Ming Lu <ming.lu@citrix.com>
    scsi: libfc: free skb when receiving invalid flogi resp

Yao Liu <yotta.liu@ucloud.cn>
    nfs: Fix NULL pointer dereference of dev_name

Tomonori Sakita <tomonori.sakita@sord.co.jp>
    net: altera_tse: fix msgdma_tx_completion on non-zero fill_level case

Max Filippov <jcmvbkbc@gmail.com>
    xtensa: SMP: limit number of possible CPUs by NR_CPUS

Max Filippov <jcmvbkbc@gmail.com>
    xtensa: SMP: mark each possible CPU as present

Max Filippov <jcmvbkbc@gmail.com>
    xtensa: smp_lx200_defconfig: fix vectors clash

Max Filippov <jcmvbkbc@gmail.com>
    xtensa: SMP: fix secondary CPU initialization

Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
    iommu/amd: Fix IOMMU page flush when detach device from a domain

ZhangXiaoxu <zhangxiaoxu5@huawei.com>
    ipvs: Fix signed integer overflow when setsockopt timeout

Stephane Eranian <eranian@google.com>
    perf tools: Handle TOPOLOGY headers with no CPU

Su Yanjun <suyj.fnst@cn.fujitsu.com>
    vti4: Fix a ipip packet processing bug in 'IPCOMP' virtual tunnel

Alistair Strachan <astrachan@google.com>
    media: uvcvideo: Fix 'type' check leading to overflow

Mike Kravetz <mike.kravetz@oracle.com>
    hugetlbfs: fix races and page leaks during migration

Ido Schimmel <idosch@mellanox.com>
    ip6mr: Do not call __IP6_INC_STATS() from preemptible context

Paul Moore <paul@paul-moore.com>
    netlabel: fix out-of-bounds memory accesses

Rajasingh Thavamani <T.Rajasingh@landisgyr.com>
    net: phy: Micrel KSZ8061: link failure after cable connect

Nazarov Sergey <s-nazarov@yandex.ru>
    net: avoid use IPCB in cipso_v4_error

Nazarov Sergey <s-nazarov@yandex.ru>
    net: Add __icmp_send helper.

YueHaibing <yuehaibing@huawei.com>
    net: nfc: Fix NULL dereference on nfc_llcp_build_tlv fails

Ido Schimmel <idosch@mellanox.com>
    team: Free BPF filter when unregistering netdev

Kai-Heng Feng <kai.heng.feng@canonical.com>
    sky2: Disable MSI on Dell Inspiron 1545 and Gateway P-79

YueHaibing <yuehaibing@huawei.com>
    net-sysfs: Fix mem leak in netdev_register_kobject

Ivan Mironov <mironov.ivan@gmail.com>
    USB: serial: cp210x: add ID for Ingenico 3070

Jann Horn <jannh@google.com>
    mm: enforce min addr even if capable() in expand_downwards()

Jonathan Neuschäfer <j.neuschaefer@gmx.net>
    mmc: spi: Fix card detection during probe

Vitaly Kuznetsov <vkuznets@redhat.com>
    KVM: nSVM: clear events pending from svm_complete_interrupts() when exiting to L1

Chaitanya Tata <chaitanya.tata@bluwirelesstechnology.com>
    cfg80211: extend range deviation for DMG

Balaji Pothunoori <bpothuno@codeaurora.org>
    mac80211: don't initiate TDLS connection if station is not associated to AP

Thomas Falcon <tlfalcon@linux.ibm.com>
    ibmveth: Do not process frames after calling napi_reschedule

Atsushi Nemoto <atsushi.nemoto@sord.co.jp>
    net: altera_tse: fix connect_local_phy error path

Varun Prakash <varun@chelsio.com>
    scsi: csiostor: fix NULL pointer dereference in csio_vport_set_state()

Tomonori Sakita <tomonori.sakita@sord.co.jp>
    serial: fsl_lpuart: fix maximum acceptable baud rate with over-sampling

Bob Copeland <me@bobcopeland.com>
    mac80211: fix miscounting of ttl-dropped frames

Silvio Cesare <silvio.cesare@gmail.com>
    ASoC: imx-audmux: change snprintf to scnprintf for possible overflow

Dan Carpenter <dan.carpenter@oracle.com>
    usb: gadget: Potential NULL dereference on allocation error

Zeng Tao <prime.zeng@hisilicon.com>
    usb: dwc3: gadget: Fix the uninitialized link_state when udc starts

Dan Carpenter <dan.carpenter@oracle.com>
    ALSA: compress: prevent potential divide by zero bugs

Rander Wang <rander.wang@linux.intel.com>
    ASoC: Intel: Haswell/Broadwell: fix setting for .dynamic field

Kristian H. Kristensen <hoegsberg@gmail.com>
    drm/msm: Unblock writer if reader closes file

John Garry <john.garry@huawei.com>
    scsi: libsas: Fix rphy phy_identifier for PHYs with end devices attached

Ilya Dryomov <idryomov@gmail.com>
    libceph: handle an empty authorize reply

Arad, Ronen <ronen.arad@intel.com>
    netlink: Trim skb to alloc size to avoid MSG_TRUNC

Hangbin Liu <liuhangbin@gmail.com>
    sit: check if IPv6 enabled before calling ip6_err_gen_icmpv6_unreach()

Cong Wang <xiyou.wangcong@gmail.com>
    team: avoid complex list operations in team_nl_cmd_options_set()

Kal Conley <kal.conley@dectris.com>
    net/packet: fix 4gb buffer limit due to overflow check

Eric Dumazet <edumazet@google.com>
    batman-adv: fix uninit-value in batadv_interface_tx()

Eric Biggers <ebiggers@google.com>
    KEYS: always initialize keyring_index_key::desc_len

Eric Biggers <ebiggers@google.com>
    KEYS: user: Align the payload buffer

Nathan Chancellor <natechancellor@gmail.com>
    isdn: avm: Fix string plus integer warning from Clang

Kangjie Lu <kjlu@umn.edu>
    leds: lp5523: fix a missing check of return value of lp55xx_read

Colin Ian King <colin.king@canonical.com>
    atm: he: fix sign-extension overflow on large shift

Jia-Ju Bai <baijiaju1990@gmail.com>
    isdn: i4l: isdn_tty: Fix some concurrency double-free bugs

Thomas Bogendoerfer <tbogendoerfer@suse.de>
    MIPS: jazz: fix 64bit build

Logan Gunthorpe <logang@deltatee.com>
    scsi: isci: initialize shost fully before calling scsi_add_host()

YueHaibing <yuehaibing@huawei.com>
    scsi: qla4xxx: check return code of qla4xxx_copy_from_fwddb_param

Alban Bedel <albeu@free.fr>
    MIPS: ath79: Enable OF serial ports in the default config

Kangjie Lu <kjlu@umn.edu>
    mfd: mc13xxx: Fix a missing check of a register-read failure

Charles Keepax <ckeepax@opensource.cirrus.com>
    mfd: wm5110: Add missing ASRC rate register

Dan Carpenter <dan.carpenter@oracle.com>
    mfd: ab8500-core: Return zero in get_register_interruptible()

Nathan Chancellor <natechancellor@gmail.com>
    mfd: db8500-prcmu: Fix some section annotations

Nathan Chancellor <natechancellor@gmail.com>
    mfd: twl-core: Fix section annotations on {,un}protect_pm_master

Vignesh R <vigneshr@ti.com>
    mfd: ti_am335x_tscadc: Use PLATFORM_DEVID_AUTO while registering mfd cells

Eric Biggers <ebiggers@google.com>
    KEYS: allow reaching the keys quotas exactly

Ralph Campbell <rcampbell@nvidia.com>
    numa: change get_mempolicy() to use nr_node_ids instead of MAX_NUMNODES

Yan, Zheng <zyan@redhat.com>
    ceph: avoid repeatedly adding inode to mdsc->snap_flush_list


-------------

Diffstat:

 Makefile                                           |  4 +-
 arch/arm/mach-s3c24xx/mach-osiris-dvs.c            |  8 ++--
 arch/arm/plat-pxa/ssp.c                            |  3 --
 arch/arm64/kernel/head.S                           |  3 +-
 arch/m68k/Makefile                                 |  5 ++-
 arch/mips/configs/ath79_defconfig                  |  1 +
 arch/mips/jazz/jazzdma.c                           |  5 ++-
 arch/powerpc/kernel/entry_32.S                     |  9 ++++
 arch/powerpc/platforms/83xx/suspend-asm.S          | 34 ++++++++++++---
 arch/powerpc/platforms/embedded6xx/wii.c           |  4 ++
 arch/powerpc/platforms/powernv/opal-msglog.c       |  2 +-
 arch/x86/kernel/kexec-bzimage64.c                  |  3 ++
 arch/x86/kvm/svm.c                                 |  8 ++++
 arch/xtensa/configs/smp_lx200_defconfig            |  1 +
 arch/xtensa/kernel/head.S                          |  5 ++-
 arch/xtensa/kernel/smp.c                           | 41 ++++++++++++------
 crypto/ahash.c                                     | 14 +++---
 crypto/pcbc.c                                      | 14 ++----
 drivers/atm/he.c                                   |  2 +-
 drivers/cpufreq/pxa2xx-cpufreq.c                   |  4 +-
 drivers/dma/dmatest.c                              | 28 ++++++------
 drivers/firmware/iscsi_ibft.c                      |  1 +
 drivers/gpu/drm/msm/msm_rd.c                       |  7 ++-
 drivers/gpu/drm/radeon/evergreen_cs.c              |  1 +
 drivers/i2c/busses/i2c-cadence.c                   |  9 +++-
 drivers/input/keyboard/matrix_keypad.c             |  2 +-
 drivers/input/keyboard/st-keyscan.c                |  4 +-
 drivers/input/tablet/wacom_serial4.c               |  2 +
 drivers/iommu/amd_iommu.c                          | 15 +++++--
 drivers/irqchip/irq-mmp.c                          |  6 ++-
 drivers/isdn/hardware/avm/b1.c                     |  2 +-
 drivers/isdn/i4l/isdn_tty.c                        |  6 ++-
 drivers/leds/leds-lp5523.c                         |  4 +-
 drivers/md/raid10.c                                |  3 +-
 drivers/md/raid5.c                                 |  2 +
 drivers/media/usb/uvc/uvc_driver.c                 | 14 ++++--
 drivers/media/usb/uvc/uvc_video.c                  |  8 ++++
 drivers/mfd/ab8500-core.c                          |  2 +-
 drivers/mfd/db8500-prcmu.c                         |  4 +-
 drivers/mfd/mc13xxx-core.c                         |  4 +-
 drivers/mfd/ti_am335x_tscadc.c                     |  5 ++-
 drivers/mfd/twl-core.c                             |  4 +-
 drivers/mfd/wm5110-tables.c                        |  2 +
 drivers/mmc/host/mmc_spi.c                         |  1 +
 drivers/net/ethernet/altera/altera_msgdma.c        |  3 +-
 drivers/net/ethernet/altera/altera_tse_main.c      |  4 +-
 drivers/net/ethernet/atheros/atlx/atl2.c           |  4 +-
 drivers/net/ethernet/broadcom/bcmsysport.c         |  4 ++
 drivers/net/ethernet/ibm/ibmveth.c                 |  2 -
 drivers/net/ethernet/marvell/mv643xx_eth.c         |  7 ++-
 drivers/net/ethernet/marvell/sky2.c                | 24 ++++++++++-
 .../net/ethernet/mellanox/mlx4/resource_tracker.c  |  6 +--
 drivers/net/phy/mdio_bus.c                         |  1 -
 drivers/net/phy/micrel.c                           | 14 +++++-
 drivers/net/ppp/pptp.c                             |  1 +
 drivers/net/team/team.c                            | 27 +++---------
 drivers/net/team/team_mode_loadbalance.c           | 15 +++++++
 drivers/net/vxlan.c                                | 10 +++++
 drivers/parport/parport_pc.c                       |  2 +-
 drivers/platform/x86/Kconfig                       |  1 +
 drivers/regulator/s2mpa01.c                        | 10 ++---
 drivers/regulator/s2mps11.c                        |  6 +--
 drivers/s390/block/dasd_eckd.c                     |  8 ++++
 drivers/s390/net/qeth_core_main.c                  | 15 +++----
 drivers/scsi/csiostor/csio_attr.c                  |  2 +-
 drivers/scsi/isci/init.c                           | 14 +++---
 drivers/scsi/libfc/fc_lport.c                      |  6 +--
 drivers/scsi/libiscsi.c                            |  6 +++
 drivers/scsi/libsas/sas_expander.c                 |  2 +
 drivers/scsi/qla4xxx/ql4_os.c                      |  2 +
 drivers/scsi/virtio_scsi.c                         |  2 -
 drivers/target/iscsi/iscsi_target.c                |  4 +-
 drivers/tty/serial/fsl_lpuart.c                    |  2 +-
 drivers/usb/dwc3/gadget.c                          |  1 +
 drivers/usb/gadget/function/f_sourcesink.c         |  2 +-
 drivers/usb/serial/cp210x.c                        |  1 +
 fs/autofs4/expire.c                                |  3 +-
 fs/autofs4/inode.c                                 |  4 +-
 fs/btrfs/extent_io.c                               |  4 +-
 fs/ceph/snap.c                                     |  3 +-
 fs/cifs/file.c                                     | 12 +++---
 fs/cifs/smb2pdu.h                                  |  4 +-
 fs/ext2/super.c                                    | 39 +++++++++++------
 fs/ext4/resize.c                                   |  3 +-
 fs/hugetlbfs/inode.c                               | 12 ++++++
 fs/jbd2/transaction.c                              | 17 +++++---
 fs/nfs/super.c                                     |  5 +++
 fs/nfsd/nfs3proc.c                                 | 16 ++++++-
 fs/nfsd/nfs3xdr.c                                  |  1 +
 fs/nfsd/nfsctl.c                                   |  2 +-
 include/keys/user-type.h                           |  2 +-
 include/net/gro_cells.h                            | 12 +++++-
 include/net/icmp.h                                 |  9 +++-
 include/net/ip.h                                   |  2 +
 kernel/rcu/tree.c                                  | 20 ++++++---
 kernel/sysctl.c                                    | 11 ++++-
 lib/assoc_array.c                                  |  8 ++--
 mm/hugetlb.c                                       | 14 +++++-
 mm/memory_hotplug.c                                |  3 +-
 mm/mempolicy.c                                     |  6 +--
 mm/migrate.c                                       | 11 +++++
 mm/mmap.c                                          |  7 ++-
 mm/shmem.c                                         | 10 +++--
 mm/vmalloc.c                                       |  2 +-
 net/9p/client.c                                    |  2 +-
 net/batman-adv/soft-interface.c                    |  2 +
 net/ceph/messenger.c                               | 12 ++++--
 net/core/net-sysfs.c                               |  3 ++
 net/hsr/hsr_device.c                               | 18 ++++----
 net/hsr/hsr_framereg.c                             | 12 ++++++
 net/hsr/hsr_framereg.h                             |  1 +
 net/ipv4/cipso_ipv4.c                              | 23 ++++++++--
 net/ipv4/icmp.c                                    |  7 +--
 net/ipv4/ip_options.c                              | 22 +++++++---
 net/ipv4/ip_vti.c                                  | 50 ++++++++++++++++++++++
 net/ipv6/ip6mr.c                                   |  8 ++--
 net/ipv6/route.c                                   |  2 +-
 net/ipv6/sit.c                                     |  7 +--
 net/l2tp/l2tp_ip6.c                                |  4 +-
 net/mac80211/cfg.c                                 |  4 ++
 net/mac80211/rx.c                                  |  4 +-
 net/netfilter/ipvs/ip_vs_ctl.c                     | 12 ++++++
 net/netlink/af_netlink.c                           | 34 +++++++++------
 net/nfc/llcp_commands.c                            | 20 +++++++++
 net/nfc/llcp_core.c                                | 24 +++++++++--
 net/packet/af_packet.c                             |  2 +-
 net/unix/af_unix.c                                 | 48 +++++++++++++--------
 net/unix/diag.c                                    |  3 +-
 net/wireless/reg.c                                 |  4 +-
 net/x25/af_x25.c                                   | 20 ++++++---
 security/keys/key.c                                |  4 +-
 security/keys/keyring.c                            |  4 +-
 security/keys/proc.c                               |  3 +-
 security/keys/request_key.c                        |  1 +
 security/keys/request_key_auth.c                   |  2 +-
 security/lsm_audit.c                               | 10 +++--
 sound/core/compress_offload.c                      |  3 +-
 sound/firewire/bebob/bebob.c                       | 14 +++++-
 sound/soc/fsl/fsl_esai.c                           |  7 +--
 sound/soc/fsl/imx-audmux.c                         | 24 +++++------
 sound/soc/intel/broadwell.c                        |  2 +-
 sound/soc/intel/haswell.c                          |  2 +-
 tools/perf/util/cpumap.c                           | 11 ++++-
 tools/perf/util/symbol-elf.c                       |  9 +++-
 144 files changed, 850 insertions(+), 350 deletions(-)


