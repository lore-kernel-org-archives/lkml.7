Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17A1CC2BCA1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 11:07:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC72120665
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 11:07:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728385AbfFGLHd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 07:07:33 -0400
Received: from baptiste.telenet-ops.be ([195.130.132.51]:41832 "EHLO
        baptiste.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728115AbfFGLHd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 07:07:33 -0400
Received: from ramsan ([84.194.111.163])
        by baptiste.telenet-ops.be with bizsmtp
        id Mn7X200043XaVaC01n7XMQ; Fri, 07 Jun 2019 13:07:31 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1hZCiZ-00048u-1d; Fri, 07 Jun 2019 13:07:31 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1hZCiZ-0003K7-04; Fri, 07 Jun 2019 13:07:31 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Jens Wiklander <jens.wiklander@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Jiri Kosina <trivial@kernel.org>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH trivial] Documentation: tee: Grammar s/the its/its/
Date:   Fri,  7 Jun 2019 13:07:29 +0200
Message-Id: <20190607110729.12734-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 Documentation/tee.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/tee.txt b/Documentation/tee.txt
index 56ea85ffebf24545..afacdf2fd1de5455 100644
--- a/Documentation/tee.txt
+++ b/Documentation/tee.txt
@@ -32,7 +32,7 @@ User space (the client) connects to the driver by opening /dev/tee[0-9]* or
   memory.
 
 - TEE_IOC_VERSION lets user space know which TEE this driver handles and
-  the its capabilities.
+  its capabilities.
 
 - TEE_IOC_OPEN_SESSION opens a new session to a Trusted Application.
 
-- 
2.17.1

