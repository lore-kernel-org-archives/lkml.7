Return-Path: <SRS0=OzJr=YZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26B70CA9ED1
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 10:08:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06D882086D
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 10:08:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729500AbfKAKIU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Nov 2019 06:08:20 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:34410 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729181AbfKAKIU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Nov 2019 06:08:20 -0400
Received: by mail-oi1-f193.google.com with SMTP id l202so7740132oig.1;
        Fri, 01 Nov 2019 03:08:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+I3xQl9ln+lrGFb5a1qNX1dE+zwF+Br3GKgAcoIpVg0=;
        b=E86Ut/9mOUJMvaqA5+eSoAUsqlTb0yuor9HT/pOHVQ0e/P60l6QqFmSQSwqJepTqwz
         6vHFsDiAMAT4dxeniEOgv4V6oWtMGzYfvUPFAgZ3km+XuoqthlMWLOdxtZAvjxHjlB80
         YCFKezgLzXYX9si5v4uRCGxO3FRtA18gqDdLpPc2IMTAhVwYXnSdSJZLL2zmxj4XGC/y
         22tgHgKtfT7X3rh4wTR3WxWF/O/gBIwuhGkmWbMtDSoEum2xaMOa6YH0rCdfk8eCMPJz
         2teCcFwMP8o2c5L+uaEktlxxj7z0F067R+kZ7TwRIpnEf9WEBpUC/xfRE8uDj6iw05TD
         uSbQ==
X-Gm-Message-State: APjAAAX6YY+SgGYZwfB8GMiwbFOKQyunaKGT6ZD0CFEpQjCYMTXDlJwz
        l1bmMH/clREXZLeDbtkWwe8+bKgTtiA1yrTIwGo=
X-Google-Smtp-Source: APXvYqyFWgpB6XEGfMCjZsYPk2WDJOLqiGcZrURCT7LaEN/S0hFYXldPAmBySb2Ylqn/7Yv1GVxJdkW9M3x45yHrDHI=
X-Received: by 2002:aca:4ac5:: with SMTP id x188mr3592931oia.148.1572602898727;
 Fri, 01 Nov 2019 03:08:18 -0700 (PDT)
MIME-Version: 1.0
References: <20191021161351.20789-1-krzk@kernel.org> <20191021161351.20789-4-krzk@kernel.org>
In-Reply-To: <20191021161351.20789-4-krzk@kernel.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 1 Nov 2019 11:08:07 +0100
Message-ID: <CAMuHMdXr7_HP5NUQ_0D76N-eBuootQqyPusqmf6nyDnLN__ORA@mail.gmail.com>
Subject: Re: [PATCH v4 4/7] dt-bindings: sram: Merge Renesas SRAM bindings
 into generic
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>, Heiko Stuebner <heiko@sntech.de>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

On Mon, Oct 21, 2019 at 6:15 PM Krzysztof Kozlowski <krzk@kernel.org> wrote:
> The Renesas SRAM bindings list only compatible so integrate them into
> generic SRAM bindings schema.
>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

Thanks for your patch, whcih is now commit 0759b09eadd0d9a1 ("dt-bindings:
sram: Merge Renesas SRAM bindings into generic") in Rob's for-next branch.

> --- a/Documentation/devicetree/bindings/sram/renesas,smp-sram.txt
> +++ /dev/null
> @@ -1,27 +0,0 @@
> -* Renesas SMP SRAM
> -
> -Renesas R-Car Gen2 and RZ/G1 SoCs need a small piece of SRAM for the jump stub
> -for secondary CPU bringup and CPU hotplug.
> -This memory is reserved by adding a child node to a "mmio-sram" node, cfr.
> -Documentation/devicetree/bindings/sram/sram.txt.
> -
> -Required child node properties:
> -  - compatible: Must be "renesas,smp-sram",
> -  - reg: Address and length of the reserved SRAM.
> -    The full physical (bus) address must be aligned to a 256 KiB boundary.
> -
> -
> -Example:
> -
> -       icram1: sram@e63c0000 {
> -               compatible = "mmio-sram";
> -               reg = <0 0xe63c0000 0 0x1000>;
> -               #address-cells = <1>;
> -               #size-cells = <1>;
> -               ranges = <0 0 0xe63c0000 0x1000>;
> -
> -               smp-sram@0 {
> -                       compatible = "renesas,smp-sram";
> -                       reg = <0 0x10>;
> -               };

> --- a/Documentation/devicetree/bindings/sram/sram.yaml
> +++ b/Documentation/devicetree/bindings/sram/sram.yaml

> @@ -186,3 +187,17 @@ examples:
>              reg = <0x1ff80 0x8>;
>          };
>      };
> +
> +  - |
> +    sram@e63c0000 {
> +        compatible = "mmio-sram";
> +        reg = <0xe63c0000 0x1000>;

Is there any specific reason you converted the example from 64-bit to
32-bit addressing?
All Renesas SoCs using this have #address-cells and #size-cells = <2>.

Thanks!

> +        #address-cells = <1>;
> +        #size-cells = <1>;
> +        ranges = <0 0xe63c0000 0x1000>;
> +
> +        smp-sram@0 {
> +            compatible = "renesas,smp-sram";
> +            reg = <0 0x10>;
> +        };
> +    };

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
