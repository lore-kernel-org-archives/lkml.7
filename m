Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1CB8C433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 09:02:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C315A2089E
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 09:02:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727582AbfGaJCQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 05:02:16 -0400
Received: from michel.telenet-ops.be ([195.130.137.88]:46960 "EHLO
        michel.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726699AbfGaJCP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 05:02:15 -0400
Received: from ramsan ([84.194.98.4])
        by michel.telenet-ops.be with bizsmtp
        id jM2C2000E05gfCL06M2Cqj; Wed, 31 Jul 2019 11:02:13 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1hskUu-0007Jc-4G; Wed, 31 Jul 2019 11:02:12 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1hskUu-00053m-1v; Wed, 31 Jul 2019 11:02:12 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Jonathan Corbet <corbet@lwn.net>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Simon Horman <horms@verge.net.au>,
        Magnus Damm <magnus.damm@gmail.com>
Cc:     linux-doc@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] docs: arm: Remove orphan sh-mobile directory
Date:   Wed, 31 Jul 2019 11:02:11 +0200
Message-Id: <20190731090211.19408-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This directory is empty, except for a .gitignore file, listing an
executable file that can no longer be built since commit
c6535e1e0361157e ("Documentation: Remove ZBOOT MMC/SDHI utility and
docs").

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 Documentation/arm/sh-mobile/.gitignore | 1 -
 1 file changed, 1 deletion(-)
 delete mode 100644 Documentation/arm/sh-mobile/.gitignore

diff --git a/Documentation/arm/sh-mobile/.gitignore b/Documentation/arm/sh-mobile/.gitignore
deleted file mode 100644
index c928dbf3cc8806e2..0000000000000000
--- a/Documentation/arm/sh-mobile/.gitignore
+++ /dev/null
@@ -1 +0,0 @@
-vrl4
-- 
2.17.1

