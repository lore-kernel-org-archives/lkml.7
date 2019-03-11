Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 378A2C4360F
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 13:21:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E8842084F
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 13:21:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727775AbfCKNT4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 09:19:56 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:57055 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727592AbfCKNTh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 09:19:37 -0400
Received: from orion.localdomain ([95.115.159.19]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1N5mOb-1h0vLI2dcx-017ENk for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019
 14:19:35 +0100
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     linux-kernel@vger.kernel.org
Subject: [PATCH 061/114] drivers: sbus: Kconfig: pedantic formatting
Date:   Mon, 11 Mar 2019 14:18:13 +0100
Message-Id: <1552310346-7629-62-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1552310346-7629-1-git-send-email-info@metux.net>
References: <1552310346-7629-1-git-send-email-info@metux.net>
X-Provags-ID: V03:K1:uv5hMka7NA9Hmootsaq1jBDjUiXjRatpBM7qRkksDN6aaKITnEq
 kQ4vdlFSLNm1lMUvcTWlET2/Re5nvmkfQCaUdX/wP68Kz/t1PeshD146XIPrTtv75g4XlW0
 ETMR+7P6vYNXDpi/GOCt4qz6wnU7iE7oF0QrcdRfaJoWiWGNJYrBa1YuD+7x+P38+4ooe5M
 FWFtn8H2B5nw98HVeQftQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:beqLM2uFWM0=:q4/5AWnLVu9I4C1/SRFgbb
 BGZMNAzn7hmSRMLME0TIRuWQ/R3xmDp5F75CVAsmD5FrVzo4I/2p9iKHqKcj0Jv9FhMt+qdi6
 X7hRcW0o88wmh4AxTHKfJ5e9Yh1j+LjVUJbq606EvdSAoOgh++69DfO4Qn0qVXZFSQ79Deqb3
 bG3+BKXqGsxSOcc+ru1H/HztOqkvTODdAJh7F8nyN3YvN55lYpePBDKXqh2ZGHEd64yqKMFmx
 ty/5kCW2IdOmNP9ekVvW1IUiQEIvLQqKvEd/0d6VARozPtnF4L9ltDJ52CqHsz5LCzbelWL6x
 uL/o2iN02QdzfGHhOSBkV/9J6ATs5NnLsrwIaBA5bNZFEObCcUUscXgMdE/8j8Bo9K/lkmHLJ
 iob4U/tjtOUqfElWr40OUXPNCfSAXb0z71fuzdTLGXt0EkMfTdA0iwP9K++3xeivn5/O7NTnM
 ZNpVD+9nP+r0jZTxF9F4wi2yqAsn6Cml07HkWZh3qddold9ktLnW9U6YzfvZGTFypxgY6PMdx
 cuvI/RtJcuaqylUBhf4NG9nNJOHWFpd3+u3CfwCTZhlWCWRVNHKxtNojaFRo0WlQleYkw+pfp
 Eulp1jhuPE/Be+MuP7RtD0qymE+/94wfyOQ+PUg3EoQ9v5G3bs6t18N6UC3E4wtvmnV61E4iu
 Jvj7ltd5pdHcuzd/UpHLzK/hMUkz2mlCm9ZdzBS5PTFHylDrY3YrkaLlbYHfoNW1S93UxW7kE
 9QSlvsYmjYeqrSwK+ibJ2Q7CWXBVxt4lFwpJkg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Formatting of Kconfig files doesn't look so pretty, so let the
Great White Handkerchief come around and clean it up.

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 drivers/sbus/char/Kconfig | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/sbus/char/Kconfig b/drivers/sbus/char/Kconfig
index 89edd13..8fe4123 100644
--- a/drivers/sbus/char/Kconfig
+++ b/drivers/sbus/char/Kconfig
@@ -68,9 +68,8 @@ config ORACLE_DAX
 	depends on SPARC64
 	default m
 	help
-	 Driver for Oracle Data Analytics Accelerator, which is
-	 a coprocessor that performs database operations in hardware.
-	 It is available on M7 and M8 based systems only.
+	  Driver for Oracle Data Analytics Accelerator, which is
+	  a coprocessor that performs database operations in hardware.
+	  It is available on M7 and M8 based systems only.
 
 endmenu
-
-- 
1.9.1

