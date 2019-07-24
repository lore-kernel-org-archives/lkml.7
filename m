Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64930C76186
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 16:38:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B4A02189F
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 16:38:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="C2o/om1I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387477AbfGXQif (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 12:38:35 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:54027 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387410AbfGXQie (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 12:38:34 -0400
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6OGZxKK003801;
        Wed, 24 Jul 2019 18:38:07 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=STMicroelectronics;
 bh=LIYF+WcEyHaSveQjneiWBz5V/SW/gazjJXI0PW9I0e8=;
 b=C2o/om1ItzSc3OdBwnt83hedbHngy+MPN/wTWy9hUMGQU+KNxgEHGTALLAHw+rV/VPpz
 BFdTu8JaBosBTkGFtxJixvbaSahxZEHmk0W+mGhYXlRZsfcljHKawomaQ0rhZ6UNVJDq
 kILBoPUa82+q8CTTOzCjTAIePw+qdzjyxkgJKVIqPOfa4rdwPkoLAz6qhWwHyunvh0W1
 TsP4xXwq6+qTbOfRK0M+MtUhWOisZOmOW5Cvg4sGAsFoG6jm+sZ+ITLFoQKRYQgprTNs
 PR0W9toqOQBoU/F5r3+YMZhPF+zmNwSeHnU0iwOOm+vDGwAyuwnfUc+H/Y1tOeSy/OLO 5w== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2tx603xbgc-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Wed, 24 Jul 2019 18:38:07 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id EE96A38;
        Wed, 24 Jul 2019 16:38:06 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id C259F5212;
        Wed, 24 Jul 2019 16:38:06 +0000 (GMT)
Received: from lmecxl0912.lme.st.com (10.75.127.51) by SFHDAG3NODE2.st.com
 (10.75.127.8) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Wed, 24 Jul
 2019 18:38:06 +0200
Subject: Re: [PATCH 1/4] ARM: dts: stm32: add FMC2 NAND controller support on
 stm32mp157c
To:     Christophe Kerello <christophe.kerello@st.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <linux@armlinux.org.uk>, <olof@lixom.net>, <arnd@arndb.de>
CC:     <mcoquelin.stm32@gmail.com>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <1561128590-14621-1-git-send-email-christophe.kerello@st.com>
 <1561128590-14621-2-git-send-email-christophe.kerello@st.com>
From:   Alexandre Torgue <alexandre.torgue@st.com>
Message-ID: <4b6a8df1-593e-44b2-4bb3-2af9f732396c@st.com>
Date:   Wed, 24 Jul 2019 18:38:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1561128590-14621-2-git-send-email-christophe.kerello@st.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.51]
X-ClientProxiedBy: SFHDAG5NODE2.st.com (10.75.127.14) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-24_06:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christophe

On 6/21/19 4:49 PM, Christophe Kerello wrote:
> This patch adds FMC2 NAND controller support used by stm32mp157c SOC.
> 
> Signed-off-by: Christophe Kerello <christophe.kerello@st.com>
> ---
>   arch/arm/boot/dts/stm32mp157c.dtsi | 19 +++++++++++++++++++
>   1 file changed, 19 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/stm32mp157c.dtsi b/arch/arm/boot/dts/stm32mp157c.dtsi
> index 0c4e6eb..f2bda28 100644
> --- a/arch/arm/boot/dts/stm32mp157c.dtsi
> +++ b/arch/arm/boot/dts/stm32mp157c.dtsi
> @@ -1239,6 +1239,25 @@
>   			dma-requests = <48>;
>   		};
>   
> +		fmc: nand-controller@58002000 {
> +			compatible = "st,stm32mp15-fmc2";
> +			reg = <0x58002000 0x1000>,
> +			      <0x80000000 0x1000>,
> +			      <0x88010000 0x1000>,
> +			      <0x88020000 0x1000>,
> +			      <0x81000000 0x1000>,
> +			      <0x89010000 0x1000>,
> +			      <0x89020000 0x1000>;
> +			interrupts = <GIC_SPI 48 IRQ_TYPE_LEVEL_HIGH>;
> +			dmas = <&mdma1 20 0x10 0x12000A02 0x0 0x0>,
> +			       <&mdma1 20 0x10 0x12000A08 0x0 0x0>,
> +			       <&mdma1 21 0x10 0x12000A0A 0x0 0x0>;

Please, don't use capital letter here.

> +			dma-names = "tx", "rx", "ecc";
> +			clocks = <&rcc FMC_K>;
> +			resets = <&rcc FMC_R>;
> +			status = "disabled";
> +		};
> +
>   		qspi: spi@58003000 {
>   			compatible = "st,stm32f469-qspi";
>   			reg = <0x58003000 0x1000>, <0x70000000 0x10000000>;
> 
