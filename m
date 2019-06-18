Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C431C31E5B
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 20:34:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1122421479
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 20:34:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730745AbfFRUen (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 16:34:43 -0400
Received: from mx2.suse.de ([195.135.220.15]:37344 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729961AbfFRUei (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 16:34:38 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 76353AC32;
        Tue, 18 Jun 2019 20:34:36 +0000 (UTC)
From:   Takashi Iwai <tiwai@suse.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH RFC 1/3] fonts: Fix coding style
Date:   Tue, 18 Jun 2019 22:34:23 +0200
Message-Id: <20190618203425.10723-2-tiwai@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20190618203425.10723-1-tiwai@suse.de>
References: <20190618203425.10723-1-tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix indentation, spaces, and move EXPORT_SYMBOL line to the
appropriate place as a preliminary work.  No actual code change.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 lib/fonts/fonts.c | 83 +++++++++++++++++++++++++++----------------------------
 1 file changed, 40 insertions(+), 43 deletions(-)

diff --git a/lib/fonts/fonts.c b/lib/fonts/fonts.c
index 9969358a7af5..269a829fcbb7 100644
--- a/lib/fonts/fonts.c
+++ b/lib/fonts/fonts.c
@@ -25,51 +25,51 @@
 static const struct font_desc *fonts[] = {
 #ifdef CONFIG_FONT_8x8
 #undef NO_FONTS
-    &font_vga_8x8,
+	&font_vga_8x8,
 #endif
 #ifdef CONFIG_FONT_8x16
 #undef NO_FONTS
-    &font_vga_8x16,
+	&font_vga_8x16,
 #endif
 #ifdef CONFIG_FONT_6x11
 #undef NO_FONTS
-    &font_vga_6x11,
+	&font_vga_6x11,
 #endif
 #ifdef CONFIG_FONT_7x14
 #undef NO_FONTS
-    &font_7x14,
+	&font_7x14,
 #endif
 #ifdef CONFIG_FONT_SUN8x16
 #undef NO_FONTS
-    &font_sun_8x16,
+	&font_sun_8x16,
 #endif
 #ifdef CONFIG_FONT_SUN12x22
 #undef NO_FONTS
-    &font_sun_12x22,
+	&font_sun_12x22,
 #endif
 #ifdef CONFIG_FONT_10x18
 #undef NO_FONTS
-    &font_10x18,
+	&font_10x18,
 #endif
 #ifdef CONFIG_FONT_ACORN_8x8
 #undef NO_FONTS
-    &font_acorn_8x8,
+	&font_acorn_8x8,
 #endif
 #ifdef CONFIG_FONT_PEARL_8x8
 #undef NO_FONTS
-    &font_pearl_8x8,
+	&font_pearl_8x8,
 #endif
 #ifdef CONFIG_FONT_MINI_4x6
 #undef NO_FONTS
-    &font_mini_4x6,
+	&font_mini_4x6,
 #endif
 #ifdef CONFIG_FONT_6x10
 #undef NO_FONTS
-    &font_6x10,
+	&font_6x10,
 #endif
 #ifdef CONFIG_FONT_TER16x32
 #undef NO_FONTS
-    &font_ter_16x32,
+	&font_ter_16x32,
 #endif
 };
 
@@ -90,16 +90,16 @@ static const struct font_desc *fonts[] = {
  *	specified font.
  *
  */
-
 const struct font_desc *find_font(const char *name)
 {
-   unsigned int i;
+	unsigned int i;
 
-   for (i = 0; i < num_fonts; i++)
-      if (!strcmp(fonts[i]->name, name))
-	  return fonts[i];
-   return NULL;
+	for (i = 0; i < num_fonts; i++)
+		if (!strcmp(fonts[i]->name, name))
+			return fonts[i];
+	return NULL;
 }
+EXPORT_SYMBOL(find_font);
 
 
 /**
@@ -116,44 +116,41 @@ const struct font_desc *find_font(const char *name)
  *	chosen font.
  *
  */
-
 const struct font_desc *get_default_font(int xres, int yres, u32 font_w,
 					 u32 font_h)
 {
-    int i, c, cc;
-    const struct font_desc *f, *g;
-
-    g = NULL;
-    cc = -10000;
-    for(i=0; i<num_fonts; i++) {
-	f = fonts[i];
-	c = f->pref;
+	int i, c, cc;
+	const struct font_desc *f, *g;
+
+	g = NULL;
+	cc = -10000;
+	for (i = 0; i < num_fonts; i++) {
+		f = fonts[i];
+		c = f->pref;
 #if defined(__mc68000__)
 #ifdef CONFIG_FONT_PEARL_8x8
-	if (MACH_IS_AMIGA && f->idx == PEARL8x8_IDX)
-	    c = 100;
+		if (MACH_IS_AMIGA && f->idx == PEARL8x8_IDX)
+			c = 100;
 #endif
 #ifdef CONFIG_FONT_6x11
-	if (MACH_IS_MAC && xres < 640 && f->idx == VGA6x11_IDX)
-	    c = 100;
+		if (MACH_IS_MAC && xres < 640 && f->idx == VGA6x11_IDX)
+			c = 100;
 #endif
 #endif
-	if ((yres < 400) == (f->height <= 8))
-	    c += 1000;
+		if ((yres < 400) == (f->height <= 8))
+			c += 1000;
 
-	if ((font_w & (1 << (f->width - 1))) &&
-	    (font_h & (1 << (f->height - 1))))
-	    c += 1000;
+		if ((font_w & (1 << (f->width - 1))) &&
+		    (font_h & (1 << (f->height - 1))))
+			c += 1000;
 
-	if (c > cc) {
-	    cc = c;
-	    g = f;
+		if (c > cc) {
+			cc = c;
+			g = f;
+		}
 	}
-    }
-    return g;
+	return g;
 }
-
-EXPORT_SYMBOL(find_font);
 EXPORT_SYMBOL(get_default_font);
 
 MODULE_AUTHOR("James Simmons <jsimmons@users.sf.net>");
-- 
2.16.4

