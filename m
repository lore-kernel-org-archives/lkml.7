Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC6F6C04E84
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 07:29:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FEC920717
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 07:29:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727581AbfE1H3J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 03:29:09 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:42043 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726816AbfE1H3J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 03:29:09 -0400
Received: by mail-lf1-f65.google.com with SMTP id y13so13706517lfh.9;
        Tue, 28 May 2019 00:29:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hd2ztrPa+/Jspv+88ZdGM7xjRP1HllQItAwAUGW3LRI=;
        b=QpLdjelLA3HG8W7J0qqEUAvL8AgpDZNnHOCWfWnGNXyHyRufR58QFfwJAal8V0WOMX
         GQaHY6ohSIZzqhgVcCr7GnaS7Ngz8rFNoQqyuoyd9WguexeVCZCQRXk79v8NGGMvHE4j
         pLQjmv1UbV/k4H72vhB/Cl0w3Uyucg/8uxT485fwfhlm7N/Z8KmlPyuSdNQu+rvpxpcw
         N36kmwGsOtKMH2KEIgrX9mDB23ook0jhsU1E8x3o1C0lTE65Y55aphDNX1TJ0hDEPned
         XW+W4k7Wgv2UJeR9wK06bpJ4KsCNcpdvljLT3FWfxGmzfUkov4X9Oxc3Wsf8jzTkrbZO
         hoUg==
X-Gm-Message-State: APjAAAU/P99heey4X39O5VLmWSIEI7Gf4tpjVsvzqGZqhrLTb/GNKd+b
        3gnd2Y/e6/6jBzGfbissqpZLCVakL6ok1Dg043w=
X-Google-Smtp-Source: APXvYqz9vHfVvbiwy5f5TN/g85aWH14wVF+UEIVfXq7XO4eOsFQL7OTr/XH5SoitkvqVhSY+4KVeEqebYEVCJDL32MU=
X-Received: by 2002:ac2:52a8:: with SMTP id r8mr25092524lfm.20.1559028546947;
 Tue, 28 May 2019 00:29:06 -0700 (PDT)
MIME-Version: 1.0
References: <1558711904-27278-1-git-send-email-gareth.williams.jx@renesas.com> <1558711904-27278-2-git-send-email-gareth.williams.jx@renesas.com>
In-Reply-To: <1558711904-27278-2-git-send-email-gareth.williams.jx@renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 28 May 2019 09:28:55 +0200
Message-ID: <CAMuHMdV2jmY2u1-Z6cRR1OQcfW8U0HM_ac-xn1gO9nPf41iD+A@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] dt-bindings: clock: renesas,r9a06g032-sysctrl:
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

Hi Gareth,

On Fri, May 24, 2019 at 5:32 PM Gareth Williams
<gareth.williams.jx@renesas.com> wrote:
> The driver is gaining power domain support, so add the new property
> to the DT binding and update the examples.
>
> Signed-off-by: Gareth Williams <gareth.williams.jx@renesas.com>

Thanks for your patch!

> --- a/Documentation/devicetree/bindings/clock/renesas,r9a06g032-sysctrl.txt
> +++ b/Documentation/devicetree/bindings/clock/renesas,r9a06g032-sysctrl.txt
@@ -40,4 +42,5 @@ Examples
>                 reg-io-width = <4>;
>                 clocks = <&sysctrl R9A06G032_CLK_UART0>;
>                 clock-names = "baudclk";
> +               power-domains = <&sysctrl>;

This is an interesting example: according to the driver,
R9A06G032_CLK_UART0, is not clock used for power management?

Oh, the real uart0 node in arch/arm/boot/dts/r9a06g032.dtsi uses

    clocks = <&sysctrl R9A06G032_CLK_UART0>, <&sysctrl R9A06G032_HCLK_UART0>;
    clock-names = "baudclk", "apb_pclk";

That does make sense...

With the above fixed:
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert


--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
