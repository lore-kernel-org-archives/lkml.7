Return-Path: <SRS0=Ecng=WJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B1BFC433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 06:10:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDF3020679
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 06:10:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727501AbfHMGKc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 02:10:32 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42161 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727129AbfHMGKc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 02:10:32 -0400
Received: by mail-wr1-f68.google.com with SMTP id b16so9899480wrq.9
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2019 23:10:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xQwc5rOjRj0zqrA+kmrUX2ciCtQC7Q6M4jUOyWVoK0g=;
        b=VTZM/1PkcDVjAiJ0zfosrFEPVRGysDkElGC19enkBazGQz/dyPhE6Dqtq95kdiXIqL
         +BGFzEpSfmtzolEtu9S4NZxX7Y7e5TD2sy/Gb/GEHJf0EMVWi3894M6QU0LPCBP7PW9Q
         T6xVFZInqB/kFqwfRvtI3n8wTk3qjC9wQRW4QJ4Jgk95ao9rLVhEYZKSTvQgOz6oLH1q
         M7YcbknqrmtxJZip4XnbihFaxjOCNmVARyj3ZmjCuFYYgk63LQ/RtjPuy4EiQwecUEtq
         4JpxVnludTYtAdrEK6NOHTFWA/y+nJTaFJNfcXu0OWUPS6T/hb8/yHZkoi0vadN62N0e
         vdtQ==
X-Gm-Message-State: APjAAAUuuM3KbWLqq9yRxDaByeLJAfI2UtKrSgPwFo5py7iqJszpaAqB
        W3rpF3BrORKgGjOpBnUhjRwpdE/D1IQ=
X-Google-Smtp-Source: APXvYqxtR1m030aNYymrabBRKfn+m8SOnZrXYimQUbsFw19W+YG+lCLztJnfiz4CnxFa/6iyGa+bVw==
X-Received: by 2002:a5d:69c8:: with SMTP id s8mr15559671wrw.353.1565676630260;
        Mon, 12 Aug 2019 23:10:30 -0700 (PDT)
Received: from localhost.localdomain (broadband-188-32-48-208.ip.moscow.rt.ru. [188.32.48.208])
        by smtp.googlemail.com with ESMTPSA id f197sm1103343wme.22.2019.08.12.23.10.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Aug 2019 23:10:29 -0700 (PDT)
From:   Denis Efremov <efremov@linux.com>
To:     linux-kernel@vger.kernel.org
Cc:     Denis Efremov <efremov@linux.com>, joe@perches.com,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH] MAINTAINERS: Update path to physmap-versatile.c
Date:   Tue, 13 Aug 2019 09:10:24 +0300
Message-Id: <20190813061024.15428-1-efremov@linux.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190325212438.25657-1-joe@perches.com>
References: <20190325212438.25657-1-joe@perches.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update MAINTAINERS record to reflect the filename change
from physmap_of_versatile.c to physmap-versatile.c

Cc: Boris Brezillon <boris.brezillon@bootlin.com>
Cc: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org
Fixes: 6ca15cfa0788 ("mtd: maps: Rename physmap_of_{versatile, gemini} into physmap-{versatile, gemini}")
Signed-off-by: Denis Efremov <efremov@linux.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 590dcebe627f..c9ad38a9414f 100644
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

