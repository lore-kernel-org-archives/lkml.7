Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1E02C04E53
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 01:50:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A643620873
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 01:50:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726607AbfEPBuo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 21:50:44 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:35262 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726357AbfEPBnA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 21:43:00 -0400
Received: by mail-pg1-f196.google.com with SMTP id h1so713627pgs.2
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2019 18:43:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=7SwtIFTytRUIEDGWEwu6hti01P2GNQFISvzzuEXab0g=;
        b=kQ2DZgvONIgdolYC3b5sB1tVVSV7OwixWx0vCTFzfOKJ/9gYGVb5Xgbq7Goe1or94s
         ffEuR1+XNidlTudE87ImcF+lEOW7H6vHYkDmmwXBxbkgkipilEPtvw0uy2UolzuXn5uW
         OM1F522lTBd6D7xk3SK8DIlf5TBHBTXlF/y6sH44r8zIQ7t2OQAHQwjKNmYTWgh9gYyl
         u/NgeXZ8+fiTrMiGUrSU4Up/kT2BqJNaX5HldNP3TGks4ngUqcG0OcXQNqhIGjDL26j+
         N1lUJjfgaobgaYAxm6oAO6JYafDi1/EYFvNeEURlKPbIcQz9H1ngE0mYwycmnx8tCtET
         eRBA==
X-Gm-Message-State: APjAAAU5B7l6zEs7IdvaIegq5ZX0Utpj0N7BUJSs37UST9MMDvRHkAt9
        4XexBuYUAXsmfGiUIf+aUK9wig==
X-Google-Smtp-Source: APXvYqwuTsPktTTpaeES4T1KVD834+oVs1m82p0wEi8Msv0ip/VofHEk1XIvtOloFudhqitu6gsEeQ==
X-Received: by 2002:a63:465b:: with SMTP id v27mr47809999pgk.38.1557970979636;
        Wed, 15 May 2019 18:42:59 -0700 (PDT)
Received: from localhost ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id n27sm8066642pfb.129.2019.05.15.18.42.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 15 May 2019 18:42:59 -0700 (PDT)
Date:   Wed, 15 May 2019 18:42:59 -0700 (PDT)
X-Google-Original-Date: Wed, 15 May 2019 18:42:40 PDT (-0700)
Subject:     Re: [GIT PULL] RISC-V Patches for the 5.2 Merge Window, Part 1
In-Reply-To: <21598eb7-8ff0-2b6b-4cab-c0d1295fd46e@wdc.com>
CC:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@sifive.com>
To:     atish.patra@wdc.com
Message-ID: <mhng-54fad465-30c1-426c-84c1-99fd4ac827b0@palmer-si-x1e>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 May 2019 12:08:36 PDT (-0700), atish.patra@wdc.com wrote:
> On 5/15/19 10:40 AM, Palmer Dabbelt wrote:
>> The following changes since commit 085b7755808aa11f78ab9377257e1dad2e6fa4bb:
>>
>>    Linux 5.1-rc6 (2019-04-21 10:45:57 -0700)
>>
>> are available in the Git repository at:
>>
>>    git://git.kernel.org/pub/scm/linux/kernel/git/palmer/riscv-linux.git tags/riscv-for-linus-5.2-mw0
>>
>> for you to fetch changes up to e23fc917f04ffac8c156fdb4ee8b56f3867fa50b:
>>
>>    RISC-V: Avoid using invalid intermediate translations (2019-05-08 15:06:18 -0700)
>>
>> ----------------------------------------------------------------
>> RISC-V Patches for the 5.2 Merge Window, Part 1
>>
>> This patch set contains an assortment of RISC-V related patches that I'd
>> like to target for the 5.2 merge window.  Most of the patches are
>> cleanups, but there are a handful of user-visible changes:
>>
>> * The nosmp and nr_cpus command-line arguments are now supported, which
>>    work like normal.
>> * The SBI console no longer installs itself as a preferred console, we
>>    rely on standard mechanisms (/chosen, command-line, hueristics)
>>    instead.
>> * sfence_remove_sfence_vma{,_asid} now pass their arguments along to the
>>    SBI call.
>> * Modules now support BUG().
>> * A missing sfence.vma during boot has been added.  This bug only
>>    manifests during boot.
>>
>> I've only tested this on QEMU again, as I didn't have time to get things
>> running on the Unleashed.  The latest master from this morning merges in
>> cleanly and passes the tests as well.
>>
>> ----------------------------------------------------------------
>> Anup Patel (4):
>>        RISC-V: Use tabs to align macro values in asm/csr.h
>>        RISC-V: Add interrupt related SCAUSE defines in asm/csr.h
>>        RISC-V: Access CSRs using CSR numbers
>>        tty: Don't force RISCV SBI console as preferred console
>>
>> Atish Patra (4):
>>        RISC-V: Add RISC-V specific arch_match_cpu_phys_id
>>        RISC-V: Implement nosmp commandline option.
>>        RISC-V: Support nr_cpus command line option.
>>        RISC-V: Fix minor checkpatch issues.
>>
>> Christoph Hellwig (11):
>>        riscv: use asm-generic/extable.h
>>        riscv: turn mm_segment_t into a struct
>>        riscv: remove unreachable big endian code
>>        riscv: remove CONFIG_RISCV_ISA_A
>>        riscv: clear all pending interrupts when booting
>>        riscv: simplify the stack pointer setup in head.S
>>        riscv: cleanup the parse_dtb calling conventions
>>        riscv: remove unreachable !HAVE_FUNCTION_GRAPH_RET_ADDR_PTR code
>>        riscv: remove duplicate macros from ptrace.h
>>        riscv: print the unexpected interrupt cause
>>        riscv: call pm_power_off from machine_halt / machine_power_off
>>
>> Gary Guo (3):
>>        riscv: move flush_icache_{all,mm} to cacheflush.c
>>        riscv: move switch_mm to its own file
>>        riscv: fix sbi_remote_sfence_vma{,_asid}.
>>
>> Guo Ren (1):
>>        riscv/signal: Fixup additional syscall restarting
>>
>> Nick Desaulniers (1):
>>        riscv: vdso: drop unnecessary cc-ldoption
>>
>> Palmer Dabbelt (1):
>>        RISC-V: Avoid using invalid intermediate translations
>>
>> Vincent Chen (3):
>>        riscv: support trap-based WARN()
>>        riscv: Add the support for c.ebreak check in is_valid_bugaddr()
>>        riscv: Support BUG() in kernel module
>>
>>   arch/riscv/Kconfig                   |   6 +-
>>   arch/riscv/Makefile                  |   5 +-
>>   arch/riscv/include/asm/Kbuild        |   1 +
>>   arch/riscv/include/asm/bug.h         |  35 ++++++----
>>   arch/riscv/include/asm/cacheflush.h  |   2 +-
>>   arch/riscv/include/asm/csr.h         | 123 ++++++++++++++++++++++-------------
>>   arch/riscv/include/asm/elf.h         |   6 --
>>   arch/riscv/include/asm/futex.h       |  13 ----
>>   arch/riscv/include/asm/irqflags.h    |  10 +--
>>   arch/riscv/include/asm/mmu_context.h |  59 +----------------
>>   arch/riscv/include/asm/ptrace.h      |  21 ++----
>>   arch/riscv/include/asm/sbi.h         |  19 ++++--
>>   arch/riscv/include/asm/thread_info.h |   4 +-
>>   arch/riscv/include/asm/uaccess.h     |  28 +++-----
>>   arch/riscv/kernel/asm-offsets.c      |   3 -
>>   arch/riscv/kernel/cpu.c              |   3 +-
>>   arch/riscv/kernel/entry.S            |  22 +++----
>>   arch/riscv/kernel/head.S             |  33 ++++++----
>>   arch/riscv/kernel/irq.c              |  19 ++----
>>   arch/riscv/kernel/perf_event.c       |   4 +-
>>   arch/riscv/kernel/reset.c            |  15 +++--
>>   arch/riscv/kernel/setup.c            |   6 +-
>>   arch/riscv/kernel/signal.c           |   6 ++
>>   arch/riscv/kernel/smp.c              |  61 +++--------------
>>   arch/riscv/kernel/smpboot.           |   0
>>   arch/riscv/kernel/smpboot.c          |  22 ++++++-
>>   arch/riscv/kernel/stacktrace.c       |  14 ++--
>>   arch/riscv/kernel/traps.c            |  30 ++++++---
>>   arch/riscv/kernel/vdso/Makefile      |   2 +-
>>   arch/riscv/mm/Makefile               |   1 +
>>   arch/riscv/mm/cacheflush.c           |  61 +++++++++++++++++
>>   arch/riscv/mm/context.c              |  69 ++++++++++++++++++++
>>   arch/riscv/mm/fault.c                |   6 +-
>>   drivers/tty/hvc/hvc_riscv_sbi.c      |   1 -
>>   34 files changed, 390 insertions(+), 320 deletions(-)
>>   create mode 100644 arch/riscv/kernel/smpboot.
>
> I think "smpboot." got added as a typo because of commit (RISC-V:
> Support nr_cpus command line option.).
>
> Can you please update the PR directly or should I send a fixup patch?

OK.  It looks like I dropped the L2 patches, which I was going to submit as
another PR.  Since I have to do that anyway, I think it's best to just drop
this one.

Linus: I'm not sure how to tag this PR as a mistake, so I'm going to just send
another one.  If this gets merged then I'll handle the follow-on.

>
> Regards,
> Atish
>>   create mode 100644 arch/riscv/mm/context.c
>>
>> _______________________________________________
>> linux-riscv mailing list
>> linux-riscv@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-riscv
>>
