Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AC0CC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 23:10:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10189218A5
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 23:10:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727661AbfCTXKP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 19:10:15 -0400
Received: from mailgw02.mediatek.com ([1.203.163.81]:19308 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726115AbfCTXKP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 19:10:15 -0400
X-UUID: cdb3e5cb4e584530a633308ce209e34c-20190321
X-UUID: cdb3e5cb4e584530a633308ce209e34c-20190321
Received: from mtkcas36.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <stanley.chu@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 172699688; Thu, 21 Mar 2019 07:10:05 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 MTKMBS31DR.mediatek.inc (172.27.6.102) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 21 Mar 2019 07:10:03 +0800
Received: from [172.21.77.33] (172.21.77.33) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 21 Mar 2019 07:10:03 +0800
Message-ID: <1553123403.30977.74.camel@mtkswgap22>
Subject: Re: [PATCH][next] scsi: phy: mediatek: fix typo in author's email
 address
From:   Stanley Chu <stanley.chu@mediatek.com>
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>
CC:     Colin King <colin.king@canonical.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <kernel-janitors@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Date:   Thu, 21 Mar 2019 07:10:03 +0800
In-Reply-To: <1553122955.10179.169.camel@mhfsdcap03>
References: <20190320212205.5726-1-colin.king@canonical.com>
         <20190320212205.5726-2-colin.king@canonical.com>
         <1553122955.10179.169.camel@mhfsdcap03>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Colin,

On Thu, 2019-03-21 at 07:02 +0800, Chunfeng Yun wrote:
> Hi Colin,
> 
> On Wed, 2019-03-20 at 21:22 +0000, Colin King wrote:
> > From: Colin Ian King <colin.king@canonical.com>
> > 
> > There is a typo in the module author's email address. Fix this.
> > 
> > Signed-off-by: Colin Ian King <colin.king@canonical.com>
> > ---
> >  drivers/phy/mediatek/phy-mtk-ufs.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/phy/mediatek/phy-mtk-ufs.c b/drivers/phy/mediatek/phy-mtk-ufs.c
> > index 9a80a76d7990..cf94f5c35dc5 100644
> > --- a/drivers/phy/mediatek/phy-mtk-ufs.c
> > +++ b/drivers/phy/mediatek/phy-mtk-ufs.c
> > @@ -241,5 +241,5 @@ static struct platform_driver ufs_mtk_phy_driver = {
> >  module_platform_driver(ufs_mtk_phy_driver);
> >  
> >  MODULE_DESCRIPTION("Universal Flash Storage (UFS) MediaTek MPHY");
> > -MODULE_AUTHOR("Stanley Chu <stanley.chu@medaitek.com>");
> > +MODULE_AUTHOR("Stanley Chu <stanley.chu@mediatek.com>");

Thanks for fixing this.

Reviewed-by: Stanley Chu <stanley.chu@mediatek.com>

> >  MODULE_LICENSE("GPL v2");
> 
> Thank you.
> 
> Acked-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> 
> 


