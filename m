Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58C39C33CA2
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 19:50:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34871206ED
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 19:50:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732547AbgAITuR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 14:50:17 -0500
Received: from mslow2.mail.gandi.net ([217.70.178.242]:42428 "EHLO
        mslow2.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730077AbgAITuQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 14:50:16 -0500
X-Greylist: delayed 1616 seconds by postgrey-1.27 at vger.kernel.org; Thu, 09 Jan 2020 14:50:15 EST
Received: from relay12.mail.gandi.net (unknown [217.70.178.232])
        by mslow2.mail.gandi.net (Postfix) with ESMTP id 2BEE63AAB51;
        Thu,  9 Jan 2020 19:14:47 +0000 (UTC)
Received: from localhost.localdomain (unknown [91.224.148.103])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id 4E1D1200007;
        Thu,  9 Jan 2020 19:14:45 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>, kyungmin.park@samsung.com,
        miquel.raynal@bootlin.com, aaro.koskinen@iki.fi, vigneshr@ti.com,
        hns@goldelico.com
Cc:     tony@atomide.com, linux-omap@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mtd: onenand: omap2: Pass correct flags for prep_dma_memcpy
Date:   Thu,  9 Jan 2020 20:14:44 +0100
Message-Id: <20200109191444.10713-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200107084544.18547-1-peter.ujfalusi@ti.com>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: 8bcef0d54067077cf9a6cb129022c77559926e8c
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2020-01-07 at 08:45:44 UTC, Peter Ujfalusi wrote:
> The commit converting the driver to DMAengine was missing the flags for
> the memcpy prepare call.
> It went unnoticed since the omap-dma driver was ignoring them.
> 
> Fixes: 3ed6a4d1de2c5 (" mtd: onenand: omap2: Convert to use dmaengine for memcp")
> Reported-by: Aaro Koskinen <aaro.koskinen@iki.fi>
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> Tested-by: H. Nikolaus Schaller <hns@goldelico.com>
> Tested-by: Aaro Koskinen <aaro.koskinen@iki.fi>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git mtd/fixes, thanks.

Miquel
