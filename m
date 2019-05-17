Return-Path: <SRS0=M1fl=TR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 722DCC04AB4
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 20:55:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 449C22082E
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 20:55:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729190AbfEQUzE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 May 2019 16:55:04 -0400
Received: from noserose.net ([66.220.18.76]:59434 "HELO noserose.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726978AbfEQUzD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 May 2019 16:55:03 -0400
X-Greylist: delayed 605 seconds by postgrey-1.27 at vger.kernel.org; Fri, 17 May 2019 16:55:03 EDT
Received: from cat.he.net ([127.0.0.1]) by noserose.net for <linux-kernel@vger.kernel.org>; Fri, 17 May 2019 13:44:54 -0700
Message-Id: <1558125894.9571@cat.he.net>
From:   Ed Cashin <ed.cashin@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Justin Sanders <justin@coraid.com>, linux-kernel@vger.kernel.org,
        ed.cashin@acm.org
Date:   Fri, 17 May 2019 16:29:18 -0400
Subject: [PATCH] aoe: list new maintainer for aoe driver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Justin Sanders, who has extensive experience with ATA over Ethernet
in general and AoE SCSI and block-device drivers in particular, is
ready to take on the role of aoe maintainer.  The driver needs a more
active maintainer.
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 5c38f21..9a0c0838 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2568,7 +2568,7 @@ F:	Documentation/devicetree/bindings/eeprom/at24.txt
 F:	drivers/misc/eeprom/at24.c
 
 ATA OVER ETHERNET (AOE) DRIVER
-M:	"Ed L. Cashin" <ed.cashin@acm.org>
+M:	"Justin Sanders" <justin@coraid.com>
 W:	http://www.openaoe.org/
 S:	Supported
 F:	Documentation/aoe/
-- 
2.7.4

