Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEBE4C31E57
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 09:44:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7D042089E
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 09:44:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="KgqofR0T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727203AbfFQJop (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 05:44:45 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:32334 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725837AbfFQJoo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 05:44:44 -0400
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5H9gHDt003329;
        Mon, 17 Jun 2019 11:44:33 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=subject : to : references
 : from : message-id : date : mime-version : in-reply-to : content-type :
 content-transfer-encoding; s=STMicroelectronics;
 bh=vSNS/bq0veNCYFxKoKYyEQdlakEJCBWCIdyquEymrxE=;
 b=KgqofR0T2LgJCXq1TE3zLLmC4ABVK94VpPhryD+CPlLTkwdOCoBRSbYv9cczm2YNKKlO
 AfWoFBnANPtX4y7W/fwtI9XB+/8LocEuw7wVMGt5UNd8Bb8LRih0aPaPr1v7U0oihnFk
 5u8X7eMB6ZP+ZBoMSYCI5OkIG2lgBoC+nIlj4KfK9/AGTxVEB1Gby+dshQzUow57V7hq
 8pAXfOIiJhKEZ4vqHFz7KB6PdmQLc/dVzLeNb4I0DTPDpVkn3UdFPh31Kcmq8DlStJrS
 zUTQxz0cWb1LmNgXqiQHtgu7Hnu9yGVEKk7xLJjKFeEeqn/8IiGE+42HUrZpxdydlbu6 OQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2t4peu1nxf-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Mon, 17 Jun 2019 11:44:33 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 097E259;
        Mon, 17 Jun 2019 09:44:33 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id DDA2B25CC;
        Mon, 17 Jun 2019 09:44:32 +0000 (GMT)
Received: from [10.48.0.204] (10.75.127.51) by SFHDAG3NODE2.st.com
 (10.75.127.8) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Mon, 17 Jun
 2019 11:44:32 +0200
Subject: Re: [PATCH] ARM: dts: stm32: add sai id registers to stm32mp157c
To:     Olivier Moysan <olivier.moysan@st.com>,
        <linux-stm32@st-md-mailman.stormreply.com>, <robh@kernel.org>,
        <mark.rutland@arm.com>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <1560253556-18399-1-git-send-email-olivier.moysan@st.com>
From:   Alexandre Torgue <alexandre.torgue@st.com>
Message-ID: <4f3f0728-d9b3-dcbc-8dfe-e7f55a9bd204@st.com>
Date:   Mon, 17 Jun 2019 11:44:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <1560253556-18399-1-git-send-email-olivier.moysan@st.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.51]
X-ClientProxiedBy: SFHDAG2NODE1.st.com (10.75.127.4) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-17_05:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Olivier

On 6/11/19 1:45 PM, Olivier Moysan wrote:
> Add identification registers to address range
> of SAI DT parent node, for stm32mp157c.
> 
> Change-Id: I696363794fab59ba8d7869b3ffbc041dacdf28de
> Signed-off-by: Olivier Moysan <olivier.moysan@st.com>
> ---
>   arch/arm/boot/dts/stm32mp157c.dtsi | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/stm32mp157c.dtsi b/arch/arm/boot/dts/stm32mp157c.dtsi
> index e98aad37ff9e..0c4e6ebc3529 100644
> --- a/arch/arm/boot/dts/stm32mp157c.dtsi
> +++ b/arch/arm/boot/dts/stm32mp157c.dtsi


Applied on stm32-next. Next time, don't forget to remove your gerrit 
changeID please.

Thanks.
Alex



> @@ -746,7 +746,7 @@
>   			#address-cells = <1>;
>   			#size-cells = <1>;
>   			ranges = <0 0x4400a000 0x400>;
> -			reg = <0x4400a000 0x4>;
> +			reg = <0x4400a000 0x4>, <0x4400a3f0 0x10>;
>   			interrupts = <GIC_SPI 87 IRQ_TYPE_LEVEL_HIGH>;
>   			resets = <&rcc SAI1_R>;
>   			status = "disabled";
> @@ -778,7 +778,7 @@
>   			#address-cells = <1>;
>   			#size-cells = <1>;
>   			ranges = <0 0x4400b000 0x400>;
> -			reg = <0x4400b000 0x4>;
> +			reg = <0x4400b000 0x4>, <0x4400b3f0 0x10>;
>   			interrupts = <GIC_SPI 91 IRQ_TYPE_LEVEL_HIGH>;
>   			resets = <&rcc SAI2_R>;
>   			status = "disabled";
> @@ -809,7 +809,7 @@
>   			#address-cells = <1>;
>   			#size-cells = <1>;
>   			ranges = <0 0x4400c000 0x400>;
> -			reg = <0x4400c000 0x4>;
> +			reg = <0x4400c000 0x4>, <0x4400c3f0 0x10>;
>   			interrupts = <GIC_SPI 114 IRQ_TYPE_LEVEL_HIGH>;
>   			resets = <&rcc SAI3_R>;
>   			status = "disabled";
> @@ -1164,7 +1164,7 @@
>   			#address-cells = <1>;
>   			#size-cells = <1>;
>   			ranges = <0 0x50027000 0x400>;
> -			reg = <0x50027000 0x4>;
> +			reg = <0x50027000 0x4>, <0x500273f0 0x10>;
>   			interrupts = <GIC_SPI 146 IRQ_TYPE_LEVEL_HIGH>;
>   			resets = <&rcc SAI4_R>;
>   			status = "disabled";
> 
