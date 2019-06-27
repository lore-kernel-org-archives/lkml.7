Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECB84C48BD6
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 07:25:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA67C20843
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 07:25:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726559AbfF0HZh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 03:25:37 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:15498 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726054AbfF0HZg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 03:25:36 -0400
X-UUID: 614d39dd1c094839a0d063f808a5f889-20190627
X-UUID: 614d39dd1c094839a0d063f808a5f889-20190627
Received: from mtkcas32.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <qii.wang@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 916891549; Thu, 27 Jun 2019 15:25:29 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS31N2.mediatek.inc
 (172.27.4.87) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Thu, 27 Jun
 2019 15:25:27 +0800
Received: from [10.17.3.153] (172.27.4.253) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 27 Jun 2019 15:25:27 +0800
Message-ID: <1561620327.12217.27.camel@mhfsdcap03>
Subject: Re: [PATCH v2 1/2] dt-bindings: i3c: Document MediaTek I3C master
 bindings
From:   Qii Wang <qii.wang@mediatek.com>
To:     Boris Brezillon <boris.brezillon@collabora.com>
CC:     <bbrezillon@kernel.org>, <matthias.bgg@gmail.com>,
        <linux-i3c@lists.infradead.org>, <gregkh@linuxfoundation.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>, <leilk.liu@mediatek.com>,
        <liguo.zhang@mediatek.com>, <xinping.qian@mediatek.com>
Date:   Thu, 27 Jun 2019 15:25:27 +0800
In-Reply-To: <20190626182339.0c6301a2@collabora.com>
References: <1561527388-4829-1-git-send-email-qii.wang@mediatek.com>
         <1561527388-4829-2-git-send-email-qii.wang@mediatek.com>
         <20190626182339.0c6301a2@collabora.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-06-26 at 18:23 +0200, Boris Brezillon wrote:
> On Wed, 26 Jun 2019 13:36:27 +0800
> Qii Wang <qii.wang@mediatek.com> wrote:
> 
> > Document MediaTek I3C master DT bindings.
> > 
> > Signed-off-by: Qii Wang <qii.wang@mediatek.com>
> > ---
> >  .../devicetree/bindings/i3c/mtk,i3c-master.txt     |   47 ++++++++++++++++++++
> >  1 file changed, 47 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/i3c/mtk,i3c-master.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/i3c/mtk,i3c-master.txt b/Documentation/devicetree/bindings/i3c/mtk,i3c-master.txt
> > new file mode 100644
> > index 0000000..3fd4f17
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/i3c/mtk,i3c-master.txt
> > @@ -0,0 +1,47 @@
> > +Bindings for MediaTek I3C master block
> > +=====================================
> > +
> > +Required properties:
> > +--------------------
> > +- compatible: shall be "mediatek,i3c-master"
> > +- reg: physical base address of the controller and apdma base, length of
> > +  memory mapped region.
> > +- reg-names: should be "main" for controller and "dma" for apdma.
> > +- interrupts: interrupt number to the cpu.
> 
> Depending on the interrupt controller, each interrupt cell might
> contain more than just the interrupt number.
> 

ok, I will modify it as "the interrupt line connected to this I3C
master"

> > +- clocks: clock name from clock manager.
> 
> This property does not contain clock names but clk references.
> 

ok, I will modify it as "shall reference the i3c and apdma clocks"

> > +- clock-names: must include "main" and "dma".
> > +
> > +Mandatory properties defined by the generic binding (see
> > +Documentation/devicetree/bindings/i3c/i3c.txt for more details):
> > +
> > +- #address-cells: shall be set to 3
> > +- #size-cells: shall be set to 0
> > +
> > +Optional properties defined by the generic binding (see
> > +Documentation/devicetree/bindings/i3c/i3c.txt for more details):
> > +
> > +- i2c-scl-hz
> > +- i3c-scl-hz
> > +
> > +I3C device connected on the bus follow the generic description (see
> > +Documentation/devicetree/bindings/i3c/i3c.txt for more details).
> > +
> > +Example:
> > +
> > +	i3c0: i3c@1100d000 {
> > +		compatible = "mediatek,i3c-master";
> > +		reg = <0x1100d000 0x100>,
> > +		      <0x11000300 0x80>;
> > +		reg-names = "main", "dma";
> > +		interrupts = <GIC_SPI 44 IRQ_TYPE_LEVEL_LOW>;
> > +		clocks = <&i3c0_ck>, <&ap_dma_ck>;
> > +		clock-names = "main", "dma";
> > +		#address-cells = <1>;
> > +		#size-cells = <0>;
> > +		i2c-scl-hz = <100000>;
> > +
> > +		nunchuk: nunchuk@52 {
> > +			compatible = "nintendo,nunchuk";
> > +			reg = <0x52 0x80000010 0>;
> 
> reg is wrong here, should be
> 
> 			reg = <0x52 0x0 0x10>;
> 
> While at it, can you send a patch to fix the example in the cadence
> binding doc?
> 

ok, I will do it. Thanks for your review.

> > +		};
> > +	};
> 


