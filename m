Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A46BC10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 15:53:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A73A20850
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 15:53:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727092AbfDLPxb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 11:53:31 -0400
Received: from mga04.intel.com ([192.55.52.120]:18727 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726808AbfDLPxa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 11:53:30 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Apr 2019 08:53:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,341,1549958400"; 
   d="scan'208";a="160835576"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 12 Apr 2019 08:53:27 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1hEyUZ-00073d-HH; Fri, 12 Apr 2019 23:53:27 +0800
Date:   Fri, 12 Apr 2019 23:52:43 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Nick Crews <ncrews@chromium.org>
Cc:     kbuild-all@01.org, enric.balletbo@collabora.com,
        bleung@chromium.org, sre@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dlaurie@chromium.org,
        lamzin@google.com, bartfab@google.com, derat@google.com,
        groeck@google.com, dtor@google.com, sjg@chromium.org,
        jchwong@chromium.org, Nick Crews <ncrews@chromium.org>
Subject: Re: [PATCH v3 2/2] power_supply: platform/chrome: wilco_ec: Add
 charging config driver
Message-ID: <201904122335.RtGa2sij%lkp@intel.com>
References: <20190412002055.92529-2-ncrews@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190412002055.92529-2-ncrews@chromium.org>
X-Patchwork-Hint: ignore
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nick,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on linus/master]
[also build test WARNING on v5.1-rc4 next-20190412]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Nick-Crews/power_supply-Add-more-charge-types-and-CHARGE_CONTROL_-properties/20190412-211253


coccinelle warnings: (new ones prefixed by >>)

>> drivers/platform/chrome/wilco_ec/charge_config.c:173:1-3: WARNING: PTR_ERR_OR_ZERO can be used

Please review and possibly fold the followup patch.

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
