Return-Path: <SRS0=sufd=TK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CAD9C04A6B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 03:27:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 046162084A
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 03:27:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727051AbfEJD1r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 23:27:47 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:12110 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726880AbfEJD1q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 23:27:46 -0400
X-UUID: 82b65e84fa1e4b81922e63f6c39d45b8-20190510
X-UUID: 82b65e84fa1e4b81922e63f6c39d45b8-20190510
Received: from mtkcas09.mediatek.inc [(172.21.101.178)] by mailgw01.mediatek.com
        (envelope-from <bibby.hsieh@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 143048053; Fri, 10 May 2019 11:27:39 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs03n2.mediatek.inc (172.21.101.182) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 10 May 2019 11:27:37 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 10 May 2019 11:27:37 +0800
Message-ID: <1557458857.29102.1.camel@mtksdaap41>
Subject: Re: [PATCH v5 04/12] dt-binding: gce: add binding for gce event
 property
From:   Bibby Hsieh <bibby.hsieh@mediatek.com>
To:     CK Hu <ck.hu@mediatek.com>
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
Date:   Fri, 10 May 2019 11:27:37 +0800
In-Reply-To: <1557292247.3936.5.camel@mtksdaap41>
References: <20190507081355.52630-1-bibby.hsieh@mediatek.com>
         <20190507081355.52630-5-bibby.hsieh@mediatek.com>
         <1557292247.3936.5.camel@mtksdaap41>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-SNTS-SMTP: 98BB702262903B75266ED8544CC84F00670BF243D4343F61910C1BCF47204AAE2000:8
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, CK,

On Wed, 2019-05-08 at 13:10 +0800, CK Hu wrote:
> Hi, Bibby:
> 
> On Tue, 2019-05-07 at 16:13 +0800, Bibby Hsieh wrote:
> > Client hardware would send event to GCE hardware,
> > mediatek,gce-event-names and mediatek,gce-events
> > can be used to present the event.
> > 
> > Signed-off-by: Bibby Hsieh <bibby.hsieh@mediatek.com>
> > ---
> >  Documentation/devicetree/bindings/mailbox/mtk-gce.txt | 9 +++++++--
> >  1 file changed, 7 insertions(+), 2 deletions(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/mailbox/mtk-gce.txt b/Documentation/devicetree/bindings/mailbox/mtk-gce.txt
> > index 8fd9479bc9f6..76491f194c56 100644
> > --- a/Documentation/devicetree/bindings/mailbox/mtk-gce.txt
> > +++ b/Documentation/devicetree/bindings/mailbox/mtk-gce.txt
> > @@ -35,6 +35,9 @@ Required properties for a client device:
> >  Optional propertier for a client device:
> >  - mediatek,gce-client-reg: u32, specify the sub-system id which is corresponding
> >    to the register address.
> > +- mediatek,gce-event-names: the event name can be defined by user.
> 
> gce-event is like an interrupt from client hardware to GCE hardware, we
> do not give a name to an interrupt, so do we need to give a name for
> gce-event?
> 

Yes, we need to know the name of gce-ecent.
The name can help users to figure out the problems when GCE meet the
event time out errors.


> Regards,
> CK
> 
> > +- mediatek,gce-events: u32, the event number defined in
> > +  'dt-bindings/gce/mt8173-gce.h' or 'dt-binding/gce/mt8183-gce.h'.
> >  
> >  Some vaules of properties are defined in 'dt-bindings/gce/mt8173-gce.h'
> >  or 'dt-binding/gce/mt8183-gce.h'. Such as sub-system ids, thread priority, event ids.
> > @@ -57,8 +60,10 @@ Example for a client device:
> >  		compatible = "mediatek,mt8173-mmsys";
> >  		mboxes = <&gce 0 CMDQ_THR_PRIO_LOWEST 1>,
> >  			 <&gce 1 CMDQ_THR_PRIO_LOWEST 1>;
> > -		mutex-event-eof = <CMDQ_EVENT_MUTEX0_STREAM_EOF
> > -				CMDQ_EVENT_MUTEX1_STREAM_EOF>;
> > +		mediatek,gce-event-names = "rdma0_sof",
> > +					   "rsz0_sof";
> > +		mediatek,gce-events = <CMDQ_EVENT_MDP_RDMA0_SOF>,
> > +				      <CMDQ_EVENT_MDP_RSZ0_SOF>;
> >  		mediatek,gce-client-reg = <&gce SUBSYS_1400XXXX 0x3000 0x1000>,
> >  					  <&gce SUBSYS_1401XXXX 0x2000 0x100>;
> >  		...
> 
> 

-- 
Bibby

