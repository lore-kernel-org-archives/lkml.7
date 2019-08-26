Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87DDBC3A59F
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 13:00:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6650021852
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 13:00:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732169AbfHZNAK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 09:00:10 -0400
Received: from relay11.mail.gandi.net ([217.70.178.231]:47353 "EHLO
        relay11.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731275AbfHZNAJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 09:00:09 -0400
Received: from localhost.localdomain (lfbn-1-17395-211.w86-250.abo.wanadoo.fr [86.250.200.211])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay11.mail.gandi.net (Postfix) with ESMTPSA id 5FC4910000C;
        Mon, 26 Aug 2019 13:00:04 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Wenwen Wang <wenwen@cs.uga.edu>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Richard Weinberger <richard@nod.at>,
        Randy Dunlap <rdunlap@infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Marek Vasut <marek.vasut@gmail.com>,
        "open list:NAND FLASH SUBSYSTEM" <linux-mtd@lists.infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Brian Norris <computersforpeace@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>
Subject: Re: [PATCH v2] mtd: rawnand: Fix a memory leak bug
Date:   Mon, 26 Aug 2019 14:59:47 +0200
Message-Id: <20190826125947.15176-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <1566182765-7150-1-git-send-email-wenwen@cs.uga.edu>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: 86aa04f4c2215912fcca6728f2dcf174f7e31fc4
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-08-19 at 02:46:04 UTC, Wenwen Wang wrote:
> In nand_scan_bbt(), a temporary buffer 'buf' is allocated through
> vmalloc(). However, if check_create() fails, 'buf' is not deallocated,
> leading to a memory leak bug. To fix this issue, free 'buf' before
> returning the error.
> 
> Signed-off-by: Wenwen Wang <wenwen@cs.uga.edu>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git nand/next, thanks.

Miquel
