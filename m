Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB8F5C10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 13:21:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C3E720650
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 13:21:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388101AbfJJNVe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 09:21:34 -0400
Received: from laurent.telenet-ops.be ([195.130.137.89]:48816 "EHLO
        laurent.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387746AbfJJNVe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 09:21:34 -0400
Received: from ramsan ([84.194.98.4])
        by laurent.telenet-ops.be with bizsmtp
        id BpMW2100205gfCL01pMWmZ; Thu, 10 Oct 2019 15:21:32 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1iIYNl-0008Qb-Tp; Thu, 10 Oct 2019 15:21:29 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1iIXai-0003zW-86; Thu, 10 Oct 2019 14:30:48 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Simon Horman <horms@verge.net.au>,
        Magnus Damm <magnus.damm@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Kevin Hilman <khilman@kernel.org>,
        Olof Johansson <olof@lixom.net>,
        linux-renesas-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] MAINTAINERS: Remove Simon as Renesas SoC Co-Maintainer
Date:   Thu, 10 Oct 2019 14:30:46 +0200
Message-Id: <20191010123046.15291-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

At the end of the v5.3 upstream kernel development cycle, Simon stepped
down from his role as Renesas SoC maintainer.

Remove his maintainership, git repository, and branch from the
MAINTAINERS file, and add an entry to the CREDITS file to honor his
work.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 CREDITS     | 4 ++++
 MAINTAINERS | 4 ----
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/CREDITS b/CREDITS
index 8b67a85844b55d88..031605d46b4d5cc1 100644
--- a/CREDITS
+++ b/CREDITS
@@ -1637,6 +1637,10 @@ S: Panoramastrasse 18
 S: D-69126 Heidelberg
 S: Germany
 
+N: Simon Horman
+M: horms@verge.net.au
+D: Renesas ARM/ARM64 SoC maintainer
+
 N: Christopher Horn
 E: chorn@warwick.net
 D: Miscellaneous sysctl hacks
diff --git a/MAINTAINERS b/MAINTAINERS
index 94ce075907a0b9aa..d44d6732510df746 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2165,12 +2165,10 @@ F:	arch/arm64/boot/dts/realtek/
 F:	Documentation/devicetree/bindings/arm/realtek.yaml
 
 ARM/RENESAS ARM64 ARCHITECTURE
-M:	Simon Horman <horms@verge.net.au>
 M:	Geert Uytterhoeven <geert+renesas@glider.be>
 M:	Magnus Damm <magnus.damm@gmail.com>
 L:	linux-renesas-soc@vger.kernel.org
 Q:	http://patchwork.kernel.org/project/linux-renesas-soc/list/
-T:	git git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git next
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-devel.git next
 S:	Supported
 F:	arch/arm64/boot/dts/renesas/
@@ -2282,12 +2280,10 @@ S:	Maintained
 F:	drivers/media/platform/s5p-mfc/
 
 ARM/SHMOBILE ARM ARCHITECTURE
-M:	Simon Horman <horms@verge.net.au>
 M:	Geert Uytterhoeven <geert+renesas@glider.be>
 M:	Magnus Damm <magnus.damm@gmail.com>
 L:	linux-renesas-soc@vger.kernel.org
 Q:	http://patchwork.kernel.org/project/linux-renesas-soc/list/
-T:	git git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git next
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-devel.git next
 S:	Supported
 F:	arch/arm/boot/dts/emev2*
-- 
2.17.1

