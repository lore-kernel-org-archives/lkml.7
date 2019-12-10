Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C32DDC00454
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 20:43:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94FEF20828
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 20:43:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727036AbfLJUnT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 15:43:19 -0500
Received: from mout.kundenserver.de ([212.227.126.187]:47761 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726619AbfLJUnQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 15:43:16 -0500
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MN5W9-1iOcuK2SST-00J1lI; Tue, 10 Dec 2019 21:43:05 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, dri-devel@lists.freedesktop.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm: tegra: mark PM functions as __maybe_unused
Date:   Tue, 10 Dec 2019 21:42:58 +0100
Message-Id: <20191210204304.3313845-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:LvIe3xUHuuPDkbK+6q+8yJiA9Fy+DJa+D4MMErBdioZQrBVJcRJ
 /rAyfxdAFGSUIfY2w+bfOOmxTJ7cn/ZVyDxsk34zfivVZ6VWKHgBZMtEnQfy2OTIyyMEwt7
 pm+yq9MSGrCMELZwoY1TsYYCLBGdoOQ5Erufm0z/Wf4eJjcJ3n+6CsaOtG2V4FYZgHDKRnJ
 8bN9DfRMprmBQHpb1GB6A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:B3T4ErrlCQQ=:fAyd3pJFXjEWurdJz4jTJw
 i7zZc9uIsQCe132lVtnZYbmUiBShLxoRn5JL9YRvY/kuU3lINEphRy1njgLNOLPbEcKblK7tp
 wLOIf4PcwpEPKhAnrFtdys2kOsmZmUA3A48EJ2URYCsMzkht7G+0G6tH78avnowXfnZXB1vcQ
 1jlw3Utl8kowESwtErS1J7O1+jWSGILXsbmXKfqtr0ReSBEy84DS2JYd4OUFUMLY0ACCB598s
 M4PS9Mk26Oy4j3CmQiPlz3HckwQQ4cH0NUfbN/MN/EaDC6Ye5A/UJfk/DidNPVMo77PDI9+ZJ
 bvaC0BSGXhVpLcs5HqgZsH3DQ37WEdrF7UWd9ySPA8TkFKXZ4yLQ2jPo8hCSlv4qZvDSeSnF8
 bTMz9c9Ri4rcNwIu8kqSHEIhv6ZqHaWhiM7b0s74PpccfJbSBJz7YKIgZtJIGNkKFQkAAz4Kq
 Z5ChDMLQEZE59B1/k8eHBJS+C5kGbbNtOckpABk0VXKUHNidUOnFZ37ZMYXjNZKMDWm2bfw08
 zgja4ZUoV4sgIcK14fjGozvu/8KdNSY9fqG8PAlkdor9/m0SPNrWMUP+HKlfYA+caeXBC8BzE
 SKuwvwB0UzES7RHoT6508f+z0BxdLf2jPtW1zoLlOdUMLf8ip6OxDtqV+RUfbh8PhOddzKPmN
 kX+BdwlnNGJOZVMuF9I/zD7ln/rOTfS4Mq23KVM/Y+KioLcoG/Ugp1ggjO3ILrrZLWXKW89hX
 dXwxaxlrSfjsDmStlTr4pkfifZPIa/E/dwsYXA0NJ7eDDW81dNqqFa7ra5swQMaHeLT8Z30vu
 jBr9JBHwh14CNW7zRfofiA9JzSWBCnJQZXayd6hAMzHsoE/2uOPTsX8DkkicnWid9a4UcWWX7
 2CZcNXlHLOw4+x1VsI0Q==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Without CONFIG_PM, some functions cause harmless warnings:

drivers/gpu/drm/tegra/sor.c:3984:12: error: 'tegra_sor_resume' defined but not used [-Werror=unused-function]
 static int tegra_sor_resume(struct device *dev)
            ^~~~~~~~~~~~~~~~
drivers/gpu/drm/tegra/sor.c:3970:12: error: 'tegra_sor_suspend' defined but not used [-Werror=unused-function]
 static int tegra_sor_suspend(struct device *dev)
            ^~~~~~~~~~~~~~~~~

Mark these as __maybe_unused so the compiler can drop them
silently.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/gpu/drm/tegra/sor.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/tegra/sor.c b/drivers/gpu/drm/tegra/sor.c
index a68d3b36b972..69b9ebee7486 100644
--- a/drivers/gpu/drm/tegra/sor.c
+++ b/drivers/gpu/drm/tegra/sor.c
@@ -3912,7 +3912,7 @@ static int tegra_sor_remove(struct platform_device *pdev)
 	return 0;
 }
 
-static int tegra_sor_runtime_suspend(struct device *dev)
+static int __maybe_unused tegra_sor_runtime_suspend(struct device *dev)
 {
 	struct tegra_sor *sor = dev_get_drvdata(dev);
 	int err;
@@ -3934,7 +3934,7 @@ static int tegra_sor_runtime_suspend(struct device *dev)
 	return 0;
 }
 
-static int tegra_sor_runtime_resume(struct device *dev)
+static int __maybe_unused tegra_sor_runtime_resume(struct device *dev)
 {
 	struct tegra_sor *sor = dev_get_drvdata(dev);
 	int err;
@@ -3967,7 +3967,7 @@ static int tegra_sor_runtime_resume(struct device *dev)
 	return 0;
 }
 
-static int tegra_sor_suspend(struct device *dev)
+static int __maybe_unused tegra_sor_suspend(struct device *dev)
 {
 	struct tegra_sor *sor = dev_get_drvdata(dev);
 	int err;
@@ -3981,7 +3981,7 @@ static int tegra_sor_suspend(struct device *dev)
 	return 0;
 }
 
-static int tegra_sor_resume(struct device *dev)
+static int __maybe_unused tegra_sor_resume(struct device *dev)
 {
 	struct tegra_sor *sor = dev_get_drvdata(dev);
 	int err;
-- 
2.20.0

