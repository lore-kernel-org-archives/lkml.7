Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D46F2C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 13:19:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD2222084F
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 13:19:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727735AbfCKNTt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 09:19:49 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:43277 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727568AbfCKNTf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 09:19:35 -0400
Received: from orion.localdomain ([95.115.159.19]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1N5G1T-1gtkbA3KZp-011Clq for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019
 14:19:33 +0100
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     linux-kernel@vger.kernel.org
Subject: [PATCH 047/114] net: caif: Kconfig: pedantic formatting
Date:   Mon, 11 Mar 2019 14:17:59 +0100
Message-Id: <1552310346-7629-48-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1552310346-7629-1-git-send-email-info@metux.net>
References: <1552310346-7629-1-git-send-email-info@metux.net>
X-Provags-ID: V03:K1:DYO0wdgGCG2v2IT+ly5GoC/BlQV2Xnm7Wzl8Rmevt1lg/KcjEnC
 tPYl3iRsKNp7lRDtDA5f/jyvjokwWP3uNg81qC0sRNPA2YOwn1599LImzTHg6NEZOWqUlxf
 sibNA5odjWUut2eRqKFShtVt83XWmxs2HH+khgp4o1mqVNEh/fiIYGYCeBiFFtcQJ6VQ+d8
 tY7KnmuQa/l0ri1nBTzww==
X-UI-Out-Filterresults: notjunk:1;V03:K0:FpBOC7R44oE=:LC5/hZkghsbxKFChnNKoS4
 8dPa1vldMwUn0OMghC1GXJ4pPRoCtREL4AjjeYFQgzQ1C1FqOhZ771ptlHVSYLyLZ467ww80w
 r/2yoPhZdfGWBpZiKPwXJ2NojS7IHy7nlRx9cEbD8+RByG0XFthzzh7ow/CbbOSleaqs+jafW
 +o7aRpKl67HTjhLhjQl+OG4QCe/Tlr1yV2VeJ9Syn+7JsgF0GXy+GOE74TwpxYXUBdILfEFjF
 fmIWSYb6jjnqOdE218xDzF2jVG/o370H0v4M3kkTKcNkNXTBMX69nM4NyyeII/fJaV39i6j9o
 /vXElLZnIvy/0524HPyDxkSCQ1tqR453sNaDNoIQobAM00PkUeeij/Fh09N2tw+ZH4th6Rtng
 jsFjq2szFKZS3kBOhU95fPkmBUnQsP+QmxyJkfpltd0oChrTZZ80vkzI7p9u+UUskkugnxJGZ
 +Zi81PnxZubzJurBN/gbTLLCM9kudVTXAWg5w7KSA/dI7aXqpX63Qyk21Xn/JbxI96TWdPhXQ
 mrA83uCvz4p38SGNiGT90Ph3KLN5Asm8VPrMW/NUw+KnG+AWc63gbwn3LWoqtcKzxEio1DPin
 PCT0afO2WF3Aie0TmBtbsAITr4V39rbuKkP0oCZmDbKtWt4wkIoJP23HwAKUrmdJ8whlgD2Ij
 8rmNdcb7+FzosELUNy0NBBQdi63loIEvCR94Mg029EqFQioXqQNyUSGGIZgQ3LlETNgAbwwdM
 jo4RBoo/n8iSJvfPWk5WQs86Dwo2qGUEuFqJGA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Formatting of Kconfig files doesn't look so pretty, so let the
Great White Handkerchief come around and clean it up.

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 net/caif/Kconfig | 48 ++++++++++++++++++++++++------------------------
 1 file changed, 24 insertions(+), 24 deletions(-)

diff --git a/net/caif/Kconfig b/net/caif/Kconfig
index d369495..de9abf0 100644
--- a/net/caif/Kconfig
+++ b/net/caif/Kconfig
@@ -7,47 +7,47 @@ menuconfig CAIF
 	select CRC_CCITT
 	default n
 	---help---
-	The "Communication CPU to Application CPU Interface" (CAIF) is a packet
-	based connection-oriented MUX protocol developed by ST-Ericsson for use
-	with its modems. It is accessed from user space as sockets (PF_CAIF).
+	  The "Communication CPU to Application CPU Interface" (CAIF) is a packet
+	  based connection-oriented MUX protocol developed by ST-Ericsson for use
+	  with its modems. It is accessed from user space as sockets (PF_CAIF).
 
-	Say Y (or M) here if you build for a phone product (e.g. Android or
-	MeeGo ) that uses CAIF as transport, if unsure say N.
+	  Say Y (or M) here if you build for a phone product (e.g. Android or
+	  MeeGo ) that uses CAIF as transport, if unsure say N.
 
-	If you select to build it as module then CAIF_NETDEV also needs to be
-	built as modules. You will also need to say yes to any CAIF physical
-	devices that your platform requires.
+	  If you select to build it as module then CAIF_NETDEV also needs to be
+	  built as modules. You will also need to say yes to any CAIF physical
+	  devices that your platform requires.
 
-	See Documentation/networking/caif for a further explanation on how to
-	use and configure CAIF.
+	  See Documentation/networking/caif for a further explanation on how to
+	  use and configure CAIF.
 
-config  CAIF_DEBUG
+config CAIF_DEBUG
 	bool "Enable Debug"
 	depends on CAIF
 	default n
 	---help---
-	Enable the inclusion of debug code in the CAIF stack.
-	Be aware that doing this will impact performance.
-	If unsure say N.
+	  Enable the inclusion of debug code in the CAIF stack.
+	  Be aware that doing this will impact performance.
+	  If unsure say N.
 
 config CAIF_NETDEV
 	tristate "CAIF GPRS Network device"
 	depends on CAIF
 	default CAIF
 	---help---
-	Say Y if you will be using a CAIF based GPRS network device.
-	This can be either built-in or a loadable module,
-	If you select to build it as a built-in then the main CAIF device must
-	also be a built-in.
-	If unsure say Y.
+	  Say Y if you will be using a CAIF based GPRS network device.
+	  This can be either built-in or a loadable module,
+	  If you select to build it as a built-in then the main CAIF device must
+	  also be a built-in.
+	  If unsure say Y.
 
 config CAIF_USB
 	tristate "CAIF USB support"
 	depends on CAIF
 	default n
 	---help---
-	Say Y if you are using CAIF over USB CDC NCM.
-	This can be either built-in or a loadable module,
-	If you select to build it as a built-in then the main CAIF device must
-	also be a built-in.
-	If unsure say N.
+	  Say Y if you are using CAIF over USB CDC NCM.
+	  This can be either built-in or a loadable module,
+	  If you select to build it as a built-in then the main CAIF device must
+	  also be a built-in.
+	  If unsure say N.
-- 
1.9.1

