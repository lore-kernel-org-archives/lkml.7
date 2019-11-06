Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4BC0C5DF64
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 08:08:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9765B217F5
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 08:08:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730235AbfKFIIE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 03:08:04 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:21663 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729734AbfKFIIE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 03:08:04 -0500
X-UUID: 8ca62760f9b54534a57f712a1ec937ab-20191106
X-UUID: 8ca62760f9b54534a57f712a1ec937ab-20191106
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by mailgw01.mediatek.com
        (envelope-from <chun-hung.wu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1091685658; Wed, 06 Nov 2019 16:07:54 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs05n1.mediatek.inc (172.21.101.15) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 6 Nov 2019 16:07:50 +0800
Received: from [172.21.77.33] (172.21.77.33) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 6 Nov 2019 16:07:50 +0800
Message-ID: <1573027672.2646.1.camel@mtkswgap22>
Subject: Re: [PATCH 3/3] [3/3] dt-bindings: mmc: mediatek: Add document for
 mt6779
From:   Chun-Hung Wu <chun-hung.wu@mediatek.com>
To:     Rob Herring <robh@kernel.org>
CC:     Chaotian Jing <chaotian.jing@mediatek.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "Matthias Brugger" <matthias.bgg@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Pavel Machek <pavel@ucw.cz>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Pan Bian <bianpan2016@163.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stanley Chu <stanley.chu@mediatek.com>,
        Kuohong Wang <kuohong.wang@mediatek.com>,
        <linux-kernel@vger.kernel.org>, <linux-mmc@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <wsd_upstream@mediatek.com>, <linux-arm-kernel@lists.infradead.org>
Date:   Wed, 6 Nov 2019 16:07:52 +0800
In-Reply-To: <20191106041708.GA26489@bogus>
References: <1572590582-11056-1-git-send-email-chun-hung.wu@mediatek.com>
         <1572590582-11056-3-git-send-email-chun-hung.wu@mediatek.com>
         <20191106041708.GA26489@bogus>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

  Thanks for the reply.
We will prepare another patch set to remove these tags.


On Tue, 2019-11-05 at 22:17 -0600, Rob Herring wrote:
> On Fri, Nov 01, 2019 at 02:43:02PM +0800, Chun-Hung Wu wrote:
> > Add compatible node for mt6779 mmc
> > 
> > Change-Id: Id36a136a75e892c9360ec95c7f52db06f5b308a4
> > CR-Id:
> > Feature:
> 
> Remove these tags.
> 
> > Signed-off-by: Chun-Hung Wu <chun-hung.wu@mediatek.com>
> > ---
> >  Documentation/devicetree/bindings/mmc/mtk-sd.txt | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/mmc/mtk-sd.txt b/Documentation/devicetree/bindings/mmc/mtk-sd.txt
> > index 8a532f4..0c9cf6a 100644
> > --- a/Documentation/devicetree/bindings/mmc/mtk-sd.txt
> > +++ b/Documentation/devicetree/bindings/mmc/mtk-sd.txt
> > @@ -12,6 +12,7 @@ Required properties:
> >  	"mediatek,mt8173-mmc": for mmc host ip compatible with mt8173
> >  	"mediatek,mt8183-mmc": for mmc host ip compatible with mt8183
> >  	"mediatek,mt8516-mmc": for mmc host ip compatible with mt8516
> > +	"mediatek,mt6779-mmc": for mmc host ip compatible with mt6779
> >  	"mediatek,mt2701-mmc": for mmc host ip compatible with mt2701
> >  	"mediatek,mt2712-mmc": for mmc host ip compatible with mt2712
> >  	"mediatek,mt7622-mmc": for MT7622 SoC
> > -- 
> > 1.9.1
> > 


