Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B8C4C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 20:39:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD5D8218A6
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 20:39:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730243AbfC2UjW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 16:39:22 -0400
Received: from terminus.zytor.com ([198.137.202.136]:47151 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730224AbfC2UjW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 16:39:22 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x2TKdDsN3938299
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Fri, 29 Mar 2019 13:39:14 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x2TKdCCh3938295;
        Fri, 29 Mar 2019 13:39:12 -0700
Date:   Fri, 29 Mar 2019 13:39:12 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-h6bspm1nomjnpr90333rrx7q@git.kernel.org>
Cc:     tglx@linutronix.de, acme@redhat.com, hpa@zytor.com,
        jolsa@kernel.org, mingo@kernel.org, adrian.hunter@intel.com,
        namhyung@kernel.org, linux-kernel@vger.kernel.org,
        tvrtko.ursulin@intel.com
Reply-To: linux-kernel@vger.kernel.org, namhyung@kernel.org,
          tvrtko.ursulin@intel.com, hpa@zytor.com, tglx@linutronix.de,
          acme@redhat.com, jolsa@kernel.org, mingo@kernel.org,
          adrian.hunter@intel.com
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] tools headers uapi: Update drm/i915_drm.h
Git-Commit-ID: 82392516e9e0818cd2227cf9a16205c90a6cacfa
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

Commit-ID:  82392516e9e0818cd2227cf9a16205c90a6cacfa
Gitweb:     https://git.kernel.org/tip/82392516e9e0818cd2227cf9a16205c90a6cacfa
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Mon, 25 Mar 2019 14:28:20 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Thu, 28 Mar 2019 14:31:56 -0300

tools headers uapi: Update drm/i915_drm.h

To get the changes in:

  e46c2e99f600 ("drm/i915: Expose RPCS (SSEU) configuration to userspace (Gen11 only)")

That don't cause changes in the generated perf binaries.

To silence this perf build warning:

  Warning: Kernel ABI header at 'tools/include/uapi/drm/i915_drm.h' differs from latest version at 'include/uapi/drm/i915_drm.h'
  diff -u tools/include/uapi/drm/i915_drm.h include/uapi/drm/i915_drm.h

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Tvrtko Ursulin <tvrtko.ursulin@intel.com>
Link: https://lkml.kernel.org/n/tip-h6bspm1nomjnpr90333rrx7q@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/include/uapi/drm/i915_drm.h | 64 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 64 insertions(+)

diff --git a/tools/include/uapi/drm/i915_drm.h b/tools/include/uapi/drm/i915_drm.h
index 298b2e197744..397810fa2d33 100644
--- a/tools/include/uapi/drm/i915_drm.h
+++ b/tools/include/uapi/drm/i915_drm.h
@@ -1486,9 +1486,73 @@ struct drm_i915_gem_context_param {
 #define   I915_CONTEXT_MAX_USER_PRIORITY	1023 /* inclusive */
 #define   I915_CONTEXT_DEFAULT_PRIORITY		0
 #define   I915_CONTEXT_MIN_USER_PRIORITY	-1023 /* inclusive */
+	/*
+	 * When using the following param, value should be a pointer to
+	 * drm_i915_gem_context_param_sseu.
+	 */
+#define I915_CONTEXT_PARAM_SSEU		0x7
 	__u64 value;
 };
 
+/**
+ * Context SSEU programming
+ *
+ * It may be necessary for either functional or performance reason to configure
+ * a context to run with a reduced number of SSEU (where SSEU stands for Slice/
+ * Sub-slice/EU).
+ *
+ * This is done by configuring SSEU configuration using the below
+ * @struct drm_i915_gem_context_param_sseu for every supported engine which
+ * userspace intends to use.
+ *
+ * Not all GPUs or engines support this functionality in which case an error
+ * code -ENODEV will be returned.
+ *
+ * Also, flexibility of possible SSEU configuration permutations varies between
+ * GPU generations and software imposed limitations. Requesting such a
+ * combination will return an error code of -EINVAL.
+ *
+ * NOTE: When perf/OA is active the context's SSEU configuration is ignored in
+ * favour of a single global setting.
+ */
+struct drm_i915_gem_context_param_sseu {
+	/*
+	 * Engine class & instance to be configured or queried.
+	 */
+	__u16 engine_class;
+	__u16 engine_instance;
+
+	/*
+	 * Unused for now. Must be cleared to zero.
+	 */
+	__u32 flags;
+
+	/*
+	 * Mask of slices to enable for the context. Valid values are a subset
+	 * of the bitmask value returned for I915_PARAM_SLICE_MASK.
+	 */
+	__u64 slice_mask;
+
+	/*
+	 * Mask of subslices to enable for the context. Valid values are a
+	 * subset of the bitmask value return by I915_PARAM_SUBSLICE_MASK.
+	 */
+	__u64 subslice_mask;
+
+	/*
+	 * Minimum/Maximum number of EUs to enable per subslice for the
+	 * context. min_eus_per_subslice must be inferior or equal to
+	 * max_eus_per_subslice.
+	 */
+	__u16 min_eus_per_subslice;
+	__u16 max_eus_per_subslice;
+
+	/*
+	 * Unused for now. Must be cleared to zero.
+	 */
+	__u32 rsvd;
+};
+
 enum drm_i915_oa_format {
 	I915_OA_FORMAT_A13 = 1,	    /* HSW only */
 	I915_OA_FORMAT_A29,	    /* HSW only */
