Return-Path: <SRS0=bFUY=XM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC1A5C4CEC9
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 19:52:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9676420862
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 19:52:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726916AbfIQTwb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Sep 2019 15:52:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54838 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726081AbfIQTwb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 15:52:31 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 542A0301E11C;
        Tue, 17 Sep 2019 19:52:31 +0000 (UTC)
Received: from builder (ovpn-120-110.rdu2.redhat.com [10.10.120.110])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 317DD608A5;
        Tue, 17 Sep 2019 19:52:31 +0000 (UTC)
Received: from builder.jcline.org.com (localhost [IPv6:::1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by builder (Postfix) with ESMTPS id 4B2A9FA9663;
        Tue, 17 Sep 2019 19:52:30 +0000 (UTC)
From:   Jeremy Cline <jcline@redhat.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jeremy Cline <jcline@redhat.com>
Subject: [PATCH] arm64: Fix reference to docs for ARM64_TAGGED_ADDR_ABI
Date:   Tue, 17 Sep 2019 19:52:27 +0000
Message-Id: <20190917195227.9061-1-jcline@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.41]); Tue, 17 Sep 2019 19:52:31 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The referenced file does not exist, but tagged-address-abi.rst does.

Signed-off-by: Jeremy Cline <jcline@redhat.com>
---
 arch/arm64/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 6ae6ad8a4db0..8960310b4f64 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -1135,7 +1135,7 @@ config ARM64_TAGGED_ADDR_ABI
 	  When this option is enabled, user applications can opt in to a
 	  relaxed ABI via prctl() allowing tagged addresses to be passed
 	  to system calls as pointer arguments. For details, see
-	  Documentation/arm64/tagged-address-abi.txt.
+	  Documentation/arm64/tagged-address-abi.rst.
 
 menuconfig COMPAT
 	bool "Kernel support for 32-bit EL0"
-- 
2.21.0

