Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2DD7C282DD
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 14:02:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9789F20705
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 14:02:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728612AbgAHOCy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 09:02:54 -0500
Received: from mout.kundenserver.de ([212.227.126.134]:50491 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726989AbgAHOCy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 09:02:54 -0500
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue012 [212.227.15.129]) with ESMTPA (Nemesis) id
 1M8k65-1ikXDF2np3-004mDm; Wed, 08 Jan 2020 15:02:32 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Dave Airlie <airlied@redhat.com>,
        Alexander Shiyan <shc_work@mail.ru>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= 
        <ville.syrjala@linux.intel.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] i915: fix backlight configuration issue
Date:   Wed,  8 Jan 2020 15:01:28 +0100
Message-Id: <20200108140227.3976563-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:kIi7ED0RYkIxN5jrC7zhCvAr9CICa71/ziyFhJPkzEnvKNE72eB
 /ZUyDZKIsiBAvn/3EyBUxdAMz1/RS34RJpaaPiFfW0kf/X463mZaKoMkMtBn4r4PvmKCeND
 gCBOfkz8zvwIhepyQu0rbieMsqHZb+Lgfu283tq+DSU4qAEkzFUHFzVk6d81qeNDcKVsq+E
 wO1mtjFWyMEGqn25HSbgQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:1nSzQY83R+Q=:EeJ7ze47xdCzjuarC5cxTs
 Bfz4fgNKREYcOkfefkRubHYmDzIYHc3PBkBeQgXRjGBgJRONkgj4AdwpjyXg4WtlKd4AkB67w
 39niysUylxQ8mMrYIzr7E/R1vOu3RKChMrV/iKL49JLQXC8sju8ryNrnt5lVJkfX1MoNiDibD
 49XsdZCVNMXAVO1FLWRHL5b0LC1ki0Kr93i7Oywdqz8lUi0pUft/4PaAQdDS6E0IDdSQEda9O
 LvdtmpHbIN8MAc9Lv+XYrznFK0jTRtxtgzlFx4HtqkSaXVYiqiJVgJbAhWXYrocHgttDKvuxt
 EQlb5C4wM+BbP1xzWPShy7XngL3rtuQb3Erql0Y+A2jqejocynLUEtI/sWHmwx3r97KPT9ueV
 Z+WdEp6YVY7zHIDO+GU02nbhnUP0qF6SmKP+6MZvCI2vHTpLIS/so8TQMnQgElY5Hv7VmQMli
 L9m/gY6C01wrebVFi0w07zwKuG23e2nqHA3zxl6S8spmy6cvsumLPNwup5iitKXf3e1MTdmev
 SXMGBaLjjlYirbVQA3c8XhXMXAF6byJ+8FfYTW7Dz4b2U47CGCvzqCc3tubeb+RhjSgjOZwBr
 +Dq55GbPZVb9el0+AUP5UlFlrxVzJBxm43kf8PlDuSD/AhKarbYiao8qlIXVEjqrtkiUi2YXz
 INQAZ6axU1pspnD9zVAejzeAzAbqt18jRKyXheFKWMY4WwP0emMnihM6VzeF63ScpDoqHuHs2
 Sxa9hABevxcR3ZDk7OCQbj2anQ9GdG7fdrgD9YGLBUo049Obdtkv6wQxLEyYl4QdmXARJ1+6X
 jDt7BC3FDXlq9QIs/HGxl4/skZ0qSRnVPfdr0SWYQhrPFGudSEFeQPHHSdMQAjPKKsHpvB71c
 dsqqGb/rd0rn9Zvgc0Wg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The i915 driver can use the backlight subsystem as an option, and usually
selects it when CONFIG_ACPI is set. However it is possible to configure
a kernel with modular backlight classdev support and a built-in i915
driver, which leads to a linker error:

drivers/gpu/drm/i915/display/intel_panel.o: In function `intel_backlight_device_register':
intel_panel.c:(.text+0x2f58): undefined reference to `backlight_device_register'
drivers/gpu/drm/i915/display/intel_panel.o: In function `intel_backlight_device_unregister':
intel_panel.c:(.text+0x2fe4): undefined reference to `backlight_device_unregister'

Add another Kconfig option to ensure the driver only tries to use
the backlight support when it can in fact be linked that way. The
new option is on by default to keep the existing behavior.

This is roughly what other drivers like nouveau do as well.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
I've had this one lying around for a long time, it is still needed
but I am not sure which solution is best here. This version is
probably the least invasive, but it does not solve the bigger
problem around too many 'select' statements in drm
---
 drivers/gpu/drm/i915/Kconfig               | 11 ++++++++++-
 drivers/gpu/drm/i915/display/intel_panel.c |  4 ++--
 drivers/gpu/drm/i915/display/intel_panel.h |  6 +++---
 3 files changed, 15 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/i915/Kconfig b/drivers/gpu/drm/i915/Kconfig
index ba9595960bbe..81d956040d18 100644
--- a/drivers/gpu/drm/i915/Kconfig
+++ b/drivers/gpu/drm/i915/Kconfig
@@ -16,7 +16,7 @@ config DRM_I915
 	select IRQ_WORK
 	# i915 depends on ACPI_VIDEO when ACPI is enabled
 	# but for select to work, need to select ACPI_VIDEO's dependencies, ick
-	select BACKLIGHT_CLASS_DEVICE if ACPI
+	select DRM_I915_BACKLIGHT if ACPI
 	select INPUT if ACPI
 	select ACPI_VIDEO if ACPI
 	select ACPI_BUTTON if ACPI
@@ -68,6 +68,15 @@ config DRM_I915_FORCE_PROBE
 
 	  Use "*" to force probe the driver for all known devices.
 
+config DRM_I915_BACKLIGHT
+	tristate "Control backlight support"
+	depends on DRM_I915
+	default DRM_I915
+	select BACKLIGHT_CLASS_DEVICE
+	help
+          Say Y here if you want to control the backlight of your display
+          (e.g. a laptop panel).
+
 config DRM_I915_CAPTURE_ERROR
 	bool "Enable capturing GPU state following a hang"
 	depends on DRM_I915
diff --git a/drivers/gpu/drm/i915/display/intel_panel.c b/drivers/gpu/drm/i915/display/intel_panel.c
index 7b3ec6eb3382..e2fe7a50dcbf 100644
--- a/drivers/gpu/drm/i915/display/intel_panel.c
+++ b/drivers/gpu/drm/i915/display/intel_panel.c
@@ -1203,7 +1203,7 @@ void intel_panel_enable_backlight(const struct intel_crtc_state *crtc_state,
 	mutex_unlock(&dev_priv->backlight_lock);
 }
 
-#if IS_ENABLED(CONFIG_BACKLIGHT_CLASS_DEVICE)
+#if IS_ENABLED(CONFIG_DRM_I915_BACKLIGHT)
 static u32 intel_panel_get_backlight(struct intel_connector *connector)
 {
 	struct drm_i915_private *dev_priv = to_i915(connector->base.dev);
@@ -1370,7 +1370,7 @@ void intel_backlight_device_unregister(struct intel_connector *connector)
 		panel->backlight.device = NULL;
 	}
 }
-#endif /* CONFIG_BACKLIGHT_CLASS_DEVICE */
+#endif /* CONFIG_DRM_I915_BACKLIGHT */
 
 /*
  * CNP: PWM clock frequency is 19.2 MHz or 24 MHz.
diff --git a/drivers/gpu/drm/i915/display/intel_panel.h b/drivers/gpu/drm/i915/display/intel_panel.h
index cedeea443336..e6e81268b7ed 100644
--- a/drivers/gpu/drm/i915/display/intel_panel.h
+++ b/drivers/gpu/drm/i915/display/intel_panel.h
@@ -49,10 +49,10 @@ intel_panel_edid_fixed_mode(struct intel_connector *connector);
 struct drm_display_mode *
 intel_panel_vbt_fixed_mode(struct intel_connector *connector);
 
-#if IS_ENABLED(CONFIG_BACKLIGHT_CLASS_DEVICE)
+#if IS_ENABLED(CONFIG_DRM_I915_BACKLIGHT)
 int intel_backlight_device_register(struct intel_connector *connector);
 void intel_backlight_device_unregister(struct intel_connector *connector);
-#else /* CONFIG_BACKLIGHT_CLASS_DEVICE */
+#else /* CONFIG_DRM_I915_BACKLIGHT */
 static inline int intel_backlight_device_register(struct intel_connector *connector)
 {
 	return 0;
@@ -60,6 +60,6 @@ static inline int intel_backlight_device_register(struct intel_connector *connec
 static inline void intel_backlight_device_unregister(struct intel_connector *connector)
 {
 }
-#endif /* CONFIG_BACKLIGHT_CLASS_DEVICE */
+#endif /* CONFIG_DRM_I915_BACKLIGHT */
 
 #endif /* __INTEL_PANEL_H__ */
-- 
2.20.0

