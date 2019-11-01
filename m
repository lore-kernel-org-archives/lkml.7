Return-Path: <SRS0=OzJr=YZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12975CA9ECE
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 01:21:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF476208C0
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 01:21:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729201AbfKABVc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Oct 2019 21:21:32 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:39663 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726540AbfKABVb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 21:21:31 -0400
X-UUID: 1887ff2598ca4eabab24c603a40aa4d3-20191101
X-UUID: 1887ff2598ca4eabab24c603a40aa4d3-20191101
Received: from mtkcas32.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 1343126105; Fri, 01 Nov 2019 09:21:17 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS32N2.mediatek.inc
 (172.27.4.72) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 1 Nov
 2019 09:21:15 +0800
Received: from [10.17.3.153] (172.27.4.253) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 1 Nov 2019 09:21:15 +0800
Message-ID: <1572571279.18464.39.camel@mhfsdcap03>
Subject: Re: [PATCH v2 04/11] dt-bindings: phy-mtk-tphy: add a new reference
 clock
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh@kernel.org>
CC:     Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Date:   Fri, 1 Nov 2019 09:21:19 +0800
In-Reply-To: <32bc288e-dbbb-8930-4750-826e9e17d58c@ti.com>
References: <1567149298-29366-1-git-send-email-chunfeng.yun@mediatek.com>
         <1567149298-29366-4-git-send-email-chunfeng.yun@mediatek.com>
         <20190917202805.GA13405@bogus>
         <32bc288e-dbbb-8930-4750-826e9e17d58c@ti.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-SNTS-SMTP: B5B93674122E8E6B22D53ED9A4AF45EE5591A27E1563D74407986ECF551E27B62000:8
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Rob,

On Wed, 2019-10-23 at 11:10 +0530, Kishon Vijay Abraham I wrote:
> Hi Rob,
> 
> On 18/09/19 1:58 AM, Rob Herring wrote:
> > On Fri, 30 Aug 2019 15:14:51 +0800, Chunfeng Yun wrote:
> >> Usually the digital and analog phys use the same reference clock,
> >> but on some platforms, they are separated, so add another optional
> >> clock to support it.
> >> In order to keep the clock names consistent with PHY IP's, use
> >> the da_ref for analog phy and ref clock for digital phy.
> >>
> >> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> >> ---
> >> v2: fix typo of analog and needed
> >> ---
> >>  Documentation/devicetree/bindings/phy/phy-mtk-tphy.txt | 7 +++++--
> >>  1 file changed, 5 insertions(+), 2 deletions(-)
> >>
> > 
> > Acked-by: Rob Herring <robh@kernel.org>
> 
> I see you've acked a couple of patches in the series. However the other
> dt-binding patch neither has an Ack or NAK. Is there a specific reason or can I
> merge the series?

Ping?

> 
> Thanks
> Kishon



