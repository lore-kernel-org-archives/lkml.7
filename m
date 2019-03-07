Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3690CC43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 01:25:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02EAF20842
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 01:25:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727438AbfCGBZ5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 20:25:57 -0500
Received: from mout.kundenserver.de ([212.227.17.10]:45127 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727418AbfCGBZ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 20:25:56 -0500
Received: from orion.localdomain ([95.118.27.116]) by mrelayeu.kundenserver.de
 (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MD9Gh-1hAkDW3XJR-0094wR; Thu, 07 Mar 2019 02:25:51 +0100
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     linux-kernel@vger.kernel.org
Cc:     atull@kernel.org, mdf@kernel.org, linux-fpga@vger.kernel.org
Subject: [PATCH v2] drivers: fpga: Kconfig: pedantic cleanups
Date:   Thu,  7 Mar 2019 02:25:50 +0100
Message-Id: <1551921950-28695-1-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1551896937-31066-1-git-send-email-info@metux.net>
References: <1551896937-31066-1-git-send-email-info@metux.net>
X-Provags-ID: V03:K1:rf1ia7ip22HKKhhvBZ91o+vf2zfo5ZVHEe1Dad2yD2UK34cFNKQ
 +aElcq+sLbmOwjKkbhjrE/CUxdnTXriIIQxTTV3mfXOEsp4ZtyyiJ+tdQYjxwGNfnfU7ArF
 pVVBox3XqUDvvaIRpcvefeoSi7v/QgHX/ro68/mVGGInU4n9LoNzR4O/75c29CLDiurjfcG
 Xlj5zZAaAEB5jK6xY2F9Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:v60/en9Vwwo=:Rg85jOLNOa2nm2q0EsjVC8
 5C3SsxYoVTNAk/OP7rwTzrJ/cBBJ/eKmifJa7GOegHjVpE+w8JAeeO+iumUa8bkRpPGtZ4z+x
 KM0OUNzPDmn6C9dvn6RGsi10Blu/pUnbmNne/ixOV8C1RXtVEdQVts1TPQB4I7m8nUHHXEsP/
 X6z14tpQbVad0yB8iXJ4tNRRkJq66tqFngeV0C5TxYNIgoyrUL44Ms9dmRvLFixXQFY+DRzxg
 fxBHj417IvqJi46lRU0etjks2qDjnf9tSTSqOtOmBZFXoEn4+UlkygUuurryL+O4L/SMu9adw
 TmUv+SBlwt+ApwoMJdEflxntsxdp7wHEdlDuUDqOwFct6/CwzcbfdkKQIgeu7jwucNgVzApo8
 82mt8bUhyXNhXIe0sFw9MIStnKpiDdhxi3jh8SfZeIHJZ3CZ4uEPQUuBGYp3ybm4eosWl+VLO
 yvo0Zz4o2D+E24niDcRNpMfZCk3O7DBy3e5SqQzO0nAKcN5EhHh9u9b31i594MDbR1ryhUZRF
 Gah3XYBG5lcIdKDO7BQlVTTxBQYZxA/rk2wFVbI+mg9J1oVTs5yDVfyoR+de2CfurAMACJjQh
 2JKF7XVULjY0N5OZc4uedwQOocin4AfKwS9OKrCE06flK5lyTdqiuFgJqL3SLr7+wXn3autXI
 MPaP31v0Gg4ak2yaSfK89GV02Ed6GaJh0gpiqK9nhLDCttML6kB5dK73WgH/rMi59k4BGePTd
 xGC+Uy1tRtVLju7HpZdhuE5kkZHkP2s4dyXD5A==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Formatting of Kconfig files doesn't look so pretty, so just
take damp cloth and clean it up.

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 drivers/fpga/Kconfig | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/fpga/Kconfig b/drivers/fpga/Kconfig
index 0bb7b5c..d6562df 100644
--- a/drivers/fpga/Kconfig
+++ b/drivers/fpga/Kconfig
@@ -25,9 +25,9 @@ config FPGA_MGR_SOCFPGA_A10
 	  FPGA manager driver support for Altera Arria10 SoCFPGA.
 
 config ALTERA_PR_IP_CORE
-        tristate "Altera Partial Reconfiguration IP Core"
-        help
-          Core driver support for Altera Partial Reconfiguration IP component
+	tristate "Altera Partial Reconfiguration IP Core"
+	help
+	  Core driver support for Altera Partial Reconfiguration IP component
 
 config ALTERA_PR_IP_CORE_PLAT
 	tristate "Platform support of Altera Partial Reconfiguration IP Core"
-- 
1.9.1

