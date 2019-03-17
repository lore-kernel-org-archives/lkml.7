Return-Path: <SRS0=5V/v=RU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 121C5C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Mar 2019 07:44:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D93EB21738
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Mar 2019 07:44:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726842AbfCQHom (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Mar 2019 03:44:42 -0400
Received: from terminus.zytor.com ([198.137.202.136]:50435 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725903AbfCQHom (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Mar 2019 03:44:42 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x2H7h3Ie2403737
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sun, 17 Mar 2019 00:43:03 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x2H7h07N2403734;
        Sun, 17 Mar 2019 00:43:00 -0700
Date:   Sun, 17 Mar 2019 00:43:00 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for kbuild test robot <tipbot@zytor.com>
Message-ID: <tip-c634dc6bdedeb0b2c750fc611612618a85639ab2@git.kernel.org>
Cc:     jolsa@redhat.com, ak@linux.intel.com, lkp@intel.com,
        peterz@infradead.org, hpa@zytor.com, kan.liang@linux.intel.com,
        bp@alien8.de, tglx@linutronix.de, mingo@kernel.org,
        linux-kernel@vger.kernel.org
Reply-To: bp@alien8.de, kan.liang@linux.intel.com, tglx@linutronix.de,
          mingo@kernel.org, linux-kernel@vger.kernel.org,
          ak@linux.intel.com, lkp@intel.com, hpa@zytor.com,
          peterz@infradead.org, jolsa@redhat.com
In-Reply-To: <20190313184243.GA10820@lkp-sb-ep06>
References: <20190313184243.GA10820@lkp-sb-ep06>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf/x86/intel: Make
 dev_attr_allow_tsx_force_abort static
Git-Commit-ID: c634dc6bdedeb0b2c750fc611612618a85639ab2
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

Commit-ID:  c634dc6bdedeb0b2c750fc611612618a85639ab2
Gitweb:     https://git.kernel.org/tip/c634dc6bdedeb0b2c750fc611612618a85639ab2
Author:     kbuild test robot <lkp@intel.com>
AuthorDate: Thu, 14 Mar 2019 02:42:43 +0800
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Sun, 17 Mar 2019 08:40:18 +0100

perf/x86/intel: Make dev_attr_allow_tsx_force_abort static

Fixes: 400816f60c54 ("perf/x86/intel: Implement support for TSX Force Abort")
Signed-off-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>
Cc: kbuild-all@01.org
Cc: Borislav Petkov <bp@alien8.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: stable@vger.kernel.org
Link: https://lkml.kernel.org/r/20190313184243.GA10820@lkp-sb-ep06

---
 arch/x86/events/intel/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 92dfeb343a6a..8baa441d8000 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -4179,7 +4179,7 @@ static struct attribute *intel_pmu_caps_attrs[] = {
        NULL
 };
 
-DEVICE_BOOL_ATTR(allow_tsx_force_abort, 0644, allow_tsx_force_abort);
+static DEVICE_BOOL_ATTR(allow_tsx_force_abort, 0644, allow_tsx_force_abort);
 
 static struct attribute *intel_pmu_attrs[] = {
 	&dev_attr_freeze_on_smi.attr,
