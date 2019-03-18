Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43618C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 15:15:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1992C2085A
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 15:15:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727304AbfCRPPg convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 11:15:36 -0400
Received: from hermes.aosc.io ([199.195.250.187]:43785 "EHLO hermes.aosc.io"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726806AbfCRPPf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 11:15:35 -0400
Received: from localhost (localhost [127.0.0.1]) (Authenticated sender: icenowy@aosc.io)
        by hermes.aosc.io (Postfix) with ESMTPSA id 51FA76BFF3;
        Mon, 18 Mar 2019 15:15:26 +0000 (UTC)
Date:   Mon, 18 Mar 2019 23:15:18 +0800
In-Reply-To: <ea4f86798466bd9680f064f663a50450452509bc.camel@bootlin.com>
References: <20190312152256.35574-1-icenowy@aosc.io> <20190312152256.35574-12-icenowy@aosc.io> <ea4f86798466bd9680f064f663a50450452509bc.camel@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8BIT
Subject: Re: [linux-sunxi] [PATCH 11/14] ARM: sunxi: dts: s3/s3l/v3: add DTSI files for S3/S3L/V3 SoCs
To:     linux-arm-kernel@lists.infradead.org,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Jagan Teki <jagan@amarulasolutions.com>
CC:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-sunxi@googlegroups.com,
        linux-clk@vger.kernel.org
From:   Icenowy Zheng <icenowy@aosc.io>
Message-ID: <86A3A1C2-323E-439D-9615-530E2AD9E199@aosc.io>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



于 2019年3月18日 GMT+08:00 下午8:41:32, Paul Kocialkowski <paul.kocialkowski@bootlin.com> 写到:
>Hi,
>
>Le mardi 12 mars 2019 à 23:22 +0800, Icenowy Zheng a écrit :
>> The Allwinner S3/S3L/V3 SoCs all share the same die with the V3s SoC,
>> but with more GPIO wired out of the package.
>> 
>> Add DTSI files for these SoCs. The DTSI file for V3 just replaces the
>> pinctrl compatible string, and the S3/S3L DTSI files just include the
>V3
>> DTSI file.
>
>Note that the V3 has a NMI controller at 1c000d0, that is required for
>handling the AXP209 interrupts IIRQ. I have no idea whether it's also
>the case on the V3s/S3/S3L though but it would be good to know.

It's not mentioned on the datasheet.

If it's present, please send a patch.

BTW all V3 series chip share the same die (sun8iw8).

Thanks

>
>Note that I can totally add support for it when adding support for my
>V3 device that uses the AXP209 this way.
>
>Also, could we get proper compatibles and config options for these new
>SoCs, since they are distinct from the V3S?
>
>Cheers,
>
>Paul
>
>> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
>> ---
>>  arch/arm/boot/dts/sun8i-s3.dtsi  |  6 ++++++
>>  arch/arm/boot/dts/sun8i-s3l.dtsi |  6 ++++++
>>  arch/arm/boot/dts/sun8i-v3.dtsi  | 14 ++++++++++++++
>>  3 files changed, 26 insertions(+)
>>  create mode 100644 arch/arm/boot/dts/sun8i-s3.dtsi
>>  create mode 100644 arch/arm/boot/dts/sun8i-s3l.dtsi
>>  create mode 100644 arch/arm/boot/dts/sun8i-v3.dtsi
>> 
>> diff --git a/arch/arm/boot/dts/sun8i-s3.dtsi
>b/arch/arm/boot/dts/sun8i-s3.dtsi
>> new file mode 100644
>> index 000000000000..0f41a25ecb30
>> --- /dev/null
>> +++ b/arch/arm/boot/dts/sun8i-s3.dtsi
>> @@ -0,0 +1,6 @@
>> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
>> +/*
>> + * Copyright (C) 2019 Icenowy Zheng <icenowy@aosc.io>
>> + */
>> +
>> +#include "sun8i-v3.dtsi"
>> diff --git a/arch/arm/boot/dts/sun8i-s3l.dtsi
>b/arch/arm/boot/dts/sun8i-s3l.dtsi
>> new file mode 100644
>> index 000000000000..0f41a25ecb30
>> --- /dev/null
>> +++ b/arch/arm/boot/dts/sun8i-s3l.dtsi
>> @@ -0,0 +1,6 @@
>> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
>> +/*
>> + * Copyright (C) 2019 Icenowy Zheng <icenowy@aosc.io>
>> + */
>> +
>> +#include "sun8i-v3.dtsi"
>> diff --git a/arch/arm/boot/dts/sun8i-v3.dtsi
>b/arch/arm/boot/dts/sun8i-v3.dtsi
>> new file mode 100644
>> index 000000000000..6ae8645ade50
>> --- /dev/null
>> +++ b/arch/arm/boot/dts/sun8i-v3.dtsi
>> @@ -0,0 +1,14 @@
>> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
>> +/*
>> + * Copyright (C) 2019 Icenowy Zheng <icenowy@aosc.io>
>> + */
>> +
>> +#include "sun8i-v3s.dtsi"
>> +
>> +&ccu {
>> +	compatible = "allwinner,sun8i-v3-ccu";
>> +};
>> +
>> +&pio {
>> +	compatible = "allwinner,sun8i-v3-pinctrl";
>> +};
>> -- 
>> 2.18.1
>> 
>-- 
>Paul Kocialkowski, Bootlin
>Embedded Linux and kernel engineering
>https://bootlin.com
>
>
>_______________________________________________
>linux-arm-kernel mailing list
>linux-arm-kernel@lists.infradead.org
>http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

-- 
使用 K-9 Mail 发送自我的Android设备。
