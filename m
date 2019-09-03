Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19CD7C3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 08:31:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB982217D7
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 08:31:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728162AbfICIbf convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 04:31:35 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:59136 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725888AbfICIbd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 04:31:33 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1i54Dg-0002d5-H2; Tue, 03 Sep 2019 10:31:20 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id EB1BB1C0772;
        Tue,  3 Sep 2019 10:31:19 +0200 (CEST)
Date:   Tue, 03 Sep 2019 08:31:19 -0000
From:   tip-bot2 for Valdis =?utf-8?q?Kl=C4=93tnieks?= 
        <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86: Make more stuff static
Cc:     Valdis Kletnieks <valdis.kletnieks@vt.edu>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <128059.1565286242@turing-police>
References: <128059.1565286242@turing-police>
MIME-Version: 1.0
Message-ID: <156749947971.12812.17483180496809148360.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     d9f3b450f206332b7ef3d78b5a85b6c20ad00fd2
Gitweb:        https://git.kernel.org/tip/d9f3b450f206332b7ef3d78b5a85b6c20ad00fd2
Author:        Valdis Klētnieks <valdis.kletnieks@vt.edu>
AuthorDate:    Thu, 08 Aug 2019 13:44:02 -04:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 03 Sep 2019 09:22:32 +02:00

perf/x86: Make more stuff static

When building with C=2, sparse makes note of a number of things:

  arch/x86/events/intel/rapl.c:637:30: warning: symbol 'rapl_attr_update' was not declared. Should it be static?
  arch/x86/events/intel/cstate.c:449:30: warning: symbol 'core_attr_update' was not declared. Should it be static?
  arch/x86/events/intel/cstate.c:457:30: warning: symbol 'pkg_attr_update' was not declared. Should it be static?
  arch/x86/events/msr.c:170:30: warning: symbol 'attr_update' was not declared. Should it be static?
  arch/x86/events/intel/lbr.c:276:1: warning: symbol 'lbr_from_quirk_key' was not declared. Should it be static?

And they can all indeed be static.

Signed-off-by: Valdis Kletnieks <valdis.kletnieks@vt.edu>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/128059.1565286242@turing-police
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/events/intel/cstate.c | 4 ++--
 arch/x86/events/intel/lbr.c    | 2 +-
 arch/x86/events/intel/rapl.c   | 2 +-
 arch/x86/events/msr.c          | 2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/x86/events/intel/cstate.c b/arch/x86/events/intel/cstate.c
index 688592b..db498b5 100644
--- a/arch/x86/events/intel/cstate.c
+++ b/arch/x86/events/intel/cstate.c
@@ -446,7 +446,7 @@ static int cstate_cpu_init(unsigned int cpu)
 	return 0;
 }
 
-const struct attribute_group *core_attr_update[] = {
+static const struct attribute_group *core_attr_update[] = {
 	&group_cstate_core_c1,
 	&group_cstate_core_c3,
 	&group_cstate_core_c6,
@@ -454,7 +454,7 @@ const struct attribute_group *core_attr_update[] = {
 	NULL,
 };
 
-const struct attribute_group *pkg_attr_update[] = {
+static const struct attribute_group *pkg_attr_update[] = {
 	&group_cstate_pkg_c2,
 	&group_cstate_pkg_c3,
 	&group_cstate_pkg_c6,
diff --git a/arch/x86/events/intel/lbr.c b/arch/x86/events/intel/lbr.c
index 6f814a2..ea54634 100644
--- a/arch/x86/events/intel/lbr.c
+++ b/arch/x86/events/intel/lbr.c
@@ -273,7 +273,7 @@ static inline bool lbr_from_signext_quirk_needed(void)
 	return !tsx_support && (lbr_desc[lbr_format] & LBR_TSX);
 }
 
-DEFINE_STATIC_KEY_FALSE(lbr_from_quirk_key);
+static DEFINE_STATIC_KEY_FALSE(lbr_from_quirk_key);
 
 /* If quirk is enabled, ensure sign extension is 63 bits: */
 inline u64 lbr_from_signext_quirk_wr(u64 val)
diff --git a/arch/x86/events/intel/rapl.c b/arch/x86/events/intel/rapl.c
index 64ab51f..f34b949 100644
--- a/arch/x86/events/intel/rapl.c
+++ b/arch/x86/events/intel/rapl.c
@@ -634,7 +634,7 @@ static void cleanup_rapl_pmus(void)
 	kfree(rapl_pmus);
 }
 
-const struct attribute_group *rapl_attr_update[] = {
+static const struct attribute_group *rapl_attr_update[] = {
 	&rapl_events_cores_group,
 	&rapl_events_pkg_group,
 	&rapl_events_ram_group,
diff --git a/arch/x86/events/msr.c b/arch/x86/events/msr.c
index 9431447..5812e87 100644
--- a/arch/x86/events/msr.c
+++ b/arch/x86/events/msr.c
@@ -167,7 +167,7 @@ static const struct attribute_group *attr_groups[] = {
 	NULL,
 };
 
-const struct attribute_group *attr_update[] = {
+static const struct attribute_group *attr_update[] = {
 	&group_aperf,
 	&group_mperf,
 	&group_pperf,
