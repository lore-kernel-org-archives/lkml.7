Return-Path: <SRS0=G0tX=VI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8202BC74A48
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 06:50:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56C2F20838
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 06:50:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728091AbfGKGuN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jul 2019 02:50:13 -0400
Received: from mga06.intel.com ([134.134.136.31]:39395 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728074AbfGKGuN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jul 2019 02:50:13 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Jul 2019 23:50:10 -0700
X-IronPort-AV: E=Sophos;i="5.63,476,1557212400"; 
   d="scan'208";a="156733048"
Received: from jkrzyszt-desk.igk.intel.com ([172.22.244.18])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Jul 2019 23:50:07 -0700
From:   Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>
To:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc:     Chris Wilson <chris@chris-wilson.co.uk>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        =?UTF-8?q?Micha=C5=82=20Wajdeczko?= <michal.wajdeczko@intel.com>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>
Subject: [PATCH v2] drm/i915: Drop extern qualifiers from header function prototypes
Date:   Thu, 11 Jul 2019 08:50:01 +0200
Message-Id: <20190711065001.26664-1-janusz.krzysztofik@linux.intel.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Follow dim checkpatch recommendation so it doesn't complain on that now
and again on header file modifications.

v2: Drop testing leftover

Signed-off-by: Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>
---
 drivers/gpu/drm/i915/gem/i915_gem_object.h |  2 +-
 drivers/gpu/drm/i915/gvt/gtt.h             | 13 +++---
 drivers/gpu/drm/i915/i915_drv.h            | 47 ++++++++++------------
 drivers/gpu/drm/i915/i915_irq.h            |  4 +-
 drivers/gpu/drm/i915/oa/i915_oa_bdw.h      |  2 +-
 drivers/gpu/drm/i915/oa/i915_oa_bxt.h      |  2 +-
 drivers/gpu/drm/i915/oa/i915_oa_cflgt2.h   |  2 +-
 drivers/gpu/drm/i915/oa/i915_oa_cflgt3.h   |  2 +-
 drivers/gpu/drm/i915/oa/i915_oa_chv.h      |  2 +-
 drivers/gpu/drm/i915/oa/i915_oa_cnl.h      |  2 +-
 drivers/gpu/drm/i915/oa/i915_oa_glk.h      |  2 +-
 drivers/gpu/drm/i915/oa/i915_oa_hsw.h      |  2 +-
 drivers/gpu/drm/i915/oa/i915_oa_icl.h      |  2 +-
 drivers/gpu/drm/i915/oa/i915_oa_kblgt2.h   |  2 +-
 drivers/gpu/drm/i915/oa/i915_oa_kblgt3.h   |  2 +-
 drivers/gpu/drm/i915/oa/i915_oa_sklgt2.h   |  2 +-
 drivers/gpu/drm/i915/oa/i915_oa_sklgt3.h   |  2 +-
 drivers/gpu/drm/i915/oa/i915_oa_sklgt4.h   |  2 +-
 include/drm/i915_drm.h                     | 10 ++---
 19 files changed, 51 insertions(+), 53 deletions(-)

diff --git a/drivers/gpu/drm/i915/gem/i915_gem_object.h b/drivers/gpu/drm/i915/gem/i915_gem_object.h
index 20754c15412a..67aea07ea019 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_object.h
+++ b/drivers/gpu/drm/i915/gem/i915_gem_object.h
@@ -81,7 +81,7 @@ i915_gem_object_lookup(struct drm_file *file, u32 handle)
 }
 
 __deprecated
-extern struct drm_gem_object *
+struct drm_gem_object *
 drm_gem_object_lookup(struct drm_file *file, u32 handle);
 
 __attribute__((nonnull))
diff --git a/drivers/gpu/drm/i915/gvt/gtt.h b/drivers/gpu/drm/i915/gvt/gtt.h
index 42d0394f0de2..88789316807d 100644
--- a/drivers/gpu/drm/i915/gvt/gtt.h
+++ b/drivers/gpu/drm/i915/gvt/gtt.h
@@ -205,17 +205,18 @@ struct intel_vgpu_gtt {
 	struct intel_vgpu_scratch_pt scratch_pt[GTT_TYPE_MAX];
 };
 
-extern int intel_vgpu_init_gtt(struct intel_vgpu *vgpu);
-extern void intel_vgpu_clean_gtt(struct intel_vgpu *vgpu);
+int intel_vgpu_init_gtt(struct intel_vgpu *vgpu);
+void intel_vgpu_clean_gtt(struct intel_vgpu *vgpu);
 void intel_vgpu_reset_ggtt(struct intel_vgpu *vgpu, bool invalidate_old);
 void intel_vgpu_invalidate_ppgtt(struct intel_vgpu *vgpu);
 
-extern int intel_gvt_init_gtt(struct intel_gvt *gvt);
+int intel_gvt_init_gtt(struct intel_gvt *gvt);
 void intel_vgpu_reset_gtt(struct intel_vgpu *vgpu);
-extern void intel_gvt_clean_gtt(struct intel_gvt *gvt);
+void intel_gvt_clean_gtt(struct intel_gvt *gvt);
 
-extern struct intel_vgpu_mm *intel_gvt_find_ppgtt_mm(struct intel_vgpu *vgpu,
-		int page_table_level, void *root_entry);
+struct intel_vgpu_mm *intel_gvt_find_ppgtt_mm(struct intel_vgpu *vgpu,
+					      int page_table_level,
+					      void *root_entry);
 
 struct intel_vgpu_oos_page {
 	struct intel_vgpu_ppgtt_spt *spt;
diff --git a/drivers/gpu/drm/i915/i915_drv.h b/drivers/gpu/drm/i915/i915_drv.h
index a9381e404fd5..246f9cb625dc 100644
--- a/drivers/gpu/drm/i915/i915_drv.h
+++ b/drivers/gpu/drm/i915/i915_drv.h
@@ -2388,19 +2388,17 @@ __i915_printk(struct drm_i915_private *dev_priv, const char *level,
 	__i915_printk(dev_priv, KERN_ERR, fmt, ##__VA_ARGS__)
 
 #ifdef CONFIG_COMPAT
-extern long i915_compat_ioctl(struct file *filp, unsigned int cmd,
-			      unsigned long arg);
+long i915_compat_ioctl(struct file *filp, unsigned int cmd, unsigned long arg);
 #else
 #define i915_compat_ioctl NULL
 #endif
 extern const struct dev_pm_ops i915_pm_ops;
 
-extern int i915_driver_load(struct pci_dev *pdev,
-			    const struct pci_device_id *ent);
-extern void i915_driver_unload(struct drm_device *dev);
+int i915_driver_load(struct pci_dev *pdev, const struct pci_device_id *ent);
+void i915_driver_unload(struct drm_device *dev);
 
-extern void intel_engine_init_hangcheck(struct intel_engine_cs *engine);
-extern void intel_hangcheck_init(struct drm_i915_private *dev_priv);
+void intel_engine_init_hangcheck(struct intel_engine_cs *engine);
+void intel_hangcheck_init(struct drm_i915_private *dev_priv);
 int vlv_force_gfx_clock(struct drm_i915_private *dev_priv, bool on);
 
 u32 intel_calculate_mcr_s_ss_select(struct drm_i915_private *dev_priv);
@@ -2670,14 +2668,14 @@ int intel_engine_cmd_parser(struct intel_engine_cs *engine,
 			    bool is_master);
 
 /* i915_perf.c */
-extern void i915_perf_init(struct drm_i915_private *dev_priv);
-extern void i915_perf_fini(struct drm_i915_private *dev_priv);
-extern void i915_perf_register(struct drm_i915_private *dev_priv);
-extern void i915_perf_unregister(struct drm_i915_private *dev_priv);
+void i915_perf_init(struct drm_i915_private *dev_priv);
+void i915_perf_fini(struct drm_i915_private *dev_priv);
+void i915_perf_register(struct drm_i915_private *dev_priv);
+void i915_perf_unregister(struct drm_i915_private *dev_priv);
 
 /* i915_suspend.c */
-extern int i915_save_state(struct drm_i915_private *dev_priv);
-extern int i915_restore_state(struct drm_i915_private *dev_priv);
+int i915_save_state(struct drm_i915_private *dev_priv);
+int i915_restore_state(struct drm_i915_private *dev_priv);
 
 /* i915_sysfs.c */
 void i915_setup_sysfs(struct drm_i915_private *dev_priv);
@@ -2691,23 +2689,22 @@ mkwrite_device_info(struct drm_i915_private *dev_priv)
 }
 
 /* modesetting */
-extern void intel_modeset_init_hw(struct drm_device *dev);
-extern int intel_modeset_init(struct drm_device *dev);
-extern void intel_modeset_cleanup(struct drm_device *dev);
-extern int intel_modeset_vga_set_state(struct drm_i915_private *dev_priv,
-				       bool state);
-extern void intel_display_resume(struct drm_device *dev);
-extern void i915_redisable_vga(struct drm_i915_private *dev_priv);
-extern void i915_redisable_vga_power_on(struct drm_i915_private *dev_priv);
-extern void intel_init_pch_refclk(struct drm_i915_private *dev_priv);
+void intel_modeset_init_hw(struct drm_device *dev);
+int intel_modeset_init(struct drm_device *dev);
+void intel_modeset_cleanup(struct drm_device *dev);
+int intel_modeset_vga_set_state(struct drm_i915_private *dev_priv, bool state);
+void intel_display_resume(struct drm_device *dev);
+void i915_redisable_vga(struct drm_i915_private *dev_priv);
+void i915_redisable_vga_power_on(struct drm_i915_private *dev_priv);
+void intel_init_pch_refclk(struct drm_i915_private *dev_priv);
 
 int i915_reg_read_ioctl(struct drm_device *dev, void *data,
 			struct drm_file *file);
 
-extern struct intel_display_error_state *
+struct intel_display_error_state *
 intel_display_capture_error_state(struct drm_i915_private *dev_priv);
-extern void intel_display_print_error_state(struct drm_i915_error_state_buf *e,
-					    struct intel_display_error_state *error);
+void intel_display_print_error_state(struct drm_i915_error_state_buf *e,
+				     struct intel_display_error_state *error);
 
 #define __I915_REG_OP(op__, dev_priv__, ...) \
 	intel_uncore_##op__(&(dev_priv__)->uncore, __VA_ARGS__)
diff --git a/drivers/gpu/drm/i915/i915_irq.h b/drivers/gpu/drm/i915/i915_irq.h
index d93fa4e75442..4f803f910177 100644
--- a/drivers/gpu/drm/i915/i915_irq.h
+++ b/drivers/gpu/drm/i915/i915_irq.h
@@ -13,8 +13,8 @@
 struct drm_i915_private;
 struct intel_crtc;
 
-extern void intel_irq_init(struct drm_i915_private *dev_priv);
-extern void intel_irq_fini(struct drm_i915_private *dev_priv);
+void intel_irq_init(struct drm_i915_private *dev_priv);
+void intel_irq_fini(struct drm_i915_private *dev_priv);
 int intel_irq_install(struct drm_i915_private *dev_priv);
 void intel_irq_uninstall(struct drm_i915_private *dev_priv);
 
diff --git a/drivers/gpu/drm/i915/oa/i915_oa_bdw.h b/drivers/gpu/drm/i915/oa/i915_oa_bdw.h
index 0e667f1a8aa1..b5ed68882588 100644
--- a/drivers/gpu/drm/i915/oa/i915_oa_bdw.h
+++ b/drivers/gpu/drm/i915/oa/i915_oa_bdw.h
@@ -10,6 +10,6 @@
 #ifndef __I915_OA_BDW_H__
 #define __I915_OA_BDW_H__
 
-extern void i915_perf_load_test_config_bdw(struct drm_i915_private *dev_priv);
+void i915_perf_load_test_config_bdw(struct drm_i915_private *dev_priv);
 
 #endif
diff --git a/drivers/gpu/drm/i915/oa/i915_oa_bxt.h b/drivers/gpu/drm/i915/oa/i915_oa_bxt.h
index 679e92cf4f1d..43c3e4ab030a 100644
--- a/drivers/gpu/drm/i915/oa/i915_oa_bxt.h
+++ b/drivers/gpu/drm/i915/oa/i915_oa_bxt.h
@@ -10,6 +10,6 @@
 #ifndef __I915_OA_BXT_H__
 #define __I915_OA_BXT_H__
 
-extern void i915_perf_load_test_config_bxt(struct drm_i915_private *dev_priv);
+void i915_perf_load_test_config_bxt(struct drm_i915_private *dev_priv);
 
 #endif
diff --git a/drivers/gpu/drm/i915/oa/i915_oa_cflgt2.h b/drivers/gpu/drm/i915/oa/i915_oa_cflgt2.h
index 4d6025559bbe..1b4b563bc585 100644
--- a/drivers/gpu/drm/i915/oa/i915_oa_cflgt2.h
+++ b/drivers/gpu/drm/i915/oa/i915_oa_cflgt2.h
@@ -10,6 +10,6 @@
 #ifndef __I915_OA_CFLGT2_H__
 #define __I915_OA_CFLGT2_H__
 
-extern void i915_perf_load_test_config_cflgt2(struct drm_i915_private *dev_priv);
+void i915_perf_load_test_config_cflgt2(struct drm_i915_private *dev_priv);
 
 #endif
diff --git a/drivers/gpu/drm/i915/oa/i915_oa_cflgt3.h b/drivers/gpu/drm/i915/oa/i915_oa_cflgt3.h
index 0697f4077402..500565e055cd 100644
--- a/drivers/gpu/drm/i915/oa/i915_oa_cflgt3.h
+++ b/drivers/gpu/drm/i915/oa/i915_oa_cflgt3.h
@@ -10,6 +10,6 @@
 #ifndef __I915_OA_CFLGT3_H__
 #define __I915_OA_CFLGT3_H__
 
-extern void i915_perf_load_test_config_cflgt3(struct drm_i915_private *dev_priv);
+void i915_perf_load_test_config_cflgt3(struct drm_i915_private *dev_priv);
 
 #endif
diff --git a/drivers/gpu/drm/i915/oa/i915_oa_chv.h b/drivers/gpu/drm/i915/oa/i915_oa_chv.h
index 0986eae3135f..ad85d6a6a573 100644
--- a/drivers/gpu/drm/i915/oa/i915_oa_chv.h
+++ b/drivers/gpu/drm/i915/oa/i915_oa_chv.h
@@ -10,6 +10,6 @@
 #ifndef __I915_OA_CHV_H__
 #define __I915_OA_CHV_H__
 
-extern void i915_perf_load_test_config_chv(struct drm_i915_private *dev_priv);
+void i915_perf_load_test_config_chv(struct drm_i915_private *dev_priv);
 
 #endif
diff --git a/drivers/gpu/drm/i915/oa/i915_oa_cnl.h b/drivers/gpu/drm/i915/oa/i915_oa_cnl.h
index e830a406aff2..9faaca38b587 100644
--- a/drivers/gpu/drm/i915/oa/i915_oa_cnl.h
+++ b/drivers/gpu/drm/i915/oa/i915_oa_cnl.h
@@ -10,6 +10,6 @@
 #ifndef __I915_OA_CNL_H__
 #define __I915_OA_CNL_H__
 
-extern void i915_perf_load_test_config_cnl(struct drm_i915_private *dev_priv);
+void i915_perf_load_test_config_cnl(struct drm_i915_private *dev_priv);
 
 #endif
diff --git a/drivers/gpu/drm/i915/oa/i915_oa_glk.h b/drivers/gpu/drm/i915/oa/i915_oa_glk.h
index 06dedf991edb..cc13a1e9fd3e 100644
--- a/drivers/gpu/drm/i915/oa/i915_oa_glk.h
+++ b/drivers/gpu/drm/i915/oa/i915_oa_glk.h
@@ -10,6 +10,6 @@
 #ifndef __I915_OA_GLK_H__
 #define __I915_OA_GLK_H__
 
-extern void i915_perf_load_test_config_glk(struct drm_i915_private *dev_priv);
+void i915_perf_load_test_config_glk(struct drm_i915_private *dev_priv);
 
 #endif
diff --git a/drivers/gpu/drm/i915/oa/i915_oa_hsw.h b/drivers/gpu/drm/i915/oa/i915_oa_hsw.h
index 3d0c870cd0bd..f0ddcc79c761 100644
--- a/drivers/gpu/drm/i915/oa/i915_oa_hsw.h
+++ b/drivers/gpu/drm/i915/oa/i915_oa_hsw.h
@@ -10,6 +10,6 @@
 #ifndef __I915_OA_HSW_H__
 #define __I915_OA_HSW_H__
 
-extern void i915_perf_load_test_config_hsw(struct drm_i915_private *dev_priv);
+void i915_perf_load_test_config_hsw(struct drm_i915_private *dev_priv);
 
 #endif
diff --git a/drivers/gpu/drm/i915/oa/i915_oa_icl.h b/drivers/gpu/drm/i915/oa/i915_oa_icl.h
index 24eaa97d61ba..e501651d385b 100644
--- a/drivers/gpu/drm/i915/oa/i915_oa_icl.h
+++ b/drivers/gpu/drm/i915/oa/i915_oa_icl.h
@@ -10,6 +10,6 @@
 #ifndef __I915_OA_ICL_H__
 #define __I915_OA_ICL_H__
 
-extern void i915_perf_load_test_config_icl(struct drm_i915_private *dev_priv);
+void i915_perf_load_test_config_icl(struct drm_i915_private *dev_priv);
 
 #endif
diff --git a/drivers/gpu/drm/i915/oa/i915_oa_kblgt2.h b/drivers/gpu/drm/i915/oa/i915_oa_kblgt2.h
index a55398a904de..dc460e6e0fae 100644
--- a/drivers/gpu/drm/i915/oa/i915_oa_kblgt2.h
+++ b/drivers/gpu/drm/i915/oa/i915_oa_kblgt2.h
@@ -10,6 +10,6 @@
 #ifndef __I915_OA_KBLGT2_H__
 #define __I915_OA_KBLGT2_H__
 
-extern void i915_perf_load_test_config_kblgt2(struct drm_i915_private *dev_priv);
+void i915_perf_load_test_config_kblgt2(struct drm_i915_private *dev_priv);
 
 #endif
diff --git a/drivers/gpu/drm/i915/oa/i915_oa_kblgt3.h b/drivers/gpu/drm/i915/oa/i915_oa_kblgt3.h
index 3ddd3483b7cc..5926992b735a 100644
--- a/drivers/gpu/drm/i915/oa/i915_oa_kblgt3.h
+++ b/drivers/gpu/drm/i915/oa/i915_oa_kblgt3.h
@@ -10,6 +10,6 @@
 #ifndef __I915_OA_KBLGT3_H__
 #define __I915_OA_KBLGT3_H__
 
-extern void i915_perf_load_test_config_kblgt3(struct drm_i915_private *dev_priv);
+void i915_perf_load_test_config_kblgt3(struct drm_i915_private *dev_priv);
 
 #endif
diff --git a/drivers/gpu/drm/i915/oa/i915_oa_sklgt2.h b/drivers/gpu/drm/i915/oa/i915_oa_sklgt2.h
index be6256037239..353db35b36c1 100644
--- a/drivers/gpu/drm/i915/oa/i915_oa_sklgt2.h
+++ b/drivers/gpu/drm/i915/oa/i915_oa_sklgt2.h
@@ -10,6 +10,6 @@
 #ifndef __I915_OA_SKLGT2_H__
 #define __I915_OA_SKLGT2_H__
 
-extern void i915_perf_load_test_config_sklgt2(struct drm_i915_private *dev_priv);
+void i915_perf_load_test_config_sklgt2(struct drm_i915_private *dev_priv);
 
 #endif
diff --git a/drivers/gpu/drm/i915/oa/i915_oa_sklgt3.h b/drivers/gpu/drm/i915/oa/i915_oa_sklgt3.h
index 650beb068e56..52f94c674b62 100644
--- a/drivers/gpu/drm/i915/oa/i915_oa_sklgt3.h
+++ b/drivers/gpu/drm/i915/oa/i915_oa_sklgt3.h
@@ -10,6 +10,6 @@
 #ifndef __I915_OA_SKLGT3_H__
 #define __I915_OA_SKLGT3_H__
 
-extern void i915_perf_load_test_config_sklgt3(struct drm_i915_private *dev_priv);
+void i915_perf_load_test_config_sklgt3(struct drm_i915_private *dev_priv);
 
 #endif
diff --git a/drivers/gpu/drm/i915/oa/i915_oa_sklgt4.h b/drivers/gpu/drm/i915/oa/i915_oa_sklgt4.h
index 8dcf849d131e..8e364820cc63 100644
--- a/drivers/gpu/drm/i915/oa/i915_oa_sklgt4.h
+++ b/drivers/gpu/drm/i915/oa/i915_oa_sklgt4.h
@@ -10,6 +10,6 @@
 #ifndef __I915_OA_SKLGT4_H__
 #define __I915_OA_SKLGT4_H__
 
-extern void i915_perf_load_test_config_sklgt4(struct drm_i915_private *dev_priv);
+void i915_perf_load_test_config_sklgt4(struct drm_i915_private *dev_priv);
 
 #endif
diff --git a/include/drm/i915_drm.h b/include/drm/i915_drm.h
index 7523e9a7b6e2..26f392fa85a3 100644
--- a/include/drm/i915_drm.h
+++ b/include/drm/i915_drm.h
@@ -30,11 +30,11 @@
 #include <uapi/drm/i915_drm.h>
 
 /* For use by IPS driver */
-extern unsigned long i915_read_mch_val(void);
-extern bool i915_gpu_raise(void);
-extern bool i915_gpu_lower(void);
-extern bool i915_gpu_busy(void);
-extern bool i915_gpu_turbo_disable(void);
+unsigned long i915_read_mch_val(void);
+bool i915_gpu_raise(void);
+bool i915_gpu_lower(void);
+bool i915_gpu_busy(void);
+bool i915_gpu_turbo_disable(void);
 
 /* Exported from arch/x86/kernel/early-quirks.c */
 extern struct resource intel_graphics_stolen_res;
-- 
2.21.0

