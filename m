Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC7E9C04AB6
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 08:03:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A997421707
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 08:03:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727577AbfFCIDS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 04:03:18 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:39226 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725856AbfFCIDR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 04:03:17 -0400
Received: by mail-lf1-f66.google.com with SMTP id p24so6360746lfo.6;
        Mon, 03 Jun 2019 01:03:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8zHct7gI+WfUh/TYxaDLq5h6uP1yLHgrI/pUFB8t+sU=;
        b=WydoQGQtheDUkzNlnfXg6bIcCAeCnYe/k3ENUzLjiyjbnDefF7SSVbF6Ssc4iEA4i3
         CDPtNLV2pUMkPkIOLm45G5+LYnhGQzYve3ucee+gOoxzzOm2CIROorTTtRn0ovjYLac3
         dQXqjnXfbJCUXXD8q4kZJb/ls0Pu5TXHHdLjHOpIOBMekWZM+fIefBrgp/K2NiAkN/2o
         cICWMI1OrVySVDE7gkSqNt2grQ64y4/tQFbHbwHXe/zoSND20DNuNRGgWl1/Et9i6c5X
         gvyyiwFrbUt9ptUGXO9Rt4+nnzyl89XaQt7BPUQWAf1o6NEkX2+CAgVHlAIGwmWTKofj
         WMlQ==
X-Gm-Message-State: APjAAAXxd/2o0UFcZOg871FwbKMp+RzF+t64VZIr+C9GsdYzyDn+nhF4
        g+bWM6WKaqywQnc6CP3Igcdjo1l7thc616GhKu4=
X-Google-Smtp-Source: APXvYqyVB06zohxUXif7x65zmAadYby0VPFg9MxWvFJ0TDCVPewZTLK9b7hBeBYQLOtfa00Znr8eMwxhl8PVi66ukiM=
X-Received: by 2002:ac2:5a04:: with SMTP id q4mr12927243lfn.90.1559548994812;
 Mon, 03 Jun 2019 01:03:14 -0700 (PDT)
MIME-Version: 1.0
References: <1559044467-2639-1-git-send-email-gareth.williams.jx@renesas.com> <1559044467-2639-2-git-send-email-gareth.williams.jx@renesas.com>
In-Reply-To: <1559044467-2639-2-git-send-email-gareth.williams.jx@renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 3 Jun 2019 10:03:02 +0200
Message-ID: <CAMuHMdXM7j_tCWR-9FZc8DOARmdXqfd88+a=TYHwKZEmMuHCrg@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] dt-bindings: clock: renesas,r9a06g032-sysctrl:
 Document power Domains
To:     Gareth Williams <gareth.williams.jx@renesas.com>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        linux-clk <linux-clk@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 28, 2019 at 1:55 PM Gareth Williams
<gareth.williams.jx@renesas.com> wrote:
> The driver is gaining power domain support, so add the new property
> to the DT binding and update the examples.
>
> Signed-off-by: Gareth Williams <gareth.williams.jx@renesas.com>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> v4:
>  - Added missing HCLK to UART0 example to show the clock added
>    to the driver.
>  - Added Geert's Reviewed-by line.

Thanks for the update, will queue in clock-renesas-for-v5.3.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
