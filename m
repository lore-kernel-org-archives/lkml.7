Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A7D9C3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 21:09:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBC9A22DD6
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 21:09:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566335350;
	bh=H64XkBuRAcQnYzn8+CQCDtiy52IhIiaYr4GOLtsnSNQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=yRaNhOlxkrkVgnHpt9hc89mQp9Kdsqt2jH7bSqVRRJOHOEu7S6B2+12zNgYJsHZgY
	 0uhvtweVJbFWHUSpedJ3qLh320EDGSw2IdCR5gwrKzwD4QRi7kAA3DY2ycr7bZ60h9
	 z5PZa0ic4LX5p5NjYWSYCGQn1FYHG4LaEjXmXZpY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730855AbfHTVJJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 17:09:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:45204 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729833AbfHTVJI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 17:09:08 -0400
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9745D22DD6;
        Tue, 20 Aug 2019 21:09:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566335347;
        bh=H64XkBuRAcQnYzn8+CQCDtiy52IhIiaYr4GOLtsnSNQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=iW94QW+j9onF8Mv6031/1TMLrkZk5qiLJUBBEqWri0F1pxjrP7ODbDb3ECH1UOqnC
         VxMViU7dJ/vXi+K6AP6UjeTQgigHstinZWfNQswKBB18pJX6bcTJcOeYpYSFiO9+2G
         A2foQ/g7cxWAeDdu14JV2Ofrd0a33u6w2QnsZ8Rw=
Received: by mail-qk1-f171.google.com with SMTP id r21so5799738qke.2;
        Tue, 20 Aug 2019 14:09:07 -0700 (PDT)
X-Gm-Message-State: APjAAAX/qA6Afz+H504gNP4/NoMfzjqMa/fnu2xSTWMh5cJva+cbKHMh
        4bqt7gWU3q4uDbC9lADlqcuZ9HTh0t6c6XOgZg==
X-Google-Smtp-Source: APXvYqxb3w4zXk/DIn9EJdy3Q+mAWLKI3wo84JlGLi5KtN1pUPJIrh6lt3WrhOwoEjq/jq2EW1VFeYyeEN233aMYmVw=
X-Received: by 2002:a37:a48e:: with SMTP id n136mr28828151qke.223.1566335346826;
 Tue, 20 Aug 2019 14:09:06 -0700 (PDT)
MIME-Version: 1.0
References: <20190726181108.GA17767@Red>
In-Reply-To: <20190726181108.GA17767@Red>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Tue, 20 Aug 2019 16:08:55 -0500
X-Gmail-Original-Message-ID: <CAL_JsqLNZF7eXN=YCZP9vS0_mG50v9WRTJadniBiyD0KDNf1NQ@mail.gmail.com>
Message-ID: <CAL_JsqLNZF7eXN=YCZP9vS0_mG50v9WRTJadniBiyD0KDNf1NQ@mail.gmail.com>
Subject: Re: How to add multiple example with conflicting includes
To:     Corentin Labbe <clabbe.montjoie@gmail.com>
Cc:     Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 26, 2019 at 1:11 PM Corentin Labbe
<clabbe.montjoie@gmail.com> wrote:
>
> Hello
>
> When I try to check the following examples of a devicetree schema:
> examples:
>   - |
>     #include <dt-bindings/interrupt-controller/arm-gic.h>
>     #include <dt-bindings/clock/sun50i-a64-ccu.h>
>     #include <dt-bindings/reset/sun50i-a64-ccu.h>
>
>     crypto: crypto@1c15000 {
>       compatible = "allwinner,sun8i-h3-crypto";
>       reg = <0x01c15000 0x1000>;
>       interrupts = <GIC_SPI 94 IRQ_TYPE_LEVEL_HIGH>;
>       clocks = <&ccu CLK_BUS_CE>, <&ccu CLK_CE>;
>       clock-names = "ahb", "mod";
>       resets = <&ccu RST_BUS_CE>;
>       reset-names = "ahb";
>     };
>
>   - |
>     #include <dt-bindings/interrupt-controller/arm-gic.h>
>     #include <dt-bindings/clock/sun50i-h6-ccu.h>
>     #include <dt-bindings/reset/sun50i-h6-ccu.h>
>
>     crypto: crypto@1904000 {
>       compatible = "allwinner,sun50i-h6-crypto";
>       reg = <0x01904000 0x1000>;
>       interrupts = <GIC_SPI 87 IRQ_TYPE_LEVEL_HIGH>;
>       clocks = <&ccu CLK_BUS_CE>, <&ccu CLK_CE>, <&ccu CLK_MBUS_CE>;
>       clock-names = "ahb", "mod", "mbus";
>       resets = <&ccu RST_BUS_CE>;
>       reset-names = "ahb";
>     };
>
> I get:
> In file included from Documentation/devicetree/bindings/crypto/allwinner,sun8i-ce.example.dts:42:
> /linux-next/scripts/dtc/include-prefixes/dt-bindings/clock/sun50i-h6-ccu.h:9: warning: "CLK_PLL_PERIPH0" redefined
>  #define CLK_PLL_PERIPH0  3
> [...]
>
> So how can I add multiple examples which need somes conflicting #include to be validated.

2 clocks versus 3 clocks hardly seems like a reason for a 2nd example
and I would just drop it IMO.

You could rename your defines to not collide, but that's kind of painful.

The 3rd option is getting dt-extract-example to spit out N example
files and then build each one separately. That was more complicated
than I cared to figure out with kbuild, so I went the simple route.

Rob
