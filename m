Return-Path: <SRS0=/uHP=YM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 541DECA9EAC
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Oct 2019 14:13:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3387721835
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Oct 2019 14:13:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726181AbfJSONV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 19 Oct 2019 10:13:21 -0400
Received: from mx2.suse.de ([195.135.220.15]:38876 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725911AbfJSONV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Oct 2019 10:13:21 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 2F10EB234;
        Sat, 19 Oct 2019 14:13:20 +0000 (UTC)
From:   =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>
To:     linux-realtek-soc@lists.infradead.org
Cc:     linux-arm-kernel@lists.infradead.org,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] MAINTAINERS: Add mailing list for Realtek SoCs
Date:   Sat, 19 Oct 2019 16:13:10 +0200
Message-Id: <20191019141310.26892-1-afaerber@suse.de>
X-Mailer: git-send-email 2.16.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document linux-realtek-soc mailing list to be CC'ed on patches.

Signed-off-by: Andreas Färber <afaerber@suse.de>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index c7b48525822a..8be71b3d25e7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2168,6 +2168,7 @@ F:	Documentation/devicetree/bindings/timer/rda,8810pl-timer.txt
 ARM/REALTEK ARCHITECTURE
 M:	Andreas Färber <afaerber@suse.de>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
+L:	linux-realtek-soc@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
 F:	arch/arm64/boot/dts/realtek/
 F:	Documentation/devicetree/bindings/arm/realtek.yaml
-- 
2.16.4

