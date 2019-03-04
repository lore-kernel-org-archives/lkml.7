Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FA16C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 20:19:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CB0C206B6
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 20:19:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726197AbfCDUTq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 15:19:46 -0500
Received: from mout.kundenserver.de ([212.227.17.13]:56693 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726038AbfCDUTq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 15:19:46 -0500
Received: from wuerfel.lan ([109.192.41.194]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.145]) with ESMTPA (Nemesis) id
 1MbAUg-1hXkuF3S0m-00bZFT; Mon, 04 Mar 2019 21:19:35 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     "Enrico Weigelt, metux IT consult" <info@metux.net>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>
Cc:     Linus Walleij <linusw@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-gpio@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] x86: apuv2: remove unused variable
Date:   Mon,  4 Mar 2019 21:19:19 +0100
Message-Id: <20190304201930.1622839-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:pHrE99LD4Az19jjq1RhzvjHdL9Am2S8ct42IpJYIyShcAj8j0iZ
 r2pQv5FzE8vV5r4fegmHgWct+3GHGV4OCkR1xTOJjdLsYJAwIdBJ9A9gLIpEH53x5iEJPE6
 fZ49UGI8JoPJHIsgdFheEIiKCtCpOO1h3M9fgWJMHxSWpHlc0s+JtMQs62RO5miDyOHodw8
 Mf9UG8EKEPKr0Q+6NGTlA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:/pFOLIY+nbA=:4HiDGKoz2TZWstJ0S3n+jX
 FYxCXB+yTQZJJnPg5B/Y1Gfqd6M5QAnysAOOkLV5aOros6IEI1dzrvU50hURojtbG+E0XT/EI
 OduWxBBMLC0WHs7mS/4QQJq/6l694jQknerWAS0b1T3ynXBs9W7Ru1aKg0V2yKi0b46NeAowK
 Rq74CrfU6ANsN2/3F1WvnKwH5SEQo5oMEZ9+8RQY5pEKCjNUPC3+BQN6l/mKY/4nUZF1EYFmu
 1Y9AlGfbfvj6qoUZu7xMasY0B0NbFSHtgOqrAQPtqKRDbhELBsoOudP+NUeCTfgRbYe8ugUKq
 g7LM/AfPPF1/AJZHCzIYjR/XN/8CiJXB/oSoryVGB7j2OVkmqD1ihLOQPjgDnlHqP9JhnKI37
 Psp5LyDgIi0N6p5o5ewjomdUAbAJX5suojcoZLCDUc2Am9Wha/hYgNZT8+BC3TX2fgmuZR2Ii
 tjsbCADH7OajN5OW3HwCvyWOxGWcZx3AxkYMGNfKBLGTzN10Z4eJF86vBmlc76t7KG/KjR6+a
 IvfeZX9jsDZCni5ldktrNVVFhOwtwhf50mmNU4oHpB7Igs0++j92hw+n4WurBXhO2uy1XTFZX
 5/9QnqfMRP3JOb/9IU8eagMu9pgYyyYbIAMCbdXqYIek+21ZkzPX3U2YRVHW1fM6apBbJlYbI
 fdxXR6vPdXX3Lrx0g0hcpSjxbFpCtaXiD5NDPtlen0Y+akZA7g8v9n3zzb1R93Fhn6VWVEugw
 PE8bArLkAdwzmFiCE3TgTFiI/efVxKQSaxymQNMnrpsPlBL41IsbKOp5TEszHDPOBZjUvlWxt
 gJGSIQC6F6VhNL+iTwAknsMZHsdj+U/8G723JqR7ZjDps2qzjnrwhvrvNhccVmtO0x0Lya/y6
 10hiFTdWQCkd2V85iP3x1twJb3WQ8OlajvSw+ifs4L5Qldnn5hARlTbaZtIRNu
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver was newly introduced but the version that got merged
produces a harmless compiler warning:

drivers/platform/x86/pcengines-apuv2.c: In function 'apu_board_init':
drivers/platform/x86/pcengines-apuv2.c:211:6: error: unused variable 'rc' [-Werror=unused-variable]

Remove the evidently useless variable.

Fixes: f8eb0235f659 ("x86: pcengines apuv2 gpio/leds/keys platform driver")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/platform/x86/pcengines-apuv2.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/platform/x86/pcengines-apuv2.c b/drivers/platform/x86/pcengines-apuv2.c
index dcb084f6b892..c1ca931e1fab 100644
--- a/drivers/platform/x86/pcengines-apuv2.c
+++ b/drivers/platform/x86/pcengines-apuv2.c
@@ -208,7 +208,6 @@ static struct platform_device * __init apu_create_pdev(
 
 static int __init apu_board_init(void)
 {
-	int rc;
 	const struct dmi_system_id *id;
 
 	id = dmi_first_match(apu_gpio_dmi_table);
-- 
2.20.0

