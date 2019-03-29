Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 203BBC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 02:39:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE8622075E
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 02:39:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728677AbfC2Cj1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 22:39:27 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:23019 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727675AbfC2Cj1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 22:39:27 -0400
X-UUID: 13ed2f3e1299475eb2e9f34f7db4a591-20190329
X-UUID: 13ed2f3e1299475eb2e9f34f7db4a591-20190329
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <bibby.hsieh@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 704832312; Fri, 29 Mar 2019 10:38:53 +0800
Received: from MTKMBS01DR.mediatek.inc (172.21.101.111) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 29 Mar 2019 10:38:51 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs01dr.mediatek.inc (172.21.101.111) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 29 Mar 2019 10:38:51 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 29 Mar 2019 10:38:51 +0800
Message-ID: <1553827131.12091.8.camel@mtksdaap41>
Subject: Re: [PATCH v3 03/12] dt-binding: gce: add binding for gce event
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
Date:   Fri, 29 Mar 2019 10:38:51 +0800
In-Reply-To: <20190328184425.GA21602@bogus>
References: <1553739573-19708-1-git-send-email-bibby.hsieh@mediatek.com>
         <1553739573-19708-4-git-send-email-bibby.hsieh@mediatek.com>
         <20190328184425.GA21602@bogus>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-TM-SNTS-SMTP: 7B6A94C4E5F9024DA14AD73D52EF93B57D22F1FB552FC9DB9658264761A902CD2000:8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Rob,

Thanks for your review and comments.

On Thu, 2019-03-28 at 13:44 -0500, Rob Herring wrote:
> On Thu, Mar 28, 2019 at 10:19:24AM +0800, Bibby Hsieh wrote:
> > Client hardware would send event to GCE hardware,
> > so #event-cells, mediatek,gce-event-names, mediatek,gce-events.
> > present the event.
> > 
> > Signed-off-by: Bibby Hsieh <bibby.hsieh@mediatek.com>
> > ---
> >  Documentation/devicetree/bindings/mailbox/mtk-gce.txt | 17 ++++++++++++++---
> >  1 file changed, 14 insertions(+), 3 deletions(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/mailbox/mtk-gce.txt b/Documentation/devicetree/bindings/mailbox/mtk-gce.txt
> > index 1f7f8f2..2f175d6 100644
> > --- a/Documentation/devicetree/bindings/mailbox/mtk-gce.txt
> > +++ b/Documentation/devicetree/bindings/mailbox/mtk-gce.txt
> > @@ -21,12 +21,21 @@ Required properties:
> >  	priority: Priority of GCE thread.
> >  	atomic_exec: GCE processing continuous packets of commands in atomic
> >  		way.
> > +- #event-cells: Should be 1.
> > +	<&phandle event_number>
> > +	phandle: Label name of a gce node.
> > +	event_number: the event number defined in 'dt-bindings/gce/mt8173-gce.h'
> > +		      or 'dt-binding/gce/mt8183-gce.h'.
> 
> You only need to have a #*-cells if the number is variable.
> 
I think #event-cells can be removed here.The cmdq_dev_get_event can be
modified as:

+u32 cmdq_dev_get_event(struct device *dev, const char *name)
+{
+	<... snip ...>

+	index = of_property_match_string(dev->of_node,
+					 "mediatek,gce-event-names", 
+	<... snip ...>

+
+	if (of_property_read_u32_index(dev->of_node, "mediatek,gce-events",
index, &result)) {
+		dev_err(dev, "can't parse gce-events property");
+
+		return -ENODEV;
+	}
+
+	return result;
+}
+EXPORT_SYMBOL(cmdq_dev_get_event);

> What are 'events' here? Sounds like interrupts or MSI?
Yes, events is a kind of communicating method from the other hardware
with GCE. It's likes interrupts.

> 
> >  
> >  Required properties for a client device:
> >  - mboxes: Client use mailbox to communicate with GCE, it should have this
> >    property and list of phandle, mailbox specifiers.
> >  - mediatek,gce-subsys: u32, specify the sub-system id which is corresponding
> >    to the register address.
> > +Optional propertier for a client device:
> > +- mediatek,gce-event-names: the event name can be defined by user.
> > +- mediatek,gce-events: u32, the event number defined in
> > +  'dt-bindings/gce/mt8173-gce.h' or 'dt-binding/gce/mt8183-gce.h'.
> >  
> >  Some vaules of properties are defined in 'dt-bindings/gce/mt8173-gce.h'
> >  or 'dt-binding/gce/mt8183-gce.h'. Such as sub-system ids, thread priority, event ids.
> > @@ -40,6 +49,7 @@ Example:
> >  		clocks = <&infracfg CLK_INFRA_GCE>;
> >  		clock-names = "gce";
> >  		#mbox-cells = <3>;
> > +		#event-cells = <1>;
> >  	};
> >  
> >  Example for a client device:
> > @@ -49,8 +59,9 @@ Example for a client device:
> >  		mboxes = <&gce 0 CMDQ_THR_PRIO_LOWEST 1>,
> >  			 <&gce 1 CMDQ_THR_PRIO_LOWEST 1>;
> >  		mediatek,gce-subsys = <SUBSYS_1400XXXX>;
> > -		mutex-event-eof = <CMDQ_EVENT_MUTEX0_STREAM_EOF
> > -				CMDQ_EVENT_MUTEX1_STREAM_EOF>;
> > -
> > +		mediatek,gce-event-names = "rdma0_sof",
> > +					   "rsz0_sof";
> > +		mediatek,gce-events = <&gce CMDQ_EVENT_MDP_RDMA0_SOF>,
> > +				      <&gce CMDQ_EVENT_MDP_RSZ0_SOF>;
> >  		...
> >  	};
> > -- 
> > 1.9.1
> > 

-- 
Bibby

