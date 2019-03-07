Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60977C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 01:40:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BF8120663
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 01:40:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726537AbfCGBkD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 20:40:03 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:55923 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726127AbfCGBkC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 20:40:02 -0500
X-UUID: 0ef6a4e97a4f4583b01ebbbb5c2ba7f5-20190307
X-UUID: 0ef6a4e97a4f4583b01ebbbb5c2ba7f5-20190307
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1533961328; Thu, 07 Mar 2019 09:39:58 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs03n1.mediatek.inc (172.21.101.181) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 7 Mar 2019 09:39:56 +0800
Received: from [172.21.77.4] (172.21.77.4) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 7 Mar 2019 09:39:56 +0800
Message-ID: <1551922796.20144.7.camel@mtksdaap41>
Subject: Re: [PATCH v2 03/10] dt-binding: gce: add binding for gce subsys
 property
From:   CK Hu <ck.hu@mediatek.com>
To:     Bibby Hsieh <bibby.hsieh@mediatek.com>
CC:     Jassi Brar <jassisinghbrar@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Daniel Kurtz <djkurtz@chromium.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>,
        Sascha Hauer <kernel@pengutronix.de>,
        "Philipp Zabel" <p.zabel@pengutronix.de>,
        Nicolas Boichat <drinkcat@chromium.org>,
        "YT Shen" <yt.shen@mediatek.com>,
        Daoyuan Huang <daoyuan.huang@mediatek.com>,
        Jiaguang Zhang <jiaguang.zhang@mediatek.com>,
        Dennis-YC Hsieh <dennis-yc.hsieh@mediatek.com>,
        Houlong Wei <houlong.wei@mediatek.com>,
        <ginny.chen@mediatek.com>, <kendrick.hsu@mediatek.com>,
        Frederic Chen <Frederic.Chen@mediatek.com>
Date:   Thu, 7 Mar 2019 09:39:56 +0800
In-Reply-To: <1551865835-50974-4-git-send-email-bibby.hsieh@mediatek.com>
References: <1551865835-50974-1-git-send-email-bibby.hsieh@mediatek.com>
         <1551865835-50974-4-git-send-email-bibby.hsieh@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Bibby:

On Wed, 2019-03-06 at 17:50 +0800, Bibby Hsieh wrote:
> cmdq driver provide a function that get the relationship
> of sub system number from device node for client.
> add specification for #subsys-cells, mediatek,gce-subsys.
> 
> Signed-off-by: Bibby Hsieh <bibby.hsieh@mediatek.com>
> ---
>  Documentation/devicetree/bindings/mailbox/mtk-gce.txt | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/mailbox/mtk-gce.txt b/Documentation/devicetree/bindings/mailbox/mtk-gce.txt
> index 812698f..07b2adf 100644
> --- a/Documentation/devicetree/bindings/mailbox/mtk-gce.txt
> +++ b/Documentation/devicetree/bindings/mailbox/mtk-gce.txt
> @@ -26,6 +26,13 @@ Required properties:
>  	phandle: Label name of a gce node.
>  	event_number: the event number defined in 'dt-bindings/gce/mt8173-gce.h'
>  		      or 'dt-binding/gce/mt8183-gce.h'.
> +#subsys-cells: Should be 2.
> +	<&phandle register_base_address subsys_number>
> +	phandle: Label name of a gce node.
> +	register_base_address: the register base address that client
> +			       want to write or read.

This look like the same as 'reg' property. I would prefer use
already-defined property, for example:

		mmsys: clock-controller@14000000 {
			compatible = "mediatek,mt8173-mmsys", "syscon";
			reg = <0 0x14000000 0 0x1000>;
			mediatek,gce-subsys = <&gce SUBSYS_1400XXXX>;
		};

Regards,
CK

> +	subsys_number: specify the sub-system id which is corresponding
> +		       to the register address.
>  
>  Required properties for a client device:
>  - mboxes: Client use mailbox to communicate with GCE, it should have this
> @@ -50,6 +57,7 @@ Example:
>  		thread-num = CMDQ_THR_MAX_COUNT;
>  		#mbox-cells = <3>;
>  		#event-cells = <1>;
> +		#subsys-cells = <2>;
>  	};
>  
>  Example for a client device:
> @@ -58,7 +66,8 @@ Example for a client device:
>  		compatible = "mediatek,mt8173-mmsys";
>  		mboxes = <&gce 0 CMDQ_THR_PRIO_LOWEST 1>,
>  			 <&gce 1 CMDQ_THR_PRIO_LOWEST 1>;
> -		mediatek,gce-subsys = <SUBSYS_1400XXXX>;
> +		mediatek,gce-subsys = <&gce 0x14000000 SUBSYS_1400XXXX>,
> +				      <&gce 0x14010000 SUBSYS_1401XXXX>;
>  		mediatek,gce-event-names = "rdma0_sof",
>  					   "rsz0_sof";
>  		mediatek,gce-events = <&gce CMDQ_EVENT_MDP_RDMA0_SOF>,


