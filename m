Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29202C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 21:44:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5A4B20700
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 21:44:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=akkea.ca header.i=@akkea.ca header.b="i4Y+rp9h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732321AbfCZVoX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 17:44:23 -0400
Received: from node.akkea.ca ([192.155.83.177]:51112 "EHLO node.akkea.ca"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731621AbfCZVoW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 17:44:22 -0400
Received: by node.akkea.ca (Postfix, from userid 33)
        id 1FA694E204B; Tue, 26 Mar 2019 21:44:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
        t=1553636661; bh=KKoYdTVdUXvuKq91LUmwwoE1yrvgMBNIxA7EFGxz+oA=;
        h=To:Subject:Date:From:Cc:In-Reply-To:References;
        b=i4Y+rp9hitcfdHCpnhMw4SDaTAlqNTrXR6p6LqeYWpkXy+pJWH5KSoN9WbHGd5yDS
         JwKzYLXSCgf/CrtiGxujqTi4lj3sDfa/VprfRDUEAgcCwZLIJ7givyuj464OvJQY7O
         4wR2qZ78BdxPeHI3P5Ot1KygU3NA911VFo1Nswoo=
To:     Shawn Guo <shawnguo@kernel.org>
Subject: Re: [PATCH v6 1/4] arm64: dts: imx8mq: Add SDMA nodes
X-PHP-Originating-Script: 1000:rcube.php
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 26 Mar 2019 14:44:21 -0700
From:   Angus Ainslie <angus@akkea.ca>
Cc:     Daniel Baluta <daniel.baluta@nxp.com>, mark.rutland@arm.com,
        devicetree@vger.kernel.org, baruch@tkos.co.il,
        Anson Huang <anson.huang@nxp.com>,
        Abel Vesa <abel.vesa@nxp.com>,
        kuninori.morimoto.gx@renesas.com, ccaione@baylibre.com,
        spencercw@gmail.com, "S.j. Wang" <shengjiu.wang@nxp.com>,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        dl-linux-imx <linux-imx@nxp.com>, kernel@pengutronix.de,
        Aisheng Dong <aisheng.dong@nxp.com>, agx@sigxcpu.org,
        festevam@gmail.com, s.hauer@pengutronix.de,
        linux-arm-kernel@lists.infradead.org, l.stach@pengutronix.de
In-Reply-To: <20190319143139.GA24315@dragon>
References: <20190308120141.3698-1-daniel.baluta@nxp.com>
 <20190308120141.3698-2-daniel.baluta@nxp.com>
 <20190319143139.GA24315@dragon>
Message-ID: <f5934d5bca4b9241d0ac84de463fbeed@www.akkea.ca>
X-Sender: angus@akkea.ca
User-Agent: Roundcube Webmail/1.1.3
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-03-19 07:31, Shawn Guo wrote:
> On Fri, Mar 08, 2019 at 12:02:22PM +0000, Daniel Baluta wrote:
>> SDMA1 is part of AIPS-3 region and SDMA2 is part
>> of AIPS-1 region.
>> 
>> Reviewed-by: Fabio Estevam <festevam@gmail.com>
> 
> Reviewed-by tag should go after your SoB, since that's the sequence of
> how they come.
> 
>> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
>> [initial submit in i.MX internal tree]
>> Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
>> [adaptation for linux-next]
> 
> I would see these notes in commit log or even just cover letter.
> 
> Shawn
> 
>> ---
>>  arch/arm64/boot/dts/freescale/imx8mq.dtsi | 22 ++++++++++++++++++++++
>>  1 file changed, 22 insertions(+)
>> 
>> diff --git a/arch/arm64/boot/dts/freescale/imx8mq.dtsi 
>> b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
>> index 9155bd4784eb..9d48450453fb 100644
>> --- a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
>> +++ b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
>> @@ -234,6 +234,17 @@
>>  				status = "disabled";
>>  			};
>> 
>> +			sdma2: sdma@302c0000 {
>> +				compatible = "fsl,imx8mq-sdma","fsl,imx7d-sdma";
>> +				reg = <0x302c0000 0x10000>;
>> +				interrupts = <GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH>;
>> +				clocks = <&clk IMX8MQ_CLK_SDMA2_ROOT>,
>> +					 <&clk IMX8MQ_CLK_SDMA2_ROOT>;
>> +				clock-names = "ipg", "ahb";
>> +				#dma-cells = <3>;
>> +				fsl,sdma-ram-script-name = "imx/sdma/sdma-imx7d.bin";
>> +			};
>> +
>>  			iomuxc: iomuxc@30330000 {
>>  				compatible = "fsl,imx8mq-iomuxc";
>>  				reg = <0x30330000 0x10000>;
>> @@ -575,6 +586,17 @@
>>  				status = "disabled";
>>  			};
>> 
>> +			sdma1: sdma@30bd0000 {
>> +				compatible = "fsl, imx8mq-sdma","fsl,imx7d-sdma";

There shouldn't be a space in the imx8mq compatible string.

Angus

>> +				reg = <0x30bd0000 0x10000>;
>> +				interrupts = <GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>;
>> +				clocks = <&clk IMX8MQ_CLK_SDMA1_ROOT>,
>> +					 <&clk IMX8MQ_CLK_SDMA1_ROOT>;
>> +				clock-names = "ipg", "ahb";
>> +				#dma-cells = <3>;
>> +				fsl,sdma-ram-script-name = "imx/sdma/sdma-imx7d.bin";
>> +			};
>> +
>>  			fec1: ethernet@30be0000 {
>>  				compatible = "fsl,imx8mq-fec", "fsl,imx6sx-fec";
>>  				reg = <0x30be0000 0x10000>;
>> --
>> 2.17.1
>> 
>> 
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

