Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3E30C28CC5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 03:47:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7E7A2083D
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 03:47:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726595AbfFFDrV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 23:47:21 -0400
Received: from mailgw02.mediatek.com ([1.203.163.81]:5391 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726331AbfFFDrU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 23:47:20 -0400
X-UUID: 2f48e69f3fb44eaab5e6ac3909e08df2-20190606
X-UUID: 2f48e69f3fb44eaab5e6ac3909e08df2-20190606
Received: from mtkcas36.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 537222429; Thu, 06 Jun 2019 11:47:14 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 MTKMBS31N2.mediatek.inc (172.27.4.87) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 6 Jun 2019 11:47:12 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 6 Jun 2019 11:47:12 +0800
Message-ID: <1559792829.20098.4.camel@mtksdaap41>
Subject: Re: [PATCH v3, 01/27] dt-bindings: mediatek: add binding for mt8183
 display
From:   CK Hu <ck.hu@mediatek.com>
To:     <yongqiang.niu@mediatek.com>
CC:     Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "David Airlie" <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Mark Rutland <mark.rutland@arm.com>,
        <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
Date:   Thu, 6 Jun 2019 11:47:09 +0800
In-Reply-To: <1559734986-7379-2-git-send-email-yongqiang.niu@mediatek.com>
References: <1559734986-7379-1-git-send-email-yongqiang.niu@mediatek.com>
         <1559734986-7379-2-git-send-email-yongqiang.niu@mediatek.com>
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

On Wed, 2019-06-05 at 19:42 +0800, yongqiang.niu@mediatek.com wrote:
> From: Yongqiang Niu <yongqiang.niu@mediatek.com>
> 
> Update device tree binding documention for the display subsystem for
> Mediatek MT8183 SOCs
> 
> Signed-off-by: Yongqiang Niu <yongqiang.niu@mediatek.com>
> ---
>  .../bindings/display/mediatek/mediatek,disp.txt    | 34 +++++++++++++---------
>  1 file changed, 20 insertions(+), 14 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,disp.txt b/Documentation/devicetree/bindings/display/mediatek/mediatek,disp.txt
> index 8469de5..70770fe 100644
> --- a/Documentation/devicetree/bindings/display/mediatek/mediatek,disp.txt
> +++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,disp.txt
> @@ -27,20 +27,20 @@ Documentation/devicetree/bindings/display/mediatek/mediatek,dpi.txt.
>  
>  Required properties (all function blocks):
>  - compatible: "mediatek,<chip>-disp-<function>", one of
> -	"mediatek,<chip>-disp-ovl"   - overlay (4 layers, blending, csc)
> -	"mediatek,<chip>-disp-rdma"  - read DMA / line buffer
> -	"mediatek,<chip>-disp-wdma"  - write DMA
> -	"mediatek,<chip>-disp-color" - color processor
> -	"mediatek,<chip>-disp-aal"   - adaptive ambient light controller
> -	"mediatek,<chip>-disp-gamma" - gamma correction
> -	"mediatek,<chip>-disp-merge" - merge streams from two RDMA sources
> -	"mediatek,<chip>-disp-split" - split stream to two encoders
> -	"mediatek,<chip>-disp-ufoe"  - data compression engine
> -	"mediatek,<chip>-dsi"        - DSI controller, see mediatek,dsi.txt
> -	"mediatek,<chip>-dpi"        - DPI controller, see mediatek,dpi.txt
> -	"mediatek,<chip>-disp-mutex" - display mutex
> -	"mediatek,<chip>-disp-od"    - overdrive
> -  the supported chips are mt2701, mt2712 and mt8173.
> +	"mediatek,<chip>-disp-ovl"   		- overlay (4 layers, blending, csc)
> +	"mediatek,<chip>-disp-rdma"  		- read DMA / line buffer
> +	"mediatek,<chip>-disp-wdma"  		- write DMA
> +	"mediatek,<chip>-disp-color" 		- color processor
> +	"mediatek,<chip>-disp-aal"   		- adaptive ambient light controller
> +	"mediatek,<chip>-disp-gamma" 		- gamma correction
> +	"mediatek,<chip>-disp-merge" 		- merge streams from two RDMA sources
> +	"mediatek,<chip>-disp-split" 		- split stream to two encoders
> +	"mediatek,<chip>-disp-ufoe"  		- data compression engine
> +	"mediatek,<chip>-dsi"        		- DSI controller, see mediatek,dsi.txt
> +	"mediatek,<chip>-dpi"        		- DPI controller, see mediatek,dpi.txt
> +	"mediatek,<chip>-disp-mutex" 		- display mutex
> +	"mediatek,<chip>-disp-od"    		- overdrive

I think you add 'tab' because of "add ovl_2l description for mt8183
display" not "add binding for mt8183 display", so move the 'tab' to the
related patch.

> +  the supported chips are mt2701, mt2712, mt8173 and mt8183.
>  - reg: Physical base address and length of the function block register space
>  - interrupts: The interrupt signal from the function block (required, except for
>    merge and split function blocks).
> @@ -71,6 +71,12 @@ mmsys: clock-controller@14000000 {
>  	#clock-cells = <1>;
>  };
>  
> +display_components: dispsys@14000000 {
> +		compatible = "mediatek,mt8183-display";

Where do you define "mediatek,mt8183-display"?

Regards,
CK

> +		reg = <0 0x14000000 0 0x1000>;
> +		power-domains = <&scpsys MT8183_POWER_DOMAIN_DISP>;
> +};
> +
>  ovl0: ovl@1400c000 {
>  	compatible = "mediatek,mt8173-disp-ovl";
>  	reg = <0 0x1400c000 0 0x1000>;


