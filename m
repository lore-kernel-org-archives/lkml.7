Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E945C282DA
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 02:42:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A3CD20869
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 02:42:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726797AbfDLCma (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 22:42:30 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:56692 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726661AbfDLCma (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 22:42:30 -0400
X-UUID: 66d88c511ae54b0db42b8d4c3e9155bc-20190412
X-UUID: 66d88c511ae54b0db42b8d4c3e9155bc-20190412
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw01.mediatek.com
        (envelope-from <weiyi.lu@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1157262839; Fri, 12 Apr 2019 10:42:22 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 12 Apr 2019 10:42:17 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 12 Apr 2019 10:42:17 +0800
Message-ID: <1555036937.2654.5.camel@mtksdaap41>
Subject: Re: [PATCH v5 6/9] clk: mediatek: Add flags support for mtk_gate
 data
From:   Weiyi Lu <weiyi.lu@mediatek.com>
To:     Stephen Boyd <sboyd@kernel.org>
CC:     Matthias Brugger <matthias.bgg@gmail.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Rob Herring <robh@kernel.org>,
        Stephen Boyd <sboyd@codeaurora.org>,
        James Liao <jamesjj.liao@mediatek.com>,
        <srv_heupstream@mediatek.com>, <linux-kernel@vger.kernel.org>,
        <stable@vger.kernel.org>, Fan Chen <fan.chen@mediatek.com>,
        <linux-mediatek@lists.infradead.org>, <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Date:   Fri, 12 Apr 2019 10:42:17 +0800
In-Reply-To: <155501399858.20095.16525048679717411283@swboyd.mtv.corp.google.com>
References: <20190305050546.23431-1-weiyi.lu@mediatek.com>
         <20190305050546.23431-8-weiyi.lu@mediatek.com>
         <155501399858.20095.16525048679717411283@swboyd.mtv.corp.google.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-04-11 at 13:19 -0700, Stephen Boyd wrote:
> Quoting Weiyi Lu (2019-03-04 21:05:43)
> > On some Mediatek platforms, there are critical clocks of
> > clock gate type.
> > To register clock gate with flags CLK_IS_CRITICAL,
> > we need to add the flags field in mtk_gate data and register APIs.
> > 
> > Signed-off-by: Weiyi Lu <weiyi.lu@mediatek.com>
> 
> This patch doesn't apply, because it's already there via commit
> 5a1cc4c27ad2 ("clk: mediatek: Add flags to mtk_gate").
> 
Got it, but just catch a minor defect by 5a1cc4c27ad2 ("clk: mediatek:
Add flags to mtk_gate").

init.flags = CLK_SET_RATE_PARENT;
...
init.flags = flags;

I'll send a fix later.

Thanks for the help on the MT8183 clk series.

> 
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek


