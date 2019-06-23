Return-Path: <SRS0=VFBv=UW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B478CC43613
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Jun 2019 15:09:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92BFE20645
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Jun 2019 15:09:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726681AbfFWPJu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Jun 2019 11:09:50 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:39361 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726429AbfFWPJt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jun 2019 11:09:49 -0400
Received: by mail-pf1-f195.google.com with SMTP id j2so6049983pfe.6;
        Sun, 23 Jun 2019 08:09:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=66SWU+ctYxtZn/h5UpypgxOW/HLCO9TF1ChCXAD7X4k=;
        b=AhVFWJV7ntugcnosGpS2QmPVv4xC49jzuauRAOtdltLkszkmWe6yT1iVQ/jD1zQT8y
         Vxgf/U9Cibla35TR/T62L/vmY38ajmBVBDyybD90kjgyV9OY4ClDOAJdyY+mXWsfEcdW
         mF8mJQm04WvDMBPgQqcoiKhdmkzsCB2PldaFHAta0sn13D7jxnG9Zr5Tg7QzV1keA5ru
         BfI7GhaqPp/HAmZ85IJuUhlFlgsPL0NlwHwqsaJqQJrS6sF87v/DWDyO3LESapOxLDnU
         /6/h/5Au1o0GnOESpQsa+sHnRbNSNdorAp/inTJhpcfvtytmuyVTHdi+uDZQkMFZKWbW
         6b5Q==
X-Gm-Message-State: APjAAAXURz5KVz2/3U+Ed1P8GFOaCfVgUFX12pIqrF0XciDROZsELxr3
        pSCJzuwNYZJunkX6Gy0pDKc=
X-Google-Smtp-Source: APXvYqwB2kg9O2RBgY8RpYRzutcwp5sLqRHDdr3hxYqbl2x0R1h6X429vICDzpeFjZy8+rIxtN4VPg==
X-Received: by 2002:a63:f346:: with SMTP id t6mr17447310pgj.203.1561302589296;
        Sun, 23 Jun 2019 08:09:49 -0700 (PDT)
Received: from localhost.localdomain (broadband-188-32-48-208.ip.moscow.rt.ru. [188.32.48.208])
        by smtp.googlemail.com with ESMTPSA id s24sm8674255pfh.133.2019.06.23.08.09.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 23 Jun 2019 08:09:48 -0700 (PDT)
From:   Denis Efremov <efremov@linux.com>
To:     "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
Cc:     Denis Efremov <efremov@linux.com>, Helge Deller <deller@gmx.de>,
        linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] parisc: asm: psw.h: missing header guard
Date:   Sun, 23 Jun 2019 18:09:20 +0300
Message-Id: <20190623150920.26422-1-efremov@linux.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The psw.h header file contains #ifndef directive of the guard,
but the complimentary #define directive is missing. The patch
adds the appropriate #define to fix the header guard.

Signed-off-by: Denis Efremov <efremov@linux.com>
---
 arch/parisc/include/asm/psw.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/parisc/include/asm/psw.h b/arch/parisc/include/asm/psw.h
index 76c301146c31..7a175e866ed0 100644
--- a/arch/parisc/include/asm/psw.h
+++ b/arch/parisc/include/asm/psw.h
@@ -1,5 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 #ifndef _PARISC_PSW_H
+#define _PARISC_PSW_H
 
 
 #define	PSW_I	0x00000001
-- 
2.21.0

