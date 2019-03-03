Return-Path: <SRS0=GAfv=RG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEE21C43381
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Mar 2019 16:55:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 983A220842
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Mar 2019 16:55:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tomli.me header.i=@tomli.me header.b="NBHlragC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726505AbfCCQzw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Mar 2019 11:55:52 -0500
Received: from tomli.me ([153.92.126.73]:42626 "EHLO tomli.me"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726474AbfCCQzv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Mar 2019 11:55:51 -0500
Received: from tomli.me (localhost [127.0.0.1])
        by tomli.me (OpenSMTPD) with ESMTP id 377c99eb;
        Sun, 3 Mar 2019 16:55:49 +0000 (UTC)
X-HELO: localhost.lan
Authentication-Results: tomli.me; auth=pass (login) smtp.auth=tomli
Received: from Unknown (HELO localhost.lan) (2402:f000:1:1501:200:5efe:3d30:3659)
 by tomli.me (qpsmtpd/0.95) with ESMTPSA (DHE-RSA-CHACHA20-POLY1305 encrypted); Sun, 03 Mar 2019 16:55:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=tomli.me; h=from:to:cc:subject:date:message-id:in-reply-to:references:mime-version:content-transfer-encoding; s=1490979754; bh=q4L6XezyUz8vykrzKVzwY31jWC0rgV5GxcNGUX2GJME=; b=NBHlragC8DCbaOLy17Fj/0DKG4d7NMBdBVZo6dygE0RnxBLTpaXZDiF7VO9qWkQCIcSbNrBWcMi/VIAUjW4p34jyNIWrKXu4pGJ2etVJC+HesEW9l0wpk5Wakj3yYCuYmxwjurKP0mkRv0TCyeQd8J+si2hGanVCO0rs1ZDStoreVy1eUYGNrkRXN41Foe6bu2b07R4TlIi87Kk8uXODn+DAe4onJfSonWzu3025qkFhb2zHl5sgizr5EOUdO8j17MuE6WevS4I4jl+mldP1kJ50+WkFzgkwSRbO1LyHzDSG/O1Q7OTyUlVNwr1foRIJgqvH6FfMk3sCLW0qKqqmyQ==
From:   Yifeng Li <tomli@tomli.me>
To:     Jiri Kosina <trivial@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-fbdev@vger.kernel.org, devel@driverdev.osuosl.org
Cc:     Yifeng Li <tomli@tomli.me>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Teddy Wang <teddy.wang@siliconmotion.com>,
        linux-kernel@vger.kernel.org
Subject: [RESEND][PATCH 1/2] staging: sm750fb: trivial comment indention fix.
Date:   Mon,  4 Mar 2019 00:55:31 +0800
Message-Id: <20190303165532.23727-2-tomli@tomli.me>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190303165532.23727-1-tomli@tomli.me>
References: <20190303165532.23727-1-tomli@tomli.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In function sm750_hw_copyarea() of sm750_accel.c, there are
some comments in ASCII graphs, describing 4 possible scenarios
of overlapping areas when copying an area. However, the graphs
have broken indention.

The entire SiliconMotion series video controllers, including
SM501, SM712 and SM750 have similar 2D engines, yet, I have
not seen a single version of it with ASCII graphs properly
formatted...

Fix the the misleading ASCII graphs. It would eliminate the
confusions and improve code readability.

Signed-off-by: Yifeng Li <tomli@tomli.me>
---
 drivers/staging/sm750fb/sm750_accel.c | 32 +++++++++++++--------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/staging/sm750fb/sm750_accel.c b/drivers/staging/sm750fb/sm750_accel.c
index eed840b251da..dbcbbd1055da 100644
--- a/drivers/staging/sm750fb/sm750_accel.c
+++ b/drivers/staging/sm750fb/sm750_accel.c
@@ -155,26 +155,26 @@ unsigned int rop2)   /* ROP value */
 	if (sBase == dBase && sPitch == dPitch) {
 		/* Determine direction of operation */
 		if (sy < dy) {
-			/* +----------+
-			 * |S         |
-			 * |   +----------+
-			 * |   |      |   |
-			 * |   |      |   |
-			 * +---|------+   |
-			 * |         D|
-			 * +----------+
+			/*  +----------+
+			 *  |S         |
+			 *  |   +----------+
+			 *  |   |      |   |
+			 *  |   |      |   |
+			 *  +---|------+   |
+			 *	|         D|
+			 *	+----------+
 			 */
 
 			nDirection = BOTTOM_TO_TOP;
 		} else if (sy > dy) {
-			/* +----------+
-			 * |D         |
-			 * |   +----------+
-			 * |   |      |   |
-			 * |   |      |   |
-			 * +---|------+   |
-			 * |         S|
-			 * +----------+
+			/*  +----------+
+			 *  |D         |
+			 *  |   +----------+
+			 *  |   |      |   |
+			 *  |   |      |   |
+			 *  +---|------+   |
+			 *	|         S|
+			 *	+----------+
 			 */
 
 			nDirection = TOP_TO_BOTTOM;
-- 
2.20.1

