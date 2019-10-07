Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39F0EECE58C
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 17:34:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06DB8206BB
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 17:34:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570469642;
	bh=FT+MLA1ZIIX8wzSlmPb5TXiwbG6yez8RYzTLIv6rC7c=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=RcUKbKv7klLJJB3r/6VEJAQASqMPvdp3UQmayUIrIf7EjzLqats3NHiZs6/kESXyN
	 AUUt7nK1kBs1wyM6CgSktyaFlahCfmWdePMdTOkTsyHGlVmCMklCkil3MdKMrrmwOV
	 XTVA8Jb2x1v2hsg2K1ptU/IyW5sZc4/wKcizler0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728767AbfJGReA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 13:34:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:49392 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728028AbfJGReA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 13:34:00 -0400
Received: from localhost.localdomain (unknown [194.230.155.145])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9728B206BB;
        Mon,  7 Oct 2019 17:33:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570469638;
        bh=FT+MLA1ZIIX8wzSlmPb5TXiwbG6yez8RYzTLIv6rC7c=;
        h=From:To:Cc:Subject:Date:From;
        b=r0OEN3WU7Q3ZarmeWoLevv5a+93B7NdOU9TMRupipQw2pDKlvCkXHOFaYMrwIBzRv
         cjf020p1xQgq6D/qkoYurtv/dbvUsvD6Qdvv45imHRfguE6pRfyxgwoHvcLEDhyUkU
         0mkpxm/hb0WyBgWF1Uj5I961mCff+vJD9v0GZPVM=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH v3] drm/i915: Fix Kconfig indentation
Date:   Mon,  7 Oct 2019 19:33:46 +0200
Message-Id: <20191007173346.9379-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adjust indentation from spaces to tab (+optional two spaces) as in
coding style with command like:
    $ sed -e 's/^        /\t/' -i */Kconfig

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

---

Changes since v2:
1. Split AMD and i915 to separate patches.
---
 drivers/gpu/drm/i915/Kconfig       |  12 +--
 drivers/gpu/drm/i915/Kconfig.debug | 144 ++++++++++++++---------------
 2 files changed, 78 insertions(+), 78 deletions(-)

diff --git a/drivers/gpu/drm/i915/Kconfig b/drivers/gpu/drm/i915/Kconfig
index 0d21402945ab..3c6d57df262d 100644
--- a/drivers/gpu/drm/i915/Kconfig
+++ b/drivers/gpu/drm/i915/Kconfig
@@ -76,7 +76,7 @@ config DRM_I915_CAPTURE_ERROR
 	  This option enables capturing the GPU state when a hang is detected.
 	  This information is vital for triaging hangs and assists in debugging.
 	  Please report any hang to
-            https://bugs.freedesktop.org/enter_bug.cgi?product=DRI
+	    https://bugs.freedesktop.org/enter_bug.cgi?product=DRI
 	  for triaging.
 
 	  If in doubt, say "Y".
@@ -105,11 +105,11 @@ config DRM_I915_USERPTR
 	  If in doubt, say "Y".
 
 config DRM_I915_GVT
-        bool "Enable Intel GVT-g graphics virtualization host support"
-        depends on DRM_I915
-        depends on 64BIT
-        default n
-        help
+	bool "Enable Intel GVT-g graphics virtualization host support"
+	depends on DRM_I915
+	depends on 64BIT
+	default n
+	help
 	  Choose this option if you want to enable Intel GVT-g graphics
 	  virtualization technology host support with integrated graphics.
 	  With GVT-g, it's possible to have one integrated graphics
diff --git a/drivers/gpu/drm/i915/Kconfig.debug b/drivers/gpu/drm/i915/Kconfig.debug
index 00786a142ff0..eea79125b3ea 100644
--- a/drivers/gpu/drm/i915/Kconfig.debug
+++ b/drivers/gpu/drm/i915/Kconfig.debug
@@ -1,34 +1,34 @@
 # SPDX-License-Identifier: GPL-2.0-only
 config DRM_I915_WERROR
-        bool "Force GCC to throw an error instead of a warning when compiling"
-        # As this may inadvertently break the build, only allow the user
-        # to shoot oneself in the foot iff they aim really hard
-        depends on EXPERT
-        # We use the dependency on !COMPILE_TEST to not be enabled in
-        # allmodconfig or allyesconfig configurations
-        depends on !COMPILE_TEST
+	bool "Force GCC to throw an error instead of a warning when compiling"
+	# As this may inadvertently break the build, only allow the user
+	# to shoot oneself in the foot iff they aim really hard
+	depends on EXPERT
+	# We use the dependency on !COMPILE_TEST to not be enabled in
+	# allmodconfig or allyesconfig configurations
+	depends on !COMPILE_TEST
 	select HEADER_TEST
-        default n
-        help
-          Add -Werror to the build flags for (and only for) i915.ko.
-          Do not enable this unless you are writing code for the i915.ko module.
+	default n
+	help
+	  Add -Werror to the build flags for (and only for) i915.ko.
+	  Do not enable this unless you are writing code for the i915.ko module.
 
-          Recommended for driver developers only.
+	  Recommended for driver developers only.
 
-          If in doubt, say "N".
+	  If in doubt, say "N".
 
 config DRM_I915_DEBUG
-        bool "Enable additional driver debugging"
-        depends on DRM_I915
-        select DEBUG_FS
-        select PREEMPT_COUNT
-        select REFCOUNT_FULL
-        select I2C_CHARDEV
-        select STACKDEPOT
-        select DRM_DP_AUX_CHARDEV
-        select X86_MSR # used by igt/pm_rpm
-        select DRM_VGEM # used by igt/prime_vgem (dmabuf interop checks)
-        select DRM_DEBUG_MM if DRM=y
+	bool "Enable additional driver debugging"
+	depends on DRM_I915
+	select DEBUG_FS
+	select PREEMPT_COUNT
+	select REFCOUNT_FULL
+	select I2C_CHARDEV
+	select STACKDEPOT
+	select DRM_DP_AUX_CHARDEV
+	select X86_MSR # used by igt/pm_rpm
+	select DRM_VGEM # used by igt/prime_vgem (dmabuf interop checks)
+	select DRM_DEBUG_MM if DRM=y
 	select DRM_DEBUG_SELFTEST
 	select DMABUF_SELFTESTS
 	select SW_SYNC # signaling validation framework (igt/syncobj*)
@@ -36,14 +36,14 @@ config DRM_I915_DEBUG
 	select DRM_I915_SELFTEST
 	select DRM_I915_DEBUG_RUNTIME_PM
 	select DRM_I915_DEBUG_MMIO
-        default n
-        help
-          Choose this option to turn on extra driver debugging that may affect
-          performance but will catch some internal issues.
+	default n
+	help
+	  Choose this option to turn on extra driver debugging that may affect
+	  performance but will catch some internal issues.
 
-          Recommended for driver developers only.
+	  Recommended for driver developers only.
 
-          If in doubt, say "N".
+	  If in doubt, say "N".
 
 config DRM_I915_DEBUG_MMIO
 	bool "Always insert extra checks around mmio access by default"
@@ -59,16 +59,16 @@ config DRM_I915_DEBUG_MMIO
 	  If in doubt, say "N".
 
 config DRM_I915_DEBUG_GEM
-        bool "Insert extra checks into the GEM internals"
-        default n
-        depends on DRM_I915_WERROR
-        help
-          Enable extra sanity checks (including BUGs) along the GEM driver
-          paths that may slow the system down and if hit hang the machine.
+	bool "Insert extra checks into the GEM internals"
+	default n
+	depends on DRM_I915_WERROR
+	help
+	  Enable extra sanity checks (including BUGs) along the GEM driver
+	  paths that may slow the system down and if hit hang the machine.
 
-          Recommended for driver developers only.
+	  Recommended for driver developers only.
 
-          If in doubt, say "N".
+	  If in doubt, say "N".
 
 config DRM_I915_ERRLOG_GEM
 	bool "Insert extra logging (very verbose) for common GEM errors"
@@ -111,41 +111,41 @@ config DRM_I915_TRACE_GTT
 	  If in doubt, say "N".
 
 config DRM_I915_SW_FENCE_DEBUG_OBJECTS
-        bool "Enable additional driver debugging for fence objects"
-        depends on DRM_I915
-        select DEBUG_OBJECTS
-        default n
-        help
-          Choose this option to turn on extra driver debugging that may affect
-          performance but will catch some internal issues.
+	bool "Enable additional driver debugging for fence objects"
+	depends on DRM_I915
+	select DEBUG_OBJECTS
+	default n
+	help
+	  Choose this option to turn on extra driver debugging that may affect
+	  performance but will catch some internal issues.
 
-          Recommended for driver developers only.
+	  Recommended for driver developers only.
 
-          If in doubt, say "N".
+	  If in doubt, say "N".
 
 config DRM_I915_SW_FENCE_CHECK_DAG
-        bool "Enable additional driver debugging for detecting dependency cycles"
-        depends on DRM_I915
-        default n
-        help
-          Choose this option to turn on extra driver debugging that may affect
-          performance but will catch some internal issues.
+	bool "Enable additional driver debugging for detecting dependency cycles"
+	depends on DRM_I915
+	default n
+	help
+	  Choose this option to turn on extra driver debugging that may affect
+	  performance but will catch some internal issues.
 
-          Recommended for driver developers only.
+	  Recommended for driver developers only.
 
-          If in doubt, say "N".
+	  If in doubt, say "N".
 
 config DRM_I915_DEBUG_GUC
-        bool "Enable additional driver debugging for GuC"
-        depends on DRM_I915
-        default n
-        help
-          Choose this option to turn on extra driver debugging that may affect
-          performance but will help resolve GuC related issues.
+	bool "Enable additional driver debugging for GuC"
+	depends on DRM_I915
+	default n
+	help
+	  Choose this option to turn on extra driver debugging that may affect
+	  performance but will help resolve GuC related issues.
 
-          Recommended for driver developers only.
+	  Recommended for driver developers only.
 
-          If in doubt, say "N".
+	  If in doubt, say "N".
 
 config DRM_I915_SELFTEST
 	bool "Enable selftests upon driver load"
@@ -178,15 +178,15 @@ config DRM_I915_SELFTEST_BROKEN
 	  If in doubt, say "N".
 
 config DRM_I915_LOW_LEVEL_TRACEPOINTS
-        bool "Enable low level request tracing events"
-        depends on DRM_I915
-        default n
-        help
-          Choose this option to turn on low level request tracing events.
-          This provides the ability to precisely monitor engine utilisation
-          and also analyze the request dependency resolving timeline.
-
-          If in doubt, say "N".
+	bool "Enable low level request tracing events"
+	depends on DRM_I915
+	default n
+	help
+	  Choose this option to turn on low level request tracing events.
+	  This provides the ability to precisely monitor engine utilisation
+	  and also analyze the request dependency resolving timeline.
+
+	  If in doubt, say "N".
 
 config DRM_I915_DEBUG_VBLANK_EVADE
 	bool "Enable extra debug warnings for vblank evasion"
-- 
2.17.1

