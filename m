Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E192FC10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 19:58:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADB5A2073F
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 19:58:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730507AbfDPT6L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 15:58:11 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:41715 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728466AbfDPT5m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 15:57:42 -0400
Received: from orion.localdomain ([95.117.99.70]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MGi2e-1h2gQI17sA-00DqED; Tue, 16 Apr 2019 21:57:40 +0200
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     linux-kernel@vger.kernel.org
Cc:     dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
Subject: [PATCH 1/4] mod_devicetable: helper macro for declaring oftree module device table
Date:   Tue, 16 Apr 2019 21:57:22 +0200
Message-Id: <1555444645-15156-2-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1555444645-15156-1-git-send-email-info@metux.net>
References: <1555444645-15156-1-git-send-email-info@metux.net>
X-Provags-ID: V03:K1:io3EYpJ0TfMSSqJWuFwvkyuTFFZlJeJGmW+bxf4rexSPfQx2v1a
 ZIdnP+Sdpw3eCqPAvVd2rzMDsO1EddsJ4bktRd90EoXYrQ9JuLhwm9v9RenFNPrWVtKLxJU
 SU8XKp4VjC70eyNfxchQzjjAD+IJ4fAuVaQOq/viEAcg3oQY0rauTtoAgTy3o3UO+tfipGg
 MgCvKjmnaOaVH+608mlGg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:pX2eMN7rHxk=:BkabbqOjBmh94xnVq/lsRX
 qVIZib+LdXlyok9G/tyFCZaAOdrTkWYaUqqslfxGJWg9fv44F/Pt3AToK2nmK52a1Mjo/am8I
 3bn4+o42yHJTSg6r0zodGj9I8yrFRwjhZ4Wvw8RrdpZdfncbCK0+d3jth0Vh5OSppe+Hn7aE2
 ECYYOqcCeTLnXpDRCg6pfwmBpYk0tkGf+JJeloQ5N1kj25jmzT/IFykm/82UxmVECcjaWItjz
 r55b/3GPvDb8Sw0e4DCa7rmgpOM+UyP92ZtFsWm3j9CUf+ryCPjo7/hUWL2AyamjvD8bKUBTA
 hPQh0w3+xPEZQWHuZmHH8mba6Bpg7ssc5l84KBqedqWp+L6HJxZ8woZEnEVW3IqOOAi2b9wDH
 7bHEZGNVSIa1274vrGnim+R5nBsLpluo78c++qV/q1WjATg7R8HbvNn4Dmf3/eoR58hMO3bbQ
 D6GUrXmSdMfq8Q7PX5Nh9sQBH9UGbuLy7zjJ7piodtoWphM4hheQD0ERnsDRyRkcTkClTKbdQ
 0zQ8zjxg4fsBnmITbR0jGBx+3p6gvBByT4iE79Cv+xphfFJK6YMp45kOfhAtAfaavySk3hp4F
 U0U4hHuKOw25TmdHFFwhRCjO+Bz+1miSDjsjtQO8zw47mxDF790xEIQ8NlnuZ1esgdYXgfJGi
 IW7V2YBpkZP9xZEph9yhAUb1mDVuxm00SOuvrQe3+cA1ElN6N3QGZphY8ZQNGDMR16j9yPUhS
 JCm/jH/VYXsR0oEgb0FGwS4vSSTcthIBkozr1g==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Little helper macro that declares an oftree module device table,
if CONFIG_OF is enabled. Otherwise it's just noop.

This is also helpful if some drivers can be built w/ or w/o
oftree support.

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 include/linux/mod_devicetable.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/include/linux/mod_devicetable.h b/include/linux/mod_devicetable.h
index 448621c..853e301 100644
--- a/include/linux/mod_devicetable.h
+++ b/include/linux/mod_devicetable.h
@@ -245,6 +245,15 @@ struct of_device_id {
 	const void *data;
 };
 
+/*
+ * macro for adding the of module device table only if CONFIG_OF enabled
+ */
+#ifdef CONFIG_OF
+#define MODULE_DEVICE_TABLE_OF(name)	MODULE_DEVICE_TABLE(of,name)
+#else
+#define MODULE_DEVICE_TABLE_OF(name)
+#endif /* CONFIG_OF */
+
 /* VIO */
 struct vio_device_id {
 	char type[32];
-- 
1.9.1

