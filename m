Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D6D8C3A59F
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 13:00:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED8172186A
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 13:00:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732186AbfHZNAQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 09:00:16 -0400
Received: from relay11.mail.gandi.net ([217.70.178.231]:54855 "EHLO
        relay11.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732170AbfHZNAP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 09:00:15 -0400
Received: from localhost.localdomain (lfbn-1-17395-211.w86-250.abo.wanadoo.fr [86.250.200.211])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay11.mail.gandi.net (Postfix) with ESMTPSA id 46808100006;
        Mon, 26 Aug 2019 13:00:13 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Wenwen Wang <wenwen@cs.uga.edu>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Richard Weinberger <richard@nod.at>,
        open list <linux-kernel@vger.kernel.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        "open list:ONENAND FLASH DRIVER" <linux-mtd@lists.infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>
Subject: Re: [PATCH] mtd: onenand_base: Fix a memory leak bug
Date:   Mon, 26 Aug 2019 15:00:11 +0200
Message-Id: <20190826130011.15239-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <1566143569-2109-1-git-send-email-wenwen@cs.uga.edu>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: d83aef09aaa50bdafbb32981859128299abf32eb
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2019-08-18 at 15:52:49 UTC, Wenwen Wang wrote:
> In onenand_scan(), if CONFIG_MTD_ONENAND_VERIFY_WRITE is defined,
> 'this->verify_buf' is allocated through kzalloc(). However, it is not
> deallocated in the following execution, if the allocation for
> 'this->oob_buf' fails, leading to a memory leak bug. To fix this issue,
> free 'this->verify_buf' before returning the error.
> 
> Signed-off-by: Wenwen Wang <wenwen@cs.uga.edu>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git nand/next, thanks.

Miquel
