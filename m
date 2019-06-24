Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D1BFC43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 06:19:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BA3D20679
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 06:19:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727599AbfFXGTQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 02:19:16 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:45113 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727509AbfFXGTJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 02:19:09 -0400
Received: by mail-pl1-f193.google.com with SMTP id bi6so6268063plb.12
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jun 2019 23:19:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding:cc:from:to;
        bh=rpm1wCgAEfHZvBGxttYyRQHFsJlX3sGmqafd0katLnk=;
        b=n5O3YAuOAuplFMyS99BF6ZcpLm0a+gMEJyUONwuqOWJeHbkKYshBQ3SDCifury66RS
         0w+PSwdHQhM/yehhHqK6Obl9z+5HpCo6tnJbOdvtbTcwqyaoXYSbdzXS2xWlVqvYhJ4j
         0CejjYyBwxOzw5foAUzJzwJjHAyBwvHxvroMgH2nLd65wF8eLT0Ajr7ReE5V4F+cHgR2
         +n9OMT+BycKJgfLvhLjDzB0vWfmL0fL1ToXk+c27MZLnldiBUu5d+KRfRv5Ilru1umr/
         cGkfcxf4QltxtDwkAAJuoMwtg4ixVh7R/017NG03hFW0Q/A8hHttTtBDUmwAsOGqd24M
         +hsw==
X-Gm-Message-State: APjAAAWuZEFZMjdnOGB0Oc18bsvxWKYx0sRhIpfjVss3EVTByHa5ybbF
        klC7w22YMqDjM3GiHfg0q3kRUA==
X-Google-Smtp-Source: APXvYqx7B25IHDAa5NnQtkwIFYSIlYT6MSecbPmUB5KuKZtiiJBO+jVepUmZEtl3wQMqCBGXNbYsTw==
X-Received: by 2002:a17:902:9a82:: with SMTP id w2mr127519179plp.291.1561357148911;
        Sun, 23 Jun 2019 23:19:08 -0700 (PDT)
Received: from localhost (220-132-236-182.HINET-IP.hinet.net. [220.132.236.182])
        by smtp.gmail.com with ESMTPSA id r188sm3524198pfr.16.2019.06.23.23.19.08
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 23 Jun 2019 23:19:08 -0700 (PDT)
Subject: [PATCH 2/2] net: macb: Kconfig: Rename Atmel to Cadence
Date:   Sun, 23 Jun 2019 23:16:03 -0700
Message-Id: <20190624061603.1704-3-palmer@sifive.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190624061603.1704-1-palmer@sifive.com>
References: <20190624061603.1704-1-palmer@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc:     nicolas.ferre@microchip.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Palmer Dabbelt <palmer@sifive.com>
From:   Palmer Dabbelt <palmer@sifive.com>
To:     davem@davemloft.net
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When touching the Kconfig for this driver I noticed that both the
Kconfig help text and a comment referred to this being an Atmel driver.
As far as I know, this is a Cadence driver.  The fix is just
s/Atmel/Cadence/, but I did go and re-wrap the Kconfig help text as that
change caused it to go over 80 characters.

Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
---
 drivers/net/ethernet/cadence/Kconfig | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/cadence/Kconfig b/drivers/net/ethernet/cadence/Kconfig
index 74ee2bfd2369..29b6132b418e 100644
--- a/drivers/net/ethernet/cadence/Kconfig
+++ b/drivers/net/ethernet/cadence/Kconfig
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0-only
 #
-# Atmel device configuration
+# Cadence device configuration
 #
 
 config NET_VENDOR_CADENCE
@@ -13,8 +13,8 @@ config NET_VENDOR_CADENCE
 	  If unsure, say Y.
 
 	  Note that the answer to this question doesn't directly affect the
-	  kernel: saying N will just cause the configurator to skip all
-	  the remaining Atmel network card questions. If you say Y, you will be
+	  kernel: saying N will just cause the configurator to skip all the
+	  remaining Cadence network card questions. If you say Y, you will be
 	  asked for your specific card in the following questions.
 
 if NET_VENDOR_CADENCE
-- 
2.21.0

