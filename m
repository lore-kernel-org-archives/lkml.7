Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E2A8C5DF63
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 21:06:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68E8B20663
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 21:06:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732581AbfKFVGO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 16:06:14 -0500
Received: from mailoutvs60.siol.net ([185.57.226.251]:38642 "EHLO
        mail.siol.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727794AbfKFVGL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 16:06:11 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTP id E672B524D2D;
        Wed,  6 Nov 2019 22:06:08 +0100 (CET)
X-Virus-Scanned: amavisd-new at psrvmta10.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
        by localhost (psrvmta10.zcs-production.pri [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id oc7mCy0JEW4Q; Wed,  6 Nov 2019 22:06:08 +0100 (CET)
Received: from mail.siol.net (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTPS id A792F524A72;
        Wed,  6 Nov 2019 22:06:08 +0100 (CET)
Received: from localhost.localdomain (cpe-86-58-102-7.static.triera.net [86.58.102.7])
        (Authenticated sender: 031275009)
        by mail.siol.net (Postfix) with ESMTPSA id 629A2524D2D;
        Wed,  6 Nov 2019 22:06:06 +0100 (CET)
From:   Jernej Skrabec <jernej.skrabec@siol.net>
To:     mripard@kernel.org, paul.kocialkowski@bootlin.com,
        hverkuil-cisco@xs4all.nl
Cc:     mchehab@kernel.org, gregkh@linuxfoundation.org, wens@csie.org,
        linux-media@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: [PATCH v2 3/3] media: cedrus: Increase maximum supported size
Date:   Wed,  6 Nov 2019 22:05:38 +0100
Message-Id: <20191106210538.3474-4-jernej.skrabec@siol.net>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191106210538.3474-1-jernej.skrabec@siol.net>
References: <20191106210538.3474-1-jernej.skrabec@siol.net>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are few variations of 4k resolutions. The biggest one is
4096x2304 which is also supported by HW. It has also nice property that
both width and size are divisible by maximum HEVC CTB size, which is 64.

Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
Acked-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
---
 drivers/staging/media/sunxi/cedrus/cedrus_video.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/media/sunxi/cedrus/cedrus_video.c b/drivers/=
staging/media/sunxi/cedrus/cedrus_video.c
index cc15a5cf107d..15cf1f10221b 100644
--- a/drivers/staging/media/sunxi/cedrus/cedrus_video.c
+++ b/drivers/staging/media/sunxi/cedrus/cedrus_video.c
@@ -29,8 +29,8 @@
=20
 #define CEDRUS_MIN_WIDTH	16U
 #define CEDRUS_MIN_HEIGHT	16U
-#define CEDRUS_MAX_WIDTH	3840U
-#define CEDRUS_MAX_HEIGHT	2160U
+#define CEDRUS_MAX_WIDTH	4096U
+#define CEDRUS_MAX_HEIGHT	2304U
=20
 static struct cedrus_format cedrus_formats[] =3D {
 	{
--=20
2.24.0

