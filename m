Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 613EEC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 19:18:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D51E20811
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 19:18:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553800720;
	bh=f2ji7CVfytWBk37WbP0EbCRpcyaKhvnEsIfc+5kEh4w=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=lHmzzzwYAhwqnsswHx1QaZQw6mnyx7OKJxcoWgbbZb8DTPpOY7vUEjGhlpNo1Xj7B
	 xzcnbFomYZqzUDO2y//3fsnWaFYnK8HdrqXdhrqfF9Mp87kGfChrNvQLHxcwdsnjpA
	 Igfcein6JUBspKC0m1ry4I+hE++UrI2SPT5EP3vE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726375AbfC1TSj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 15:18:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:51756 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725828AbfC1TSi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 15:18:38 -0400
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CD54421850;
        Thu, 28 Mar 2019 19:18:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553800716;
        bh=f2ji7CVfytWBk37WbP0EbCRpcyaKhvnEsIfc+5kEh4w=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=2twr3E5rkYrQDEKKkP4pslbmLhC58Incr6HAaBYRkDhudfnS2TEEMt+en7zGZqP+G
         rpV7EDYQqVRfnZ27RYpuVssEUVuLuyMEzjZNBbU5u8XOTQWQgPs+YpyzcRQe3qo5rN
         aQNbxprBPn+QhD/LPezbh8KK1UDPUNO63Rz9mzPI=
Received: by mail-qt1-f174.google.com with SMTP id w5so24425508qtb.11;
        Thu, 28 Mar 2019 12:18:35 -0700 (PDT)
X-Gm-Message-State: APjAAAVroS1Qgp6doWsVj/VzYeStgr+YTSM6Fp3Pp+5oel1FVpGokRab
        /EV8ZsoRH+Kl6lfWhiIzOkuazMz3IbTpS2piaA==
X-Google-Smtp-Source: APXvYqwrhDy5nQn/wGlVX1Wk959GiBJT3M/q//wbyVP1mE0yuhqcRHk2psgN3r5631QIz6slN3zVgcbRT5pLNxPDHvU=
X-Received: by 2002:ac8:267c:: with SMTP id v57mr36980294qtv.76.1553800715059;
 Thu, 28 Mar 2019 12:18:35 -0700 (PDT)
MIME-Version: 1.0
References: <20190323211612.860-1-fparent@baylibre.com> <20190323211612.860-8-fparent@baylibre.com>
In-Reply-To: <20190323211612.860-8-fparent@baylibre.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Thu, 28 Mar 2019 14:18:23 -0500
X-Gmail-Original-Message-ID: <CAL_JsqLN9+NeCjYcuiACtpxqsTzttemaLt=L9fkXH+EjiC4rdA@mail.gmail.com>
Message-ID: <CAL_JsqLN9+NeCjYcuiACtpxqsTzttemaLt=L9fkXH+EjiC4rdA@mail.gmail.com>
Subject: Re: [PATCH 07/24] arm64: dts: mt6392: Add PMIC mt6392 dtsi
To:     Fabien Parent <fparent@baylibre.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Sean Wang <sean.wang@kernel.org>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>,
        Wenzhen Yu <wenzhen.yu@mediatek.com>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        Yong Mao <yong.mao@mediatek.com>, jjian.zhou@mediatek.com,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux I2C <linux-i2c@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        LINUX-WATCHDOG <linux-watchdog@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        stephane.leprovost@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 23, 2019 at 4:16 PM Fabien Parent <fparent@baylibre.com> wrote:
>
> Add the regulator nodes for the MT6392 PMIC.
>
> Signed-off-by: Fabien Parent <fparent@baylibre.com>
> ---
>  arch/arm64/boot/dts/mediatek/mt6392.dtsi | 208 +++++++++++++++++++++++
>  1 file changed, 208 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/mediatek/mt6392.dtsi
>
> diff --git a/arch/arm64/boot/dts/mediatek/mt6392.dtsi b/arch/arm64/boot/dts/mediatek/mt6392.dtsi
> new file mode 100644
> index 000000000000..e33a45fd52af
> --- /dev/null
> +++ b/arch/arm64/boot/dts/mediatek/mt6392.dtsi
> @@ -0,0 +1,208 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2019 MediaTek Inc.
> + */
> +
> +&pwrap {
> +       pmic: mt6392 {

Same comments in binding example apply here.

> +               compatible = "mediatek,mt6392", "mediatek,mt6323";
> +               mediatek,system-power-controller;
> +
> +               mt6392_regulator: mt6392_regulator {
> +                       compatible = "mediatek,mt6392-regulator";
> +
> +                       mt6392_vproc_reg: buck_vproc {
> +                               regulator-name = "buck_vproc";
> +                               regulator-min-microvolt = < 700000>;
> +                               regulator-max-microvolt = <1350000>;
> +                               regulator-ramp-delay = <12500>;
> +                               regulator-always-on;
> +                               regulator-boot-on;
> +                       };
> +
> +                       mt6392_vsys_reg: buck_vsys {
> +                               regulator-name = "buck_vsys";
> +                               regulator-min-microvolt = <1400000>;
> +                               regulator-max-microvolt = <2987500>;
> +                               regulator-ramp-delay = <25000>;
> +                               regulator-always-on;
> +                               regulator-boot-on;
> +                       };
> +
> +                       mt6392_vcore_reg: buck_vcore {
> +                               regulator-name = "buck_vcore";
> +                               regulator-min-microvolt = < 700000>;
> +                               regulator-max-microvolt = <1350000>;
> +                               regulator-ramp-delay = <12500>;
> +                               regulator-always-on;
> +                               regulator-boot-on;
> +                       };
> +
> +                       mt6392_vxo22_reg: ldo_vxo22 {
> +                               regulator-name = "ldo_vxo22";
> +                               regulator-min-microvolt = <2200000>;
> +                               regulator-max-microvolt = <2200000>;
> +                               regulator-enable-ramp-delay = <110>;
> +                               regulator-always-on;
> +                               regulator-boot-on;
> +                       };
> +
> +                       mt6392_vaud22_reg: ldo_vaud22 {
> +                               regulator-name = "ldo_vaud22";
> +                               regulator-min-microvolt = <1800000>;
> +                               regulator-max-microvolt = <2200000>;
> +                               regulator-enable-ramp-delay = <264>;
> +                               regulator-always-on;
> +                               regulator-boot-on;
> +                       };
> +
> +                       mt6392_vcama_reg: ldo_vcama {
> +                               regulator-name = "ldo_vcama";
> +                               regulator-min-microvolt = <2800000>;
> +                               regulator-max-microvolt = <2800000>;
> +                               regulator-enable-ramp-delay = <264>;
> +                       };
> +
> +                       mt6392_vaud28_reg: ldo_vaud28 {
> +                               regulator-name = "ldo_vaud28";
> +                               regulator-min-microvolt = <2800000>;
> +                               regulator-max-microvolt = <2800000>;
> +                               regulator-enable-ramp-delay = <264>;
> +                               regulator-always-on;
> +                               regulator-boot-on;
> +                       };
> +
> +                       mt6392_vadc18_reg: ldo_vadc18 {
> +                               regulator-name = "ldo_vadc18";
> +                               regulator-min-microvolt = <1800000>;
> +                               regulator-max-microvolt = <1800000>;
> +                               regulator-enable-ramp-delay = <264>;
> +                               regulator-always-on;
> +                               regulator-boot-on;
> +                       };
> +
> +                       mt6392_vcn35_reg: ldo_vcn35 {
> +                               regulator-name = "ldo_vcn35";
> +                               regulator-min-microvolt = <3300000>;
> +                               regulator-max-microvolt = <3600000>;
> +                               regulator-enable-ramp-delay = <264>;
> +                       };
> +
> +                       mt6392_vio28_reg: ldo_vio28 {
> +                               regulator-name = "ldo_vio28";
> +                               regulator-min-microvolt = <2800000>;
> +                               regulator-max-microvolt = <2800000>;
> +                               regulator-enable-ramp-delay = <264>;
> +                               regulator-always-on;
> +                               regulator-boot-on;
> +                       };
> +
> +                       mt6392_vusb_reg: ldo_vusb {
> +                               regulator-name = "ldo_vusb";
> +                               regulator-min-microvolt = <3300000>;
> +                               regulator-max-microvolt = <3300000>;
> +                               regulator-enable-ramp-delay = <264>;
> +                               regulator-always-on;
> +                               regulator-boot-on;
> +                       };
> +
> +                       mt6392_vmc_reg: ldo_vmc {
> +                               regulator-name = "ldo_vmc";
> +                               regulator-min-microvolt = <1800000>;
> +                               regulator-max-microvolt = <3300000>;
> +                               regulator-enable-ramp-delay = <264>;
> +                               regulator-boot-on;
> +                       };
> +
> +                       mt6392_vmch_reg: ldo_vmch {
> +                               regulator-name = "ldo_vmch";
> +                               regulator-min-microvolt = <3000000>;
> +                               regulator-max-microvolt = <3300000>;
> +                               regulator-enable-ramp-delay = <264>;
> +                               regulator-boot-on;
> +                       };
> +
> +                       mt6392_vemc3v3_reg: ldo_vemc3v3 {
> +                               regulator-name = "ldo_vemc3v3";
> +                               regulator-min-microvolt = <3000000>;
> +                               regulator-max-microvolt = <3300000>;
> +                               regulator-enable-ramp-delay = <264>;
> +                               regulator-boot-on;
> +                       };
> +
> +                       mt6392_vgp1_reg: ldo_vgp1 {
> +                               regulator-name = "ldo_vgp1";
> +                               regulator-min-microvolt = <1200000>;
> +                               regulator-max-microvolt = <3300000>;
> +                               regulator-enable-ramp-delay = <264>;
> +                       };
> +
> +                       mt6392_vgp2_reg: ldo_vgp2 {
> +                               regulator-name = "ldo_vgp2";
> +                               regulator-min-microvolt = <1200000>;
> +                               regulator-max-microvolt = <3300000>;
> +                               regulator-enable-ramp-delay = <264>;
> +                       };
> +
> +                       mt6392_vcn18_reg: ldo_vcn18 {
> +                               regulator-name = "ldo_vcn18";
> +                               regulator-min-microvolt = <1800000>;
> +                               regulator-max-microvolt = <1800000>;
> +                               regulator-enable-ramp-delay = <264>;
> +                       };
> +
> +                       mt6392_vcamaf_reg: ldo_vcamaf {
> +                               regulator-name = "ldo_vcamaf";
> +                               regulator-min-microvolt = <1200000>;
> +                               regulator-max-microvolt = <3300000>;
> +                               regulator-enable-ramp-delay = <264>;
> +                       };
> +
> +                       mt6392_vm_reg: ldo_vm {
> +                               regulator-name = "ldo_vm";
> +                               regulator-min-microvolt = <1240000>;
> +                               regulator-max-microvolt = <1390000>;
> +                               regulator-enable-ramp-delay = <264>;
> +                               regulator-always-on;
> +                               regulator-boot-on;
> +                       };
> +
> +                       mt6392_vio18_reg: ldo_vio18 {
> +                               regulator-name = "ldo_vio18";
> +                               regulator-min-microvolt = <1800000>;
> +                               regulator-max-microvolt = <1800000>;
> +                               regulator-enable-ramp-delay = <264>;
> +                               regulator-always-on;
> +                               regulator-boot-on;
> +                       };
> +
> +                       mt6392_vcamd_reg: ldo_vcamd {
> +                               regulator-name = "ldo_vcamd";
> +                               regulator-min-microvolt = <1200000>;
> +                               regulator-max-microvolt = <1800000>;
> +                               regulator-enable-ramp-delay = <264>;
> +                       };
> +
> +                       mt6392_vcamio_reg: ldo_vcamio {
> +                               regulator-name = "ldo_vcamio";
> +                               regulator-min-microvolt = <1800000>;
> +                               regulator-max-microvolt = <1800000>;
> +                               regulator-enable-ramp-delay = <264>;
> +                       };
> +
> +                       mt6392_vm25_reg: ldo_vm25 {
> +                               regulator-name = "ldo_vm25";
> +                               regulator-min-microvolt = <2500000>;
> +                               regulator-max-microvolt = <2500000>;
> +                               regulator-enable-ramp-delay = <264>;
> +                       };
> +
> +                       mt6392_vefuse_reg: ldo_vefuse {
> +                               regulator-name = "ldo_vefuse";
> +                               regulator-min-microvolt = <1800000>;
> +                               regulator-max-microvolt = <2000000>;
> +                               regulator-enable-ramp-delay = <264>;
> +                       };
> +               };
> +       };
> +};
> --
> 2.20.1
>
