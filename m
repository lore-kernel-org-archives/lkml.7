Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97656C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 16:53:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CEAF218D0
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 16:53:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727598AbfDOQx2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 12:53:28 -0400
Received: from mga17.intel.com ([192.55.52.151]:7333 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725972AbfDOQx1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 12:53:27 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Apr 2019 09:53:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,354,1549958400"; 
   d="scan'208";a="223727566"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 15 Apr 2019 09:53:25 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1hG4rE-000Irx-L1; Tue, 16 Apr 2019 00:53:24 +0800
Date:   Tue, 16 Apr 2019 00:52:38 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Pascal PAILLET-LME <p.paillet@st.com>
Cc:     kbuild-all@01.org, Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
Subject: [regulator:for-next 103/105] drivers/regulator/stm32-pwr.c:35:5:
 sparse: symbol 'ready_mask_table' was not declared. Should it be static?
Message-ID: <201904160046.ggavw2OV%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Patchwork-Hint: ignore
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next
head:   598387d3ce4bd982272a2bc990dfad6d67d20efd
commit: 6cdae8173f6771977c3863bac7f1455c96bb1f6e [103/105] regulator: Add support for stm32 power regulators
reproduce:
        # apt-get install sparse
        git checkout 6cdae8173f6771977c3863bac7f1455c96bb1f6e
        make ARCH=x86_64 allmodconfig
        make C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__'


sparse warnings: (new ones prefixed by >>)

>> drivers/regulator/stm32-pwr.c:35:5: sparse: symbol 'ready_mask_table' was not declared. Should it be static?
>> drivers/regulator/stm32-pwr.c:47:5: sparse: symbol 'stm32_pwr_reg_is_ready' was not declared. Should it be static?
>> drivers/regulator/stm32-pwr.c:57:5: sparse: symbol 'stm32_pwr_reg_is_enabled' was not declared. Should it be static?

Please review and possibly fold the followup patch.

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
