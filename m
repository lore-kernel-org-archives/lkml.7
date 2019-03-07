Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCAD2C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 01:47:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B544320675
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 01:47:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726561AbfCGBrt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 20:47:49 -0500
Received: from mailgw02.mediatek.com ([1.203.163.81]:36571 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726197AbfCGBrs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 20:47:48 -0500
X-UUID: 0e46c200a40245bd9b0b98cd4cb5f06f-20190307
X-UUID: 0e46c200a40245bd9b0b98cd4cb5f06f-20190307
Received: from mtkcas32.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <houlong.wei@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 215947327; Thu, 07 Mar 2019 09:47:41 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS31N1.mediatek.inc
 (172.27.4.69) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Thu, 7 Mar
 2019 09:47:40 +0800
Received: from [10.17.3.153] (172.27.4.253) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 7 Mar 2019 09:47:39 +0800
Message-ID: <1551923259.32207.10.camel@mhfsdcap03>
Subject: Re: [PATCH] arm64: dts: add gce node for mt8183
From:   houlong wei <houlong.wei@mediatek.com>
To:     CK Hu <ck.hu@mediatek.com>, <bibby.hsieh@mediatek.com>
CC:     Bibby Hsieh =?UTF-8?Q?=28=E8=AC=9D=E6=BF=9F=E9=81=A0=29?= 
        <Bibby.Hsieh@mediatek.com>, Jassi Brar <jassisinghbrar@gmail.com>,
        "Matthias Brugger" <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        "Daniel Kurtz" <djkurtz@chromium.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        srv_heupstream <srv_heupstream@mediatek.com>,
        Sascha Hauer <kernel@pengutronix.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "Nicolas Boichat" <drinkcat@chromium.org>,
        YT Shen =?UTF-8?Q?=28=E6=B2=88=E5=B2=B3=E9=9C=86=29?= 
        <Yt.Shen@mediatek.com>,
        Daoyuan Huang =?UTF-8?Q?=28=E9=BB=83=E9=81=93=E5=8E=9F=29?= 
        <Daoyuan.Huang@mediatek.com>,
        Jiaguang Zhang =?UTF-8?Q?=28=E5=BC=A0=E5=8A=A0=E5=B9=BF=29?= 
        <Jiaguang.Zhang@mediatek.com>,
        Dennis-YC Hsieh =?UTF-8?Q?=28=E8=AC=9D=E5=AE=87=E5=93=B2=29?= 
        <Dennis-YC.Hsieh@mediatek.com>,
        Ginny Chen =?UTF-8?Q?=28=E9=99=B3=E6=B2=BB=E5=82=91=29?= 
        <ginny.chen@mediatek.com>,
        Kendrick Hsu =?UTF-8?Q?=28=E5=BE=90=E5=AD=90=E5=87=A1=29?= 
        <Kendrick.Hsu@mediatek.com>,
        Frederic Chen =?UTF-8?Q?=28=E9=99=B3=E4=BF=8A=E5=85=83=29?= 
        <Frederic.Chen@mediatek.com>, <houlong.wei@mediatek.com>
Date:   Thu, 7 Mar 2019 09:47:39 +0800
In-Reply-To: <1551921866.20144.1.camel@mtksdaap41>
References: <1551867024-52951-1-git-send-email-bibby.hsieh@mediatek.com>
         <1551921866.20144.1.camel@mtksdaap41>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-03-07 at 09:24 +0800, CK Hu wrote:
> Hi, Bibby:
> 
> On Wed, 2019-03-06 at 18:10 +0800, Bibby Hsieh wrote: 
> > This patch need based on v5.0-rc1 and these series
> > http://lists.infradead.org/pipermail/linux-mediatek/2019-February/017570.html
> > http://lists.infradead.org/pipermail/linux-mediatek/2019-February/017320.html
> > http://lists.infradead.org/pipermail/linux-mediatek/2019-January/017196.html
> > http://lists.infradead.org/pipermail/linux-mediatek/2019-March/018005.html
> > 
> > add gce device node for mt8183
> > 
> > Signed-off-by: Bibby Hsieh <bibby.hsieh@mediatek.com>
> > ---
> >  arch/arm64/boot/dts/mediatek/mt8183.dtsi | 13 +++++++++++++
> >  1 file changed, 13 insertions(+)
> > 
> > diff --git a/arch/arm64/boot/dts/mediatek/mt8183.dtsi b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
> > index 165b859..5006368 100644
> > --- a/arch/arm64/boot/dts/mediatek/mt8183.dtsi
> > +++ b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
> > @@ -8,6 +8,7 @@
> >  #include <dt-bindings/clock/mt8183-clk.h>
> >  #include <dt-bindings/interrupt-controller/arm-gic.h>
> >  #include <dt-bindings/interrupt-controller/irq.h>
> > +#include <dt-bindings/gce/mt8183-gce.h>
> >  #include "mt8183-pinfunc.h"
> >  
> >  / {
> > @@ -238,6 +239,18 @@
> >  			clock-names = "spi", "wrap";
> >  		};
> >  
> > +		gce: gce@10238000 {
> > +			compatible = "mediatek,mt8183-gce";
> > +			reg = <0 0x10238000 0 0x4000>;
> > +			interrupts = <GIC_SPI 162 IRQ_TYPE_LEVEL_LOW>;
> > +			thread-num = <CMDQ_THR_MAX_COUNT>;
> 
> I does not find 'thread-num' in binding document [1].
> 
> [1]
> https://www.kernel.org/doc/Documentation/devicetree/bindings/mailbox/mtk-gce.txt
> 
> Regards,
> CK

The property "thread-num" is not used and and it was removed from the
properties description, but I forgot to remove it from the example. That
is misleading and I'm sorry for that. @Bibby, could you please help
remove it from the example in mtk-gce.txt if you would upload a new
version?
> 
> > +			#mbox-cells = <3>;
> > +			#gce-event-cells = <1>;
> > +			#gce-subsys-cells = <2>;
> > +			clocks = <&infracfg CLK_INFRA_GCE>;
> > +			clock-names = "gce";
> > +		};
> > +
> >  		uart0: serial@11002000 {
> >  			compatible = "mediatek,mt8183-uart",
> >  				     "mediatek,mt6577-uart";
> 


