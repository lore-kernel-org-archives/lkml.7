Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C5CFC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 02:03:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AC9A214D8
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 02:03:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730683AbfB1CDs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 21:03:48 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:43446 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730649AbfB1CDs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 21:03:48 -0500
X-UUID: 1fe05881b1af47fca3a0cc347b992b6c-20190228
X-UUID: 1fe05881b1af47fca3a0cc347b992b6c-20190228
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
        (envelope-from <seiya.wang@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 860474768; Thu, 28 Feb 2019 10:03:38 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs02n1.mediatek.inc (172.21.101.77) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 28 Feb 2019 10:03:37 +0800
Received: from [172.21.84.99] (172.21.84.99) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 28 Feb 2019 10:03:37 +0800
Message-ID: <1551319417.3477.0.camel@mtksdccf07>
Subject: Re: [PATCH v2 2/2] clk: mediatek: correct cpu clock name for MT8173
 SoC
From:   Seiya Wang <seiya.wang@mediatek.com>
To:     Stephen Boyd <sboyd@kernel.org>
CC:     Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        "Rob Herring" <robh+dt@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>
Date:   Thu, 28 Feb 2019 10:03:37 +0800
In-Reply-To: <155120509627.260864.5936412356126577519@swboyd.mtv.corp.google.com>
References: <20190225065112.3400-1-seiya.wang@mediatek.com>
         <20190225065112.3400-2-seiya.wang@mediatek.com>
         <155120509627.260864.5936412356126577519@swboyd.mtv.corp.google.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-02-26 at 10:18 -0800, Stephen Boyd wrote:
> Quoting Seiya Wang (2019-02-24 22:51:12)
> > diff --git a/include/dt-bindings/clock/mt8173-clk.h b/include/dt-bindings/clock/mt8173-clk.h
> > index 8aea623dd518..76e4e5b65353 100644
> > --- a/include/dt-bindings/clock/mt8173-clk.h
> > +++ b/include/dt-bindings/clock/mt8173-clk.h
> > @@ -194,7 +194,8 @@
> >  #define CLK_INFRA_PMICWRAP             11
> >  #define CLK_INFRA_CLK_13M              12
> >  #define CLK_INFRA_CA53SEL               13
> > -#define CLK_INFRA_CA57SEL               14
> > +#define CLK_INFRA_CA57SEL               14 /* Deprecated. Don't use it. */
> > +#define CLK_INFRA_CA72SEL               14
> 
> Also, please send a followup patch to remove the deprecated define later
> when the dts file is fixed up.
> 

Sure. Thank you so much~

