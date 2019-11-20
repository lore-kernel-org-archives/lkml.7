Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BB80C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 13:59:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E84CD2235D
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 13:59:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574258348;
	bh=8UW0uf40Vitk2fewWHuQdpiL9jQwLWLDb3hfLQSTEmo=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=iwoIu6DD3x6WWe/oqF6Yzfrtk8jXaO8h5T2pqu8lLAFtfa6PaKu9UN4JfvsLg26Yf
	 YRJswqaN9HUUUkYlYker0FaJ//BsdJIWrePkojRiR/3BLPNFIDFcYfiXb4i3TPcm+t
	 IEH186Dl8f19Ab6/8wknFo2uU+JvPpEz4hgExPk0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731412AbfKTN7H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 08:59:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:58660 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727988AbfKTN7G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 08:59:06 -0500
Received: from localhost.localdomain (unknown [118.189.143.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 44421218BA;
        Wed, 20 Nov 2019 13:59:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574258345;
        bh=8UW0uf40Vitk2fewWHuQdpiL9jQwLWLDb3hfLQSTEmo=;
        h=From:To:Cc:Subject:Date:From;
        b=l6/62XnPxzx4tV6G/dj+1lnj36toXAhBQC8mkn9bhASOceuqR0D8jbt40kikiO/HG
         NiuhftvbtPmfehkcRth4wlUSmswKhY8N748R2JY9scV/GFRdOFgEeblPJwfDskXZgO
         1kIkd1PWwy71Ko8zjV+98vxBRiT3erDzBfwXbc7M=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Jiri Kosina <trivial@kernel.org>, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [RESEND PATCH] samples: Fix Kconfig indentation
Date:   Wed, 20 Nov 2019 21:58:59 +0800
Message-Id: <20191120135859.18753-1-krzk@kernel.org>
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

