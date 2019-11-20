Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 642ADC432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 13:38:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AC4322529
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 13:38:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574257081;
	bh=8UW0uf40Vitk2fewWHuQdpiL9jQwLWLDb3hfLQSTEmo=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=pOhQX8EYbfW400XJqbTz4ATUfDg4XmZPgDH2/LKkFj0SgVF27/EbF7dcBMo1q46S8
	 PPmuNWkm4zvq2uv1IvBAhraZ7P5WwxSCY6bMwAzQiHrGwjpRuZTuLE24MvdXPScYMB
	 hp+noMSlhkUJN2XMHURTzn5DmSxUF4Lbrh3A/Ja8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730967AbfKTNiA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 08:38:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:45088 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729783AbfKTNh7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 08:37:59 -0500
Received: from localhost.localdomain (unknown [118.189.143.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D6EAF22529;
        Wed, 20 Nov 2019 13:37:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574257078;
        bh=8UW0uf40Vitk2fewWHuQdpiL9jQwLWLDb3hfLQSTEmo=;
        h=From:To:Cc:Subject:Date:From;
        b=0AEWd2CQRp2opXIKCFfA/PpGZISt14Jlg5XaPGsHgSrCCjbv5LtW4zpLo8slh/pit
         gBhXR1oDyMtg1LJ6NFdV69VAQDfKuOY3WwlSBOVyUo9moiusFhbLdm8CFR7KeUovJK
         kAPrYHp4E7ysR3rUEJSduVU0lLd6+C86D0VQIqzw=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH] samples: Fix Kconfig indentation
Date:   Wed, 20 Nov 2019 21:37:55 +0800
Message-Id: <20191120133755.12574-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adjust indentation from spaces to tab (+optional two spaces) as in
coding style with command like:
	$ sed -e 's/^        /\t/' -i */Kconfig

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 samples/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/samples/Kconfig b/samples/Kconfig
index c7015c239884..88c6586ccc10 100644
--- a/samples/Kconfig
+++ b/samples/Kconfig
@@ -13,7 +13,7 @@ config SAMPLE_TRACE_EVENTS
 	  This build trace event example modules.
 
 config SAMPLE_TRACE_PRINTK
-        tristate "Build trace_printk module - tests various trace_printk formats"
+	tristate "Build trace_printk module - tests various trace_printk formats"
 	depends on EVENT_TRACING && m
 	help
 	 This builds a module that calls trace_printk() and can be used to
-- 
2.17.1

