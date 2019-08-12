Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 355C2C433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 04:53:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01D9120842
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 04:53:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565585595;
	bh=U2DFlAsT9fiCibIRTlnmIj7xBh4FZ71yzSmmo/sRMDc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=aN1uYEw6JkVp7qWRc0G6IYuliiDjU4QyrQenXTSLGZZAtQGV/TTv12sk0wRSWgIiY
	 WraYRak4EyL0J9c/3HmfxHeAR5Xd+AKAqaFbkKUQf/ZV169DzBowbAvw6l6Wp6sy4A
	 wLlNP+evvxOQCs0gaFpPmPGpHhf2TPoN2J5QSPgw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726358AbfHLExO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 00:53:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:40272 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725648AbfHLExN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 00:53:13 -0400
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2B6EF2087B;
        Mon, 12 Aug 2019 04:53:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565585592;
        bh=U2DFlAsT9fiCibIRTlnmIj7xBh4FZ71yzSmmo/sRMDc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=dcVsHGW3621y7F6SNvLxIU/nsBvDMBnezicKt9/5s2OijcY+XgzbnU2lkmzWSDlUi
         U2dzKAf7FjGCC3HqwZDxj/bO7/1j/bhkrxB3hlE0Tjhn4p41VgSDPL1WP6twWVIe1Z
         /hSpMvGD0yELB5uOF0J2BmPa9LMY8yHh8914ZD9w=
Received: by mail-wr1-f52.google.com with SMTP id b16so6695635wrq.9;
        Sun, 11 Aug 2019 21:53:12 -0700 (PDT)
X-Gm-Message-State: APjAAAWr8DFAJCHMOjgF3u9Zsi4UDT89WE1xSGBOI6Vq1ogC5xfol641
        BUzVWW7r6w79PJjhnxUcLRXOtxSd+e95W2Kla8U=
X-Google-Smtp-Source: APXvYqzWTwxFBAger42CdK0YgxZARYvcqOa5DVNzRa6gk/EElcW+UHkrG2le3oAfyQ7okItaDDgPMMoxxRg8hCuxstI=
X-Received: by 2002:adf:c613:: with SMTP id n19mr38373302wrg.109.1565585590646;
 Sun, 11 Aug 2019 21:53:10 -0700 (PDT)
MIME-Version: 1.0
References: <20190811203144.5999-1-peron.clem@gmail.com> <20190811203144.5999-2-peron.clem@gmail.com>
In-Reply-To: <20190811203144.5999-2-peron.clem@gmail.com>
From:   Chen-Yu Tsai <wens@kernel.org>
Date:   Mon, 12 Aug 2019 12:52:59 +0800
X-Gmail-Original-Message-ID: <CAGb2v67T3h_KTVZ20NVWNd78xqCa2ZhYiCJr4oOwYjUM3OaZXA@mail.gmail.com>
Message-ID: <CAGb2v67T3h_KTVZ20NVWNd78xqCa2ZhYiCJr4oOwYjUM3OaZXA@mail.gmail.com>
Subject: Re: [linux-sunxi] [PATCH v5 1/3] arm64: dts: allwinner: Add SPDIF
 node for Allwinner H6
To:     =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Cc:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Aug 12, 2019 at 4:31 AM Cl=C3=A9ment P=C3=A9ron <peron.clem@gmail.c=
om> wrote:
>
> The Allwinner H6 has a SPDIF controller called OWA (One Wire Audio).
>
> Only one pinmuxing is available so set it as default.
>
> Signed-off-by: Cl=C3=A9ment P=C3=A9ron <peron.clem@gmail.com>
> ---
>  arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi | 38 ++++++++++++++++++++
>  1 file changed, 38 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi b/arch/arm64/bo=
ot/dts/allwinner/sun50i-h6.dtsi
> index 7628a7c83096..677eb374678d 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
> @@ -83,6 +83,24 @@
>                 method =3D "smc";
>         };
>
> +       sound-spdif {
> +               compatible =3D "simple-audio-card";
> +               simple-audio-card,name =3D "sun50i-h6-spdif";
> +
> +               simple-audio-card,cpu {
> +                       sound-dai =3D <&spdif>;
> +               };
> +
> +               simple-audio-card,codec {
> +                       sound-dai =3D <&spdif_out>;
> +               };
> +       };
> +
> +       spdif_out: spdif-out {
> +               #sound-dai-cells =3D <0>;
> +               compatible =3D "linux,spdif-dit";
> +       };
> +

We've always had this part in the board dts. It isn't relevant to boards
that don't have SPDIF output.

Also, not so relevant here, but there are different simple sound card
constructs. Some support multiple audio streams with dynamic PCM routing.
How these are configured really depends on what interfaces are usable.

So keeping this at the board level is IMO a better choice.

ChenYu


>         timer {
>                 compatible =3D "arm,armv8-timer";
>                 interrupts =3D <GIC_PPI 13
> @@ -282,6 +300,11 @@
>                                 bias-pull-up;
>                         };
>
> +                       spdif_tx_pin: spdif-tx-pin {
> +                               pins =3D "PH7";
> +                               function =3D "spdif";
> +                       };
> +
>                         uart0_ph_pins: uart0-ph-pins {
>                                 pins =3D "PH0", "PH1";
>                                 function =3D "uart0";
> @@ -411,6 +434,21 @@
>                         };
>                 };
>
> +               spdif: spdif@5093000 {
> +                       #sound-dai-cells =3D <0>;
> +                       compatible =3D "allwinner,sun50i-h6-spdif";
> +                       reg =3D <0x05093000 0x400>;
> +                       interrupts =3D <GIC_SPI 21 IRQ_TYPE_LEVEL_HIGH>;
> +                       clocks =3D <&ccu CLK_BUS_SPDIF>, <&ccu CLK_SPDIF>=
;
> +                       clock-names =3D "apb", "spdif";
> +                       resets =3D <&ccu RST_BUS_SPDIF>;
> +                       dmas =3D <&dma 2>;
> +                       dma-names =3D "tx";
> +                       pinctrl-names =3D "default";
> +                       pinctrl-0 =3D <&spdif_tx_pin>;
> +                       status =3D "disabled";
> +               };
> +
>                 usb2otg: usb@5100000 {
>                         compatible =3D "allwinner,sun50i-h6-musb",
>                                      "allwinner,sun8i-a33-musb";
> --
> 2.20.1
>
> --
> You received this message because you are subscribed to the Google Groups=
 "linux-sunxi" group.
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to linux-sunxi+unsubscribe@googlegroups.com.
> To view this discussion on the web, visit https://groups.google.com/d/msg=
id/linux-sunxi/20190811203144.5999-2-peron.clem%40gmail.com.
