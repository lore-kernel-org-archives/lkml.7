Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FB81C43613
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 18:53:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C06342075E
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 18:53:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726429AbfFUSxK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Jun 2019 14:53:10 -0400
Received: from mga09.intel.com ([134.134.136.24]:34656 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726338AbfFUSxI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 14:53:08 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Jun 2019 11:53:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,401,1557212400"; 
   d="gz'50?scan'50,208,50";a="359372435"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 21 Jun 2019 11:53:04 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1heOel-0005B5-M2; Sat, 22 Jun 2019 02:53:03 +0800
Date:   Sat, 22 Jun 2019 02:52:46 +0800
From:   kbuild test robot <lkp@intel.com>
To:     "Chang S. Bae" <chang.seok.bae@intel.com>
Cc:     kbuild-all@01.org, linux-kernel@vger.kernel.org,
        tipbuild@zytor.com, Thomas Gleixner <tglx@linutronix.de>
Subject: [tip:WIP.x86/cpu 8/17] include/linux/irqflags.h:122:3: note: in
 expansion of macro 'if'
Message-ID: <201906220240.t2dkh6EG%lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="BXVAT5kNtrzKuDFl"
Content-Disposition: inline
X-Patchwork-Hint: ignore
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--BXVAT5kNtrzKuDFl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git WIP.x86/cpu
head:   707e6befd43ba8d754485d8d02ed4f49ec8ec667
commit: 41cf6ccef21080168970226f657daff26ecaf3e1 [8/17] x86/process/64: Use FSGSBASE instructions on thread copy and ptrace
config: x86_64-randconfig-x016-201924 (attached as .config)
compiler: gcc-7 (Debian 7.3.0-1) 7.3.0
reproduce:
        git checkout 41cf6ccef21080168970226f657daff26ecaf3e1
        # save the attached .config to linux build tree
        make ARCH=x86_64 

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from include/linux/kernel.h:14:0,
                    from include/linux/list.h:9,
                    from include/linux/kobject.h:19,
                    from include/linux/device.h:16,
                    from include/linux/node.h:18,
                    from include/linux/cpu.h:17,
                    from arch/x86//kernel/process_64.c:18:
   arch/x86//kernel/process_64.c: In function 'save_fsgs':
   include/linux/typecheck.h:12:18: warning: comparison of distinct pointer types lacks a cast
     (void)(&__dummy == &__dummy2); \
                     ^
   include/linux/irqflags.h:83:3: note: in expansion of macro 'typecheck'
      typecheck(unsigned long, flags); \
      ^~~~~~~~~
   include/linux/irqflags.h:115:3: note: in expansion of macro 'raw_local_irq_save'
      raw_local_irq_save(flags);  \
      ^~~~~~~~~~~~~~~~~~
   arch/x86//kernel/process_64.c:256:3: note: in expansion of macro 'local_irq_save'
      local_irq_save(&flags);
      ^~~~~~~~~~~~~~
   In file included from arch/x86/include/asm/processor.h:33:0,
                    from include/linux/mutex.h:19,
                    from include/linux/kernfs.h:12,
                    from include/linux/sysfs.h:16,
                    from include/linux/kobject.h:20,
                    from include/linux/device.h:16,
                    from include/linux/node.h:18,
                    from include/linux/cpu.h:17,
                    from arch/x86//kernel/process_64.c:18:
   include/linux/irqflags.h:84:9: error: lvalue required as left operand of assignment
      flags = arch_local_irq_save();  \
            ^
   include/linux/irqflags.h:115:3: note: in expansion of macro 'raw_local_irq_save'
      raw_local_irq_save(flags);  \
      ^~~~~~~~~~~~~~~~~~
   arch/x86//kernel/process_64.c:256:3: note: in expansion of macro 'local_irq_save'
      local_irq_save(&flags);
      ^~~~~~~~~~~~~~
   In file included from include/linux/ioport.h:13:0,
                    from include/linux/device.h:15,
                    from include/linux/node.h:18,
                    from include/linux/cpu.h:17,
                    from arch/x86//kernel/process_64.c:18:
   include/linux/typecheck.h:12:18: warning: comparison of distinct pointer types lacks a cast
     (void)(&__dummy == &__dummy2); \
                     ^
   include/linux/compiler.h:58:52: note: in definition of macro '__trace_if_var'
    #define __trace_if_var(cond) (__builtin_constant_p(cond) ? (cond) : __trace_if_value(cond))
                                                       ^~~~
>> include/linux/irqflags.h:122:3: note: in expansion of macro 'if'
      if (raw_irqs_disabled_flags(flags)) { \
      ^~
   include/linux/irqflags.h:98:3: note: in expansion of macro 'typecheck'
      typecheck(unsigned long, flags); \
      ^~~~~~~~~
   include/linux/irqflags.h:122:7: note: in expansion of macro 'raw_irqs_disabled_flags'
      if (raw_irqs_disabled_flags(flags)) { \
          ^~~~~~~~~~~~~~~~~~~~~~~
   arch/x86//kernel/process_64.c:258:3: note: in expansion of macro 'local_irq_restore'
      local_irq_restore(&flags);
      ^~~~~~~~~~~~~~~~~
   arch/x86//kernel/process_64.c:258:21: warning: passing argument 1 of 'arch_irqs_disabled_flags' makes integer from pointer without a cast [-Wint-conversion]
      local_irq_restore(&flags);
                        ^
   include/linux/compiler.h:58:52: note: in definition of macro '__trace_if_var'
    #define __trace_if_var(cond) (__builtin_constant_p(cond) ? (cond) : __trace_if_value(cond))
                                                       ^~~~
>> include/linux/irqflags.h:122:3: note: in expansion of macro 'if'
      if (raw_irqs_disabled_flags(flags)) { \
      ^~
   include/linux/irqflags.h:122:7: note: in expansion of macro 'raw_irqs_disabled_flags'
      if (raw_irqs_disabled_flags(flags)) { \
          ^~~~~~~~~~~~~~~~~~~~~~~
   arch/x86//kernel/process_64.c:258:3: note: in expansion of macro 'local_irq_restore'
      local_irq_restore(&flags);
      ^~~~~~~~~~~~~~~~~
   In file included from include/linux/irqflags.h:16:0,
                    from arch/x86/include/asm/processor.h:33,
                    from include/linux/mutex.h:19,
                    from include/linux/kernfs.h:12,
                    from include/linux/sysfs.h:16,
                    from include/linux/kobject.h:20,
                    from include/linux/device.h:16,
                    from include/linux/node.h:18,
                    from include/linux/cpu.h:17,
                    from arch/x86//kernel/process_64.c:18:
   arch/x86/include/asm/irqflags.h:162:19: note: expected 'long unsigned int' but argument is of type 'long unsigned int *'
    static inline int arch_irqs_disabled_flags(unsigned long flags)
                      ^~~~~~~~~~~~~~~~~~~~~~~~
   In file included from include/linux/ioport.h:13:0,
                    from include/linux/device.h:15,
                    from include/linux/node.h:18,
                    from include/linux/cpu.h:17,
                    from arch/x86//kernel/process_64.c:18:
   include/linux/typecheck.h:12:18: warning: comparison of distinct pointer types lacks a cast
     (void)(&__dummy == &__dummy2); \
                     ^
   include/linux/compiler.h:58:61: note: in definition of macro '__trace_if_var'
    #define __trace_if_var(cond) (__builtin_constant_p(cond) ? (cond) : __trace_if_value(cond))
                                                                ^~~~
>> include/linux/irqflags.h:122:3: note: in expansion of macro 'if'
      if (raw_irqs_disabled_flags(flags)) { \
      ^~
   include/linux/irqflags.h:98:3: note: in expansion of macro 'typecheck'
      typecheck(unsigned long, flags); \
      ^~~~~~~~~
   include/linux/irqflags.h:122:7: note: in expansion of macro 'raw_irqs_disabled_flags'
      if (raw_irqs_disabled_flags(flags)) { \
          ^~~~~~~~~~~~~~~~~~~~~~~
   arch/x86//kernel/process_64.c:258:3: note: in expansion of macro 'local_irq_restore'
      local_irq_restore(&flags);
      ^~~~~~~~~~~~~~~~~
   arch/x86//kernel/process_64.c:258:21: warning: passing argument 1 of 'arch_irqs_disabled_flags' makes integer from pointer without a cast [-Wint-conversion]
      local_irq_restore(&flags);
                        ^
   include/linux/compiler.h:58:61: note: in definition of macro '__trace_if_var'
    #define __trace_if_var(cond) (__builtin_constant_p(cond) ? (cond) : __trace_if_value(cond))
                                                                ^~~~
>> include/linux/irqflags.h:122:3: note: in expansion of macro 'if'
      if (raw_irqs_disabled_flags(flags)) { \
      ^~
   include/linux/irqflags.h:122:7: note: in expansion of macro 'raw_irqs_disabled_flags'
      if (raw_irqs_disabled_flags(flags)) { \
          ^~~~~~~~~~~~~~~~~~~~~~~
   arch/x86//kernel/process_64.c:258:3: note: in expansion of macro 'local_irq_restore'
      local_irq_restore(&flags);
      ^~~~~~~~~~~~~~~~~
   In file included from include/linux/irqflags.h:16:0,
                    from arch/x86/include/asm/processor.h:33,
                    from include/linux/mutex.h:19,
                    from include/linux/kernfs.h:12,
                    from include/linux/sysfs.h:16,
                    from include/linux/kobject.h:20,
                    from include/linux/device.h:16,
                    from include/linux/node.h:18,
                    from include/linux/cpu.h:17,
                    from arch/x86//kernel/process_64.c:18:
   arch/x86/include/asm/irqflags.h:162:19: note: expected 'long unsigned int' but argument is of type 'long unsigned int *'
    static inline int arch_irqs_disabled_flags(unsigned long flags)
                      ^~~~~~~~~~~~~~~~~~~~~~~~
   In file included from include/linux/ioport.h:13:0,
                    from include/linux/device.h:15,
                    from include/linux/node.h:18,
                    from include/linux/cpu.h:17,
                    from arch/x86//kernel/process_64.c:18:
   include/linux/typecheck.h:12:18: warning: comparison of distinct pointer types lacks a cast
     (void)(&__dummy == &__dummy2); \
                     ^
   include/linux/compiler.h:69:3: note: in definition of macro '__trace_if_value'
     (cond) ?     \
      ^~~~
   include/linux/compiler.h:56:28: note: in expansion of macro '__trace_if_var'
    #define if(cond, ...) if ( __trace_if_var( !!(cond , ## __VA_ARGS__) ) )
                               ^~~~~~~~~~~~~~
>> include/linux/irqflags.h:122:3: note: in expansion of macro 'if'
      if (raw_irqs_disabled_flags(flags)) { \
      ^~
   include/linux/irqflags.h:98:3: note: in expansion of macro 'typecheck'
      typecheck(unsigned long, flags); \
      ^~~~~~~~~
   include/linux/irqflags.h:122:7: note: in expansion of macro 'raw_irqs_disabled_flags'
      if (raw_irqs_disabled_flags(flags)) { \
          ^~~~~~~~~~~~~~~~~~~~~~~
   arch/x86//kernel/process_64.c:258:3: note: in expansion of macro 'local_irq_restore'
      local_irq_restore(&flags);
      ^~~~~~~~~~~~~~~~~
   arch/x86//kernel/process_64.c:258:21: warning: passing argument 1 of 'arch_irqs_disabled_flags' makes integer from pointer without a cast [-Wint-conversion]
      local_irq_restore(&flags);
                        ^
   include/linux/compiler.h:69:3: note: in definition of macro '__trace_if_value'
     (cond) ?     \
      ^~~~
   include/linux/compiler.h:56:28: note: in expansion of macro '__trace_if_var'
    #define if(cond, ...) if ( __trace_if_var( !!(cond , ## __VA_ARGS__) ) )
                               ^~~~~~~~~~~~~~
>> include/linux/irqflags.h:122:3: note: in expansion of macro 'if'
      if (raw_irqs_disabled_flags(flags)) { \
      ^~
   include/linux/irqflags.h:122:7: note: in expansion of macro 'raw_irqs_disabled_flags'
      if (raw_irqs_disabled_flags(flags)) { \
          ^~~~~~~~~~~~~~~~~~~~~~~
   arch/x86//kernel/process_64.c:258:3: note: in expansion of macro 'local_irq_restore'
      local_irq_restore(&flags);
      ^~~~~~~~~~~~~~~~~
   In file included from include/linux/irqflags.h:16:0,
                    from arch/x86/include/asm/processor.h:33,
                    from include/linux/mutex.h:19,
                    from include/linux/kernfs.h:12,
                    from include/linux/sysfs.h:16,
                    from include/linux/kobject.h:20,
                    from include/linux/device.h:16,
                    from include/linux/node.h:18,
                    from include/linux/cpu.h:17,
                    from arch/x86//kernel/process_64.c:18:
   arch/x86/include/asm/irqflags.h:162:19: note: expected 'long unsigned int' but argument is of type 'long unsigned int *'
    static inline int arch_irqs_disabled_flags(unsigned long flags)
                      ^~~~~~~~~~~~~~~~~~~~~~~~
   In file included from include/linux/kernel.h:14:0,
                    from include/linux/list.h:9,
                    from include/linux/kobject.h:19,
                    from include/linux/device.h:16,
                    from include/linux/node.h:18,
                    from include/linux/cpu.h:17,
                    from arch/x86//kernel/process_64.c:18:
   include/linux/typecheck.h:12:18: warning: comparison of distinct pointer types lacks a cast
     (void)(&__dummy == &__dummy2); \
                     ^
   include/linux/irqflags.h:88:3: note: in expansion of macro 'typecheck'
      typecheck(unsigned long, flags); \
      ^~~~~~~~~
   include/linux/irqflags.h:123:4: note: in expansion of macro 'raw_local_irq_restore'
       raw_local_irq_restore(flags); \
       ^~~~~~~~~~~~~~~~~~~~~
   arch/x86//kernel/process_64.c:258:3: note: in expansion of macro 'local_irq_restore'
      local_irq_restore(&flags);
      ^~~~~~~~~~~~~~~~~
   In file included from arch/x86/include/asm/processor.h:33:0,
                    from include/linux/mutex.h:19,
                    from include/linux/kernfs.h:12,
                    from include/linux/sysfs.h:16,
                    from include/linux/kobject.h:20,
                    from include/linux/device.h:16,
                    from include/linux/node.h:18,
                    from include/linux/cpu.h:17,
                    from arch/x86//kernel/process_64.c:18:
   arch/x86//kernel/process_64.c:258:21: warning: passing argument 1 of 'arch_local_irq_restore' makes integer from pointer without a cast [-Wint-conversion]
      local_irq_restore(&flags);
                        ^
   include/linux/irqflags.h:89:26: note: in definition of macro 'raw_local_irq_restore'
      arch_local_irq_restore(flags);  \
                             ^~~~~
   arch/x86//kernel/process_64.c:258:3: note: in expansion of macro 'local_irq_restore'
      local_irq_restore(&flags);
      ^~~~~~~~~~~~~~~~~
   In file included from include/linux/irqflags.h:16:0,
                    from arch/x86/include/asm/processor.h:33,
                    from include/linux/mutex.h:19,
                    from include/linux/kernfs.h:12,
                    from include/linux/sysfs.h:16,
                    from include/linux/kobject.h:20,
                    from include/linux/device.h:16,
                    from include/linux/node.h:18,
                    from include/linux/cpu.h:17,
                    from arch/x86//kernel/process_64.c:18:
   arch/x86/include/asm/irqflags.h:82:28: note: expected 'long unsigned int' but argument is of type 'long unsigned int *'
    static inline notrace void arch_local_irq_restore(unsigned long flags)
                               ^~~~~~~~~~~~~~~~~~~~~~
   In file included from include/linux/kernel.h:14:0,
                    from include/linux/list.h:9,
                    from include/linux/kobject.h:19,
                    from include/linux/device.h:16,
                    from include/linux/node.h:18,
                    from include/linux/cpu.h:17,
                    from arch/x86//kernel/process_64.c:18:
   include/linux/typecheck.h:12:18: warning: comparison of distinct pointer types lacks a cast
     (void)(&__dummy == &__dummy2); \
                     ^
   include/linux/irqflags.h:88:3: note: in expansion of macro 'typecheck'
      typecheck(unsigned long, flags); \
      ^~~~~~~~~
   include/linux/irqflags.h:127:4: note: in expansion of macro 'raw_local_irq_restore'
       raw_local_irq_restore(flags); \
       ^~~~~~~~~~~~~~~~~~~~~
   arch/x86//kernel/process_64.c:258:3: note: in expansion of macro 'local_irq_restore'
      local_irq_restore(&flags);
      ^~~~~~~~~~~~~~~~~
   In file included from arch/x86/include/asm/processor.h:33:0,
                    from include/linux/mutex.h:19,
                    from include/linux/kernfs.h:12,
                    from include/linux/sysfs.h:16,
                    from include/linux/kobject.h:20,
                    from include/linux/device.h:16,
                    from include/linux/node.h:18,
                    from include/linux/cpu.h:17,
                    from arch/x86//kernel/process_64.c:18:
   arch/x86//kernel/process_64.c:258:21: warning: passing argument 1 of 'arch_local_irq_restore' makes integer from pointer without a cast [-Wint-conversion]
--
   In file included from include/linux/kernel.h:14:0,
                    from include/linux/list.h:9,
                    from include/linux/kobject.h:19,
                    from include/linux/device.h:16,
                    from include/linux/node.h:18,
                    from include/linux/cpu.h:17,
                    from arch/x86/kernel/process_64.c:18:
   arch/x86/kernel/process_64.c: In function 'save_fsgs':
   include/linux/typecheck.h:12:18: warning: comparison of distinct pointer types lacks a cast
     (void)(&__dummy == &__dummy2); \
                     ^
   include/linux/irqflags.h:83:3: note: in expansion of macro 'typecheck'
      typecheck(unsigned long, flags); \
      ^~~~~~~~~
   include/linux/irqflags.h:115:3: note: in expansion of macro 'raw_local_irq_save'
      raw_local_irq_save(flags);  \
      ^~~~~~~~~~~~~~~~~~
   arch/x86/kernel/process_64.c:256:3: note: in expansion of macro 'local_irq_save'
      local_irq_save(&flags);
      ^~~~~~~~~~~~~~
   In file included from arch/x86/include/asm/processor.h:33:0,
                    from include/linux/mutex.h:19,
                    from include/linux/kernfs.h:12,
                    from include/linux/sysfs.h:16,
                    from include/linux/kobject.h:20,
                    from include/linux/device.h:16,
                    from include/linux/node.h:18,
                    from include/linux/cpu.h:17,
                    from arch/x86/kernel/process_64.c:18:
   include/linux/irqflags.h:84:9: error: lvalue required as left operand of assignment
      flags = arch_local_irq_save();  \
            ^
   include/linux/irqflags.h:115:3: note: in expansion of macro 'raw_local_irq_save'
      raw_local_irq_save(flags);  \
      ^~~~~~~~~~~~~~~~~~
   arch/x86/kernel/process_64.c:256:3: note: in expansion of macro 'local_irq_save'
      local_irq_save(&flags);
      ^~~~~~~~~~~~~~
   In file included from include/linux/ioport.h:13:0,
                    from include/linux/device.h:15,
                    from include/linux/node.h:18,
                    from include/linux/cpu.h:17,
                    from arch/x86/kernel/process_64.c:18:
   include/linux/typecheck.h:12:18: warning: comparison of distinct pointer types lacks a cast
     (void)(&__dummy == &__dummy2); \
                     ^
   include/linux/compiler.h:58:52: note: in definition of macro '__trace_if_var'
    #define __trace_if_var(cond) (__builtin_constant_p(cond) ? (cond) : __trace_if_value(cond))
                                                       ^~~~
>> include/linux/irqflags.h:122:3: note: in expansion of macro 'if'
      if (raw_irqs_disabled_flags(flags)) { \
      ^~
   include/linux/irqflags.h:98:3: note: in expansion of macro 'typecheck'
      typecheck(unsigned long, flags); \
      ^~~~~~~~~
   include/linux/irqflags.h:122:7: note: in expansion of macro 'raw_irqs_disabled_flags'
      if (raw_irqs_disabled_flags(flags)) { \
          ^~~~~~~~~~~~~~~~~~~~~~~
   arch/x86/kernel/process_64.c:258:3: note: in expansion of macro 'local_irq_restore'
      local_irq_restore(&flags);
      ^~~~~~~~~~~~~~~~~
   arch/x86/kernel/process_64.c:258:21: warning: passing argument 1 of 'arch_irqs_disabled_flags' makes integer from pointer without a cast [-Wint-conversion]
      local_irq_restore(&flags);
                        ^
   include/linux/compiler.h:58:52: note: in definition of macro '__trace_if_var'
    #define __trace_if_var(cond) (__builtin_constant_p(cond) ? (cond) : __trace_if_value(cond))
                                                       ^~~~
>> include/linux/irqflags.h:122:3: note: in expansion of macro 'if'
      if (raw_irqs_disabled_flags(flags)) { \
      ^~
   include/linux/irqflags.h:122:7: note: in expansion of macro 'raw_irqs_disabled_flags'
      if (raw_irqs_disabled_flags(flags)) { \
          ^~~~~~~~~~~~~~~~~~~~~~~
   arch/x86/kernel/process_64.c:258:3: note: in expansion of macro 'local_irq_restore'
      local_irq_restore(&flags);
      ^~~~~~~~~~~~~~~~~
   In file included from include/linux/irqflags.h:16:0,
                    from arch/x86/include/asm/processor.h:33,
                    from include/linux/mutex.h:19,
                    from include/linux/kernfs.h:12,
                    from include/linux/sysfs.h:16,
                    from include/linux/kobject.h:20,
                    from include/linux/device.h:16,
                    from include/linux/node.h:18,
                    from include/linux/cpu.h:17,
                    from arch/x86/kernel/process_64.c:18:
   arch/x86/include/asm/irqflags.h:162:19: note: expected 'long unsigned int' but argument is of type 'long unsigned int *'
    static inline int arch_irqs_disabled_flags(unsigned long flags)
                      ^~~~~~~~~~~~~~~~~~~~~~~~
   In file included from include/linux/ioport.h:13:0,
                    from include/linux/device.h:15,
                    from include/linux/node.h:18,
                    from include/linux/cpu.h:17,
                    from arch/x86/kernel/process_64.c:18:
   include/linux/typecheck.h:12:18: warning: comparison of distinct pointer types lacks a cast
     (void)(&__dummy == &__dummy2); \
                     ^
   include/linux/compiler.h:58:61: note: in definition of macro '__trace_if_var'
    #define __trace_if_var(cond) (__builtin_constant_p(cond) ? (cond) : __trace_if_value(cond))
                                                                ^~~~
>> include/linux/irqflags.h:122:3: note: in expansion of macro 'if'
      if (raw_irqs_disabled_flags(flags)) { \
      ^~
   include/linux/irqflags.h:98:3: note: in expansion of macro 'typecheck'
      typecheck(unsigned long, flags); \
      ^~~~~~~~~
   include/linux/irqflags.h:122:7: note: in expansion of macro 'raw_irqs_disabled_flags'
      if (raw_irqs_disabled_flags(flags)) { \
          ^~~~~~~~~~~~~~~~~~~~~~~
   arch/x86/kernel/process_64.c:258:3: note: in expansion of macro 'local_irq_restore'
      local_irq_restore(&flags);
      ^~~~~~~~~~~~~~~~~
   arch/x86/kernel/process_64.c:258:21: warning: passing argument 1 of 'arch_irqs_disabled_flags' makes integer from pointer without a cast [-Wint-conversion]
      local_irq_restore(&flags);
                        ^
   include/linux/compiler.h:58:61: note: in definition of macro '__trace_if_var'
    #define __trace_if_var(cond) (__builtin_constant_p(cond) ? (cond) : __trace_if_value(cond))
                                                                ^~~~
>> include/linux/irqflags.h:122:3: note: in expansion of macro 'if'
      if (raw_irqs_disabled_flags(flags)) { \
      ^~
   include/linux/irqflags.h:122:7: note: in expansion of macro 'raw_irqs_disabled_flags'
      if (raw_irqs_disabled_flags(flags)) { \
          ^~~~~~~~~~~~~~~~~~~~~~~
   arch/x86/kernel/process_64.c:258:3: note: in expansion of macro 'local_irq_restore'
      local_irq_restore(&flags);
      ^~~~~~~~~~~~~~~~~
   In file included from include/linux/irqflags.h:16:0,
                    from arch/x86/include/asm/processor.h:33,
                    from include/linux/mutex.h:19,
                    from include/linux/kernfs.h:12,
                    from include/linux/sysfs.h:16,
                    from include/linux/kobject.h:20,
                    from include/linux/device.h:16,
                    from include/linux/node.h:18,
                    from include/linux/cpu.h:17,
                    from arch/x86/kernel/process_64.c:18:
   arch/x86/include/asm/irqflags.h:162:19: note: expected 'long unsigned int' but argument is of type 'long unsigned int *'
    static inline int arch_irqs_disabled_flags(unsigned long flags)
                      ^~~~~~~~~~~~~~~~~~~~~~~~
   In file included from include/linux/ioport.h:13:0,
                    from include/linux/device.h:15,
                    from include/linux/node.h:18,
                    from include/linux/cpu.h:17,
                    from arch/x86/kernel/process_64.c:18:
   include/linux/typecheck.h:12:18: warning: comparison of distinct pointer types lacks a cast
     (void)(&__dummy == &__dummy2); \
                     ^
   include/linux/compiler.h:69:3: note: in definition of macro '__trace_if_value'
     (cond) ?     \
      ^~~~
   include/linux/compiler.h:56:28: note: in expansion of macro '__trace_if_var'
    #define if(cond, ...) if ( __trace_if_var( !!(cond , ## __VA_ARGS__) ) )
                               ^~~~~~~~~~~~~~
>> include/linux/irqflags.h:122:3: note: in expansion of macro 'if'
      if (raw_irqs_disabled_flags(flags)) { \
      ^~
   include/linux/irqflags.h:98:3: note: in expansion of macro 'typecheck'
      typecheck(unsigned long, flags); \
      ^~~~~~~~~
   include/linux/irqflags.h:122:7: note: in expansion of macro 'raw_irqs_disabled_flags'
      if (raw_irqs_disabled_flags(flags)) { \
          ^~~~~~~~~~~~~~~~~~~~~~~
   arch/x86/kernel/process_64.c:258:3: note: in expansion of macro 'local_irq_restore'
      local_irq_restore(&flags);
      ^~~~~~~~~~~~~~~~~
   arch/x86/kernel/process_64.c:258:21: warning: passing argument 1 of 'arch_irqs_disabled_flags' makes integer from pointer without a cast [-Wint-conversion]
      local_irq_restore(&flags);
                        ^
   include/linux/compiler.h:69:3: note: in definition of macro '__trace_if_value'
     (cond) ?     \
      ^~~~
   include/linux/compiler.h:56:28: note: in expansion of macro '__trace_if_var'
    #define if(cond, ...) if ( __trace_if_var( !!(cond , ## __VA_ARGS__) ) )
                               ^~~~~~~~~~~~~~
>> include/linux/irqflags.h:122:3: note: in expansion of macro 'if'
      if (raw_irqs_disabled_flags(flags)) { \
      ^~
   include/linux/irqflags.h:122:7: note: in expansion of macro 'raw_irqs_disabled_flags'
      if (raw_irqs_disabled_flags(flags)) { \
          ^~~~~~~~~~~~~~~~~~~~~~~
   arch/x86/kernel/process_64.c:258:3: note: in expansion of macro 'local_irq_restore'
      local_irq_restore(&flags);
      ^~~~~~~~~~~~~~~~~
   In file included from include/linux/irqflags.h:16:0,
                    from arch/x86/include/asm/processor.h:33,
                    from include/linux/mutex.h:19,
                    from include/linux/kernfs.h:12,
                    from include/linux/sysfs.h:16,
                    from include/linux/kobject.h:20,
                    from include/linux/device.h:16,
                    from include/linux/node.h:18,
                    from include/linux/cpu.h:17,
                    from arch/x86/kernel/process_64.c:18:
   arch/x86/include/asm/irqflags.h:162:19: note: expected 'long unsigned int' but argument is of type 'long unsigned int *'
    static inline int arch_irqs_disabled_flags(unsigned long flags)
                      ^~~~~~~~~~~~~~~~~~~~~~~~
   In file included from include/linux/kernel.h:14:0,
                    from include/linux/list.h:9,
                    from include/linux/kobject.h:19,
                    from include/linux/device.h:16,
                    from include/linux/node.h:18,
                    from include/linux/cpu.h:17,
                    from arch/x86/kernel/process_64.c:18:
   include/linux/typecheck.h:12:18: warning: comparison of distinct pointer types lacks a cast
     (void)(&__dummy == &__dummy2); \
                     ^
   include/linux/irqflags.h:88:3: note: in expansion of macro 'typecheck'
      typecheck(unsigned long, flags); \
      ^~~~~~~~~
   include/linux/irqflags.h:123:4: note: in expansion of macro 'raw_local_irq_restore'
       raw_local_irq_restore(flags); \
       ^~~~~~~~~~~~~~~~~~~~~
   arch/x86/kernel/process_64.c:258:3: note: in expansion of macro 'local_irq_restore'
      local_irq_restore(&flags);
      ^~~~~~~~~~~~~~~~~
   In file included from arch/x86/include/asm/processor.h:33:0,
                    from include/linux/mutex.h:19,
                    from include/linux/kernfs.h:12,
                    from include/linux/sysfs.h:16,
                    from include/linux/kobject.h:20,
                    from include/linux/device.h:16,
                    from include/linux/node.h:18,
                    from include/linux/cpu.h:17,
                    from arch/x86/kernel/process_64.c:18:
   arch/x86/kernel/process_64.c:258:21: warning: passing argument 1 of 'arch_local_irq_restore' makes integer from pointer without a cast [-Wint-conversion]
      local_irq_restore(&flags);
                        ^
   include/linux/irqflags.h:89:26: note: in definition of macro 'raw_local_irq_restore'
      arch_local_irq_restore(flags);  \
                             ^~~~~
   arch/x86/kernel/process_64.c:258:3: note: in expansion of macro 'local_irq_restore'
      local_irq_restore(&flags);
      ^~~~~~~~~~~~~~~~~
   In file included from include/linux/irqflags.h:16:0,
                    from arch/x86/include/asm/processor.h:33,
                    from include/linux/mutex.h:19,
                    from include/linux/kernfs.h:12,
                    from include/linux/sysfs.h:16,
                    from include/linux/kobject.h:20,
                    from include/linux/device.h:16,
                    from include/linux/node.h:18,
                    from include/linux/cpu.h:17,
                    from arch/x86/kernel/process_64.c:18:
   arch/x86/include/asm/irqflags.h:82:28: note: expected 'long unsigned int' but argument is of type 'long unsigned int *'
    static inline notrace void arch_local_irq_restore(unsigned long flags)
                               ^~~~~~~~~~~~~~~~~~~~~~
   In file included from include/linux/kernel.h:14:0,
                    from include/linux/list.h:9,
                    from include/linux/kobject.h:19,
                    from include/linux/device.h:16,
                    from include/linux/node.h:18,
                    from include/linux/cpu.h:17,
                    from arch/x86/kernel/process_64.c:18:
   include/linux/typecheck.h:12:18: warning: comparison of distinct pointer types lacks a cast
     (void)(&__dummy == &__dummy2); \
                     ^
   include/linux/irqflags.h:88:3: note: in expansion of macro 'typecheck'
      typecheck(unsigned long, flags); \
      ^~~~~~~~~
   include/linux/irqflags.h:127:4: note: in expansion of macro 'raw_local_irq_restore'
       raw_local_irq_restore(flags); \
       ^~~~~~~~~~~~~~~~~~~~~
   arch/x86/kernel/process_64.c:258:3: note: in expansion of macro 'local_irq_restore'
      local_irq_restore(&flags);
      ^~~~~~~~~~~~~~~~~
   In file included from arch/x86/include/asm/processor.h:33:0,
                    from include/linux/mutex.h:19,
                    from include/linux/kernfs.h:12,
                    from include/linux/sysfs.h:16,
                    from include/linux/kobject.h:20,
                    from include/linux/device.h:16,
                    from include/linux/node.h:18,
                    from include/linux/cpu.h:17,
                    from arch/x86/kernel/process_64.c:18:
   arch/x86/kernel/process_64.c:258:21: warning: passing argument 1 of 'arch_local_irq_restore' makes integer from pointer without a cast [-Wint-conversion]

vim +/if +122 include/linux/irqflags.h

de30a2b35 Ingo Molnar    2006-07-03  103  
df9ee2927 David Howells  2010-10-07  104  /*
df9ee2927 David Howells  2010-10-07  105   * The local_irq_*() APIs are equal to the raw_local_irq*()
df9ee2927 David Howells  2010-10-07  106   * if !TRACE_IRQFLAGS.
df9ee2927 David Howells  2010-10-07  107   */
db2dcb4f9 Jan Beulich    2015-01-20  108  #ifdef CONFIG_TRACE_IRQFLAGS
de30a2b35 Ingo Molnar    2006-07-03  109  #define local_irq_enable() \
de30a2b35 Ingo Molnar    2006-07-03  110  	do { trace_hardirqs_on(); raw_local_irq_enable(); } while (0)
de30a2b35 Ingo Molnar    2006-07-03  111  #define local_irq_disable() \
de30a2b35 Ingo Molnar    2006-07-03  112  	do { raw_local_irq_disable(); trace_hardirqs_off(); } while (0)
de30a2b35 Ingo Molnar    2006-07-03  113  #define local_irq_save(flags)				\
3f307891c Steven Rostedt 2008-07-25  114  	do {						\
3f307891c Steven Rostedt 2008-07-25  115  		raw_local_irq_save(flags);		\
3f307891c Steven Rostedt 2008-07-25  116  		trace_hardirqs_off();			\
3f307891c Steven Rostedt 2008-07-25  117  	} while (0)
3f307891c Steven Rostedt 2008-07-25  118  
de30a2b35 Ingo Molnar    2006-07-03  119  
de30a2b35 Ingo Molnar    2006-07-03  120  #define local_irq_restore(flags)			\
de30a2b35 Ingo Molnar    2006-07-03  121  	do {						\
de30a2b35 Ingo Molnar    2006-07-03 @122  		if (raw_irqs_disabled_flags(flags)) {	\
de30a2b35 Ingo Molnar    2006-07-03  123  			raw_local_irq_restore(flags);	\
de30a2b35 Ingo Molnar    2006-07-03  124  			trace_hardirqs_off();		\
de30a2b35 Ingo Molnar    2006-07-03  125  		} else {				\
de30a2b35 Ingo Molnar    2006-07-03  126  			trace_hardirqs_on();		\
de30a2b35 Ingo Molnar    2006-07-03  127  			raw_local_irq_restore(flags);	\
de30a2b35 Ingo Molnar    2006-07-03  128  		}					\
de30a2b35 Ingo Molnar    2006-07-03  129  	} while (0)
de30a2b35 Ingo Molnar    2006-07-03  130  

:::::: The code at line 122 was first introduced by commit
:::::: de30a2b355ea85350ca2f58f3b9bf4e5bc007986 [PATCH] lockdep: irqtrace subsystem, core

:::::: TO: Ingo Molnar <mingo@elte.hu>
:::::: CC: Linus Torvalds <torvalds@g5.osdl.org>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--BXVAT5kNtrzKuDFl
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
R1Qsk+hMghtHKV+X/gcPrW4xiMgBAA==

--BXVAT5kNtrzKuDFl--
