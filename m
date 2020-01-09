Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 184FDC33CA2
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 12:17:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8FA82067D
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 12:17:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b="OzKMvUKH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730855AbgAIMRa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 07:17:30 -0500
Received: from mout02.posteo.de ([185.67.36.66]:53923 "EHLO mout02.posteo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728974AbgAIMRa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 07:17:30 -0500
Received: from submission (posteo.de [89.146.220.130]) 
        by mout02.posteo.de (Postfix) with ESMTPS id 3428E240100
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jan 2020 13:17:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.de; s=2017;
        t=1578572248; bh=a/CFMKZd5EKbE2w3uLeWxRa2LN6InqDmBM5OcZ4GtjM=;
        h=From:To:Cc:Subject:Date:From;
        b=OzKMvUKHtoVecQwMMFo6iijLbY98whrMSFqegtI9mh8ET4RkUih4HPdgSS0xqtI4D
         N2Wima9eiE2mBrEVre9nEYfVot5pn+YPLAwPPlBJ+CtGx6PUWE6OfuMB2E5xS2C+P+
         HkOSni1AfnYnlMm9axOWXDqSwbKii8hzDTBLJurx+V1PtzG5NTDX7kuR+PXZRf/Pz6
         PuAPnHl5+5J9/Al2ZBPdw4ByMbUR3Vfb9XCCWHQe8vTJJhgRVgSyUUFhJrQkVzi3oO
         90orb00SuO3KVaEjYvyzUfOdr82EeSoBc0zzYIVvGNFYuO8VJCOAtO18gw3uW6GhuH
         OVyXHh5Cyd37A==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 47tlVb53nPz9rxD;
        Thu,  9 Jan 2020 13:17:27 +0100 (CET)
From:   Benjamin Thiel <b.thiel@posteo.de>
To:     bp@alien8.de
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Benjamin Thiel <b.thiel@posteo.de>
Subject: [PATCH] x86/cpu: Add a missing prototype for arch_smt_update()
Date:   Thu,  9 Jan 2020 13:17:23 +0100
Message-Id: <20200109121723.8151-1-b.thiel@posteo.de>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

.. in order to fix a -Wmissing-prototype warning.

No functional change.

Signed-off-by: Benjamin Thiel <b.thiel@posteo.de>
---
 arch/x86/kernel/cpu/common.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 2e4d90294fe6..6b95f18255fa 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -14,6 +14,7 @@
 #include <linux/sched/mm.h>
 #include <linux/sched/clock.h>
 #include <linux/sched/task.h>
+#include <linux/sched/smt.h>
 #include <linux/init.h>
 #include <linux/kprobes.h>
 #include <linux/kgdb.h>
-- 
2.17.1

