Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AD65C04AB3
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 20:41:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDA6E2075E
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 20:41:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727183AbfE0UlT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 16:41:19 -0400
Received: from www17.your-server.de ([213.133.104.17]:53762 "EHLO
        www17.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726346AbfE0UlT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 16:41:19 -0400
Received: from [88.198.220.130] (helo=sslproxy01.your-server.de)
        by www17.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <thomas@m3y3r.de>)
        id 1hVMQn-0006wV-Ed; Mon, 27 May 2019 22:41:17 +0200
Received: from [2a02:908:4c22:ec00:915f:2518:d2f6:b586] (helo=maria.localdomain)
        by sslproxy01.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <thomas@m3y3r.de>)
        id 1hVMQm-0002Kt-4r; Mon, 27 May 2019 22:41:17 +0200
Received: by maria.localdomain (sSMTP sendmail emulation); Mon, 27 May 2019 22:41:15 +0200
From:   "Thomas Meyer" <thomas@m3y3r.de>
Date:   Mon, 27 May 2019 22:41:15 +0200
Subject: [PATCH] drm/omap: Make sure device_id tables are NULL terminated
To:     tomi.valkeinen@ti.com, airlied@linux.ie, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Patch: Cocci
X-Mailer: DiffSplit
Message-ID: <1558989631162-1860150863-1-diffsplit-thomas@m3y3r.de>
References: <1558989631144-20791398-0-diffsplit-thomas@m3y3r.de>
In-Reply-To: <1558989631144-20791398-0-diffsplit-thomas@m3y3r.de>
X-Serial-No: 1
X-Authenticated-Sender: thomas@m3y3r.de
X-Virus-Scanned: Clear (ClamAV 0.100.3/25462/Mon May 27 09:58:16 2019)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make sure (of/i2c/platform)_device_id tables are NULL terminated.

Signed-off-by: Thomas Meyer <thomas@m3y3r.de>
---

diff -u -p a/drivers/gpu/drm/omapdrm/dss/omapdss-boot-init.c b/drivers/gpu/drm/omapdrm/dss/omapdss-boot-init.c
--- a/drivers/gpu/drm/omapdrm/dss/omapdss-boot-init.c
+++ b/drivers/gpu/drm/omapdrm/dss/omapdss-boot-init.c
@@ -198,6 +198,7 @@ static const struct of_device_id omapdss
 	{ .compatible = "toppoly,td028ttec1" },
 	{ .compatible = "tpo,td028ttec1" },
 	{ .compatible = "tpo,td043mtea1" },
+	{},
 };
 
 static int __init omapdss_boot_init(void)
