Return-Path: <SRS0=w+Kb=XL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5165CC4CECE
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 18:30:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23CE8206C2
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 18:30:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="dgCGCeR8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390400AbfIPSaY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Sep 2019 14:30:24 -0400
Received: from mout.gmx.net ([212.227.15.18]:37475 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726648AbfIPSaX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 14:30:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1568658578;
        bh=5JYExOoizKoku5K5TgA/HNnjAWp4gGtovIt70J4r0CE=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject;
        b=dgCGCeR81F8b9hOraeryyMarZeGV+JHEu9LMJQ5ulZCJ1kMCF3PEcWyQGlESpoVeN
         G6nsCv9JzTn+g7Kwa0UTBu1HfBaUftg4KqOc3IIBqTx1bi99wl7f+8+If7P0Pq1dYL
         hfi2UN/pGcmr2tH3T4dMEPedKB4nkSU/9RXK5JiE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from ls3530.fritz.box ([92.116.141.197]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MnJlW-1iZ7ZO1qBo-00jMH4; Mon, 16
 Sep 2019 20:29:38 +0200
Date:   Mon, 16 Sep 2019 20:29:32 +0200
From:   Helge Deller <deller@gmx.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        John David Anglin <dave.anglin@bell.net>
Cc:     Sven Schnelle <svens@stackframe.org>,
        Jeroen Roovers <jer@gentoo.org>,
        Jisheng Zhang <Jisheng.Zhang@synaptics.com>
Subject: [GIT PULL] parisc architecture updates for kernel v5.4
Message-ID: <20190916182932.GA8097@ls3530.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Provags-ID: V03:K1:440bKVaa1Q+3xLpUEUoFEcM5u1Bu8qPzEsOFS5a9qYSTqegTcu4
 3+uGsrPtdej3qhD8uC0MgJKpVsnx6ZwBa2fzzMKrFOJxQWY+Bg2H9TCIXx144RqvI9+n8OM
 TgT0HcFglI8raLZo+5v2K3WeIsMjzFKmwUeWBEHcjEwHhj5IOdCtgS34tdPq5eV+CX0kbtL
 UCBhBDYUF1k5VEr4TRSeg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:6LUP+KjmiZs=:B3RVywv9l2zy0I+HselXkS
 a69OURBWixa5VN0Db7QUuNo5Aqzyy4N2a2kp94kKE+kROUyQ5rCaHc2dpdVTThzGbmlc+YBz0
 Hz8dA8wTeGYxagO3wp9KXTJftTl0T+6ITA2QXxIKwn8TvT8QDWrFck3K2ZBtPSSV4Uv+LAuKl
 qyWgGA0cKeNOy7cgK7vKZnqTVGS/Twqeuzl/izVgoWRJVmLO/920yjASRhgSY5VJKX7HN1wJ5
 DRPtt9ziqHuZiU5hKuNro89SsMQtUe+WsgHtfGURHC9i8o38Vvu8FCWRxZsuHUZ91AvfPhMV6
 a6OGKhQmbW+1AhRMQVCIG/dh8HsctaMI+2hw6M78OEN3BAAe3PHRs4o6IaSyfRRllXUht8R7H
 /qkstakpkrTPGni48EUM+qke0/CrRgJULis3H+ijt3MH7SU06n4u2fKRkS8Rz2sQRsgiW0VuI
 BjvLFyLk/FEwtqu4zGkJ7wxY+ArZlort17T3B58pY9fjzJ0Hiawm4QtIeoHHJGtN2vzsJr6HP
 Uvgqu/QSsjIUiV7hof0+3aHqEDieNWEb+WXICVcToTA538gL/Ok16M7ctqnA6HiW5B98NSWes
 0t2Y/l+xhSRwKaLIxpg+FfubZqrnjubQwNMZw4540vASUbcjoTtorOpD5Xpyg90DDM9Nueu/m
 Si3UOiPGIjOAEMwHFK0AiBC0ys8zwM2toldouy1gWRIknnV/md2F+d8uHgQMSnRcXKHMMXChf
 +OUPMvpyrZxy9yvNfP4+DqT67Y2WRwjnu86f8WLv/7D3Df7tedTr7qytRpeUMhehk8h/Bebd8
 3wOs3+cu5S7HXpUKLcRQK4nG5NZ0r8vpDhfyPa++bU2YKcpgWEKAEdIJDrossJtV8ve9rlMuG
 sGG1hHM7SA7YjZKq3G2PpWSRPYPbnNGKmQnE+d0icf8RDkLiqhw9EnJ99LxF7jD116pTPhIow
 QY+kaaHZEjF+V+djASec7ukkrvH5Q3yVhobQDP0Q9wdRHIfzd6ePDxngPMxuA+fyjeN6SKnri
 J6fL/wogjiWB/Q0AxVLGtv6Zd1xzT9w3Zhxa8KX+0fl5ove0xF4Od6YcB2V4abhyDHrqAJpLl
 QpJlTT2BriCK0BuNPH1pRxCiWMCEPpHlNi/eA7/sgvduqNXgEwDhiboOSpFMVj3MeR5/PMGla
 rFpWg0hbD0fcLTY+E9mFcTmImcESyKQZuS1GMNlfO7J4ziLtlZZ0Bg+nfUexJX2UxBAbGuSJL
 x6wYqSRvEhQYVagxDS4csV6Tcj26MOEStqYPEfA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull the parisc architecture updates for kernel 5.4 from:

  git://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git parisc-5.4-1

Major changes:
* Make the powerpc implementation to read elf files available as a public
  kexec interface so it can be re-used on other architectures (Sven)
* Implement kexec on parisc (Sven)
* Add kprobes on ftrace on parisc (Sven)
* Fix kernel crash with HSC-PCI cards based on card-mode Dino
* Add assembly implementations for memset, strlen, strcpy, strncpy and strcat
* Some cleanups, documentation updates, warning fixes, ...

Thanks,
Helge

----------------------------------------------------------------
Helge Deller (8):
      parisc: Add assembly implementations for memset, strlen, strcpy, strncpy and strcat
      parisc: Add ALTERNATIVE_CODE() and ALT_COND_RUN_ON_QEMU
      parisc: speed up flush_tlb_all_local with qemu
      parisc: Avoid warning when loading hppb driver
      parisc: Convert eisa_enumerator to use pr_cont()
      parisc: Drop comments which are already in pci.h
      parisc: Save some bytes in dino driver
      parisc: Disable HP HSC-PCI Cards to prevent kernel crash

Jeroen Roovers (1):
      parisc: Have git ignore generated real2.S and firmware.c

Jisheng Zhang (1):
      kprobes/parisc: remove arch_kprobe_on_func_entry()

Sven Schnelle (15):
      parisc/ftrace: Add ARCH_SUPPORTS_FTRACE_OPS support
      parisc/ftrace: Add KPROBES_ON_FTRACE
      parisc: Update feature list
      parisc: trigger die notifier chain in parisc_terminate()
      kexec: add KEXEC_ELF
      kexec_elf: change order of elf_*_to_cpu() functions
      kexec_elf: remove parsing of section headers
      kexec_elf: remove PURGATORY_STACK_SIZE
      kexec_elf: remove Elf_Rel macro
      kexec_elf: remove unused variable in kexec_elf_load()
      kexec_elf: support 32 bit ELF files
      parisc: add __pdc_cpu_rendezvous()
      parisc: add kexec syscall support
      parisc: wire up kexec_file_load syscall
      parisc: add support for kexec_file_load() syscall

 .../features/core/jump-labels/arch-support.txt     |   2 +-
 .../debug/kprobes-on-ftrace/arch-support.txt       |   2 +-
 arch/Kconfig                                       |   3 +
 arch/parisc/Kconfig                                |  25 +
 arch/parisc/boot/compressed/.gitignore             |   2 +
 arch/parisc/include/asm/alternative.h              |  11 +-
 arch/parisc/include/asm/fixmap.h                   |   1 +
 arch/parisc/include/asm/ftrace.h                   |   1 +
 arch/parisc/include/asm/kexec.h                    |  37 ++
 arch/parisc/include/asm/pdc.h                      |   1 +
 arch/parisc/include/asm/string.h                   |  15 +
 arch/parisc/kernel/Makefile                        |   2 +
 arch/parisc/kernel/alternative.c                   |  23 +-
 arch/parisc/kernel/entry.S                         |  99 ++++
 arch/parisc/kernel/firmware.c                      |  13 +
 arch/parisc/kernel/ftrace.c                        |  64 ++-
 arch/parisc/kernel/kexec.c                         | 112 +++++
 arch/parisc/kernel/kexec_file.c                    |  86 ++++
 arch/parisc/kernel/kprobes.c                       |   4 -
 arch/parisc/kernel/pacache.S                       |   9 +
 arch/parisc/kernel/parisc_ksyms.c                  |   4 +
 arch/parisc/kernel/pci.c                           |  11 -
 arch/parisc/kernel/relocate_kernel.S               | 149 ++++++
 arch/parisc/kernel/smp.c                           |   1 +
 arch/parisc/kernel/syscalls/syscall.tbl            |   3 +-
 arch/parisc/kernel/traps.c                         |   2 +
 arch/parisc/lib/Makefile                           |   4 +-
 arch/parisc/lib/memset.c                           |  91 ----
 arch/parisc/lib/string.S                           | 136 +++++
 arch/powerpc/Kconfig                               |   1 +
 arch/powerpc/kernel/kexec_elf_64.c                 | 545 +--------------------
 drivers/parisc/dino.c                              |  30 +-
 drivers/parisc/eisa_enumerator.c                   |  10 +-
 drivers/parisc/hppb.c                              |  11 +-
 include/linux/kexec.h                              |  23 +
 include/uapi/linux/kexec.h                         |   1 +
 kernel/Makefile                                    |   1 +
 kernel/kexec_elf.c                                 | 430 ++++++++++++++++
 38 files changed, 1289 insertions(+), 676 deletions(-)
 create mode 100644 arch/parisc/include/asm/kexec.h
 create mode 100644 arch/parisc/kernel/kexec.c
 create mode 100644 arch/parisc/kernel/kexec_file.c
 create mode 100644 arch/parisc/kernel/relocate_kernel.S
 delete mode 100644 arch/parisc/lib/memset.c
 create mode 100644 arch/parisc/lib/string.S
 create mode 100644 kernel/kexec_elf.c
