Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C398C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 13:38:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EA4C21850
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 13:38:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553866720;
	bh=O99lNlLChUiaFZjV5DEHRhpx9lasRD64riKH/+5bGM8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=rnCh3HfzyoUziqmQk2EckeslYArn/06KWrmGYYizTovsYXputw0kNxFR4Xf4dSGO2
	 SAoSzRXa8TOwVUMODZeA5tZvxlH2G9VwY53eFXL3lX9UMUlxHflCtHSlIZB33f3Jb0
	 5NqmgPRMG7/W+2xdViI3XQqqJQz6UVGv1esMVaWg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729821AbfC2Nii (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 09:38:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:33900 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729809AbfC2Nif (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 09:38:35 -0400
Received: from quaco.ghostprotocols.net (unknown [190.15.121.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4B6BA2184E;
        Fri, 29 Mar 2019 13:38:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553866714;
        bh=O99lNlLChUiaFZjV5DEHRhpx9lasRD64riKH/+5bGM8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VOa59KnLF2nbpi0edmsSOnQIUs+OtJzegP1I85/Kfay3cqZ1225FpEXus+EnhJTuO
         IHNajMsZKjo+fejaeWq8/dny/usyTtb51S3xt68RIpwlcVUzGuCDXip+z1QnWmO0gV
         B4lYGvC5k7IN9vu0mcDgSXqEVbNcF4nnGf2eb9G4=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@intel.com>
Subject: [PATCH 07/13] tools headers uapi: Update drm/i915_drm.h
Date:   Fri, 29 Mar 2019 10:37:55 -0300
Message-Id: <20190329133801.21004-8-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190329133801.21004-1-acme@kernel.org>
References: <20190329133801.21004-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

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
 tools/include/uapi/drm/i915_drm.h | 64 +++++++++++++++++++++++++++++++
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
-- 
2.20.1

