Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB1BAC04AB1
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 06:22:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5F0420B7C
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 06:22:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727423AbfEMGU5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 02:20:57 -0400
Received: from mail-vs1-f67.google.com ([209.85.217.67]:41939 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726103AbfEMGU5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 02:20:57 -0400
Received: by mail-vs1-f67.google.com with SMTP id g187so7282950vsc.8
        for <linux-kernel@vger.kernel.org>; Sun, 12 May 2019 23:20:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4z6TOqQd7xpUAzupjuOesaFbYODxlU8r51j/bIYSpok=;
        b=i/erGbTiypY9Jxo86cxUspcGbmjvHyOr5dlmP34yUWoHzvp7fQAbyb+bBxs5f7lOj+
         z3c1p/RwZs3+4CuqD2h548zVPWHvqWZfH1yOWmNzqHTqB3dsGhLhZmUfMyWgwYJW8rrh
         wl1Ottko77Ik6Zh+1Cd9zPJuMaaEBfcL0uGgqBRl5Jq7BVW1+e/smshRZW785CZNK/kz
         FQOYdT6Iydb/rWGGB+iOtkQQST2Y4rlXFuOVry50MrBD1EC7rCTLKj8EcdFYgLDAfagP
         3PyEp3A3MBtcruWz34DeJmzQTHlsLjzHCgCGV2qkYwmCvW2CAWM6SDsFzR8A2xz8J3UG
         HYYg==
X-Gm-Message-State: APjAAAV4K0us3/oVyt/6o1T6w1S26Qs7GF3+58u5C2jqJ3lMExS2CpxW
        2gE7CMCBwkB0uIZIuHLLPyUFtF7JHh8Hl8n1yQA=
X-Google-Smtp-Source: APXvYqxIAjBs3bKYcwXUWTPBFDzX+ggIz6zeo1JRjSWp3eQ1BVWFfT1xGSTKey2SXbg2CaCuuovHzHUjRzlkEAHRzZ8=
X-Received: by 2002:a67:7c93:: with SMTP id x141mr5085007vsc.96.1557728456522;
 Sun, 12 May 2019 23:20:56 -0700 (PDT)
MIME-Version: 1.0
References: <20190512114105.41792-1-yuehaibing@huawei.com>
In-Reply-To: <20190512114105.41792-1-yuehaibing@huawei.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 13 May 2019 08:20:45 +0200
Message-ID: <CAMuHMdVEEuvNLQeMGuuK9vp+w8AA2dHe8UnJ1XfPzUFarLQdTA@mail.gmail.com>
Subject: Re: [PATCH] ARM: mm: remove unused variables
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     Russell King <linux@armlinux.org.uk>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Kees Cook <keescook@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 12, 2019 at 1:48 PM YueHaibing <yuehaibing@huawei.com> wrote:
> Fix gcc warnings:
>
> arch/arm/mm/init.c: In function 'mem_init':
> arch/arm/mm/init.c:456:13: warning: unused variable 'itcm_end' [-Wunused-variable]
>   extern u32 itcm_end;
>              ^
> arch/arm/mm/init.c:455:13: warning: unused variable 'dtcm_end' [-Wunused-variable]
>   extern u32 dtcm_end;
>              ^
>
> They are not used any more since
> commit 1c31d4e96b8c ("ARM: 8820/1: mm: Stop printing the virtual memory layout")

Thanks! Sorry for missing that.

> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
