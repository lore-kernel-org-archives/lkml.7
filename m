Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92C35C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 13:28:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 678FF2183F
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 13:28:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728211AbfCKN2s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 09:28:48 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:33849 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727554AbfCKNTe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 09:19:34 -0400
Received: from orion.localdomain ([95.115.159.19]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1Mzhax-1gqUxI09uT-00vj8U for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019
 14:19:33 +0100
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     linux-kernel@vger.kernel.org
Subject: [PATCH 041/114] drivers: w1: Kconfig: pedantic formatting
Date:   Mon, 11 Mar 2019 14:17:53 +0100
Message-Id: <1552310346-7629-42-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1552310346-7629-1-git-send-email-info@metux.net>
References: <1552310346-7629-1-git-send-email-info@metux.net>
X-Provags-ID: V03:K1:o06/8INm1V2qSjKnrekUd1aAvOZf2VIJ3cCHEvknpwVgwtozwP5
 1NWJ07p0NyKrTzoDRxlhHhdNigl/aQZzxgR0Ljh/SQCUeNATp28EOL7XPdkVi705nvYdPFC
 SOlRsrtX2DnVQLY/wDd4p1vNOg/0HmwSBEBWaRn7DqV9f/Lfjq0WMoNYWRvg547dUSXS6GS
 K19JROxWPhkNaRlyJnFjA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:5QIjfUWo29g=:YRd6gjKQmIPeVdFLjbTrdb
 CLOfE3PrEFTLTzRs+X2vjn15e1IxfwtrX1Iar7nTYQqSKfxHPzPTVC1S1n1zuavZ5roaC5ACW
 /JZioWUGKTq+vbMGmYU1DuI4noFqt+kR/8EaprNuaI9RP7gX9ruy3ZHzd/qSBZfOWol3dpQ71
 aEdBNQ2tYipk+//AzLNw/WhYlROmzEQ2q5/mQBiKDaavs2e8wOdFcCop/PHx6jVRBcOPCvkFi
 +3ufLwyDL68PebZXnSICncsQr6WB+hP6+14jsAnWVVimX4jR2gjPY6r4mZt8U6JmzPZ6ydrnO
 NDOkQCpGNA+gV+PoBTnst0W6+IMVq9TzVGTaFMeQPDRZ+6Qtq2FV1HjWfn5OzK1eZ/TNdn5sQ
 zM3DHvv7j2NptSo1EJKupbHQJtK7ORpII8MMoZm1P8rKz36RXW+01+8ap90nCiWxTYaz+H/XG
 CWzeM+xZjQ/6UKwEKh6m/KT0V3V3JSF9pF0K3UzdQWqHgsA12dkgVl8gN7oG2hkEIuWdVInIr
 i6jkh8Ng17I8Gu1sR4Bn8qlmjGy9JWtAdN7jvtDmFTkyQZV9m9y+9fCRx+zDdtDUeD3NZuDQX
 RfQDkM/6T7oiVPNqW7l1H4Lm06cc7nTlXKncgGU1sE7nsBHJHzfN5PktbJVbjvoxirrhokMJu
 LJL6ivLzwUu7s5DvtmvStlOZD2Nnn4AA7kLjIVKp6dAyDCO4Z+T3OyR6N77pPqW8oXphmLI/D
 wCcWERvhNPbLzgrTRftLCFHN+9cqtYoNvQDBJg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Formatting of Kconfig files doesn't look so pretty, so let the
Great White Handkerchief come around and clean it up.

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 drivers/w1/masters/Kconfig | 7 +++----
 drivers/w1/slaves/Kconfig  | 4 ++--
 2 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/w1/masters/Kconfig b/drivers/w1/masters/Kconfig
index 00827d2..dfedf6d 100644
--- a/drivers/w1/masters/Kconfig
+++ b/drivers/w1/masters/Kconfig
@@ -16,12 +16,12 @@ config W1_MASTER_MATROX
 
 config W1_MASTER_DS2490
 	tristate "DS2490 USB <-> W1 transport layer for 1-wire"
-  	depends on USB
-  	help
+	depends on USB
+	help
 	  Say Y here if you want to have a driver for DS2490 based USB <-> W1 bridges,
 	  for example DS9490*.
 
-  	  This support is also available as a module.  If so, the module
+	  This support is also available as a module.  If so, the module
 	  will be called ds2490.
 
 config W1_MASTER_DS2482
@@ -65,4 +65,3 @@ config HDQ_MASTER_OMAP
 	  on an OMAP processor.
 
 endmenu
-
diff --git a/drivers/w1/slaves/Kconfig b/drivers/w1/slaves/Kconfig
index e22fded..c0c711c 100644
--- a/drivers/w1/slaves/Kconfig
+++ b/drivers/w1/slaves/Kconfig
@@ -70,8 +70,8 @@ config W1_SLAVE_DS2805
 	help
 	  Say Y here if you want to use a 1-wire
 	  is a 112-byte user-programmable EEPROM is
-          organized as 7 pages of 16 bytes each with 64bit
-          unique number. Requires OverDrive Speed to talk to.
+	  organized as 7 pages of 16 bytes each with 64bit
+	  unique number. Requires OverDrive Speed to talk to.
 
 config W1_SLAVE_DS2431
 	tristate "1kb EEPROM family support (DS2431)"
-- 
1.9.1

