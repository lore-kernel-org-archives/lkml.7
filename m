Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2FA7C04AB5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 13:31:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6A9127DC1
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 13:31:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="yUGz4cr5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728722AbfFCNbY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 09:31:24 -0400
Received: from terminus.zytor.com ([198.137.202.136]:57119 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726842AbfFCNbY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 09:31:24 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x53DVDhL610157
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 3 Jun 2019 06:31:13 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x53DVDhL610157
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019051801; t=1559568673;
        bh=A90KpaUzz/Tuu8TgyE2FWyUHZCimw1SzVYqCH4t10uU=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=yUGz4cr5laiZN8eRJF4NKXpvbK5TC3Tm2bMdlDvnGuYHnyyqXq9/kVCUj+6bKCWfJ
         0l55r7iBS0OJT1CjCN3V0VxRP0vXQEqrd6f/rujsJR8NAFm7bsNcxzdB+OPR9nK5e5
         evTjrePKDVxYhFXP3Zvrbp7j2OiVlU1NSZ17ihuMbSV4Qt6BW2/ehoEmG0yEpelki0
         lGTTe4UabfSxZxI4KZq+RfonbCuEdUay1XiVCABeLI+I68heiD9Wtnd3E1v+jNGvLg
         QRodn4VnzlDKDaKlMJzBGZjRHGB+jTyCU3o2C+vbxwrI372iqEp7cMqW/fVEr05grn
         JRDDvyX+iP8bQ==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x53DVCZF610153;
        Mon, 3 Jun 2019 06:31:12 -0700
Date:   Mon, 3 Jun 2019 06:31:12 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jiri Olsa <tipbot@zytor.com>
Message-ID: <tip-6a9f4efe78af6069a11946c64d3d4c86cb42046b@git.kernel.org>
Cc:     alexander.shishkin@linux.intel.com, hpa@zytor.com, acme@kernel.org,
        peterz@infradead.org, tglx@linutronix.de,
        gregkh@linuxfoundation.org, namhyung@kernel.org, jolsa@kernel.org,
        mingo@kernel.org, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org
Reply-To: jolsa@kernel.org, acme@kernel.org,
          alexander.shishkin@linux.intel.com, namhyung@kernel.org,
          hpa@zytor.com, peterz@infradead.org,
          linux-kernel@vger.kernel.org, mingo@kernel.org,
          tglx@linutronix.de, torvalds@linux-foundation.org,
          gregkh@linuxfoundation.org
In-Reply-To: <20190512155518.21468-10-jolsa@kernel.org>
References: <20190512155518.21468-10-jolsa@kernel.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf/x86: Use update attribute groups for default
 attributes
Git-Commit-ID: 6a9f4efe78af6069a11946c64d3d4c86cb42046b
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

Commit-ID:  6a9f4efe78af6069a11946c64d3d4c86cb42046b
Gitweb:     https://git.kernel.org/tip/6a9f4efe78af6069a11946c64d3d4c86cb42046b
Author:     Jiri Olsa <jolsa@kernel.org>
AuthorDate: Sun, 12 May 2019 17:55:18 +0200
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 3 Jun 2019 11:58:27 +0200

perf/x86: Use update attribute groups for default attributes

Using the new pmu::update_attrs attribute group for default
attributes - freeze_on_smi, allow_tsx_force_abort.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/20190512155518.21468-10-jolsa@kernel.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/events/core.c       | 34 ----------------------------------
 arch/x86/events/intel/core.c |  9 +++++----
 arch/x86/events/perf_event.h |  3 ---
 3 files changed, 5 insertions(+), 41 deletions(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index dd0996ba75c3..f0e4804515d8 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -1618,32 +1618,6 @@ static struct attribute_group x86_pmu_format_group __ro_after_init = {
 	.attrs = NULL,
 };
 
-/* Merge two pointer arrays */
-__init struct attribute **merge_attr(struct attribute **a, struct attribute **b)
-{
-	struct attribute **new;
-	int j, i;
-
-	for (j = 0; a && a[j]; j++)
-		;
-	for (i = 0; b && b[i]; i++)
-		j++;
-	j++;
-
-	new = kmalloc_array(j, sizeof(struct attribute *), GFP_KERNEL);
-	if (!new)
-		return NULL;
-
-	j = 0;
-	for (i = 0; a && a[i]; i++)
-		new[j++] = a[i];
-	for (i = 0; b && b[i]; i++)
-		new[j++] = b[i];
-	new[j] = NULL;
-
-	return new;
-}
-
 ssize_t events_sysfs_show(struct device *dev, struct device_attribute *attr, char *page)
 {
 	struct perf_pmu_events_attr *pmu_attr = \
@@ -1824,14 +1798,6 @@ static int __init init_hw_perf_events(void)
 	if (!x86_pmu.events_sysfs_show)
 		x86_pmu_events_group.attrs = &empty_attrs;
 
-	if (x86_pmu.attrs) {
-		struct attribute **tmp;
-
-		tmp = merge_attr(x86_pmu_attr_group.attrs, x86_pmu.attrs);
-		if (!WARN_ON(!tmp))
-			x86_pmu_attr_group.attrs = tmp;
-	}
-
 	pmu.attr_update = x86_pmu.attr_update;
 
 	pr_info("... version:                %d\n",     x86_pmu.version);
diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 3bc967be7c7b..71001f005bfe 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -3897,8 +3897,6 @@ static __initconst const struct x86_pmu core_pmu = {
 	.check_period		= intel_pmu_check_period,
 };
 
-static struct attribute *intel_pmu_attrs[];
-
 static __initconst const struct x86_pmu intel_pmu = {
 	.name			= "Intel",
 	.handle_irq		= intel_pmu_handle_irq,
@@ -3930,8 +3928,6 @@ static __initconst const struct x86_pmu intel_pmu = {
 	.format_attrs		= intel_arch3_formats_attr,
 	.events_sysfs_show	= intel_event_sysfs_show,
 
-	.attrs			= intel_pmu_attrs,
-
 	.cpu_prepare		= intel_pmu_cpu_prepare,
 	.cpu_starting		= intel_pmu_cpu_starting,
 	.cpu_dying		= intel_pmu_cpu_dying,
@@ -4458,6 +4454,10 @@ static struct attribute_group group_format_extra_skl = {
 	.is_visible = exra_is_visible,
 };
 
+static struct attribute_group group_default = {
+	.attrs = intel_pmu_attrs,
+};
+
 static const struct attribute_group *attr_update[] = {
 	&group_events_td,
 	&group_events_mem,
@@ -4466,6 +4466,7 @@ static const struct attribute_group *attr_update[] = {
 	&group_caps_lbr,
 	&group_format_extra,
 	&group_format_extra_skl,
+	&group_default,
 	NULL,
 };
 
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index 1da9b6f0b279..9bcec3f99e4a 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -636,7 +636,6 @@ struct x86_pmu {
 	const struct attribute_group **attr_update;
 
 	unsigned long	attr_freeze_on_smi;
-	struct attribute **attrs;
 
 	/*
 	 * CPU Hotplug hooks
@@ -903,8 +902,6 @@ static inline void set_linear_ip(struct pt_regs *regs, unsigned long ip)
 ssize_t x86_event_sysfs_show(char *page, u64 config, u64 event);
 ssize_t intel_event_sysfs_show(char *page, u64 config);
 
-struct attribute **merge_attr(struct attribute **a, struct attribute **b);
-
 ssize_t events_sysfs_show(struct device *dev, struct device_attribute *attr,
 			  char *page);
 ssize_t events_ht_sysfs_show(struct device *dev, struct device_attribute *attr,
