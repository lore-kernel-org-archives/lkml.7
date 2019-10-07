Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 746BBC47404
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 10:42:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5368A2070B
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 10:42:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727668AbfJGKmv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 06:42:51 -0400
Received: from mail-out.m-online.net ([212.18.0.10]:46720 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727252AbfJGKmv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 06:42:51 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 46mxrl2qpYz1rpwC;
        Mon,  7 Oct 2019 12:42:47 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 46mxrl1c40z1qqkC;
        Mon,  7 Oct 2019 12:42:47 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id 1rb2Z0aqgA5u; Mon,  7 Oct 2019 12:42:45 +0200 (CEST)
X-Auth-Info: I9YYeUNrKjVrdUUDAQTC/Y0aiMCFlFUVIzRUFRXKK/0=
Received: from antares.denx.de (unknown [62.91.23.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Mon,  7 Oct 2019 12:42:45 +0200 (CEST)
Cc:     pn@denx.de, robh+dt@kernel.org, mark.rutland@arm.com,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: imx6: Extend support for Phytec phycore
 i.MX6ULL SoM
To:     Shawn Guo <shawnguo@kernel.org>
References: <20190912202928.946200-1-pn@denx.de>
 <20191006082349.GA7150@dragon>
From:   Parthiban Nallathambi <pn@denx.de>
Message-ID: <3c92e681-3b7b-fedf-48bc-cfb2080c3f12@denx.de>
Date:   Mon, 7 Oct 2019 12:42:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191006082349.GA7150@dragon>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/6/19 10:23 AM, Shawn Guo wrote:
> On Thu, Sep 12, 2019 at 10:29:28PM +0200, Parthiban Nallathambi wrote:
>> Extend Phycore i.MX6UL SoM for i.MX6ULL with on board eMMC. Phycore
>> i.MX6ULL is deployed with same carrier board Segin as the pins are
>> compatible with UL version.
>>
>> Signed-off-by: Parthiban Nallathambi <pn@denx.de>
> 
> What is the base that the patch was generated from?  It doesn't apply to
> my tree.

It was based on prior to 5.4 merge window. But there are series of patch
which renamed the filename and the changes are already part of mainline
from Phytec.

Please ignore this patch.

Thanks,
Parthiban N

> 
> Shawn
> 
>> ---
>>   arch/arm/boot/dts/imx6ul-phytec-pcl063.dtsi   | 26 +++++++++++++++++--
>>   .../dts/imx6ul-phytec-phyboard-segin-full.dts |  5 ++++
>>   arch/arm/boot/dts/imx6ull-phytec-pcl063.dtsi  | 24 +++++++++++++++++
>>   3 files changed, 53 insertions(+), 2 deletions(-)
>>   create mode 100644 arch/arm/boot/dts/imx6ull-phytec-pcl063.dtsi
>>
>> diff --git a/arch/arm/boot/dts/imx6ul-phytec-pcl063.dtsi b/arch/arm/boot/dts/imx6ul-phytec-pcl063.dtsi
>> index fc2997449b49..822a178ce438 100644
>> --- a/arch/arm/boot/dts/imx6ul-phytec-pcl063.dtsi
>> +++ b/arch/arm/boot/dts/imx6ul-phytec-pcl063.dtsi
>> @@ -7,7 +7,6 @@
>>   #include <dt-bindings/gpio/gpio.h>
>>   #include <dt-bindings/interrupt-controller/irq.h>
>>   #include <dt-bindings/pwm/pwm.h>
>> -#include "imx6ul.dtsi"
>>   
>>   / {
>>   	model = "Phytec phyCORE i.MX6 UltraLite";
>> @@ -65,7 +64,7 @@
>>   	pinctrl-names = "default";
>>   	pinctrl-0 = <&pinctrl_gpmi_nand>;
>>   	nand-on-flash-bbt;
>> -	status = "okay";
>> +	status = "disabled";
>>   };
>>   
>>   &i2c1 {
>> @@ -90,6 +89,15 @@
>>   	status = "okay";
>>   };
>>   
>> +&usdhc2 {
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = <&pinctrl_usdhc2>;
>> +	bus-width = <8>;
>> +	no-1-8-v;
>> +	non-removable;
>> +	status = "disabled";
>> +};
>> +
>>   &iomuxc {
>>   	pinctrl_enet1: enet1grp {
>>   		fsl,pins = <
>> @@ -145,4 +153,18 @@
>>   		>;
>>   	};
>>   
>> +	pinctrl_usdhc2: usdhc2grp {
>> +		fsl,pins = <
>> +			MX6UL_PAD_NAND_WE_B__USDHC2_CMD		0x170f9
>> +			MX6UL_PAD_NAND_RE_B__USDHC2_CLK		0x100f9
>> +			MX6UL_PAD_NAND_DATA00__USDHC2_DATA0	0x170f9
>> +			MX6UL_PAD_NAND_DATA01__USDHC2_DATA1	0x170f9
>> +			MX6UL_PAD_NAND_DATA02__USDHC2_DATA2	0x170f9
>> +			MX6UL_PAD_NAND_DATA03__USDHC2_DATA3	0x170f9
>> +			MX6UL_PAD_NAND_DATA04__USDHC2_DATA4	0x170f9
>> +			MX6UL_PAD_NAND_DATA05__USDHC2_DATA5	0x170f9
>> +			MX6UL_PAD_NAND_DATA06__USDHC2_DATA6	0x170f9
>> +			MX6UL_PAD_NAND_DATA07__USDHC2_DATA7	0x170f9
>> +		>;
>> +	};
>>   };
>> diff --git a/arch/arm/boot/dts/imx6ul-phytec-phyboard-segin-full.dts b/arch/arm/boot/dts/imx6ul-phytec-phyboard-segin-full.dts
>> index b6a1407a9d44..76f2447f2657 100644
>> --- a/arch/arm/boot/dts/imx6ul-phytec-phyboard-segin-full.dts
>> +++ b/arch/arm/boot/dts/imx6ul-phytec-phyboard-segin-full.dts
>> @@ -5,6 +5,7 @@
>>    */
>>   
>>   /dts-v1/;
>> +#include "imx6ul.dtsi"
>>   #include "imx6ul-phytec-pcl063.dtsi"
>>   #include "imx6ul-phytec-phyboard-segin.dtsi"
>>   #include "imx6ul-phytec-peb-eval-01.dtsi"
>> @@ -37,6 +38,10 @@
>>   	status = "okay";
>>   };
>>   
>> +&gpmi {
>> +	status = "okay";
>> +};
>> +
>>   &i2c_rtc {
>>   	status = "okay";
>>   };
>> diff --git a/arch/arm/boot/dts/imx6ull-phytec-pcl063.dtsi b/arch/arm/boot/dts/imx6ull-phytec-pcl063.dtsi
>> new file mode 100644
>> index 000000000000..3f749d9f09a5
>> --- /dev/null
>> +++ b/arch/arm/boot/dts/imx6ull-phytec-pcl063.dtsi
>> @@ -0,0 +1,24 @@
>> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
>> +/*
>> + * Copyright (C) 2018 PHYTEC Messtechnik GmbH
>> + * Author: Stefan Riedmueller <s.riedmueller@phytec.de>
>> + */
>> +
>> +#include "imx6ul-phytec-pcl063.dtsi"
>> +
>> +/ {
>> +	model = "PHYTEC phyCORE-i.MX 6ULL";
>> +	compatible = "phytec,imx6ull-pcl063", "fsl,imx6ull";
>> +};
>> +
>> +&iomuxc {
>> +	/delete-node/ gpioledssomgrp;
>> +};
>> +
>> +&iomuxc_snvs {
>> +	pinctrl_gpioleds_som: gpioledssomgrp {
>> +		fsl,pins = <
>> +			MX6ULL_PAD_SNVS_TAMPER4__GPIO5_IO04	0x0b0b0
>> +		>;
>> +	};
>> +};
>> -- 
>> 2.21.0
>>
> 

-- 
Thanks,
Parthiban N

DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-22 Fax: (+49)-8142-66989-80 Email: pn@denx.de
