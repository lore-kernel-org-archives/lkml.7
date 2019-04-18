Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CAB5C10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 16:22:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 624FF206B6
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 16:22:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389636AbfDRQWo convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 12:22:44 -0400
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:49515 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725888AbfDRQWn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 12:22:43 -0400
X-Originating-IP: 91.224.148.103
Received: from xps13 (unknown [91.224.148.103])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id 7C84A20004;
        Thu, 18 Apr 2019 16:22:40 +0000 (UTC)
Date:   Thu, 18 Apr 2019 18:22:38 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Yue Haibing <yuehaibing@huawei.com>
Cc:     <bbrezillon@kernel.org>, <richard@nod.at>, <dwmw2@infradead.org>,
        <computersforpeace@gmail.com>, <marek.vasut@gmail.com>,
        <paul@crapouillou.net>, <linux-kernel@vger.kernel.org>,
        <linux-mtd@lists.infradead.org>
Subject: Re: [PATCH -next] mtd: rawnand: ingenic: Make jz4725b_ooblayout_ops
 static
Message-ID: <20190418182238.2284f917@xps13>
In-Reply-To: <20190410140035.33004-1-yuehaibing@huawei.com>
References: <20190410140035.33004-1-yuehaibing@huawei.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yue,

Yue Haibing <yuehaibing@huawei.com> wrote on Wed, 10 Apr 2019 22:00:35
+0800:

> From: YueHaibing <yuehaibing@huawei.com>
> 
> Fix sparse warning:
> 
> drivers/mtd/nand/raw/ingenic/ingenic_nand.c:140:32: warning:
>  symbol 'jz4725b_ooblayout_ops' was not declared. Should it be static?
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---


Applied to 
https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git 
branch nand/next.

Thanks,
Miquèl
