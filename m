Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19738C004C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 18:38:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC852206BF
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 18:38:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="QjAmFuFy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727692AbfEGSif (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 14:38:35 -0400
Received: from mout.gmx.net ([212.227.17.20]:49935 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727264AbfEGSie (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 14:38:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1557254301;
        bh=2scSQ07oSeavjRdJwehx3u2dCjaIy4U1FF+d4BYK7p8=;
        h=X-UI-Sender-Class:Date:From:To:Subject;
        b=QjAmFuFy/SnMa/OU/Eh6v7arMzvqTVdcHXwguZvJhzarSMcGT+kYHY2igU0qF0TBq
         M67N/YP9oEHeyYTRHVHs6vsi7esF4G/xfgufOgS4xLXh83rUpS8yOZyLT1dMwYdVQa
         Q3xmUcccpgJBCzqzbFXaQX9+wy9claczfWdgSOsU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from ls3530.dellerweb.de ([92.116.181.99]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MZCfJ-1hAYTU18M5-00V7uT; Tue, 07
 May 2019 20:38:21 +0200
Date:   Tue, 7 May 2019 20:38:18 +0200
From:   Helge Deller <deller@gmx.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        John David Anglin <dave.anglin@bell.net>,
        Sven Schnelle <svens@stackframe.org>,
        Alexandre Ghiti <alex@ghiti.fr>,
        Mikulas Patocka <mpatocka@redhat.com>
Subject: [GIT PULL] parisc architecture updates for kernel v5.2
Message-ID: <20190507183818.GA17218@ls3530.dellerweb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Provags-ID: V03:K1:cQwO5lN27S4uuDXBk4Mkoit5YEgMCPm2E1Ws8AYuT+GI8PlbWff
 ZNPS8rWJfOkXoxjMbrqmu3pfM0aDh+DDoFSOpv4fNHIAb3EbhqFITPzWpb3XuPQiN0c0hRi
 VbQ3IojvNZzopM9MmfYBBE4jPMIbR07Rkj5rI3jVrPZmRqV0pMCTvqKinTGlOKGQ63Fw8U4
 8s3+9PgEErhq7ikEjbpoA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:anZ3IMaOLh0=:c7ghpPNAu5k7XSYpwyjSRN
 PbXbytJ/aj8p8iXUjBy2tARkK4fur3lR7RUIOeUazqygKob+u3KJzafBmAWqbJyvSmMNVkDk6
 HyKsb4eRh3ZTdBR+cwtSNhT9jK9n3QUWwBkfMu3s2y2qNoTo6aY2462trjFLKtgHvjK9qbToA
 tKT+0m8bcVTfXZe6SUiJh6fnSLIKLmj1Agp0clnX4v4cV7kc/r8+wVV9v19Z2qv50HywT+hpr
 0X49mAHLKYGiySGmPFvc0TqENY1t+s/AUQoxrjvXTIbFvHOaX4sjxeohubQsO0QQU9cPCZzlH
 jMnAF7WlAyBsytZ8Go2yAxEEJbGZZrB3CBNjmmEtmR7WjBMJTAJg/shkDwVGWEOFA5ReoVbeg
 Lb1fknqkMi67QKR/hH49YhWBzp/HHiU7/YgBJY6/dFTRQnnDGJ/QfUgdT6rgMYuZ4zP8HduKA
 KpybSxni7A3h0hfdIAN0MRUz353RMh+1Zq5I/6WClGvG1LQEGC7IsrxQlIX1nHhTW/TG8Atk3
 /41qhroyxWz9l58T6q7ZEaI57qt6MXgSHrUi+rDIPFV9JZy6S9YnWgZqtZrgdchIRzEP713Yc
 XOovfZgz4deqJOgnEHOv+iB5P653LD1L1UXnSIykGhZJPuVUH8ZzfTEHw0RYk2v6pLFdN90WE
 T6OpdA5kL5xKXMVZaX6hk5m1xL60J6WtjJAHtoHsPY0anOsdsZW5vQj+3eEhj4UqX1ZZNG5cJ
 pvTwFWCsMJHQwNfyAKws5zxvNL20xBY7Y2N/Ttk00rY6ffJ+a8o8xwiLnBt8i+cnrbKS+d0ib
 wP6cziwNKVYVP87Z0Lo+iSz/iAroQowA+rbAFDiCsghohSK4ZD3IOpaK4BdbGNQm8yMx83Sjv
 4cUZr6l5HQ3cwIuuwsNDjZG7YLoh+h/8/zQBUfXHXvaGwxKj76VNEyLm81ByQo
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull the parisc architecture updates for kernel 5.2:

  git://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git parisc-5.2-1


Many great new features, fixes and optimizations, including:

- Convert to use per-pagetable spinlocks which overall improves performance on
  SMP machines a lot, by Mikulas Patocka

- Kernel debugger (KGDB) support, by Sven Schnelle

- KPROBES support, by Sven Schnelle

- Lots of TLB lock/flush improvements, by Dave Anglin

- Drop DISCONTIGMEM and switch to SPARSEMEM

- Added JUMP_LABEL, branch runtime-patching support

- Lots of other small speedups and cleanups, e.g. for QEMU, stack
  randomization, avoidance of name clashes, documentation updates, ...


Thanks,
Helge

----------------------------------------------------------------
Alexandre Ghiti (1):
      parisc: Consider stack randomization for mmap base only when necessary

Helge Deller (11):
      parisc: Export running_on_qemu symbol for modules
      parisc: Tune LASI LAN for QEMU
      parisc: Skip registering LED when running in QEMU
      parisc: PA-Linux requires at least 32 MB RAM
      parisc: Show n/a if product number not available
      parisc: Switch from DISCONTIGMEM to SPARSEMEM
      parisc: Add memory barrier to asm pdc and sync instructions
      parisc: Allow live-patching of __meminit functions
      parisc: Rename LEVEL to PA_ASM_LEVEL to avoid name clash with DRBD code
      parisc: Use PA_ASM_LEVEL in boot code
      parisc: Add static branch and JUMP_LABEL feature

John David Anglin (4):
      parisc: Remove lock code to serialize TLB operations in pacache.S
      parisc: Use ldcw instruction for SMP spinlock release barrier
      parisc: Add memory clobber to TLB purges
      parisc: Update huge TLB page support to use per-pagetable spinlock

Mikulas Patocka (1):
      parisc: Use per-pagetable spinlock

Sven Schnelle (11):
      parisc: add set_fixmap()/clear_fixmap()
      parisc: add parisc code patching
      parisc: add KGDB support
      parisc: add functions required by KPROBE_EVENTS
      parisc: Implement kprobes
      parisc: remove kprobes.h from generic-y
      parisc: Implement kretprobes
      doc: update kprobes supported architecture list
      parisc: remove unused flags parameter in __patch_text()
      parisc: update feature lists
      parisc: enable wide mode early

 Documentation/features/debug/kgdb/arch-support.txt |   2 +-
 .../features/debug/kprobes/arch-support.txt        |   2 +-
 .../features/debug/kretprobes/arch-support.txt     |   2 +-
 Documentation/kprobes.txt                          |   1 +
 arch/parisc/Kconfig                                |  17 +-
 arch/parisc/boot/compressed/head.S                 |   6 +-
 arch/parisc/boot/compressed/misc.c                 |  31 ++-
 arch/parisc/include/asm/Kbuild                     |   1 -
 arch/parisc/include/asm/assembly.h                 |   6 +-
 arch/parisc/include/asm/cache.h                    |  10 +-
 arch/parisc/include/asm/fixmap.h                   |  19 +-
 arch/parisc/include/asm/hardware.h                 |   2 +-
 arch/parisc/include/asm/jump_label.h               |  43 +++
 arch/parisc/include/asm/kgdb.h                     |  68 +++++
 arch/parisc/include/asm/kprobes.h                  |  55 ++++
 arch/parisc/include/asm/mmzone.h                   |  58 +---
 arch/parisc/include/asm/page.h                     |   4 +-
 arch/parisc/include/asm/patch.h                    |  11 +
 arch/parisc/include/asm/pgalloc.h                  |   1 +
 arch/parisc/include/asm/pgtable.h                  |  69 +++--
 arch/parisc/include/asm/ptrace.h                   |  13 +
 arch/parisc/include/asm/sparsemem.h                |  14 +
 arch/parisc/include/asm/spinlock.h                 |   4 +
 arch/parisc/include/asm/tlbflush.h                 |  24 +-
 arch/parisc/kernel/Makefile                        |   6 +-
 arch/parisc/kernel/cache.c                         |  15 +-
 arch/parisc/kernel/drivers.c                       |  25 ++
 arch/parisc/kernel/entry.S                         |  51 ++--
 arch/parisc/kernel/head.S                          |  17 +-
 arch/parisc/kernel/inventory.c                     |   7 +
 arch/parisc/kernel/jump_label.c                    |  55 ++++
 arch/parisc/kernel/kgdb.c                          | 209 +++++++++++++++
 arch/parisc/kernel/kprobes.c                       | 291 +++++++++++++++++++++
 arch/parisc/kernel/pacache.S                       |  43 ---
 arch/parisc/kernel/parisc_ksyms.c                  |   6 -
 arch/parisc/kernel/patch.c                         |  77 ++++++
 arch/parisc/kernel/process.c                       |   1 +
 arch/parisc/kernel/processor.c                     |   3 +-
 arch/parisc/kernel/ptrace.c                        |  35 +++
 arch/parisc/kernel/setup.c                         |   6 +
 arch/parisc/kernel/sys_parisc.c                    |   3 +-
 arch/parisc/kernel/syscall.S                       |  18 +-
 arch/parisc/kernel/traps.c                         |  31 +++
 arch/parisc/kernel/vmlinux.lds.S                   |   3 +
 arch/parisc/mm/Makefile                            |   2 +-
 arch/parisc/mm/fixmap.c                            |  41 +++
 arch/parisc/mm/hugetlbpage.c                       |  19 +-
 arch/parisc/mm/init.c                              | 118 ++++-----
 drivers/net/ethernet/i825xx/lasi_82596.c           |   5 +-
 drivers/parisc/led.c                               |   3 +
 50 files changed, 1258 insertions(+), 295 deletions(-)
 create mode 100644 arch/parisc/include/asm/jump_label.h
 create mode 100644 arch/parisc/include/asm/kgdb.h
 create mode 100644 arch/parisc/include/asm/kprobes.h
 create mode 100644 arch/parisc/include/asm/patch.h
 create mode 100644 arch/parisc/include/asm/sparsemem.h
 create mode 100644 arch/parisc/kernel/jump_label.c
 create mode 100644 arch/parisc/kernel/kgdb.c
 create mode 100644 arch/parisc/kernel/kprobes.c
 create mode 100644 arch/parisc/kernel/patch.c
 create mode 100644 arch/parisc/mm/fixmap.c
