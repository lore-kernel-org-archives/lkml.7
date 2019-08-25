Return-Path: <SRS0=9baz=WV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E82F8C3A5A1
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Aug 2019 18:37:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A65FF2080C
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Aug 2019 18:37:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728929AbfHYShL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 25 Aug 2019 14:37:11 -0400
Received: from mga14.intel.com ([192.55.52.115]:1228 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728697AbfHYShL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Aug 2019 14:37:11 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Aug 2019 11:37:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,430,1559545200"; 
   d="gz'50?scan'50,208,50";a="355204228"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 25 Aug 2019 11:37:05 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1i1xNw-0001CI-Nq; Mon, 26 Aug 2019 02:37:04 +0800
Date:   Mon, 26 Aug 2019 02:36:46 +0800
From:   kbuild test robot <lkp@intel.com>
To:     tip-bot2 for Arnaldo Carvalho de Melo <tip-bot2@linutronix.de>
Cc:     kbuild-all@01.org, linux-tip-commits@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [tip: perf/core] tools headers: Synchronize linux/bits.h with
 the kernel sources
Message-ID: <201908260202.WwIQWEbZ%lkp@intel.com>
References: <156652825705.13156.18245800688508519303.tip-bot2@tip-bot2>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="hgkd23j42qq4qr2q"
Content-Disposition: inline
In-Reply-To: <156652825705.13156.18245800688508519303.tip-bot2@tip-bot2>
X-Patchwork-Hint: ignore
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--hgkd23j42qq4qr2q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi tip-bot2,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on linus/master]
[cannot apply to v5.3-rc5 next-20190823]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/tip-bot2-for-Arnaldo-Carvalho-de-Melo/tools-headers-Synchronize-linux-bits-h-with-the-kernel-sources/20190826-001511
config: x86_64-randconfig-a004-201934 (attached as .config)
compiler: gcc-6 (Debian 6.3.0-18+deb9u1) 6.3.0 20170516
reproduce:
        # save the attached .config to linux build tree
        make ARCH=x86_64 

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from tools/include/linux/bitops.h:13:0,
                    from tools/include/linux/hashtable.h:13,
                    from elf.h:12,
                    from check.h:10,
                    from builtin-check.c:18:
   tools/include/asm-generic/bitops/non-atomic.h: In function '__set_bit':
>> tools/include/linux/bits.h:10:24: error: implicit declaration of function 'UL' [-Werror=implicit-function-declaration]
    #define BIT_MASK(nr)  (UL(1) << ((nr) % BITS_PER_LONG))
                           ^
   tools/include/asm-generic/bitops/non-atomic.h:18:23: note: in expansion of macro 'BIT_MASK'
     unsigned long mask = BIT_MASK(nr);
                          ^~~~~~~~
   In file included from tools/include/asm-generic/bitops.h:30:0,
                    from tools/include/linux/bitops.h:32,
                    from tools/include/linux/hashtable.h:13,
                    from elf.h:12,
                    from check.h:10,
                    from builtin-check.c:18:
   tools/include/asm-generic/bitops/non-atomic.h:18:2: error: nested extern declaration of 'UL' [-Werror=nested-externs]
     unsigned long mask = BIT_MASK(nr);
     ^~~~~~~~
   In file included from tools/include/linux/bitops.h:13:0,
                    from tools/include/linux/hashtable.h:13,
                    from elf.h:12,
                    from check.h:10,
                    from builtin-orc.c:17:
   tools/include/asm-generic/bitops/non-atomic.h: In function '__set_bit':
>> tools/include/linux/bits.h:10:24: error: implicit declaration of function 'UL' [-Werror=implicit-function-declaration]
    #define BIT_MASK(nr)  (UL(1) << ((nr) % BITS_PER_LONG))
                           ^
   tools/include/asm-generic/bitops/non-atomic.h:18:23: note: in expansion of macro 'BIT_MASK'
     unsigned long mask = BIT_MASK(nr);
                          ^~~~~~~~
   In file included from tools/include/asm-generic/bitops.h:30:0,
                    from tools/include/linux/bitops.h:32,
                    from tools/include/linux/hashtable.h:13,
                    from elf.h:12,
                    from check.h:10,
                    from builtin-orc.c:17:
   tools/include/asm-generic/bitops/non-atomic.h:18:2: error: nested extern declaration of 'UL' [-Werror=nested-externs]
     unsigned long mask = BIT_MASK(nr);
     ^~~~~~~~
   cc1: all warnings being treated as errors
   In file included from tools/include/linux/bitops.h:13:0,
                    from tools/include/linux/hashtable.h:13,
                    from elf.h:12,
                    from check.h:10,
                    from check.c:10:
   tools/include/asm-generic/bitops/non-atomic.h: In function '__set_bit':
>> tools/include/linux/bits.h:10:24: error: implicit declaration of function 'UL' [-Werror=implicit-function-declaration]
    #define BIT_MASK(nr)  (UL(1) << ((nr) % BITS_PER_LONG))
                           ^
   tools/include/asm-generic/bitops/non-atomic.h:18:23: note: in expansion of macro 'BIT_MASK'
     unsigned long mask = BIT_MASK(nr);
                          ^~~~~~~~
   In file included from tools/include/asm-generic/bitops.h:30:0,
                    from tools/include/linux/bitops.h:32,
                    from tools/include/linux/hashtable.h:13,
                    from elf.h:12,
                    from check.h:10,
                    from check.c:10:
   tools/include/asm-generic/bitops/non-atomic.h:18:2: error: nested extern declaration of 'UL' [-Werror=nested-externs]
     unsigned long mask = BIT_MASK(nr);
     ^~~~~~~~
   In file included from tools/include/linux/bitops.h:13:0,
                    from tools/include/linux/hashtable.h:13,
                    from elf.h:12,
                    from check.h:10,
                    from orc_gen.c:10:
   tools/include/asm-generic/bitops/non-atomic.h: In function '__set_bit':
>> tools/include/linux/bits.h:10:24: error: implicit declaration of function 'UL' [-Werror=implicit-function-declaration]
    #define BIT_MASK(nr)  (UL(1) << ((nr) % BITS_PER_LONG))
                           ^
   tools/include/asm-generic/bitops/non-atomic.h:18:23: note: in expansion of macro 'BIT_MASK'
     unsigned long mask = BIT_MASK(nr);
                          ^~~~~~~~
   In file included from tools/include/asm-generic/bitops.h:30:0,
                    from tools/include/linux/bitops.h:32,
                    from tools/include/linux/hashtable.h:13,
                    from elf.h:12,
                    from check.h:10,
                    from orc_gen.c:10:
   tools/include/asm-generic/bitops/non-atomic.h:18:2: error: nested extern declaration of 'UL' [-Werror=nested-externs]
     unsigned long mask = BIT_MASK(nr);
     ^~~~~~~~
   mv: cannot stat 'tools/objtool/.builtin-check.o.tmp': No such file or directory
   make[4]: *** [tools/objtool/builtin-check.o] Error 1
   In file included from tools/include/linux/bitops.h:13:0,
                    from tools/include/linux/hashtable.h:13,
                    from elf.h:12,
                    from elf.c:19:
   tools/include/asm-generic/bitops/non-atomic.h: In function '__set_bit':
>> tools/include/linux/bits.h:10:24: error: implicit declaration of function 'UL' [-Werror=implicit-function-declaration]
    #define BIT_MASK(nr)  (UL(1) << ((nr) % BITS_PER_LONG))
                           ^
   tools/include/asm-generic/bitops/non-atomic.h:18:23: note: in expansion of macro 'BIT_MASK'
     unsigned long mask = BIT_MASK(nr);
                          ^~~~~~~~
   In file included from tools/include/asm-generic/bitops.h:30:0,
                    from tools/include/linux/bitops.h:32,
                    from tools/include/linux/hashtable.h:13,
                    from elf.h:12,
                    from elf.c:19:
   tools/include/asm-generic/bitops/non-atomic.h:18:2: error: nested extern declaration of 'UL' [-Werror=nested-externs]
     unsigned long mask = BIT_MASK(nr);
     ^~~~~~~~
   In file included from tools/include/linux/bitops.h:13:0,
                    from tools/include/linux/hashtable.h:13,
                    from elf.h:12,
                    from warn.h:14,
                    from orc_dump.c:8:
   tools/include/asm-generic/bitops/non-atomic.h: In function '__set_bit':
>> tools/include/linux/bits.h:10:24: error: implicit declaration of function 'UL' [-Werror=implicit-function-declaration]
    #define BIT_MASK(nr)  (UL(1) << ((nr) % BITS_PER_LONG))
                           ^
   tools/include/asm-generic/bitops/non-atomic.h:18:23: note: in expansion of macro 'BIT_MASK'
     unsigned long mask = BIT_MASK(nr);
                          ^~~~~~~~
   In file included from tools/include/asm-generic/bitops.h:30:0,
                    from tools/include/linux/bitops.h:32,
                    from tools/include/linux/hashtable.h:13,
                    from elf.h:12,
                    from warn.h:14,
                    from orc_dump.c:8:
   tools/include/asm-generic/bitops/non-atomic.h:18:2: error: nested extern declaration of 'UL' [-Werror=nested-externs]
     unsigned long mask = BIT_MASK(nr);
     ^~~~~~~~
   cc1: all warnings being treated as errors
   In file included from tools/include/linux/bitops.h:13:0,
                    from tools/include/linux/hashtable.h:13,
                    from elf.h:12,
                    from special.h:10,
                    from special.c:15:
   tools/include/asm-generic/bitops/non-atomic.h: In function '__set_bit':
>> tools/include/linux/bits.h:10:24: error: implicit declaration of function 'UL' [-Werror=implicit-function-declaration]
    #define BIT_MASK(nr)  (UL(1) << ((nr) % BITS_PER_LONG))
                           ^
   tools/include/asm-generic/bitops/non-atomic.h:18:23: note: in expansion of macro 'BIT_MASK'
     unsigned long mask = BIT_MASK(nr);
                          ^~~~~~~~
   In file included from tools/include/asm-generic/bitops.h:30:0,
                    from tools/include/linux/bitops.h:32,
                    from tools/include/linux/hashtable.h:13,
                    from elf.h:12,
                    from special.h:10,
                    from special.c:15:
   tools/include/asm-generic/bitops/non-atomic.h:18:2: error: nested extern declaration of 'UL' [-Werror=nested-externs]
     unsigned long mask = BIT_MASK(nr);
     ^~~~~~~~
   mv: cannot stat 'tools/objtool/.builtin-orc.o.tmp': No such file or directory
   make[4]: *** [tools/objtool/builtin-orc.o] Error 1
   cc1: all warnings being treated as errors
   In file included from tools/include/linux/bitops.h:13:0,
                    from tools/include/linux/hashtable.h:13,
                    from arch/x86/../../elf.h:12,
                    from arch/x86/decode.c:14:
   tools/include/asm-generic/bitops/non-atomic.h: In function '__set_bit':
>> tools/include/linux/bits.h:10:24: error: implicit declaration of function 'UL' [-Werror=implicit-function-declaration]
    #define BIT_MASK(nr)  (UL(1) << ((nr) % BITS_PER_LONG))
                           ^
   tools/include/asm-generic/bitops/non-atomic.h:18:23: note: in expansion of macro 'BIT_MASK'
     unsigned long mask = BIT_MASK(nr);
                          ^~~~~~~~
   In file included from tools/include/asm-generic/bitops.h:30:0,
                    from tools/include/linux/bitops.h:32,
                    from tools/include/linux/hashtable.h:13,
                    from arch/x86/../../elf.h:12,
                    from arch/x86/decode.c:14:
   tools/include/asm-generic/bitops/non-atomic.h:18:2: error: nested extern declaration of 'UL' [-Werror=nested-externs]
     unsigned long mask = BIT_MASK(nr);
     ^~~~~~~~
   mv: cannot stat 'tools/objtool/.special.o.tmp': No such file or directory
   make[4]: *** [tools/objtool/special.o] Error 1
   cc1: all warnings being treated as errors
   mv: cannot stat 'tools/objtool/.orc_dump.o.tmp': No such file or directory
   make[4]: *** [tools/objtool/orc_dump.o] Error 1
   cc1: all warnings being treated as errors
   mv: cannot stat 'tools/objtool/.orc_gen.o.tmp': No such file or directory
   make[4]: *** [tools/objtool/orc_gen.o] Error 1
   cc1: all warnings being treated as errors
   mv: cannot stat 'tools/objtool/.elf.o.tmp': No such file or directory
   make[4]: *** [tools/objtool/elf.o] Error 1
   cc1: all warnings being treated as errors
   mv: cannot stat 'tools/objtool/arch/x86/.decode.o.tmp': No such file or directory
   make[5]: *** [tools/objtool/arch/x86/decode.o] Error 1
   make[5]: Target '__build' not remade because of errors.
   make[4]: *** [arch/x86] Error 2
   cc1: all warnings being treated as errors
   mv: cannot stat 'tools/objtool/.check.o.tmp': No such file or directory
   make[4]: *** [tools/objtool/check.o] Error 1
   make[4]: Target '__build' not remade because of errors.
   make[3]: *** [tools/objtool/objtool-in.o] Error 2
   make[3]: Target 'all' not remade because of errors.
   make[2]: *** [objtool] Error 2
   make[1]: *** [tools/objtool] Error 2
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [sub-make] Error 2
   34 real  23 user  10 sys  100.03% cpu 	make prepare

vim +/UL +10 tools/include/linux/bits.h

     7	
     8	#define BIT(nr)			(UL(1) << (nr))
     9	#define BIT_ULL(nr)		(ULL(1) << (nr))
  > 10	#define BIT_MASK(nr)		(UL(1) << ((nr) % BITS_PER_LONG))
    11	#define BIT_WORD(nr)		((nr) / BITS_PER_LONG)
    12	#define BIT_ULL_MASK(nr)	(ULL(1) << ((nr) % BITS_PER_LONG_LONG))
    13	#define BIT_ULL_WORD(nr)	((nr) / BITS_PER_LONG_LONG)
    14	#define BITS_PER_BYTE		8
    15	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--hgkd23j42qq4qr2q
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
Gi6Iq3HOxeoHSSrzyf8AZH93F8gFAgA=

--hgkd23j42qq4qr2q--
