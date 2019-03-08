Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15097C4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 08:47:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E452B20684
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 08:47:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726334AbfCHIrw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 03:47:52 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:1969 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726238AbfCHIrw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 03:47:52 -0500
X-UUID: c6a993b043be42d7bad82109c0eb2468-20190308
X-UUID: c6a993b043be42d7bad82109c0eb2468-20190308
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw01.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 110564800; Fri, 08 Mar 2019 16:47:40 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 8 Mar 2019 16:47:39 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 8 Mar 2019 16:47:39 +0800
Message-ID: <1552034858.2863.25.camel@mtksdaap41>
Subject: Re: [PATCH v2 02/10] dt-binding: gce: add binding for gce event
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
Date:   Fri, 8 Mar 2019 16:47:38 +0800
In-Reply-To: <1551865835-50974-3-git-send-email-bibby.hsieh@mediatek.com>
References: <1551865835-50974-1-git-send-email-bibby.hsieh@mediatek.com>
         <1551865835-50974-3-git-send-email-bibby.hsieh@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-SNTS-SMTP: 53E949AEC08988B78A0AC1647D487C3228351745EA3C37EF067C1A23601FEB272000:8
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Bibby:

On Wed, 2019-03-06 at 17:50 +0800, Bibby Hsieh wrote:
> cmdq driver provide a function that get event number
> from device node for client.

I think device tree is based on the view of hardware design, so you need
not to mention how the driver design. 

Client hardware would send event to GCE hardware, so this property
present this event.


> add specification for #event-cells,
> mediatek,gce-event-names, mediatek,gce-events.
> 
> Signed-off-by: Bibby Hsieh <bibby.hsieh@mediatek.com>
> ---
>  Documentation/devicetree/bindings/mailbox/mtk-gce.txt | 16 +++++++++++++---
>  1 file changed, 13 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/mailbox/mtk-gce.txt b/Documentation/devicetree/bindings/mailbox/mtk-gce.txt
> index 9c0d982..812698f 100644
> --- a/Documentation/devicetree/bindings/mailbox/mtk-gce.txt
> +++ b/Documentation/devicetree/bindings/mailbox/mtk-gce.txt
> @@ -21,12 +21,20 @@ Required properties:
>  	priority: Priority of GCE thread.
>  	atomic_exec: GCE processing continuous packets of commands in atomic
>  		way.
> +- #event-cells: Should be 1.
> +	<&phandle event_number>
> +	phandle: Label name of a gce node.
> +	event_number: the event number defined in 'dt-bindings/gce/mt8173-gce.h'
> +		      or 'dt-binding/gce/mt8183-gce.h'.
>  
>  Required properties for a client device:
>  - mboxes: Client use mailbox to communicate with GCE, it should have this
>    property and list of phandle, mailbox specifiers.
>  - mediatek,gce-subsys: u32, specify the sub-system id which is corresponding
>    to the register address.
> +- mediatek,gce-event-names: the event name can be defined by user.
> +- mediatek,gce-events: u32, the event number defined in
> +  'dt-bindings/gce/mt8173-gce.h' or 'dt-binding/gce/mt8183-gce.h'.

I think both gce-subsys and gce-event are optional and depend on the
hardware design.

Regards,
CK

>  
>  Some vaules of properties are defined in 'dt-bindings/gce/mt8173-gce.h'
>  or 'dt-binding/gce/mt8183-gce.h'. Such as sub-system ids, thread priority, event ids.
> @@ -41,6 +49,7 @@ Example:
>  		clock-names = "gce";
>  		thread-num = CMDQ_THR_MAX_COUNT;
>  		#mbox-cells = <3>;
> +		#event-cells = <1>;
>  	};
>  
>  Example for a client device:
> @@ -50,8 +59,9 @@ Example for a client device:
>  		mboxes = <&gce 0 CMDQ_THR_PRIO_LOWEST 1>,
>  			 <&gce 1 CMDQ_THR_PRIO_LOWEST 1>;
>  		mediatek,gce-subsys = <SUBSYS_1400XXXX>;
> -		mutex-event-eof = <CMDQ_EVENT_MUTEX0_STREAM_EOF
> -				CMDQ_EVENT_MUTEX1_STREAM_EOF>;
> -
> +		mediatek,gce-event-names = "rdma0_sof",
> +					   "rsz0_sof";
> +		mediatek,gce-events = <&gce CMDQ_EVENT_MDP_RDMA0_SOF>,
> +				      <&gce CMDQ_EVENT_MDP_RSZ0_SOF>;
>  		...
>  	};


