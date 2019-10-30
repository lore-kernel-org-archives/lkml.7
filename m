Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E402CA9EC0
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 09:12:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2752120874
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 09:12:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726636AbfJ3JMh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 05:12:37 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:54454 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726028AbfJ3JMg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 05:12:36 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id A2F42984BC1C39FDC845;
        Wed, 30 Oct 2019 17:12:34 +0800 (CST)
Received: from [127.0.0.1] (10.57.101.250) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.439.0; Wed, 30 Oct 2019
 17:12:33 +0800
Subject: Re: [PATCH] arm64: dts: hisilicon: Add Mali-450 MP4 GPU DT entry
To:     John Stultz <john.stultz@linaro.org>,
        lkml <linux-kernel@vger.kernel.org>
References: <20191001183535.70835-1-john.stultz@linaro.org>
CC:     Peter Griffin <peter.griffin@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>
From:   Wei Xu <xuwei5@hisilicon.com>
Message-ID: <5DB95401.2000609@hisilicon.com>
Date:   Wed, 30 Oct 2019 17:12:33 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.2.0
MIME-Version: 1.0
In-Reply-To: <20191001183535.70835-1-john.stultz@linaro.org>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.57.101.250]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019/10/2 2:35, John Stultz wrote:
> From: Peter Griffin <peter.griffin@linaro.org>
>
> hi6220 has a Mali450 MP4 so lets add it into the DT.
>
> Cc: Wei Xu <xuwei5@hisilicon.com>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
> Signed-off-by: John Stultz <john.stultz@linaro.org>

Thanks!
Applied to the hisilicon arm64 dt tree.

Best Regards,
Wei

> ---
>   arch/arm64/boot/dts/hisilicon/hi6220.dtsi | 38 +++++++++++++++++++++++
>   1 file changed, 38 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/hisilicon/hi6220.dtsi b/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
> index 108e2a4227f6..2072b637b5af 100644
> --- a/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
> +++ b/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
> @@ -260,6 +260,7 @@
>   			compatible = "hisilicon,hi6220-aoctrl", "syscon";
>   			reg = <0x0 0xf7800000 0x0 0x2000>;
>   			#clock-cells = <1>;
> +			#reset-cells = <1>;
>   		};
>   
>   		sys_ctrl: sys_ctrl@f7030000 {
> @@ -1021,6 +1022,43 @@
>   			clock-names = "apb_pclk";
>   			cpu = <&cpu7>;
>   		};
> +
> +		mali: gpu@f4080000 {
> +			compatible = "hisilicon,hi6220-mali", "arm,mali-450";
> +			reg = <0x0 0xf4080000 0x0 0x00040000>;
> +			interrupt-parent = <&gic>;
> +			interrupts =	<GIC_PPI 126 IRQ_TYPE_LEVEL_HIGH>,
> +					<GIC_PPI 126 IRQ_TYPE_LEVEL_HIGH>,
> +					<GIC_PPI 126 IRQ_TYPE_LEVEL_HIGH>,
> +					<GIC_PPI 126 IRQ_TYPE_LEVEL_HIGH>,
> +					<GIC_PPI 126 IRQ_TYPE_LEVEL_HIGH>,
> +					<GIC_PPI 126 IRQ_TYPE_LEVEL_HIGH>,
> +					<GIC_PPI 126 IRQ_TYPE_LEVEL_HIGH>,
> +					<GIC_PPI 126 IRQ_TYPE_LEVEL_HIGH>,
> +					<GIC_PPI 126 IRQ_TYPE_LEVEL_HIGH>,
> +					<GIC_PPI 126 IRQ_TYPE_LEVEL_HIGH>,
> +					<GIC_PPI 126 IRQ_TYPE_LEVEL_HIGH>;
> +
> +			interrupt-names = "gp",
> +					  "gpmmu",
> +					  "pp",
> +					  "pp0",
> +					  "ppmmu0",
> +					  "pp1",
> +					  "ppmmu1",
> +					  "pp2",
> +					  "ppmmu2",
> +					  "pp3",
> +					  "ppmmu3";
> +			clocks = <&media_ctrl HI6220_G3D_CLK>,
> +				 <&media_ctrl HI6220_G3D_PCLK>;
> +			clock-names = "core", "bus";
> +			assigned-clocks = <&media_ctrl HI6220_G3D_CLK>,
> +					  <&media_ctrl HI6220_G3D_PCLK>;
> +			assigned-clock-rates = <500000000>, <144000000>;
> +			reset-names = "ao_g3d", "media_g3d";
> +			resets = <&ao_ctrl AO_G3D>, <&media_ctrl MEDIA_G3D>;
> +		};
>   	};
>   };
>   


