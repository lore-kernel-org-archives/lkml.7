Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8856CC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 13:20:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6345620657
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 13:20:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727921AbfCKNUO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 09:20:14 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:44521 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727653AbfCKNTl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 09:19:41 -0400
Received: from orion.localdomain ([95.115.159.19]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MXY2T-1hYt7522hT-00YzUi for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019
 14:19:40 +0100
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     linux-kernel@vger.kernel.org
Subject: [PATCH 097/114] arch: riscv: Kconfig: pedantic formatting
Date:   Mon, 11 Mar 2019 14:18:49 +0100
Message-Id: <1552310346-7629-98-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1552310346-7629-1-git-send-email-info@metux.net>
References: <1552310346-7629-1-git-send-email-info@metux.net>
X-Provags-ID: V03:K1:+y2cBMCeI8jbAYeOA+KoFd9gDXG4xus3dgf5gYFDZ5zAzyKRZIE
 Vx4MFhNLZGRzoig4HfG1yjmeU5CgBZ2NngDziOIteEb285iTuitmyyXY/C9p7c5eKTbVphp
 EOj+BLx0xd7o8GHH/Zvg3Wi25r+ZGgCalguPRvNkMrztq2Z/UOBNh6mWJp4a2YOw5wVG6PB
 urfY9Z/6CJ1e/qPgLZN1g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:vYzl0sYgbWQ=:k1+X/VP/dgfNOo/kqL5jCd
 P3OK07rTHhh863ouJ+S0pQoZHg+65nwimhPXiQQh3Jv6Dxgu7YFtMx8sLKwA2ypkDkvH9mNt5
 iSZGNJiDOs4C423/Vh9D/kRMbtgCmSOvYVJYamiwK2sqW5bZo32xnxf5ZzHmle4s8XgC8Ul+T
 ykdjJ5o6jNy8DbFPyxJN+Bl8yU63D2zB4z0M4qhslCZRLlkvdiZfkNOHXtC0otNRy2Yw5jHqX
 wpyRQdEmNIc6BIuVy92fwaGpFx2UrCvWfYh+0dQb3ZBVs7zZ6VUzQqUX1epcM3Fnji1Tb04uE
 bKN/BgVxS3LNFv4u4c2UHoWaGBfNKHV29SqQuozH7k+pBUmnYHFweGlNgnZGyhjFEnMrMkkVB
 lXUf4ZE/bi0Y5dLGxjfycY59rewACBBS93slro+vjvDV1Wt44gUfi9ZJkSTkx8scHjE3YkGB1
 fPlDmD58wlF1YVX1kt0GFSsZHCASIujdwKnNcYcrVNQtboT51rzDpdNpUZKzLcEFugbjAX3w6
 lQT89ugldHDCy73ds3nXAie1xgZPnwX/TT6vT89iJWAP2i3ayHGO8N2S7W5CIolEuNjJdltTP
 r1hQw3t+pdLzM6n5l6drWoqLxXCahH1raQ9XmcsRlb9SDg5450i+Xn7rJq4xpecj3zTVLRAGa
 B9h9BcGetpJT8bD+reBaFhBvf/E9EOuR5fO14DB0yrdGz+v4V+Ko7UkJTDeQFGCQWMzAzvX3t
 yQqMrdhkauCa4Ir5Ep0F8r7PnkPldE7mWdGsng==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Formatting of Kconfig files doesn't look so pretty, so let the
Great White Handkerchief come around and clean it up.

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 arch/riscv/Kconfig | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index eb56c82..5dc6a2b 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -191,11 +191,11 @@ config RISCV_ISA_C
 	bool "Emit compressed instructions when building Linux"
 	default y
 	help
-	   Adds "C" to the ISA subsets that the toolchain is allowed to emit
-	   when building Linux, which results in compressed instructions in the
-	   Linux binary.
+	  Adds "C" to the ISA subsets that the toolchain is allowed to emit
+	  when building Linux, which results in compressed instructions in the
+	  Linux binary.
 
-	   If you don't know what to do here, say Y.
+	  If you don't know what to do here, say Y.
 
 config RISCV_ISA_A
 	def_bool y
-- 
1.9.1

