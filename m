Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D6CCC33CA2
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 13:49:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E05EA206DB
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 13:49:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727950AbgAHNto (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 08:49:44 -0500
Received: from mout.kundenserver.de ([212.227.126.133]:54747 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727158AbgAHNto (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 08:49:44 -0500
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MUGmJ-1jFpMw3wu3-00RIIe; Wed, 08 Jan 2020 14:49:38 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Jyri Sarha <jsarha@ti.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] [v2] of: add more dummy helper functions
Date:   Wed,  8 Jan 2020 14:49:28 +0100
Message-Id: <20200108134936.3617013-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:JQOAbVK0LWH8+kGq3OdUd50ufs2YEZV3baqlPgyjnJ1EKClaWfd
 3RQXwmRqR6iIRfGAw0SJ6ykQeTSDGMKgHSCbCWFQmagnm4q8JsA4OZv2kn6aO/2YbFoOexC
 a0EbrrHdfgzLnQ7iOLnvVORt0r2SlDlgWGY5Hk2Jyx/wHu7LKeT53tI+XkSjtiMeoR/DuIC
 TcX6eu2WCN17t6VfERARw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:2pHzSasBQPo=:KLVRXx6QyUgV/cEWTC5tkr
 /QQavo2hzouhq7JHsZQS9eVUwqmQ8ifQwgwycTIC9ask6pVnFnkRXCfuIVhXHSSbnoTsFe3+3
 jZww/noej6zIfZ2qurhMV2XaIe8gwcGRwg5MOKx5YvoUbTTAyQS6w7URRm3NINnydKDOelVh0
 KhssziFYqRk0q+k1SUh+So2ZPKnQBrG/HZuW6pC5ySkdNyNs/MZRSgT1BPYi7QmiKZZQwtQFT
 k3/2RIwWI4Ya2+vbsK3DOCeyAGreJrMvIlbHT6WnTyVY7IT+zer/LmOrRwxFz3bY8/0/qLtLB
 mwlRsPOIpe/l2OHnxlc+zW9fIGPA5w3q2TsbbvGpaxJkSNRy0g4T15kgsrWPq0QYOPfIA8xrv
 tBJYisaY1J83fk+spOaoAqJYM4C/jKcPl5/IbK0qqeHOcJhzsrKEC4ZPE3H0WN6ogWH/tKgt7
 LdYwNIkYBSdJ+upWFTJbYxxU46mSkzm1DIT1FunawjyOSdoO6X/j32/HdhubicCRvKPaz75Ni
 4HTX/XbhVm3SjlcBOVf/RVY9maywbgOJcY9QzSAltGPWvjOkw2iA93Sym2R0k3d9umC5KGbFF
 3uvSjFD5m6FUPLi6frVfZSrdm8TSb3lNsEEs6WCyu5n6Q8Zx9See4yEv127ki/G6npw1cz67s
 aQmenEh+CUaj6eZh5Q6+WwjEnLlUoa6ejO6k9+dqVwsmZlXGO2SKwX0V2x4rxDQRASRZFNr5y
 CF+GYclP67xC4CxoEYk+P6LQQqDlWXZHnV56TDMv83UCeijBgoUkbgT6qr6X3PMU2cDfAqL/q
 8L7JtdN+u9EWyJPelSangHh88Pw2FI1UY8wCMbACpijNVF9l2xqYYCd5Z0uqKaqrsEv0aKF/d
 bdmh3RFFZmZUSA4cFL8Q==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The new phy-j721e-wiz driver causes a link failure without CONFIG_OF:

drivers/phy/ti/phy-j721e-wiz.o: In function `wiz_remove':
phy-j721e-wiz.c:(.text+0x40): undefined reference to `of_platform_device_destroy'

Add a dummy version of of_platform_device_destroy to avoid having to add
Kconfig dependencies for the driver. As there are a few other functions
without dummy implementations, add those as well for completeness.

Fixes: 42440de5438a ("phy: ti: j721e-wiz: Add support for WIZ module present in TI J721E SoC")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 include/linux/of_platform.h | 39 ++++++++++++++++++++++++++++---------
 1 file changed, 30 insertions(+), 9 deletions(-)

diff --git a/include/linux/of_platform.h b/include/linux/of_platform.h
index 84a966623e78..f5dea3de4856 100644
--- a/include/linux/of_platform.h
+++ b/include/linux/of_platform.h
@@ -48,28 +48,49 @@ struct of_dev_auxdata {
 
 extern const struct of_device_id of_default_bus_match_table[];
 
+#ifdef CONFIG_OF
 /* Platform drivers register/unregister */
 extern struct platform_device *of_device_alloc(struct device_node *np,
 					 const char *bus_id,
 					 struct device *parent);
-#ifdef CONFIG_OF
 extern struct platform_device *of_find_device_by_node(struct device_node *np);
-#else
-static inline struct platform_device *of_find_device_by_node(struct device_node *np)
-{
-	return NULL;
-}
-#endif
-
 /* Platform devices and busses creation */
 extern struct platform_device *of_platform_device_create(struct device_node *np,
 						   const char *bus_id,
 						   struct device *parent);
-
 extern int of_platform_device_destroy(struct device *dev, void *data);
 extern int of_platform_bus_probe(struct device_node *root,
 				 const struct of_device_id *matches,
 				 struct device *parent);
+#else
+static inline struct platform_device *of_device_alloc(struct device_node *np,
+						      const char *bus_id,
+						      struct device *parent)
+{
+	return NULL;
+}
+static inline struct platform_device *of_find_device_by_node(struct device_node *np)
+{
+	return NULL;
+}
+static inline struct platform_device *of_platform_device_create(struct device_node *np,
+								const char *bus_id,
+								struct device *parent)
+{
+	return NULL;
+}
+static inline int of_platform_device_destroy(struct device *dev, void *data)
+{
+	return 0;
+}
+static inline int of_platform_bus_probe(struct device_node *root,
+					const struct of_device_id *matches,
+					struct device *parent)
+{
+	return -ENODEV;
+}
+#endif
+
 #ifdef CONFIG_OF_ADDRESS
 extern int of_platform_populate(struct device_node *root,
 				const struct of_device_id *matches,
-- 
2.20.0

