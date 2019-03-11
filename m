Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49A0EC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 13:23:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2383E20657
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 13:23:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727966AbfCKNWw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 09:22:52 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:60377 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727668AbfCKNTm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 09:19:42 -0400
Received: from orion.localdomain ([95.115.159.19]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1N3sZy-1guZPp1r8a-00zprH for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019
 14:19:41 +0100
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     linux-kernel@vger.kernel.org
Subject: [PATCH 104/114] drivers: edac: Kconfig: pedantic formatting
Date:   Mon, 11 Mar 2019 14:18:56 +0100
Message-Id: <1552310346-7629-105-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1552310346-7629-1-git-send-email-info@metux.net>
References: <1552310346-7629-1-git-send-email-info@metux.net>
X-Provags-ID: V03:K1:eAdfjsPos204lLeUubCFFiVziCL7qNVJElvLHaadZ/WoS/j0Jfr
 Pu1Cx03jEp52SlUB2NG30S8UXx+tMIbF9PqtHSD0QxV3SW5SeQXHZ2enXYrmbTCggDP2vsr
 5PnPfA2gj0YvgTJTgxbFTr9YSckTjmG5YJqZFwfQk3uvSsAxA9iAu5b8x9uX2ZYHL+WqMKZ
 PUFXGeWyXbDQG60ednSAA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:9xQEp5mXZzg=:aimWbwUUCgLDD0Q4h+SI28
 /03PHX94/zQ9a9fIoGAtxp95zyBLnp9eJPFxPwmi+s+W+d2+HXZeA2TvDF8t8Z6PzeOHVl2lG
 2RvDg+59yeajmeFrcjAU//EF7M9PO+DqigeQ8WBiIqQf3wknSIyQYfYg6ooNMg/hA6GcJH2aa
 rVF0oQEozl+2lbIyA4K1Qif96As29yFl9bnJ0GMSc0idBDLC0N87N1LTNnvgC+cG5WTzDDPa6
 DRNWoUpgGeA1bJGIuen6EAAg3B3+Wtifm+rDaD5G73YfEmtMWfYYcSWelUHcFOGV4SzRAju0e
 gqqQnOtdHbDFsegiQ5qPXd9f+QHZQr/MdjP2jZiBnSD8gY1AXc3Quz543Kk1e5n5Bg/IArm3S
 8YY7xpWktdKf43fwKMyD+4LlGkBIVUmVa0AY0TRDDUm/us1BodSetVKQwMfmqz0jXMfsAFyY2
 7GWXpbwUhcriY+t5Sl+/fQfKxRNsAYIL2aQbDcQ7+Yulk/XSCjk0oSkAzZydcN5+O0NV+B0ed
 EIPhFdhN3QrTK4WTB5doR2Rqj58FHQx5c4miev+uMHCVdvr2d/rriHZJ058fapgdxs3HTmqGv
 9KW5pTAwYgdKsrw7e+6jSu2rHpggs74YJw3U3xjSjdasufgHuZaPBsJRj36gZVkfD5lppOGs+
 EeMBtj5xk3XWuZCELEvgU8sC2pyTvq4K6SysfuQofoK1hncMMRtqKPAC9/rFZkyQNW0nE9+8z
 pEq1nwoQNEzvQ1sXzys+kWQdqOlmy6IUUZtIag==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Formatting of Kconfig files doesn't look so pretty, so let the
Great White Handkerchief come around and clean it up.

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 drivers/edac/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/edac/Kconfig b/drivers/edac/Kconfig
index 47eb4d1..a299da4 100644
--- a/drivers/edac/Kconfig
+++ b/drivers/edac/Kconfig
@@ -479,7 +479,7 @@ config EDAC_TI
 	depends on ARCH_KEYSTONE || SOC_DRA7XX
 	help
 	  Support for error detection and correction on the
-          TI SoCs.
+	  TI SoCs.
 
 config EDAC_QCOM
 	tristate "QCOM EDAC Controller"
-- 
1.9.1

