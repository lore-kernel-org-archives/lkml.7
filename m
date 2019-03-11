Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAA82C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 13:23:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 946F12084F
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 13:23:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727664AbfCKNTl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 09:19:41 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:53417 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726826AbfCKNTb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 09:19:31 -0400
Received: from orion.localdomain ([95.115.159.19]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MyK9S-1grKpx37SG-00yjwN for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019
 14:19:29 +0100
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     linux-kernel@vger.kernel.org
Subject: [PATCH 016/114] drivers: pcmcia: Kconfig: pedantic formatting
Date:   Mon, 11 Mar 2019 14:17:28 +0100
Message-Id: <1552310346-7629-17-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1552310346-7629-1-git-send-email-info@metux.net>
References: <1552310346-7629-1-git-send-email-info@metux.net>
X-Provags-ID: V03:K1:DutnTnCXKj+LjH0YvRZSP1ALY/F5lkX5onakkTKHZDsBPowO+K0
 3XzyldEtUj59teylaPxCYyDgPlkhoHWujqCg0Jib2RXRx5gjNz9GDVQo/wgdX7YFqf8iTng
 r3vltWSAuFjoZrYzZeSrRUlOjbBcYjKRrM2jE1w+NG5Mfin+D0GZAFUNXeEgODckIr2zPtf
 X/2c1UiqKkPAfW090lzdg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Tg3vld7R8TY=:1TzriM+Sa4KY86EL36cKSO
 eC/SNM10BvpFbs/wXABCLg0OfuBRYCKzJwehvEAT9zya2fNUH1O0+G7UFBuZnFC7sd5g1M3jg
 ZaRzIK3Qa+Puskf8In12W54WaAZGYTWBu+MRriSWHHhYhnkfEYvnntQ5HcDtlRDxQr+kxZive
 VqhJSYRQnohcdjjj99yrw/mYeBd4hXvWOiJYf66iZIxN37UtBnCMXENrN+zn9tkaOcYF4qC8w
 5TQRqrb3q585zAvj7JPt9wAC8UuQ1rP+0u+QD/St88j7pR7sjHQNK0zoMv400gwmHQwhl0vv2
 kAY5PXK/C6ZrpmTSOldP6De29U+YssI3GpdimeOYJqzW9i68PvZWOnxbszIVD1cx+hSWrJ1Ck
 DmyfEeiqk4Tu4tCHpFwoNJZqABed7IgA0OYbF/+cgbhgmJuXuAi5UYBgt25nQGZgX2HQqao8V
 KZh1176SxnLOlQ+DMF944BbFMAKCC2RTGu5z+mgrZbmGY5trDBI4OaDTT0zKXnpqHLwbNXA00
 108gAzuGvP2MeuzkMWCxpwPS30vwtiyJls8lF/564o+5D3lE2EmNtuu2/bztd3zLHbNtzQs/j
 QaBggkVuvF8ZAf0mMMOJtYggjC8qr4vN1rGg26dYS5Zfr9ZWqgiHPe80rvFITz9R4x3fkcAAp
 rtwxQtTa3Fuex++bqAJdgo5jSZZhV7wosSkFbD1A0BSTwIQixQGuAFOn3bXj7WJlPl3FAxVZr
 ATThKf2Ayw1FygOf/btR3fHDomBp2CLbkY2A5g==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Formatting of Kconfig files doesn't look so pretty, so let the
Great White Handkerchief come around and clean it up.

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 drivers/pcmcia/Kconfig | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/pcmcia/Kconfig b/drivers/pcmcia/Kconfig
index fab92ba..1fc7ded 100644
--- a/drivers/pcmcia/Kconfig
+++ b/drivers/pcmcia/Kconfig
@@ -22,18 +22,18 @@ config PCMCIA
 	select CRC32
 	default y
 	---help---
-	   This option enables support for 16-bit PCMCIA cards. Most older
-	   PC-cards are such 16-bit PCMCIA cards, so unless you know you're
-	   only using 32-bit CardBus cards, say Y or M here.
+	  This option enables support for 16-bit PCMCIA cards. Most older
+	  PC-cards are such 16-bit PCMCIA cards, so unless you know you're
+	  only using 32-bit CardBus cards, say Y or M here.
 
-	   To use 16-bit PCMCIA cards, you will need supporting software in
-	   most cases. (see the file <file:Documentation/Changes> for
-	   location and details).
+	  To use 16-bit PCMCIA cards, you will need supporting software in
+	  most cases. (see the file <file:Documentation/Changes> for
+	  location and details).
 
-	   To compile this driver as modules, choose M here: the
-	   module will be called pcmcia.
+	  To compile this driver as modules, choose M here: the
+	  module will be called pcmcia.
 
-	   If unsure, say Y.
+	  If unsure, say Y.
 
 config PCMCIA_LOAD_CIS
 	bool "Load CIS updates from userspace"
@@ -275,4 +275,4 @@ config PCCARD_NONSTATIC
 config PCCARD_IODYN
 	bool
 
-endif	# PCCARD
+endif # PCCARD
-- 
1.9.1

