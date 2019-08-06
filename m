Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1D1DC31E40
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 07:18:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 935782147A
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 07:18:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732102AbfHFHSt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 03:18:49 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:44034 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731807AbfHFHSt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 03:18:49 -0400
Received: by mail-oi1-f193.google.com with SMTP id e189so64979738oib.11
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2019 00:18:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RCMaRU9I37uLcxKjbqn1cVlK7lGMUQpE7VaAEHhYNjY=;
        b=i7qblEpR4iFg4fIhtT/W0nXMjsvn80t7KwQB18fIn4tLz5IekpWhsgbsZmdCRskthe
         qOL5R9SiK+UlOUlVW5+XZ59bKhjsfFcQdl0D+mzuaiHBDu4Zin5V638z6X1AQDwycnLP
         CiaK+Qp4DK1ofZRywrTH8EwnotdRwjGKcOsD5gViZbZA+K8jvhWuKcq/pK7RB+KrmVJN
         gjeZDKQ6wvTlu/F32fytfiNtke5qTr7r/6VzSotU+BmPaz67wkzGuzBF5aftvpksHq8P
         2HkLuXXMLrl9ah7PYmTy6m8LzNrxKG/CDSJeyLUqGmMptxI56h9kghpMsE3Kuz3FMKfr
         qg/g==
X-Gm-Message-State: APjAAAXW2ozz2W69HUOzFsfBVvKj+YotlNdhjXdtc6a+I5kpzoIKR4Pm
        iMp/jGYWso0ssxtWQ+Cu3UVVf1Vt6D8k4u83hAY=
X-Google-Smtp-Source: APXvYqwjYCurnRuh/bt7im8dfb27uOpzcrL2Zjt0ZknjXuj/KW6oVlfIvMu0nIWeSxk0tmwM7x3rQ9p+mPw0zuqGjsI=
X-Received: by 2002:aca:c4d5:: with SMTP id u204mr720107oif.131.1565075928299;
 Tue, 06 Aug 2019 00:18:48 -0700 (PDT)
MIME-Version: 1.0
References: <20190806071445.13705-1-yamada.masahiro@socionext.com>
In-Reply-To: <20190806071445.13705-1-yamada.masahiro@socionext.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 6 Aug 2019 09:18:37 +0200
Message-ID: <CAMuHMdWa=WYUjo-N-ZOmDaR-OMOypTtupTpHT0-B00AN39_YPQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] auxdisplay: charlcd: move charlcd.h to drivers/auxdisplay
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Miguel Ojeda Sandonis <miguel.ojeda.sandonis@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Allison Randal <allison@lohutok.net>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ksenija Stanojevic <ksenija.stanojevic@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Willy Tarreau <willy@haproxy.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 6, 2019 at 9:16 AM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
> This header is included in drivers/auxdisplay/. Make it a local header.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
