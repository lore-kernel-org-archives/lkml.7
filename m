Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6D4AC43219
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 14:16:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C12F5206C1
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 14:16:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726475AbfDZOQ0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 10:16:26 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:36303 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726138AbfDZOQ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 10:16:26 -0400
Received: from orion.localdomain ([95.117.100.117]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MdNwm-1gkxse3wuW-00ZRXc; Fri, 26 Apr 2019 16:16:25 +0200
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     linux-kernel@vger.kernel.org
Cc:     devicetree@vger.kernel.org
Subject: [PATCH v2] mod_devicetable: helper macro for declaring oftree module device table
Date:   Fri, 26 Apr 2019 16:16:23 +0200
Message-Id: <1556288183-5782-1-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1556104081-16217-1-git-send-email-info@metux.net>
References: <1556104081-16217-1-git-send-email-info@metux.net>
X-Provags-ID: V03:K1:VXbLcvMuAOqTTZzEnbwD5yL/8RUrBdUNDwzoEry+5maS8eaT0FC
 ceSzjFovrgtnNZaiwFPrv32rdsNbZD/HYJ8+oWBwZ5Ny3y2QcM92XcRmDeQTAGNS6JU/lEK
 PjgU4UdWNB4f27457jF54Okm7y4d4LoZsIAaxn9Jzzb5g6DEKYpWQhIyHCHHsXG0Ug/pYlN
 P17gml8sXCVgTOzoXnFUg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:nwfzftOqN0A=:ogYbeblqrWvqS6Qkodk14f
 z2TI8d5A5gkbrkr1xZiiRX4MCtaoRjeYcvmXHgZDZhIxUiS4R7ByCUJKfM8Bb62pBCwYtBG3A
 SF8pHKa7g+J5kiUxE2EN5O33vqRHoFtuTne8mTMS8MPvztSeGyX0zYV3/SXcuPFCTCVuu6vEr
 dh2/OpfjiTG3TYEQjK+1V+iq4mMFRv/oxMybn7TM6+IglBLexGBqQLeez0uWtbou7IHNhwJEl
 XQI5fX6axvNOGdMju8BSxStkS2F/W7EgH4rqONF+LZPTN7gzQ11EVNW8pEvGtJZDaK6KZ9IDR
 BihVGZcE0OF0jTGNU1cVLayGqtfFvZ77X9oTLp5+o9JhwpRlnGUeVRae8sK8jUCF/3M30rswV
 kuhxX7OiJURv+76gEb3hp4D1xpcs+aGu7C8fTU9SpYCWt9pwi04ynsPvHnVzcYO8DDFdKVXBd
 TO+saHBrBFpLXwNEOfcfj4Y9eTaFWh73RdN+pH3YP4nckQA9DGl1vvOzY9oRkv+kx0AHSnzgw
 9nzJ1PDCGmPtz4ddScKBKxCL8dQiwNON3yBUji4Xgu9p8RIENNZ2QEIN2gHzapv/g+OV/g45Y
 yPLBolSRuMO3k8dxbD/6rKyptCrbwV8Lc0ukGYOeyKDG6zpQm6ctuYrHqwoxuxYqnHGLP9+Za
 JJ0ctn5bQPbNps0PLT3KG3coma6eCgr8kDsaz6ldXvUnklgmiv6fHUgxGhn7uGbZnomG4XlHF
 gFGw1oFAUzMWW3JkVwa1KT9Nv8ZXn+jv9v5Z4Q==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Little helper macro that declares an oftree module device table,
if CONFIG_OF is enabled. Otherwise it's just noop.

This is also helpful if some drivers can be built w/ or w/o
oftree support.

Signed-off-by: Enrico Weigelt <info@metux.net>
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

