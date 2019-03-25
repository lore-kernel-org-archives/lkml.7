Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A03D7C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 10:05:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7032420811
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 10:05:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730642AbfCYKFc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 06:05:32 -0400
Received: from mail-vs1-f68.google.com ([209.85.217.68]:33735 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730250AbfCYKFb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 06:05:31 -0400
Received: by mail-vs1-f68.google.com with SMTP id a190so2828962vsd.0;
        Mon, 25 Mar 2019 03:05:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ATvHZQLJnseqKzWZ0/+0qvI8MhxuS2/rOv8FNjOsT3U=;
        b=cfhzJ2NAzMnpsqUAH2g3MrP/EO2/kCuJe//5s5rmx9TM95pSZN2yl1ttv7IHLWhPnw
         FKJibVLYtgtK0XEbGxkO0/8u9Vgi5Oa1oXNIaOruWFuiQ3w0A0UWD0828ZnQOQQZRLlT
         HBpcu/eyxuE0V+V3og4j+4W+uZtwyql/Bmz0ytF1oftaudF93FObFOTYMeYBPO25lV4c
         cawlCPGMRYbdS7nldVGXB+XeDODAqLJcNT9Mzz+4/PTARWjAvXEbKisp/Xr0pDnFS1YG
         f65g4RLOdYEB8d6/T4KPCztn5vD3mUfOtSzsyyUdkQGeIIZjJxZUBda4wGwwmXvVtvr1
         Fw8A==
X-Gm-Message-State: APjAAAWE5wmfcSZvNo3KI19FKRoW183tiksxtRYdMexrf/2qZbW69L+b
        0C1Ah0xGeiYGj9qDZQTEXLzt7uUSVIvIA0AS5gE=
X-Google-Smtp-Source: APXvYqzoFGYQK+OMPXBUkSVUI7HafxasrjQi989ULF7ik6f/XlC4IIRD5nU1m0jkNqVQt1WOFlBSFW7A2xj0ma9HlQ4=
X-Received: by 2002:a67:f843:: with SMTP id b3mr14284925vsp.152.1553508330620;
 Mon, 25 Mar 2019 03:05:30 -0700 (PDT)
MIME-Version: 1.0
References: <1553254384-8196-1-git-send-email-gareth.williams.jx@renesas.com>
In-Reply-To: <1553254384-8196-1-git-send-email-gareth.williams.jx@renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 25 Mar 2019 11:05:18 +0100
Message-ID: <CAMuHMdXThxm58o7xZ=ZRFFWTUjMeuYKeLVuqjMFVR8Rr5DBJAQ@mail.gmail.com>
Subject: Re: [PATCH] clk: renesas: r9a06g032: Add missing PCI USB clock
To:     Gareth Williams <gareth.williams.jx@renesas.com>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 22, 2019 at 12:35 PM Gareth Williams
<gareth.williams.jx@renesas.com> wrote:
> The clock driver is missing support for the clk_pci_usb clock that is
> present on the SoC. This is added to allow the clock to be supported.
>
> Signed-off-by: Gareth Williams <gareth.williams.jx@renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. queueing clk-renesas-for-v5.2.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
