Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1386C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 12:39:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D82520878
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 12:39:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730202AbfDXMjQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 08:39:16 -0400
Received: from mga12.intel.com ([192.55.52.136]:57933 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726167AbfDXMjP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 08:39:15 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Apr 2019 05:39:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,389,1549958400"; 
   d="scan'208";a="138403183"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 24 Apr 2019 05:39:13 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1hJHBA-000IYz-Ty; Wed, 24 Apr 2019 20:39:12 +0800
Date:   Wed, 24 Apr 2019 20:38:53 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     kbuild-all@01.org, linux-kernel@vger.kernel.org,
        tipbuild@zytor.com, Ingo Molnar <mingo@kernel.org>
Subject: [tip:core/objtool 26/27] arch/x86/kernel/signal.c:357:16: sparse:
    got unsigned long long [usertype] *__pu_ptr
Message-ID: <201904242047.cHccU4xI%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Patchwork-Hint: ignore
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git core/objtool
head:   29da93fea3ea39ab9b12270cc6be1b70ef201c9e
commit: 6ae865615fc43d014da2fd1f1bba7e81ee622d1b [26/27] x86/uaccess: Dont leak the AC flag into __put_user() argument evaluation
reproduce:
        # apt-get install sparse
        git checkout 6ae865615fc43d014da2fd1f1bba7e81ee622d1b
        make ARCH=x86_64 allmodconfig
        make C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__'

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>

sparse warnings: (new ones prefixed by >>)

   arch/x86/kernel/signal.c:357:16: sparse: sparse: cast removes address space '<asn:1>' of expression
   arch/x86/kernel/signal.c:357:16: sparse: sparse: cast removes address space '<asn:1>' of expression
   arch/x86/kernel/signal.c:357:16: sparse: sparse: cast removes address space '<asn:1>' of expression
   arch/x86/kernel/signal.c:357:16: sparse: sparse: cast removes address space '<asn:1>' of expression
   arch/x86/kernel/signal.c:357:16: sparse: sparse: cast removes address space '<asn:1>' of expression
   arch/x86/kernel/signal.c:357:16: sparse: sparse: cast removes address space '<asn:1>' of expression
   arch/x86/kernel/signal.c:357:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@    expected void const volatile [noderef] <asn:1> * @@    got st volatile [noderef] <asn:1> * @@
   arch/x86/kernel/signal.c:357:16: sparse:    expected void const volatile [noderef] <asn:1> *
>> arch/x86/kernel/signal.c:357:16: sparse:    got unsigned long long [usertype] *__pu_ptr
   arch/x86/kernel/signal.c:417:17: sparse: sparse: cast removes address space '<asn:1>' of expression
   arch/x86/kernel/signal.c:417:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@    expected void const volatile [noderef] <asn:1> * @@    got st volatile [noderef] <asn:1> * @@
   arch/x86/kernel/signal.c:417:17: sparse:    expected void const volatile [noderef] <asn:1> *
   arch/x86/kernel/signal.c:417:17: sparse:    got unsigned long long [usertype] *
   arch/x86/kernel/signal.c:417:17: sparse: sparse: cast removes address space '<asn:1>' of expression
   arch/x86/kernel/signal.c:417:17: sparse: sparse: cast removes address space '<asn:1>' of expression
   arch/x86/kernel/signal.c:417:17: sparse: sparse: cast removes address space '<asn:1>' of expression
   arch/x86/kernel/signal.c:417:17: sparse: sparse: cast removes address space '<asn:1>' of expression
   arch/x86/kernel/signal.c:417:17: sparse: sparse: cast removes address space '<asn:1>' of expression
   arch/x86/kernel/signal.c:417:17: sparse: sparse: cast removes address space '<asn:1>' of expression
   arch/x86/kernel/signal.c:417:17: sparse: sparse: cast removes address space '<asn:1>' of expression
   arch/x86/kernel/signal.c:417:17: sparse: sparse: cast removes address space '<asn:1>' of expression
   arch/x86/kernel/signal.c:417:17: sparse: sparse: cast removes address space '<asn:1>' of expression
   arch/x86/kernel/signal.c:417:17: sparse: sparse: cast removes address space '<asn:1>' of expression

vim +357 arch/x86/kernel/signal.c

75779f05 arch/x86/kernel/signal.c    Hiroshi Shimamoto 2009-02-27  312  
7e907f48 arch/x86/kernel/signal_32.c Ingo Molnar       2008-03-06  313  static int
235b8022 arch/x86/kernel/signal.c    Al Viro           2012-11-09  314  __setup_frame(int sig, struct ksignal *ksig, sigset_t *set,
7e907f48 arch/x86/kernel/signal_32.c Ingo Molnar       2008-03-06  315  	      struct pt_regs *regs)
^1da177e arch/i386/kernel/signal.c   Linus Torvalds    2005-04-16  316  {
^1da177e arch/i386/kernel/signal.c   Linus Torvalds    2005-04-16  317  	struct sigframe __user *frame;
7e907f48 arch/x86/kernel/signal_32.c Ingo Molnar       2008-03-06  318  	void __user *restorer;
^1da177e arch/i386/kernel/signal.c   Linus Torvalds    2005-04-16  319  	int err = 0;
ab513701 arch/x86/kernel/signal_32.c Suresh Siddha     2008-07-29  320  	void __user *fpstate = NULL;
^1da177e arch/i386/kernel/signal.c   Linus Torvalds    2005-04-16  321  
235b8022 arch/x86/kernel/signal.c    Al Viro           2012-11-09  322  	frame = get_sigframe(&ksig->ka, regs, sizeof(*frame), &fpstate);
^1da177e arch/i386/kernel/signal.c   Linus Torvalds    2005-04-16  323  
96d4f267 arch/x86/kernel/signal.c    Linus Torvalds    2019-01-03  324  	if (!access_ok(frame, sizeof(*frame)))
3d0aedd9 arch/x86/kernel/signal_32.c Hiroshi Shimamoto 2008-09-12  325  		return -EFAULT;
^1da177e arch/i386/kernel/signal.c   Linus Torvalds    2005-04-16  326  
2ba48e16 arch/x86/kernel/signal_32.c Hiroshi Shimamoto 2008-09-12  327  	if (__put_user(sig, &frame->sig))
3d0aedd9 arch/x86/kernel/signal_32.c Hiroshi Shimamoto 2008-09-12  328  		return -EFAULT;
^1da177e arch/i386/kernel/signal.c   Linus Torvalds    2005-04-16  329  
2ba48e16 arch/x86/kernel/signal_32.c Hiroshi Shimamoto 2008-09-12  330  	if (setup_sigcontext(&frame->sc, fpstate, regs, set->sig[0]))
3d0aedd9 arch/x86/kernel/signal_32.c Hiroshi Shimamoto 2008-09-12  331  		return -EFAULT;
^1da177e arch/i386/kernel/signal.c   Linus Torvalds    2005-04-16  332  
^1da177e arch/i386/kernel/signal.c   Linus Torvalds    2005-04-16  333  	if (_NSIG_WORDS > 1) {
2ba48e16 arch/x86/kernel/signal_32.c Hiroshi Shimamoto 2008-09-12  334  		if (__copy_to_user(&frame->extramask, &set->sig[1],
2ba48e16 arch/x86/kernel/signal_32.c Hiroshi Shimamoto 2008-09-12  335  				   sizeof(frame->extramask)))
3d0aedd9 arch/x86/kernel/signal_32.c Hiroshi Shimamoto 2008-09-12  336  			return -EFAULT;
^1da177e arch/i386/kernel/signal.c   Linus Torvalds    2005-04-16  337  	}
^1da177e arch/i386/kernel/signal.c   Linus Torvalds    2005-04-16  338  
1a3e4ca4 arch/x86/kernel/signal_32.c Roland McGrath    2008-04-09  339  	if (current->mm->context.vdso)
6f121e54 arch/x86/kernel/signal.c    Andy Lutomirski   2014-05-05  340  		restorer = current->mm->context.vdso +
0a6d1fa0 arch/x86/kernel/signal.c    Andy Lutomirski   2015-10-05  341  			vdso_image_32.sym___kernel_sigreturn;
9fbbd4dd arch/i386/kernel/signal.c   Andi Kleen        2007-02-13  342  	else
ade1af77 arch/x86/kernel/signal_32.c Jan Engelhardt    2008-01-30  343  		restorer = &frame->retcode;
235b8022 arch/x86/kernel/signal.c    Al Viro           2012-11-09  344  	if (ksig->ka.sa.sa_flags & SA_RESTORER)
235b8022 arch/x86/kernel/signal.c    Al Viro           2012-11-09  345  		restorer = ksig->ka.sa.sa_restorer;
^1da177e arch/i386/kernel/signal.c   Linus Torvalds    2005-04-16  346  
^1da177e arch/i386/kernel/signal.c   Linus Torvalds    2005-04-16  347  	/* Set up to return from userspace.  */
^1da177e arch/i386/kernel/signal.c   Linus Torvalds    2005-04-16  348  	err |= __put_user(restorer, &frame->pretcode);
^1da177e arch/i386/kernel/signal.c   Linus Torvalds    2005-04-16  349  
^1da177e arch/i386/kernel/signal.c   Linus Torvalds    2005-04-16  350  	/*
7e907f48 arch/x86/kernel/signal_32.c Ingo Molnar       2008-03-06  351  	 * This is popl %eax ; movl $__NR_sigreturn, %eax ; int $0x80
^1da177e arch/i386/kernel/signal.c   Linus Torvalds    2005-04-16  352  	 *
^1da177e arch/i386/kernel/signal.c   Linus Torvalds    2005-04-16  353  	 * WE DO NOT USE IT ANY MORE! It's only left here for historical
^1da177e arch/i386/kernel/signal.c   Linus Torvalds    2005-04-16  354  	 * reasons and because gdb uses it as a signature to notice
^1da177e arch/i386/kernel/signal.c   Linus Torvalds    2005-04-16  355  	 * signal handler stack frames.
^1da177e arch/i386/kernel/signal.c   Linus Torvalds    2005-04-16  356  	 */
4a612048 arch/x86/kernel/signal_32.c Hiroshi Shimamoto 2008-11-11 @357  	err |= __put_user(*((u64 *)&retcode), (u64 *)frame->retcode);
^1da177e arch/i386/kernel/signal.c   Linus Torvalds    2005-04-16  358  
^1da177e arch/i386/kernel/signal.c   Linus Torvalds    2005-04-16  359  	if (err)
3d0aedd9 arch/x86/kernel/signal_32.c Hiroshi Shimamoto 2008-09-12  360  		return -EFAULT;
^1da177e arch/i386/kernel/signal.c   Linus Torvalds    2005-04-16  361  
^1da177e arch/i386/kernel/signal.c   Linus Torvalds    2005-04-16  362  	/* Set up registers for signal handler */
65ea5b03 arch/x86/kernel/signal_32.c H. Peter Anvin    2008-01-30  363  	regs->sp = (unsigned long)frame;
235b8022 arch/x86/kernel/signal.c    Al Viro           2012-11-09  364  	regs->ip = (unsigned long)ksig->ka.sa.sa_handler;
65ea5b03 arch/x86/kernel/signal_32.c H. Peter Anvin    2008-01-30  365  	regs->ax = (unsigned long)sig;
92bc2056 arch/x86/kernel/signal_32.c Harvey Harrison   2008-02-08  366  	regs->dx = 0;
92bc2056 arch/x86/kernel/signal_32.c Harvey Harrison   2008-02-08  367  	regs->cx = 0;
^1da177e arch/i386/kernel/signal.c   Linus Torvalds    2005-04-16  368  
65ea5b03 arch/x86/kernel/signal_32.c H. Peter Anvin    2008-01-30  369  	regs->ds = __USER_DS;
65ea5b03 arch/x86/kernel/signal_32.c H. Peter Anvin    2008-01-30  370  	regs->es = __USER_DS;
65ea5b03 arch/x86/kernel/signal_32.c H. Peter Anvin    2008-01-30  371  	regs->ss = __USER_DS;
65ea5b03 arch/x86/kernel/signal_32.c H. Peter Anvin    2008-01-30  372  	regs->cs = __USER_CS;
^1da177e arch/i386/kernel/signal.c   Linus Torvalds    2005-04-16  373  
283828f3 arch/i386/kernel/signal.c   David Howells     2006-01-18  374  	return 0;
^1da177e arch/i386/kernel/signal.c   Linus Torvalds    2005-04-16  375  }
^1da177e arch/i386/kernel/signal.c   Linus Torvalds    2005-04-16  376  

:::::: The code at line 357 was first introduced by commit
:::::: 4a61204856e8b28e9f5489a7875cb3a60afd1e43 x86: signal_32: introduce retcode and rt_retcode

:::::: TO: Hiroshi Shimamoto <h-shimamoto@ct.jp.nec.com>
:::::: CC: Ingo Molnar <mingo@elte.hu>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
