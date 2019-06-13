Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2A5DC31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:27:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85782206BB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:27:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728402AbfFMP1Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 11:27:16 -0400
Received: from 6.mo2.mail-out.ovh.net ([87.98.165.38]:40663 "EHLO
        6.mo2.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729054AbfFMLkg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 07:40:36 -0400
Received: from player728.ha.ovh.net (unknown [10.108.35.158])
        by mo2.mail-out.ovh.net (Postfix) with ESMTP id 897B719F3A8
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2019 13:34:43 +0200 (CEST)
Received: from armadeus.com (lfbn-1-7591-179.w90-126.abo.wanadoo.fr [90.126.248.179])
        (Authenticated sender: sebastien.szymanski@armadeus.com)
        by player728.ha.ovh.net (Postfix) with ESMTPSA id 7FFDA6B6DE10;
        Thu, 13 Jun 2019 11:34:32 +0000 (UTC)
Subject: Re: [PATCH 1/1] ARM: dts: imx6ul: Add PXP node
To:     Marco Felsch <m.felsch@pengutronix.de>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, NXP Linux Team <linux-imx@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>
References: <20190606164642.11539-1-sebastien.szymanski@armadeus.com>
 <20190612172103.gat3yrub2iyurai5@pengutronix.de>
From:   =?UTF-8?Q?S=c3=a9bastien_Szymanski?= 
        <sebastien.szymanski@armadeus.com>
Openpgp: preference=signencrypt
Message-ID: <6802e25d-f12b-28e3-d975-7f21fe002a35@armadeus.com>
Date:   Thu, 13 Jun 2019 13:34:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190612172103.gat3yrub2iyurai5@pengutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 3806386112924832978
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduuddrudehledggedtucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddm
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marco,

On 6/12/19 7:21 PM, Marco Felsch wrote:
> Hi Sébastien,
> 
> On 19-06-06 18:46, Sébastien Szymanski wrote:
>> Add PXP node for i.MX6UL/L SoC.
>>
>> Signed-off-by: Sébastien Szymanski <sebastien.szymanski@armadeus.com>
>> ---
>>  arch/arm/boot/dts/imx6ul.dtsi  | 9 +++++++++
>>  arch/arm/boot/dts/imx6ull.dtsi | 6 ++++++
>>  2 files changed, 15 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/imx6ul.dtsi b/arch/arm/boot/dts/imx6ul.dtsi
>> index f10012de5eb6..a3c005373ae1 100644
>> --- a/arch/arm/boot/dts/imx6ul.dtsi
>> +++ b/arch/arm/boot/dts/imx6ul.dtsi
>> @@ -971,6 +971,15 @@
>>  				status = "disabled";
>>  			};
>>  
>> +			pxp: pxp@21cc000 {
>> +				compatible = "fsl,imx6ul-pxp";
>> +				reg = <0x021cc000 0x4000>;
>> +				interrupts = <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>;
>> +				clocks = <&clks IMX6UL_CLK_PXP>;
>> +				clock-names = "axi";
>> +				status = "disabled";
> 
> Can you drop the status line because its a platform device and isn't
> removeable.

Ok, done. thanks!

Regards,

> 
>> +			};
>> +
>>  			qspi: spi@21e0000 {
>>  				#address-cells = <1>;
>>  				#size-cells = <0>;
>> diff --git a/arch/arm/boot/dts/imx6ull.dtsi b/arch/arm/boot/dts/imx6ull.dtsi
>> index 22e4a307fa59..b017e925bd87 100644
>> --- a/arch/arm/boot/dts/imx6ull.dtsi
>> +++ b/arch/arm/boot/dts/imx6ull.dtsi
>> @@ -34,6 +34,12 @@
>>  	compatible = "fsl,imx6ull-ocotp", "syscon";
>>  };
>>  
>> +&pxp {
>> +	compatible = "fsl,imx6ull-pxp";
>> +	interrupts = <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>,
>> +		     <GIC_SPI 18 IRQ_TYPE_LEVEL_HIGH>;
>> +};
>> +
>>  &usdhc1 {
>>  	compatible = "fsl,imx6ull-usdhc", "fsl,imx6sx-usdhc";
>>  };
>> -- 
>> 2.19.2
>>
>>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 


-- 
Sébastien Szymanski
Software engineer, Armadeus Systems
Tel: +33 (0)9 72 29 41 44
Fax: +33 (0)9 72 28 79 26
