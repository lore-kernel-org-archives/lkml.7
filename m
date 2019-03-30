Return-Path: <SRS0=yJb2=SB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E362C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 08:12:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43DE7218A6
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 08:12:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730463AbfC3IMr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Mar 2019 04:12:47 -0400
Received: from mga06.intel.com ([134.134.136.31]:41053 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726385AbfC3IMr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Mar 2019 04:12:47 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Mar 2019 01:12:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,287,1549958400"; 
   d="scan'208";a="159784801"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 30 Mar 2019 01:12:44 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1hA96Z-0002cA-Qo; Sat, 30 Mar 2019 16:12:43 +0800
Date:   Sat, 30 Mar 2019 16:12:15 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Yannick =?iso-8859-1?Q?Fertr=E9?= <yannick.fertre@st.com>
Cc:     kbuild-all@01.org, Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        Yannick Fertre <yannick.fertre@st.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Benjamin Gaignard <benjamin.gaignard@st.com>,
        Philippe Cornu <philippe.cornu@st.com>
Subject: [RFC PATCH] drm/bridge: sii902x: sii902x_cec_init() can be static
Message-ID: <20190330081215.GA24391@lkp-kbuild01>
References: <1553862958-6454-1-git-send-email-yannick.fertre@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1553862958-6454-1-git-send-email-yannick.fertre@st.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Fixes: 1402bda01406 ("drm/bridge: sii902x: initialize CEC device")
Signed-off-by: kbuild test robot <lkp@intel.com>
---
 sii902x.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/sii902x.c b/drivers/gpu/drm/bridge/sii902x.c
index d33c097..42a0a7a 100644
--- a/drivers/gpu/drm/bridge/sii902x.c
+++ b/drivers/gpu/drm/bridge/sii902x.c
@@ -482,7 +482,7 @@ static int sii902x_i2c_bypass_deselect(struct i2c_mux_core *mux, u32 chan_id)
 	return 0;
 }
 
-int sii902x_cec_init(struct device *dev, struct sii902x *sii902x)
+static int sii902x_cec_init(struct device *dev, struct sii902x *sii902x)
 {
 	struct i2c_client *client;
 	int ret;
