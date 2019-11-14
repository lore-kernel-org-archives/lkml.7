Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E98A2C432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 15:33:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE86B206F4
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 15:33:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726949AbfKNPdN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 10:33:13 -0500
Received: from mga06.intel.com ([134.134.136.31]:37154 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726339AbfKNPdN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 10:33:13 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Nov 2019 07:33:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,304,1569308400"; 
   d="scan'208";a="405008904"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 14 Nov 2019 07:33:09 -0800
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1iVH7N-0003cb-Er; Thu, 14 Nov 2019 23:33:09 +0800
Date:   Thu, 14 Nov 2019 23:33:04 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Ben Zhang <benzh@chromium.org>
Cc:     kbuild-all@lists.01.org, Mark Brown <broonie@kernel.org>,
        Curtis Malainey <cujomalainey@chromium.org>,
        Bard Liao <bardliao@realtek.com>,
        Oder Chiou <oder_chiou@realtek.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH linux-next] ASoC: rt5677: rt5677_check_hotword() can be
 static
Message-ID: <20191114153304.n4pyix7qadu76tx4@4978f4969bb8>
References: <201911142322.pHmcOJHb%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201911142322.pHmcOJHb%lkp@intel.com>
X-Patchwork-Hint: ignore
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Fixes: 21c00e5df439 ("ASoC: rt5677: Enable jack detect while DSP is running")
Signed-off-by: kbuild test robot <lkp@intel.com>
---
 rt5677.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/rt5677.c b/sound/soc/codecs/rt5677.c
index 48955b22262fa..cd01a3a8daa82 100644
--- a/sound/soc/codecs/rt5677.c
+++ b/sound/soc/codecs/rt5677.c
@@ -5243,7 +5243,7 @@ static const struct rt5677_irq_desc rt5677_irq_descs[] = {
 	},
 };
 
-bool rt5677_check_hotword(struct rt5677_priv *rt5677)
+static bool rt5677_check_hotword(struct rt5677_priv *rt5677)
 {
 	int reg_gpio;
 
