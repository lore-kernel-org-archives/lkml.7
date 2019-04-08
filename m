Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFB00C10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 21:28:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A778D21473
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 21:28:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729325AbfDHV2O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 17:28:14 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:34741 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726585AbfDHV2N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 17:28:13 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.129]) with ESMTPA (Nemesis) id
 1Mow4E-1gYA3B1D6U-00qR62; Mon, 08 Apr 2019 23:28:03 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Julian Wiedmann <jwi@linux.ibm.com>,
        Ursula Braun <ubraun@linux.ibm.com>
Cc:     clang-built-linux@googlegroups.com,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        linux-s390@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        "David S. Miller" <davem@davemloft.net>,
        Kittipon Meesompop <kmeesomp@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 04/12] s390: qeth: address type mismatch warning
Date:   Mon,  8 Apr 2019 23:26:17 +0200
Message-Id: <20190408212648.2407234-4-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20190408212648.2407234-1-arnd@arndb.de>
References: <20190408212648.2407234-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:+QJU0uJxcc6xEbQFznVyL0iC3/HwW742Nz5nMKVxDCcza0Vsbs3
 CeF6aQuoUkeYzjFzTXZ0dsCKyGtaQm0aCegCCk+8QgfIXmA2JcWO8VbtWsxSEcgvgEsKaq7
 fRMdc2Nz2wdHcHRrRWFIRCOGsC6W/JXeKKGChmNmjpt2OZkOdSAJGTqdh4ZTse8SJgjBct5
 Ukc/DZR9TWhDihkEz6a6Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Js6QLh8dEi4=:2WKLJ1YqPSrMciIZ6UXtdB
 hbjJhkTr+iACVzmmWtwrh54IOiRI0FRTl3akDmdkjhSZHglcSMTykMeEi7MJ3jsI7oYI3Fx2v
 CLgmIu+Tw5Luy71NZbO7M7a6S7n5xEXxVpVPPHwRzj49fAupP9RQg0UyI+F13Dd82aKACJmhN
 zoXeqtYjs9AMezdTo3SlZN9e2vvZ1lhB+C3pT5mbEh0tSyVFoY5TY3hGaBOmXB07Im6Lg8yGL
 8hTrH2fF5RICvwVsyWIzXqmEUoMoRHz01dP1kaCksGzM8/WHLaUGE9xBY4tYEyqOnu9mUU+Y2
 en+adaLqpX2rzJVmmP/G424Yx6rUBST4WZp0DPktnXzq+e+2bq/biyVHHBKff/2CW8RmLjJvs
 KQ+edLxIqi1MYBPgpXxKLjABKkqqlSscxX4Q5D4w0MNErfMeD4w0W9A9ZESarHL2W1oaeyTVQ
 YZwWcGoLCn0vgIBv7rD/XYgQawnrzaS3hwtq5936ROcYd0Ql4ZQtF6+7QTPScLQoow0OhHjQ3
 9fCd0ZtfQqV5lKk5InRR3GlJNrL8duIpuMM+XEq/uufWaGmSiVkTxWx2+YuaeSk/ny8kAI816
 74f5SbPwzyI9IVfYekabs8XV5C5Zz7IQcxPL1HiSjRmxpm3TRf4JqIctLpx5LPc8Y0Xk4XK2w
 05pT+gWWtQZaz2z2WLFcKtBXmlOg5AoFVvdUYD9NNIK5OxEk24WNGv8Xo+jHrcEgAEY6otdAT
 11QtMd0Qbx7OQukYEXmFF+xQ8gBegdR6STllSw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

clang produces a harmless warning for each use for the qeth_adp_supported
macro:

drivers/s390/net/qeth_l2_main.c:559:31: warning: implicit conversion from enumeration type 'enum qeth_ipa_setadp_cmd' to
      different enumeration type 'enum qeth_ipa_funcs' [-Wenum-conversion]
        if (qeth_adp_supported(card, IPA_SETADP_SET_PROMISC_MODE))
            ~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/s390/net/qeth_core.h:179:41: note: expanded from macro 'qeth_adp_supported'
        qeth_is_ipa_supported(&c->options.adp, f)
        ~~~~~~~~~~~~~~~~~~~~~                  ^

Add a version of this macro that uses the correct types, and
remove the unused qeth_adp_enabled() macro that has the same
problem.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/s390/net/qeth_core.h | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/s390/net/qeth_core.h b/drivers/s390/net/qeth_core.h
index c851cf6e01c4..d603dfea97ab 100644
--- a/drivers/s390/net/qeth_core.h
+++ b/drivers/s390/net/qeth_core.h
@@ -163,6 +163,12 @@ struct qeth_vnicc_info {
 	bool rx_bcast_enabled;
 };
 
+static inline int qeth_is_adp_supported(struct qeth_ipa_info *ipa,
+		enum qeth_ipa_setadp_cmd func)
+{
+	return (ipa->supported_funcs & func);
+}
+
 static inline int qeth_is_ipa_supported(struct qeth_ipa_info *ipa,
 		enum qeth_ipa_funcs func)
 {
@@ -176,9 +182,7 @@ static inline int qeth_is_ipa_enabled(struct qeth_ipa_info *ipa,
 }
 
 #define qeth_adp_supported(c, f) \
-	qeth_is_ipa_supported(&c->options.adp, f)
-#define qeth_adp_enabled(c, f) \
-	qeth_is_ipa_enabled(&c->options.adp, f)
+	qeth_is_adp_supported(&c->options.adp, f)
 #define qeth_is_supported(c, f) \
 	qeth_is_ipa_supported(&c->options.ipa4, f)
 #define qeth_is_enabled(c, f) \
-- 
2.20.0

