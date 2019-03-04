Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54349C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 20:26:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A23320835
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 20:26:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726526AbfCDU0U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 15:26:20 -0500
Received: from mout.kundenserver.de ([212.227.126.130]:59695 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726061AbfCDU0U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 15:26:20 -0500
Received: from wuerfel.lan ([109.192.41.194]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MJEAV-1ghRTL1Q3n-00KhNF; Mon, 04 Mar 2019 21:26:12 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     Jassi Brar <jassisinghbrar@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Bartosz Golaszewski <brgl@bgdev.pl>,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: [PATCH] mailbox: tegra-hsp: mark suspend function as __maybe_unused
Date:   Mon,  4 Mar 2019 21:26:05 +0100
Message-Id: <20190304202610.1759671-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:RvWNmDXWOSkxMV+U8nZn/XR9PieO0qCcM8OS+2wjV87Py96sfCy
 SGPKmoIq2uiOnhDV2qFg4XBteygDm7zUsmE7n5IzRrt+nRMgX1StGpap1cR0AvHN4n6lzCo
 BrZtT3rGElxMsyYhOVW0sk80lN0cIbbJG0KlfIMh4k0CINB9WPP6rmF7xJHQ6wCKomP3AZY
 NLFlt/NvOjpYBsA+EJMgA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:MwQJbPgGxkk=:hoHinUKBp+fWWVvpB+c/q7
 PS0u7e/ByQOoyH/knJDVBDQkC9v8suNi2myoQWrtucEiYxEyJwPL5fmZM2W8O5FYza7VZMnaT
 Q9/O/E45yggCtP7eNh2ojVCh87IHTuaeLdCAWXAHoyglI4BfFLe2KBWMFHdGTbuoC161HSHNX
 ode93YyRn2cIhkerO2LmJlS7+VbUAXR/pEcdDtekq8bnmghPoe74ihwSTXFZi/vdHM6h/1kBD
 AdnRWcoVyJWtlhghXUN211fqfs8r422NMUvcUxbI7khFp6TuQQ1nZtU7IJk/F0clgDzTAxgj4
 PmzQuAyIcYSiD33ciQVbyXlNsJsrXvS9yT7D/0Gj6hKMjNV1P275A/xucWYocUjN5EvwKtjpK
 jZDz1PmREhN1RrYlcZ9bnmLhX+WzC9dKWdYBjMvetJhakX7ddp46RapzpvigWwmggO7V40oob
 rshJHlNkiEO3xqt5Arm/B28HLxuGJvArslGpd6MP1xTaVApYi1Gh90NVcss9CITbe4lFc8TaQ
 MYQwCgskPWi8nigJXyw8D7Q9ODPVolnisk14QkAyt+bInidt4UvGIuMsP36rZh415xXb+A7S/
 S2JGgc/OVShvamttGv9KpgPx+6445PIR8uuAdpmSji+W4icV+Ukd6j9HjTysJE11a2aqDcMm/
 Eip7sK5Vk3TyTmWxSMi35egFyH7oGNTUdlPA8H7cxtZe7uqiUmGUKBLkrx/tTXsuKSaMAeWts
 McalO4te8Y8V869ixxpjhAZyzvvt5L/O8gyD2g==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We get a warning about this being unused when CONFIG_PM is disabled:

drivers/mailbox/tegra-hsp.c:782:12: error: 'tegra_hsp_resume' defined but not used [-Werror=unused-function]

Fixes: 9a63f0f40599 ("mailbox: tegra-hsp: Add suspend/resume support")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/mailbox/tegra-hsp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mailbox/tegra-hsp.c b/drivers/mailbox/tegra-hsp.c
index e443f6a2ec4b..11fc9fd6a94a 100644
--- a/drivers/mailbox/tegra-hsp.c
+++ b/drivers/mailbox/tegra-hsp.c
@@ -779,7 +779,7 @@ static int tegra_hsp_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int tegra_hsp_resume(struct device *dev)
+static int __maybe_unused tegra_hsp_resume(struct device *dev)
 {
 	struct tegra_hsp *hsp = dev_get_drvdata(dev);
 	unsigned int i;
-- 
2.20.0

