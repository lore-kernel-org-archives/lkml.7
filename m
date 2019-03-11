Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB571C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 13:23:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 966642084F
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 13:23:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727806AbfCKNXY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 09:23:24 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:33131 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727661AbfCKNTm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 09:19:42 -0400
Received: from orion.localdomain ([95.115.159.19]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MG9c2-1hHd6u3gRY-00GV8h for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019
 14:19:40 +0100
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     linux-kernel@vger.kernel.org
Subject: [PATCH 100/114] arch: sparc: Kconfig: pedantic formatting
Date:   Mon, 11 Mar 2019 14:18:52 +0100
Message-Id: <1552310346-7629-101-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1552310346-7629-1-git-send-email-info@metux.net>
References: <1552310346-7629-1-git-send-email-info@metux.net>
X-Provags-ID: V03:K1:vHsiTShidC5Dgo8VTrjmmxpoRSc13r9m2pYkb3Zhec/yy61Ecl0
 uHxXprYVZfBU4Ipv7+ZMJe93HhPHqaeJnoX5oNk6iJM+W94+cRBFUkCT/EUxkp5C4vaG+lk
 03BglHAVELfypLNDwzqbbgmsMj3Nh3SECjldSK9Tx1fOZzET85NBZRSVoMUplloiTHFNiYj
 IXRUYPIZJ3Tnc6r+uioSg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ijfaSP5fHHg=:nfOL92eohqH49WANxfYIcb
 w+7Q3/XldT+CyyYM0EFU5+V06e1wSp9ewFxCU6OvQMCTgYkAcQw/zyMLN4B8c9lheJt3KDorV
 cMY5kFdAJ7n8RgEPQ2N4cq5XQsvWBu52FHrzi0M//YKUUzkIXq/bFrJ5I/AF3xY+JnkUcXQok
 P+pCBoGNqVWn1qzTWsKkHgWkuDoNO385JyLwCJ7pREBSKY+XzHfBqnIWbKdD37PNikeYC8uZN
 uCpCaWnPmJaprqlsFkwYPwvAiLbOpA2ck7f/q+JtT0EMtCA/XSOlFQIKQ8ZR5kFhsZG7TMQZT
 mkZV0hRj70LQyG88/1R4OZp3DjD+mLVvCoiCH7KlqeeWQk/vrOPralnFhySyvda7eTHYsgOS6
 rrxpOVWAgEcvyf3O7dCeSYE3vdWEpSS/UjP21QRYtdSGrJssNkviup8w1A0PcTqGbL5k/6sEd
 kh7RoCmYSjQvLo5wpErvf+7YCyM9wWT8Ka6DH0joOvQAx7UW0HkpNwn5dom+Ix3X5UNuHyNll
 rhGUVQaKj9i1wl7hrJRLMurTiM307dhJ5BOq1KTI2lNFAdCzkrtXjWf+sWO7dOhTRTAV0eL2x
 HkHNRkHW2ufDYPbiEnWqi+FnT493BkXkuwkHy8NbCHvU7jFGTCL3OCCOe80fBRdPiautiP3se
 cRBZXr04X/UQU/juhPXqvnJ9tp3jsL6fA8NcXSoF8NiTYnISvMF9RcVlZUo6n/oKBsLFzwKeO
 ZC2lvkZD5jpzk+Xhhfebb5+nGuhL7+LfrFmMPQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Formatting of Kconfig files doesn't look so pretty, so let the
Great White Handkerchief come around and clean it up.

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 arch/sparc/Kconfig | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
index 40f8f4f..574fd92 100644
--- a/arch/sparc/Kconfig
+++ b/arch/sparc/Kconfig
@@ -430,28 +430,28 @@ config UBOOT_LOAD_ADDR
 	hex "uImage Load Address"
 	default 0x40004000
 	---help---
-	 U-Boot kernel load address, the address in physical address space
-	 where u-boot will place the Linux kernel before booting it.
-	 This address is normally the base address of main memory + 0x4000.
+	  U-Boot kernel load address, the address in physical address space
+	  where u-boot will place the Linux kernel before booting it.
+	  This address is normally the base address of main memory + 0x4000.
 
 config UBOOT_FLASH_ADDR
 	hex "uImage.o Load Address"
 	default 0x00080000
 	---help---
-	 Optional setting only affecting the uImage.o ELF-image used to
-	 download the uImage file to the target using a ELF-loader other than
-	 U-Boot. It may for example be used to download an uImage to FLASH with
-	 the GRMON utility before even starting u-boot.
+	  Optional setting only affecting the uImage.o ELF-image used to
+	  download the uImage file to the target using a ELF-loader other than
+	  U-Boot. It may for example be used to download an uImage to FLASH with
+	  the GRMON utility before even starting u-boot.
 
 config UBOOT_ENTRY_ADDR
 	hex "uImage Entry Address"
 	default 0xf0004000
 	---help---
-	 Do not change this unless you know what you're doing. This is
-	 hardcoded by the SPARC32 and LEON port.
+	  Do not change this unless you know what you're doing. This is
+	  hardcoded by the SPARC32 and LEON port.
 
-	 This is the virtual address u-boot jumps to when booting the Linux
-	 Kernel.
+	  This is the virtual address u-boot jumps to when booting the Linux
+	  Kernel.
 
 endmenu
 endif
-- 
1.9.1

