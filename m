Return-Path: <SRS0=sufd=TK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 879D1C04A6B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 03:31:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61D9F2084A
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 03:31:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727079AbfEJDb0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 23:31:26 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:11623 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726882AbfEJDbZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 23:31:25 -0400
X-UUID: f7bcf20f63b1405f844762fb0ffd0d35-20190510
X-UUID: f7bcf20f63b1405f844762fb0ffd0d35-20190510
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw02.mediatek.com
        (envelope-from <bibby.hsieh@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 328189043; Fri, 10 May 2019 11:31:22 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 10 May 2019 11:31:21 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 10 May 2019 11:31:21 +0800
Message-ID: <1557459081.29102.4.camel@mtksdaap41>
Subject: Re: [PATCH v5 03/12] dt-binding: gce: add binding for gce subsys
 property
From:   Bibby Hsieh <bibby.hsieh@mediatek.com>
To:     Rob Herring <robh@kernel.org>
CC:     Jassi Brar <jassisinghbrar@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        CK HU <ck.hu@mediatek.com>,
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
Date:   Fri, 10 May 2019 11:31:21 +0800
In-Reply-To: <20190507174110.GA6767@bogus>
References: <20190507081355.52630-1-bibby.hsieh@mediatek.com>
         <20190507081355.52630-4-bibby.hsieh@mediatek.com>
         <20190507174110.GA6767@bogus>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-SNTS-SMTP: 2CE4E89CBFF18FFD220CA801469A51525C75B7E68B1C0A4BF46A2CE75B1E01422000:8
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Rob,

On Tue, 2019-05-07 at 12:41 -0500, Rob Herring wrote:
> On Tue, May 07, 2019 at 04:13:46PM +0800, Bibby Hsieh wrote:
> > tcmdq driver provide a function that get the relationship
> > of sub system number from device node for client.
> > add specification for #subsys-cells, mediatek,gce-subsys.
> > 
> > Signed-off-by: Bibby Hsieh <bibby.hsieh@mediatek.com>
> > ---
> >  .../devicetree/bindings/mailbox/mtk-gce.txt       | 15 ++++++++++++---
> >  1 file changed, 12 insertions(+), 3 deletions(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/mailbox/mtk-gce.txt b/Documentation/devicetree/bindings/mailbox/mtk-gce.txt
> > index 1f7f8f2a3f49..8fd9479bc9f6 100644
> > --- a/Documentation/devicetree/bindings/mailbox/mtk-gce.txt
> > +++ b/Documentation/devicetree/bindings/mailbox/mtk-gce.txt
> > @@ -21,11 +21,19 @@ Required properties:
> >  	priority: Priority of GCE thread.
> >  	atomic_exec: GCE processing continuous packets of commands in atomic
> >  		way.
> > +- #subsys-cells: Should be 3.
> > +	<&phandle subsys_number start_offset size>
> > +	phandle: Label name of a gce node.
> > +	subsys_number: specify the sub-system id which is corresponding
> > +		       to the register address.
> > +	start_offset: the start offset of register address that GCE can access.
> > +	size: the total size of register address that GCE can access.
> 
> Like the #event-cells, do you need this if it isn't variable?
> 

Yes, we need. Because the start_offset and size will be a fix number
when the chip was designed out.
Those two informations will help us to check if the same register
address was wrote by different user.
The checking mechanism is designing...

> >  
> >  Required properties for a client device:
> >  - mboxes: Client use mailbox to communicate with GCE, it should have this
> >    property and list of phandle, mailbox specifiers.
> > -- mediatek,gce-subsys: u32, specify the sub-system id which is corresponding
> > +Optional propertier for a client device:
> > +- mediatek,gce-client-reg: u32, specify the sub-system id which is corresponding
> >    to the register address.
> 
> This isn't a u32, but a phandle + 3 cells (or a list of those). How many 
> entries can there be?

Ok, I will fix it.
> 
> >  
> >  Some vaules of properties are defined in 'dt-bindings/gce/mt8173-gce.h'
> > @@ -40,6 +48,7 @@ Example:
> >  		clocks = <&infracfg CLK_INFRA_GCE>;
> >  		clock-names = "gce";
> >  		#mbox-cells = <3>;
> > +		#subsys-cells = <3>;
> >  	};
> >  
> >  Example for a client device:
> > @@ -48,9 +57,9 @@ Example for a client device:
> >  		compatible = "mediatek,mt8173-mmsys";
> >  		mboxes = <&gce 0 CMDQ_THR_PRIO_LOWEST 1>,
> >  			 <&gce 1 CMDQ_THR_PRIO_LOWEST 1>;
> > -		mediatek,gce-subsys = <SUBSYS_1400XXXX>;
> >  		mutex-event-eof = <CMDQ_EVENT_MUTEX0_STREAM_EOF
> >  				CMDQ_EVENT_MUTEX1_STREAM_EOF>;
> > -
> > +		mediatek,gce-client-reg = <&gce SUBSYS_1400XXXX 0x3000 0x1000>,
> > +					  <&gce SUBSYS_1401XXXX 0x2000 0x100>;
> >  		...
> >  	};
> > -- 
> > 2.18.0
> > 

-- 
Bibby

