Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78D8AC48BD3
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 16:14:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 426DB2084B
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 16:14:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561565660;
	bh=evdGKyD5k1ccTowkp8GnBdRSislkNYG2obtcT6+5mYw=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=mg0liKbVxNq35bIpDBRrIF+q9PKmgvxJD9m5SN8Jyy6faBFm7YsEYpATpRHSKIaE9
	 HBYxkyYIXXh87FfO/1MLmCkL+VaDg2A5UM/BkMmOvp85mEjtSP9p5+M1UOur0S1R5g
	 EDg8mflrOhQWgEIBYZTaU1XFxI7ejW2BZxBsu3gA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726596AbfFZQOS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 12:14:18 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:57896 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726227AbfFZQOS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 12:14:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=xgArw+nVtTXG7oezfdfD4Z1XiVxNfU8kA8v4SVH+Er8=; b=H8pU6ksMjxPS9r4Rpfv5NA8Hz
        +YS3Oa+ujur3g18XgsDxJQe7f0Mom3EwR5DPIW1GpwAsW1jzd2koULTevDvSOhS7aq+XgZ8HxwiEd
        TBJx1lvgP3P1uks1zEwTL8j7Hk4nAcViKpVzEblKnZXK/C+HKQtdfxbKWHZsRXvpw3hQ3QguTYSzj
        JBRdRCxyzdLJaecnl2YkSxGuJsNkXk4L6tW9lObvi87S5GEGoXU+4/ezOe6GXvTzXJGIAHftGd4GY
        TIQerjgzoce7Z+9ZJOXftSSONKMRf1AWdCShlccCI1jecYU5SL21L+gMj2G/RJa69lKnhkG2NiOtd
        dd95/mUQg==;
Received: from [186.213.242.156] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hgAYq-0004wb-Ov; Wed, 26 Jun 2019 16:14:16 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hgAYo-0008AF-RE; Wed, 26 Jun 2019 13:14:14 -0300
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
Subject: [PATCH] drm: fix a reference for a renamed file: fb/modedb.rst
Date:   Wed, 26 Jun 2019 13:14:13 -0300
Message-Id: <699d7618720e2808f9aa094a13ab2f3545c3c25c.1561565652.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Due to two patches being applied about the same time, the
reference for modedb.rst file got wrong:

	Documentation/fb/modedb.txt is now Documentation/fb/modedb.rst.

Fixes: 1bf4e09227c3 ("drm/modes: Allow to specify rotation and reflection on the commandline")
Fixes: ab42b818954c ("docs: fb: convert docs to ReST and rename to *.rst")
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 drivers/gpu/drm/drm_modes.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_modes.c b/drivers/gpu/drm/drm_modes.c
index 57e6408288c8..4645af681ef8 100644
--- a/drivers/gpu/drm/drm_modes.c
+++ b/drivers/gpu/drm/drm_modes.c
@@ -1680,7 +1680,7 @@ static int drm_mode_parse_cmdline_options(char *str, size_t len,
  *
  * Additionals options can be provided following the mode, using a comma to
  * separate each option. Valid options can be found in
- * Documentation/fb/modedb.txt.
+ * Documentation/fb/modedb.rst.
  *
  * The intermediate drm_cmdline_mode structure is required to store additional
  * options from the command line modline like the force-enable/disable flag.
-- 
2.21.0

