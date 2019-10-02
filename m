Return-Path: <SRS0=zem1=X3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 620DEC35280
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 15:39:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3728C21920
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 15:39:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="WMUwOlX1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727451AbfJBPjF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 11:39:05 -0400
Received: from mout.gmx.net ([212.227.17.20]:48975 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726233AbfJBPjF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 11:39:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1570030728;
        bh=uJ94hoeDYVlEUYDK9HmHZapgsgfzPQRJy+izURTskdE=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=WMUwOlX1Lb+j1C/oVgGjmbT2uNZ8Szam2fkpKo78AKGmKzBXzAHYANDh2eDKXx3L4
         wDojROI8kNSvHNtmUonTmzCkOCa3ndhwdVJPJdjX/j1l436Id1m9J11tdGoHeGnkJ/
         V65KyvV+61xIAbki28wFcMSBrP35Y5Gw6qVlXdYQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([109.90.233.87]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N4hvb-1i6RN120Od-011loW; Wed, 02
 Oct 2019 17:38:48 +0200
From:   =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     dri-devel@lists.freedesktop.org
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Sean Paul <sean@poorly.run>, Jonathan Corbet <corbet@lwn.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
Subject: [PATCH 1/2] drm/mcde: Fix reference to DOC comment
Date:   Wed,  2 Oct 2019 17:38:26 +0200
Message-Id: <20191002153827.23026-1-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:SVSunW34OIe4oEVA5808fwuyxjOn+4LwN+7F3SKvA2tXwrxZ4Hf
 sXxKuyLBXu20zT684c5xM3xYP6buM+1XcJdQARxKi0O+Qytp/nI6EAd4ZgYmj81/3TLPC0R
 k3NZYHtLRqlmKP13YfBJ8I4gGX0IlC4elWUNLjUMAOHIxuv+0B0aAbri/+0lGfTK0OQ51fu
 B0AjU17XJkcVMotb4r2Pg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:3el9ghxLDL4=:UcbCjmWj4WraLgSfYL5TUF
 Pk7ndKlh01nUM8aE3vYwVsz+uszqjobrKK8qe4UcF3J9v9T6yHxc9nhwDf5XPWGHO6NDyUZPH
 aa+53iLudgA5eee8pZ5MaVFO9ss/70BRV5dHHmUCHyCLhb0d6xfavSfkb/Ctut6GaEmYvEtSz
 VwDRL0leZlci/p0Z1F2S8xio1QERlnWedllMLvNMY1lE7S2lsey/Lb6jmAHKvDFhkXp2Gdfqp
 toEIgZMxmxVD4IUXVYV5H2kViDQcRCrUxwnkhPRBF2LCI2PSiq9dI2Fd/YerBIy0Bm0Vmd4dY
 75brhPkyITGoqUTjwxPftnitlWWyeYuS7nH3QPWchDIgQI88lEzG+2h4Xno/fIel8cb4IYvi3
 pWNa47tePmuYPXT5uFL7xyMVEDriAC7CvukZnYS3q6MmY7gWS6PTf2zUcN3A9SnF71gqwcPVB
 kz6qTgZgV2ZT2bGsu4hvgfCSFUYZU1hoEjAgziseu5iInIqCUs/CBvMyyLnShVftcG846gD7l
 Y2hjzcojN/VHj9isHHhXfZoPibDqMukghJqzv9H0Fx1HesEpk9uu3gIyVwyFE0Nt/h/zouKNi
 npRIr2cZ03MLSBphfNyFp3R9OiboRovfpc3gHJHGjtcFpgtag2o5A2lo2qpF1d2SAqasEichf
 KL/lD8vwqJybY7spv/VsYCnGdRjGkVZTgmxeF/X0RAAuZKMA1TpkphI0veE1sE87AitiicqN9
 237UZ/7Qt6/LGqdJPspaoH7hs8/4XF42yk0FoxuD5d5mpS10//UsFv43Zk2OAR0FmUp58pqFf
 kQBpjeE6QlBVS3RaN5/Oy4XojOvwcg2mPIeR04CiwfAZEOSYk7kL8iQ0skit6N7yhgwpOvSJa
 rWXCTvxDdcLd4JBcYWOKR/5pU+Wlzh5QUaRTOqGC8CTh2tlV7Pr7gua9b9oa4K94d3fzzdvGL
 MgrzhUVneX/BOnP486dsKC7S5Joa46apHh8+d5G4bTLvxNB941WeDFLuz75CfZbAZ7s/jnFGX
 q1Zb6kzbTnChvXKA4s9UNojCfw1W+rhSn5aeYVqdXLv+eelP2Rh/l4W41dauVf0nu/HoJdtbh
 +PymWVbJsR0Hdn63k7Aeoan+v0MTc57r5X35uIg/KhtmcaE6DcpxImMd9xETtjVuHiBTvPLLm
 vhfk9g22PDZne8ISXgEG+hs9RO/bJfO5iC/uhf/f3DDzNwggxEnJijM/SLCc/i8iIlLbqPs1Z
 vVH2v9j6cT1m3xfUDBlEYVvOPbvxEtlBwOWubr6r8nBLGYCOvU82DkNw7sJQ=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The :doc: reference did not match the DOC comment's name.

Fixes: 5fc537bfd000 ("drm/mcde: Add new driver for ST-Ericsson MCDE")
Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
=2D--
 Documentation/gpu/mcde.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/gpu/mcde.rst b/Documentation/gpu/mcde.rst
index c69e977defda..dd43dde379e0 100644
=2D-- a/Documentation/gpu/mcde.rst
+++ b/Documentation/gpu/mcde.rst
@@ -5,4 +5,4 @@
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D

 .. kernel-doc:: drivers/gpu/drm/mcde/mcde_drv.c
-   :doc: ST-Ericsson MCDE DRM Driver
+   :doc: ST-Ericsson MCDE Driver
=2D-
2.20.1

