Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A60EDC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 02:55:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A9B92080F
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 02:55:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730757AbfCZCzo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 22:55:44 -0400
Received: from mailgw02.mediatek.com ([1.203.163.81]:27829 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727157AbfCZCzn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 22:55:43 -0400
X-UUID: db69e56abb9b413baa1a4cdef2378883-20190326
X-UUID: db69e56abb9b413baa1a4cdef2378883-20190326
Received: from mtkcas34.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <zhiyong.tao@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 1992935466; Tue, 26 Mar 2019 10:55:36 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS31DR.mediatek.inc
 (172.27.6.102) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 26 Mar
 2019 10:55:34 +0800
Received: from [10.17.3.153] (172.27.4.253) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 26 Mar 2019 10:55:33 +0800
Message-ID: <1553568933.21970.6.camel@mhfsdcap03>
Subject: Re: [PATCH RESEND v3 3/4] arm64: dts: mt8183: add pintcrl device
 node
From:   Zhiyong Tao <zhiyong.tao@mediatek.com>
To:     Nicolas Boichat <drinkcat@chromium.org>
CC:     Rob Herring <robh+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "Matthias Brugger" <matthias.bgg@gmail.com>,
        Sean Wang <sean.wang@kernel.org>,
        srv_heupstream <srv_heupstream@mediatek.com>,
        <hui.liu@mediatek.com>, "Eddie Huang" <eddie.huang@mediatek.com>,
        <chuanjia.liu@mediatek.com>, <biao.huang@mediatek.com>,
        <hongzhou.yang@mediatek.com>, Erin Lo <erin.lo@mediatek.com>,
        Sean Wang <sean.wang@mediatek.com>,
        <devicetree@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>,
        "linux-arm Mailing List" <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>, <linux-gpio@vger.kernel.org>
Date:   Tue, 26 Mar 2019 10:55:33 +0800
In-Reply-To: <CANMq1KCSN11fH0JS72iheDwKjo06ShKiFu+Yn51xVObcvV37GA@mail.gmail.com>
References: <20190325124137.6117-1-zhiyong.tao@mediatek.com>
         <20190325124137.6117-4-zhiyong.tao@mediatek.com>
         <CANMq1KCSN11fH0JS72iheDwKjo06ShKiFu+Yn51xVObcvV37GA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-03-25 at 11:17 -0700, Nicolas Boichat wrote:
> On Mon, Mar 25, 2019 at 5:41 AM Zhiyong Tao <zhiyong.tao@mediatek.com> wrote:
> >
> > The commit adds pintcrl device node for mt8183
> 
> Minor nit: This should say pinctrl (in the commit title as well).
==> Thanks for your suggestion, we will change it in next version.
> 
> >
> > Signed-off-by: Zhiyong Tao <zhiyong.tao@mediatek.com>
> > ---
> >  arch/arm64/boot/dts/mediatek/mt8183.dtsi | 26 +++++++++++++++++++++++++-
> >  1 file changed, 25 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/arm64/boot/dts/mediatek/mt8183.dtsi b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
> > index 75c4881bbe5e..cf92504e2a9b 100644
> > --- a/arch/arm64/boot/dts/mediatek/mt8183.dtsi
> > +++ b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
> > @@ -9,7 +9,7 @@
> >  #include <dt-bindings/interrupt-controller/arm-gic.h>
> >  #include <dt-bindings/interrupt-controller/irq.h>
> >  #include <dt-bindings/power/mt8183-power.h>
> > -
> > +#include "mt8183-pinfunc.h"
> >  / {
> >         compatible = "mediatek,mt8183";
> >         interrupt-parent = <&sysirq>;
> > @@ -197,6 +197,30 @@
> >                         #clock-cells = <1>;
> >                 };
> >
> > +               pio: pinctrl@10005000 {
> > +                       compatible = "mediatek,mt8183-pinctrl";
> > +                       reg = <0 0x10005000 0 0x1000>,
> > +                             <0 0x11f20000 0 0x1000>,
> > +                             <0 0x11e80000 0 0x1000>,
> > +                             <0 0x11e70000 0 0x1000>,
> > +                             <0 0x11e90000 0 0x1000>,
> > +                             <0 0x11d30000 0 0x1000>,
> > +                             <0 0x11d20000 0 0x1000>,
> > +                             <0 0x11c50000 0 0x1000>,
> > +                             <0 0x11f30000 0 0x1000>,
> > +                             <0 0x1000b000 0 0x1000>;
> > +                       reg-names = "iocfg0", "iocfg1", "iocfg2",
> > +                                   "iocfg3", "iocfg4", "iocfg5",
> > +                                   "iocfg6", "iocfg7", "iocfg8",
> > +                                   "eint";
> > +                       gpio-controller;
> > +                       #gpio-cells = <2>;
> > +                       gpio-ranges = <&pio 0 0 192>;
> > +                       interrupt-controller;
> > +                       interrupts = <GIC_SPI 177 IRQ_TYPE_LEVEL_HIGH>;
> > +                       #interrupt-cells = <2>;
> > +               };
> > +
> >                 scpsys: syscon@10006000 {
> >                         compatible = "mediatek,mt8183-scpsys", "syscon";
> >                         #power-domain-cells = <1>;
> > --
> > 2.12.5
> >


