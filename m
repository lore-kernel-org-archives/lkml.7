Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65411CA9ED0
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 04:56:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42DA52070B
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 04:56:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409545AbfJRE4u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 00:56:50 -0400
Received: from mailgw02.mediatek.com ([1.203.163.81]:57887 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S2389158AbfJRE4t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 00:56:49 -0400
X-UUID: 456865fc1cb443a58d46027694256ed7-20191018
X-UUID: 456865fc1cb443a58d46027694256ed7-20191018
Received: from mtkcas32.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <min.guo@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 421628261; Fri, 18 Oct 2019 11:41:25 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS31N2.mediatek.inc
 (172.27.4.87) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 18 Oct
 2019 11:41:19 +0800
Received: from [10.17.3.153] (172.27.4.253) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 18 Oct 2019 11:41:18 +0800
Message-ID: <1571370080.28949.5.camel@mhfsdcap03>
Subject: Re: [PATCH RESEND v7 1/6] dt-bindings: usb: musb: Add support for
 MediaTek musb controller
From:   Min Guo <min.guo@mediatek.com>
To:     Rob Herring <robh@kernel.org>
CC:     Bin Liu <b-liu@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        <chunfeng.yun@mediatek.com>, <linux-usb@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <tony@atomide.com>,
        <hdegoede@redhat.com>
Date:   Fri, 18 Oct 2019 11:41:20 +0800
In-Reply-To: <20191017140841.GA20279@bogus>
References: <20191017082554.27953-1-min.guo@mediatek.com>
         <20191017082554.27953-2-min.guo@mediatek.com>
         <20191017140841.GA20279@bogus>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-SNTS-SMTP: CB98BBEA4BB874D3A0D88CACED1C5CC76A62CDA4161EE13A5117F18AFA2C7BDE2000:8
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-10-17 at 09:08 -0500, Rob Herring wrote:
> On Thu, 17 Oct 2019 16:25:49 +0800, <min.guo@mediatek.com> wrote:
> > From: Min Guo <min.guo@mediatek.com>
> > 
> > This adds support for MediaTek musb controller in
> > host, peripheral and otg mode.
> > 
> > Signed-off-by: Min Guo <min.guo@mediatek.com>
> > ---
> > changes in v7:
> > 1. Modify compatible as
> > - compatible : should be one of:
> >                "mediatek,mt2701-musb"
> >                ...
> >                followed by "mediatek,mtk-musb"
> > 2. Change usb connector child node compatible as "gpio-usb-b-connector" 
> > 
> > changes in v6:
> > 1. Modify usb connector child node
> > 
> > changes in v5:
> > suggested by Rob:
> > 1. Modify compatible as 
> > - compatible : should be one of:
> >                "mediatek,mt-2701"
> >                ...
> >                followed by "mediatek,mtk-musb"
> > 2. Add usb connector child node
> > 
> > changes in v4:
> > suggested by Sergei:
> > 1. String alignment
> > 
> > changes in v3:
> > 1. no changes
> > 
> > changes in v2:
> > suggested by Bin:
> > 1. Modify DRC to DRD
> > suggested by Rob:
> > 2. Drop the "<soc-model>-musb" in compatible
> > 3. Remove phy-names
> > 4. Add space after comma in clock-names
> > ---
> >  .../devicetree/bindings/usb/mediatek,musb.txt      | 55 ++++++++++++++++++++++
> >  1 file changed, 55 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/usb/mediatek,musb.txt
> > 
> 
> Please add Acked-by/Reviewed-by tags when posting new versions. However,
> there's no need to repost patches *only* to add the tags. The upstream
> maintainer will do that for acks received on the version they apply.

> If a tag was not added on purpose, please state why and what changed.
OK,thanks. I will add Acked-by/Reviewed-by tags in the next version.


