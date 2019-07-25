Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B57D4C76194
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 05:36:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E8FB2083B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 05:36:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403927AbfGYFg1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 01:36:27 -0400
Received: from smtp01.smtpout.orange.fr ([80.12.242.123]:28194 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403902AbfGYFg1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 01:36:27 -0400
Received: from localhost.localdomain ([92.140.204.221])
        by mwinf5d54 with ME
        id gtcK2000X4n7eLC03tcL7y; Thu, 25 Jul 2019 07:36:23 +0200
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Thu, 25 Jul 2019 07:36:23 +0200
X-ME-IP: 92.140.204.221
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     pierre-louis.bossart@linux.intel.com,
        liam.r.girdwood@linux.intel.com, yang.jie@linux.intel.com,
        broonie@kernel.org, perex@perex.cz, tiwai@suse.com
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] ASoC: Intel: Fix some acpi vs apci typo in somme comments
Date:   Thu, 25 Jul 2019 07:35:23 +0200
Message-Id: <20190725053523.16542-1-christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix some typo to have the filaname given in a comment match the real name
of the file.
Some 'acpi' have erroneously been written 'apci'

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 sound/soc/intel/common/soc-acpi-intel-bxt-match.c     | 2 +-
 sound/soc/intel/common/soc-acpi-intel-byt-match.c     | 2 +-
 sound/soc/intel/common/soc-acpi-intel-cht-match.c     | 2 +-
 sound/soc/intel/common/soc-acpi-intel-cnl-match.c     | 2 +-
 sound/soc/intel/common/soc-acpi-intel-glk-match.c     | 2 +-
 sound/soc/intel/common/soc-acpi-intel-hda-match.c     | 2 +-
 sound/soc/intel/common/soc-acpi-intel-hsw-bdw-match.c | 2 +-
 sound/soc/intel/common/soc-acpi-intel-icl-match.c     | 2 +-
 sound/soc/intel/common/soc-acpi-intel-kbl-match.c     | 2 +-
 sound/soc/intel/common/soc-acpi-intel-skl-match.c     | 2 +-
 10 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/sound/soc/intel/common/soc-acpi-intel-bxt-match.c b/sound/soc/intel/common/soc-acpi-intel-bxt-match.c
index 229e39586868..4a5adae1d785 100644
--- a/sound/soc/intel/common/soc-acpi-intel-bxt-match.c
+++ b/sound/soc/intel/common/soc-acpi-intel-bxt-match.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * soc-apci-intel-bxt-match.c - tables and support for BXT ACPI enumeration.
+ * soc-acpi-intel-bxt-match.c - tables and support for BXT ACPI enumeration.
  *
  * Copyright (c) 2018, Intel Corporation.
  *
diff --git a/sound/soc/intel/common/soc-acpi-intel-byt-match.c b/sound/soc/intel/common/soc-acpi-intel-byt-match.c
index b94b482ac34f..1cc801ba92eb 100644
--- a/sound/soc/intel/common/soc-acpi-intel-byt-match.c
+++ b/sound/soc/intel/common/soc-acpi-intel-byt-match.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- * soc-apci-intel-byt-match.c - tables and support for BYT ACPI enumeration.
+ * soc-acpi-intel-byt-match.c - tables and support for BYT ACPI enumeration.
  *
  * Copyright (c) 2017, Intel Corporation.
  */
diff --git a/sound/soc/intel/common/soc-acpi-intel-cht-match.c b/sound/soc/intel/common/soc-acpi-intel-cht-match.c
index b7f11f6be1cf..d0fb43c2b9f6 100644
--- a/sound/soc/intel/common/soc-acpi-intel-cht-match.c
+++ b/sound/soc/intel/common/soc-acpi-intel-cht-match.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- * soc-apci-intel-cht-match.c - tables and support for CHT ACPI enumeration.
+ * soc-acpi-intel-cht-match.c - tables and support for CHT ACPI enumeration.
  *
  * Copyright (c) 2017, Intel Corporation.
  */
diff --git a/sound/soc/intel/common/soc-acpi-intel-cnl-match.c b/sound/soc/intel/common/soc-acpi-intel-cnl-match.c
index c36c0aa4f683..771b0ef21051 100644
--- a/sound/soc/intel/common/soc-acpi-intel-cnl-match.c
+++ b/sound/soc/intel/common/soc-acpi-intel-cnl-match.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * soc-apci-intel-cnl-match.c - tables and support for CNL ACPI enumeration.
+ * soc-acpi-intel-cnl-match.c - tables and support for CNL ACPI enumeration.
  *
  * Copyright (c) 2018, Intel Corporation.
  *
diff --git a/sound/soc/intel/common/soc-acpi-intel-glk-match.c b/sound/soc/intel/common/soc-acpi-intel-glk-match.c
index 616eb09e78a0..60dea358fa04 100644
--- a/sound/soc/intel/common/soc-acpi-intel-glk-match.c
+++ b/sound/soc/intel/common/soc-acpi-intel-glk-match.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * soc-apci-intel-glk-match.c - tables and support for GLK ACPI enumeration.
+ * soc-acpi-intel-glk-match.c - tables and support for GLK ACPI enumeration.
  *
  * Copyright (c) 2018, Intel Corporation.
  *
diff --git a/sound/soc/intel/common/soc-acpi-intel-hda-match.c b/sound/soc/intel/common/soc-acpi-intel-hda-match.c
index 68ae43f7b4b2..cc972d2ac691 100644
--- a/sound/soc/intel/common/soc-acpi-intel-hda-match.c
+++ b/sound/soc/intel/common/soc-acpi-intel-hda-match.c
@@ -2,7 +2,7 @@
 // Copyright (c) 2018, Intel Corporation.
 
 /*
- * soc-apci-intel-hda-match.c - tables and support for HDA+ACPI enumeration.
+ * soc-acpi-intel-hda-match.c - tables and support for HDA+ACPI enumeration.
  *
  */
 
diff --git a/sound/soc/intel/common/soc-acpi-intel-hsw-bdw-match.c b/sound/soc/intel/common/soc-acpi-intel-hsw-bdw-match.c
index d27853e7a369..34eb0baaa951 100644
--- a/sound/soc/intel/common/soc-acpi-intel-hsw-bdw-match.c
+++ b/sound/soc/intel/common/soc-acpi-intel-hsw-bdw-match.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- * soc-apci-intel-hsw-bdw-match.c - tables and support for ACPI enumeration.
+ * soc-acpi-intel-hsw-bdw-match.c - tables and support for ACPI enumeration.
  *
  * Copyright (c) 2017, Intel Corporation.
  */
diff --git a/sound/soc/intel/common/soc-acpi-intel-icl-match.c b/sound/soc/intel/common/soc-acpi-intel-icl-match.c
index 0b430b9b3673..38977669b576 100644
--- a/sound/soc/intel/common/soc-acpi-intel-icl-match.c
+++ b/sound/soc/intel/common/soc-acpi-intel-icl-match.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * soc-apci-intel-icl-match.c - tables and support for ICL ACPI enumeration.
+ * soc-acpi-intel-icl-match.c - tables and support for ICL ACPI enumeration.
  *
  * Copyright (c) 2018, Intel Corporation.
  *
diff --git a/sound/soc/intel/common/soc-acpi-intel-kbl-match.c b/sound/soc/intel/common/soc-acpi-intel-kbl-match.c
index 4b331058e807..e200baa11011 100644
--- a/sound/soc/intel/common/soc-acpi-intel-kbl-match.c
+++ b/sound/soc/intel/common/soc-acpi-intel-kbl-match.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * soc-apci-intel-kbl-match.c - tables and support for KBL ACPI enumeration.
+ * soc-acpi-intel-kbl-match.c - tables and support for KBL ACPI enumeration.
  *
  * Copyright (c) 2018, Intel Corporation.
  *
diff --git a/sound/soc/intel/common/soc-acpi-intel-skl-match.c b/sound/soc/intel/common/soc-acpi-intel-skl-match.c
index 0c9c0edd35b3..42fa40a8d932 100644
--- a/sound/soc/intel/common/soc-acpi-intel-skl-match.c
+++ b/sound/soc/intel/common/soc-acpi-intel-skl-match.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * soc-apci-intel-skl-match.c - tables and support for SKL ACPI enumeration.
+ * soc-acpi-intel-skl-match.c - tables and support for SKL ACPI enumeration.
  *
  * Copyright (c) 2018, Intel Corporation.
  *
-- 
2.20.1

