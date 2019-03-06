Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91A30C43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 18:30:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 677C8208E4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 18:30:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727834AbfCFSaw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 13:30:52 -0500
Received: from mout.kundenserver.de ([212.227.126.133]:52107 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727765AbfCFSar (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 13:30:47 -0500
Received: from orion.localdomain ([95.118.27.116]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1Mg6mM-1gamsb46hy-00hbK9; Wed, 06 Mar 2019 19:30:32 +0100
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     linux-kernel@vger.kernel.org
Cc:     linux-nvme@lists.infradead.org
Subject: [PATCH] drivers: nvme: Kconfig: pedantic cleanups
Date:   Wed,  6 Mar 2019 19:30:30 +0100
Message-Id: <1551897030-2219-1-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
X-Provags-ID: V03:K1:DeSHj3fbz1Q828yaBJ4kOujVZDx+jIJ5+b2cnuFSdJEFeHd9lKI
 ycyx98bMtC/iNd/NNM3P+cMaoSKQrR4Q/+ELURKMtsCe5ksYz4AQc45ab9snFORX50+SMrm
 DIwhdNBUwVKLT85BtxYipGMKA6IKa7QV9gWT2k/DMzDB336ePAe8W3T9/NRQNdMrjhstyKe
 ldoDuockmC07BwxCWDcnA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:yMGon7iQg4k=:RnoBwJ9oQvH9agMpWfkwV6
 26ZdEZ2RRk+ntMuTzcRdpF1IYuGi8HhyJsKUhjXAydK/hZSIZpl6357zwRynQ14iTxrZoUumC
 zi6/G4PE4ESXAOU4jfoaHcmPkBg3BMgFSVI6+EL8bxBvy9mq1BCBkLnnyviswDllRrBaiatIC
 NRpyPgMOO/UVCeLpMMuHMJ/3nAYZaxplxjZC/F9MWZUeC/DyzOxi1WUeCEnk/a+hoo6CtJjRH
 xl/a2ER+a+1oSZrsrbFgq8iOQ96MoNYStIowBqKlwO318Sdo9aFtUF9O78Y2dtpfz9xQj6PHM
 T1YSThZyG/BgmbSXOQS+nxn/O86BxDU7id/8zfX7Lu7aWkR67nQMpxYQziM5omyG8Q+Qy/DJf
 lm9GbT7GjbmCJ7S+v56ejmeiifeYNU1sLNzJncc6182bfOiyxrNILt78UwZysR9rHGt0bvmvN
 Y1nvIV+l/DAOy2Ej3aBWqZc/sSAAE88adwoDBdN/68S7DUHt9jJsF+2mAtF2HdsTltHtwcow9
 ZcVsoHhU/kPWFZxFjOEk4+9agN+m+rGkCl8tsEuyBvG440OxC6bzIIBSRc+yza5QVjUwvK2Sq
 abJX/bDYZ4p7BcmNOsWMNv2BxQx1Fa4ljqvXPfuRG0rG2pPqEPL6shXZbs1qEjxoYsFQCkyTo
 WCcn0Epnytpbt3zLrGmk621XsXJR6nfRLeEStEUERf0+Dz+64L9eG2A2w15Z6IfiHsj/qLjvH
 riCPn69oTBm4n6mO0GHWJVuPf5yjFlADc0jbkw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

