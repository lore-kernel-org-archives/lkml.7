Return-Path: <SRS0=w+Kb=XL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A3F1C49ED7
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 18:13:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3130206A4
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 18:13:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="YwceST0K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730053AbfIPSND (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Sep 2019 14:13:03 -0400
Received: from mail-io1-f50.google.com ([209.85.166.50]:37070 "EHLO
        mail-io1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729750AbfIPSNC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 14:13:02 -0400
Received: by mail-io1-f50.google.com with SMTP id b19so1285552iob.4
        for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2019 11:13:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FCdfvdOk6i1PoT83esv8mw4MKjFjtOqfKz5poFVmLek=;
        b=YwceST0KP0kuGGiavZuwZVI2YGvsxAJeNIpoLigO78+4BkdeHFkbppJCuJVAkY5I9m
         MR0Kx9oNVgvCfR+Kcx/9qKEUvpnxDEdr3Je3yWFS2NQSQU/4cjoU+8HsN6QySbRh1k2A
         rbLoamwkXeT6Zo7+dFCWx2pLTAHrb7NbwBJCk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FCdfvdOk6i1PoT83esv8mw4MKjFjtOqfKz5poFVmLek=;
        b=OdR0hUaVxKjbv4KHlZcgn895HieDW6Q2Tx2Kl7vjhObgK9Z7Pl1JWp682WB480Pru8
         han/Df3hSSadQKFJWMbXzKusbD8Rh7jXS01vFz6XN7MV0sJJ2Q7FoeLEQ+6P675CaGXy
         MSw8KDrrG5tGndcoDg+Hs+HXVESrwTTuWWASqh5aM3B6VpQzmtyanG1E4DQvoIPuuJRh
         fjAHvapyd42cPP5DtUCHHZD7grhsCEA+spmSq7/mSoraMbZW/GS8XlKn7LnWLAKEiLCA
         RroyJxIGUv7G2Qj0ChHrpsAhFxpj2+Oqv7xR5Jbp1iItKpbFSXF+ffNByTVADX6ASgM0
         xZ5A==
X-Gm-Message-State: APjAAAVhQXFiCJ4y1ybTOG5iPA9vzMJtlgALwyDj+NBu0Id3PmRApYyR
        N4yLMT/l9oIDLTyXOsP01nCKcQ==
X-Google-Smtp-Source: APXvYqx0AthyDGP+i6oETR4PDu0mVnx6IZxg7STns05chD4X85djTTMnfuOMorZz7aPKrM2cJIMIcA==
X-Received: by 2002:a6b:8bd8:: with SMTP id n207mr1205205iod.147.1568657581367;
        Mon, 16 Sep 2019 11:13:01 -0700 (PDT)
Received: from ncrews2.bld.corp.google.com ([2620:15c:183:200:cb43:2cd4:65f5:5c84])
        by smtp.gmail.com with ESMTPSA id t9sm10889188iop.86.2019.09.16.11.13.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 16 Sep 2019 11:13:00 -0700 (PDT)
From:   Nick Crews <ncrews@chromium.org>
To:     bleung@chromium.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Alessandro Zummo <a.zummo@towertech.it>
Cc:     enric.balletbo@collabora.com, linux-kernel@vger.kernel.org,
        dlaurie@chromium.org, Nick Crews <ncrews@chromium.org>
Subject: [PATCH v2 2/2] rtc: wilco-ec: Fix license to GPL from GPLv2
Date:   Mon, 16 Sep 2019 12:12:17 -0600
Message-Id: <20190916181215.501-2-ncrews@chromium.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190916181215.501-1-ncrews@chromium.org>
References: <20190916181215.501-1-ncrews@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Nick Crews <ncrews@chromium.org>
---
 drivers/rtc/rtc-wilco-ec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-wilco-ec.c b/drivers/rtc/rtc-wilco-ec.c
index e84faa268caf..951268f5e690 100644
--- a/drivers/rtc/rtc-wilco-ec.c
+++ b/drivers/rtc/rtc-wilco-ec.c
@@ -184,5 +184,5 @@ module_platform_driver(wilco_ec_rtc_driver);
 
 MODULE_ALIAS("platform:rtc-wilco-ec");
 MODULE_AUTHOR("Nick Crews <ncrews@chromium.org>");
-MODULE_LICENSE("GPL v2");
+MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("Wilco EC RTC driver");
-- 
2.21.0

