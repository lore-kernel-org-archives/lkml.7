Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7147AC32751
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 16:48:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40D642229C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 16:48:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388782AbfHGQs6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 12:48:58 -0400
Received: from mga02.intel.com ([134.134.136.20]:20914 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387922AbfHGQs5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 12:48:57 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Aug 2019 09:35:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,357,1559545200"; 
   d="gz'50?scan'50,208,50";a="203250364"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 07 Aug 2019 09:35:56 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1hvOuq-000DUf-Bm; Thu, 08 Aug 2019 00:35:56 +0800
Date:   Thu, 8 Aug 2019 00:35:24 +0800
From:   kbuild test robot <lkp@intel.com>
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc:     kbuild-all@01.org, linux-kernel@vger.kernel.org,
        "Paul E. McKenney" <paulmck@linux.ibm.com>
Subject: [rcu:dev.2019.08.01a 57/113] drivers/base/core.c:102:9: error:
 implicit declaration of function 'lock_is_held'; did you mean
 'clock_was_set'?
Message-ID: <201908080022.ie6TWHBS%lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="pgxhbgyrk32j6kkt"
Content-Disposition: inline
X-Patchwork-Hint: ignore
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--pgxhbgyrk32j6kkt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://kernel.googlesource.com/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2019.08.01a
head:   00ec8f46465e07c72f2813cc346f6e7e8749ea98
commit: 24f1c2ad7b902c9ab867518b5258d4db70f28ec0 [57/113] acpi: Use built-in RCU list checking for acpi_ioremaps list
config: sparc64-allnoconfig (attached as .config)
compiler: sparc64-linux-gcc (GCC) 7.4.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout 24f1c2ad7b902c9ab867518b5258d4db70f28ec0
        # save the attached .config to linux build tree
        GCC_VERSION=7.4.0 make.cross ARCH=sparc64 

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/base/core.c: In function 'device_links_read_lock_held':
>> drivers/base/core.c:102:9: error: implicit declaration of function 'lock_is_held'; did you mean 'clock_was_set'? [-Werror=implicit-function-declaration]
     return lock_is_held(&device_links_lock);
            ^~~~~~~~~~~~
            clock_was_set
   cc1: some warnings being treated as errors

vim +102 drivers/base/core.c

    99	
   100	int device_links_read_lock_held(void)
   101	{
 > 102		return lock_is_held(&device_links_lock);
   103	}
   104	#endif /* !CONFIG_SRCU */
   105	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--pgxhbgyrk32j6kkt
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
C0gXCQDtbGBm/k8AAA==

--pgxhbgyrk32j6kkt--
