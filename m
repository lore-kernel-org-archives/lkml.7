Return-Path: <SRS0=TpO6=UA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8650C28CC5
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Jun 2019 14:02:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8ED724C3B
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Jun 2019 14:02:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726720AbfFAOCa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Jun 2019 10:02:30 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:39123 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726013AbfFAOCa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Jun 2019 10:02:30 -0400
Received: from orion.localdomain ([95.114.112.19]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MRTIx-1hCWtS1bmf-00NOdl; Sat, 01 Jun 2019 16:01:47 +0200
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     linux-kernel@vger.kernel.org
Cc:     rjw@rjwysocki.net, viresh.kumar@linaro.org, jdelvare@suse.com,
        linux@roeck-us.net, khalid@gonehiking.org, jejb@linux.ibm.com,
        martin.petersen@oracle.com, aacraid@microsemi.com,
        linux-pm@vger.kernel.org, linux-hwmon@vger.kernel.org,
        linux-scsi@vger.kernel.org
Subject: [PATCH 3/3] drivers: hwmon: i5k_amb: remove unnecessary #ifdef MODULE
Date:   Sat,  1 Jun 2019 16:01:40 +0200
Message-Id: <1559397700-15585-4-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1559397700-15585-1-git-send-email-info@metux.net>
References: <1559397700-15585-1-git-send-email-info@metux.net>
X-Provags-ID: V03:K1:Uf07aEan7IAl+nMPJVoauPGY3tAx+SpH5WZIUWYrVAiwM4ruUrl
 1j5M4Bv/Eq/zrLWd7J4UhOJT+teoWZyQ+eAnr+3sfAzfq1nHyqkH4en3lfiFGUjY4gk/vzu
 nYFbaOW1BbKDMIcfeC2exMzSwNwZJAJ6e6WzFCyDZlvnAkBDCjeZcQLQ/6UHzshutYcoayi
 Q8o2upcrzAXRJiD+AJgmw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:l8x9QWxf8zs=:xd+EqbnZ2qTUJdaZquAU5U
 t8kfaqegmGmPvFY+r/WDW3k7SFwqj+q1Iuhvfrflz116yYuSqkc2EtvrBS/UQJU3YaO6cShFh
 O5fUeNvLMYpOO8YgBUntUE4XfDPxyuqlz9VWEyTIXsmBqvnLsiqBofSQtjvrCP5RaNSpiCjyJ
 EgrNflZzNB/98p+ys/dIStdu4yFrR1/naeMzlCFnS9wiVgYKqNz8tnf3JnlUs4aiFmLgVe/nT
 AzjeRsuBCtoBoFmHX8DCnw3i1bVx72vDpnwjzgY4FNxqzhMnMvm5HfteKmAxcSM0DN9cQ3Ns7
 dQaGXhqCkot/mOPYrC8UmoiSzqnswF4kWd2ad9InMvpw5IAleEV1RZCvoLlkJk1E8QhSMnFr9
 4rjio+sx8BV1a0tBv6MmBGdb9cysjfpPNUJeBcepKN/7JGbql85PHNQ5bN3N8s+SX6/HWfsZu
 iahc1Et8ff8fE6ko7bKhuHMuRE+M5BDHbofgseni67mLuD1ymMED3+WVUZj43g09KLBZ7dQvX
 oSyp/on4QsqiUXMAOVivpnufHnH/i7iq2SwaghNjhQoUL9i8g3XydQkPph9N/tqpfZeMApkK2
 gWnmEJbQsrZS6GEw1rkqYSen1iWlqczHt3fIiSlh3yceylDmTXR2LY7GUMajCrbRa2zrSc0oH
 4UFhSUaWrzY5F24KmE9tAzhFFePnblgMly7uf/1ZJal1/cnOpTZ7TMBzVv/JNBMO+vB49NmSR
 ZNoZV433PfwMe1y34tR58ipgoJMFp2rFJmI6xA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The MODULE_DEVICE_TABLE() macro already checks for MODULE defined,
so the extra check here is not necessary.

Signed-off-by: Enrico Weigelt <info@metux.net>
---
 drivers/hwmon/i5k_amb.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/hwmon/i5k_amb.c b/drivers/hwmon/i5k_amb.c
index b09c39a..b674c2f 100644
--- a/drivers/hwmon/i5k_amb.c
+++ b/drivers/hwmon/i5k_amb.c
@@ -482,14 +482,12 @@ static int i5k_channel_probe(u16 *amb_present, unsigned long dev_id)
 	{ 0, 0 }
 };
 
-#ifdef MODULE
 static const struct pci_device_id i5k_amb_ids[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_5000_ERR) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_5400_ERR) },
 	{ 0, }
 };
 MODULE_DEVICE_TABLE(pci, i5k_amb_ids);
-#endif
 
 static int i5k_amb_probe(struct platform_device *pdev)
 {
-- 
1.9.1

