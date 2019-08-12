Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01400C433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 09:18:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD53C2087B
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 09:18:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727311AbfHLJSE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 05:18:04 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:46771 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727154AbfHLJSE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 05:18:04 -0400
Received: by mail-ed1-f65.google.com with SMTP id z51so15635111edz.13;
        Mon, 12 Aug 2019 02:18:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qYfm+HhxiVLxwMRZpF6kOW9iq3of0f5g9KF9ckov0fc=;
        b=cVXExtymyEjoZpWX0ovDJLW5SCLo+b+U7P4pTosqUARvfjcwtFd3VsaOuw5CLJ4gYx
         Ui6SInKS2BXsZLMOEhVMlTfUu34DkUMkvCgK5qd6aDXZ8NSBNPREMqeCBoIENIwVMh1t
         jUUNMkjG+tEDPc/Tu8ir/VJB6VDNs10YW8NjOul8oArMoZ3OoD+TM4x0EFJVrL2jsbrr
         sTOwwhRhNnYUTksL86wxQMr43wwGe2Cl2vbL8Kq9WBjT/+Mxb/vg6mqlytoPEmaJ3oUf
         6B2vwzlnmFTig8HHyk5Fpb9g4KPo1RY3o5lFK+3cv8QdUBTWuDkrO7MzKpM+n2gA9mis
         M3/A==
X-Gm-Message-State: APjAAAWUieWSFTXtE7P8qr+MxzM59a7r0J010MLNxZ/FnG7ykvRtT1oc
        yUJOauTqbe4k/hhuQwIgOm0jyhNf59E=
X-Google-Smtp-Source: APXvYqzK3Gd7c+stmPBEDXck6lIvUr4izmcWUK1wvlhoe6Bx1vfTv9cxeWM97fymb54Y17+cYoQQSA==
X-Received: by 2002:a50:8b64:: with SMTP id l91mr15854796edl.258.1565601481313;
        Mon, 12 Aug 2019 02:18:01 -0700 (PDT)
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com. [209.85.221.45])
        by smtp.gmail.com with ESMTPSA id l26sm438803ejg.70.2019.08.12.02.18.00
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Aug 2019 02:18:01 -0700 (PDT)
Received: by mail-wr1-f45.google.com with SMTP id p17so103906122wrf.11;
        Mon, 12 Aug 2019 02:18:00 -0700 (PDT)
X-Received: by 2002:adf:dbce:: with SMTP id e14mr30773546wrj.9.1565601480549;
 Mon, 12 Aug 2019 02:18:00 -0700 (PDT)
MIME-Version: 1.0
References: <20190806155744.10263-1-megous@megous.com> <20190806155744.10263-2-megous@megous.com>
In-Reply-To: <20190806155744.10263-2-megous@megous.com>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Mon, 12 Aug 2019 17:17:48 +0800
X-Gmail-Original-Message-ID: <CAGb2v66+L6_QrL-05fLHQxqavBAmP-pEFp9RWT5XeTQ2rpGa3w@mail.gmail.com>
Message-ID: <CAGb2v66+L6_QrL-05fLHQxqavBAmP-pEFp9RWT5XeTQ2rpGa3w@mail.gmail.com>
Subject: Re: [linux-sunxi] [PATCH v8 1/4] arm64: dts: allwinner: orange-pi-3:
 Enable ethernet
To:     =?UTF-8?Q?Ond=C5=99ej_Jirman?= <megous@megous.com>
Cc:     linux-sunxi <linux-sunxi@googlegroups.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        =?UTF-8?Q?Jernej_=C5=A0krabec?= <jernej.skrabec@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Mark Rutland <mark.rutland@arm.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 6, 2019 at 11:57 PM <megous@megous.com> wrote:
>
> From: Ondrej Jirman <megous@megous.com>
>
> Orange Pi 3 has two regulators that power the Realtek RTL8211E. According
> to the phy datasheet, both regulators need to be enabled at the same time,
> but we can only specify a single phy-supply in the DT.
>
> This can be achieved by making one regulator depedning on the other via
> vin-supply. While it's not a technically correct description of the
> hardware, it achieves the purpose.
>
> All values of RX/TX delay were tested exhaustively and a middle one of the
> working values was chosen.
>
> Signed-off-by: Ondrej Jirman <megous@megous.com>
> ---
>  .../dts/allwinner/sun50i-h6-orangepi-3.dts    | 44 +++++++++++++++++++
>  1 file changed, 44 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-3.dts b/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-3.dts
> index 17d496990108..2c6807b74ff6 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-3.dts
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-3.dts
> @@ -15,6 +15,7 @@
>
>         aliases {
>                 serial0 = &uart0;
> +               ethernet0 = &emac;
>         };
>
>         chosen {
> @@ -44,6 +45,27 @@
>                 regulator-max-microvolt = <5000000>;
>                 regulator-always-on;
>         };
> +
> +       /*
> +        * The board uses 2.5V RGMII signalling. Power sequence to enable
> +        * the phy is to enable GMAC-2V5 and GMAC-3V (aldo2) power rails
> +        * at the same time and to wait 100ms.
> +        */
> +       reg_gmac_2v5: gmac-2v5 {
> +               compatible = "regulator-fixed";
> +               regulator-name = "gmac-2v5";
> +               regulator-min-microvolt = <2500000>;
> +               regulator-max-microvolt = <2500000>;
> +               startup-delay-us = <100000>;
> +               enable-active-high;
> +               gpio = <&pio 3 6 GPIO_ACTIVE_HIGH>; /* PD6 */
> +
> +               /* The real parent of gmac-2v5 is reg_vcc5v, but we need to
> +                * enable two regulators to power the phy. This is one way
> +                * to achieve that.
> +                */
> +               vin-supply = <&reg_aldo2>; /* GMAC-3V */
> +       };

The RTL8211E datasheet I have says:

    2.5V (or 1.8/1.5V) RGMII power should be risen simultaneously or slightly
    earlier than 3.3V power. Rising 2.5V (or 1.8/1.5V) power later than 3.3V
    power may lead to errors.

Since you can't reverse the parent relationship in your patch, maybe it's
time to add a phy-io-supply property?

It also says the rise time for 3.3V must be between 1ms and 100ms. However
the PMIC doesn't support voltage ramp control for the LDOs, nor does it list
the ramp rate.

ChenYu

>  };
>
>  &cpu0 {
> @@ -58,6 +80,28 @@
>         status = "okay";
>  };
>
> +&emac {
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&ext_rgmii_pins>;
> +       phy-mode = "rgmii";
> +       phy-handle = <&ext_rgmii_phy>;
> +       phy-supply = <&reg_gmac_2v5>;
> +       allwinner,rx-delay-ps = <1500>;
> +       allwinner,tx-delay-ps = <700>;
> +       status = "okay";
> +};
> +
> +&mdio {
> +       ext_rgmii_phy: ethernet-phy@1 {
> +               compatible = "ethernet-phy-ieee802.3-c22";
> +               reg = <1>;
> +
> +               reset-gpios = <&pio 3 14 GPIO_ACTIVE_LOW>; /* PD14 */
> +               reset-assert-us = <15000>;
> +               reset-deassert-us = <40000>;
> +       };
> +};
> +
>  &mmc0 {
>         vmmc-supply = <&reg_cldo1>;
>         cd-gpios = <&pio 5 6 GPIO_ACTIVE_LOW>; /* PF6 */
> --
> 2.22.0
>
> --
> You received this message because you are subscribed to the Google Groups "linux-sunxi" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to linux-sunxi+unsubscribe@googlegroups.com.
> To view this discussion on the web, visit https://groups.google.com/d/msgid/linux-sunxi/20190806155744.10263-2-megous%40megous.com.
