Return-Path: <SRS0=avfD=SQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5655CC10F13
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 04:56:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FDEF2084D
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 04:56:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726159AbfDNE4y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Apr 2019 00:56:54 -0400
Received: from www.osadl.org ([62.245.132.105]:46582 "EHLO www.osadl.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725681AbfDNE4y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Apr 2019 00:56:54 -0400
Received: from debian01.hofrr.at (178.115.242.59.static.drei.at [178.115.242.59])
        by www.osadl.org (8.13.8/8.13.8/OSADL-2007092901) with ESMTP id x3E4tDwj021036;
        Sun, 14 Apr 2019 06:55:25 +0200
From:   Nicholas Mc Guire <hofrat@osadl.org>
To:     Jason Cooper <jason@lakedaemon.net>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Nicholas Mc Guire <hofrat@osadl.org>
Subject: [PATCH 2/3] ARM: mvebu: drop return from void function
Date:   Sun, 14 Apr 2019 06:49:50 +0200
Message-Id: <1555217391-3552-2-git-send-email-hofrat@osadl.org>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1555217391-3552-1-git-send-email-hofrat@osadl.org>
References: <1555217391-3552-1-git-send-email-hofrat@osadl.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The return statement is unnecessary here - so drop it.

Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
---

Problem reported by checkpatch

WARNING: void function return statements are not generally useful
#141: FILE: arch/arm/mach-mvebu/board-v7.c:141:
+       return;
+}

Patch was compile-tested: mvebu_v7_defconfig (implies MACH_MVEBU_ANY=y)
(with some unrelated sparse warnings about missing syscalls)

Patch is against 5.1-rc4 (localversion-next is 20190412)

 arch/arm/mach-mvebu/board-v7.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/mach-mvebu/board-v7.c b/arch/arm/mach-mvebu/board-v7.c
index 37f8cb6..28fd256 100644
--- a/arch/arm/mach-mvebu/board-v7.c
+++ b/arch/arm/mach-mvebu/board-v7.c
@@ -137,7 +137,6 @@ static void __init i2c_quirk(void)
 
 		of_update_property(np, new_compat);
 	}
-	return;
 }
 
 static void __init mvebu_dt_init(void)
-- 
2.1.4

