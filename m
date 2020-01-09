Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEF67C32771
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 09:47:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9305F2072E
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 09:47:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="a5Pp6DTZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729769AbgAIJrF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 04:47:05 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:11234 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728755AbgAIJrF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 04:47:05 -0500
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0099bweL010751;
        Thu, 9 Jan 2020 10:46:56 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=STMicroelectronics;
 bh=kaxJeJxsQ9kniwCq7eta3R28bBgqLC1dveeyS7Ju7cY=;
 b=a5Pp6DTZ/GlpD0FCtQUjLWhUkZwYV9XTBXGlEbgqM3xXjL83GA5aBjJHRtBdxLxFebD6
 YM8UtNwT1nPY+2lUxtgZn0hkLiH2X32GrsXvWvKPsBlAuk+72KzgGmRRoQewLA9cUh/Y
 5HbmkmBrUWs03P7nHFuHDrDO28ZknO+yzv0S1oXiNpSxqvsYpsZhKCROm5ycEEQmgvze
 stnUxKE+c535SLRRjBUeE8uXVpS1PSswLjOv5mIkg6f1ecjRDDHjwf8R6S4THUBobKox
 dtNGnv8UU29aXLYW6pidPc8CYc//SZgbGEfZ1VD1DYUAdhrIp8rBMwldu02/hFpyc5bP nQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2xakkb0ysg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 09 Jan 2020 10:46:56 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 175E510003D;
        Thu,  9 Jan 2020 10:46:52 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 01FEC2A791B;
        Thu,  9 Jan 2020 10:46:52 +0100 (CET)
Received: from lmecxl0912.lme.st.com (10.75.127.45) by SFHDAG3NODE2.st.com
 (10.75.127.8) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Thu, 9 Jan
 2020 10:46:51 +0100
Subject: Re: [PATCH] ARM: dts: stm32: Add power-supply for RGB panel on
 stm32429i-eval
To:     Benjamin Gaignard <benjamin.gaignard@st.com>,
        <mcoquelin.stm32@gmail.com>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>
CC:     <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20200108132647.26131-1-benjamin.gaignard@st.com>
From:   Alexandre Torgue <alexandre.torgue@st.com>
Message-ID: <2af148e9-c67c-0654-716b-1e65a77510b7@st.com>
Date:   Thu, 9 Jan 2020 10:46:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200108132647.26131-1-benjamin.gaignard@st.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.45]
X-ClientProxiedBy: SFHDAG5NODE3.st.com (10.75.127.15) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-09_02:2020-01-08,2020-01-09 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

On 1/8/20 2:26 PM, Benjamin Gaignard wrote:
> Add a fixed regulator and use it as power supply for RBG panel.
> 
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
> ---
>   arch/arm/boot/dts/stm32429i-eval.dts | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/stm32429i-eval.dts b/arch/arm/boot/dts/stm32429i-eval.dts
> index 58288aa53fee..c27fa355e5ab 100644
> --- a/arch/arm/boot/dts/stm32429i-eval.dts
> +++ b/arch/arm/boot/dts/stm32429i-eval.dts
> @@ -95,6 +95,13 @@
>   		regulator-max-microvolt = <3300000>;
>   	};
>   
> +	vdd_panel: vdd-panel {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vdd_panel";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +	};
> +
>   	leds {
>   		compatible = "gpio-leds";
>   		green {
> @@ -138,6 +145,7 @@
>   
>   	panel_rgb: panel-rgb {
>   		compatible = "ampire,am-480272h3tmqw-t01h";
> +		power-supply = <&vdd_panel>;
>   		status = "okay";
>   		port {
>   			panel_in_rgb: endpoint {
> 

Applied on stm32-next.

Thanks
Alex
