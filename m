Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DE88C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 03:18:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EB05206C0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 03:18:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728342AbfC1DSf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 23:18:35 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:32849 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726176AbfC1DSe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 23:18:34 -0400
X-UUID: 6a516fcfc32e4ec0b12309d87313533a-20190328
X-UUID: 6a516fcfc32e4ec0b12309d87313533a-20190328
Received: from mtkcas09.mediatek.inc [(172.21.101.178)] by mailgw01.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1770464845; Thu, 28 Mar 2019 11:18:28 +0800
Received: from MTKMBS01DR.mediatek.inc (172.21.101.111) by
 mtkmbs06n1.mediatek.inc (172.21.101.129) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 28 Mar 2019 11:18:26 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs01dr.mediatek.inc (172.21.101.111) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 28 Mar 2019 11:18:26 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 28 Mar 2019 11:18:26 +0800
Message-ID: <1553743106.14682.6.camel@mtksdaap41>
Subject: Re: [PATCH v2 01/25] arm64: dts: add display nodes for mt8183
From:   CK Hu <ck.hu@mediatek.com>
To:     <yongqiang.niu@mediatek.com>
CC:     <p.zabel@pengutronix.de>, <robh+dt@kernel.org>,
        <matthias.bgg@gmail.com>, <airlied@linux.ie>,
        <mark.rutland@arm.com>, <dri-devel@lists.freedesktop.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <Bibby.Hsieh@mediatek.com>,
        <yt.shen@mediatek.com>
Date:   Thu, 28 Mar 2019 11:18:26 +0800
In-Reply-To: <1553667561-25447-2-git-send-email-yongqiang.niu@mediatek.com>
References: <1553667561-25447-1-git-send-email-yongqiang.niu@mediatek.com>
         <1553667561-25447-2-git-send-email-yongqiang.niu@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Yongqiang:

On Wed, 2019-03-27 at 14:18 +0800, yongqiang.niu@mediatek.com wrote:
> From: Yongqiang Niu <yongqiang.niu@mediatek.com>
> 
> This patch add display nodes for mt8183

I think this patch should be after binding document patch. You should
define the compatible string then you could add device node.

> 
> Change-Id: I9ce7081a2159ec7cc199999285b0390b01de43fe

Remove 'Change-Id' when you upstream.

Regards,
CK

> Signed-off-by: Yongqiang Niu <yongqiang.niu@mediatek.com>
> ---
>  arch/arm64/boot/dts/mediatek/mt8183.dtsi | 107 +++++++++++++++++++++++++++++++
>  1 file changed, 107 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8183.dtsi b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
> index 75c4881..f219dbd 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8183.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
> @@ -16,6 +16,14 @@
>  	#address-cells = <2>;
>  	#size-cells = <2>;
>  
> +	aliases {
> +		ovl0 = &ovl0;
> +		ovl_2l0 = &ovl0_2l;
> +		ovl_2l1 = &ovl1_2l;
> +		rdma0 = &rdma0;
> +		rdma1 = &rdma1;
> +	};
> +
>  	cpus {
>  		#address-cells = <1>;
>  		#size-cells = <0>;
> @@ -317,6 +325,105 @@
>  			#clock-cells = <1>;
>  		};
>  
> +		display_components: dispsys@14000000 {
> +			compatible = "mediatek,mt8183-display";
> +			reg = <0 0x14000000 0 0x1000>;
> +			power-domains = <&scpsys MT8183_POWER_DOMAIN_DISP>;
> +		};
> +
> +		ovl0: ovl@14008000 {
> +			compatible = "mediatek,mt8183-disp-ovl";
> +			reg = <0 0x14008000 0 0x1000>;
> +			interrupts = <GIC_SPI 225 IRQ_TYPE_LEVEL_LOW>;
> +			power-domains = <&scpsys MT8183_POWER_DOMAIN_DISP>;
> +			clocks = <&mmsys CLK_MM_DISP_OVL0>;
> +			iommus = <&iommu M4U_PORT_DISP_OVL0>;
> +			mediatek,larb = <&larb0>;
> +		};
> +
> +		ovl0_2l: ovl@14009000 {
> +			compatible = "mediatek,mt8183-disp-ovl-2l";
> +			reg = <0 0x14009000 0 0x1000>;
> +			interrupts = <GIC_SPI 226 IRQ_TYPE_LEVEL_LOW>;
> +			power-domains = <&scpsys MT8183_POWER_DOMAIN_DISP>;
> +			clocks = <&mmsys CLK_MM_DISP_OVL0_2L>;
> +			iommus = <&iommu M4U_PORT_DISP_2L_OVL0_LARB0>;
> +			mediatek,larb = <&larb0>;
> +		};
> +
> +		ovl1_2l: ovl@1400a000 {
> +			compatible = "mediatek,mt8183-disp-ovl-2l";
> +			reg = <0 0x1400a000 0 0x1000>;
> +			interrupts = <GIC_SPI 227 IRQ_TYPE_LEVEL_LOW>;
> +			power-domains = <&scpsys MT8183_POWER_DOMAIN_DISP>;
> +			clocks = <&mmsys CLK_MM_DISP_OVL1_2L>;
> +			iommus = <&iommu M4U_PORT_DISP_2L_OVL1_LARB0>;
> +			mediatek,larb = <&larb0>;
> +		};
> +
> +		rdma0: rdma@1400b000 {
> +			compatible = "mediatek,mt8183-disp-rdma";
> +			reg = <0 0x1400b000 0 0x1000>;
> +			interrupts = <GIC_SPI 228 IRQ_TYPE_LEVEL_LOW>;
> +			power-domains = <&scpsys MT8183_POWER_DOMAIN_DISP>;
> +			clocks = <&mmsys CLK_MM_DISP_RDMA0>;
> +			iommus = <&iommu M4U_PORT_DISP_RDMA0>;
> +			mediatek,larb = <&larb0>;
> +		};
> +
> +		rdma1: rdma@1400c000 {
> +			compatible = "mediatek,mt8183-disp-rdma1";
> +			reg = <0 0x1400c000 0 0x1000>;
> +			interrupts = <GIC_SPI 229 IRQ_TYPE_LEVEL_LOW>;
> +			power-domains = <&scpsys MT8183_POWER_DOMAIN_DISP>;
> +			clocks = <&mmsys CLK_MM_DISP_RDMA1>;
> +			iommus = <&iommu M4U_PORT_DISP_RDMA1>;
> +			mediatek,larb = <&larb0>;
> +		};
> +
> +		color0: color@1400e000 {
> +			compatible = "mediatek,mt8183-disp-color",
> +				     "mediatek,mt8173-disp-color";
> +			reg = <0 0x1400e000 0 0x1000>;
> +			interrupts = <GIC_SPI 231 IRQ_TYPE_LEVEL_LOW>;
> +			power-domains = <&scpsys MT8183_POWER_DOMAIN_DISP>;
> +			clocks = <&mmsys CLK_MM_DISP_COLOR0>;
> +		};
> +
> +		ccorr0: ccorr@1400f000 {
> +			compatible = "mediatek,mt8183-disp-ccorr";
> +			reg = <0 0x1400f000 0 0x1000>;
> +			interrupts = <GIC_SPI 232 IRQ_TYPE_LEVEL_LOW>;
> +			power-domains = <&scpsys MT8183_POWER_DOMAIN_DISP>;
> +			clocks = <&mmsys CLK_MM_DISP_CCORR0>;
> +		};
> +
> +		aal0: aal@14010000 {
> +			compatible = "mediatek,mt8183-disp-aal",
> +				     "mediatek,mt8173-disp-aal";
> +			reg = <0 0x14010000 0 0x1000>;
> +			interrupts = <GIC_SPI 233 IRQ_TYPE_LEVEL_LOW>;
> +			power-domains = <&scpsys MT8183_POWER_DOMAIN_DISP>;
> +			clocks = <&mmsys CLK_MM_DISP_AAL0>;
> +		};
> +
> +		gamma0: gamma@14011000 {
> +			compatible = "mediatek,mt8183-disp-gamma",
> +				     "mediatek,mt8173-disp-gamma";
> +			reg = <0 0x14011000 0 0x1000>;
> +			interrupts = <GIC_SPI 234 IRQ_TYPE_LEVEL_LOW>;
> +			power-domains = <&scpsys MT8183_POWER_DOMAIN_DISP>;
> +			clocks = <&mmsys CLK_MM_DISP_GAMMA0>;
> +		};
> +
> +		dither0: dither@14012000 {
> +			compatible = "mediatek,mt8183-disp-dither";
> +			reg = <0 0x14012000 0 0x1000>;
> +			interrupts = <GIC_SPI 235 IRQ_TYPE_LEVEL_LOW>;
> +			power-domains = <&scpsys MT8183_POWER_DOMAIN_DISP>;
> +			clocks = <&mmsys CLK_MM_DISP_DITHER0>;
> +		};
> +
>  		smi_common: smi@14019000 {
>  			compatible = "mediatek,mt8183-smi-common", "syscon";
>  			reg = <0 0x14019000 0 0x1000>;


