Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 756E1FA372A
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 14:22:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5489221835
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 14:22:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440284AbfJQOWh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 10:22:37 -0400
Received: from relay12.mail.gandi.net ([217.70.178.232]:33261 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437756AbfJQOWg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 10:22:36 -0400
Received: from xps13.stephanxp.local (lfbn-1-17395-211.w86-250.abo.wanadoo.fr [86.250.200.211])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id E5035200009;
        Thu, 17 Oct 2019 14:22:32 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     <linux-mtd@lists.infradead.org>
Cc:     linux-kernel@vger.kernel.org,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Artem Bityutskiy <dedekind1@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>
Subject: [PATCH] MAINTAINERS: mtd/ubi/ubifs: Remove inactive maintainers
Date:   Thu, 17 Oct 2019 16:22:29 +0200
Message-Id: <20191017142229.3853-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Despite their substantial personal investment in the MTD/UBI/UBIFS a
few years back, David, Brian, Artem and Adrian are not actively
maintaining the subsystem anymore. We warmly salute them for all the
work they have achieved and will of course still welcome their
participation and reviews.

That said, Marek retired himself a few weeks ago quoting Harald [1]:

        It matters who has which title and when. Should somebody not
        be an active maintainer, make sure he's not listed as such.

For this same reason, let’s trim the maintainers list with the
actually active ones over the past two years.

[1] http://laforge.gnumonks.org/blog/20180307-mchardy-gpl/

Cc: David Woodhouse <dwmw2@infradead.org>
Cc: Brian Norris <computersforpeace@gmail.com>
Cc: Artem Bityutskiy <dedekind1@gmail.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Marek Vasut <marek.vasut@gmail.com>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Richard Weinberger <richard@nod.at>
Cc: Vignesh Raghavendra <vigneshr@ti.com>
Cc: Tudor Ambarus <tudor.ambarus@microchip.com>
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 MAINTAINERS | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 0632422ce9d4..0e5e0736ee55 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10528,8 +10528,6 @@ F:	include/linux/vmalloc.h
 F:	mm/
 
 MEMORY TECHNOLOGY DEVICES (MTD)
-M:	David Woodhouse <dwmw2@infradead.org>
-M:	Brian Norris <computersforpeace@gmail.com>
 M:	Miquel Raynal <miquel.raynal@bootlin.com>
 M:	Richard Weinberger <richard@nod.at>
 M:	Vignesh Raghavendra <vigneshr@ti.com>
@@ -16579,8 +16577,6 @@ F:	drivers/media/pci/tw686x/
 
 UBI FILE SYSTEM (UBIFS)
 M:	Richard Weinberger <richard@nod.at>
-M:	Artem Bityutskiy <dedekind1@gmail.com>
-M:	Adrian Hunter <adrian.hunter@intel.com>
 L:	linux-mtd@lists.infradead.org
 T:	git git://git.infradead.org/ubifs-2.6.git
 W:	http://www.linux-mtd.infradead.org/doc/ubifs.html
@@ -16697,7 +16693,6 @@ S:	Maintained
 F:	drivers/scsi/ufs/ufs-mediatek*
 
 UNSORTED BLOCK IMAGES (UBI)
-M:	Artem Bityutskiy <dedekind1@gmail.com>
 M:	Richard Weinberger <richard@nod.at>
 W:	http://www.linux-mtd.infradead.org/
 L:	linux-mtd@lists.infradead.org
-- 
2.20.1

