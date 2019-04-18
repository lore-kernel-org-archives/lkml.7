Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21BACC10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 08:18:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB2F52184B
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 08:18:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388371AbfDRIS1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 04:18:27 -0400
Received: from mailgw02.mediatek.com ([1.203.163.81]:40403 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S2388315AbfDRISX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 04:18:23 -0400
X-UUID: 0fee49785471427ba9a5605c483fc628-20190418
X-UUID: 0fee49785471427ba9a5605c483fc628-20190418
Received: from mtkcas35.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <leilk.liu@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 812527592; Thu, 18 Apr 2019 16:18:11 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS31N1.mediatek.inc
 (172.27.4.69) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Thu, 18 Apr
 2019 16:18:09 +0800
Received: from [10.17.3.153] (172.27.4.253) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 18 Apr 2019 16:18:07 +0800
Message-ID: <1555575487.7441.6.camel@mhfsdcap03>
Subject: Re: [PATCH 19/24] dt-bindings: spi: spi-mt65xx: add support for
 MT8516
From:   lei liu <leilk.liu@mediatek.com>
To:     Fabien Parent <fparent@baylibre.com>
CC:     Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mark Brown <broonie@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <ryder.lee@mediatek.com>,
        <linux-watchdog@vger.kernel.org>, <jjian.zhou@mediatek.com>,
        <wenzhen.yu@mediatek.com>,
        Stephane Le Provost <stephane.leprovost@mediatek.com>,
        <sean.wang@kernel.org>, <linux-mmc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <yong.mao@mediatek.com>,
        <linux-spi@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <hsin-hsiung.wang@mediatek.com>, <linux-serial@vger.kernel.org>,
        <linux-clk@vger.kernel.org>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        <linux-i2c@vger.kernel.org>
Date:   Thu, 18 Apr 2019 16:18:07 +0800
In-Reply-To: <CAOwMV_yKAm1zar6buhe25O56AkAX8e0nXnm4GmqhvHC-yagKfQ@mail.gmail.com>
References: <20190323211612.860-1-fparent@baylibre.com>
         <20190323211612.860-20-fparent@baylibre.com>
         <5bc3fbfa-6d7e-08d3-116c-a8f78bc680cd@gmail.com>
         <1555403151.7441.4.camel@mhfsdcap03>
         <CAOwMV_yKAm1zar6buhe25O56AkAX8e0nXnm4GmqhvHC-yagKfQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-04-18 at 10:05 +0200, Fabien Parent wrote:
> On Tue, Apr 16, 2019 at 10:25 AM lei liu <leilk.liu@mediatek.com> wrote:
> >
> > On Tue, 2019-04-16 at 09:55 +0200, Matthias Brugger wrote:
> > >
> > > On 23/03/2019 22:16, Fabien Parent wrote:
> > > > Add binding documentation of spi-mt65xx for MT8516 SoC.
> > > >
> > > > Signed-off-by: Fabien Parent <fparent@baylibre.com>
> > > > ---
> > > >  Documentation/devicetree/bindings/spi/spi-mt65xx.txt | 1 +
> > > >  1 file changed, 1 insertion(+)
> > > >
> > >
> > >
> > > applied to v5.1-next/dts64
> > >
> > > Mark let me know if you want to take it through your tree and I drop the patch.
> > >
> > > > diff --git a/Documentation/devicetree/bindings/spi/spi-mt65xx.txt b/Documentation/devicetree/bindings/spi/spi-mt65xx.txt
> > > > index 69c356767cf8..69ac5976b952 100644
> > > > --- a/Documentation/devicetree/bindings/spi/spi-mt65xx.txt
> > > > +++ b/Documentation/devicetree/bindings/spi/spi-mt65xx.txt
> > > > @@ -10,6 +10,7 @@ Required properties:
> > > >      - mediatek,mt8135-spi: for mt8135 platforms
> > > >      - mediatek,mt8173-spi: for mt8173 platforms
> > > >      - mediatek,mt8183-spi: for mt8183 platforms
> > > > +    - "mediatek,mt8516-spi", "mediatek,mt2701-spi": for mt8516 platforms
> > Hi Fabien,
> > mt8516 SPI design comes from mt2712 and it's different from mt2701. Here
> > it should compatible with mt2712.
> 
> Ok, thanks. I will retry with the mt2712 compatible.
> 

Hi, I already send mt8516 spi patch and it's applied by Mark. Please
don't do it again. Thanks.

> > > >
> > > >  - #address-cells: should be 1.
> > > >
> > > >
> > >
> > > _______________________________________________
> > > Linux-mediatek mailing list
> > > Linux-mediatek@lists.infradead.org
> > > http://lists.infradead.org/mailman/listinfo/linux-mediatek
> >
> >


