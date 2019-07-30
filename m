Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7B76C76186
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 01:34:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81D0D2070D
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 01:34:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730560AbfG3Be0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 21:34:26 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:25672 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729221AbfG3BeZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 21:34:25 -0400
X-UUID: fa52ff4a3a274579b251fa276632f2cb-20190730
X-UUID: fa52ff4a3a274579b251fa276632f2cb-20190730
Received: from mtkcas35.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <qii.wang@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 2079832734; Tue, 30 Jul 2019 09:34:16 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS31N2.mediatek.inc
 (172.27.4.87) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 30 Jul
 2019 09:34:13 +0800
Received: from [10.17.3.153] (172.27.4.253) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 30 Jul 2019 09:34:13 +0800
Message-ID: <1564450453.24702.14.camel@mhfsdcap03>
Subject: Re: [PATCH v3 1/2] dt-bindings: i3c: Document MediaTek I3C master
 bindings
From:   Qii Wang <qii.wang@mediatek.com>
To:     Boris Brezillon <boris.brezillon@collabora.com>
CC:     Rob Herring <robh@kernel.org>, <bbrezillon@kernel.org>,
        <matthias.bgg@gmail.com>, <mark.rutland@arm.com>,
        <linux-i3c@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>, <leilk.liu@mediatek.com>,
        <liguo.zhang@mediatek.com>, <xinping.qian@mediatek.com>
Date:   Tue, 30 Jul 2019 09:34:13 +0800
In-Reply-To: <20190727111859.315994c3@collabora.com>
References: <1562677762-24067-1-git-send-email-qii.wang@mediatek.com>
         <1562677762-24067-2-git-send-email-qii.wang@mediatek.com>
         <20190724202119.GA26566@bogus> <1564190613.24702.11.camel@mhfsdcap03>
         <20190727111859.315994c3@collabora.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-SNTS-SMTP: 91A1554D3BC24F029BD720EAFB2775A8A7F8762EFAD65B4F447638B10A285CF22000:8
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2019-07-27 at 11:18 +0200, Boris Brezillon wrote:
> On Sat, 27 Jul 2019 09:23:33 +0800
> Qii Wang <qii.wang@mediatek.com> wrote:
> 
> > On Wed, 2019-07-24 at 14:21 -0600, Rob Herring wrote:
> > > On Tue, Jul 09, 2019 at 09:09:21PM +0800, Qii Wang wrote:  
> > > > Document MediaTek I3C master DT bindings.
> > > > 
> > > > Signed-off-by: Qii Wang <qii.wang@mediatek.com>
> > > > ---
> > > >  .../devicetree/bindings/i3c/mtk,i3c-master.txt     |   48 ++++++++++++++++++++
> > > >  1 file changed, 48 insertions(+)
> > > >  create mode 100644 Documentation/devicetree/bindings/i3c/mtk,i3c-master.txt
> > > > 
> > > > diff --git a/Documentation/devicetree/bindings/i3c/mtk,i3c-master.txt b/Documentation/devicetree/bindings/i3c/mtk,i3c-master.txt
> > > > new file mode 100644
> > > > index 0000000..d32eda6
> > > > --- /dev/null
> > > > +++ b/Documentation/devicetree/bindings/i3c/mtk,i3c-master.txt
> > > > @@ -0,0 +1,48 @@
> > > > +Bindings for MediaTek I3C master block
> > > > +=====================================
> > > > +
> > > > +Required properties:
> > > > +--------------------
> > > > +- compatible: shall be "mediatek,i3c-master"  
> > > 
> > > Needs to be SoC specific.
> > >   
> > 
> > We hope that the SOCs will use the same driver and try to avoid big
> > changes. If there are inevitable changes in the future, then we will
> > modify the compatible to be SoC specific. cdns,i3c-master.txt is not SoC
> > specific either.
> 
> The cadence case is a bit different I think. When the driver was
> developed there was no SoC integrating this IP. I guess Mediatek knows
> already which SoC(s) will embed the I3C master block.
> 

ok, I will modify it as "mediatek,mt8183-i3c".

> > 
> > > > +- reg: physical base address of the controller and apdma base, length of
> > > > +  memory mapped region.
> > > > +- reg-names: shall be "main" for master controller and "dma" for apdma.
> > > > +- interrupts: the interrupt line connected to this I3C master.
> > > > +- clocks: shall reference the i3c and apdma clocks.
> > > > +- clock-names: shall include "main" and "dma".
> > > > +
> > > > +Mandatory properties defined by the generic binding (see
> > > > +Documentation/devicetree/bindings/i3c/i3c.txt for more details):
> > > > +
> > > > +- #address-cells: shall be set to 3
> > > > +- #size-cells: shall be set to 0
> > > > +
> > > > +Optional properties defined by the generic binding (see
> > > > +Documentation/devicetree/bindings/i3c/i3c.txt for more details):
> > > > +
> > > > +- i2c-scl-hz
> > > > +- i3c-scl-hz
> > > > +
> > > > +I3C device connected on the bus follow the generic description (see
> > > > +Documentation/devicetree/bindings/i3c/i3c.txt for more details).
> > > > +
> > > > +Example:
> > > > +
> > > > +	i3c0: i3c@1100d000 {
> > > > +		compatible = "mediatek,i3c-master";
> > > > +		reg = <0x1100d000 0x1000>,
> > > > +		      <0x11000300 0x80>;
> > > > +		reg-names = "main", "dma";
> > > > +		interrupts = <GIC_SPI 44 IRQ_TYPE_LEVEL_LOW>;
> > > > +		clocks = <&infracfg CLK_INFRA_I3C0>,
> > > > +			 <&infracfg CLK_INFRA_AP_DMA>;
> > > > +		clock-names = "main", "dma";
> > > > +		#address-cells = <3>;
> > > > +		#size-cells = <0>;
> > > > +		i2c-scl-hz = <100000>;
> > > > +
> > > > +		nunchuk: nunchuk@52 {
> > > > +			compatible = "nintendo,nunchuk";
> > > > +			reg = <0x52 0x0 0x10>;
> > > > +		};
> > > > +	};
> > > > -- 
> > > > 1.7.9.5
> > > >   
> > 
> > 
> 


