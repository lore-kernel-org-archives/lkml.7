Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEE8FC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 23:17:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BA5B2183E
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 23:17:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727614AbfCTXRi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 19:17:38 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:16175 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727437AbfCTXRi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 19:17:38 -0400
X-UUID: 5fb7af52b1744e8aa5a04922cbaa7dfc-20190321
X-UUID: 5fb7af52b1744e8aa5a04922cbaa7dfc-20190321
Received: from mtkcas09.mediatek.inc [(172.21.101.178)] by mailgw02.mediatek.com
        (envelope-from <stanley.chu@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1965427408; Thu, 21 Mar 2019 07:17:32 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs02n1.mediatek.inc (172.21.101.77) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 21 Mar 2019 07:17:31 +0800
Received: from [172.21.77.33] (172.21.77.33) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 21 Mar 2019 07:17:31 +0800
Message-ID: <1553123851.30977.76.camel@mtkswgap22>
Subject: Re: [PATCH -next] scsi: ufs-mediatek: Make some symbols static
From:   Stanley Chu <stanley.chu@mediatek.com>
To:     Yue Haibing <yuehaibing@huawei.com>
CC:     Yue Haibing <yuehaibing@huawei.com>, <alim.akhtar@samsung.com>,
        <avri.altman@wdc.com>, <pedrom.sousa@synopsys.com>,
        <jejb@linux.ibm.com>, <martin.petersen@oracle.com>,
        <matthias.bgg@gmail.com>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <linux-scsi@vger.kernel.org>,
        "Mukesh Ojha" <mojha@codeaurora.org>
Date:   Thu, 21 Mar 2019 07:17:31 +0800
In-Reply-To: <d0536ff3-c6aa-ae3d-49cd-1a54a8dce5b5@codeaurora.org>
References: <20190320142458.20052-1-yuehaibing@huawei.com>
         <d0536ff3-c6aa-ae3d-49cd-1a54a8dce5b5@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 2019-03-21 at 01:00 +0530, Mukesh Ojha wrote:
> On 3/20/2019 7:54 PM, Yue Haibing wrote:
> > From: YueHaibing <yuehaibing@huawei.com>
> >
> > Fix sparse warnings:
> >
> > drivers/scsi/ufs/ufs-mediatek.c:19:6: warning: symbol 'ufs_mtk_cfg_unipro_cg' was not declared. Should it be static?
> > drivers/scsi/ufs/ufs-mediatek.c:55:5: warning: symbol 'ufs_mtk_bind_mphy' was not declared. Should it be static?
> > drivers/scsi/ufs/ufs-mediatek.c:342:27: warning: symbol 'ufs_mtk_of_match' was not declared. Should it be static?
> >
> > Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> > ---
> >   drivers/scsi/ufs/ufs-mediatek.c | 6 +++---
> >   1 file changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/scsi/ufs/ufs-mediatek.c b/drivers/scsi/ufs/ufs-mediatek.c
> > index c3b78fc..2fbb450 100644
> > --- a/drivers/scsi/ufs/ufs-mediatek.c
> > +++ b/drivers/scsi/ufs/ufs-mediatek.c
> > @@ -16,7 +16,7 @@
> >   #include "unipro.h"
> >   #include "ufs-mediatek.h"
> >   
> > -void ufs_mtk_cfg_unipro_cg(struct ufs_hba *hba, bool enable)
> > +static void ufs_mtk_cfg_unipro_cg(struct ufs_hba *hba, bool enable)
> >   {
> >   	u32 tmp;
> >   
> > @@ -52,7 +52,7 @@ void ufs_mtk_cfg_unipro_cg(struct ufs_hba *hba, bool enable)
> >   	}
> >   }
> >   
> > -int ufs_mtk_bind_mphy(struct ufs_hba *hba)
> > +static int ufs_mtk_bind_mphy(struct ufs_hba *hba)
> >   {
> >   	struct ufs_mtk_host *host = ufshcd_get_variant(hba);
> >   	struct device *dev = hba->dev;
> > @@ -339,7 +339,7 @@ static int ufs_mtk_remove(struct platform_device *pdev)
> >   	return 0;
> >   }
> >   
> > -const struct of_device_id ufs_mtk_of_match[] = {
> > +static const struct of_device_id ufs_mtk_of_match[] = {
> >   	{ .compatible = "mediatek,mt8183-ufshci"},
> >   	{},
> >   };
> 
> 
> Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>
> 
> 
> Cheers,
> Mukesh
> 

Reviewed-by: Stanley Chu <stanley.chu@mediatek.com>

Thanks,
Stanley



