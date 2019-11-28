Return-Path: <SRS0=QHyQ=ZU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10C56C43215
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 00:46:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D966C215F1
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 00:46:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=jms.id.au header.i=@jms.id.au header.b="JW2HM0d3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727262AbfK1AqK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 19:46:10 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:43723 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726947AbfK1AqJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 19:46:09 -0500
Received: by mail-qt1-f194.google.com with SMTP id q8so24664788qtr.10;
        Wed, 27 Nov 2019 16:46:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aJeoqcmKSSQvMjifG41URfXpoPD2I45j8yZ0E+rYsGo=;
        b=JW2HM0d38B3YxpLDeP3VdWE5jC1VN+rWirnpsjbm7P1MG3Qvquz6yXZNb/VcCji6uh
         B0aao0fYaU+rr3A/SmPrwOt9WA4bI5NBrlIQPqK5v/EKfh9j48phG2kk7fcK0d1D+Blm
         UhV3sq6Z0f1FOKVWceulCSq6/F+rQ/sWTigVk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aJeoqcmKSSQvMjifG41URfXpoPD2I45j8yZ0E+rYsGo=;
        b=NiciWzvKwnhMRUu9iuuZhBCQ0xM6ga1G5Er94uZoHZNP1PUMIleQAKLj2fiQB5yTHV
         ARQ00uz/xjfxRmPvqoI4WRaC8kSiIaxox+Q6FIkniY8k6GpJUPIWbmThpynqw2GwAVAU
         lkqtcKysALyM4aNrXJqTSXfTmtBA7Yg8gqA1LxhMnbtLH1Ysr4HOHetVk5TayoPBP4aM
         wmmNDdj7WkNdGTevXO/djVm/qNJ214wErNJO0AcsVJI84zpkSFUAkb6pooLnJO2Dr3XW
         p+bicQKxPWNdcP0KhCBTyIkqMhPa0WqTn0zPIrP7/gssNYwDGSLq/MEDe3mRRVnbmyX3
         +z6Q==
X-Gm-Message-State: APjAAAVIWaofWjtK3DjTS0CuV2Do31u1tjpbPJY+yngip3gu3Wkkir7h
        SV2cUymD4XJMwJEwQvTGEp9ch6eA4U84RnRrQPw=
X-Google-Smtp-Source: APXvYqwHl9cUPcDab0I8y61KT4zfdU3MEvfmMOQHLFg4tSI+jEGYfr73nyiTucDoGr+hQ7JGvoonYex7C6ghTlEKCJM=
X-Received: by 2002:ac8:167c:: with SMTP id x57mr28046701qtk.255.1574901968058;
 Wed, 27 Nov 2019 16:46:08 -0800 (PST)
MIME-Version: 1.0
References: <20191127060747.GA30829@cnn>
In-Reply-To: <20191127060747.GA30829@cnn>
From:   Joel Stanley <joel@jms.id.au>
Date:   Thu, 28 Nov 2019 00:45:56 +0000
Message-ID: <CACPK8Xc4jw_gPqbTZ5tbSBUD0NF3_aRk+aCbGDZBye3CF+n=rg@mail.gmail.com>
Subject: Re: [PATCH v4] ARM: dts: aspeed: Adding Facebook Yosemite V2 BMC
To:     manikandan-e <manikandan.hcl.ers.epl@gmail.com>
Cc:     Vijay Khemka <vijaykhemka@fb.com>,
        Andrew Jeffery <andrew@aj.id.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-aspeed <linux-aspeed@lists.ozlabs.org>,
        manikandan.e@hcl.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Nov 2019 at 06:07, manikandan-e
<manikandan.hcl.ers.epl@gmail.com> wrote:
>
> The Yosemite V2 is a facebook multi-node server
> platform that host four OCP server. The BMC
> in the Yosemite V2 platorm based on AST2500 SoC.

spelling: platform

>
> This patch adds linux device tree entry related to
> Yosemite V2 specific devices connected to BMC SoC.
>
> Signed-off-by: manikandan-e <manikandan.hcl.ers.epl@gmail.com>

Please see this:

 https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst#n418

 > then you just add a line saying:
 >
 > Signed-off-by: Random J Developer <random@developer.example.org>
 >
 > using your real name (sorry, no pseudonyms or anonymous contributions.)

Can you make sure you've got your real name there? You can make this
global with:

 > git config --global user.name "Random J Developer"
 > git commit --amend --reset-author


> ---
>  .../boot/dts/aspeed-bmc-facebook-yosemitev2.dts    | 150 +++++++++++++++++++++
>  1 file changed, 150 insertions(+)
>  create mode 100644 arch/arm/boot/dts/aspeed-bmc-facebook-yosemitev2.dts
>
> diff --git a/arch/arm/boot/dts/aspeed-bmc-facebook-yosemitev2.dts b/arch/arm/boot/dts/aspeed-bmc-facebook-yosemitev2.dts
> new file mode 100644
> index 0000000..44e2b17
> --- /dev/null
> +++ b/arch/arm/boot/dts/aspeed-bmc-facebook-yosemitev2.dts
> @@ -0,0 +1,150 @@
> +// SPDX-License-Identifier: GPL-2.0+

The kernel prefers this to be spelt "GPL-2.0-or-later"

> +// Copyright (c) 2018 Facebook Inc.
> +/dts-v1/;
> +
> +#include "aspeed-g5.dtsi"
> +#include <dt-bindings/gpio/aspeed-gpio.h>
> +
> +/ {
> +       model = "Facebook Yosemitev2 BMC";
> +       compatible = "facebook,yosemitev2-bmc", "aspeed,ast2500";
> +       aliases {
> +               serial4 = &uart5;
> +       };
> +       chosen {
> +               stdout-path = &uart5;
> +       };
> +
> +       memory@80000000 {
> +               reg = <0x80000000 0x20000000>;
> +       };
> +
> +       iio-hwmon {
> +               // VOLATAGE SENSOR
> +               compatible = "iio-hwmon";
> +               io-channels = <&adc 0> , <&adc 1> , <&adc 2> ,  <&adc 3> ,
> +               <&adc 4> , <&adc 5> , <&adc 6> ,  <&adc 7> ,
> +               <&adc 8> , <&adc 9> , <&adc 10>, <&adc 11> ,
> +               <&adc 12> , <&adc 13> , <&adc 14> , <&adc 15> ;
> +       };
> +};
> +
> +&fmc {
> +       status = "okay";
> +       flash@0 {
> +               status = "okay";
> +               m25p,fast-read;
> +#include "openbmc-flash-layout.dtsi"
> +       };
> +};
> +
> +&spi1 {
> +       status = "okay";
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&pinctrl_spi1_default>;
> +       flash@0 {
> +               status = "okay";
> +               m25p,fast-read;
> +               label = "pnor";
> +       };
> +};
> +
> +&uart5 {
> +       // BMC Console
> +       status = "okay";
> +};
> +
> +&mac0 {
> +       status = "okay";
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&pinctrl_rmii1_default>;
> +       use-ncsi;
> +};
> +
> +&adc {
> +       status = "okay";
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&pinctrl_adc0_default
> +                       &pinctrl_adc1_default
> +                       &pinctrl_adc2_default
> +                       &pinctrl_adc3_default
> +                       &pinctrl_adc4_default
> +                       &pinctrl_adc5_default
> +                       &pinctrl_adc6_default
> +                       &pinctrl_adc7_default
> +                       &pinctrl_adc8_default
> +                       &pinctrl_adc9_default
> +                       &pinctrl_adc10_default
> +                       &pinctrl_adc11_default
> +                       &pinctrl_adc12_default
> +                       &pinctrl_adc13_default
> +                       &pinctrl_adc14_default
> +                       &pinctrl_adc15_default>;
> +};
> +
> +&i2c8 {
> +       status = "okay";
> +       //FRU EEPROM
> +       eeprom@51 {
> +               compatible = "atmel,24c64";
> +               reg = <0x51>;
> +               pagesize = <32>;
> +       };
> +};
> +
> +&i2c9 {
> +       status = "okay";
> +       tmp421@4e {
> +       //INLET TEMP

Make this consistent by putting it one line up.

> +               compatible = "ti,tmp421";
> +               reg = <0x4e>;
> +       };
> +       //OUTLET TEMP
> +       tmp421@4f {
> +               compatible = "ti,tmp421";
> +               reg = <0x4f>;
> +       };
> +};
> +
> +&i2c10 {
> +       status = "okay";
> +       //HSC
> +       adm1278@40 {
> +               compatible = "adi,adm1278";
> +               reg = <0x40>;
> +       };
> +};
> +
> +&i2c11 {
> +       status = "okay";
> +       //MEZZ_TEMP_SENSOR
> +       tmp421@1f {
> +               compatible = "ti,tmp421";
> +               reg = <0x1f>;
> +       };
> +};
> +
> +&i2c12 {
> +       status = "okay";
> +       //MEZZ_FRU
> +       eeprom@51 {
> +               compatible = "atmel,24c64";
> +               reg = <0x51>;
> +               pagesize = <32>;
> +       };
> +};
> +
> +&pwm_tacho {
> +       status = "okay";
> +       //FSC
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&pinctrl_pwm0_default &pinctrl_pwm1_default>;
> +       fan@0 {
> +               reg = <0x00>;
> +               aspeed,fan-tach-ch = /bits/ 8 <0x00>;
> +       };
> +       fan@1 {
> +               reg = <0x01>;
> +               aspeed,fan-tach-ch = /bits/ 8 <0x02>;
> +       };
> +};
> --
> 2.7.4
>
