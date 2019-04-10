Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12D5CC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 10:51:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBA8B20850
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 10:51:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730793AbfDJKvT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 06:51:19 -0400
Received: from mga14.intel.com ([192.55.52.115]:40259 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727661AbfDJKvT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 06:51:19 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Apr 2019 03:51:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,332,1549958400"; 
   d="gz'50?scan'50,208,50";a="314669443"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 10 Apr 2019 03:51:16 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1hEAp2-000H9W-9M; Wed, 10 Apr 2019 18:51:16 +0800
Date:   Wed, 10 Apr 2019 18:50:35 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Waiman Long <longman@redhat.com>
Cc:     kbuild-all@01.org, linux-kernel@vger.kernel.org,
        tipbuild@zytor.com, Ingo Molnar <mingo@kernel.org>
Subject: [tip:WIP.locking/core 28/29] kernel/locking/rwsem.h:335:9: error:
 implicit declaration of function 'is_rwsem_owner_reader'; did you mean
 'rwsem_owner_count'?
Message-ID: <201904101833.oAfkSbvr%lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="d6Gm4EdcadzBjdND"
Content-Disposition: inline
X-Patchwork-Hint: ignore
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--d6Gm4EdcadzBjdND
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git WIP.locking/core
head:   5c587ed687faed2eb0afdd669ddd167d0d940236
commit: 0d8bd477cd9602fb18bee6e3dae41c5fda9cebab [28/29] locking/rwsem: Merge owner into count on x86-64
config: riscv-tinyconfig (attached as .config)
compiler: riscv64-linux-gcc (GCC) 8.1.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout 0d8bd477cd9602fb18bee6e3dae41c5fda9cebab
        # save the attached .config to linux build tree
        GCC_VERSION=8.1.0 make.cross ARCH=riscv 

All errors (new ones prefixed by >>):

   In file included from include/linux/kernel.h:11,
                    from kernel/locking/rwsem.c:9:
   kernel/locking/rwsem.h: In function 'rwsem_set_nonspinnable':
   kernel/locking/rwsem.h:333:34: error: 'struct rw_semaphore' has no member named 'owner'
     long owner = (long)READ_ONCE(sem->owner);
                                     ^~
   include/linux/compiler.h:255:17: note: in definition of macro '__READ_ONCE'
     union { typeof(x) __val; char __c[1]; } __u;   \
                    ^
   kernel/locking/rwsem.h:333:21: note: in expansion of macro 'READ_ONCE'
     long owner = (long)READ_ONCE(sem->owner);
                        ^~~~~~~~~
   kernel/locking/rwsem.h:333:34: error: 'struct rw_semaphore' has no member named 'owner'
     long owner = (long)READ_ONCE(sem->owner);
                                     ^~
   include/linux/compiler.h:257:22: note: in definition of macro '__READ_ONCE'
      __read_once_size(&(x), __u.__c, sizeof(x));  \
                         ^
   kernel/locking/rwsem.h:333:21: note: in expansion of macro 'READ_ONCE'
     long owner = (long)READ_ONCE(sem->owner);
                        ^~~~~~~~~
   kernel/locking/rwsem.h:333:34: error: 'struct rw_semaphore' has no member named 'owner'
     long owner = (long)READ_ONCE(sem->owner);
                                     ^~
   include/linux/compiler.h:257:42: note: in definition of macro '__READ_ONCE'
      __read_once_size(&(x), __u.__c, sizeof(x));  \
                                             ^
   kernel/locking/rwsem.h:333:21: note: in expansion of macro 'READ_ONCE'
     long owner = (long)READ_ONCE(sem->owner);
                        ^~~~~~~~~
   kernel/locking/rwsem.h:333:34: error: 'struct rw_semaphore' has no member named 'owner'
     long owner = (long)READ_ONCE(sem->owner);
                                     ^~
   include/linux/compiler.h:259:30: note: in definition of macro '__READ_ONCE'
      __read_once_size_nocheck(&(x), __u.__c, sizeof(x)); \
                                 ^
   kernel/locking/rwsem.h:333:21: note: in expansion of macro 'READ_ONCE'
     long owner = (long)READ_ONCE(sem->owner);
                        ^~~~~~~~~
   kernel/locking/rwsem.h:333:34: error: 'struct rw_semaphore' has no member named 'owner'
     long owner = (long)READ_ONCE(sem->owner);
                                     ^~
   include/linux/compiler.h:259:50: note: in definition of macro '__READ_ONCE'
      __read_once_size_nocheck(&(x), __u.__c, sizeof(x)); \
                                                     ^
   kernel/locking/rwsem.h:333:21: note: in expansion of macro 'READ_ONCE'
     long owner = (long)READ_ONCE(sem->owner);
                        ^~~~~~~~~
   In file included from kernel/locking/rwsem.c:16:
>> kernel/locking/rwsem.h:335:9: error: implicit declaration of function 'is_rwsem_owner_reader'; did you mean 'rwsem_owner_count'? [-Werror=implicit-function-declaration]
     while (is_rwsem_owner_reader((struct task_struct *)owner)) {
            ^~~~~~~~~~~~~~~~~~~~~
            rwsem_owner_count
   kernel/locking/rwsem.h:336:8: error: implicit declaration of function 'is_rwsem_owner_spinnable'; did you mean 'rwsem_set_nonspinnable'? [-Werror=implicit-function-declaration]
      if (!is_rwsem_owner_spinnable((struct task_struct *)owner))
           ^~~~~~~~~~~~~~~~~~~~~~~~
           rwsem_set_nonspinnable
   In file included from arch/riscv/include/asm/atomic.h:23,
                    from include/linux/atomic.h:7,
                    from include/linux/rcupdate.h:25,
                    from include/linux/rculist.h:11,
                    from include/linux/pid.h:5,
                    from include/linux/sched.h:14,
                    from kernel/locking/rwsem.c:10:
   kernel/locking/rwsem.h:338:31: error: 'struct rw_semaphore' has no member named 'owner'
      owner = cmpxchg((long *)&sem->owner, owner,
                                  ^~
   arch/riscv/include/asm/cmpxchg.h:350:15: note: in definition of macro 'cmpxchg'
     __typeof__(*(ptr)) _o_ = (o);     \
                  ^~~
   kernel/locking/rwsem.h:338:31: error: 'struct rw_semaphore' has no member named 'owner'
      owner = cmpxchg((long *)&sem->owner, owner,
                                  ^~
   arch/riscv/include/asm/cmpxchg.h:351:15: note: in definition of macro 'cmpxchg'
     __typeof__(*(ptr)) _n_ = (n);     \
                  ^~~
   kernel/locking/rwsem.h:338:31: error: 'struct rw_semaphore' has no member named 'owner'
      owner = cmpxchg((long *)&sem->owner, owner,
                                  ^~
   arch/riscv/include/asm/cmpxchg.h:352:16: note: in definition of macro 'cmpxchg'
     (__typeof__(*(ptr))) __cmpxchg((ptr),    \
                   ^~~
   kernel/locking/rwsem.h:338:31: error: 'struct rw_semaphore' has no member named 'owner'
      owner = cmpxchg((long *)&sem->owner, owner,
                                  ^~
   arch/riscv/include/asm/cmpxchg.h:312:13: note: in definition of macro '__cmpxchg'
     __typeof__(ptr) __ptr = (ptr);     \
                ^~~
   kernel/locking/rwsem.h:338:11: note: in expansion of macro 'cmpxchg'
      owner = cmpxchg((long *)&sem->owner, owner,
              ^~~~~~~
   kernel/locking/rwsem.h:338:31: error: 'struct rw_semaphore' has no member named 'owner'
      owner = cmpxchg((long *)&sem->owner, owner,
                                  ^~
   arch/riscv/include/asm/cmpxchg.h:312:27: note: in definition of macro '__cmpxchg'
     __typeof__(ptr) __ptr = (ptr);     \
                              ^~~
   kernel/locking/rwsem.h:338:11: note: in expansion of macro 'cmpxchg'
      owner = cmpxchg((long *)&sem->owner, owner,
              ^~~~~~~
   kernel/locking/rwsem.h:338:31: error: 'struct rw_semaphore' has no member named 'owner'
      owner = cmpxchg((long *)&sem->owner, owner,
                                  ^~
   arch/riscv/include/asm/cmpxchg.h:313:15: note: in definition of macro '__cmpxchg'
     __typeof__(*(ptr)) __old = (old);    \
                  ^~~
   kernel/locking/rwsem.h:338:11: note: in expansion of macro 'cmpxchg'
      owner = cmpxchg((long *)&sem->owner, owner,
              ^~~~~~~
   kernel/locking/rwsem.h:338:31: error: 'struct rw_semaphore' has no member named 'owner'
      owner = cmpxchg((long *)&sem->owner, owner,
                                  ^~
   arch/riscv/include/asm/cmpxchg.h:314:15: note: in definition of macro '__cmpxchg'
     __typeof__(*(ptr)) __new = (new);    \
                  ^~~
   kernel/locking/rwsem.h:338:11: note: in expansion of macro 'cmpxchg'
      owner = cmpxchg((long *)&sem->owner, owner,
              ^~~~~~~
   kernel/locking/rwsem.h:338:31: error: 'struct rw_semaphore' has no member named 'owner'
      owner = cmpxchg((long *)&sem->owner, owner,
                                  ^~
   arch/riscv/include/asm/cmpxchg.h:315:15: note: in definition of macro '__cmpxchg'
     __typeof__(*(ptr)) __ret;     \
                  ^~~
   kernel/locking/rwsem.h:338:11: note: in expansion of macro 'cmpxchg'
      owner = cmpxchg((long *)&sem->owner, owner,
              ^~~~~~~
   kernel/locking/rwsem.h:338:31: error: 'struct rw_semaphore' has no member named 'owner'
      owner = cmpxchg((long *)&sem->owner, owner,
                                  ^~
   arch/riscv/include/asm/cmpxchg.h:317:10: note: in definition of macro '__cmpxchg'
     switch (size) {       \
             ^~~~
   kernel/locking/rwsem.h:338:11: note: in expansion of macro 'cmpxchg'
      owner = cmpxchg((long *)&sem->owner, owner,
              ^~~~~~~
   arch/riscv/include/asm/cmpxchg.h:326:41: error: invalid type argument of unary '*' (have 'int')
       : "=&r" (__ret), "=&r" (__rc), "+A" (*__ptr) \
                                            ^~~~~~
   arch/riscv/include/asm/cmpxchg.h:352:23: note: in expansion of macro '__cmpxchg'
     (__typeof__(*(ptr))) __cmpxchg((ptr),    \
                          ^~~~~~~~~
   kernel/locking/rwsem.h:338:11: note: in expansion of macro 'cmpxchg'
      owner = cmpxchg((long *)&sem->owner, owner,
              ^~~~~~~
   arch/riscv/include/asm/cmpxchg.h:338:41: error: invalid type argument of unary '*' (have 'int')
       : "=&r" (__ret), "=&r" (__rc), "+A" (*__ptr) \
                                            ^~~~~~
   arch/riscv/include/asm/cmpxchg.h:352:23: note: in expansion of macro '__cmpxchg'
     (__typeof__(*(ptr))) __cmpxchg((ptr),    \

vim +335 kernel/locking/rwsem.h

12a30a7f Waiman Long 2019-04-04  326  
46ad0840 Waiman Long 2019-03-22  327  /*
2d6f2f61 Waiman Long 2019-04-05  328   * Set the RWSEM_ANONYMOUSLY_OWNED flag if the RWSEM_READER_OWNED flag
2d6f2f61 Waiman Long 2019-04-05  329   * remains set. Otherwise, the operation will be aborted.
2d6f2f61 Waiman Long 2019-04-05  330   */
2d6f2f61 Waiman Long 2019-04-05  331  static inline void rwsem_set_nonspinnable(struct rw_semaphore *sem)
2d6f2f61 Waiman Long 2019-04-05  332  {
2d6f2f61 Waiman Long 2019-04-05 @333  	long owner = (long)READ_ONCE(sem->owner);
2d6f2f61 Waiman Long 2019-04-05  334  
2d6f2f61 Waiman Long 2019-04-05 @335  	while (is_rwsem_owner_reader((struct task_struct *)owner)) {
2d6f2f61 Waiman Long 2019-04-05  336  		if (!is_rwsem_owner_spinnable((struct task_struct *)owner))
2d6f2f61 Waiman Long 2019-04-05  337  			break;
2d6f2f61 Waiman Long 2019-04-05  338  		owner = cmpxchg((long *)&sem->owner, owner,
2d6f2f61 Waiman Long 2019-04-05  339  				owner | RWSEM_ANONYMOUSLY_OWNED);
2d6f2f61 Waiman Long 2019-04-05  340  	}
2d6f2f61 Waiman Long 2019-04-05  341  }
2d6f2f61 Waiman Long 2019-04-05  342  

:::::: The code at line 335 was first introduced by commit
:::::: 2d6f2f61367455179ee140b3d4af6974d3e5d06d locking/rwsem: Enable time-based spinning on reader-owned rwsem

:::::: TO: Waiman Long <longman@redhat.com>
:::::: CC: Ingo Molnar <mingo@kernel.org>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--d6Gm4EdcadzBjdND
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
OB+AB3EwyY5Xbd6iiqf/HwwqB1mtOwAA

--d6Gm4EdcadzBjdND--
