Return-Path: <SRS0=BIzH=UB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0194C46470
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Jun 2019 01:23:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2E1A276E0
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Jun 2019 01:23:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726779AbfFBBXU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Jun 2019 21:23:20 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:14017 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726211AbfFBBXU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Jun 2019 21:23:20 -0400
X-UUID: 42d88cd7ad0645b2906d049d2b5059b1-20190602
X-UUID: 42d88cd7ad0645b2906d049d2b5059b1-20190602
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <chaotian.jing@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1797417067; Sun, 02 Jun 2019 09:23:13 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by mtkmbs07n1.mediatek.inc
 (172.21.101.16) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Sun, 2 Jun
 2019 09:23:12 +0800
Received: from [10.17.3.153] (172.27.4.253) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Sun, 2 Jun 2019 09:23:11 +0800
Message-ID: <1559438591.25015.0.camel@mhfsdcap03>
Subject: Re: fix controller busy issue and add 24bits segment support
From:   Chaotian Jing <chaotian.jing@mediatek.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
CC:     <srv_heupstream@mediatek.com>, <linux-mmc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        "Matthias Brugger" <matthias.bgg@gmail.com>,
        <linux-arm-kernel@lists.infradead.org>
Date:   Sun, 2 Jun 2019 09:23:11 +0800
In-Reply-To: <1558252637-10556-1-git-send-email-chaotian.jing@mediatek.com>
References: <1558252637-10556-1-git-send-email-chaotian.jing@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ulf,

Gentle ping for this patch.

On Sun, 2019-05-19 at 15:57 +0800, Chaotian Jing wrote:
> the below 2 patches fix controller busy issue when plug out SD card
> and add 24bits segment size support.
> 
> Chaotian Jing (2):
>   mmc: mediatek: fix controller busy when plug out SD
>   mmc: mediatek: support 24bits segment size
> 
>  drivers/mmc/host/mtk-sd.c | 24 ++++++++++++++++++------
>  1 file changed, 18 insertions(+), 6 deletions(-)
> 


