Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D317C43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 18:49:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DFC72063F
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 18:49:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728051AbfCFStG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 13:49:06 -0500
Received: from mout.kundenserver.de ([212.227.17.13]:53559 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727780AbfCFStF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 13:49:05 -0500
Received: from orion.localdomain ([95.118.27.116]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MsZ3N-1gnFJT0jP9-00u3f1 for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2019
 19:49:04 +0100
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     linux-kernel@vger.kernel.org
Subject: [PATCH] drivers: pcmcia: Kconfig: pedantic cleanups
Date:   Wed,  6 Mar 2019 19:49:03 +0100
Message-Id: <1551898143-18026-1-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
X-Provags-ID: V03:K1:bpx8tDC3Z/uu8AIBstDrCq9NaR3a2VKlz5upt/KYVOFosEvXz4T
 nw1DyVLuyataDARtQ4twyn+WQSpAalJmgbS88J9MI4oIhtN3Khd/1zNSIgl4Mjr7Uvm8Def
 fIyM2R+vE6ZLj5XNiu3jy25/bCrABfVSzpoZ2+gzqS9ja9lslbkPw0aMlv74hOFKdvN36CQ
 l8rxewa0dPsmqkPp/ApCg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:leoq1K2HASU=:Ix4RigPnVDIHaUxPXujhq+
 4bxUn8LQkLqzUXvQ5XO0Zljw/nCqEfZFzBGbxVD8egiZC0yFiR0lYD8W8fLhVk1ra8eUby5NP
 zlZ8ekMuTDGpaF5ddbau7hrmplqa31JBldSOtXsbF+5tGCED9HFQpi4PH48Fa07OLEJtjgUCI
 CWKOT9BKPKZboIOeZg3zhQgJQof3ZzpUUayy8DO3ziFAGtwbItd8h6jf7aT09YyCUdXL/9byT
 3zXul+U12QJDsGYXJik1c3D2u+PWdBMY9odHvlTrms46RWuZ6Wa2k3AyZd9dMxS7aD5SqgQnr
 hdiqXLaquPpG2OVb3rujkg3uiloqSm5n+MGrVku3v/r1vbSJr59WhE9hc++/JwT5pdsOs2qAO
 iLCz02CR/Sh0ObMa1/TR8ue2g5S3lRxCdOs6wnB7R4RNaiL6f61+X6mXVHr39M2BHZ7mlR2Ui
 L0+XFr4NW0Fa7pG/9+TPc4Y2LmG8wiXPMSZa+muLK8OnO1SkeYTlrpCX/CCvo4WCRj1e6BUYJ
 ln+EVzeN05NPT/PnFoOBxSoFW8uiSpqwajk/CE9HlzRkEBmsZpKaDDCsfDDYzBdh7xoi5CRb7
 KLW2biEPnxx/sMAt3j5ml6D9+Wg/h3xawnsEgUtuNT2AEQfl+ka7ocyBHdrlirWyoXe3xTC2B
 8nmtPIvfyk8omaXj5sJtBv/Ts2Ur5OIwjy4EvswkzDV9a45gQunDtSXI7nGwFZAzauKdjESWl
 JlCxs3eMNDF2IMJrTrLI52RvnpS7f9dHqEqBTA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

