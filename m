Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,
	UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46FFFC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 21:42:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17D8E20657
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 21:42:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728320AbfCKVmA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 17:42:00 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:16684 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727138AbfCKVl7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 17:41:59 -0400
X-UUID: 3f289adcc33447c6ae236cc3e89aaf8e-20190312
X-UUID: 3f289adcc33447c6ae236cc3e89aaf8e-20190312
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1375627957; Tue, 12 Mar 2019 05:41:54 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs02n2.mediatek.inc (172.21.101.101) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 12 Mar 2019 05:41:52 +0800
Received: from [172.21.77.33] (172.21.77.33) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 12 Mar 2019 05:41:52 +0800
Message-ID: <1552340512.17993.4.camel@mtkswgap22>
Subject: Re: [PATCH v1 1/2] mmc: add SDIO identifiers for MediaTek Bluetooth
 devices
From:   Sean Wang <sean.wang@mediatek.com>
To:     Marcel Holtmann <marcel@holtmann.org>
CC:     <ulf.hansson@linaro.org>, Johan Hedberg <johan.hedberg@gmail.com>,
        <linux-mmc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-bluetooth@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>
Date:   Tue, 12 Mar 2019 05:41:52 +0800
In-Reply-To: <7C99941A-306E-4233-9EA4-5D681308C490@holtmann.org>
References: <cover.1552007058.git.sean.wang@mediatek.com>
         <97d7949c00bd78f8ec282fb9cd380ad161244616.1552007059.git.sean.wang@mediatek.com>
         <7C99941A-306E-4233-9EA4-5D681308C490@holtmann.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-TM-SNTS-SMTP: A0A2E58563D355418E7D0ABB0A80B4006E56C8377A6DCFF6677EB3ECEB372E382000:8
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-03-11 at 17:38 +0100, Marcel Holtmann wrote:
> Hi Sean,
> 
> > The SDIO identifier for MediaTek Bluetooth devices were defined in the
> > MediaTek Bluetooth driver. Moving the definitions in MMC header file
> > seems common sense.
> > 
> > Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> > ---
> > include/linux/mmc/sdio_ids.h | 2 ++
> > 1 file changed, 2 insertions(+)
> 
> patch has been applied to bluetooth-next tree.
> 
> Can we also update the sdio.ids database inside systemd.
> 
> https://github.com/systemd/systemd/blob/master/hwdb/sdio.ids
> 


Sure, thanks for showing me the information and I'll update the database
for the card.

> Regards
> 
> Marcel
> 
> 
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek


