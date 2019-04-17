Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8229AC282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 09:47:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49BB82173C
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 09:47:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555494462;
	bh=t3CcOt2HDuc1gQ9AGA3HEhB+D7deMg2dE500Ev/kWPM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=yCPiNqAYgP8tgCUgdfgoaLPgQDxAkZK6d9VK85rq6Qs1b/vLJTNFbAAssgNOGfvrV
	 Wk2BGFZvhQTfFjhXqZ+3aMgkefy8DkktUg2Uor2Mqb6TXx1B240Iha8wU3tiKvDnnE
	 7kaxVLQOHk4JQXb3/INB0xaVMT/DM5Lcz0YcEVP4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731877AbfDQJrk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 05:47:40 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:44982 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731633AbfDQJqj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 05:46:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=9LalUJPmuPDaMfLRWCl1lzBZDSX3p4v9Ob+a/oKrM1M=; b=kUr4Vp3hsaiwCMmYlm++/7B9Lr
        29ZVXEQ2bn8jMe0gSw2Qnc3cDTf0nWkepLzMpW4vb9YHVNQyqm4bln9nAR7YKRTHZD5vD9Adey4y1
        xPbAbX95rglQgbUuWCf0bEfZFn3jACUHRaigO7Yme5kgcLv2cnnxCqo33d/Gzatpr5nrw2C61mwHQ
        ED5rLFHiQaV+aSb1NAlVo/VmAnNbjaCnyzTYYU/4HRpYHkOgEQKlJGT8z2ZwLNpI+yzdPfvEut48h
        eSD3DSu32UCsHvKjJTkHcLI8kDhe39ih8SbcYEgMATeGudyv+SEbaWFquMht2UtLsMmia2fWu/ZF4
        H7nJ2oIA==;
Received: from 177.132.233.55.dynamic.adsl.gvt.net.br ([177.132.233.55] helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hGh9K-0000aJ-9x; Wed, 17 Apr 2019 09:46:38 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hGh9D-0003vF-59; Wed, 17 Apr 2019 06:46:31 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>, linux-hwmon@vger.kernel.org
Subject: [PATCH v3 15/21] docs: hwmon: wm831x, wm8350: convert to ReST format
Date:   Wed, 17 Apr 2019 06:46:23 -0300
Message-Id: <05f285eae86db4c6ea1d8c48f7cca1618de4a3f3.1555494108.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1555494108.git.mchehab+samsung@kernel.org>
References: <cover.1555494108.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert wm831x and wm8350 to ReST format, in order to allow
them to be parsed by Sphinx.

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 Documentation/hwmon/wm831x |  9 ++++++---
 Documentation/hwmon/wm8350 | 10 +++++++---
 2 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/Documentation/hwmon/wm831x b/Documentation/hwmon/wm831x
index 11446757c8c8..c56fb35a2fb3 100644
--- a/Documentation/hwmon/wm831x
+++ b/Documentation/hwmon/wm831x
@@ -3,11 +3,14 @@ Kernel driver wm831x-hwmon
 
 Supported chips:
   * Wolfson Microelectronics WM831x PMICs
+
     Prefix: 'wm831x'
+
     Datasheet:
-	http://www.wolfsonmicro.com/products/WM8310
-	http://www.wolfsonmicro.com/products/WM8311
-	http://www.wolfsonmicro.com/products/WM8312
+
+	- http://www.wolfsonmicro.com/products/WM8310
+	- http://www.wolfsonmicro.com/products/WM8311
+	- http://www.wolfsonmicro.com/products/WM8312
 
 Authors: Mark Brown <broonie@opensource.wolfsonmicro.com>
 
diff --git a/Documentation/hwmon/wm8350 b/Documentation/hwmon/wm8350
index 98f923bd2e92..cec044ca5900 100644
--- a/Documentation/hwmon/wm8350
+++ b/Documentation/hwmon/wm8350
@@ -2,12 +2,16 @@ Kernel driver wm8350-hwmon
 ==========================
 
 Supported chips:
+
   * Wolfson Microelectronics WM835x PMICs
+
     Prefix: 'wm8350'
+
     Datasheet:
-	http://www.wolfsonmicro.com/products/WM8350
-	http://www.wolfsonmicro.com/products/WM8351
-	http://www.wolfsonmicro.com/products/WM8352
+
+	- http://www.wolfsonmicro.com/products/WM8350
+	- http://www.wolfsonmicro.com/products/WM8351
+	- http://www.wolfsonmicro.com/products/WM8352
 
 Authors: Mark Brown <broonie@opensource.wolfsonmicro.com>
 
-- 
2.20.1

