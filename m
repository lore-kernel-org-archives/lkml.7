Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9EEEC43331
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 15:16:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82C202178F
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 15:16:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389753AbfIFPQD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 11:16:03 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:56103 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389510AbfIFPQD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 11:16:03 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue012 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MpTpc-1iVdYL0j08-00py2u; Fri, 06 Sep 2019 17:15:53 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Suman Anna <s-anna@ti.com>,
        Joerg Roedel <jroedel@suse.de>, Tero Kristo <t-kristo@ti.com>,
        Will Deacon <will@kernel.org>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: [PATCH] iommu: omap: mark pm functions __maybe_unused
Date:   Fri,  6 Sep 2019 17:15:38 +0200
Message-Id: <20190906151551.1192788-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:M0af/bs8WnLsuP5v9Cfk35XYuWThVjCh/hUKldRjhSEfmpKW5nU
 TgZI+JhlgW7OUNGEFkEKtYW0Q4sQeuBhhtcioFZ/qQ1cp684duECo09+mJCZ/JErVoQs/U7
 9vt9Dl/fFjGpETZ+6TmZU2WXF3GLe58bX0l8kO4gvBThJq8+hCgEnvPbsKifg01BhzP6b7t
 GGM5kQTV+y93s3XLlHrvA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:FTaH62799Ls=:IEN0kCFz2j77p/z0ACtfne
 SaZpmsL7cZsIuhw9dDwLOgQByab3KUEBgIUlzbr7I/K+qM9/46Ikxw6j8KtnUwgtL+7LWLnlL
 9DSrZbkCSq0n5gw51H55vijQziqGehEpIM9x5KHdGoQYFz5MuFxSbCzNf4BvipgXrPx6uQSTd
 AsAeeUUj48BT0PNxGkm1S9jRG1t1G3iCk38TxC7mBISxKPTrKf9+/9CZnWTmzJaXYAcBtfgc+
 C9niXUfYzQ7y3cw/6y0A56Cji4mfn+I54ZVdJKiznXxIasmeW/x1V/cHd7sG216cHWCPAtT9X
 QzGU1+3cZK1DPwP9hGk5k3XcPaJ8uTl8Iq+ulByyZyi/O3VqPqBlYCNAcKDcJh1ef2M04Illp
 gy8C2OeXPk89El0vCZO9Dw5BWwtMaVJI7E7/dX/YXSnKaw5oNtW7gMb1PRWdO1Un6y0kWHpR+
 GmnWXHdowppVLB+TJS2vNDZq5ay7sECkB669iureCDXtESyOq0s7oyOz+dqHhWuHtv8rj7Wxc
 qermZ56i2H+0ZXk7PznB4DweZfo7jKKlJIjsmFX1wTG8KHFChgX6Ex60xyu/qmf62M+IWGH0p
 ZQ5MnUNJMEdRyMvF7Aw4/NP9gn6U7RFC8uOjsUXm5wf1tUPWF8T2COCVPDOe/96Q8HWPplvBI
 0/zGQIAn6iI+5lbYce7QjkPc2ypBPkXyLR4O4iMRSZg2EnUcxel0RzQ2RXcMOJ5aNHi2L9cq9
 FTmtCPTF3hWNE2MwpPUL9rcS/1irRmfGi2npPopRdOJpjv123XnzTHWshXvaZyqszLCPMS3Ts
 e02ozL0PENqjoLXdclkfRN3556XLSPbi1/Jjf8bMQjhv3AxvLQ=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The runtime_pm functions are unused when CONFIG_PM is disabled:

drivers/iommu/omap-iommu.c:1022:12: error: unused function 'omap_iommu_runtime_suspend' [-Werror,-Wunused-function]
static int omap_iommu_runtime_suspend(struct device *dev)
drivers/iommu/omap-iommu.c:1064:12: error: unused function 'omap_iommu_runtime_resume' [-Werror,-Wunused-function]
static int omap_iommu_runtime_resume(struct device *dev)

Mark them as __maybe_unused to let gcc silently drop them
instead of warning.

Fixes: db8918f61d51 ("iommu/omap: streamline enable/disable through runtime pm callbacks")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/iommu/omap-iommu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/omap-iommu.c b/drivers/iommu/omap-iommu.c
index 451e3c98ab2d..09c6e1c680db 100644
--- a/drivers/iommu/omap-iommu.c
+++ b/drivers/iommu/omap-iommu.c
@@ -1019,7 +1019,7 @@ EXPORT_SYMBOL_GPL(omap_iommu_domain_activate);
  * reset line. This function also saves the context of any
  * locked TLBs if suspending.
  **/
-static int omap_iommu_runtime_suspend(struct device *dev)
+static __maybe_unused int omap_iommu_runtime_suspend(struct device *dev)
 {
 	struct platform_device *pdev = to_platform_device(dev);
 	struct iommu_platform_data *pdata = dev_get_platdata(dev);
@@ -1061,7 +1061,7 @@ static int omap_iommu_runtime_suspend(struct device *dev)
  * reset line. The function also restores any locked TLBs if
  * resuming after a suspend.
  **/
-static int omap_iommu_runtime_resume(struct device *dev)
+static __maybe_unused int omap_iommu_runtime_resume(struct device *dev)
 {
 	struct platform_device *pdev = to_platform_device(dev);
 	struct iommu_platform_data *pdata = dev_get_platdata(dev);
-- 
2.20.0

