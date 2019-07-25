Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 523DDC76186
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 03:20:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3107E22BEB
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 03:20:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388211AbfGYDUe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 23:20:34 -0400
Received: from mailgw02.mediatek.com ([1.203.163.81]:46963 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S2387752AbfGYDUd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 23:20:33 -0400
X-UUID: ed85f5d1925b4024b7446fdc12bebcaf-20190725
X-UUID: ed85f5d1925b4024b7446fdc12bebcaf-20190725
Received: from mtkcas34.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 461284809; Thu, 25 Jul 2019 11:20:21 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 MTKMBS31N2.mediatek.inc (172.27.4.87) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 25 Jul 2019 11:20:19 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 25 Jul 2019 11:20:19 +0800
Message-ID: <1564024819.2621.4.camel@mtksdaap41>
Subject: Re: [PATCH v4, 05/33] dt-bindings: mediatek: add RDMA1 description
 for mt8183 display
From:   CK Hu <ck.hu@mediatek.com>
To:     Rob Herring <robh@kernel.org>
CC:     <yongqiang.niu@mediatek.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Mark Rutland <mark.rutland@arm.com>,
        <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
Date:   Thu, 25 Jul 2019 11:20:19 +0800
In-Reply-To: <20190724201635.GA18345@bogus>
References: <1562625253-29254-1-git-send-email-yongqiang.niu@mediatek.com>
         <1562625253-29254-6-git-send-email-yongqiang.niu@mediatek.com>
         <20190724201635.GA18345@bogus>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-SNTS-SMTP: 7D8A1CCF38AD247D3F162A72E891F36A49E6C52CAB3DEA3F413B16EB119711E62000:8
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Rob:

On Wed, 2019-07-24 at 14:16 -0600, Rob Herring wrote:
> On Tue, Jul 09, 2019 at 06:33:45AM +0800, yongqiang.niu@mediatek.com wrote:
> > From: Yongqiang Niu <yongqiang.niu@mediatek.com>
> > 
> > This patch add RDMA1 description for mt8183 display
> > 
> > Signed-off-by: Yongqiang Niu <yongqiang.niu@mediatek.com>
> > ---
> >  Documentation/devicetree/bindings/display/mediatek/mediatek,disp.txt | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,disp.txt b/Documentation/devicetree/bindings/display/mediatek/mediatek,disp.txt
> > index afd3c90..bb9274a 100644
> > --- a/Documentation/devicetree/bindings/display/mediatek/mediatek,disp.txt
> > +++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,disp.txt
> > @@ -30,6 +30,7 @@ Required properties (all function blocks):
> >  	"mediatek,<chip>-disp-ovl"   		- overlay (4 layers, blending, csc)
> >  	"mediatek,<chip>-disp-ovl-2l"           - overlay (2 layers, blending, csc)
> >  	"mediatek,<chip>-disp-rdma"  		- read DMA / line buffer
> > +	"mediatek,<chip>-disp-rdma1"            - function is same with RDMA, fifo size is different
> 
> This can't be determined by which chip it is? IOW, a chip may have both 
> rdma and rdma1?

In MT8183, there are two different rdma. The difference is the fifo size
in each one. I've a question: is it better to have two compatible string
for each one, or just one compatible string for both but with a property
to set fifo size?

Regards,
CK

> 
> >  	"mediatek,<chip>-disp-wdma"  		- write DMA
> >  	"mediatek,<chip>-disp-ccorr"            - color correction
> >  	"mediatek,<chip>-disp-color" 		- color processor
> > -- 
> > 1.8.1.1.dirty
> > 


