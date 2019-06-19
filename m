Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33FA1C31E49
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 08:08:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB73120679
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 08:08:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731231AbfFSIId (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 04:08:33 -0400
Received: from mga05.intel.com ([192.55.52.43]:9615 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726142AbfFSIId (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 04:08:33 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Jun 2019 01:08:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,392,1557212400"; 
   d="gz'50?scan'50,208,50";a="186378962"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 19 Jun 2019 01:08:30 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1hdVdu-000CM7-7e; Wed, 19 Jun 2019 16:08:30 +0800
Date:   Wed, 19 Jun 2019 16:07:54 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     kbuild-all@01.org, linux-kernel@vger.kernel.org, tipbuild@zytor.com
Subject: [tip:WIP.x86/ipi 3/11] arch/x86/kernel/nmi.c:515:46: error:
 'cpu_is_dead' undeclared; did you mean 'cpuid_eax'?
Message-ID: <201906191652.VGOCGBmi%lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="X1bOJ3K7DJ5YkBrT"
Content-Disposition: inline
X-Patchwork-Hint: ignore
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--X1bOJ3K7DJ5YkBrT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git WIP.x86/ipi
head:   0663387727c00bb25ce1e76f30deb6b193f591f8
commit: 8adde844ea4f8d0d147e0ad6c675970a58550bae [3/11] x86/hotplug: Silence APIC and NMI when CPU is dead
config: i386-tinyconfig (attached as .config)
compiler: gcc-7 (Debian 7.3.0-1) 7.3.0
reproduce:
        git checkout 8adde844ea4f8d0d147e0ad6c675970a58550bae
        # save the attached .config to linux build tree
        make ARCH=i386 

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from include/asm-generic/percpu.h:7:0,
                    from arch/x86/include/asm/percpu.h:544,
                    from arch/x86/include/asm/preempt.h:6,
                    from include/linux/preempt.h:78,
                    from include/linux/spinlock.h:51,
                    from arch/x86/kernel/nmi.c:14:
   arch/x86/kernel/nmi.c: In function 'do_nmi':
>> arch/x86/kernel/nmi.c:515:46: error: 'cpu_is_dead' undeclared (first use in this function); did you mean 'cpuid_eax'?
     if (IS_ENABLED(CONFIG_SMP) && this_cpu_read(cpu_is_dead))
                                                 ^
   include/linux/percpu-defs.h:319:9: note: in definition of macro '__pcpu_size_call_return'
     typeof(variable) pscr_ret__;     \
            ^~~~~~~~
   arch/x86/kernel/nmi.c:515:32: note: in expansion of macro 'this_cpu_read'
     if (IS_ENABLED(CONFIG_SMP) && this_cpu_read(cpu_is_dead))
                                   ^~~~~~~~~~~~~
   arch/x86/kernel/nmi.c:515:46: note: each undeclared identifier is reported only once for each function it appears in
     if (IS_ENABLED(CONFIG_SMP) && this_cpu_read(cpu_is_dead))
                                                 ^
   include/linux/percpu-defs.h:319:9: note: in definition of macro '__pcpu_size_call_return'
     typeof(variable) pscr_ret__;     \
            ^~~~~~~~
   arch/x86/kernel/nmi.c:515:32: note: in expansion of macro 'this_cpu_read'
     if (IS_ENABLED(CONFIG_SMP) && this_cpu_read(cpu_is_dead))
                                   ^~~~~~~~~~~~~

vim +515 arch/x86/kernel/nmi.c

   511	
   512	dotraplinkage notrace void
   513	do_nmi(struct pt_regs *regs, long error_code)
   514	{
 > 515		if (IS_ENABLED(CONFIG_SMP) && this_cpu_read(cpu_is_dead))
   516			return;
   517	
   518		if (this_cpu_read(nmi_state) != NMI_NOT_RUNNING) {
   519			this_cpu_write(nmi_state, NMI_LATCHED);
   520			return;
   521		}
   522		this_cpu_write(nmi_state, NMI_EXECUTING);
   523		this_cpu_write(nmi_cr2, read_cr2());
   524	nmi_restart:
   525	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--X1bOJ3K7DJ5YkBrT
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--X1bOJ3K7DJ5YkBrT--
