Return-Path: <SRS0=xe0T=ZQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CC69C432C3
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Nov 2019 21:14:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E6D120748
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Nov 2019 21:14:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727007AbfKXVOE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Nov 2019 16:14:04 -0500
Received: from mga03.intel.com ([134.134.136.65]:1480 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726957AbfKXVOE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Nov 2019 16:14:04 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Nov 2019 13:14:03 -0800
X-IronPort-AV: E=Sophos;i="5.69,239,1571727600"; 
   d="scan'208";a="210912404"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Nov 2019 13:14:03 -0800
Subject: [PATCH v3 1/3] MAINTAINERS: Reclaim the P: tag for Maintainer Entry
 Profile
From:   Dan Williams <dan.j.williams@intel.com>
To:     corbet@lwn.net
Cc:     Joe Perches <joe@perches.com>, vishal.l.verma@intel.com,
        linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org,
        linux-doc@vger.kernel.org
Date:   Sun, 24 Nov 2019 12:59:48 -0800
Message-ID: <157462918794.1729495.10838545318307341653.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <157462918268.1729495.10257190766638995699.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <157462918268.1729495.10257190766638995699.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixup some P: entries to be M: and delete the others that do not include an
email address. The P: tag will be used to indicate the location of a
Profile for a given MAINTAINERS entry.

Cc: Joe Perches <joe@perches.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 MAINTAINERS |   12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index e7a47b5210fd..3f171339df53 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -76,7 +76,6 @@ trivial patch so apply some common sense.
 
 Descriptions of section entries:
 
-	P: Person (obsolete)
 	M: Mail patches to: FullName <address@domain>
 	R: Designated reviewer: FullName <address@domain>
 	   These reviewers should be CCed on patches.
@@ -811,7 +810,7 @@ S:	Orphan
 F:	drivers/usb/gadget/udc/amd5536udc.*
 
 AMD GEODE PROCESSOR/CHIPSET SUPPORT
-P:	Andres Salomon <dilinger@queued.net>
+M:	Andres Salomon <dilinger@queued.net>
 L:	linux-geode@lists.infradead.org (moderated for non-subscribers)
 W:	http://www.amd.com/us-en/ConnectivitySolutions/TechnicalResources/0,,50_2334_2452_11363,00.html
 S:	Supported
@@ -10085,7 +10084,6 @@ F:	drivers/staging/media/tegra-vde/
 
 MEDIA INPUT INFRASTRUCTURE (V4L/DVB)
 M:	Mauro Carvalho Chehab <mchehab@kernel.org>
-P:	LinuxTV.org Project
 L:	linux-media@vger.kernel.org
 W:	https://linuxtv.org
 Q:	http://patchwork.kernel.org/project/linux-media/list/
@@ -13452,7 +13450,6 @@ S:	Maintained
 F:	arch/mips/ralink
 
 RALINK RT2X00 WIRELESS LAN DRIVER
-P:	rt2x00 project
 M:	Stanislaw Gruszka <sgruszka@redhat.com>
 M:	Helmut Schaa <helmut.schaa@googlemail.com>
 L:	linux-wireless@vger.kernel.org
@@ -13787,7 +13784,6 @@ S:	Supported
 F:	drivers/net/ethernet/rocker/
 
 ROCKETPORT DRIVER
-P:	Comtrol Corp.
 W:	http://www.comtrol.com
 S:	Maintained
 F:	Documentation/driver-api/serial/rocket.rst
@@ -14668,15 +14664,13 @@ F:	drivers/video/fbdev/simplefb.c
 F:	include/linux/platform_data/simplefb.h
 
 SIMTEC EB110ATX (Chalice CATS)
-P:	Ben Dooks
-P:	Vincent Sanders <vince@simtec.co.uk>
+M:	Vincent Sanders <vince@simtec.co.uk>
 M:	Simtec Linux Team <linux@simtec.co.uk>
 W:	http://www.simtec.co.uk/products/EB110ATX/
 S:	Supported
 
 SIMTEC EB2410ITX (BAST)
-P:	Ben Dooks
-P:	Vincent Sanders <vince@simtec.co.uk>
+M:	Vincent Sanders <vince@simtec.co.uk>
 M:	Simtec Linux Team <linux@simtec.co.uk>
 W:	http://www.simtec.co.uk/products/EB2410ITX/
 S:	Supported

