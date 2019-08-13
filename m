Return-Path: <SRS0=Ecng=WJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84D36C433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 06:16:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5438020578
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 06:16:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727435AbfHMGP7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 02:15:59 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:39639 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726298AbfHMGP6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 02:15:58 -0400
Received: by mail-wm1-f65.google.com with SMTP id i63so367854wmg.4
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2019 23:15:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pwhmqWSkZkXK5PIssyQP4lQrBTS/FC4L2zJCnXKmTD0=;
        b=dNFOoZvJiv54Udh9ANlNN6OrwAPZVfMudlH17fqCeCXnCc+c4sgZ/bgfUGViLtMfz5
         g93DsVICMbcMDaMcrmMLDXSH0WplPGf52+hRizoRGTv8185edR9S8g2Lx35JWraWU99z
         q4LNYLdWy5HxvedW6k/8V/kkVzo+o/dnzRH/jsl/vbNSGMEU2HO2goky3av3zNgGQCvj
         KNxNQSNL8EUvV2iO292opePbC+BXbRk1hxnINh4P/pjLbAQo8SsuDiTV6um+8mczOaup
         +1/6SKKjzaQP5HwULAC7zT7nsmdawoOPR6XhvEhAarp/XF4XnTeAQLq+zmLovfzebYz9
         U/3g==
X-Gm-Message-State: APjAAAXoqy1Ecy442VidVtROa3xCwfoIo/m/JLn7KFiUu+SfWmyh7URI
        Ddn9AjJyru2aUx+2A2TrYeRaM6ODidU=
X-Google-Smtp-Source: APXvYqzo+ft9DO0CBBiDxvH3zpmBWDs3avnFnYe8+g3hlfnALaKNcUHwSOvKaeJS/cXvpxHIkj5cqw==
X-Received: by 2002:a7b:c310:: with SMTP id k16mr1009432wmj.133.1565676956514;
        Mon, 12 Aug 2019 23:15:56 -0700 (PDT)
Received: from localhost.localdomain (broadband-188-32-48-208.ip.moscow.rt.ru. [188.32.48.208])
        by smtp.googlemail.com with ESMTPSA id p13sm40776514wrw.90.2019.08.12.23.15.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Aug 2019 23:15:56 -0700 (PDT)
From:   Denis Efremov <efremov@linux.com>
To:     linux-kernel@vger.kernel.org
Cc:     Denis Efremov <efremov@linux.com>, joe@perches.com,
        Linus Walleij <linus.walleij@linaro.org>,
        Federico Vaga <federico.vaga@cern.ch>,
        Pat Riehecky <riehecky@fnal.gov>
Subject: [PATCH] MAINTAINERS: Remove FMC subsystem
Date:   Tue, 13 Aug 2019 09:15:47 +0300
Message-Id: <20190813061547.17847-1-efremov@linux.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <7cd8d12f59bcacd18a78f599b46dac555f7f16c0.camel@perches.com>
References: <7cd8d12f59bcacd18a78f599b46dac555f7f16c0.camel@perches.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cleanup MAINTAINERS from FMC record since the subsystem was removed.

Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Federico Vaga <federico.vaga@cern.ch>
Cc: Pat Riehecky <riehecky@fnal.gov>
Fixes: 6a80b30086b8 ("fmc: Delete the FMC subsystem")
Signed-off-by: Denis Efremov <efremov@linux.com>
---
 MAINTAINERS | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index ab870920ea82..2548dd1efb2d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6330,15 +6330,6 @@ S:	Odd Fixes
 L:	linux-block@vger.kernel.org
 F:	drivers/block/floppy.c
 
-FMC SUBSYSTEM
-M:	Alessandro Rubini <rubini@gnudd.com>
-W:	http://www.ohwr.org/projects/fmc-bus
-S:	Supported
-F:	drivers/fmc/
-F:	include/linux/fmc*.h
-F:	include/linux/ipmi-fru.h
-K:	fmc_d.*register
-
 FPGA MANAGER FRAMEWORK
 M:	Moritz Fischer <mdf@kernel.org>
 L:	linux-fpga@vger.kernel.org
-- 
2.21.0

