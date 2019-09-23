Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 164A1C4CEC4
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 16:56:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC75920882
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 16:56:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569257761;
	bh=DU2kvNAIuhXyViG+3qbXnYW3t67qH6zaHBJaAJ37H8Q=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=f5Sd0fHRuRjZ2Un50ZIKPEGtQlMdNxYiuAxC/7GA+UpILDA8dx1XOKkuBi0FMw3Og
	 K18cbESCc1lqNrucOn9Oa4aicp+hLmJjUFITVVsOWvGwiYE40FdOQ6XcPTBM/qKMMU
	 iG/a3omQrhH/gI7Lj8BzcyYMuDQ88OxN8ULbMm1Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502149AbfIWQ4B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 12:56:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:56294 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390958AbfIWQ4A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 12:56:00 -0400
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B763D20882
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2019 16:55:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569257760;
        bh=DU2kvNAIuhXyViG+3qbXnYW3t67qH6zaHBJaAJ37H8Q=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=W9bfH39DgA7GJ61wpbNIC3KxO+72UURchqn5gujrTaavCAUDeEsPUV9uf/su4G98t
         qMmk1536yB+trjWQANtZPaq9B3DjabiuDqpJ9G1vk2HjVDkpr12NXwYTI4c3vXsmOS
         vUZUxAy4xmO8Via5KVHegiMYh0eccmCKMmeMxr1o=
Received: by mail-wm1-f43.google.com with SMTP id i16so10819410wmd.3
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2019 09:55:59 -0700 (PDT)
X-Gm-Message-State: APjAAAWpobi698bPfhkFv6/NlhAq3hfH6G6wZgQzOmiga0j8+rtrz812
        LCTJh5lBx6VJlZVyJGEzfnMcTeCTdhFN3MwQIUs=
X-Google-Smtp-Source: APXvYqynnlhLNQb+vzw7v316LJr1OcvxaOGPR0DH2hBkNnTxi30s7EaaxQQsgqus/AWzlzZEGjzocNaFzXGkZeSdMf4=
X-Received: by 2002:a1c:9dc1:: with SMTP id g184mr439636wme.77.1569257758290;
 Mon, 23 Sep 2019 09:55:58 -0700 (PDT)
MIME-Version: 1.0
References: <20190923143620.29334-1-valentin.schneider@arm.com> <20190923143620.29334-4-valentin.schneider@arm.com>
In-Reply-To: <20190923143620.29334-4-valentin.schneider@arm.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Tue, 24 Sep 2019 00:55:47 +0800
X-Gmail-Original-Message-ID: <CAJF2gTT_H3wadP1d1vrnqAXivkrew2X+ShO9nJhJMk77v_VdQw@mail.gmail.com>
Message-ID: <CAJF2gTT_H3wadP1d1vrnqAXivkrew2X+ShO9nJhJMk77v_VdQw@mail.gmail.com>
Subject: Re: [PATCH v2 3/9] csky: entry: Remove unneeded need_resched() loop
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ok, I'll put in my tree :)

On Mon, Sep 23, 2019 at 10:36 PM Valentin Schneider
<valentin.schneider@arm.com> wrote:
>
> Since the enabling and disabling of IRQs within preempt_schedule_irq()
> is contained in a need_resched() loop, we don't need the outer arch
> code loop.
>
> Acked-by: Guo Ren <guoren@kernel.org>
> Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
> ---
>  arch/csky/kernel/entry.S | 4 ----
>  1 file changed, 4 deletions(-)
>
> diff --git a/arch/csky/kernel/entry.S b/arch/csky/kernel/entry.S
> index a7e84ccccbd8..679afbcc2001 100644
> --- a/arch/csky/kernel/entry.S
> +++ b/arch/csky/kernel/entry.S
> @@ -292,11 +292,7 @@ ENTRY(csky_irq)
>         ldw     r8, (r9, TINFO_FLAGS)
>         btsti   r8, TIF_NEED_RESCHED
>         bf      2f
> -1:
>         jbsr    preempt_schedule_irq    /* irq en/disable is done inside */
> -       ldw     r7, (r9, TINFO_FLAGS)   /* get new tasks TI_FLAGS */
> -       btsti   r7, TIF_NEED_RESCHED
> -       bt      1b                      /* go again */
>  #endif
>  2:
>         jmpi    ret_from_exception
> --
> 2.22.0
>


-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
