Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A739C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 13:24:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5136720449
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 13:24:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728080AbfCKNYO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 09:24:14 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:60589 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727644AbfCKNTl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 09:19:41 -0400
Received: from orion.localdomain ([95.115.159.19]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MEVBc-1hIB4j41t4-00FxAn for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019
 14:19:40 +0100
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     linux-kernel@vger.kernel.org
Subject: [PATCH 093/114] arch: h8300: Kconfig: pedantic formatting
Date:   Mon, 11 Mar 2019 14:18:45 +0100
Message-Id: <1552310346-7629-94-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1552310346-7629-1-git-send-email-info@metux.net>
References: <1552310346-7629-1-git-send-email-info@metux.net>
X-Provags-ID: V03:K1:vvZ4boBNPvtK3VXAVY7B7HtBd9Rp0oydiP978l6oPqBD8ZaiepQ
 uGDPUf39Otg6tUqBQT1sMisKLLxpmIgBvP2Qsj1SPSFCri4aaUP7Adk68w19RzuP7QcuvMS
 VaQzFL+594Ewcl/x/DFZz1hYBaS+EPfqg6D3JvSTqPELZC9xsSrlb9NOD2MOOYd5MgoxaH+
 +/RDQmCHz3faAFNksYFjg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:3ftQ3JTFRb4=:XlteUeK0Et37nRTEmRnwmi
 i1EJ7dEljwAwgXTZljujpB1aJNXxq9RsmiWKmjKhvTJMLKwwjJxpT8wSdZrCEhZ7uHHSQPOec
 VEjcerGDHfx+UtgI7etZ720BsXxhKigK+ZnTM/HLPkKu+the/ievqT46t6Ev8+IpuH7NtWpcj
 doNnMXyZQJ0USz4Qeck1tC1HjqHnJoThn1eXQkIaSBwVRVRXBOHzOsoAGf3opakmwMFMC+315
 PfGcmkt2iGxNWmjMgCf1xE5D3LS4XSTCnskA0AjRFVJm2dD52EqGqoTNoJ7nrTTC6oAfdcTuE
 AHSaVcCV8i+nAU0OKA9jHj7CtAoe9j1j4m8bkkZCLYbkhpUuIsAkFeOLIMVK7Tw/0MoMCKdad
 FUJusxrKT/LrLBiQedpNpq8OrQP8B1IoVQXfqqIgaCkZNTp/qRbjSv5totHrVqMqLdTjF3gEf
 SyeDxANbXD/r8eh4DLbjYE30HWjnTg7wPNNLCfmF2sIseSNhBRvZAG3rb2cOZYXe2D3oHUoov
 wI8c+dTUiXfRCgn6rcm4ADgrrZf/W1fYbCUGDvAZzZj8wIRCq5MvGfXCxnuk4/SbqUzviCKY7
 4Mg56PGSNiCTCiaBOiFkvlwJuW9DgvNuThxbjhxCmod5peAifIysV3ugPvIiS1GcCW4MWMQrd
 59jxVglS8eCJfZuHyj++a7LkP1buE6mDDV1OpRStFXoDkStEUPrvU3imykmtGvMZNjIwe2NOL
 PBycYVaqwBHVnqH0CUEfvkor9AiH/9MI2f3Oag==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Formatting of Kconfig files doesn't look so pretty, so let the
Great White Handkerchief come around and clean it up.

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 arch/h8300/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/h8300/Kconfig b/arch/h8300/Kconfig
index c071da3..eb6854d 100644
--- a/arch/h8300/Kconfig
+++ b/arch/h8300/Kconfig
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 config H8300
-        def_bool y
+	def_bool y
 	select ARCH_32BIT_OFF_T
 	select GENERIC_ATOMIC64
 	select HAVE_UID16
@@ -37,7 +37,7 @@ config NO_IOPORT_MAP
 	def_bool y
 
 config GENERIC_CSUM
-        def_bool y
+	def_bool y
 
 config HZ
 	int
-- 
1.9.1

