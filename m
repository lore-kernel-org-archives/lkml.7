Return-Path: <SRS0=Ncac=VO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF47EC76186
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 12:33:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC3692173B
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 12:33:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726343AbfGQMd6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 08:33:58 -0400
Received: from foss.arm.com ([217.140.110.172]:46974 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725873AbfGQMd6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 08:33:58 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 93241337;
        Wed, 17 Jul 2019 05:33:57 -0700 (PDT)
Received: from dawn-kernel.cambridge.arm.com (unknown [10.1.197.116])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id BAA3B3F71F;
        Wed, 17 Jul 2019 05:33:56 -0700 (PDT)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     kvmarm@lists.cs.columbia.edu, will@kernel.org, maz@kernel.org,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: [PATCH] MAINTAINERS: Fix spelling mistake in my name
Date:   Wed, 17 Jul 2019 13:33:30 +0100
Message-Id: <20190717123330.7220-1-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix a typo in my name against in KVM-ARM reviewers.

Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
Will,

Please could you pick this one too ? There might be conflict with
the other updates.

---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index c144bd6a432e..ce5e40d91041 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8795,7 +8795,7 @@ KERNEL VIRTUAL MACHINE FOR ARM/ARM64 (KVM/arm, KVM/arm64)
 M:	Marc Zyngier <marc.zyngier@arm.com>
 R:	James Morse <james.morse@arm.com>
 R:	Julien Thierry <julien.thierry@arm.com>
-R:	Suzuki K Pouloze <suzuki.poulose@arm.com>
+R:	Suzuki K Poulose <suzuki.poulose@arm.com>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 L:	kvmarm@lists.cs.columbia.edu
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/kvmarm/kvmarm.git
-- 
2.21.0

