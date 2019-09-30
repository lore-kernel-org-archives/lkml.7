Return-Path: <SRS0=rUXN=XZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 915FBC32792
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 20:48:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 620A1224FE
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 20:48:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730553AbfI3Usp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Sep 2019 16:48:45 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:34276 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727469AbfI3Usp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Sep 2019 16:48:45 -0400
Received: by mail-lj1-f195.google.com with SMTP id j19so10994615lja.1
        for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2019 13:48:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2XkmrViXlZTGZ245RYNenq5fBl7sK7iDFb6fGcyt8H0=;
        b=gYECvp4/JGA5s2zAhpm8mbt1T2QCmO3coJjCichiA+D5U9zh6rM8Z/rZW/CfHdFoJ5
         Cre9qRu9jrQGFreRf0bIOFb3BawJWqMEBRuSrjbuTnFo0RMpO+wVhycR9XmShnWmIi5f
         Eo9Z+X7RIeiE/AJsAJz5entbzrOl1BJiXbO6MggCH2CEH2XEem2f0D0ItchcX/C7ocQA
         sqjeDtErfgrHfK9Ykf4BVp79a9kyaAHh9xJqB5OFuAbx0NkgD8sWEmp6Qx4Qhkq7B88T
         C1mRrTpZzELxRMtkil3DIAxuWbTMO5tnQrZUFeTkpOGRaVNFKl7F6ww1hAxhahVyGQWO
         WfOA==
X-Gm-Message-State: APjAAAVz0zuEHOdT9HI4XofN4irHMjZmXzs5pjgs6X8A0Qw1N/vLbcsK
        YLz11JhFk5ZrxkJ0tMhYIkI=
X-Google-Smtp-Source: APXvYqyVqTLQSaSPvYycXHi8oB6poIgqD2MxYFat9MbkEE1gRedCs7BRe3biYAiHFo8Ct2d+SNMPUQ==
X-Received: by 2002:a2e:3e16:: with SMTP id l22mr12787964lja.195.1569876523560;
        Mon, 30 Sep 2019 13:48:43 -0700 (PDT)
Received: from localhost.localdomain (broadband-188-32-48-208.ip.moscow.rt.ru. [188.32.48.208])
        by smtp.googlemail.com with ESMTPSA id h9sm3441171lfp.40.2019.09.30.13.48.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2019 13:48:42 -0700 (PDT)
From:   Denis Efremov <efremov@linux.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Denis Efremov <efremov@linux.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [RESEND v2 PATCH] MAINTAINERS: Update path to physmap-versatile.c
Date:   Mon, 30 Sep 2019 23:48:15 +0300
Message-Id: <20190930204815.16635-1-efremov@linux.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190813061024.15428-1-efremov@linux.com>
References: <20190813061024.15428-1-efremov@linux.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update MAINTAINERS record to reflect the filename change from
physmap_of_versatile.c to physmap-versatile.c in commit 6ca15cfa0788
("mtd: maps: Rename physmap_of_{versatile, gemini} into physmap-{versatile, gemini}").

Cc: Boris Brezillon <bbrezillon@kernel.org>
Cc: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Denis Efremov <efremov@linux.com>
---
Ping.

 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 296de2b51c83..dc7137a9cf77 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1238,7 +1238,7 @@ F:	arch/arm/boot/dts/versatile*
 F:	drivers/clk/versatile/
 F:	drivers/i2c/busses/i2c-versatile.c
 F:	drivers/irqchip/irq-versatile-fpga.c
-F:	drivers/mtd/maps/physmap_of_versatile.c
+F:	drivers/mtd/maps/physmap-versatile.c
 F:	drivers/power/reset/arm-versatile-reboot.c
 F:	drivers/soc/versatile/
 
-- 
2.21.0

