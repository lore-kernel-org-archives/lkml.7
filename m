Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3250CC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 13:42:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02AEF2133D
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 13:42:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="ASzuB41G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732281AbfDJNmS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 09:42:18 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:22366 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728971AbfDJNmQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 09:42:16 -0400
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3ADaVhM005736;
        Wed, 10 Apr 2019 15:42:10 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=STMicroelectronics;
 bh=wafYL0FxqT7aM5UWs8U7fdktRS4pG36Q7Mjllpl1zyM=;
 b=ASzuB41GM71NIl5VxZyyrS6FTdo37Ooza94qhicvooNTk5NF6sCFBCEfcPPZC4AU94l7
 8Mrjl/jGnbQgw3DmwdFJ4ZfRM4A8uZ2vRfPyYTgZ2djybIbVAgnORwhihiKZDHZT9ZYI
 5prYTgiX5VBmtQrXeRgkcBKKBdDMqc2rMIdMcTLYaRmniZg/sDXe9FTiMc1l8noVsWSi
 ue4dtsiyFkMWko+/vhFiX3lBO1KIkFTUQdlMSkBssyZFIBuZYp9d0PJcTVU3W3JhKa2I
 krZNkFx1LlCa8fGA2vtIzwT8zuUYNBgK8e8TTc29wxXtjT2wtzp2lHnsYXEM8YvKInT2 Dw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2rprcfg7x4-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Wed, 10 Apr 2019 15:42:10 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id DD04334;
        Wed, 10 Apr 2019 13:42:09 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id B0F0824D0;
        Wed, 10 Apr 2019 13:42:09 +0000 (GMT)
Received: from [10.48.0.204] (10.75.127.47) by SFHDAG3NODE2.st.com
 (10.75.127.8) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Wed, 10 Apr
 2019 15:42:09 +0200
Subject: Re: [PATCH 2/2] ARM: dts: stm32: Enable STM32F769 clock driver
To:     Gabriel Fernandez <gabriel.fernandez@st.com>,
        michael turquette <mturquette@baylibre.com>,
        stephen boyd <sboyd@kernel.org>,
        rob herring <robh+dt@kernel.org>,
        mark rutland <mark.rutland@arm.com>,
        maxime coquelin <mcoquelin.stm32@gmail.com>
CC:     <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
References: <20190405075332.28530-1-gabriel.fernandez@st.com>
 <20190405075332.28530-3-gabriel.fernandez@st.com>
From:   Alexandre Torgue <alexandre.torgue@st.com>
Message-ID: <5d6bc520-caa1-9dca-539d-e270562c4873@st.com>
Date:   Wed, 10 Apr 2019 15:40:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190405075332.28530-3-gabriel.fernandez@st.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.47]
X-ClientProxiedBy: SFHDAG8NODE2.st.com (10.75.127.23) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-10_06:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Gabriel

On 4/5/19 9:53 AM, Gabriel Fernandez wrote:
> This patch enables clocks for STM32F769 boards.
> 
> Signed-off-by: Gabriel Fernandez <gabriel.fernandez@st.com>
> ---
>   arch/arm/boot/dts/stm32f769-disco.dts | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/stm32f769-disco.dts b/arch/arm/boot/dts/stm32f769-disco.dts
> index 3c7216844a9b..6f1d0ac8c31c 100644
> --- a/arch/arm/boot/dts/stm32f769-disco.dts
> +++ b/arch/arm/boot/dts/stm32f769-disco.dts
> @@ -102,6 +102,10 @@
>   	};
>   };
>   
> +&rcc {
> +	compatible = "st,stm32f769-rcc", "st,stm32f746-rcc", "st,stm32-rcc";
> +};
> +
>   &cec {
>   	pinctrl-0 = <&cec_pins_a>;
>   	pinctrl-names = "default";
> 

Even if driver part is not yet merged, this DT part can be taken as we 
will run with "st,stm32f746-rcc" compatible (the current one).

So:

Applied on stm32-next.

Thanks.
Alex
