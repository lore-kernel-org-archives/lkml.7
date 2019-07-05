Return-Path: <SRS0=fBTF=VC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C349C46499
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 21:00:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E0762133F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 21:00:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728179AbfGEVAi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jul 2019 17:00:38 -0400
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:50779 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728054AbfGEVAh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jul 2019 17:00:37 -0400
X-Originating-IP: 91.224.148.103
Received: from localhost.localdomain (unknown [91.224.148.103])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id AB3C720004;
        Fri,  5 Jul 2019 21:00:32 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Schrempf Frieder <frieder.schrempf@kontron.de>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "emil.lenngren@gmail.com" <emil.lenngren@gmail.com>,
        "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     Vignesh Raghavendra <vigneshr@ti.com>,
        "bbrezillon@kernel.org" <bbrezillon@kernel.org>,
        Richard Weinberger <richard@nod.at>,
        Marek Vasut <marek.vasut@gmail.com>,
        Brian Norris <computersforpeace@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>
Subject: Re: [PATCH] mtd: spinand: Fix max_bad_eraseblocks_per_lun info in memorg
Date:   Fri,  5 Jul 2019 23:00:26 +0200
Message-Id: <20190705210026.13420-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190606170754.6531-1-frieder.schrempf@kontron.de>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: a126483e82957172b8a93ebb1d30fb2b1df3cbbc
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-06-06 at 17:07:55 UTC, Schrempf Frieder wrote:
> From: Frieder Schrempf <frieder.schrempf@kontron.de>
> 
> The 1Gb Macronix chip can have a maximum of 20 bad blocks, while
> the 2Gb version has twice as many blocks and therefore the maximum
> number of bad blocks is 40.
> 
> The 4Gb GigaDevice GD5F4GQ4xA has twice as many blocks as its 2Gb
> counterpart and therefore a maximum of 80 bad blocks.
> 
> Fixes: 377e517b5fa5 ("mtd: nand: Add max_bad_eraseblocks_per_lun info to memorg")
> Reported-by: Emil Lenngren <emil.lenngren@gmail.com>
> Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git mtd/fixes, thanks.

Miquel
