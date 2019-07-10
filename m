Return-Path: <SRS0=5O2B=VH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 346EAC74A2B
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 15:00:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5EEA2064B
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 15:00:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727315AbfGJPAK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jul 2019 11:00:10 -0400
Received: from mga03.intel.com ([134.134.136.65]:16077 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726097AbfGJPAK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 11:00:10 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Jul 2019 08:00:08 -0700
X-IronPort-AV: E=Sophos;i="5.63,475,1557212400"; 
   d="scan'208";a="168331121"
Received: from jkrzyszt-desk.igk.intel.com ([172.22.244.18])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Jul 2019 08:00:06 -0700
From:   Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>
To:     intel-gfx@lists.freedesktop.org
Cc:     Chris Wilson <chris@chris-wilson.co.uk>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        =?UTF-8?q?Micha=C5=82=20Wajdeczko?= <michal.wajdeczko@intel.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>
Subject: [RFC PATCH] drm/i915: Join quoted strings and align them with open parenthesis
Date:   Wed, 10 Jul 2019 16:59:55 +0200
Message-Id: <20190710145955.16104-1-janusz.krzysztofik@linux.intel.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Follow dim checkpatch recommendations so it doesn't complain now and
again on consistent modifications of i915_params.c

Signed-off-by: Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>
---
 drivers/gpu/drm/i915/i915_params.c | 96 ++++++++++--------------------
 1 file changed, 33 insertions(+), 63 deletions(-)

diff --git a/drivers/gpu/drm/i915/i915_params.c b/drivers/gpu/drm/i915/i915_params.c
index 296452f9efe4..8007fa893869 100644
--- a/drivers/gpu/drm/i915/i915_params.c
+++ b/drivers/gpu/drm/i915/i915_params.c
@@ -41,141 +41,111 @@ struct i915_params i915_modparams __read_mostly = {
 };
 
 i915_param_named(modeset, int, 0400,
-	"Use kernel modesetting [KMS] (0=disable, "
-	"1=on, -1=force vga console preference [default])");
+		 "Use kernel modesetting [KMS] (0=disable, 1=on, -1=force vga console preference [default])");
 
 i915_param_named_unsafe(enable_dc, int, 0400,
-	"Enable power-saving display C-states. "
-	"(-1=auto [default]; 0=disable; 1=up to DC5; 2=up to DC6)");
+			"Enable power-saving display C-states. (-1=auto [default]; 0=disable; 1=up to DC5; 2=up to DC6)");
 
 i915_param_named_unsafe(enable_fbc, int, 0600,
-	"Enable frame buffer compression for power savings "
-	"(default: -1 (use per-chip default))");
+			"Enable frame buffer compression for power savings (default: -1 (use per-chip default))");
 
 i915_param_named_unsafe(lvds_channel_mode, int, 0400,
-	 "Specify LVDS channel mode "
-	 "(0=probe BIOS [default], 1=single-channel, 2=dual-channel)");
+			"Specify LVDS channel mode (0=probe BIOS [default], 1=single-channel, 2=dual-channel)");
 
 i915_param_named_unsafe(panel_use_ssc, int, 0600,
-	"Use Spread Spectrum Clock with panels [LVDS/eDP] "
-	"(default: auto from VBT)");
+			"Use Spread Spectrum Clock with panels [LVDS/eDP] (default: auto from VBT)");
 
 i915_param_named_unsafe(vbt_sdvo_panel_type, int, 0400,
-	"Override/Ignore selection of SDVO panel mode in the VBT "
-	"(-2=ignore, -1=auto [default], index in VBT BIOS table)");
+			"Override/Ignore selection of SDVO panel mode in the VBT (-2=ignore, -1=auto [default], index in VBT BIOS table)");
 
 i915_param_named_unsafe(reset, int, 0600,
-	"Attempt GPU resets (0=disabled, 1=full gpu reset, 2=engine reset [default])");
+			"Attempt GPU resets (0=disabled, 1=full gpu reset, 2=engine reset [default])");
 
 i915_param_named_unsafe(vbt_firmware, charp, 0400,
-	"Load VBT from specified file under /lib/firmware");
+			"Load VBT from specified file under /lib/firmware");
 
 #if IS_ENABLED(CONFIG_DRM_I915_CAPTURE_ERROR)
 i915_param_named(error_capture, bool, 0600,
-	"Record the GPU state following a hang. "
-	"This information in /sys/class/drm/card<N>/error is vital for "
-	"triaging and debugging hangs.");
+		 "Record the GPU state following a hang. This information in /sys/class/drm/card<N>/error is vital for triaging and debugging hangs.");
 #endif
 
 i915_param_named_unsafe(enable_hangcheck, bool, 0600,
-	"Periodically check GPU activity for detecting hangs. "
-	"WARNING: Disabling this can cause system wide hangs. "
-	"(default: true)");
+			"Periodically check GPU activity for detecting hangs. WARNING: Disabling this can cause system wide hangs. (default: true)");
 
 i915_param_named_unsafe(enable_psr, int, 0600,
-	"Enable PSR "
-	"(0=disabled, 1=enabled) "
-	"Default: -1 (use per-chip default)");
+			"Enable PSR (0=disabled, 1=enabled) Default: -1 (use per-chip default)");
 
 i915_param_named_unsafe(force_probe, charp, 0400,
-	"Force probe the driver for specified devices. "
-	"See CONFIG_DRM_I915_FORCE_PROBE for details.");
+			"Force probe the driver for specified devices. See CONFIG_DRM_I915_FORCE_PROBE for details.");
 
 i915_param_named_unsafe(alpha_support, bool, 0400,
-	"Deprecated. See i915.force_probe.");
+			"Deprecated. See i915.force_probe.");
 
 i915_param_named_unsafe(disable_power_well, int, 0400,
-	"Disable display power wells when possible "
-	"(-1=auto [default], 0=power wells always on, 1=power wells disabled when possible)");
+			"Disable display power wells when possible (-1=auto [default], 0=power wells always on, 1=power wells disabled when possible)");
 
 i915_param_named_unsafe(enable_ips, int, 0600, "Enable IPS (default: true)");
 
 i915_param_named(fastboot, int, 0600,
-	"Try to skip unnecessary mode sets at boot time "
-	"(0=disabled, 1=enabled) "
-	"Default: -1 (use per-chip default)");
+		 "Try to skip unnecessary mode sets at boot time (0=disabled, 1=enabled) Default: -1 (use per-chip default)");
 
 i915_param_named_unsafe(prefault_disable, bool, 0600,
-	"Disable page prefaulting for pread/pwrite/reloc (default:false). "
-	"For developers only.");
+			"Disable page prefaulting for pread/pwrite/reloc (default:false). For developers only.");
 
 i915_param_named_unsafe(load_detect_test, bool, 0600,
-	"Force-enable the VGA load detect code for testing (default:false). "
-	"For developers only.");
+			"Force-enable the VGA load detect code for testing (default:false). For developers only.");
 
 i915_param_named_unsafe(force_reset_modeset_test, bool, 0600,
-	"Force a modeset during gpu reset for testing (default:false). "
-	"For developers only.");
+			"Force a modeset during gpu reset for testing (default:false). For developers only.");
 
 i915_param_named_unsafe(invert_brightness, int, 0600,
-	"Invert backlight brightness "
-	"(-1 force normal, 0 machine defaults, 1 force inversion), please "
-	"report PCI device ID, subsystem vendor and subsystem device ID "
-	"to dri-devel@lists.freedesktop.org, if your machine needs it. "
-	"It will then be included in an upcoming module version.");
+			"Invert backlight brightness (-1 force normal, 0 machine defaults, 1 force inversion), please report PCI device ID, subsystem vendor and subsystem device ID to dri-devel@lists.freedesktop.org, if your machine needs it. It will then be included in an upcoming module version.");
 
 i915_param_named(disable_display, bool, 0400,
-	"Disable display (default: false)");
+		 "Disable display (default: false)");
 
 i915_param_named(mmio_debug, int, 0600,
-	"Enable the MMIO debug code for the first N failures (default: off). "
-	"This may negatively affect performance.");
+		 "Enable the MMIO debug code for the first N failures (default: off). This may negatively affect performance.");
 
 i915_param_named(verbose_state_checks, bool, 0600,
-	"Enable verbose logs (ie. WARN_ON()) in case of unexpected hw state conditions.");
+		 "Enable verbose logs (ie. WARN_ON()) in case of unexpected hw state conditions.");
 
 i915_param_named_unsafe(nuclear_pageflip, bool, 0400,
-	"Force enable atomic functionality on platforms that don't have full support yet.");
+			"Force enable atomic functionality on platforms that don't have full support yet.");
 
 /* WA to get away with the default setting in VBT for early platforms.Will be removed */
 i915_param_named_unsafe(edp_vswing, int, 0400,
-	"Ignore/Override vswing pre-emph table selection from VBT "
-	"(0=use value from vbt [default], 1=low power swing(200mV),"
-	"2=default swing(400mV))");
+			"Ignore/Override vswing pre-emph table selection from VBT (0=use value from vbt [default], 1=low power swing(200mV), 2=default swing(400mV))");
 
 i915_param_named_unsafe(enable_guc, int, 0400,
-	"Enable GuC load for GuC submission and/or HuC load. "
-	"Required functionality can be selected using bitmask values. "
-	"(-1=auto, 0=disable [default], 1=GuC submission, 2=HuC load)");
+			"Enable GuC load for GuC submission and/or HuC load. Required functionality can be selected using bitmask values. (-1=auto, 0=disable [default], 1=GuC submission, 2=HuC load)");
 
 i915_param_named(guc_log_level, int, 0400,
-	"GuC firmware logging level. Requires GuC to be loaded. "
-	"(-1=auto [default], 0=disable, 1..4=enable with verbosity min..max)");
+		 "GuC firmware logging level. Requires GuC to be loaded. (-1=auto [default], 0=disable, 1..4=enable with verbosity min..max)");
 
 i915_param_named_unsafe(guc_firmware_path, charp, 0400,
-	"GuC firmware path to use instead of the default one");
+			"GuC firmware path to use instead of the default one");
 
 i915_param_named_unsafe(huc_firmware_path, charp, 0400,
-	"HuC firmware path to use instead of the default one");
+			"HuC firmware path to use instead of the default one");
 
 i915_param_named_unsafe(dmc_firmware_path, charp, 0400,
-	"DMC firmware path to use instead of the default one");
+			"DMC firmware path to use instead of the default one");
 
 i915_param_named_unsafe(enable_dp_mst, bool, 0600,
-	"Enable multi-stream transport (MST) for new DisplayPort sinks. (default: true)");
+			"Enable multi-stream transport (MST) for new DisplayPort sinks. (default: true)");
 
 #if IS_ENABLED(CONFIG_DRM_I915_DEBUG)
 i915_param_named_unsafe(inject_load_failure, uint, 0400,
-	"Force an error after a number of failure check points (0:disabled (default), N:force failure at the Nth failure check point)");
+			"Force an error after a number of failure check points (0:disabled (default), N:force failure at the Nth failure check point)");
 #endif
 
 i915_param_named(enable_dpcd_backlight, int, 0600,
-	"Enable support for DPCD backlight control"
-	"(-1=use per-VBT LFP backlight type setting, 0=disabled [default], 1=enabled)");
+		 "Enable support for DPCD backlight control (-1=use per-VBT LFP backlight type setting, 0=disabled [default], 1=enabled)");
 
 #if IS_ENABLED(CONFIG_DRM_I915_GVT)
 i915_param_named(enable_gvt, bool, 0400,
-	"Enable support for Intel GVT-g graphics virtualization host support(default:false)");
+		 "Enable support for Intel GVT-g graphics virtualization host support(default:false)");
 #endif
 
 static __always_inline void _print_param(struct drm_printer *p,
-- 
2.21.0

