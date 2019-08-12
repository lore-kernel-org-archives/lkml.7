Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3393C433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 21:00:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A1D22085A
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 21:00:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726770AbfHLVAN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 17:00:13 -0400
Received: from mga06.intel.com ([134.134.136.31]:43664 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726974AbfHLVAK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 17:00:10 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Aug 2019 13:59:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,378,1559545200"; 
   d="gz'50?scan'50,208,50";a="166849418"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 12 Aug 2019 13:59:42 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1hxHPq-0007pS-BE; Tue, 13 Aug 2019 04:59:42 +0800
Date:   Tue, 13 Aug 2019 04:58:44 +0800
From:   kbuild test robot <lkp@intel.com>
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc:     kbuild-all@01.org, linux-kernel@vger.kernel.org,
        "Paul E. McKenney" <paulmck@linux.ibm.com>
Subject: [rcu:rcu/next 27/86] drivers/base/core.c:102:9: error: implicit
 declaration of function 'lock_is_held'; did you mean 'lockref_get'?
Message-ID: <201908130428.TFrFvLFs%lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="55kactpty27s4oex"
Content-Disposition: inline
X-Patchwork-Hint: ignore
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--55kactpty27s4oex
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://kernel.googlesource.com/pub/scm/linux/kernel/git/paulmck/linux-rcu.git rcu/next
head:   eee850b8c265f38ab5feeb8fe6793b1b86eb77c7
commit: 4a3a5474b4c14fc6bc57b2d30cfbf20b54d54989 [27/86] driver/core: Convert to use built-in RCU list checking
config: parisc-allnoconfig (attached as .config)
compiler: hppa-linux-gcc (GCC) 7.4.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout 4a3a5474b4c14fc6bc57b2d30cfbf20b54d54989
        # save the attached .config to linux build tree
        GCC_VERSION=7.4.0 make.cross ARCH=parisc 

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/base/core.c: In function 'device_links_read_lock_held':
>> drivers/base/core.c:102:9: error: implicit declaration of function 'lock_is_held'; did you mean 'lockref_get'? [-Werror=implicit-function-declaration]
     return lock_is_held(&device_links_lock);
            ^~~~~~~~~~~~
            lockref_get
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

--55kactpty27s4oex
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
QQqMcYKQjVRLnt2kgok5/hdCjFCn8UwAAA==

--55kactpty27s4oex--
