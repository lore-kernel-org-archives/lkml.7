Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50B57C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 15:09:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23F11214AE
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 15:09:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726711AbfCLPJI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 11:09:08 -0400
Received: from mail-ua1-f67.google.com ([209.85.222.67]:42775 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725894AbfCLPJH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 11:09:07 -0400
Received: by mail-ua1-f67.google.com with SMTP id s26so893749uao.9
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2019 08:09:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RXSspT5YSM1WDqufKOLQ1VCjmhX5dUB0d7LeJaUuD9g=;
        b=ev2p7Efaj4OkdrOsOcN1P9zJnFpq7uinWUyK1l3CFp9Vx4KkpUoNFB0holKFOpM/iC
         dY5ZAVue4chwltEIEk7g3yiC3iw95pajX/FzswlMa5rshEbGdkB/XB3xp2CcBNYrCXkD
         8rjP6V9B71/wnHpvD2RHd8wD1zWtzcqsfLKsBNx3L2zVqSDxX3v1E9A6g1Wna7tRd/SA
         dyH//J+zUg/QDc6hiuNhcOHl+VLTpEaMvoVhLEPdXqB+Ik4jCN4uaqGTs3s6oaJszOKS
         StQ7t2ItQJF/UZQOu4wAk5jh23LNxDeHFNMGGcfxPD9cnwXOLAFnavLxFn9sosdp+jv7
         qdHg==
X-Gm-Message-State: APjAAAUNyys9K0QZIiCxa6ksxf0roFfsdWODBR8n1OsOzjGL9sDKe1Lq
        o1PwjVJtDpvh6/4xdLo0RB89w8sJ87/Gf7Vj86Q=
X-Google-Smtp-Source: APXvYqyvbRtv4dQOxqTNfo3l0PvkWELRzl6Xx7d/QJz/xUzD6fW3MmeB/Vo1UrHXky/GpxvrbImmB6QzMotQQF3Km08=
X-Received: by 2002:a9f:2f0b:: with SMTP id x11mr19027982uaj.78.1552403346891;
 Tue, 12 Mar 2019 08:09:06 -0700 (PDT)
MIME-Version: 1.0
References: <20190312144432.7668-1-andriy.shevchenko@linux.intel.com> <20190312144432.7668-4-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20190312144432.7668-4-andriy.shevchenko@linux.intel.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 12 Mar 2019 16:08:55 +0100
Message-ID: <CAMuHMdVa2n87syB+nBF7790mR_kEDc3P-w+xCbo5X9HyXxRfpA@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] auxdisplay: charlcd: Introduce charlcd_free() helper
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Miguel Ojeda Sandonis <miguel.ojeda.sandonis@gmail.com>,
        Willy Tarreau <willy@haproxy.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 12, 2019 at 3:44 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
> The charlcd_free() is a counterpart to charlcd_alloc()
> and should be called symmetrically on tear down.
>
> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
