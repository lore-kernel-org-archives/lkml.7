Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22D6EC433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 02:34:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F25242173C
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 02:34:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728233AbfHHCeJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 22:34:09 -0400
Received: from mga02.intel.com ([134.134.136.20]:4114 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728020AbfHHCeJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 22:34:09 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Aug 2019 19:33:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,358,1559545200"; 
   d="scan'208";a="168834754"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 07 Aug 2019 19:33:42 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1hvYFK-00077q-AW; Thu, 08 Aug 2019 10:33:42 +0800
Date:   Thu, 8 Aug 2019 10:32:57 +0800
From:   kbuild test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     kbuild-all@01.org, linux-kernel@vger.kernel.org
Subject: [rcu:dev.2019.07.31a 110/123] kernel/rcu/rcu_segcblist.c:61:6:
 sparse: sparse: symbol 'rcu_segcblist_set_len' was not declared. Should it
 be static?
Message-ID: <201908081009.37BaOO5n%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Patchwork-Hint: ignore
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://kernel.googlesource.com/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2019.07.31a
head:   71cf692f482ff45802352cf85a8880035fca9e52
commit: ab2ef5c7b4d1933ee53a66d981cb67974de46815 [110/123] rcu/nocb: Atomic ->len field in rcu_segcblist structure
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.1-rc1-7-g2b96cd8-dirty
        git checkout ab2ef5c7b4d1933ee53a66d981cb67974de46815
        make ARCH=x86_64 allmodconfig
        make C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__'

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)

   kernel/rcu/rcu_segcblist.c:32:6: sparse: sparse: symbol 'rcu_cblist_enqueue' was not declared. Should it be static?
>> kernel/rcu/rcu_segcblist.c:61:6: sparse: sparse: symbol 'rcu_segcblist_set_len' was not declared. Should it be static?
>> kernel/rcu/rcu_segcblist.c:77:6: sparse: sparse: symbol 'rcu_segcblist_add_len' was not declared. Should it be static?
   kernel/rcu/rcu_segcblist.c:96:6: sparse: sparse: symbol 'rcu_segcblist_inc_len' was not declared. Should it be static?
>> kernel/rcu/rcu_segcblist.c:107:6: sparse: sparse: symbol 'rcu_segcblist_xchg_len' was not declared. Should it be static?

Please review and possibly fold the followup patch.

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
