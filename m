Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C75ABC04AB6
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 08:05:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7A3427D0D
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 08:05:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727627AbfFCIF0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 04:05:26 -0400
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:49125 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725856AbfFCIFZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 04:05:25 -0400
X-Originating-IP: 90.88.144.139
Received: from localhost.localdomain (aaubervilliers-681-1-24-139.w90-88.abo.wanadoo.fr [90.88.144.139])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id 014721C000D;
        Mon,  3 Jun 2019 08:05:21 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     =?utf-8?q?Pawe=C5=82_Chmiel?= <pawel.mikolaj.chmiel@gmail.com>,
        kyungmin.park@samsung.com
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>, bbrezillon@kernel.org,
        richard@nod.at, Jonathan Bakker <xc-racer2@live.ca>,
        linux-kernel@vger.kernel.org, marek.vasut@gmail.com,
        linux-mtd@lists.infradead.org, computersforpeace@gmail.com,
        dwmw2@infradead.org
Subject: Re: [PATCH] mtd: onenand: Add support for 8Gb datasize onenand
Date:   Mon,  3 Jun 2019 10:05:18 +0200
Message-Id: <20190603080518.29054-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190426150634.5643-1-pawel.mikolaj.chmiel@gmail.com>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: 04e8af9c0b99907a47a16bf47eb46a74079b59f0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2019-04-26 at 15:06:34 UTC, =?utf-8?q?Pawe=C5=82_Chmiel?= wrote:
> From: Jonathan Bakker <xc-racer2@live.ca>
> 
> Used in several S5PV210-based Galaxy S devices, among them SGH-T959V,
> SGH-T959P, SGH-T839, and SPH-D700.
> 
> Signed-off-by: Jonathan Bakker <xc-racer2@live.ca>
> Signed-off-by: Paweł Chmiel <pawel.mikolaj.chmiel@gmail.com>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git nand/next, thanks.

Miquel
