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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3992CC352AA
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 15:39:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08A4221920
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 15:39:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="kWLlsgWp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727783AbfJBPjQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 11:39:16 -0400
Received: from mout.gmx.net ([212.227.17.22]:49815 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726233AbfJBPjP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 11:39:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1570030737;
        bh=7UNQa6APdXCQXKmz4/u06gNevWXgMiwFA0a8UcA0ctY=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=kWLlsgWpRAk+ojVf5qCKKag7laV6AiQCVwaZH6gmYMO8klQbYPOY9jS13xFSFrHfB
         WzYjDxMO6ErVjF9yrhZFIL3cS58U4ODEKKeSybs/NddlxMjp/PqrqQFAz+USzNs0BB
         T1z42Qxz37Vm2EY0yzupKEMph4ZcczZrFcqV4dPQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([109.90.233.87]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M26vB-1iIAky2d21-002ZYR; Wed, 02
 Oct 2019 17:38:57 +0200
From:   =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     dri-devel@lists.freedesktop.org
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Sean Paul <sean@poorly.run>, Jonathan Corbet <corbet@lwn.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
Subject: [PATCH 2/2] drm/mcde: Fix Sphinx formatting
Date:   Wed,  2 Oct 2019 17:38:27 +0200
Message-Id: <20191002153827.23026-2-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191002153827.23026-1-j.neuschaefer@gmx.net>
References: <20191002153827.23026-1-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:+HGwyEkEJ1bTWVKUnQD498SQcfuBEXN7W3Cj2BGlplSjTF4nz8f
 cBUw6lk5d0t6dvZbTJEE0d3SOQTGqREpxLdnWvFCAT0RVu51e1dc03+JVBM+f6FILbK5lqA
 8DIH19MLF2K5FCSv83/YTi+Y5kG5g9G+P/NYzqFHgNz8SSVUzP4Yh9CPwzyyIpWRJQRi8kz
 pkHWoe2H4jisRK4hILzvQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:P8/WDH8GVeE=:6b+d5EuIc/tVdwLd5A16CG
 BuM36A4vHcQb1ol4jEVAMCpAfjgb3WWIzJ8gC4d71cVGbSjg1rAsK6Jgnb/iiD28VZUjzU45e
 5O96n3cpNR0lHAjzrjJfUMujf39LfDPF5dLXPodCCigFNMnre2kJPJ1raa20o51coUNP5ReH6
 KX4I0jc1+VVrB5Ug9liLNNbGqxisUBiBkc/EbdisjI5ekxfCSMVdGV9x/OBpQmFBJziprBLy0
 C1lf5Vli46BMrembrkjYsjP0WLw7TBMqgyzgDspVroE+cfkc9CLc6vkOndW6JaMgy1VsfqzmT
 +Bb1yZm4FUIpkXk9TCM6orKGpKHszWV7v4U4UbtIAmazoFPtXyMFsyv96OlKcbph4oZl+zEmH
 ht/kud1GLODIr4eCRdJWVHR+yz0/arq1VkllN76f7/8gj2FnQ4jZjhYDQVk1BBKEJVJTFXVGy
 +iDEm1nA/qO1zaV3W+M1yoA6n2N2niVGMUYTagS3Fya0S4Rd3BQ5QrvIDEHdjo3f4QkOG4B62
 ao2FMZ6rRveeQ9cj1xgSMOAyDN8NKBaREVV2nM8Ywn0RUQAwA4p6S7iL88dAR3937iJpXbcx3
 s8zf7vAACbuwo+8alJCoIu0/p1440kqKXkIOOxN8btKtzQRNeAwxqDuyMD6+uo45XCDwueH3N
 eI+7+rUGcVKzT+rW4VjF9n8z25T1dLw+9+DkGsSsJajvFJacRH4qi0u2CDgCcukJkC5fbUHKA
 T8zuo/ujkV8Vn1QRxE3ZjLok2NsAIdAa+bk3HcXWUM5CazJcQHin5fwcFDHEeR4CYb77cf31t
 45xmVgB2MH5wVhGgQ4LuQWv4LTGtzddVfIuMeF+MyBkXfo7BizEnMq02HuKzfNs4LMYfrclZj
 G43I1rkIH9bNLV5dq5VFopiuOdNDbYGzPEjcVE/VutyGlVJPmlgwwhyKdi3R5FUKrz+PuVeiG
 xOJpWlV4dWUNbgDJz+eRv+9kdRerhI6ZDQhDcDf/JhCH26+fU3VuHbY6ebmHBWbJT82SqDZle
 t8Tze4K8fuNmgg4TWi/Kxps347pHZ3Nh1A5MDjiGYCrxQbEfZXQyyVw7lo/Uf6gyb0EdvR+Kw
 OB4LVkRJpeEtPnXf6wxyd1t/1WmM4fQsufeZb27IPu2jdajVOmlNw19ecaJpB7QVMv0jSCRL0
 C9fDO15mANqZFvDAca5EvqMUj2BiDDljV9RlfHzW1xVGns6XEXQsv5jMp8Kg8refqKCKM/bl8
 umAQ+YaRtF5q/lRjv1sH3P7MvvaXrcgS/xNI5kz0IJKsdbsBZGY41DgThUt8=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

- Format the pipe diagram as a monospace block.
- Fix formatting of the list. Without the empty line, the first dash is
  not parsed as a bullet point.

Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
=2D--
 drivers/gpu/drm/mcde/mcde_drv.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/mcde/mcde_drv.c b/drivers/gpu/drm/mcde/mcde_d=
rv.c
index 9a09eba53182..c535abed4765 100644
=2D-- a/drivers/gpu/drm/mcde/mcde_drv.c
+++ b/drivers/gpu/drm/mcde/mcde_drv.c
@@ -20,11 +20,11 @@
  * input formats including most variants of RGB and YUV.
  *
  * The hardware has four display pipes, and the layout is a little
- * bit like this:
+ * bit like this::
  *
- * Memory     -> Overlay -> Channel -> FIFO -> 5 formatters -> DSI/DPI
- * External      0..5       0..3       A,B,    3 x DSI         bridge
- * source 0..9                         C0,C1   2 x DPI
+ *   Memory     -> Overlay -> Channel -> FIFO -> 5 formatters -> DSI/DPI
+ *   External      0..5       0..3       A,B,    3 x DSI         bridge
+ *   source 0..9                         C0,C1   2 x DPI
  *
  * FIFOs A and B are for LCD and HDMI while FIFO CO/C1 are for
  * panels with embedded buffer.
@@ -43,6 +43,7 @@
  * to change as we exploit more of the hardware capabilities.
  *
  * TODO:
+ *
  * - Enabled damaged rectangles using drm_plane_enable_fb_damage_clips()
  *   so we can selectively just transmit the damaged area to a
  *   command-only display.
=2D-
2.20.1

