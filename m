Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 692C5C10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 10:42:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4223C217D4
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 10:42:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726711AbfDKKmt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 06:42:49 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:45787 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726121AbfDKKms (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 06:42:48 -0400
X-UUID: ed53220bd43d4344853d0d85948572b7-20190411
X-UUID: ed53220bd43d4344853d0d85948572b7-20190411
Received: from mtkcas35.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <chaotian.jing@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 55076221; Thu, 11 Apr 2019 18:42:36 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS32N1.mediatek.inc
 (172.27.4.71) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Thu, 11 Apr
 2019 18:42:33 +0800
Received: from [10.17.3.153] (172.27.4.253) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 11 Apr 2019 18:42:32 +0800
Message-ID: <1554979352.18628.0.camel@mhfsdcap03>
Subject: Re: [PATCH] MAINTAINERS: Add section for MediaTek MMC/SD/SDIO driver
From:   Chaotian Jing <chaotian.jing@mediatek.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
CC:     Matthias Brugger <matthias.bgg@gmail.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Thu, 11 Apr 2019 18:42:32 +0800
In-Reply-To: <CAPDyKFqNih3kEuRM9HHkmcVOzaT2RZLRjb=0ifq6hGB+OCxUug@mail.gmail.com>
References: <20190325122442.30644-1-ulf.hansson@linaro.org>
         <CAPDyKFqNih3kEuRM9HHkmcVOzaT2RZLRjb=0ifq6hGB+OCxUug@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-TM-SNTS-SMTP: B40457E360424A250D23298BF447B1398DB561ECBBA3EA99A3963918CBB035D62000:8
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-04-11 at 11:49 +0200, Ulf Hansson wrote:
> Chaotian,
> 
> On Mon, 25 Mar 2019 at 13:24, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> >
> > Cc: Chaotian Jing <chaotian.jing@mediatek.com>
> > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> > ---
> >  MAINTAINERS | 6 ++++++
> >  1 file changed, 6 insertions(+)
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 3e5a5d263f29..b43e563b4c95 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -9775,6 +9775,12 @@ F:       drivers/media/platform/mtk-vpu/
> >  F:     Documentation/devicetree/bindings/media/mediatek-vcodec.txt
> >  F:     Documentation/devicetree/bindings/media/mediatek-vpu.txt
> >
> > +MEDIATEK MMC/SD/SDIO DRIVER
> > +M:     Chaotian Jing <chaotian.jing@mediatek.com>
> > +S:     Maintained
> > +F:     drivers/mmc/host/mtk-sd.c
> > +F:     Documentation/devicetree/bindings/mmc/mtk-sd.txt
> > +
> 
> Are you fine with this, or do you have any other guys at your side
> that can help with reviewing patches for the mtk-sd driver?
> 
Yes, It's fine for me.
Thx!
> [...]
> 
> Kind regards
> Uffe


