Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63D78C31E4A
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 17:55:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D6652173C
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 17:55:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560362115;
	bh=XLL57U2cMcgWqVQGfPVFokKKJNwtXDP4xduajeX58G8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=GifcFttgojblZUlijcj4TF+Zmj9u4eb88SUjVUQ5pHsiuhE8nBnZEz2eb8j7DqQnv
	 xpqhcVzakRXbv+58eNiIjcAywof5twyB+RS30AibD5d53q2/qai9Gkv2lLuaj1lUT8
	 KI39tIW5fSRLnkfGQkDR9E35WM85Dp8lejGAWgz8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390311AbfFLRzO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 13:55:14 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:40650 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389228AbfFLRxS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 13:53:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=LODV2xUoFNxknV26miUARY9/ZInmVpzomuSRyMjtHiw=; b=qhY3Sf6FfNEogGrDLpyftWrZuf
        JJQdRw/7eO3o/MuDOTpXitWc7L7YkGvyhhGnLy/2MBysWmo8kOkt9oXi1/0wjav78Qr8zKOeJLhbk
        w6XziYseHKPtC9heWrMhpH/1SZrPO9Q9DFpiofc4Bug0LdxpxZPtboIKOUFrMdZ0Yqg7yBk+ob+gE
        OmSYjUB+t5xYqfqgZPzydsGjfukWcIaXKv70dYDNYmOmXTCSi83WDOHaW9Obv7rwJS4jyhYwgZPFC
        rNNweA1HfZEHJW7UeLaFoQ1wWaIda3Ehk1GwhpGvo2kHCljDdFwMa4tiRjeyuTAYoONsXKfyUGKOt
        MLWlL0pw==;
Received: from 201.86.169.251.dynamic.adsl.gvt.net.br ([201.86.169.251] helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hb7Qx-0002Dv-WE; Wed, 12 Jun 2019 17:53:16 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hb7Qq-0001hm-Py; Wed, 12 Jun 2019 14:53:08 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH v4 28/28] docs: EDID/HOWTO.txt: convert it and rename to howto.rst
Date:   Wed, 12 Jun 2019 14:53:04 -0300
Message-Id: <fda591389c53e22ae95d1493f0cb443370484757.1560361364.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1560361364.git.mchehab+samsung@kernel.org>
References: <cover.1560361364.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sphinx need to know when a paragraph ends. So, do some adjustments
at the file for it to be properly parsed.

At its new index.rst, let's add a :orphan: while this is not linked to
the main index.rst file, in order to avoid build warnings.

that's said, I believe that this file should be moved to the
GPU/DRM documentation.

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 Documentation/EDID/{HOWTO.txt => howto.rst}   | 31 ++++++++++++-------
 .../admin-guide/kernel-parameters.txt         |  2 +-
 drivers/gpu/drm/Kconfig                       |  2 +-
 3 files changed, 22 insertions(+), 13 deletions(-)
 rename Documentation/EDID/{HOWTO.txt => howto.rst} (83%)

diff --git a/Documentation/EDID/HOWTO.txt b/Documentation/EDID/howto.rst
similarity index 83%
rename from Documentation/EDID/HOWTO.txt
rename to Documentation/EDID/howto.rst
index 539871c3b785..725fd49a88ca 100644
--- a/Documentation/EDID/HOWTO.txt
+++ b/Documentation/EDID/howto.rst
@@ -1,3 +1,9 @@
+:orphan:
+
+====
+EDID
+====
+
 In the good old days when graphics parameters were configured explicitly
 in a file called xorg.conf, even broken hardware could be managed.
 
@@ -34,16 +40,19 @@ Makefile. Please note that the EDID data structure expects the timing
 values in a different way as compared to the standard X11 format.
 
 X11:
-HTimings:  hdisp hsyncstart hsyncend htotal
-VTimings:  vdisp vsyncstart vsyncend vtotal
+  HTimings:
+    hdisp hsyncstart hsyncend htotal
+  VTimings:
+    vdisp vsyncstart vsyncend vtotal
 
-EDID:
-#define XPIX hdisp
-#define XBLANK htotal-hdisp
-#define XOFFSET hsyncstart-hdisp
-#define XPULSE hsyncend-hsyncstart
+EDID::
 
-#define YPIX vdisp
-#define YBLANK vtotal-vdisp
-#define YOFFSET vsyncstart-vdisp
-#define YPULSE vsyncend-vsyncstart
+  #define XPIX hdisp
+  #define XBLANK htotal-hdisp
+  #define XOFFSET hsyncstart-hdisp
+  #define XPULSE hsyncend-hsyncstart
+
+  #define YPIX vdisp
+  #define YBLANK vtotal-vdisp
+  #define YOFFSET vsyncstart-vdisp
+  #define YPULSE vsyncend-vsyncstart
diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 3d072ca532bb..3faf37b8b001 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -930,7 +930,7 @@
 			edid/1680x1050.bin, or edid/1920x1080.bin is given
 			and no file with the same name exists. Details and
 			instructions how to build your own EDID data are
-			available in Documentation/EDID/HOWTO.txt. An EDID
+			available in Documentation/EDID/howto.rst. An EDID
 			data set will only be used for a particular connector,
 			if its name and a colon are prepended to the EDID
 			name. Each connector may use a unique EDID data
diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
index 6b34949416b1..c3a6dd284c91 100644
--- a/drivers/gpu/drm/Kconfig
+++ b/drivers/gpu/drm/Kconfig
@@ -141,7 +141,7 @@ config DRM_LOAD_EDID_FIRMWARE
 	  monitor are unable to provide appropriate EDID data. Since this
 	  feature is provided as a workaround for broken hardware, the
 	  default case is N. Details and instructions how to build your own
-	  EDID data are given in Documentation/EDID/HOWTO.txt.
+	  EDID data are given in Documentation/EDID/howto.rst.
 
 config DRM_DP_CEC
 	bool "Enable DisplayPort CEC-Tunneling-over-AUX HDMI support"
-- 
2.21.0

