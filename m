Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB367C4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 18:37:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9ECE32063F
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 18:37:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726936AbfF1Shb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 14:37:31 -0400
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:47867 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726631AbfF1Shb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 14:37:31 -0400
X-Originating-IP: 81.185.164.234
Received: from localhost.localdomain (234.164.185.81.rev.sfr.net [81.185.164.234])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id 54B2020004;
        Fri, 28 Jun 2019 18:37:27 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Jeff Kletsky <lede@allycomm.com>,
        Schrempf Frieder <frieder.schrempf@kontron.de>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     linux-mtd@lists.infradead.org,
        Jeff Kletsky <git-commits@allycomm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mtd: spinand: Add initial support for Paragon PN26G0xA
Date:   Fri, 28 Jun 2019 20:37:19 +0200
Message-Id: <20190628183719.18941-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190618170805.7187-1-lede@allycomm.com>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: 3552691616c940a7c4125c2678ba816653cd725e
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-06-18 at 17:08:05 UTC, Jeff Kletsky wrote:
> From: Jeff Kletsky <git-commits@allycomm.com>
> 
> Add initial support for Paragon Technology
> PN26G01Axxxxx and PN26G02Axxxxx SPI NAND
> 
> Datasheets available at
> http://www.xtxtech.com/upfile/2016082517274590.pdf
> http://www.xtxtech.com/upfile/2016082517282329.pdf
> 
> Signed-off-by: Jeff Kletsky <git-commits@allycomm.com>
> Reviewed-by: Frieder Schrempf <frieder.schrempf@kontron.de>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git nand/next, thanks.

Miquel
