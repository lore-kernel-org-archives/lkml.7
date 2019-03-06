Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52941C43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 18:29:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 310D8206DD
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 18:29:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727058AbfCFS3D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 13:29:03 -0500
Received: from mout.kundenserver.de ([212.227.17.10]:37975 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726767AbfCFS3D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 13:29:03 -0500
Received: from orion.localdomain ([95.118.27.116]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MtfVx-1goLYb3Edz-00v9R6; Wed, 06 Mar 2019 19:28:58 +0100
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     linux-kernel@vger.kernel.org
Cc:     atull@kernel.org, mdf@kernel.org, linux-fpga@vger.kernel.org
Subject: [PATCH] drivers: fpga: Kconfig: pedantic cleanups
Date:   Wed,  6 Mar 2019 19:28:57 +0100
Message-Id: <1551896937-31066-1-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
X-Provags-ID: V03:K1:s6tNgjJsrktczS3Bg84+DQPTPTLRBnzYWPVH+/vQw+5L/XtJYwG
 ny+irnfRizvkYJDTsiIxIzcuoGvTe4kFKRthcqV0nYmwSpRxxckqgv0CX2kL/h3Kpn0+zcb
 Jg9U86JgUtVXzmajQp4Uw7wW621nPFmRQFBQRFKZ1+rIkPqRg30/ojT/MU//mAsgYQWHtP3
 /+G5z+iBjEncC0K0I3SZw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:efp527prIIU=:XTzMruZAZ/8qsTg56KkZCo
 Q58pry5ZWDX5rIC0QBnSwS52lMGU4DCwe1GxrEi3j4MeXn73FfdkkkrfgANLTr+vR5Y+duphG
 2Oarf+x9MIF7uvPZuOJ3cHGYD8znv38c0p0NTAoN5SMOx8Sltc9RECN5Zdqm2/KrOycyKvs89
 QptkZhfvZI5lltdTthdmwJwOSDXUAqTMqcZMTTfm77MxMX9jVZXdgq1yYZnJOo3KZvWoGQw9q
 TRtD2/wGLDlDTzNWHQLU+9QEfFVZIcd6r6jqXVZN/lk9+XZOFoz9pJQ+JkHjPIvEqmpkLaYx7
 +WXviLlcS6pxgKtz9zSQqxrFgW9yUzRwoDSoBUeszhOmWJn5iJb6/Xvq4Xd5QTNXG9gdOxJOs
 Aixl30EUb963QUtEtoIEF075Zo8XMg14nsjQEGzRgZ1yU8EYtdFVO2X4AenrV6JiYEdwLpYHm
 J23IhmebLxAfwjkfl8aevqFbL9FpuZ/nA7sunuoanQJh8HzTlZqbfbBRo/QiTP/pDR8Q4RwjU
 mgJaNheahUZ+yV4BE+vkR9ZwevkLEmomYdY+tchVdm9FzShunYM4v+C++trcHtGdYYzjg4rym
 SPpamgPHln73N0gJbLZ+U6MJa7s94ll3IGdL40g1r+yMBra0lXt9+K83DoPEoQkHabjN41GcF
 nwpFxiIiJpRcgBYAfSUUP2HkV61Mo0AGQotHYfr+/pI9Vb8G/0nzdIRdvOOMwIEKPakdpHP7F
 qs49Tuk6jynoCZQEKhX6qr6LTnLwdD1A81pqQQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

