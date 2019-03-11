Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AB9BC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 13:20:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 255F120657
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 13:20:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727840AbfCKNUE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 09:20:04 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:60367 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727623AbfCKNTj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 09:19:39 -0400
Received: from orion.localdomain ([95.115.159.19]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MVvCl-1hSoIx0Ovt-00Rrx8 for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019
 14:19:38 +0100
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     linux-kernel@vger.kernel.org
Subject: [PATCH 080/114] drivers: devfreq: Kconfig: pedantic formatting
Date:   Mon, 11 Mar 2019 14:18:32 +0100
Message-Id: <1552310346-7629-81-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1552310346-7629-1-git-send-email-info@metux.net>
References: <1552310346-7629-1-git-send-email-info@metux.net>
X-Provags-ID: V03:K1:b6095jJY3z2x7HQjvKMC1VhDD/IIfvH+3CTiq77Gqp24Z1NYTDD
 78eSMsPOEFtAv7XMEVNi62RCYw6X99c/Q2uJHa0U+cO7MKF1iA99J+dceAaKk0mBSLzIA8j
 WZ9WIYYSeFRDNHQb8i1F0k6v7buvAUhnXiDt6yrVpnD3w12bSR2FC0f8JxUXT9mZtutYkEL
 QYdCLZY4tvdfkgdWz0bFg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:HXXZIyIAjlk=:3vnsnbAEkkbc2sTsBZJ15S
 /JB5nR7vZYAGJ8UUO1PVNvuXPQarPdcRdKB8AZLNmQrn+gyktHdkl85bsEynIOG2qWcpPr1tV
 SrRy3D/63cdWUjAthD4fvfOupqKut1IKZn8hfEurW1iVEpWeDEdBVZ6Cf+z7rSyi2Jr/pOHru
 nK9rhZIw+00WnsIjMZYJoN/tayEmI+4bbojuonrdmYlGxeOce8h7jFgjx6QwimDA6hetHNbyo
 WjCO2Bx+oARYB3OhNmVrQYfN/pJ1f9abG2JZXvyIL1zwcKhO/qyY0UtQaYHkPf2qotzW1oXZR
 IqDQzudSnTuTwscxh6zwWPCElQ8Xuf9MwNTa1OyP7lgNVwXMT3CzcWqpfn707vZH+uxyPaWey
 1+KMLCCV+PY4YxLOvV7cUFgORUssVsUoiuABHq8BCGYIIKt88VSxbgNiOob6lniGAZNxQnNGA
 UYEn0NtZDznfzacPgCLqjJYMmHS+5EAVfpX61lA7tylcOnW6CqDYRc/Ywq+LxwiLVCG7P84r6
 fP5h/gVoxaLyUXscA3CJEp0XWOgIBkaa3muGDUCLkfBY9lD2C4Oxa02XEAzNsETyjXZV7WUrG
 dfSjjE6ucnervqZgF4RGCScMan58xB5taim8FYzYPSb+9bBmRCkHC/o5aJOYCgPZR336jGzmb
 a+zgONMi3bf4TYqbRlG22KiOd5pqbNsF8MG2gsJIztHUI0iTZiErpo5JLw+3jRK4g1RcKnVEz
 rfUoBCk7E4JSi79Xg1ZBgFJUyAghEVH5D4+Cag==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Formatting of Kconfig files doesn't look so pretty, so let the
Great White Handkerchief come around and clean it up.

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 drivers/devfreq/Kconfig | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/devfreq/Kconfig b/drivers/devfreq/Kconfig
index 6a172d3..1af5ca3 100644
--- a/drivers/devfreq/Kconfig
+++ b/drivers/devfreq/Kconfig
@@ -109,9 +109,9 @@ config ARM_RK3399_DMC_DEVFREQ
 	select PM_DEVFREQ_EVENT
 	select PM_OPP
 	help
-          This adds the DEVFREQ driver for the RK3399 DMC(Dynamic Memory Controller).
-          It sets the frequency for the memory controller and reads the usage counts
-          from hardware.
+	  This adds the DEVFREQ driver for the RK3399 DMC(Dynamic Memory Controller).
+	  It sets the frequency for the memory controller and reads the usage counts
+	  from hardware.
 
 source "drivers/devfreq/event/Kconfig"
 
-- 
1.9.1

