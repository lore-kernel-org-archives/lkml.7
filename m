Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB264C433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 16:37:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 983562173C
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 16:37:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="VpYxY8p6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403996AbfHHQhC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 12:37:02 -0400
Received: from mout.gmx.net ([212.227.17.20]:35617 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732698AbfHHQhC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 12:37:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1565282209;
        bh=WngWhu+VSrCczKQcOC13V5cOcMqdUrDfvvX37Ol79QE=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=VpYxY8p6JQ4xJ1DH5gH9cbaBeuJnbTg0CjWQzqRb0sUCJEXIK/AGq3qGwLixGjFsX
         pBzwgaPzkaTIED89J44zOL/kLF4KVX04/mkAn4g5qF7riNy58B1rYj9nddga6lTRQ3
         e9UgFWlen36S7XfCDTpW4/eyBDm809lLTrmRzZ5M=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([109.90.233.87]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MgGDK-1hhxO30DLC-00Nhga; Thu, 08
 Aug 2019 18:36:49 +0200
From:   =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     dri-devel@lists.freedesktop.org
Cc:     =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/drv: Use // for comments in example code
Date:   Thu,  8 Aug 2019 18:36:28 +0200
Message-Id: <20190808163629.14280-1-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:dh3da0VddiuGyCNG224VsMkUXNRw99d9WmBP31IFNv2qRcTIkKX
 qMCm5t0MXLZ1Vv7HuJTL3lZuNi3bATiGZhWpF3WGPD9tl306WCqrnRnG8XYfUFgmCNdV3HH
 e8AZ7WX/nE+7saZzJmC102wK4O5ZG0pwL9v/C+bM3iLJhKXPoOTsUmEV32h/a8hDG0RC6PV
 /ILNrOU851vhdFDPYNuDw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:XXDPmahNr4s=:D3NRvITByIEX0lWkI/kSUa
 BKyz37oQlIowLBxfGYm+P997A+XTZDJD/QhCoEzYRxKuq61b+7A24VzAYdxbZ/TFn81wrRmq0
 Fz4L4lAtPBLZi34hb37D/bDr7A8G89GWq2uT2bCTWEDX55PL4v/EvR2kVTlw6fhiUowJoiKl1
 Z1x+Tvov0OKjbH3kf5LflRAdyCND/k5aZuKBLV8JYQ6dCUbuCATSPm5UJzQop/XHC/NnmDkPN
 xpcEApbAe7CGZGM0+bkEUpRYRgTvq223Uz+sxjfaoEMdJANW9dJsvtecryTZRSEwu97uo56VL
 iuk50TV6LmTDands57TzHHWd6WWHEmg9f33cx1zcDUOHu9hybvWY3eeuq18gvl7wPq3ho9IxV
 98ZWyUuI5Wq6rhI6kLJEXg58nUG5ppAf1GA98P1PhE9QoS56o7srG3DbXvUDrezAfohAyuSr2
 6Xi4yFz3MiJkuewOV2DXOI4Vt0afHKjmwnsx6oldA0qrSBthl8IwX2qJBac7+dtpg9gKhliNU
 JpG7N4I36j8eeUctlxd8bTriH4qX/5Y8vGwPSTaZ7V7vzToqSEUgKBgYsPlo4DsHOOk052S7S
 isDadH19hEslXNy8ShDBb3JZYEKa8Uq64ktSCu6OxIJJqEiDMyfXxPHltlkj0DN9QnALWFntA
 VtmhL1JVzKXAxElqJNJ5hOujn+IaylwI5g6gO6wqYjj//GknL/2QfIBTLDuaWdPmO9XhTAhZj
 uVxFzmLr4MqHDno28Il/jt3caK+Iq6vFauzqowvoeEKO8MNbCLOMbgvXx6ZYsh1JOte3AWbFk
 0Pgnm0YyK+CXBQLqdRp6AH6nQG7KGAjMMZ409pTmprP90WkyzHDjtyifD8ye/S6Sn3fVcQRv6
 qrc2ZA9NDr78PCaHlHZN4MKA7NB6h2/poL/KxcaaEd53cjf0rZ6sXQwRde6oGEVoJLYEAnYtm
 hP+0XLN9lAKKQTML7hznzn24Khsp5YWGWutDGUMcq7WmNkeOQOqWVlp86SUVhoBXTlYeMXFWF
 W2UIz0XJG8yuhGm5euGYcfDVs8DdZifBL5IguNxMB0jK7NKmXWl0uJJ39PlyYY8ZDUkUVKdxg
 N4FGFf72LacFY214RE1PrH/uPbQIjljGVjjcT7kqxP763DYgypxyPj9XqmAlrTO87rPYSHs5D
 +mvr8=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This improves Sphinx output in two ways:

- It avoids an unmatched single-quote ('), about which Sphinx complained:

  /.../Documentation/gpu/drm-internals.rst:298:
    WARNING: Could not lex literal_block as "c". Highlighting skipped.

  An alternative approach would be to replace "can't" with a word that
  doesn't have a single-quote.

- It lets Sphinx format the comments in italics and grey, making the
  code slightly easier to read.

Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
=2D--
 drivers/gpu/drm/drm_drv.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/drm_drv.c b/drivers/gpu/drm/drm_drv.c
index 9d00947ca447..769feefeeeef 100644
=2D-- a/drivers/gpu/drm/drm_drv.c
+++ b/drivers/gpu/drm/drm_drv.c
@@ -328,11 +328,9 @@ void drm_minor_release(struct drm_minor *minor)
  *		struct drm_device *drm;
  *		int ret;
  *
- *		[
- *		  devm_kzalloc() can't be used here because the drm_device
- *		  lifetime can exceed the device lifetime if driver unbind
- *		  happens when userspace still has open file descriptors.
- *		]
+ *		// devm_kzalloc() can't be used here because the drm_device '
+ *		// lifetime can exceed the device lifetime if driver unbind
+ *		// happens when userspace still has open file descriptors.
  *		priv =3D kzalloc(sizeof(*priv), GFP_KERNEL);
  *		if (!priv)
  *			return -ENOMEM;
@@ -355,7 +353,7 @@ void drm_minor_release(struct drm_minor *minor)
  *		if (IS_ERR(priv->pclk))
  *			return PTR_ERR(priv->pclk);
  *
- *		[ Further setup, display pipeline etc ]
+ *		// Further setup, display pipeline etc
  *
  *		platform_set_drvdata(pdev, drm);
  *
@@ -370,7 +368,7 @@ void drm_minor_release(struct drm_minor *minor)
  *		return 0;
  *	}
  *
- *	[ This function is called before the devm_ resources are released ]
+ *	// This function is called before the devm_ resources are released
  *	static int driver_remove(struct platform_device *pdev)
  *	{
  *		struct drm_device *drm =3D platform_get_drvdata(pdev);
@@ -381,7 +379,7 @@ void drm_minor_release(struct drm_minor *minor)
  *		return 0;
  *	}
  *
- *	[ This function is called on kernel restart and shutdown ]
+ *	// This function is called on kernel restart and shutdown
  *	static void driver_shutdown(struct platform_device *pdev)
  *	{
  *		drm_atomic_helper_shutdown(platform_get_drvdata(pdev));
=2D-
2.20.1

