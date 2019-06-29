Return-Path: <SRS0=Dr8o=U4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13D0DC4321A
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Jun 2019 15:58:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E478320645
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Jun 2019 15:58:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726906AbfF2P6X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Jun 2019 11:58:23 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:61038 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726837AbfF2P6X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jun 2019 11:58:23 -0400
X-UUID: cb4d007beed24b438c80b8f6513dc84b-20190629
X-UUID: cb4d007beed24b438c80b8f6513dc84b-20190629
Received: from mtkcas09.mediatek.inc [(172.21.101.178)] by mailgw01.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 750830825; Sat, 29 Jun 2019 23:58:17 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs05n2.mediatek.inc (172.21.101.140) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Sat, 29 Jun 2019 23:58:16 +0800
Received: from [172.21.77.33] (172.21.77.33) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Sat, 29 Jun 2019 23:58:16 +0800
Message-ID: <1561823896.29227.0.camel@mtkswgap22>
Subject: Re: [PATCH v1] arm: dts: mediatek: add basic support for MT7629 SoC
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     Kevin Hilman <khilman@baylibre.com>
CC:     <ryder.lee@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
        "Rob Herring" <robh+dt@kernel.org>,
        Weijie Gao <weijie.gao@mediatek.com>,
        "Sean Wang" <sean.wang@mediatek.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        Steven Liu <steven.liu@mediatek.com>
Date:   Sat, 29 Jun 2019 23:58:16 +0800
In-Reply-To: <7hy31lp9q5.fsf@baylibre.com>
References: <a8ca0018ac8a4c5f61a7a1efc9dc5dccd768628b.1552449524.git.ryder.lee@mediatek.com>
         <7hy31lp9q5.fsf@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2019-06-28 at 16:32 -0700, Kevin Hilman wrote:
> <ryder.lee@kernel.org> writes:
> 
> > From: Ryder Lee <ryder.lee@mediatek.com>
> >
> > This adds basic support for MT7629 reference board.
> >
> > Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
> 
> Just noticing this is not upstream yet.
> 
> I did a basic boot test to ramdisk on the mt7629-rfb board donated for
> kernelCI (thanks MediaTek!) and it boots just fine.
> 
> Tested-by: Kevin Hilman <khilman@baylibre.com>
> 
> Kevin

Thanks. I'll post v3 with some fixups soon.

Ryder


