Return-Path: <SRS0=7jSw=YF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0050CC47404
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Oct 2019 01:49:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3DCC2089F
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Oct 2019 01:49:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570844983;
	bh=f0wlEjG8WmkKa1cWbJ4QmjpAGM6HQDmdqEiOIOWF7Yw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=PIfutkloaCZ4fnqUshAoq4KZOF3huefnQMSVgUpnM9MdjaV4bYX/PHtSrghnfvu1I
	 rl+DBW1e78dFMx1BgIu1MYCmXmGwMMRnHI8nFkZXL4UHzHIZgu08FS3l56hQhV3BYi
	 tnYpoFfp5gErvG/T3oaBzsWutLviCsKyzR+cjrFU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728585AbfJLBtl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 21:49:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:35966 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726903AbfJLBtl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 21:49:41 -0400
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7C3DD2089F
        for <linux-kernel@vger.kernel.org>; Sat, 12 Oct 2019 01:49:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570844980;
        bh=f0wlEjG8WmkKa1cWbJ4QmjpAGM6HQDmdqEiOIOWF7Yw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=D4mC3QXVJKKptyBI8aWDcTjdO6B+FVSKx/sH9CbwCL/uuMQ5x3t0+amlOXRdWNgup
         W5FZClnw9Ni+P4IofrvkUb0FgHXOn9LRfLU5ibZ+MxK86Hb49BCBEvu6fnVGlpscnm
         2AirWR3S7/fd5ZWWQ06T9MyMZSV/qqeZivEyGVpI=
Received: by mail-wr1-f45.google.com with SMTP id q9so13715800wrm.8
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2019 18:49:40 -0700 (PDT)
X-Gm-Message-State: APjAAAXDnIlF1rGvzQzM8D/HiVXR7WWjrVVUVmqTJQe7pvp9Nsq1y3dq
        AjNHQKQIrup1b1OLr6ILdu+41q9ffd+70jm7yEc=
X-Google-Smtp-Source: APXvYqyHll70SB89q4EOs2qQE068vddRsSCQ4F7SMizVfRcf4l7lfCp6AUV3e9cSPRitbSDBAW5WqLD+Ina5urnKblg=
X-Received: by 2002:adf:ebd1:: with SMTP id v17mr7345395wrn.204.1570844978955;
 Fri, 11 Oct 2019 18:49:38 -0700 (PDT)
MIME-Version: 1.0
References: <1570762615-4256-1-git-send-email-han_mao@c-sky.com>
In-Reply-To: <1570762615-4256-1-git-send-email-han_mao@c-sky.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Sat, 12 Oct 2019 09:49:27 +0800
X-Gmail-Original-Message-ID: <CAJF2gTTqRhEMhiyTWkj32cboqJoJhte+=9MRV84Pm4w8MVyoRw@mail.gmail.com>
Message-ID: <CAJF2gTTqRhEMhiyTWkj32cboqJoJhte+=9MRV84Pm4w8MVyoRw@mail.gmail.com>
Subject: Re: [PATCH] csky: Initial stack protector support
To:     Mao Han <han_mao@c-sky.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Acked,
I need optimize commit log with:
...

    It's tested with strcpy local array overflow in sys_kill and get:
    stack-protector: Kernel stack is corrupted in: sys_kill+0x23c/0x23c

    TODO:
     - Support task switch for different cannary


On Fri, Oct 11, 2019 at 10:59 AM Mao Han <han_mao@c-sky.com> wrote:
>
> This is a basic -fstack-protector support without per-task canary
> switching. The protector will report something like when stack
> corruption is detected:
>
> stack-protector: Kernel stack is corrupted in: sys_kill+0x23c/0x23c
>
> Tested with a local array overflow in kill system call.
>
> Signed-off-by: Mao Han <han_mao@c-sky.com>
> Cc: Guo Ren <guoren@kernel.org>
> ---
>  arch/csky/Kconfig                      |  1 +
>  arch/csky/include/asm/stackprotector.h | 29 +++++++++++++++++++++++++++++
>  arch/csky/kernel/process.c             |  6 ++++++
>  3 files changed, 36 insertions(+)
>  create mode 100644 arch/csky/include/asm/stackprotector.h
>
> diff --git a/arch/csky/Kconfig b/arch/csky/Kconfig
> index 3973847..2852343 100644
> --- a/arch/csky/Kconfig
> +++ b/arch/csky/Kconfig
> @@ -48,6 +48,7 @@ config CSKY
>         select HAVE_PERF_USER_STACK_DUMP
>         select HAVE_DMA_API_DEBUG
>         select HAVE_DMA_CONTIGUOUS
> +       select HAVE_STACKPROTECTOR
>         select HAVE_SYSCALL_TRACEPOINTS
>         select MAY_HAVE_SPARSE_IRQ
>         select MODULES_USE_ELF_RELA if MODULES
> diff --git a/arch/csky/include/asm/stackprotector.h b/arch/csky/include/asm/stackprotector.h
> new file mode 100644
> index 0000000..d7cd4e5
> --- /dev/null
> +++ b/arch/csky/include/asm/stackprotector.h
> @@ -0,0 +1,29 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _ASM_STACKPROTECTOR_H
> +#define _ASM_STACKPROTECTOR_H 1
> +
> +#include <linux/random.h>
> +#include <linux/version.h>
> +
> +extern unsigned long __stack_chk_guard;
> +
> +/*
> + * Initialize the stackprotector canary value.
> + *
> + * NOTE: this must only be called from functions that never return,
> + * and it must always be inlined.
> + */
> +static __always_inline void boot_init_stack_canary(void)
> +{
> +       unsigned long canary;
> +
> +       /* Try to get a semi random initial value. */
> +       get_random_bytes(&canary, sizeof(canary));
> +       canary ^= LINUX_VERSION_CODE;
> +       canary &= CANARY_MASK;
> +
> +       current->stack_canary = canary;
> +       __stack_chk_guard = current->stack_canary;
> +}
> +
> +#endif /* __ASM_SH_STACKPROTECTOR_H */
> diff --git a/arch/csky/kernel/process.c b/arch/csky/kernel/process.c
> index f320d92..5349cd8 100644
> --- a/arch/csky/kernel/process.c
> +++ b/arch/csky/kernel/process.c
> @@ -16,6 +16,12 @@
>
>  struct cpuinfo_csky cpu_data[NR_CPUS];
>
> +#ifdef CONFIG_STACKPROTECTOR
> +#include <linux/stackprotector.h>
> +unsigned long __stack_chk_guard __read_mostly;
> +EXPORT_SYMBOL(__stack_chk_guard);
> +#endif
> +
>  asmlinkage void ret_from_fork(void);
>  asmlinkage void ret_from_kernel_thread(void);
>
> --
> 2.7.4
>


-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
