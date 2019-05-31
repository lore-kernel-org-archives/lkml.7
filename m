Return-Path: <SRS0=bMiL=T7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C11DC04AB6
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 17:10:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B79426CDD
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 17:10:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726831AbfEaRKp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 May 2019 13:10:45 -0400
Received: from mga06.intel.com ([134.134.136.31]:8023 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726518AbfEaRKo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 May 2019 13:10:44 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 31 May 2019 10:10:44 -0700
X-ExtLoop1: 1
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 31 May 2019 10:10:42 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1hWl3C-000GNz-4N; Sat, 01 Jun 2019 01:10:42 +0800
Date:   Sat, 1 Jun 2019 01:10:01 +0800
From:   kbuild test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     kbuild-all@01.org, linux-kernel@vger.kernel.org
Subject: [rcu:test 69/69] arch/arm/include/asm/irqflags.h:171:2: warning:
 'flags' may be used uninitialized in this function
Message-ID: <201906010155.Q62ezt8n%lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="IJpNTDwzlM2Ie8A6"
Content-Disposition: inline
X-Patchwork-Hint: ignore
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--IJpNTDwzlM2Ie8A6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git test
head:   685a26bc60076305987bf06cfd1269e5e4094c73
commit: 685a26bc60076305987bf06cfd1269e5e4094c73 [69/69] rcu/nocb: Avoid ->nocb_lock capture by corresponding CPU
config: arm-realview_defconfig (attached as .config)
compiler: arm-linux-gnueabi-gcc (GCC) 7.4.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout 685a26bc60076305987bf06cfd1269e5e4094c73
        # save the attached .config to linux build tree
        GCC_VERSION=7.4.0 make.cross ARCH=arm 

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>

Note: it may well be a FALSE warning. FWIW you are at least aware of it now.
http://gcc.gnu.org/wiki/Better_Uninitialized_Warnings

All warnings (new ones prefixed by >>):

   In file included from kernel/rcu/tree.c:3519:0:
   kernel/rcu/tree_plugin.h: In function 'do_nocb_deferred_wakeup_common':
   kernel/rcu/tree_plugin.h:1891:2: warning: 'flags' may be used uninitialized in this function [-Wmaybe-uninitialized]
     wake_nocb_gp(rdp, ndw == RCU_NOCB_WAKE_FORCE, flags);
     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   In file included from include/linux/irqflags.h:16:0,
                    from arch/arm/include/asm/bitops.h:28,
                    from include/linux/bitops.h:19,
                    from include/linux/kernel.h:12,
                    from kernel/rcu/tree.c:21:
   kernel/rcu/tree_plugin.h: In function 'rcu_nocb_gp_kthread':
>> arch/arm/include/asm/irqflags.h:171:2: warning: 'flags' may be used uninitialized in this function [-Wmaybe-uninitialized]
     asm volatile(
     ^~~
   In file included from kernel/rcu/tree.c:3519:0:
   kernel/rcu/tree_plugin.h:1719:16: note: 'flags' was declared here
     unsigned long flags;
                   ^~~~~
--
   In file included from kernel//rcu/tree.c:3519:0:
   kernel//rcu/tree_plugin.h: In function 'do_nocb_deferred_wakeup_common':
   kernel//rcu/tree_plugin.h:1891:2: warning: 'flags' may be used uninitialized in this function [-Wmaybe-uninitialized]
     wake_nocb_gp(rdp, ndw == RCU_NOCB_WAKE_FORCE, flags);
     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   In file included from include/linux/irqflags.h:16:0,
                    from arch/arm/include/asm/bitops.h:28,
                    from include/linux/bitops.h:19,
                    from include/linux/kernel.h:12,
                    from kernel//rcu/tree.c:21:
   kernel//rcu/tree_plugin.h: In function 'rcu_nocb_gp_kthread':
>> arch/arm/include/asm/irqflags.h:171:2: warning: 'flags' may be used uninitialized in this function [-Wmaybe-uninitialized]
     asm volatile(
     ^~~
   In file included from kernel//rcu/tree.c:3519:0:
   kernel//rcu/tree_plugin.h:1719:16: note: 'flags' was declared here
     unsigned long flags;
                   ^~~~~

vim +/flags +171 arch/arm/include/asm/irqflags.h

7ad1bcb2 include/asm-arm/irqflags.h      Russell King    2006-08-27  164  
7ad1bcb2 include/asm-arm/irqflags.h      Russell King    2006-08-27  165  /*
7ad1bcb2 include/asm-arm/irqflags.h      Russell King    2006-08-27  166   * restore saved IRQ & FIQ state
7ad1bcb2 include/asm-arm/irqflags.h      Russell King    2006-08-27  167   */
6fb18ac9 arch/arm/include/asm/irqflags.h Daniel Thompson 2015-06-10  168  #define arch_local_irq_restore arch_local_irq_restore
df9ee292 arch/arm/include/asm/irqflags.h David Howells   2010-10-07  169  static inline void arch_local_irq_restore(unsigned long flags)
df9ee292 arch/arm/include/asm/irqflags.h David Howells   2010-10-07  170  {
df9ee292 arch/arm/include/asm/irqflags.h David Howells   2010-10-07 @171  	asm volatile(
55bdd694 arch/arm/include/asm/irqflags.h Catalin Marinas 2010-05-21  172  		"	msr	" IRQMASK_REG_NAME_W ", %0	@ local_irq_restore"
df9ee292 arch/arm/include/asm/irqflags.h David Howells   2010-10-07  173  		:
df9ee292 arch/arm/include/asm/irqflags.h David Howells   2010-10-07  174  		: "r" (flags)
df9ee292 arch/arm/include/asm/irqflags.h David Howells   2010-10-07  175  		: "memory", "cc");
df9ee292 arch/arm/include/asm/irqflags.h David Howells   2010-10-07  176  }
df9ee292 arch/arm/include/asm/irqflags.h David Howells   2010-10-07  177  

:::::: The code at line 171 was first introduced by commit
:::::: df9ee29270c11dba7d0fe0b83ce47a4d8e8d2101 Fix IRQ flag handling naming

:::::: TO: David Howells <dhowells@redhat.com>
:::::: CC: David Howells <dhowells@redhat.com>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--IJpNTDwzlM2Ie8A6
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
aS2qPwELrgqvIkABAA==

--IJpNTDwzlM2Ie8A6--
