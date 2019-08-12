Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0AE2C31E40
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 04:12:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 687A22075B
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 04:12:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726296AbfHLEMx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 00:12:53 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:44801 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725774AbfHLEMw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 00:12:52 -0400
Received: by mail-ed1-f66.google.com with SMTP id a21so1632070edt.11;
        Sun, 11 Aug 2019 21:12:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oAP6t0pKBozy4Ru4dNG6hCmwdati3Pg/29On1WvuiE8=;
        b=G1zWlhLBEBk5Qhu34ztoscprtrYGSJQyC88CkiuSKPHdn6ZsicuDBL8lfCKfFCalrX
         YuHLCyb9W4ytUYeTMhv3uN3MzP79Q0sTvbH/C+h733xyT5YC1Z+FCRXKHRLtCDBd9ly8
         S/oV4Pth5a2oGFOJk4nggqzU52sLKnJ1PrahHjMrCuz+9VQBjx24xPKUQNc8v36LNYfN
         2N0J5GMYnPHNuN3owvK7sFIZ8EBdQWfj+l6bQLxd3sn+ddk77Ykyt7KLJyV3DSh8olZ6
         wZ15hVDLrTnbULsoSQM5DAfROFD81TzpTmyRgS4FjFz/1SAk+LEA5dBgbWEpaBUP3dzm
         x9FQ==
X-Gm-Message-State: APjAAAVh0Udh2zh7y5BgHiZ7keHZfbE990qNN7le0Bbr0bmDHtVRqc5p
        iDGnALyTBSSxzayHaZtx6rfpQiA1Hc0=
X-Google-Smtp-Source: APXvYqzgtxu2/C3svbR2pHpD+DVaAmvSmwrvt7pBjQQRAWC6GCunsaarLJIHsnm/Lgn/pnYn6cjNrA==
X-Received: by 2002:a17:907:39a:: with SMTP id ss26mr18836635ejb.278.1565583170546;
        Sun, 11 Aug 2019 21:12:50 -0700 (PDT)
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com. [209.85.221.49])
        by smtp.gmail.com with ESMTPSA id m26sm425895edd.19.2019.08.11.21.12.49
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Sun, 11 Aug 2019 21:12:49 -0700 (PDT)
Received: by mail-wr1-f49.google.com with SMTP id b16so6649570wrq.9;
        Sun, 11 Aug 2019 21:12:49 -0700 (PDT)
X-Received: by 2002:a5d:568e:: with SMTP id f14mr37314937wrv.167.1565583169399;
 Sun, 11 Aug 2019 21:12:49 -0700 (PDT)
MIME-Version: 1.0
References: <20190811090503.32396-1-bshah@kde.org> <20190811090503.32396-2-bshah@kde.org>
In-Reply-To: <20190811090503.32396-2-bshah@kde.org>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Mon, 12 Aug 2019 12:12:38 +0800
X-Gmail-Original-Message-ID: <CAGb2v67_GjWFOEiThMp5o8m+nqYrrTCrNdSkscRfe5vmoJM47Q@mail.gmail.com>
Message-ID: <CAGb2v67_GjWFOEiThMp5o8m+nqYrrTCrNdSkscRfe5vmoJM47Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] arm64: allwinner: h6: add I2C nodes
To:     Bhushan Shah <bshah@kde.org>
Cc:     Icenowy Zheng <icenowy@aosc.io>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 11, 2019 at 5:05 PM Bhushan Shah <bshah@kde.org> wrote:
>
> Add device-tree nodes for i2c0 to i2c2, and also add relevant pinctrl
> nodes.
>
> Suggested-by: Icenowy Zheng <icenowy@aosc.io>
> Signed-off-by: Bhushan Shah <bshah@kde.org>
> ---
>  arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi | 54 ++++++++++++++++++++
>  1 file changed, 54 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
> index bcecca17d61d..1d9ad3ec0b65 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
> @@ -329,6 +329,21 @@
>                                 function = "hdmi";
>                         };
>
> +                       i2c0_pins: i2c0-pins {
> +                               pins = "PD25", "PD26";
> +                               function = "i2c0";
> +                       };
> +
> +                       i2c1_pins: i2c1-pins {
> +                               pins = "PH5", "PH6";
> +                               function = "i2c1";
> +                       };
> +
> +                       i2c2_pins: i2c2-pins {
> +                               pins = "PD23", "PD24";
> +                               function = "i2c2";
> +                       };
> +
>                         mmc0_pins: mmc0-pins {
>                                 pins = "PF0", "PF1", "PF2", "PF3",
>                                        "PF4", "PF5";
> @@ -464,6 +479,45 @@
>                         status = "disabled";
>                 };
>
> +               i2c0: i2c@5002000 {
> +                       compatible = "allwinner,sun6i-a31-i2c";

Please add an soc-specific compatible string, like "allwinner,sun50i-h6-i2c".
This is a last-resort way out in case the hardware isn't so compatible with
the A31.

You'll also need to update the bindings in

    Documentation/devicetree/bindings/i2c/marvell,mv64xxx-i2c.yaml

The file also shows that we do this for other chips, such as the A23,
A64 and A83T.

ChenYu

> +                       reg = <0x05002000 0x400>;
> +                       interrupts = <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>;
> +                       clocks = <&ccu CLK_BUS_I2C0>;
> +                       resets = <&ccu RST_BUS_I2C0>;
> +                       pinctrl-names = "default";
> +                       pinctrl-0 = <&i2c0_pins>;
> +                       status = "disabled";
> +                       #address-cells = <1>;
> +                       #size-cells = <0>;
> +               };
> +
> +               i2c1: i2c@5002400 {
> +                       compatible = "allwinner,sun6i-a31-i2c";
> +                       reg = <0x05002400 0x400>;
> +                       interrupts = <GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>;
> +                       clocks = <&ccu CLK_BUS_I2C1>;
> +                       resets = <&ccu RST_BUS_I2C1>;
> +                       pinctrl-names = "default";
> +                       pinctrl-0 = <&i2c1_pins>;
> +                       status = "disabled";
> +                       #address-cells = <1>;
> +                       #size-cells = <0>;
> +               };
> +
> +               i2c2: i2c@5002800 {
> +                       compatible = "allwinner,sun6i-a31-i2c";
> +                       reg = <0x05002800 0x400>;
> +                       interrupts = <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>;
> +                       clocks = <&ccu CLK_BUS_I2C2>;
> +                       resets = <&ccu RST_BUS_I2C2>;
> +                       pinctrl-names = "default";
> +                       pinctrl-0 = <&i2c2_pins>;
> +                       status = "disabled";
> +                       #address-cells = <1>;
> +                       #size-cells = <0>;
> +               };
> +
>                 emac: ethernet@5020000 {
>                         compatible = "allwinner,sun50i-h6-emac",
>                                      "allwinner,sun50i-a64-emac";
> --
> 2.17.1
>
