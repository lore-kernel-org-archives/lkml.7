Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9798EC43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 18:10:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70A9F206C3
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 18:10:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727012AbfKKSKr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 13:10:47 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:34660 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726763AbfKKSKr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 13:10:47 -0500
Received: by mail-oi1-f195.google.com with SMTP id l202so12318172oig.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2019 10:10:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=U0dm5D6eillHbo+SYeBB7f0hErK0a+Kk33c8eTHG8H4=;
        b=uBlfCgXqo7AHGAgUEqHHHg8XNyocTzO00ikzLes8lxILlAohEc7WBWYNwBmgyDB16n
         GMnGGZ1u7pjJHra3S+s+3Z3p04cMAv9MAr2Wu4/d3yRziyv+eaMsRgMaDf8pEP4Fyp5+
         atTY3cUvR8Pc5qUuvO0aQ5jNN5jQJt0PDvwPCh7GP+wIDNw+h8O7Go3AwDfQ8430L/2w
         87SDrUwSwVFO7xIU5ktQ/rsFiNbnbtpCGdGuL1pJACWV1XjTZw+j9MoSYv72ewztdVNA
         7zXSJdjUaWMfZRncQjt+f343vB5c3GRAOHiYha0cdm5KlXIc2i5Qt9RnQMGdTivGiMOd
         eMdA==
X-Gm-Message-State: APjAAAXzZNO23iYqvBtrZjHqPi7HlrmCVGZWnEeeM2T3mErCZfnvezaU
        FRXs/3nz819hzHYgX8eNuQPLMOIw3ikppUBSII+giQ==
X-Google-Smtp-Source: APXvYqy5+K5Ca70nfdLzLpsHL1LP47SJMH7uBNWJHVoxDJt89nuKEY13OiKJzKEWbKRlo+wgCcXId9NnMQPQFowaWfc=
X-Received: by 2002:aca:882:: with SMTP id 124mr284378oii.54.1573495843776;
 Mon, 11 Nov 2019 10:10:43 -0800 (PST)
MIME-Version: 1.0
References: <201911110920.5840E9AF1@keescook>
In-Reply-To: <201911110920.5840E9AF1@keescook>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 11 Nov 2019 19:10:32 +0100
Message-ID: <CAMuHMdX_EM0e=fN6udZsPfa-YGX7KkNEgCQtdC0M51LGmWOxzA@mail.gmail.com>
Subject: Re: [PATCH] m68k: Convert missed RODATA to RO_DATA
To:     Kees Cook <keescook@chromium.org>
Cc:     Borislav Petkov <bp@suse.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 11, 2019 at 6:22 PM Kees Cook <keescook@chromium.org> wrote:
> I missed two instances of the old RODATA macro (seems I was searching
> for vmlinux.lds* not vmlinux*lds*). Fix both instances and double-check
> the entire tree for other "RODATA" instances in linker scripts.
>
> Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Fixes: c82318254d15 ("vmlinux.lds.h: Replace RODATA with RO_DATA")
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  arch/m68k/kernel/vmlinux-std.lds  | 2 +-
>  arch/m68k/kernel/vmlinux-sun3.lds | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
