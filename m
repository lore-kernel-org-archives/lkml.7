Return-Path: <SRS0=avfD=SQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A6F8C10F13
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 20:44:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A02F20684
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 20:44:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727339AbfDNUoN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Apr 2019 16:44:13 -0400
Received: from terminus.zytor.com ([198.137.202.136]:52465 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726127AbfDNUoM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Apr 2019 16:44:12 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x3EKha6a2690129
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sun, 14 Apr 2019 13:43:37 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x3EKhZlv2690126;
        Sun, 14 Apr 2019 13:43:35 -0700
Date:   Sun, 14 Apr 2019 13:43:35 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Thomas Gleixner <tipbot@zytor.com>
Message-ID: <tip-fa49e2eac9aa8259e1ea540d1bd301448d5b735d@git.kernel.org>
Cc:     rostedt@goodmis.org, linux-kernel@vger.kernel.org,
        peterz@infradead.org, joonas.lahtinen@linux.intel.com,
        jani.nikula@linux.intel.com, daniel@ffwll.ch, tglx@linutronix.de,
        mingo@kernel.org, maarten.lankhorst@linux.intel.com,
        jpoimboe@redhat.com, rodrigo.vivi@intel.com, glider@google.com,
        airlied@linux.ie, luto@kernel.org, hpa@zytor.com
Reply-To: luto@kernel.org, hpa@zytor.com, airlied@linux.ie,
          glider@google.com, rodrigo.vivi@intel.com,
          maarten.lankhorst@linux.intel.com, jpoimboe@redhat.com,
          daniel@ffwll.ch, tglx@linutronix.de, jani.nikula@linux.intel.com,
          joonas.lahtinen@linux.intel.com, linux-kernel@vger.kernel.org,
          rostedt@goodmis.org, peterz@infradead.org, mingo@kernel.org
In-Reply-To: <20190410103644.945059666@linutronix.de>
References: <20190410103644.945059666@linutronix.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:core/stacktrace] drm: Remove the ULONG_MAX stack trace hackery
Git-Commit-ID: fa49e2eac9aa8259e1ea540d1bd301448d5b735d
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

Commit-ID:  fa49e2eac9aa8259e1ea540d1bd301448d5b735d
Gitweb:     https://git.kernel.org/tip/fa49e2eac9aa8259e1ea540d1bd301448d5b735d
Author:     Thomas Gleixner <tglx@linutronix.de>
AuthorDate: Wed, 10 Apr 2019 12:28:09 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Sun, 14 Apr 2019 19:58:32 +0200

drm: Remove the ULONG_MAX stack trace hackery

No architecture terminates the stack trace with ULONG_MAX anymore. Remove
the cruft.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Alexander Potapenko <glider@google.com>
Cc: intel-gfx@lists.freedesktop.org
Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: dri-devel@lists.freedesktop.org
Cc: David Airlie <airlied@linux.ie>
Cc: Jani Nikula <jani.nikula@linux.intel.com>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
Link: https://lkml.kernel.org/r/20190410103644.945059666@linutronix.de

---
 drivers/gpu/drm/drm_mm.c                | 3 ---
 drivers/gpu/drm/i915/intel_runtime_pm.c | 4 ----
 2 files changed, 7 deletions(-)

diff --git a/drivers/gpu/drm/drm_mm.c b/drivers/gpu/drm/drm_mm.c
index 2b4f373736c7..69552777e13a 100644
--- a/drivers/gpu/drm/drm_mm.c
+++ b/drivers/gpu/drm/drm_mm.c
@@ -113,9 +113,6 @@ static noinline void save_stack(struct drm_mm_node *node)
 	};
 
 	save_stack_trace(&trace);
-	if (trace.nr_entries != 0 &&
-	    trace.entries[trace.nr_entries-1] == ULONG_MAX)
-		trace.nr_entries--;
 
 	/* May be called under spinlock, so avoid sleeping */
 	node->stack = depot_save_stack(&trace, GFP_NOWAIT);
diff --git a/drivers/gpu/drm/i915/intel_runtime_pm.c b/drivers/gpu/drm/i915/intel_runtime_pm.c
index a017a4232c0f..1f8acbb332c9 100644
--- a/drivers/gpu/drm/i915/intel_runtime_pm.c
+++ b/drivers/gpu/drm/i915/intel_runtime_pm.c
@@ -67,10 +67,6 @@ static noinline depot_stack_handle_t __save_depot_stack(void)
 	};
 
 	save_stack_trace(&trace);
-	if (trace.nr_entries &&
-	    trace.entries[trace.nr_entries - 1] == ULONG_MAX)
-		trace.nr_entries--;
-
 	return depot_save_stack(&trace, GFP_NOWAIT | __GFP_NOWARN);
 }
 
