Return-Path: <SRS0=Ecng=WJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB63DC433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 06:33:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94C242064A
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 06:33:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726932AbfHMGdN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 02:33:13 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:54895 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725842AbfHMGdM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 02:33:12 -0400
Received: by mail-wm1-f65.google.com with SMTP id p74so394848wme.4
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2019 23:33:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sz3hBlZrKToKuC257EuHXyI7IFd+9vCG5NtLH+UK5dE=;
        b=ncdUri9GYh+Rd72L+an4rJWauXy8o5V6RLSX8R94P2Q1DbdlOrGGqsjEsl/ZpXPuMm
         BLFquhX5hBDhoibbPiTKUkrpzYAg55oIt01wQhx9S9lSSnE5x/d5Y+Ej3pattBy28FKq
         71Upg+mGRmUuGkpdJ+zbrKgmClDF0pifmJ92lLByKNHCqrwEtWOjhmJ/YMl22ablmCRN
         QAAPtHlxS99EYRLKkcI8t+KEackXhpRZ2Lhfrx2I8Epcdq7MLrIAnrfcLnY+IrEGh4mW
         uIcMwJzsqK3bgIwib4EZLWGV2Yv1pXkhAX4QpSWCG9OaKZFvb2JfYa+5oX3g/oXOM+Xk
         Q7Mg==
X-Gm-Message-State: APjAAAUL1Is04Dcdos5V6/qIZoEoXih0sB9xlyLt4ngX4a4HMzQidpw4
        4OhAGwOv/zK0WeqlV+/NYPIaJPH5nlw=
X-Google-Smtp-Source: APXvYqxMgeV+8orhH6cQ52RcH1PBjaI1BCrIQSLyKerSVwcKSkQ3fLMDFSOHumSk0HLOz0nQgV+MIA==
X-Received: by 2002:a1c:9e4b:: with SMTP id h72mr1097686wme.99.1565677990805;
        Mon, 12 Aug 2019 23:33:10 -0700 (PDT)
Received: from localhost.localdomain (broadband-188-32-48-208.ip.moscow.rt.ru. [188.32.48.208])
        by smtp.googlemail.com with ESMTPSA id v124sm488763wmf.23.2019.08.12.23.33.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Aug 2019 23:33:10 -0700 (PDT)
From:   Denis Efremov <efremov@linux.com>
To:     linux-kernel@vger.kernel.org
Cc:     Denis Efremov <efremov@linux.com>, joe@perches.com,
        Boris Brezillon <bbrezillon@kernel.org>,
        Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-arm-kernel@lists.infradead.org
Subject: [RESEND PATCH] MAINTAINERS: Update path to physmap-versatile.c
Date:   Tue, 13 Aug 2019 09:32:51 +0300
Message-Id: <20190813063251.21842-1-efremov@linux.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190813061024.15428-1-efremov@linux.com>
References: <20190813061024.15428-1-efremov@linux.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update MAINTAINERS record to reflect the filename change
from physmap_of_versatile.c to physmap-versatile.c

Cc: Boris Brezillon <bbrezillon@kernel.org>
Cc: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org
Fixes: 6ca15cfa0788 ("mtd: maps: Rename physmap_of_{versatile, gemini} into physmap-{versatile, gemini}")
Signed-off-by: Denis Efremov <efremov@linux.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index d42b478f2673..eeeb4097d5bd 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1221,7 +1221,7 @@ F:	arch/arm/boot/dts/versatile*
 F:	drivers/clk/versatile/
 F:	drivers/i2c/busses/i2c-versatile.c
 F:	drivers/irqchip/irq-versatile-fpga.c
-F:	drivers/mtd/maps/physmap_of_versatile.c
+F:	drivers/mtd/maps/physmap-versatile.c
 F:	drivers/power/reset/arm-versatile-reboot.c
 F:	drivers/soc/versatile/
 
-- 
2.21.0

