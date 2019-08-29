Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F6E7C3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 18:52:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0098F2166E
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 18:52:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728610AbfH2Swe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 14:52:34 -0400
Received: from mga11.intel.com ([192.55.52.93]:50853 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727798AbfH2Swd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 14:52:33 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Aug 2019 11:52:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,444,1559545200"; 
   d="scan'208";a="205836344"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 29 Aug 2019 11:52:25 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1i3PWy-000Edp-Qf; Fri, 30 Aug 2019 02:52:24 +0800
Date:   Fri, 30 Aug 2019 02:51:35 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Rahul Tanwar <rahul.tanwar@linux.intel.com>
Cc:     kbuild-all@01.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, hpa@zytor.com, tony.luck@intel.com, x86@kernel.org,
        andriy.shevchenko@intel.com, alan@linux.intel.com,
        linux-kernel@vger.kernel.org, qi-ming.wu@intel.com,
        chuanhua.lei@linux.intel.com, cheol.yong.kim@intel.com,
        rahul.tanwar@intel.com, Rahul Tanwar <rahul.tanwar@linux.intel.com>
Subject: Re: [PATCH v2 1/1] x86/init: Noop get/set wallclock when platform
 doesn't support RTC
Message-ID: <201908300248.W8vwpC3z%lkp@intel.com>
References: <199d34bc514d4fbf2058a862918dc6a71390c48f.1566895445.git.rahul.tanwar@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <199d34bc514d4fbf2058a862918dc6a71390c48f.1566895445.git.rahul.tanwar@linux.intel.com>
X-Patchwork-Hint: ignore
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rahul,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on linus/master]
[cannot apply to v5.3-rc6 next-20190829]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Rahul-Tanwar/x86-init-Noop-get-set-wallclock-when-platform-doesn-t-support-RTC/20190829-202237
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.1-rc1-7-g2b96cd8-dirty
        make ARCH=x86_64 allmodconfig
        make C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__'

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)

>> arch/x86/kernel/x86_init.c:42:6: sparse: sparse: symbol 'x86_wallclock_init' was not declared. Should it be static?

Please review and possibly fold the followup patch.

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
