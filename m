Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0B16C4321A
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 23:41:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92582208E3
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 23:41:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="hSAi2vDJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726686AbfF0Xli (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 19:41:38 -0400
Received: from terminus.zytor.com ([198.137.202.136]:59233 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726567AbfF0Xli (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 19:41:38 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5RNcLFh499829
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 27 Jun 2019 16:38:21 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5RNcLFh499829
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1561678702;
        bh=BxmF73YzvbBY3dwzGpz/7ke1kcNU3bQb9Zt5QKmAw2o=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=hSAi2vDJJ8esjmD2ky+UetkxbWqx4QVfjqm18C/r1NsLaxXd63g7T2kJdegNUic5x
         3yNF+T4V/qE46WaRCP6cpTlOKZm5GJL1hMdv2hkYd4Cy81rEKQCTkL/DeZj/B3Bw3s
         uxyiSb39Go+HC+vAoXuKsuGaJzbET7Nec1CCPhVv2yUSpc4q+va3UNCtr/7ZhOg6ws
         k2MQabEpI7tOV0Jbjixc+4LG6gowxJ1cbhK91vwpclDSh43G3Ev2Hs3wNsR0/QZGUK
         3vNUKXsE7a+O+q3vp4iw4nXQ/X+6wF4C3I/khSITAH1wY79xvdU0lRXy+cIHd+Mwrk
         iGSCIJzIGscGQ==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5RNcKuA499824;
        Thu, 27 Jun 2019 16:38:20 -0700
Date:   Thu, 27 Jun 2019 16:38:20 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Thomas Gleixner <tipbot@zytor.com>
Message-ID: <tip-433526cc0502ff13d9b2fd63ba546a202dac0463@git.kernel.org>
Cc:     ravi.v.shankar@intel.com, mingo@kernel.org, eranian@google.com,
        andi.kleen@intel.com, tglx@linutronix.de,
        ricardo.neri-calderon@linux.intel.com,
        linux-kernel@vger.kernel.org, hpa@zytor.com,
        Suravee.Suthikulpanit@amd.com, peterz@infradead.org,
        ashok.raj@intel.com
Reply-To: mingo@kernel.org, ravi.v.shankar@intel.com, eranian@google.com,
          tglx@linutronix.de, andi.kleen@intel.com,
          linux-kernel@vger.kernel.org,
          ricardo.neri-calderon@linux.intel.com, peterz@infradead.org,
          Suravee.Suthikulpanit@amd.com, hpa@zytor.com, ashok.raj@intel.com
In-Reply-To: <20190623132434.645357869@linutronix.de>
References: <20190623132434.645357869@linutronix.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/timers] x86/hpet: Mark init functions __init
Git-Commit-ID: 433526cc0502ff13d9b2fd63ba546a202dac0463
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  433526cc0502ff13d9b2fd63ba546a202dac0463
Gitweb:     https://git.kernel.org/tip/433526cc0502ff13d9b2fd63ba546a202dac0463
Author:     Thomas Gleixner <tglx@linutronix.de>
AuthorDate: Sun, 23 Jun 2019 15:23:47 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Fri, 28 Jun 2019 00:57:17 +0200

x86/hpet: Mark init functions __init

They are only called from init code.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Ingo Molnar <mingo@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Cc: Ashok Raj <ashok.raj@intel.com>
Cc: Andi Kleen <andi.kleen@intel.com>
Cc: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
Cc: Stephane Eranian <eranian@google.com>
Cc: Ravi Shankar <ravi.v.shankar@intel.com>
Link: https://lkml.kernel.org/r/20190623132434.645357869@linutronix.de

---
 arch/x86/kernel/hpet.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/hpet.c b/arch/x86/kernel/hpet.c
index 69cd0829f432..638aaff39819 100644
--- a/arch/x86/kernel/hpet.c
+++ b/arch/x86/kernel/hpet.c
@@ -176,7 +176,7 @@ do {								\
 
 static void hpet_reserve_msi_timers(struct hpet_data *hd);
 
-static void hpet_reserve_platform_timers(unsigned int id)
+static void __init hpet_reserve_platform_timers(unsigned int id)
 {
 	struct hpet __iomem *hpet = hpet_virt_address;
 	struct hpet_timer __iomem *timer = &hpet->hpet_timers[2];
@@ -572,7 +572,7 @@ static void init_one_hpet_msi_clockevent(struct hpet_dev *hdev, int cpu)
 #define RESERVE_TIMERS 0
 #endif
 
-static void hpet_msi_capability_lookup(unsigned int start_timer)
+static void __init hpet_msi_capability_lookup(unsigned int start_timer)
 {
 	unsigned int id;
 	unsigned int num_timers;
@@ -631,7 +631,7 @@ static void hpet_msi_capability_lookup(unsigned int start_timer)
 }
 
 #ifdef CONFIG_HPET
-static void hpet_reserve_msi_timers(struct hpet_data *hd)
+static void __init hpet_reserve_msi_timers(struct hpet_data *hd)
 {
 	int i;
 
