Return-Path: <SRS0=TDlZ=Y2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30071CA9EC7
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Nov 2019 16:11:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 040822080F
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Nov 2019 16:11:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726950AbfKBQLd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Nov 2019 12:11:33 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:40696 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726387AbfKBQLc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Nov 2019 12:11:32 -0400
Received: by mail-ed1-f66.google.com with SMTP id p59so9753043edp.7
        for <linux-kernel@vger.kernel.org>; Sat, 02 Nov 2019 09:11:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KFow89QyKCB2iUuNfpuKCtlkTyh/+skrIFNEolrPo5Y=;
        b=FAFReOxU98bQ/+141yimueel08efEmhiLiaLkTtGqpNUxe3MDdkry+Fk39P5Csg77+
         W81/i+MI1qQySyJ3dzxdLEeG6QPJ3aKK0UsswYbnfFVFWAZwqny2g9Bzx0GtWKfDd5HI
         XI87+yG6mt2HVuv1AvJx0/mDUMfdTAxdEzpMQfPg75SDr944gOdNBUUhTMo0yZCarDmA
         GklMh16tZ05a08eH1grDLPe4bn7nNbPs5om//6lv0kaXpdZzDgxnctpyriid6LfoQVdJ
         EMvX8PQ2FUl+4zfymLibx1Y56oXakOkaT2EJPqyoadXxFT4rm3qzvJSGxRx1EysM5xVx
         Nexw==
X-Gm-Message-State: APjAAAXHksSA2vi0UK7dXiT8IUrjTFnYPdRBkioUKYGSNYfmEJnPkaPA
        2ZBTAw5LQetJyjD5vI11vlAv2JV44gM=
X-Google-Smtp-Source: APXvYqxAWM4mvZDbyYeaHA5mCsb/1C9deZzboOgkEJzIZoCmdMQG+gX1STp+6wVmp7j8RysexJg8tg==
X-Received: by 2002:aa7:d0c9:: with SMTP id u9mr19128534edo.217.1572711089092;
        Sat, 02 Nov 2019 09:11:29 -0700 (PDT)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com. [209.85.128.44])
        by smtp.gmail.com with ESMTPSA id bu9sm309835edb.64.2019.11.02.09.11.28
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 02 Nov 2019 09:11:28 -0700 (PDT)
Received: by mail-wm1-f44.google.com with SMTP id f3so798082wmc.5
        for <linux-kernel@vger.kernel.org>; Sat, 02 Nov 2019 09:11:28 -0700 (PDT)
X-Received: by 2002:a7b:caa9:: with SMTP id r9mr15035191wml.47.1572711088345;
 Sat, 02 Nov 2019 09:11:28 -0700 (PDT)
MIME-Version: 1.0
References: <20191101205535.7896-1-karlp@tweak.net.au>
In-Reply-To: <20191101205535.7896-1-karlp@tweak.net.au>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Sun, 3 Nov 2019 00:11:17 +0800
X-Gmail-Original-Message-ID: <CAGb2v66kSw4d787OGLbiusWv=iVPNtMsXyFNB7NQiCgXS85fEA@mail.gmail.com>
Message-ID: <CAGb2v66kSw4d787OGLbiusWv=iVPNtMsXyFNB7NQiCgXS85fEA@mail.gmail.com>
Subject: Re: [PATCHv2 1/2] ARM: dts: sun8i: add FriendlyARM NanoPi Duo2
To:     Karl Palsson <karlp@tweak.net.au>
Cc:     Maxime Ripard <mripard@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 2, 2019 at 4:56 AM Karl Palsson <karlp@tweak.net.au> wrote:
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
> Change since v1:
> * dropped accidental commentary
> * sorted nodes
> * added enable gpio for vdd-cpu
> * added vdd-dram and vcc-sys
> * dropped default led trigger
>
>  arch/arm/boot/dts/Makefile                 |   1 +
>  arch/arm/boot/dts/sun8i-h3-nanopi-duo2.dts | 174 +++++++++++++++++++++
>  2 files changed, 175 insertions(+)
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
> index 000000000000..c73f59900975
> --- /dev/null
> +++ b/arch/arm/boot/dts/sun8i-h3-nanopi-duo2.dts
> @@ -0,0 +1,174 @@
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
> +               pwr {
> +                       label = "nanopi:red:pwr";
> +                       gpios = <&r_pio 0 10 GPIO_ACTIVE_HIGH>; /* PL10 */
> +                       default-state = "on";
> +               };
> +
> +               status {
> +                       label = "nanopi:green:status";
> +                       gpios = <&pio 0 10 GPIO_ACTIVE_HIGH>; /* PA10 */
> +               };
> +       };
> +
> +       r_gpio_keys {
> +               compatible = "gpio-keys";
> +
> +               k1 {
> +                       label = "k1";
> +                       linux,code = <BTN_0>;
> +                       gpios = <&r_pio 0 3 GPIO_ACTIVE_LOW>; /* PL3 */
> +               };
> +       };
> +
> +       reg_vdd_cpux: vdd-cpux-regulator {
> +               compatible = "regulator-gpio";
> +               regulator-name = "vdd-cpux";
> +               regulator-min-microvolt = <1100000>;
> +               regulator-max-microvolt = <1300000>;
> +               regulator-always-on;
> +               regulator-boot-on;
> +               regulator-ramp-delay = <50>; /* 4ms */
> +
> +               enable-active-high;
> +               enable-gpio = <&r_pio 0 8 GPIO_ACTIVE_HIGH>; /* PL8 */
> +               gpios = <&r_pio 0 6 GPIO_ACTIVE_HIGH>; /* PL6 */
> +               gpios-states = <0x1>;
> +               states = <1100000 0x0
> +                         1300000 0x1>;
> +       };
> +
> +       reg_vcc_dram: vcc-dram {

This regulator and the next don't have -regulator in their node name,
unlike vdd-cpux-regulator above.

Other than that, this patch looks good to go.

ChenYu

> +               compatible = "regulator-fixed";
> +               regulator-name = "vcc-dram";
> +               regulator-min-microvolt = <1500000>;
> +               regulator-max-microvolt = <1500000>;
> +               regulator-always-on;
> +               regulator-boot-on;
> +               enable-active-high;
> +               gpio = <&r_pio 0 9 GPIO_ACTIVE_HIGH>; /* PL9 */
> +               vin-supply = <&reg_vcc5v0>;
> +        };
> +
> +       reg_vdd_sys: vdd-sys {
> +               compatible = "regulator-fixed";
> +               regulator-name = "vdd-sys";
> +               regulator-min-microvolt = <1200000>;
> +               regulator-max-microvolt = <1200000>;
> +               regulator-always-on;
> +               regulator-boot-on;
> +               enable-active-high;
> +               gpio = <&r_pio 0 8 GPIO_ACTIVE_HIGH>; /* PL8 */
> +               vin-supply = <&reg_vcc5v0>;
> +        };
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
> +&ehci0 {
> +       status = "okay";
> +};
> +
> +&mmc0 {
> +       bus-width = <4>;
> +       cd-gpios = <&pio 5 6 GPIO_ACTIVE_LOW>; /* PF6 */
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
> +&ohci0 {
> +       status = "okay";
> +};
> +
> +&reg_usb0_vbus {
> +       gpio = <&r_pio 0 2 GPIO_ACTIVE_HIGH>; /* PL2 */
> +       status = "okay";
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
> +               clocks = <&rtc 1>;
> +               clock-names = "lpo";
> +               vbat-supply = <&reg_vcc3v3>;
> +               vddio-supply = <&reg_vcc3v3>;
> +               device-wakeup-gpios = <&pio 0 8 GPIO_ACTIVE_HIGH>; /* PA8 */
> +               host-wakeup-gpios = <&pio 0 7 GPIO_ACTIVE_HIGH>; /* PA7 */
> +               shutdown-gpios = <&pio 6 13 GPIO_ACTIVE_HIGH>; /* PG13 */
> +       };
> +};
> +
> +&usb_otg {
> +       status = "okay";
> +       dr_mode = "otg";
> +};
> +
> +&usbphy {
> +       usb0_id_det-gpios = <&pio 6 12 GPIO_ACTIVE_HIGH>; /* PG12 */
> +       usb0_vbus-supply = <&reg_usb0_vbus>;
> +       status = "okay";
> +};
> --
> 2.20.1
>
