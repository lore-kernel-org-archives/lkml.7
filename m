Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D28F7C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 15:11:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A309E2147C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 15:11:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726828AbfCLPLT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 11:11:19 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:32968 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725894AbfCLPLT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 11:11:19 -0400
Received: by mail-vs1-f65.google.com with SMTP id z6so1712373vsc.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2019 08:11:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7wqGJiWYRwkdUJyqrM6cONlJwekjbifUrqXWCARk7eo=;
        b=SMXquf5uqidYnN86saTxKndkPnkvdQZ8ySunvSYKCydk5VM4b7AIQXs1ocLsD/pot6
         kLx9Qnaf1zCgUjIHH/ZKblJcMqPjAAPRA6tBoj8OWPQQxtG7IoqOQs0UzDASCiNnKlZS
         4lpSGQWWEKhomXOLBc3CgoUiTOK5hXZSLV/g07vKLvTxppy36XxMGIfQU+gS9GhDbPkv
         iZJLI/pDz0YmAzhDmdnbakYbVsnvjsWWBdtzIIjE7G4PZ/9ACqt1Lw5M8Yfzr7SEylNj
         kYvFpc28CatqsmLkZR0t+rP4YS9bcVLejOBgMRAtAqL9CPyaafu2DNMfTuR6xx7cxWn4
         k0VQ==
X-Gm-Message-State: APjAAAUgx99/G+3PDu+/OPdstfzuMRfw8F9OwALlkIFwREtff988S0dX
        Ugi7ezhX4b9ppR2mrpRhdXLUZOuYNI/DYmkG4fk=
X-Google-Smtp-Source: APXvYqx5WEadnARVKd5DFxFLqXYfVdij1UEJGRK+qaqlaSJDJFJF2DrfZuVqhxN+/3F/UdSdq9g6fNaBIO9XPH4QJms=
X-Received: by 2002:a67:78ce:: with SMTP id t197mr20022517vsc.152.1552403478064;
 Tue, 12 Mar 2019 08:11:18 -0700 (PDT)
MIME-Version: 1.0
References: <20190312144432.7668-1-andriy.shevchenko@linux.intel.com> <20190312144432.7668-6-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20190312144432.7668-6-andriy.shevchenko@linux.intel.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 12 Mar 2019 16:11:06 +0100
Message-ID: <CAMuHMdWYW8frwOr0tCY5bBHp3nAQ+dxeeHEiCkTqvs-HU_vjHw@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] auxdisplay: hd44780: Convert to use charlcd_free()
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Miguel Ojeda Sandonis <miguel.ojeda.sandonis@gmail.com>,
        Willy Tarreau <willy@haproxy.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 12, 2019 at 3:46 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
> Convert to use charlcd_free() instead of kfree() for sake of type check.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
