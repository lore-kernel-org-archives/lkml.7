Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0CC0C04A6B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 12:00:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B467620830
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 12:00:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726149AbfEFMAX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 08:00:23 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:50712 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725852AbfEFMAX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 08:00:23 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x46BvRsN059682
        for <linux-kernel@vger.kernel.org>; Mon, 6 May 2019 08:00:19 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2sajd1nh0u-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2019 08:00:18 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <schwidefsky@de.ibm.com>;
        Mon, 6 May 2019 13:00:15 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 6 May 2019 13:00:12 +0100
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x46C0B0e51183842
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 6 May 2019 12:00:12 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C4F794C066;
        Mon,  6 May 2019 12:00:10 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8194F4C05E;
        Mon,  6 May 2019 12:00:10 +0000 (GMT)
Received: from mschwideX1 (unknown [9.152.212.60])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon,  6 May 2019 12:00:10 +0000 (GMT)
Date:   Mon, 6 May 2019 14:00:09 +0200
From:   Martin Schwidefsky <schwidefsky@de.ibm.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: [GIT PULL] s390 patches for the 5.2 merge window
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19050612-0020-0000-0000-00000339CA79
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19050612-0021-0000-0000-0000218C5EE2
Message-Id: <20190506140009.05dbc545@mschwideX1>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-06_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905060106
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 2cc9637ce825f3a9f51f8f78af7474e9e85bfa5f:

  s390/dasd: Fix capacity calculation for large volumes (2019-03-29 07:23:44 +0100)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux s390-5.2-1

for you to fetch changes up to ce968f6012f632bbe071839d229db77c45fc38d1:

  s390/vdso: drop unnecessary cc-ldoption (2019-05-03 17:17:58 +0200)

----------------------------------------------------------------
s390 updates for the 5.2 merge window

 - Support for kernel address space layout randomization

 - Add support for kernel image signature verification

 - Convert s390 to the generic get_user_pages_fast code

 - Convert s390 to the stack unwind API analog to x86

 - Add support for CPU directed interrupts for PCI devices

 - Provide support for MIO instructions to the PCI base layer, this
   will allow the use of direct PCI mappings in user space code

 - Add the basic KVM guest ultravisor interface for protected VMs

 - Add AT_HWCAP bits for several new hardware capabilities

 - Update the CPU measurement facility counter definitions to SVN 6

 - Arnds cleanup patches for his quest to get LLVM compiles working

 - A vfio-ccw update with bug fixes and support for halt and clear

 - Improvements for the hardware TRNG code

 - Another round of cleanup for the QDIO layer

 - Numerous cleanups and bug fixes

----------------------------------------------------------------
Arnd Bergmann (12):
      s390: cio: fix cio_irb declaration
      s390: remove -fno-strength-reduce flag
      s390: don't build vdso32 with clang
      s390: syscall_wrapper: avoid clang warning
      s390: make __load_psw_mask work with clang
      s390: make chkbss work with clang
      s390: avoid __builtin_return_address(n) on clang
      s390: zcrypt: initialize variables before_use
      s390: only build for new CPUs with clang
      s390: boot, purgatory: pass $(CLANG_FLAGS) where needed
      s390: drop CONFIG_VIRT_TO_BUS
      s390: fix clang -Wpointer-sign warnigns in boot code

Cornelia Huck (6):
      vfio-ccw: make it safe to access channel programs
      vfio-ccw: rework ssch state handling
      vfio-ccw: protect the I/O region
      vfio-ccw: add capabilities chain
      s390/cio: export hsch to modules
      vfio-ccw: add handling for async channel instructions

Farhan Ali (3):
      vfio-ccw: Do not call flush_workqueue while holding the spinlock
      vfio-ccw: Release any channel program when releasing/removing vfio-ccw mdev
      vfio-ccw: Prevent quiesce function going into an infinite loop

Gerald Schaefer (8):
      s390: introduce .boot.preserved.data section
      s390/kernel: build a relocatable kernel
      s390/kernel: convert SYSCALL and PGM_CHECK handlers to .quad
      s390/kprobes: use static buffer for insn_page
      s390/sclp: do not use static sccbs
      s390/kernel: introduce .dma sections
      s390/kernel: add support for kernel address space layout randomization (KASLR)
      locking/lockdep: check for freed initmem in static_obj()

Harald Freudenberger (2):
      s390/crypto: rework generate_entropy function for pseudo random dd
      s390/crypto: use TRNG for seeding/reseeding

Joe Perches (1):
      s390: Convert IS_ENABLED uses to __is_defined

Julian Wiedmann (8):
      s390/qdio: clean up pci_out_supported()
      s390/qdio: clean up qdio_check_outbound_after_thinint()
      s390/qdio: fix output of DSCI value in debug file
      s390/qdio: pass up count of ready-to-process SBALs
      s390/qdio: simplify SBAL range calculation
      s390/qdio: eliminate queue's last_move cursor
      s390/qdio: limit direct access to first_to_check cursor
      s390/qdio: consolidate index tracking for queue scan

Martin Schwidefsky (21):
      s390/rseq: use trap4 for RSEQ_SIG
      s390: fine-tune stack switch helper
      s390/mm: make the pxd_offset functions more robust
      s390/mm: convert to the generic get_user_pages_fast code
      s390/mm: fix pxd_bad with folded page tables
      Merge tag 'vfio-ccw-20190425' of https://git.kernel.org/.../kvms390/vfio-ccw into features
      s390: report new CPU capabilities
      s390/ipl: make ipl_info less confusing
      s390/ipl: provide uapi header for list directed IPL
      s390/ipl: add definitions for the IPL report block
      s390/ipl: read IPL report at early boot
      s390/ipl: add helper functions to create an IPL report
      s390/boot: pad bzImage to 4K
      s390: add missing ENDPROC statements to assembler functions
      s390/nospec: rename assembler generated expoline thunks
      s390: use proper expoline sections for .dma code
      s390/bug: add entry size to the __bug_table section
      s390/opcodes: add missing instructions to the disassembler
      s390/unwind: introduce stack unwind API
      s390/ftrace: use HAVE_FUNCTION_GRAPH_RET_ADDR_PTR
      s390: simplify disabled_wait

Nick Desaulniers (1):
      s390/vdso: drop unnecessary cc-ldoption

Philipp Rudo (12):
      s390/zcore: Rename ipl_block to mitigate name collision
      s390/kexec_file: Fix potential segment overlap in ELF loader
      s390/kexec_file: Fix detection of text segment in ELF loader
      s390/purgatory: Reduce purgatory size
      s390/purgatory: Omit use of bin2c
      s390/kexec_file: Simplify parmarea access
      s390/kexec_file: Unify loader code
      s390/kexec_file: Load new kernel to absolute 0
      s390/kexec_file: Signature verification prototype
      s390/kexec_file: Create ipl report and pass to next kernel
      s390/kexec_file: Disable kexec_load when IPLed secure
      s390/ipl: Provide has_secure sysfs attribute

Sebastian Ott (16):
      s390/pci: mark command line parser data __initdata
      s390/pci: remove unused define
      s390/pci: move everything irq related to pci_irq.c
      s390/sclp: detect DIRQ facility
      s390/airq: recognize directed interrupts
      s390/pci: clarify interrupt vector usage
      s390/airq: provide cacheline aligned ivs
      s390/pci: provide support for CPU directed interrupts
      s390: show statistics for MSI IRQs
      s390/pci: gather statistics for floating vs directed irqs
      s390/pci: add parameter to force floating irqs
      s390/pci: move io address mapping code to pci_insn.c
      s390/ism: move oddities of device IO to wrapper function
      s390/pci: provide support for MIO instructions
      s390/pci: add parameter to disable usage of MIO instructions
      s390: enable processes for mio instructions

Thomas Huth (1):
      s390/mm: silence compiler warning when compiling without CONFIG_PGSTE

Thomas Richter (1):
      s390/cpum_cf: Add support for CPU-MF SVN 6

Thomas-Mich Richter (1):
      s390/cpum_cf_diag: Add support for CPU-MF SVN 6

Vasily Gorbik (6):
      s390: move ipl block to .boot.preserved.data section
      s390: introduce .boot.preserved.data section compile time validation
      s390/uv: introduce guest side ultravisor code
      s390/protvirt: add memory sharing for diag 308 set/store
      s390/protvirt: block kernel command line alteration
      s390/kasan: fix strncpy_from_user kasan checks

 Documentation/admin-guide/kernel-parameters.txt   |   2 +
 arch/s390/Kconfig                                 |  56 ++-
 arch/s390/Makefile                                |  10 +-
 arch/s390/boot/Makefile                           |  31 +-
 arch/s390/boot/als.c                              |   2 +-
 arch/s390/boot/boot.h                             |   5 +
 arch/s390/boot/compressed/decompressor.h          |   5 +
 arch/s390/boot/compressed/vmlinux.lds.S           |  22 +
 arch/s390/boot/head.S                             |  48 ++-
 arch/s390/boot/ipl_parm.c                         |  54 ++-
 arch/s390/boot/ipl_report.c                       | 165 ++++++++
 arch/s390/boot/kaslr.c                            | 144 +++++++
 arch/s390/boot/machine_kexec_reloc.c              |   2 +
 arch/s390/boot/startup.c                          | 121 +++++-
 arch/s390/boot/text_dma.S                         | 184 ++++++++
 arch/s390/boot/uv.c                               |  24 ++
 arch/s390/configs/debug_defconfig                 |   1 +
 arch/s390/configs/performance_defconfig           |   1 +
 arch/s390/crypto/crc32be-vx.S                     |   1 +
 arch/s390/crypto/crc32le-vx.S                     |   6 +-
 arch/s390/crypto/prng.c                           | 135 ++++--
 arch/s390/defconfig                               |   1 +
 arch/s390/hypfs/hypfs_diag0c.c                    |  18 +-
 arch/s390/include/asm/airq.h                      |  12 +-
 arch/s390/include/asm/bitops.h                    |  12 +-
 arch/s390/include/asm/boot_data.h                 |  11 +-
 arch/s390/include/asm/bug.h                       |  24 +-
 arch/s390/include/asm/diag.h                      |  13 +
 arch/s390/include/asm/ebcdic.h                    |   2 +-
 arch/s390/include/asm/elf.h                       |   4 +
 arch/s390/include/asm/extable.h                   |   5 +
 arch/s390/include/asm/ftrace.h                    |   7 +
 arch/s390/include/asm/io.h                        |  17 +-
 arch/s390/include/asm/ipl.h                       | 132 +++---
 arch/s390/include/asm/irq.h                       |   9 +-
 arch/s390/include/asm/kexec.h                     |  26 +-
 arch/s390/include/asm/linkage.h                   |   7 +
 arch/s390/include/asm/lowcore.h                   |   2 +-
 arch/s390/include/asm/nospec-insn.h               |  10 +-
 arch/s390/include/asm/pci.h                       |  12 +
 arch/s390/include/asm/pci_clp.h                   |  20 +-
 arch/s390/include/asm/pci_insn.h                  |  97 ++++-
 arch/s390/include/asm/pci_io.h                    |  49 +--
 arch/s390/include/asm/pgtable.h                   | 112 +++--
 arch/s390/include/asm/processor.h                 |  82 +---
 arch/s390/include/asm/sclp.h                      |   3 +
 arch/s390/include/asm/sections.h                  |  22 +
 arch/s390/include/asm/setup.h                     |  21 +-
 arch/s390/include/asm/stacktrace.h                | 114 +++++
 arch/s390/include/asm/syscall.h                   |   9 +-
 arch/s390/include/asm/syscall_wrapper.h           |   4 +-
 arch/s390/include/asm/uaccess.h                   |   2 +
 arch/s390/include/asm/unwind.h                    | 101 +++++
 arch/s390/include/asm/uv.h                        | 132 ++++++
 arch/s390/include/asm/vmlinux.lds.h               |  13 +
 arch/s390/include/uapi/asm/ipl.h                  | 154 +++++++
 arch/s390/kernel/Makefile                         |   7 +-
 arch/s390/kernel/asm-offsets.c                    |   1 +
 arch/s390/kernel/base.S                           |  71 +---
 arch/s390/kernel/diag.c                           |  67 +--
 arch/s390/kernel/dumpstack.c                      | 167 +++++---
 arch/s390/kernel/early.c                          |   9 +-
 arch/s390/kernel/early_nobss.c                    |   2 +-
 arch/s390/kernel/entry.S                          |  42 +-
 arch/s390/kernel/entry.h                          |   2 +-
 arch/s390/kernel/ftrace.c                         |   9 +-
 arch/s390/kernel/head64.S                         |  26 --
 arch/s390/kernel/ima_arch.c                       |  14 +
 arch/s390/kernel/ipl.c                            | 370 +++++++++++-----
 arch/s390/kernel/ipl_vmparm.c                     |   8 +-
 arch/s390/kernel/irq.c                            |  49 ++-
 arch/s390/kernel/kexec_elf.c                      |  63 ++-
 arch/s390/kernel/kexec_image.c                    |  49 +--
 arch/s390/kernel/kprobes.c                        |  37 +-
 arch/s390/kernel/machine_kexec.c                  |   8 +-
 arch/s390/kernel/machine_kexec_file.c             | 268 ++++++++----
 arch/s390/kernel/machine_kexec_reloc.c            |  53 +++
 arch/s390/kernel/mcount.S                         |  12 +-
 arch/s390/kernel/nmi.c                            |   2 +-
 arch/s390/kernel/nospec-branch.c                  |   6 +-
 arch/s390/kernel/nospec-sysfs.c                   |   2 +-
 arch/s390/kernel/perf_cpum_cf.c                   |  15 +-
 arch/s390/kernel/perf_cpum_cf_diag.c              |   9 +-
 arch/s390/kernel/perf_cpum_cf_events.c            | 107 +++--
 arch/s390/kernel/perf_event.c                     |  16 +-
 arch/s390/kernel/pgm_check.S                      |   2 +-
 arch/s390/kernel/process.c                        |   1 +
 arch/s390/kernel/processor.c                      |   3 +-
 arch/s390/kernel/reipl.S                          |   1 +
 arch/s390/kernel/relocate_kernel.S                |   4 +
 arch/s390/kernel/setup.c                          |  71 +++-
 arch/s390/kernel/smp.c                            |   3 +-
 arch/s390/kernel/stacktrace.c                     |  69 ++-
 arch/s390/kernel/swsusp.S                         |  17 +-
 arch/s390/kernel/traps.c                          |   3 +-
 arch/s390/kernel/unwind_bc.c                      | 155 +++++++
 arch/s390/kernel/vdso.c                           |  10 +-
 arch/s390/kernel/vdso32/Makefile                  |   2 +-
 arch/s390/kernel/vdso64/Makefile                  |   2 +-
 arch/s390/kernel/vmlinux.lds.S                    |  19 +
 arch/s390/kvm/interrupt.c                         |   2 +-
 arch/s390/lib/mem.S                               |   1 +
 arch/s390/mm/Makefile                             |   2 +-
 arch/s390/mm/fault.c                              |  14 +-
 arch/s390/mm/gup.c                                | 300 -------------
 arch/s390/mm/init.c                               |   3 +
 arch/s390/mm/maccess.c                            |   1 +
 arch/s390/mm/pgtable.c                            |   2 +
 arch/s390/mm/vmem.c                               |   2 +
 arch/s390/net/bpf_jit_comp.c                      |   6 +-
 arch/s390/oprofile/init.c                         |  22 +-
 arch/s390/pci/Makefile                            |   2 +-
 arch/s390/pci/pci.c                               | 366 ++++++----------
 arch/s390/pci/pci_clp.c                           |  25 +-
 arch/s390/pci/pci_insn.c                          | 169 +++++++-
 arch/s390/pci/pci_irq.c                           | 486 ++++++++++++++++++++++
 arch/s390/purgatory/Makefile                      |  20 +-
 arch/s390/purgatory/kexec-purgatory.S             |  14 +
 arch/s390/purgatory/purgatory.lds.S               |  54 +++
 arch/s390/scripts/Makefile.chkbss                 |   3 +-
 arch/s390/tools/opcodes.txt                       |  11 +
 drivers/s390/char/sclp.c                          |  14 +-
 drivers/s390/char/sclp.h                          |  10 +-
 drivers/s390/char/sclp_early.c                    |   5 +-
 drivers/s390/char/sclp_early_core.c               |  20 +-
 drivers/s390/char/sclp_sdias.c                    |  74 ++--
 drivers/s390/char/zcore.c                         |  22 +-
 drivers/s390/cio/Makefile                         |   3 +-
 drivers/s390/cio/airq.c                           |  41 +-
 drivers/s390/cio/cio.c                            |   2 +-
 drivers/s390/cio/cio.h                            |   4 +-
 drivers/s390/cio/ioasm.c                          |   1 +
 drivers/s390/cio/qdio.h                           |   6 +-
 drivers/s390/cio/qdio_debug.c                     |   9 +-
 drivers/s390/cio/qdio_main.c                      | 211 +++++-----
 drivers/s390/cio/qdio_setup.c                     |   2 +-
 drivers/s390/cio/qdio_thinint.c                   |   4 +-
 drivers/s390/cio/vfio_ccw_async.c                 |  88 ++++
 drivers/s390/cio/vfio_ccw_cp.c                    |  21 +-
 drivers/s390/cio/vfio_ccw_cp.h                    |   2 +
 drivers/s390/cio/vfio_ccw_drv.c                   |  81 ++--
 drivers/s390/cio/vfio_ccw_fsm.c                   | 143 ++++++-
 drivers/s390/cio/vfio_ccw_ops.c                   | 227 ++++++++--
 drivers/s390/cio/vfio_ccw_private.h               |  48 ++-
 drivers/s390/crypto/ap_bus.c                      |   4 +-
 drivers/s390/crypto/zcrypt_api.c                  |   4 +
 drivers/s390/net/ism.h                            |  29 +-
 drivers/s390/net/ism_drv.c                        |  20 +-
 drivers/s390/virtio/virtio_ccw.c                  |   2 +-
 include/asm-generic/sections.h                    |  14 +
 include/linux/ima.h                               |   2 +-
 include/uapi/linux/vfio.h                         |   4 +
 include/uapi/linux/vfio_ccw.h                     |  12 +
 kernel/locking/lockdep.c                          |   3 +
 kernel/panic.c                                    |   7 +-
 security/integrity/Kconfig                        |  11 +-
 security/integrity/Makefile                       |   8 +-
 security/integrity/platform_certs/load_ipl_s390.c |  36 ++
 tools/testing/selftests/rseq/rseq-s390.h          |   9 +-
 159 files changed, 4904 insertions(+), 1935 deletions(-)
 create mode 100644 arch/s390/boot/ipl_report.c
 create mode 100644 arch/s390/boot/kaslr.c
 create mode 100644 arch/s390/boot/machine_kexec_reloc.c
 create mode 100644 arch/s390/boot/text_dma.S
 create mode 100644 arch/s390/boot/uv.c
 create mode 100644 arch/s390/include/asm/stacktrace.h
 create mode 100644 arch/s390/include/asm/unwind.h
 create mode 100644 arch/s390/include/asm/uv.h
 create mode 100644 arch/s390/include/uapi/asm/ipl.h
 create mode 100644 arch/s390/kernel/ima_arch.c
 create mode 100644 arch/s390/kernel/machine_kexec_reloc.c
 create mode 100644 arch/s390/kernel/unwind_bc.c
 delete mode 100644 arch/s390/mm/gup.c
 create mode 100644 arch/s390/pci/pci_irq.c
 create mode 100644 arch/s390/purgatory/kexec-purgatory.S
 create mode 100644 arch/s390/purgatory/purgatory.lds.S
 create mode 100644 drivers/s390/cio/vfio_ccw_async.c
 create mode 100644 security/integrity/platform_certs/load_ipl_s390.c

