Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87B88C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 11:47:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FFE020856
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 11:47:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730743AbfDBLrO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 07:47:14 -0400
Received: from mga05.intel.com ([192.55.52.43]:63193 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729568AbfDBLrN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 07:47:13 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Apr 2019 04:47:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,300,1549958400"; 
   d="scan'208";a="139456936"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 02 Apr 2019 04:47:11 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1hBHsl-0006bi-2F; Tue, 02 Apr 2019 19:47:11 +0800
Date:   Tue, 2 Apr 2019 19:46:16 +0800
From:   kbuild test robot <lkp@intel.com>
To:     "Andrew F. Davis" <afd@ti.com>
Cc:     kbuild-all@01.org, alsa-devel@alsa-project.org,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
        Colin Ian King <colin.king@canonical.com>,
        linux-kernel@vger.kernel.org
Subject: [asoc:for-5.2 98/99] sound/soc/codecs/tlv320aic31xx.c:1267:5:
 sparse: symbol 'aic31xx_set_jack' was not declared. Should it be static?
Message-ID: <201904021912.ym8zWPD9%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.2
head:   90f0202bf2e15e8933a550b7dfd439b500a76e1c
commit: ebf3326cd96989a498892a1b344faee3110f7877 [98/99] ASoC: tlv320aic31xx: Add headphone/headset detection
reproduce:
        # apt-get install sparse
        git checkout ebf3326cd96989a498892a1b344faee3110f7877
        make ARCH=x86_64 allmodconfig
        make C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__'


sparse warnings: (new ones prefixed by >>)

>> sound/soc/codecs/tlv320aic31xx.c:1267:5: sparse: symbol 'aic31xx_set_jack' was not declared. Should it be static?

Please review and possibly fold the followup patch.

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
