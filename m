Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63CF7C4360F
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 13:30:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 334E1222C9
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 13:30:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728171AbfCKNah (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 09:30:37 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:40593 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727500AbfCKNTb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 09:19:31 -0400
Received: from orion.localdomain ([95.115.159.19]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MeTwY-1gTBCv2b8G-00aUxD for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019
 14:19:29 +0100
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     linux-kernel@vger.kernel.org
Subject: [PATCH 015/114] drivers: nvme: Kconfig: pedantic formatting
Date:   Mon, 11 Mar 2019 14:17:27 +0100
Message-Id: <1552310346-7629-16-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1552310346-7629-1-git-send-email-info@metux.net>
References: <1552310346-7629-1-git-send-email-info@metux.net>
X-Provags-ID: V03:K1:ehyj0M+Notcgj6s9BxFxWRLaAW2XEjiu4epqWNJ1GXFlj6L0dYv
 BT70z0eWLVz9xunGDgXV8djHP0e7qAh51kMFoxj8S1UKzeUpsfA5KCVzOEeatIAjWafRYtY
 RNlpu540FTmnBPGF3pqpvluZ2qiaIQtdg2gvFQs5W5ITIknMh3aR4866VeQR0dt+MV8TSZy
 Fc5xpFEzrxnBu5uVJsQIA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:rQnNcWcy4XI=:rvWHKYpFaRHEclTQqJ7j7j
 SMmpw7bQUJ2C0cO9QUW2EhOO/2KIcWrtWPi+6Tvy2dmPoKM8jUY4DKqPJEfE6dCZ2s8DBchM4
 PQVPN8NppTV6PhTgPOF0w8aCwdQDG7849mrx76o/H/mcjtDwA07KNZv2Bwky3c3j64tPIfZHx
 QnK/lejAL10fKK8oltc814TSnqQ0sgzqoPDDPBcDk8vTxts53cxiLMMGEtlGSBA1oeJkTkSYn
 9BbbKvh6aGSyX2hBlV9kG9f9lloadOHcA827UoHIk7rvrh5meJuHNybCKwEGXARa61TfHtSiz
 WdnGHTbq68ZVev6VSi1Q2koZ7m3wCJZHiF8HEC1FGqwFUlpaEAeBcJogimBD+3q5ilxNkiTcy
 4xJC7ElVRJCFa9fvfIGq1pqhg2j4RXGfFnEk9vBuuTNFRECIRUW7TBHjGa48wkn2bJH3qkheh
 dA3dJFXBvr0ZnQYsXtK5D1qEq2gmPLGUCNZQtFut9XjUScttJOQxITQEV71xJJzl1EBoBeMkT
 MHaKG6ZGmV7Pl2wagh/L6eU41alIKCa2J8mm6KKbOU5G7pSelscz8adoXw59ydQMysjzELwrR
 WPz40378K55lqKZXl/Uai+bSuhDkp0wzj1HgxnGC8IyYM3y/FWB7zFRR8uBZVZ6Iu7ki6B+st
 SzEyBDdggCmch9eeZ5VoxewHqEIyuxU4Xqs+zPYA6rj9J/lKnjbycJv4mZZcQkmUps9X7zhzS
 tniSf0gm6MVe4BIuw5Sm53PfVSo44o+caF/Phw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Formatting of Kconfig files doesn't look so pretty, so let the
Great White Handkerchief come around and clean it up.

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 drivers/nvme/host/Kconfig | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/host/Kconfig b/drivers/nvme/host/Kconfig
index 0f345e2..ce361c9 100644
--- a/drivers/nvme/host/Kconfig
+++ b/drivers/nvme/host/Kconfig
@@ -17,10 +17,10 @@ config NVME_MULTIPATH
 	bool "NVMe multipath support"
 	depends on NVME_CORE
 	---help---
-	   This option enables support for multipath access to NVMe
-	   subsystems.  If this option is enabled only a single
-	   /dev/nvmeXnY device will show up for each NVMe namespaces,
-	   even if it is accessible through multiple controllers.
+	  This option enables support for multipath access to NVMe
+	  subsystems.  If this option is enabled only a single
+	  /dev/nvmeXnY device will show up for each NVMe namespaces,
+	  even if it is accessible through multiple controllers.
 
 config NVME_FABRICS
 	tristate
-- 
1.9.1

