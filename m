Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F97BC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 13:25:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7817A2087C
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 13:25:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728102AbfCKNZA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 09:25:00 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:32847 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727433AbfCKNTj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 09:19:39 -0400
Received: from orion.localdomain ([95.115.159.19]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MAwPf-1hEaIt26o5-00BITC for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019
 14:19:38 +0100
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     linux-kernel@vger.kernel.org
Subject: [PATCH 083/114] drivers: vme: Kconfig: pedantic formatting
Date:   Mon, 11 Mar 2019 14:18:35 +0100
Message-Id: <1552310346-7629-84-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1552310346-7629-1-git-send-email-info@metux.net>
References: <1552310346-7629-1-git-send-email-info@metux.net>
X-Provags-ID: V03:K1:jXThxQ9mDwEqVfPRR6kSFJM9cHnjcXZZvce7gByJ9+5rwpf0Bf2
 s4pJarTUqs43TdyYc81kjQp46a5/BKtBahIhuB9WEec/4WSqlVRUAmezpF5huJDFZCH1FKH
 Vb6LUXSWV9+UXpP3KZeF612j17TaKrICSbYIwv9EWWAHIaMz6Bk8vMZ1CVoE/qeaatsrXxf
 YLJkaX7P1GlSP5Bknki1w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Gw7A2Jx0EFo=:RtyR4TcgPmfVIBkLlep4i2
 JQ5A7Te3kWbOssI9zcSs8prRhZao27fbwiAo95iCLpy1iVVzU8HYvTxF8OpKBTQsY01xtcm11
 fwODHjwzEOjofarwdZOpC0jQkkbxz7a2ZuTiCYBjFZNWIHjBb0Gj9NSfivvrW1u5bmoo2Z0gD
 ZA4IVVPUELyt/t/m8BT//+/4DJ5vjiYCsbiqWItMsGWxj4pND3/cS2AxC7T8in5U0RrWUw4+3
 AcQ8v48woHuVKI0NxWRqb77QVrqL6tcuchrFl6yWKggU3oK7Q5tzvKdeUO3w56suHs22QTInj
 6z6ME+7fTlBAnsj3+efzyujM+jZ6o2EpAixP1puY9Uz9fiK6E0Q1skk4hd4P1Z5Ep5GAQTUPy
 EL87EtCAuLspyWFdtuMXAht1ear7Drsw3FfSzvKZ+xWES+nRMzpBbQPQGfOpmEY6zcKaPzN9y
 XiMZczsOhjnq+w+9Cu1Uk5pF/MxiPAk5F/uBLmQv21ptqMMeuu0XfhwazW5KZJWldQgiKEV6m
 H+6kM0oqS7/V+Pshv4ycp+K66I8/QSrmEGNg8gSbOCkuwXQIPtMhprJpsXJu4zDwpyOxYdugu
 pnuGnoiKnDlhL58M4lrwdZ+xx2UO5FlOCZjxeTdpOuzbXwuOkMeh95iWcQxlnWNWUzir0IgOx
 AO35stMPkC3V6OhrqHvUg73Xgph7jSBiXg1waNd305OtZxtqtcadIBUaTEkvlY+jR6ana3Ssu
 J/SaaZZTLui1R4VKQ/ChUtqZUHMVmUeIF2hOQw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Formatting of Kconfig files doesn't look so pretty, so let the
Great White Handkerchief come around and clean it up.

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 drivers/vme/bridges/Kconfig | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/vme/bridges/Kconfig b/drivers/vme/bridges/Kconfig
index f6ddc37..adbb92d 100644
--- a/drivers/vme/bridges/Kconfig
+++ b/drivers/vme/bridges/Kconfig
@@ -4,20 +4,20 @@ config VME_CA91CX42
 	tristate "Universe II"
 	depends on VIRT_TO_BUS
 	help
-	 If you say Y here you get support for the Tundra CA91C142
-	 (Universe II) VME bridge chip.
+	  If you say Y here you get support for the Tundra CA91C142
+	  (Universe II) VME bridge chip.
 
 config VME_TSI148
 	tristate "Tempe"
 	depends on HAS_DMA
 	help
-	 If you say Y here you get support for the Tundra TSI148 VME bridge
-	 chip.
+	  If you say Y here you get support for the Tundra TSI148 VME bridge
+	  chip.
 
 config VME_FAKE
 	tristate "Fake"
 	help
-	 If you say Y here you get support for the fake VME bridge. This
-	 provides a virtualised VME Bus for devices with no VME bridge. This
-	 is mainly useful for VME development (in the absence of VME
-	 hardware).
+	  If you say Y here you get support for the fake VME bridge. This
+	  provides a virtualised VME Bus for devices with no VME bridge. This
+	  is mainly useful for VME development (in the absence of VME
+	  hardware).
-- 
1.9.1

