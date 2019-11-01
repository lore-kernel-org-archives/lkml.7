Return-Path: <SRS0=OzJr=YZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB7E7CA9ECB
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 03:01:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93C4B2067D
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 03:01:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728659AbfKADBR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Oct 2019 23:01:17 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:40749 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726793AbfKADBQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 23:01:16 -0400
Received: by mail-ed1-f67.google.com with SMTP id p59so6492114edp.7
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2019 20:01:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ja69r3scSsFa5ExNkwUmGih/B4M0amxDhxiXxuJHmpY=;
        b=o1+gCJPFZwFioHWR1x700X2zOxm9IVecMUK9bBdqvqd8HZDTpfDrNNI52IzogRCs3q
         ZcYy781FM464vk/ucycnI9oR1OGFuBBwlsT6p6Gd6wGkXXCPw1Y01+k9oXbtg16LBd/I
         G+CSdpNyv+jkIEps1KMvOUv9OguaWXGlCQnARLPUVk1Ita7A/3MtyYYI9gHY6AQTUbfd
         ccwR09dQXT6/S5OVV8f0Ljjl7E9LWeofx4SN8BtrlQHISFogg1Zc5GPeHUabSupgLvOj
         NTK0PF17ASo7YNlq4y28lvw7sd+Ub+q1nBel1e2h/8G+njRjSSb9cLb7YQUz5YUTPinD
         4erQ==
X-Gm-Message-State: APjAAAXIoHvmWs+78SueXpYJt7l7e2tWGq0QteuLz899gMCEVIUdgyaS
        kd/cevMnp5QtNFloL0lC9oOGAG4cxYM=
X-Google-Smtp-Source: APXvYqxlQ3kejwefW7bZQQXDzXrAyaEVDjEooDDJ/ki6PyxXkWIjFKNlqLdsRZqbAxyHlMgy4Kz86Q==
X-Received: by 2002:a17:906:680c:: with SMTP id k12mr7609410ejr.118.1572577273916;
        Thu, 31 Oct 2019 20:01:13 -0700 (PDT)
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com. [209.85.221.41])
        by smtp.gmail.com with ESMTPSA id k25sm169423edv.28.2019.10.31.20.01.13
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Oct 2019 20:01:13 -0700 (PDT)
Received: by mail-wr1-f41.google.com with SMTP id o28so8345373wro.7
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2019 20:01:13 -0700 (PDT)
X-Received: by 2002:a05:6000:1252:: with SMTP id j18mr8450718wrx.23.1572577273265;
 Thu, 31 Oct 2019 20:01:13 -0700 (PDT)
MIME-Version: 1.0
References: <20191031231216.30903-2-karlp@tweak.net.au>
In-Reply-To: <20191031231216.30903-2-karlp@tweak.net.au>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Fri, 1 Nov 2019 11:01:01 +0800
X-Gmail-Original-Message-ID: <CAGb2v67PLemQvj+SOF2h_cfc4HcnAyvs866Bas7GRUF9Y1Lo1A@mail.gmail.com>
Message-ID: <CAGb2v67PLemQvj+SOF2h_cfc4HcnAyvs866Bas7GRUF9Y1Lo1A@mail.gmail.com>
Subject: Re: [PATCH 2/3] ARM: dts: sun8i: add FriendlyARM NanoPi Duo2
To:     Karl Palsson <karlp@tweak.net.au>
Cc:     Maxime Ripard <mripard@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 1, 2019 at 7:12 AM Karl Palsson <karlp@tweak.net.au> wrote:
>
> This is an Allwinner H3 based board, with 512MB ram, a USB OTG port,
> microsd slot, an onboard AP6212A wifi/bluetooth module, and a CSI
> connector.
>
> Full details and schematic available from vendor:
> http://wiki.friendlyarm.com/wiki/index.php/NanoPi_Duo2
>
> Signed-off-by: Karl Palsson <karlp@tweak.net.au>
> ---
>  arch/arm/boot/dts/Makefile                 |   1 +
>  arch/arm/boot/dts/sun8i-h3-nanopi-duo2.dts | 161 +++++++++++++++++++++
>  2 files changed, 162 insertions(+)
>  create mode 100644 arch/arm/boot/dts/sun8i-h3-nanopi-duo2.dts
>
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index 9159fa2cea90..d8bf02abcda1 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -1096,6 +1096,7 @@ dtb-$(CONFIG_MACH_SUN8I) += \
>         sun8i-h3-beelink-x2.dtb \
>         sun8i-h3-libretech-all-h3-cc.dtb \
>         sun8i-h3-mapleboard-mp130.dtb \
> +       sun8i-h3-nanopi-duo2.dtb \
>         sun8i-h3-nanopi-m1.dtb  \
>         sun8i-h3-nanopi-m1-plus.dtb \
>         sun8i-h3-nanopi-neo.dtb \
> diff --git a/arch/arm/boot/dts/sun8i-h3-nanopi-duo2.dts b/arch/arm/boot/dts/sun8i-h3-nanopi-duo2.dts
> new file mode 100644
> index 000000000000..ecfaaa0ec73e
> --- /dev/null
> +++ b/arch/arm/boot/dts/sun8i-h3-nanopi-duo2.dts
> @@ -0,0 +1,161 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Copyright (C) 2019 Karl Palsson <karlp@tweak.net.au>
> + */
> +
> +/dts-v1/;
> +#include "sun8i-h3.dtsi"
> +#include "sunxi-common-regulators.dtsi"
> +
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/input/input.h>
> +
> +/ {
> +       model = "FriendlyARM NanoPi Duo2";
> +       compatible = "friendlyarm,nanopi-duo2", "allwinner,sun8i-h3";
> +
> +       aliases {
> +               serial0 = &uart0;
> +       };
> +
> +       chosen {
> +               stdout-path = "serial0:115200n8";
> +       };
> +
> +       leds {
> +               compatible = "gpio-leds";
> +
> +               status {
> +                       label = "nanopi:green:status";
> +                       gpios = <&pio 0 10 GPIO_ACTIVE_HIGH>;

Can you add the pin name as a comment after this, like you already have
for most of the other gpios entries?

> +                       linux,default-trigger = "heartbeat";

I'm not so found of this. Unless the LED actually says "heartbeat",
I don't think we should force a default.

> +               };
> +
> +               pwr {
> +                       label = "nanopi:red:pwr";
> +                       gpios = <&r_pio 0 10 GPIO_ACTIVE_HIGH>;

Here as well.

> +                       default-state = "on";
> +               };
> +       };
> +
> +       r_gpio_keys {
> +               compatible = "gpio-keys";
> +
> +               k1 {
> +                       label = "k1";
> +                       linux,code = <BTN_0>;
> +                       gpios = <&r_pio 0 3 GPIO_ACTIVE_LOW>;
> +               };
> +       };
> +
> +       reg_vdd_cpux: vdd-cpux-regulator {
> +               compatible = "regulator-gpio";
> +               regulator-name = "vdd-cpux";
> +               regulator-boot-on;
> +               regulator-always-on;
> +               regulator-min-microvolt = <1100000>;
> +               regulator-max-microvolt = <1300000>;
> +               regulator-ramp-delay = <50>; /* 4ms */
> +
> +               gpios = <&r_pio 0 6 GPIO_ACTIVE_HIGH>; /* PL6 */

This regulator also uses a GPIO line for its enable pin.
Please include that.

> +               enable-active-high;
> +               gpios-states = <0x1>;
> +               states = <1100000 0x0
> +                         1300000 0x1>;
> +       };

Please also add the two other regulators, VDD-SYS and VCC-DRAM.

> +
> +       wifi_pwrseq: wifi_pwrseq {
> +               compatible = "mmc-pwrseq-simple";
> +               reset-gpios = <&r_pio 0 7 GPIO_ACTIVE_LOW>; /* PL7 */
> +               clocks = <&rtc 1>;
> +               clock-names = "ext_clock";
> +       };
> +
> +};
> +
> +&cpu0 {
> +       cpu-supply = <&reg_vdd_cpux>;
> +};
> +
> +&usb_otg {
> +       status = "okay";
> +       dr_mode = "otg";
> +};
> +
> +&ehci0 {
> +       status = "okay";
> +};
> +
> +&ohci0 {
> +       status = "okay";
> +};
> +
> +&reg_usb0_vbus {
> +       gpio = <&r_pio 0 2 GPIO_ACTIVE_HIGH>; /* PL2 */
> +       status = "okay";
> +};
> +
> +&usbphy {
> +       usb0_id_det-gpios = <&pio 6 12 GPIO_ACTIVE_HIGH>; /* PG12 */
> +       usb0_vbus-supply = <&reg_usb0_vbus>;
> +       status = "okay";
> +};

Please have the nodes in alphabetic order, not group them by function.

> +
> +&mmc0 {
> +       bus-width = <4>;
> +       cd-gpios = <&pio 5 6 GPIO_ACTIVE_LOW>;
> +       status = "okay";
> +       vmmc-supply = <&reg_vcc3v3>;
> +};
> +
> +&mmc1 {
> +       vmmc-supply = <&reg_vcc3v3>;
> +       vqmmc-supply = <&reg_vcc3v3>;
> +       mmc-pwrseq = <&wifi_pwrseq>;
> +       bus-width = <4>;
> +       non-removable;
> +       status = "okay";
> +
> +       sdio_wifi: sdio_wifi@1 {
> +               reg = <1>;
> +               compatible = "brcm,bcm4329-fmac";
> +               interrupt-parent = <&pio>;
> +               interrupts = <6 10 IRQ_TYPE_LEVEL_LOW>; /* PG10 / EINT10 */
> +               interrupt-names = "host-wake";
> +       };
> +};
> +
> +&uart0 {
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&uart0_pa_pins>;
> +       status = "okay";
> +};
> +
> +&uart2 {
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&uart2_pins>, <&uart2_rts_cts_pins>;
> +       uart-has-rtscts;
> +       status = "okay";
> +
> +       bluetooth {
> +               compatible = "brcm,bcm43438-bt";
> +               //clocks = <&osc32k 1>;
> +               clocks = <&rtc 1>; // this is what bananapi-m2-zero does, and it has same schematic...

Yes, this is the correct setup. The module is taking the clock from
the X32KFOUT on the SoC.
This is an external output from the RTC module.

> +               clock-names = "lpo";
> +
> +               // these are both fine..
> +               vbat-supply = <&reg_vcc3v3>;
> +               vddio-supply = <&reg_vcc3v3>;
> +               // on opi-win, device-wakup is pl6 is AP-WAKE-BT is module pin 6, bt-wake.
> +               // YES; PA8 is correct.
> +               device-wakeup-gpios = <&pio 0 8 GPIO_ACTIVE_HIGH>; /* PA8 */
> +
> +               // on opi-win, hostwakeup (pl5) is bt-wake-ap is module pin 7, bt-host-wake
> +               // YES; PA7 is correct
> +               host-wakeup-gpios = <&pio 0 7 GPIO_ACTIVE_HIGH>; /* PA7 */
> +
> +               // on opi-win, shutdown is pl4, is BT-RST-N is moduel pin 34
> +               // YES; PG13 is correct.

I'm guessing all these comments are from your development cycle? Please
remove them.

> +               shutdown-gpios = <&pio 6 13 GPIO_ACTIVE_HIGH>; /* PG13 */
> +       };
> +};

The board also has SPI flash. Can you add that as well?


Thanks
ChenYu

> --
> 2.20.1
>
