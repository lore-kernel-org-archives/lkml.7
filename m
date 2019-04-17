Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9553C10F12
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 10:05:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4F0220835
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 10:05:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731750AbfDQKFa convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 06:05:30 -0400
Received: from relay12.mail.gandi.net ([217.70.178.232]:35831 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729039AbfDQKFa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 06:05:30 -0400
Received: from xps13 (aaubervilliers-681-1-42-238.w90-88.abo.wanadoo.fr [90.88.160.238])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id 8745020000D;
        Wed, 17 Apr 2019 10:05:27 +0000 (UTC)
Date:   Wed, 17 Apr 2019 12:05:26 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Schrempf Frieder <frieder.schrempf@kontron.de>
Cc:     "bbrezillon@kernel.org" <bbrezillon@kernel.org>,
        "richard@nod.at" <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 4/7] mtd: nand: Make flags for bad block marker
 position more granular
Message-ID: <20190417120526.1fd9130c@xps13>
In-Reply-To: <20190218104122.18788-5-frieder.schrempf@kontron.de>
References: <20190218104122.18788-1-frieder.schrempf@kontron.de>
        <20190218104122.18788-5-frieder.schrempf@kontron.de>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Frieder,

Schrempf Frieder <frieder.schrempf@kontron.de> wrote on Mon, 18 Feb
2019 10:42:45 +0000:

> From: Frieder Schrempf <frieder.schrempf@kontron.de>
> 
> To be able to check and set bad block markers in the first and
> second page of a block independently of each other, we create
> separate flags for both cases.
> 
> Previously NAND_BBM_SECONDPAGE meant, that both, the first and the
> second page were used. With this patch NAND_BBM_FIRSTPAGE stands for
> using the first page and NAND_BBM_SECONDPAGE for using the second
> page.
> 
> This patch is only for preparation of subsequent changes and does
> not implement the logic to actually handle both flags separately.
> 
> Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
> Reviewed-by: Boris Brezillon <bbrezillon@kernel.org>
> ---

Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>


Thanks,
Miquèl
