Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23509C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 13:28:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFFC4217D4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 13:28:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728022AbfCKN23 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 09:28:29 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:42159 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727569AbfCKNTf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 09:19:35 -0400
Received: from orion.localdomain ([95.115.159.19]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MowSu-1gi1Rj403a-00qNvB for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019
 14:19:34 +0100
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     linux-kernel@vger.kernel.org
Subject: [PATCH 048/114] samples: Kconfig: pedantic formatting
Date:   Mon, 11 Mar 2019 14:18:00 +0100
Message-Id: <1552310346-7629-49-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1552310346-7629-1-git-send-email-info@metux.net>
References: <1552310346-7629-1-git-send-email-info@metux.net>
X-Provags-ID: V03:K1:3h+nWFM78mEUWibOh1tIWC7y7jV1GmeOl/6oyY0enuspj5X8jdx
 AF6UUUdXtDNpmiGp4vAj802I1M+FRgAqZ487KlTAt/iUfGaYTXfoWnLlUg0vcwWIJsZj+h7
 2/3oQHPcvlh2+La0c/zoAfJAQoFk7Jsld8F1padV+4ivIl1dQcUC/HDRg9Z0uW6eGvw+glZ
 yA83ZiDlMd5309sQuUECA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:9cs8+XTlSio=:FoW8Apijo+xZgsii0OjBcL
 nRD5wW1a5drui23w93cafTiNJCwjgyurn5IJnFG6TVxeSY5tMPonUVuslI1bdHKuaX5MCoLYt
 XP33szo2pt9IVjqnzOquWr+UT7G3Ve2EIY9k0kyosexKS2JrdC4JyGXrchPg2yt7RMFIDzMdF
 2WwoqpP5eQk6Gb5O9XkeqZmwuXZcl4WxGvGEbsJI+iWGd8F2ibyo2nJnzZCvE1xFByHA6tFKu
 vVuirpKUBatmT7L5zB0BYOBkh81+iXgz2opykM+pCVH5PWWMM75zQU1T2xn72mKcp+1tpOiqL
 DFhlJko8jk2nOKaGs25jBDbTcCoWMabRNQ38w8Y5ZWczF4o9HlhfL4ApPyBZy8VP3TVYPTmSx
 55PmCHqSXwe8vy/2jANHL/EuLV93VZPf9FeyIk7y7w4vpyY4yGrcLm2qLDiMymyzXpI13njq7
 rf1QshH8Q7mBXjV1h+RIEmph1hVtqN+B/AOR22ryGdjD8ofu0u9k5e5jGEc92ivcaTtRvjwhh
 ehSU6jY4aLErbpeGq4dsW8rFMSy1pTuDvXiviFm0SJ4vq5KQUg8B8l1v9G8VEJ5003426+dsq
 2R/gY/I9ezN92ogoh0RakQIW3EMMwFjxVVWOHE4MiYXV52v1xzAYoJXyZF44L4wdInBB1PxTn
 8pbxsABAnpG1wMv8Q7jvf6Yxv99twRyqfcNd3OVuljrrBQv2tiqmgt5r2e601kB+Q320ILfKQ
 4HjhBe/C/wVMvlDKNDkdLXHszbGzZjQUBT1IPQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Formatting of Kconfig files doesn't look so pretty, so let the
Great White Handkerchief come around and clean it up.

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 samples/Kconfig | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/samples/Kconfig b/samples/Kconfig
index d19754c..97fabf3 100644
--- a/samples/Kconfig
+++ b/samples/Kconfig
@@ -13,11 +13,11 @@ config SAMPLE_TRACE_EVENTS
 	  This build trace event example modules.
 
 config SAMPLE_TRACE_PRINTK
-        tristate "Build trace_printk module - tests various trace_printk formats"
+	tristate "Build trace_printk module - tests various trace_printk formats"
 	depends on EVENT_TRACING && m
 	help
-	 This builds a module that calls trace_printk() and can be used to
-	 test various trace_printk() calls from a module.
+	  This builds a module that calls trace_printk() and can be used to
+	  test various trace_printk() calls from a module.
 
 config SAMPLE_KOBJECT
 	tristate "Build kobject examples -- loadable modules only"
-- 
1.9.1

