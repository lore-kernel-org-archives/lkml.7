Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5818C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 13:28:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7796B214D8
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 13:28:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727800AbfCKN21 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 09:28:27 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:51113 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727562AbfCKNTf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 09:19:35 -0400
Received: from orion.localdomain ([95.115.159.19]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MekvT-1gTSK02oeT-00alw6 for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019
 14:19:33 +0100
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     linux-kernel@vger.kernel.org
Subject: [PATCH 046/114] lib: Kconfig: pedantic formatting
Date:   Mon, 11 Mar 2019 14:17:58 +0100
Message-Id: <1552310346-7629-47-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1552310346-7629-1-git-send-email-info@metux.net>
References: <1552310346-7629-1-git-send-email-info@metux.net>
X-Provags-ID: V03:K1:vYv7O1XJRkozsQlAwUGdGC2nrXK7HZbbR4OirO0O58l32q7HVxO
 uaLu/awhmaDwSsMxwR1iBI4WhTUDJN5ZmSYsD6qmQGc3pYjj2Abx0273XkqVD0K9P1bt04f
 qzF0ok03Ma45pMEFDP7d6rAH9LRqW2JxZVWfqxHl4pRoTvRjRCQWtojKgGVsxghrF5xPvF7
 7+bASTlxUw3NXru9H8DfQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:L+K8Wl9WJwg=:dLJg/MG5no73K57odF//0N
 9GbiaBjBWQx9TBUizaHkoDglC+NknivTpi1QP69VHBCEjpZk/C8yplIn3VJi0DZd9akaWcujF
 PkMEvSAjw7zvWcICzHlzMJT2iCnurLjyo9WSBVWsr+YNSln7YYa9O8A8mp3mwVcmH7iuenTl/
 qYy1s/PWPEgvGqqdYsR3Wd7lSyIqSgDHA4DXrkl3jdqUrWQmXDI5TA4MfJ+luunCyDjknUsgz
 i3SHgTiywkH1quL9ibApwG9mLm4iLXmxrQrv5MA7oY/5W57FyTylOZEr9nqNh/66Kv2948er4
 LjrHGRtnTP6saKF76AfGYp9HdXli+j/gYVP7u9R688hHipMsHLApwXpvpayXCjV93lznMG8xk
 894SkfqTu3X3C+S4d+JfpVkiiwBujL7me8zxVz/3DNoae5I5tcR5GOGuILc6K2PEB3t402lmx
 OXpoDyesC33w8Gq6C/pAi4V07iuL5lskR19LMQdiKPHIlUpfWrP9kfmIlgXZ+UQDeISh/QuU2
 Mws58dsac1ImrtNXhD3GfgCRG+vTIsIucRl3gfLpMXd+tF/QmW64PpqAYvWYbTTjs/dcz/F3C
 lsymBhJjGzONFcK9FWALIjFQlaWMMVOLH72lhEW2u0nhwXFpLEjmfBCeGq8gcg5d+XJtUrTj/
 jWEFxk9SasAQ2XO2bB1H5Urj2PwRhbztF00/rCwMtFGjERDkX1QlOhBWyumsbhyTRZi4oO6GN
 xmy+U7xQiSyUtaUmjqo6KDAAR1tIgNgsgZWUvw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Formatting of Kconfig files doesn't look so pretty, so let the
Great White Handkerchief come around and clean it up.

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 lib/Kconfig | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/lib/Kconfig b/lib/Kconfig
index a9e5653..11888db 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -506,7 +506,7 @@ config NLATTR
 # Generic 64-bit atomic support is selected if needed
 #
 config GENERIC_ATOMIC64
-       bool
+	bool
 
 config LRU_CACHE
 	tristate
@@ -563,23 +563,23 @@ config OID_REGISTRY
 	  Enable fast lookup object identifier registry.
 
 config UCS2_STRING
-        tristate
+	tristate
 
 source "lib/fonts/Kconfig"
 
 config SG_SPLIT
 	def_bool n
 	help
-	 Provides a helper to split scatterlists into chunks, each chunk being
-	 a scatterlist. This should be selected by a driver or an API which
-	 whishes to split a scatterlist amongst multiple DMA channels.
+	  Provides a helper to split scatterlists into chunks, each chunk being
+	  a scatterlist. This should be selected by a driver or an API which
+	  whishes to split a scatterlist amongst multiple DMA channels.
 
 config SG_POOL
 	def_bool n
 	help
-	 Provides a helper to allocate chained scatterlists. This should be
-	 selected by a driver or an API which whishes to allocate chained
-	 scatterlist.
+	  Provides a helper to allocate chained scatterlists. This should be
+	  selected by a driver or an API which whishes to allocate chained
+	  scatterlist.
 
 #
 # sg chaining option
-- 
1.9.1

