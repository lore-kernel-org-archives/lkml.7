Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B144EC33CA2
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 09:47:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 876ED206ED
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 09:47:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="HaRkAnCb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729801AbgAIJr3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 04:47:29 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:10304 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728755AbgAIJr2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 04:47:28 -0500
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0099bw3M010765;
        Thu, 9 Jan 2020 10:47:17 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=STMicroelectronics;
 bh=/srlc8j4yMgSJXREcaFnjnBeD6pKrkieKNXc+bew/uo=;
 b=HaRkAnCbc5l084A2XWXcD5uIsugiHHJo8D/Yzu21Jc/zbGVexB2QKczlGvjFovDUb78V
 0zxWDypWd1pzNGG5+lTYTxBc6LkyF5hhdvWN6ZOYsLJJMpxGg2tAft2LiWB/n1bRCqG2
 +wNp5yvieGlZ3IxuxpTRWiG7dARMlj5HnJIinj4LK2RwgS6f1b4RlSSmgRHvKJRQ/TRg
 +nvyQ4Ns+jzilthgf84M8jl3/Ts4OV/3JobOM08Ju6c26XoZWR1OPO2QxedkQ3vEqTEr
 8VXJZmVMoYEYRK8DAZJTcW2XbQPJJ7Q1aSsFsFAw3fmLcgk+ELP7e7e571esktT6K3Ng tg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2xakkb0yuh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 09 Jan 2020 10:47:17 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id E76E3100038;
        Thu,  9 Jan 2020 10:47:12 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id DA8AE2A7915;
        Thu,  9 Jan 2020 10:47:12 +0100 (CET)
Received: from lmecxl0912.lme.st.com (10.75.127.46) by SFHDAG3NODE2.st.com
 (10.75.127.8) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Thu, 9 Jan
 2020 10:47:12 +0100
Subject: Re: [PATCH] ARM: dts: stm32: Add power-supply for DSI panel on
 stm32f469-disco
To:     Benjamin Gaignard <benjamin.gaignard@st.com>,
        <mcoquelin.stm32@gmail.com>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>
CC:     <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20200108132647.26131-1-benjamin.gaignard@st.com>
 <20200108132647.26131-2-benjamin.gaignard@st.com>
From:   Alexandre Torgue <alexandre.torgue@st.com>
Message-ID: <d4d67add-9dd2-4589-42b1-226f63d1ed29@st.com>
Date:   Thu, 9 Jan 2020 10:47:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200108132647.26131-2-benjamin.gaignard@st.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.46]
X-ClientProxiedBy: SFHDAG4NODE2.st.com (10.75.127.11) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-09_02:2020-01-08,2020-01-09 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

On 1/8/20 2:26 PM, Benjamin Gaignard wrote:
> Add a fixed regulator and use it as power supply for DSI panel.
> 
> Fixes: 18c8866266 ("ARM: dts: stm32: Add display support on stm32f469-disco")
> 
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
> ---
>   arch/arm/boot/dts/stm32f469-disco.dts | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/stm32f469-disco.dts b/arch/arm/boot/dts/stm32f469-disco.dts
> index f3ce477b7bae..4801565e19d7 100644
> --- a/arch/arm/boot/dts/stm32f469-disco.dts
> +++ b/arch/arm/boot/dts/stm32f469-disco.dts
> @@ -76,6 +76,13 @@
>   		regulator-max-microvolt = <3300000>;
>   	};
>   
> +	vdd_dsi: vdd-dsi {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vdd_dsi";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +	};
> +
>   	soc {
>   		dma-ranges = <0xc0000000 0x0 0x10000000>;
>   	};
> @@ -155,6 +162,7 @@
>   		compatible = "orisetech,otm8009a";
>   		reg = <0>; /* dsi virtual channel (0..3) */
>   		reset-gpios = <&gpioh 7 GPIO_ACTIVE_LOW>;
> +		power-supply = <&vdd_dsi>;
>   		status = "okay";
>   
>   		port {
> 

Applied on stm32-next.

Thanks
Alex
