Return-Path: <SRS0=TDlZ=Y2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47DDDCA9ECF
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Nov 2019 00:48:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D689208CB
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Nov 2019 00:48:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728266AbfKBAsm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Nov 2019 20:48:42 -0400
Received: from mga06.intel.com ([134.134.136.31]:14171 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726771AbfKBAsm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Nov 2019 20:48:42 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Nov 2019 17:48:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,257,1569308400"; 
   d="gz'50?scan'50,208,50";a="199479814"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 01 Nov 2019 17:48:40 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1iQhap-00097p-7p; Sat, 02 Nov 2019 08:48:39 +0800
Date:   Sat, 2 Nov 2019 08:47:59 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Andi Kleen <andi@firstfloor.org>
Cc:     kbuild-all@lists.01.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH v3] x86: Add trace points to (nearly) all vectors
Message-ID: <201911020848.LOEtnDnd%lkp@intel.com>
References: <20191030195619.22244-1-andi@firstfloor.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="mlja3gggun3wgpid"
Content-Disposition: inline
In-Reply-To: <20191030195619.22244-1-andi@firstfloor.org>
X-Patchwork-Hint: ignore
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--mlja3gggun3wgpid
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Andi,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on tip/auto-latest]
[also build test ERROR on v5.4-rc5 next-20191031]
[if your patch is applied to the wrong git tree, please drop us a note to help
improve the system. BTW, we also suggest to use '--base' option to specify the
base tree in git format-patch, please see https://stackoverflow.com/a/37406982]

url:    https://github.com/0day-ci/linux/commits/Andi-Kleen/x86-Add-trace-points-to-nearly-all-vectors/20191102-063457
base:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git a5b576bfb3ba85d3e356f9900dce1428d4760582
config: i386-tinyconfig (attached as .config)
compiler: gcc-7 (Debian 7.4.0-14) 7.4.0
reproduce:
        # save the attached .config to linux build tree
        make ARCH=i386 

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   arch/x86/kernel/traps.c: In function 'do_error_trap':
>> arch/x86/kernel/traps.c:264:2: error: implicit declaration of function 'trace_other_vector_entry'; did you mean 'frame_vector_destroy'? [-Werror=implicit-function-declaration]
     trace_other_vector_entry(trapnr);
     ^~~~~~~~~~~~~~~~~~~~~~~~
     frame_vector_destroy
>> arch/x86/kernel/traps.c:279:2: error: implicit declaration of function 'trace_other_vector_exit'; did you mean 'trace_hardirq_exit'? [-Werror=implicit-function-declaration]
     trace_other_vector_exit(trapnr);
     ^~~~~~~~~~~~~~~~~~~~~~~
     trace_hardirq_exit
   cc1: some warnings being treated as errors
--
   arch/x86/kernel/irq.c: In function 'smp_kvm_posted_intr_ipi':
>> arch/x86/kernel/irq.c:311:2: error: implicit declaration of function 'trace_other_vector_entry'; did you mean 'frame_vector_destroy'? [-Werror=implicit-function-declaration]
     trace_other_vector_entry(POSTED_INTR_VECTOR);
     ^~~~~~~~~~~~~~~~~~~~~~~~
     frame_vector_destroy
>> arch/x86/kernel/irq.c:314:2: error: implicit declaration of function 'trace_other_vector_exit'; did you mean 'trace_hardirq_exit'? [-Werror=implicit-function-declaration]
     trace_other_vector_exit(POSTED_INTR_VECTOR);
     ^~~~~~~~~~~~~~~~~~~~~~~
     trace_hardirq_exit
   cc1: some warnings being treated as errors

vim +264 arch/x86/kernel/traps.c

   259	
   260	static void do_error_trap(struct pt_regs *regs, long error_code, char *str,
   261		unsigned long trapnr, int signr, int sicode, void __user *addr)
   262	{
   263		RCU_LOCKDEP_WARN(!rcu_is_watching(), "entry code didn't wake RCU");
 > 264		trace_other_vector_entry(trapnr);
   265	
   266		/*
   267		 * WARN*()s end up here; fix them up before we call the
   268		 * notifier chain.
   269		 */
   270		if (!user_mode(regs) && fixup_bug(regs, trapnr))
   271			goto out;
   272	
   273		if (notify_die(DIE_TRAP, str, regs, error_code, trapnr, signr) !=
   274				NOTIFY_STOP) {
   275			cond_local_irq_enable(regs);
   276			do_trap(trapnr, signr, str, regs, error_code, sicode, addr);
   277		}
   278	out:
 > 279		trace_other_vector_exit(trapnr);
   280	}
   281	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--mlja3gggun3wgpid
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
iyYrsBFUUc/QEQU9PbZOcKDwA2/5ffUoaAAA

--mlja3gggun3wgpid--
