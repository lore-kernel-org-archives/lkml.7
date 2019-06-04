Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A617C282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 08:02:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EBB223F6B
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 08:02:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727144AbfFDIC2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 04:02:28 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:40627 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726805AbfFDIC2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 04:02:28 -0400
Received: by mail-lj1-f195.google.com with SMTP id a21so3534140ljh.7
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2019 01:02:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YKrWcEE+1+xOTvbjgAfsUzEO5QbPrU8ilMZ5XA3rETw=;
        b=Cu1ZPE500oKhs0KC8GdNTIm100yi5MWshaiWEm6HRVi+LvJtkpMXrshbv/NkU6Vzgj
         fsEuIMrxKOu4AJqAWxpaa4omThgVblvcxSLyojIsDE8RMe6zEyuFJslq53E5bYcI2fqH
         Cl0E7CNJBlS7MGzK1ddYlm1LABaGT7wPB78QVouolpCkjkoQcEvCGwDBnxWiZJk6Bd/7
         xw0oEg3YQj4o9Xhvp3tfc9q+w4nrmquk8sqZn0AI8ECfXvZYyRP5e8o2vpOZArK3nNhU
         MwPikmGLr0eKpU1dm4PoS5K6POe2lg7028OoPXR2QY5Tzzf586xR5kNvoGBLXL5wqWZZ
         lChA==
X-Gm-Message-State: APjAAAURJXlCATYEMVVGtLdAJyObj/qrs/zcTZn6oLlcOYPumz2WfNKB
        V2136Rp7bCvAo9aFxtaIXElObT5DudqWphh21/A=
X-Google-Smtp-Source: APXvYqzzf13C6wiQMMFGa7+YGno05GQRLA5lbCkTvOdIMMODSSpqRw2+8UyeCEu5iNIWNk+qucMElr3uAFn6IYCf3GU=
X-Received: by 2002:a2e:91c5:: with SMTP id u5mr4699545ljg.65.1559635345302;
 Tue, 04 Jun 2019 01:02:25 -0700 (PDT)
MIME-Version: 1.0
References: <1559635233-21385-1-git-send-email-krzk@kernel.org>
In-Reply-To: <1559635233-21385-1-git-send-email-krzk@kernel.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 4 Jun 2019 10:02:13 +0200
Message-ID: <CAMuHMdVn5PtJEHApLQ8-C02Hr+ghhKQb2EAP=Kgr9oQwR6psTg@mail.gmail.com>
Subject: Re: [PATCH] powerpc/configs: Remove useless UEVENT_HELPER_PATH
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 4, 2019 at 10:01 AM Krzysztof Kozlowski <krzk@kernel.org> wrote:
> Remove the CONFIG_UEVENT_HELPER_PATH because:
> 1. It is disabled since commit 1be01d4a5714 ("driver: base: Disable
>    CONFIG_UEVENT_HELPER by default") as its dependency (UEVENT_HELPER) was
>    made default to 'n',
> 2. It is not recommended (help message: "This should not be used today
>    [...] creates a high system load") and was kept only for ancient
>    userland,
> 3. Certain userland specifically requests it to be disabled (systemd
>    README: "Legacy hotplug slows down the system and confuses udev").
>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
