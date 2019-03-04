Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BA15C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 12:44:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0E5420815
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 12:44:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726622AbfCDMoo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 07:44:44 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:39456 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726619AbfCDMol (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 07:44:41 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x24CiX3a084488
        for <linux-kernel@vger.kernel.org>; Mon, 4 Mar 2019 07:44:40 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2r134yu1ju-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2019 07:44:40 -0500
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <schwidefsky@de.ibm.com>;
        Mon, 4 Mar 2019 12:44:38 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 4 Mar 2019 12:44:35 -0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x24CiYc228573790
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 4 Mar 2019 12:44:34 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 84CAC4C046;
        Mon,  4 Mar 2019 12:44:34 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5014D4C044;
        Mon,  4 Mar 2019 12:44:34 +0000 (GMT)
Received: from mschwideX1 (unknown [9.152.212.164])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon,  4 Mar 2019 12:44:34 +0000 (GMT)
Date:   Mon, 4 Mar 2019 13:44:33 +0100
From:   Martin Schwidefsky <schwidefsky@de.ibm.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: [GIT PULL] s390 patches for the 5.1 merge window
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
X-TM-AS-GCONF: 00
x-cbid: 19030412-0012-0000-0000-000002FE4E06
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19030412-0013-0000-0000-000021355026
Message-Id: <20190304134433.5fa966f4@mschwideX1>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-04_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1903040094
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 1c7fc5cbc33980acd13d668f1c8f0313d6ae9fd8:

  Linux 5.0-rc2 (2019-01-14 10:41:12 +1200)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux tags/s390-5.1-1

for you to fetch changes up to c533b46e552711575e6120a2ada2b5a7e2354573:

  Revert "s390/cpum_cf: Add kernel message exaplanations" (2019-03-04 08:25:00 +0100)

----------------------------------------------------------------
s390 updates for the 5.1 merge window

 - A copy of Arnds compat wrapper generation series

 - Pass information about the KVM guest to the host in form the control
   program code and the control program version code

 - Map IOV resources to support PCI physical functions on s390

 - Add vector load and store alignment hints to improve performance

 - Use the "jdd" constraint with gcc 9 to make jump labels working again

 - Remove amode workaround for old z/VM releases from the DCSS code

 - Add support for in-kernel performance measurements using the
   CPU measurement counter facility

 - Introduce a new PMU device cpum_cf_diag to capture counters and
   store thenn as event raw data.

 - Bug fixes and cleanups

----------------------------------------------------------------
Arnd Bergmann (5):
      s390: open-code s390_personality syscall
      ipc: introduce ksys_ipc()/compat_ksys_ipc() for s390
      s390: use generic UID16 implementation
      s390: autogenerate compat syscall wrappers
      s390: remove compat_wrapper.c

Christoph Hellwig (1):
      s390: remove the ptep_modify_prot_{start,commit} exports

Collin Walling (1):
      s390/setup: set control program code via diag 318

Eric Farman (2):
      s390/cio: Fix vfio-ccw handling of recursive TICs
      s390/cio: Use cpa range elsewhere within vfio-ccw

Farhan Ali (1):
      vfio-ccw: Don't assume there are more ccws after a TIC

Gerald Schaefer (4):
      s390/setup: remove obsolete #ifdef
      s390: remove dead code
      s390/extmem: remove code for 31 bit addressing mode
      s390/extmem: print DCSS range with %px

Greg Kroah-Hartman (3):
      s390/hypfs: no need to check return value of debugfs_create functions
      s390: pci: no need to check return value of debugfs_create functions
      s390: no need to check return value of debugfs_create functions

Gustavo A. R. Silva (1):
      s390/hypfs: Use struct_size() in kzalloc()

Harald Freudenberger (1):
      s390/zcrypt: use new state UNBOUND during queue driver rebind

Heiko Carstens (1):
      s390: fix system call tracing

Hendrik Brueckner (11):
      s390/cpum_cf: move counter set controls to a new header file
      s390/cpum_cf: prepare for in-kernel counter measurements
      s390/cpum_cf: rename per-CPU counter facility structure and variables
      s390/cpu_mf: move struct cpu_cf_events and per-CPU variable to header file
      s390/cpum_cf: introduce kernel_cpumcf_alert() to obtain measurement alerts
      s390/cpum_cf: Add minimal in-kernel interface for counter measurements
      s390/cpu_mf: add store cpu counter multiple instruction support
      s390/cpu_mf: replace stcctm5() with the stcctm() function
      s390/cpum_cf: introduce kernel_cpumcf_avail() function
      s390/cpum_cf: move common functions into a separate file
      s390/cpum_cf: add ctr_stcctm() function

Ilya Leoshkevich (1):
      s390/jump_label: Use "jdd" constraint on gcc9

Ingo Franzki (1):
      pkey: Indicate old mkvp only if old and current mkvp are different

Julian Wiedmann (1):
      s390/qdio: make SBAL address array type-safe

Martin Schwidefsky (10):
      Merge branch 'compat' of git://git.kernel.org/.../s390/linux into features
      s390/mmap: take stack_guard_gap into account for mmap_base
      s390: add alignment hints to vector load and store
      Merge tag 'vfio-ccw-20190204' of git://git.kernel.org/.../kvms390/vfio-ccw into features
      s390/setup: fix early warning messages
      s390/setup: fix boot crash for machine without EDAT-1
      Merge tag 'vfio-ccw-20190227' of git://git.kernel.org/.../kvms390/vfio-ccw into features
      s390/suspend: fix prefix register reset in swsusp_arch_resume
      s390/dasd: fix read device characteristic with CONFIG_VMAP_STACK=y
      Revert "s390/cpum_cf: Add kernel message exaplanations"

Pierre Morel (1):
      s390: vfio_ap: link the vfio_ap devices to the vfio_ap bus subsystem

Sebastian Ott (3):
      s390/pci: improve bar check
      s390/pci: map IOV resources
      s390/ism: ignore some errors during deregistration

Thomas Richter (3):
      s390/cpum_cf_diag: Add support for s390 counter facility diagnostic trace
      s390/cpum_cf: Add kernel message exaplanations
      s390/cpum_cf: Handle EBUSY return code from CPU counter facility reservation

Vasily Gorbik (5):
      s390/kasan: improve string/memory functions checks
      s390/als: remove duplicated in-place implementation of stfle
      s390: clean up redundant facilities list setup
      s390: allow overriding facilities via command line
      s390: warn about clearing als implied facilities

YueHaibing (1):
      s390: remove unused including <linux/version.h>

 arch/s390/Kconfig                        |   2 +
 arch/s390/boot/als.c                     |  20 +-
 arch/s390/boot/boot.h                    |   2 +
 arch/s390/boot/ipl_parm.c                |  66 ++-
 arch/s390/boot/startup.c                 |   1 +
 arch/s390/boot/string.c                  |   1 +
 arch/s390/hypfs/hypfs.h                  |   6 +-
 arch/s390/hypfs/hypfs_dbfs.c             |   8 +-
 arch/s390/hypfs/hypfs_diag.c             |   9 +-
 arch/s390/hypfs/hypfs_diag0c.c           |   6 +-
 arch/s390/hypfs/hypfs_sprp.c             |   6 +-
 arch/s390/hypfs/hypfs_vm.c               |   3 +-
 arch/s390/hypfs/inode.c                  |  11 +-
 arch/s390/include/asm/cpu_mcf.h          | 126 ++++++
 arch/s390/include/asm/cpu_mf-insn.h      |  22 +
 arch/s390/include/asm/cpu_mf.h           |  18 +-
 arch/s390/include/asm/diag.h             |  12 +
 arch/s390/include/asm/ftrace.h           |  25 ++
 arch/s390/include/asm/jump_label.h       |  14 +-
 arch/s390/include/asm/pci.h              |   1 -
 arch/s390/include/asm/perf_event.h       |   2 +-
 arch/s390/include/asm/qdio.h             |   4 +-
 arch/s390/include/asm/sclp.h             |   1 +
 arch/s390/include/asm/string.h           |  28 +-
 arch/s390/include/asm/syscall_wrapper.h  | 135 ++++++
 arch/s390/include/asm/vx-insn.h          |   8 +-
 arch/s390/include/uapi/asm/posix_types.h |   6 +
 arch/s390/kernel/Makefile                |   6 +-
 arch/s390/kernel/compat_linux.c          | 235 +----------
 arch/s390/kernel/compat_wrapper.c        | 186 ---------
 arch/s390/kernel/debug.c                 |   6 -
 arch/s390/kernel/diag.c                  |   1 +
 arch/s390/kernel/early.c                 |   2 -
 arch/s390/kernel/entry.S                 |   4 +-
 arch/s390/kernel/head64.S                |   2 -
 arch/s390/kernel/kdebugfs.c              |   2 -
 arch/s390/kernel/perf_cpum_cf.c          | 224 ++--------
 arch/s390/kernel/perf_cpum_cf_common.c   | 201 +++++++++
 arch/s390/kernel/perf_cpum_cf_diag.c     | 693 +++++++++++++++++++++++++++++++
 arch/s390/kernel/perf_cpum_cf_events.c   |   1 +
 arch/s390/kernel/setup.c                 |  60 ++-
 arch/s390/kernel/swsusp.S                |   6 +-
 arch/s390/kernel/sys_s390.c              |  16 +-
 arch/s390/kernel/syscalls/syscall.tbl    | 286 ++++++-------
 arch/s390/kernel/sysinfo.c               |   2 -
 arch/s390/kernel/vtime.c                 |   4 +-
 arch/s390/lib/string.c                   |  28 ++
 arch/s390/mm/extmem.c                    | 133 +-----
 arch/s390/mm/kasan_init.c                |   2 -
 arch/s390/mm/mmap.c                      |  33 +-
 arch/s390/mm/pgtable.c                   |   2 -
 arch/s390/pci/pci.c                      |  22 +-
 arch/s390/pci/pci_debug.c                |  15 +-
 drivers/s390/block/dasd.c                |  19 +-
 drivers/s390/char/sclp.h                 |   4 +-
 drivers/s390/char/sclp_early.c           |   2 +
 drivers/s390/cio/qdio_setup.c            |   6 +-
 drivers/s390/cio/vfio_ccw_cp.c           |  55 ++-
 drivers/s390/crypto/ap_bus.c             |  19 +-
 drivers/s390/crypto/ap_bus.h             |   3 +-
 drivers/s390/crypto/ap_queue.c           |   7 +-
 drivers/s390/crypto/pkey_api.c           |   2 +-
 drivers/s390/crypto/vfio_ap_drv.c        |  44 +-
 drivers/s390/crypto/vfio_ap_ops.c        |   4 +-
 drivers/s390/crypto/vfio_ap_private.h    |   1 +
 drivers/s390/net/ism_drv.c               |  12 +-
 drivers/s390/net/qeth_core_main.c        |   4 +-
 drivers/s390/scsi/zfcp_qdio.c            |   4 +-
 include/linux/syscalls.h                 |   4 +
 ipc/syscall.c                            |  20 +-
 kernel/sys_ni.c                          |   1 +
 71 files changed, 1846 insertions(+), 1080 deletions(-)
 create mode 100644 arch/s390/include/asm/cpu_mcf.h
 create mode 100644 arch/s390/include/asm/cpu_mf-insn.h
 create mode 100644 arch/s390/include/asm/syscall_wrapper.h
 delete mode 100644 arch/s390/kernel/compat_wrapper.c
 create mode 100644 arch/s390/kernel/perf_cpum_cf_common.c
 create mode 100644 arch/s390/kernel/perf_cpum_cf_diag.c

