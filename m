Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADA27C18E7D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 10:15:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4106220868
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 10:15:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="TyZ+ZcFg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729091AbfEVKPk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 06:15:40 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:45853 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728406AbfEVKPk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 06:15:40 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190522101537euoutp019ff2e6373f78f69b9b8a7a3bf93ae370~g_c7TYv2P1036510365euoutp014
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2019 10:15:37 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190522101537euoutp019ff2e6373f78f69b9b8a7a3bf93ae370~g_c7TYv2P1036510365euoutp014
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1558520137;
        bh=lgBQ+8uTfQLkV5PxSZgmgCh8/JrIEUqTDsyfWM/9dxM=;
        h=From:Subject:To:Date:References:From;
        b=TyZ+ZcFgG2o0RIttpGeKeyEQOSBoMhAjQhBt7fGCYVU1rsojri08t7QM8CwvemggF
         vMh/mkW5CgabVTWWrpR9iG1YvOKfM6QMcSiZ76250U9u1qIwHpmbO08D1lOOwBavvG
         DE53t9CFLhqn1mo3/D8N8tBiLUOp+KV+ENGay6Tw=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190522101537eucas1p1f7812bd5cf91f685eadd65139204d3e8~g_c68FAc71081010810eucas1p1k;
        Wed, 22 May 2019 10:15:37 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id B0.E8.04298.94125EC5; Wed, 22
        May 2019 11:15:37 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190522101536eucas1p12e71e836b8d5983f26ec50324156b926~g_c6Oj--t1081010810eucas1p1j;
        Wed, 22 May 2019 10:15:36 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190522101536eusmtrp25c2931906d41c5320e661acda7b4fe36~g_c6AcN082564725647eusmtrp2z;
        Wed, 22 May 2019 10:15:36 +0000 (GMT)
X-AuditID: cbfec7f2-f2dff700000010ca-c7-5ce5214938d1
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 9B.60.04140.84125EC5; Wed, 22
        May 2019 11:15:36 +0100 (BST)
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190522101535eusmtip240a6689d03d52c29a7c2f974647b1f09~g_c5cYoQh1251612516eusmtip2h;
        Wed, 22 May 2019 10:15:35 +0000 (GMT)
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH 1/2] video: fbdev: pvr2fb: remove function prototypes
To:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Message-ID: <2a32648a-69c8-47a6-109a-6c2f764b2534@samsung.com>
Date:   Wed, 22 May 2019 12:15:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.6.1
MIME-Version: 1.0
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpileLIzCtJLcpLzFFi42LZduznOV1PxacxBnPvsFpc+fqezeJE3wdW
        i8u75rA5MHvc7z7O5PF5k1wAUxSXTUpqTmZZapG+XQJXxv6dZ9kL/mhVfLsm08B4R7GLkYND
        QsBE4uGEqC5GTg4hgRWMEo8/AtlcQPYXRonbcx+yQiQ+M0p8PS8AYoPUt35bzgIRX84o8fuw
        KUTDW0aJWZeawBJsAlYSE9tXMYLYwgKuEk9X9DCD2CICCRIrps8Ai/MK2Ek8njeVDcRmEVCV
        aH/6GmyZqECExP1jG1ghagQlTs58AjaTWUBc4taT+UwQtrzE9rdzmEEWSwjcZpP4sPoEE8Q3
        LhKX9kZCHCos8er4FnYIW0bi/06QXpD6dYwSfzteQDVvZ5RYPvkfG0SVtcTh4xdZQQYxC2hK
        rN+lDxF2lNiw7xoLxHw+iRtvBSFu4JOYtG06M0SYV6KjTQiiWk1iw7INbDBru3auhCrxkPh2
        twASbLES7f2L2SYwKsxC8uQsJE/OQvLkLIRzFjCyrGIUTy0tzk1PLTbMSy3XK07MLS7NS9dL
        zs/dxAhMGaf/Hf+0g/HrpaRDjAIcjEo8vBYPH8cIsSaWFVfmHmKU4GBWEuE9fepRjBBvSmJl
        VWpRfnxRaU5q8SFGaQ4WJXHeaoYH0UIC6YklqdmpqQWpRTBZJg5OqQZGRwazTwtZsll38E5p
        WPWluuH67or+7ntyeUbGmYn5KVP5LRSTbfMZ9b0fpb7+UbHZa8e8l9f5DFfoHpNkKDrGVnPQ
        RPKj8bPse7HXK41/KovG8ZnyvDtdpd3iK/vxyIJvkxiyXnB+OMi7zOBB8+UDC/YXx0q21cVc
        aDcxto2ee493V9HcGAMlluKMREMt5qLiRADGUubnFQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrCLMWRmVeSWpSXmKPExsVy+t/xe7oeik9jDGb9ErK48vU9m8WJvg+s
        Fpd3zWFzYPa4332cyePzJrkApig9m6L80pJUhYz84hJbpWhDCyM9Q0sLPSMTSz1DY/NYKyNT
        JX07m5TUnMyy1CJ9uwS9jP07z7IX/NGq+HZNpoHxjmIXIyeHhICJROu35SxdjFwcQgJLGSUu
        Pj3O3MXIAZSQkTi+vgyiRljiz7UuNoia14wSB2ccYQdJsAlYSUxsX8UIYgsLuEo8XdHDDGKL
        CCRIPH09nw3E5hWwk3g8byqYzSKgKtH+9DUriC0qECFx5v0KFogaQYmTM5+A2cwC6hJ/5l1i
        hrDFJW49mc8EYctLbH87h3kCI/8sJC2zkLTMQtIyC0nLAkaWVYwiqaXFuem5xUZ6xYm5xaV5
        6XrJ+bmbGIEhvu3Yzy07GLveBR9iFOBgVOLhfXDvcYwQa2JZcWXuIUYJDmYlEd7Tpx7FCPGm
        JFZWpRblxxeV5qQWH2I0BXpoIrOUaHI+MP7ySuINTQ3NLSwNzY3Njc0slMR5OwQOxggJpCeW
        pGanphakFsH0MXFwSjUwXkqYGtBz/lylTq0mH+ulr4+03t5ov3zZLNLq5oe7iYwieq9/8bza
        d+3UsWmtB5bppz5SrlrKyGc2TS/Xxe/xvq+zf1t47S98apujUWibcSt54pwKjcvzd69eICp0
        jOdbbG/JjO/7D88w3GP2tD/2dvjKWqvyxKnXS7ZPEE84W6SwJ3rrpq7FO5VYijMSDbWYi4oT
        Aderj5WHAgAA
X-CMS-MailID: 20190522101536eucas1p12e71e836b8d5983f26ec50324156b926
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190522101536eucas1p12e71e836b8d5983f26ec50324156b926
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190522101536eucas1p12e71e836b8d5983f26ec50324156b926
References: <CGME20190522101536eucas1p12e71e836b8d5983f26ec50324156b926@eucas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reorder code a bit and then remove no longer needed function
prototypes.

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/video/fbdev/pvr2fb.c |  141 ++++++++++++++++++-------------------------
 1 file changed, 61 insertions(+), 80 deletions(-)

Index: b/drivers/video/fbdev/pvr2fb.c
===================================================================
--- a/drivers/video/fbdev/pvr2fb.c
+++ b/drivers/video/fbdev/pvr2fb.c
@@ -193,39 +193,6 @@ static unsigned int shdma = PVR2_CASCADE
 static unsigned int pvr2dma = ONCHIP_NR_DMA_CHANNELS;
 #endif
 
-static int pvr2fb_setcolreg(unsigned int regno, unsigned int red, unsigned int green, unsigned int blue,
-                            unsigned int transp, struct fb_info *info);
-static int pvr2fb_blank(int blank, struct fb_info *info);
-static unsigned long get_line_length(int xres_virtual, int bpp);
-static void set_color_bitfields(struct fb_var_screeninfo *var);
-static int pvr2fb_check_var(struct fb_var_screeninfo *var, struct fb_info *info);
-static int pvr2fb_set_par(struct fb_info *info);
-static void pvr2_update_display(struct fb_info *info);
-static void pvr2_init_display(struct fb_info *info);
-static void pvr2_do_blank(void);
-static irqreturn_t pvr2fb_interrupt(int irq, void *dev_id);
-static int pvr2_init_cable(void);
-static int pvr2_get_param(const struct pvr2_params *p, const char *s,
-                            int val, int size);
-#ifdef CONFIG_PVR2_DMA
-static ssize_t pvr2fb_write(struct fb_info *info, const char *buf,
-			    size_t count, loff_t *ppos);
-#endif
-
-static struct fb_ops pvr2fb_ops = {
-	.owner		= THIS_MODULE,
-	.fb_setcolreg	= pvr2fb_setcolreg,
-	.fb_blank	= pvr2fb_blank,
-	.fb_check_var	= pvr2fb_check_var,
-	.fb_set_par	= pvr2fb_set_par,
-#ifdef CONFIG_PVR2_DMA
-	.fb_write	= pvr2fb_write,
-#endif
-	.fb_fillrect	= cfb_fillrect,
-	.fb_copyarea	= cfb_copyarea,
-	.fb_imageblit	= cfb_imageblit,
-};
-
 static struct fb_videomode pvr2_modedb[] = {
     /*
      * Broadcast video modes (PAL and NTSC).  I'm unfamiliar with
@@ -353,6 +320,36 @@ static int pvr2fb_setcolreg(unsigned int
 	return 0;
 }
 
+/*
+ * Determine the cable type and initialize the cable output format.  Don't do
+ * anything if the cable type has been overidden (via "cable:XX").
+ */
+
+#define PCTRA 0xff80002c
+#define PDTRA 0xff800030
+#define VOUTC 0xa0702c00
+
+static int pvr2_init_cable(void)
+{
+	if (cable_type < 0) {
+		fb_writel((fb_readl(PCTRA) & 0xfff0ffff) | 0x000a0000,
+	                  PCTRA);
+		cable_type = (fb_readw(PDTRA) >> 8) & 3;
+	}
+
+	/* Now select the output format (either composite or other) */
+	/* XXX: Save the previous val first, as this reg is also AICA
+	  related */
+	if (cable_type == CT_COMPOSITE)
+		fb_writel(3 << 8, VOUTC);
+	else if (cable_type == CT_RGB)
+		fb_writel(1 << 9, VOUTC);
+	else
+		fb_writel(0, VOUTC);
+
+	return cable_type;
+}
+
 static int pvr2fb_set_par(struct fb_info *info)
 {
 	struct pvr2fb_par *par = (struct pvr2fb_par *)info->par;
@@ -641,36 +638,6 @@ static irqreturn_t pvr2fb_interrupt(int
 	return IRQ_HANDLED;
 }
 
-/*
- * Determine the cable type and initialize the cable output format.  Don't do
- * anything if the cable type has been overidden (via "cable:XX").
- */
-
-#define PCTRA 0xff80002c
-#define PDTRA 0xff800030
-#define VOUTC 0xa0702c00
-
-static int pvr2_init_cable(void)
-{
-	if (cable_type < 0) {
-		fb_writel((fb_readl(PCTRA) & 0xfff0ffff) | 0x000a0000,
-	                  PCTRA);
-		cable_type = (fb_readw(PDTRA) >> 8) & 3;
-	}
-
-	/* Now select the output format (either composite or other) */
-	/* XXX: Save the previous val first, as this reg is also AICA
-	  related */
-	if (cable_type == CT_COMPOSITE)
-		fb_writel(3 << 8, VOUTC);
-	else if (cable_type == CT_RGB)
-		fb_writel(1 << 9, VOUTC);
-	else
-		fb_writel(0, VOUTC);
-
-	return cable_type;
-}
-
 #ifdef CONFIG_PVR2_DMA
 static ssize_t pvr2fb_write(struct fb_info *info, const char *buf,
 			    size_t count, loff_t *ppos)
@@ -741,6 +708,37 @@ out_unmap:
 }
 #endif /* CONFIG_PVR2_DMA */
 
+static struct fb_ops pvr2fb_ops = {
+	.owner		= THIS_MODULE,
+	.fb_setcolreg	= pvr2fb_setcolreg,
+	.fb_blank	= pvr2fb_blank,
+	.fb_check_var	= pvr2fb_check_var,
+	.fb_set_par	= pvr2fb_set_par,
+#ifdef CONFIG_PVR2_DMA
+	.fb_write	= pvr2fb_write,
+#endif
+	.fb_fillrect	= cfb_fillrect,
+	.fb_copyarea	= cfb_copyarea,
+	.fb_imageblit	= cfb_imageblit,
+};
+
+static int pvr2_get_param(const struct pvr2_params *p, const char *s, int val,
+			  int size)
+{
+	int i;
+
+	for (i = 0 ; i < size ; i++ ) {
+		if (s != NULL) {
+			if (!strncasecmp(p[i].name, s, strlen(s)))
+				return p[i].val;
+		} else {
+			if (p[i].val == val)
+				return (int)p[i].name;
+		}
+	}
+	return -1;
+}
+
 /**
  * pvr2fb_common_init
  *
@@ -990,23 +988,6 @@ static void __exit pvr2fb_pci_exit(void)
 }
 #endif /* CONFIG_PCI */
 
-static int pvr2_get_param(const struct pvr2_params *p, const char *s, int val,
-			  int size)
-{
-	int i;
-
-	for (i = 0 ; i < size ; i++ ) {
-		if (s != NULL) {
-			if (!strncasecmp(p[i].name, s, strlen(s)))
-				return p[i].val;
-		} else {
-			if (p[i].val == val)
-				return (int)p[i].name;
-		}
-	}
-	return -1;
-}
-
 /*
  * Parse command arguments.  Supported arguments are:
  *    inverse                             Use inverse color maps
