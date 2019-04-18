Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A78CC10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 09:50:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BF9420821
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 09:50:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555581031;
	bh=OgKW8Le/Vcu7HoszvC/fZ/RFhMMoXtzV+ROuH4yjlM8=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=FCnxmvEkH2abfrtUGW1uWM6mfsPHimd0AdxEqT5zMcyuL+6zRTFUzZmOIWE5uVt6h
	 mDPQFUrL7e7rxjZnqpqmYPGjBUCN81ILAcqlQmHZz9YIXC3r7nfyYuC7WDE/AuXBWs
	 RMvQps9SVQs2l9/oTM+HvXY/KaBrXqqx4hbiZsX4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388516AbfDRJua (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 05:50:30 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:34494 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733049AbfDRJu3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 05:50:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=0m721at5cwMfiWxrdIYV8i/+vD6LBjTJalnje+Q//hI=; b=KOhJ74iejdPdvbwOawaXKNSSZ
        hYY+fa/jyT3efq5bRa0PJxsnfFf3ljNJDRbwUHBVaJdhKdFvjNJ2cN4PYUy6pM+iPW3pHvwxDcAcw
        Gf3je9ttAH2YswmxYpovcgz0XcbQ/r4iMbRDbf1uq38twr4VFj5CXLORl6QVRSx8LX1r/WiBbrlmG
        TSu8dI9MVfj5StvKZGsom3H48CaBoBPdDfpiKnHOtOGbYXN0ZHPS0zc14kaClnJFg05nrAB4nbCZN
        sXs2wTtbs8nppi9ZoLV4CVglhL0BcD5zQzxIQW9efk6N7sydPnSEkjfNv6fO/tjtqxjlzGlqDSqDy
        hf+APruQw==;
Received: from 177.132.233.55.dynamic.adsl.gvt.net.br ([177.132.233.55] helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hH3ga-0003X2-PQ; Thu, 18 Apr 2019 09:50:28 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hH3gW-0007kz-Fu; Thu, 18 Apr 2019 06:50:24 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Ray Jui <rjui@broadcom.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Marcos Paulo de Souza <marcos.souza.org@gmail.com>
Subject: [PATCH] docs: core-api: fix broken references for div64.c and gcd.c
Date:   Thu, 18 Apr 2019 06:50:18 -0300
Message-Id: <734f49bae5d4052b3c25691dfefad59bea2e5843.1555580999.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Those files were moved to lib/math.

Fixes: 9635bad21596 ("lib: Move mathematic helpers to separate folder")
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 Documentation/core-api/kernel-api.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/core-api/kernel-api.rst b/Documentation/core-api/kernel-api.rst
index 71f5d2fe39b7..a29c99d13331 100644
--- a/Documentation/core-api/kernel-api.rst
+++ b/Documentation/core-api/kernel-api.rst
@@ -147,10 +147,10 @@ Division Functions
 .. kernel-doc:: include/linux/math64.h
    :internal:
 
-.. kernel-doc:: lib/div64.c
+.. kernel-doc:: lib/math/div64.c
    :functions: div_s64_rem div64_u64_rem div64_u64 div64_s64
 
-.. kernel-doc:: lib/gcd.c
+.. kernel-doc:: lib/math/gcd.c
    :export:
 
 UUID/GUID
-- 
2.20.1

