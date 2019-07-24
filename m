Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87C28C76186
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 02:55:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33AFC229F5
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 02:55:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726248AbfGXCzW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 22:55:22 -0400
Received: from mga17.intel.com ([192.55.52.151]:62834 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725497AbfGXCzW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 22:55:22 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Jul 2019 19:55:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,300,1559545200"; 
   d="gz'50?scan'50,208,50";a="188994551"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 23 Jul 2019 19:55:17 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1hq7Qz-000EjO-ED; Wed, 24 Jul 2019 10:55:17 +0800
Date:   Wed, 24 Jul 2019 10:54:35 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Max Filippov <jcmvbkbc@gmail.com>
Cc:     kbuild-all@01.org, linux-kernel@vger.kernel.org
Subject: arch/xtensa/kernel/coprocessor.S:128: Error: literal pool location
 required for text-section-literals; specify with .literal_position
Message-ID: <201907241012.UfFNHgLS%lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="fom6egumfp7zbdbd"
Content-Disposition: inline
X-Patchwork-Hint: ignore
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--fom6egumfp7zbdbd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Max,

First bad commit (maybe != root cause):

tree:   https://kernel.googlesource.com/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   ad5e427e0f6b702e52c11d1f7b2b7be3bac7de82
commit: d6d5f19e21d98c0607ff029e4e2e508d4cdd1d5a xtensa: abstract 'entry' and 'retw' in assembly code
date:   2 weeks ago
config: xtensa-audio_kc705_defconfig (attached as .config)
compiler: xtensa-test_kc705_hifi-linux-gcc (GCC) 7.4.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout d6d5f19e21d98c0607ff029e4e2e508d4cdd1d5a
        # save the attached .config to linux build tree
        GCC_VERSION=7.4.0 make.cross ARCH=xtensa 

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   arch/xtensa/kernel/coprocessor.S: Assembler messages:
   arch/xtensa/kernel/coprocessor.S:69: Error: unknown opcode or format name 'rur.ae_ovf_sar'
   arch/xtensa/kernel/coprocessor.S:69: Error: unknown opcode or format name 'rur.ae_bithead'
   arch/xtensa/kernel/coprocessor.S:69: Error: unknown opcode or format name 'rur.ae_ts_fts_bu_bp'
   arch/xtensa/kernel/coprocessor.S:69: Error: unknown opcode or format name 'rur.ae_cw_sd_no'
   arch/xtensa/kernel/coprocessor.S:69: Error: unknown opcode or format name 'rur.ae_cbegin0'
   arch/xtensa/kernel/coprocessor.S:69: Error: unknown opcode or format name 'rur.ae_cend0'
   arch/xtensa/kernel/coprocessor.S:69: Error: unknown opcode or format name 'ae_s64.i'
   arch/xtensa/kernel/coprocessor.S:69: Error: unknown opcode or format name 'ae_s64.i'
   arch/xtensa/kernel/coprocessor.S:69: Error: unknown opcode or format name 'ae_s64.i'
   arch/xtensa/kernel/coprocessor.S:69: Error: unknown opcode or format name 'ae_s64.i'
   arch/xtensa/kernel/coprocessor.S:69: Error: unknown opcode or format name 'ae_s64.i'
   arch/xtensa/kernel/coprocessor.S:69: Error: unknown opcode or format name 'ae_s64.i'
   arch/xtensa/kernel/coprocessor.S:69: Error: unknown opcode or format name 'ae_s64.i'
   arch/xtensa/kernel/coprocessor.S:69: Error: unknown opcode or format name 'ae_s64.i'
   arch/xtensa/kernel/coprocessor.S:69: Error: unknown opcode or format name 'ae_s64.i'
   arch/xtensa/kernel/coprocessor.S:69: Error: unknown opcode or format name 'ae_s64.i'
   arch/xtensa/kernel/coprocessor.S:69: Error: unknown opcode or format name 'ae_s64.i'
   arch/xtensa/kernel/coprocessor.S:69: Error: unknown opcode or format name 'ae_s64.i'
   arch/xtensa/kernel/coprocessor.S:69: Error: unknown opcode or format name 'ae_s64.i'
   arch/xtensa/kernel/coprocessor.S:69: Error: unknown opcode or format name 'ae_s64.i'
   arch/xtensa/kernel/coprocessor.S:69: Error: unknown opcode or format name 'ae_s64.i'
   arch/xtensa/kernel/coprocessor.S:69: Error: unknown opcode or format name 'ae_s64.i'
   arch/xtensa/kernel/coprocessor.S:69: Error: unknown opcode or format name 'ae_salign64.i'
   arch/xtensa/kernel/coprocessor.S:69: Error: unknown opcode or format name 'ae_salign64.i'
   arch/xtensa/kernel/coprocessor.S:69: Error: unknown opcode or format name 'ae_salign64.i'
   arch/xtensa/kernel/coprocessor.S:69: Error: unknown opcode or format name 'ae_salign64.i'
   arch/xtensa/kernel/coprocessor.S:78: Error: unknown opcode or format name 'wur.ae_ovf_sar'
   arch/xtensa/kernel/coprocessor.S:78: Error: unknown opcode or format name 'wur.ae_bithead'
   arch/xtensa/kernel/coprocessor.S:78: Error: unknown opcode or format name 'wur.ae_ts_fts_bu_bp'
   arch/xtensa/kernel/coprocessor.S:78: Error: unknown opcode or format name 'wur.ae_cw_sd_no'
   arch/xtensa/kernel/coprocessor.S:78: Error: unknown opcode or format name 'wur.ae_cbegin0'
   arch/xtensa/kernel/coprocessor.S:78: Error: unknown opcode or format name 'wur.ae_cend0'
   arch/xtensa/kernel/coprocessor.S:78: Error: unknown opcode or format name 'ae_l64.i'
   arch/xtensa/kernel/coprocessor.S:78: Error: unknown opcode or format name 'ae_l64.i'
   arch/xtensa/kernel/coprocessor.S:78: Error: unknown opcode or format name 'ae_l64.i'
   arch/xtensa/kernel/coprocessor.S:78: Error: unknown opcode or format name 'ae_l64.i'
   arch/xtensa/kernel/coprocessor.S:78: Error: unknown opcode or format name 'ae_l64.i'
   arch/xtensa/kernel/coprocessor.S:78: Error: unknown opcode or format name 'ae_l64.i'
   arch/xtensa/kernel/coprocessor.S:78: Error: unknown opcode or format name 'ae_l64.i'
   arch/xtensa/kernel/coprocessor.S:78: Error: unknown opcode or format name 'ae_l64.i'
   arch/xtensa/kernel/coprocessor.S:78: Error: unknown opcode or format name 'ae_l64.i'
   arch/xtensa/kernel/coprocessor.S:78: Error: unknown opcode or format name 'ae_l64.i'
   arch/xtensa/kernel/coprocessor.S:78: Error: unknown opcode or format name 'ae_l64.i'
   arch/xtensa/kernel/coprocessor.S:78: Error: unknown opcode or format name 'ae_l64.i'
   arch/xtensa/kernel/coprocessor.S:78: Error: unknown opcode or format name 'ae_l64.i'
   arch/xtensa/kernel/coprocessor.S:78: Error: unknown opcode or format name 'ae_l64.i'
   arch/xtensa/kernel/coprocessor.S:78: Error: unknown opcode or format name 'ae_l64.i'
   arch/xtensa/kernel/coprocessor.S:78: Error: unknown opcode or format name 'ae_l64.i'
   arch/xtensa/kernel/coprocessor.S:78: Error: unknown opcode or format name 'ae_lalign64.i'
   arch/xtensa/kernel/coprocessor.S:78: Error: unknown opcode or format name 'ae_lalign64.i'
   arch/xtensa/kernel/coprocessor.S:78: Error: unknown opcode or format name 'ae_lalign64.i'
   arch/xtensa/kernel/coprocessor.S:78: Error: unknown opcode or format name 'ae_lalign64.i'
   arch/xtensa/kernel/coprocessor.S:125: Error: unknown opcode or format name 'abi_entry'
>> arch/xtensa/kernel/coprocessor.S:128: Error: literal pool location required for text-section-literals; specify with .literal_position
   arch/xtensa/kernel/coprocessor.S:137: Error: unknown opcode or format name 'abi_ret'
   arch/xtensa/kernel/coprocessor.S:158: Error: literal pool location required for text-section-literals; specify with .literal_position
   arch/xtensa/kernel/coprocessor.S:199: Error: literal pool location required for text-section-literals; specify with .literal_position
   arch/xtensa/kernel/coprocessor.S:216: Error: literal pool location required for text-section-literals; specify with .literal_position
   arch/xtensa/kernel/coprocessor.S:217: Error: literal pool location required for text-section-literals; specify with .literal_position
   arch/xtensa/kernel/coprocessor.S:228: Error: literal pool location required for text-section-literals; specify with .literal_position
   arch/xtensa/kernel/coprocessor.S:238: Error: literal pool location required for text-section-literals; specify with .literal_position
   arch/xtensa/kernel/coprocessor.S:239: Error: literal pool location required for text-section-literals; specify with .literal_position
>> arch/xtensa/kernel/coprocessor.S:128: Error: literal pool location required for text-section-literals; specify with .literal_position

vim +128 arch/xtensa/kernel/coprocessor.S

5a0015d62668e64 Chris Zankel 2005-06-23   30  
c658eac628aa8df Chris Zankel 2008-02-12   31  /*
c658eac628aa8df Chris Zankel 2008-02-12   32   * Macros for lazy context switch. 
c658eac628aa8df Chris Zankel 2008-02-12   33   */
5a0015d62668e64 Chris Zankel 2005-06-23   34  
c658eac628aa8df Chris Zankel 2008-02-12   35  #define SAVE_CP_REGS(x)							\
5dacbbef3d29598 Max Filippov 2018-11-25   36  	.if XTENSA_HAVE_COPROCESSOR(x);					\
c658eac628aa8df Chris Zankel 2008-02-12   37  		.align 4;						\
c658eac628aa8df Chris Zankel 2008-02-12   38  	.Lsave_cp_regs_cp##x:						\
c658eac628aa8df Chris Zankel 2008-02-12   39  		xchal_cp##x##_store a2 a4 a5 a6 a7;			\
5dacbbef3d29598 Max Filippov 2018-11-25   40  		jx	a0;						\
5dacbbef3d29598 Max Filippov 2018-11-25   41  	.endif
5a0015d62668e64 Chris Zankel 2005-06-23   42  
c658eac628aa8df Chris Zankel 2008-02-12   43  #define SAVE_CP_REGS_TAB(x)						\
c658eac628aa8df Chris Zankel 2008-02-12   44  	.if XTENSA_HAVE_COPROCESSOR(x);					\
5dacbbef3d29598 Max Filippov 2018-11-25   45  		.long .Lsave_cp_regs_cp##x;				\
c658eac628aa8df Chris Zankel 2008-02-12   46  	.else;								\
c658eac628aa8df Chris Zankel 2008-02-12   47  		.long 0;						\
c658eac628aa8df Chris Zankel 2008-02-12   48  	.endif;								\
c658eac628aa8df Chris Zankel 2008-02-12   49  	.long THREAD_XTREGS_CP##x
5a0015d62668e64 Chris Zankel 2005-06-23   50  
5a0015d62668e64 Chris Zankel 2005-06-23   51  
c658eac628aa8df Chris Zankel 2008-02-12   52  #define LOAD_CP_REGS(x)							\
5dacbbef3d29598 Max Filippov 2018-11-25   53  	.if XTENSA_HAVE_COPROCESSOR(x);					\
c658eac628aa8df Chris Zankel 2008-02-12   54  		.align 4;						\
c658eac628aa8df Chris Zankel 2008-02-12   55  	.Lload_cp_regs_cp##x:						\
c658eac628aa8df Chris Zankel 2008-02-12   56  		xchal_cp##x##_load a2 a4 a5 a6 a7;			\
5dacbbef3d29598 Max Filippov 2018-11-25   57  		jx	a0;						\
5dacbbef3d29598 Max Filippov 2018-11-25   58  	.endif
5a0015d62668e64 Chris Zankel 2005-06-23   59  
c658eac628aa8df Chris Zankel 2008-02-12   60  #define LOAD_CP_REGS_TAB(x)						\
c658eac628aa8df Chris Zankel 2008-02-12   61  	.if XTENSA_HAVE_COPROCESSOR(x);					\
5dacbbef3d29598 Max Filippov 2018-11-25   62  		.long .Lload_cp_regs_cp##x;				\
c658eac628aa8df Chris Zankel 2008-02-12   63  	.else;								\
c658eac628aa8df Chris Zankel 2008-02-12   64  		.long 0;						\
c658eac628aa8df Chris Zankel 2008-02-12   65  	.endif;								\
c658eac628aa8df Chris Zankel 2008-02-12   66  	.long THREAD_XTREGS_CP##x
5a0015d62668e64 Chris Zankel 2005-06-23   67  
c658eac628aa8df Chris Zankel 2008-02-12   68  	SAVE_CP_REGS(0)
c658eac628aa8df Chris Zankel 2008-02-12   69  	SAVE_CP_REGS(1)
c658eac628aa8df Chris Zankel 2008-02-12   70  	SAVE_CP_REGS(2)
c658eac628aa8df Chris Zankel 2008-02-12   71  	SAVE_CP_REGS(3)
c658eac628aa8df Chris Zankel 2008-02-12   72  	SAVE_CP_REGS(4)
c658eac628aa8df Chris Zankel 2008-02-12   73  	SAVE_CP_REGS(5)
c658eac628aa8df Chris Zankel 2008-02-12   74  	SAVE_CP_REGS(6)
c658eac628aa8df Chris Zankel 2008-02-12   75  	SAVE_CP_REGS(7)
5a0015d62668e64 Chris Zankel 2005-06-23   76  
c658eac628aa8df Chris Zankel 2008-02-12   77  	LOAD_CP_REGS(0)
c658eac628aa8df Chris Zankel 2008-02-12  @78  	LOAD_CP_REGS(1)
c658eac628aa8df Chris Zankel 2008-02-12   79  	LOAD_CP_REGS(2)
c658eac628aa8df Chris Zankel 2008-02-12   80  	LOAD_CP_REGS(3)
c658eac628aa8df Chris Zankel 2008-02-12   81  	LOAD_CP_REGS(4)
c658eac628aa8df Chris Zankel 2008-02-12   82  	LOAD_CP_REGS(5)
c658eac628aa8df Chris Zankel 2008-02-12   83  	LOAD_CP_REGS(6)
c658eac628aa8df Chris Zankel 2008-02-12   84  	LOAD_CP_REGS(7)
5a0015d62668e64 Chris Zankel 2005-06-23   85  
5dacbbef3d29598 Max Filippov 2018-11-25   86  	.section ".rodata", "a"
c658eac628aa8df Chris Zankel 2008-02-12   87  	.align 4
c658eac628aa8df Chris Zankel 2008-02-12   88  .Lsave_cp_regs_jump_table:
c658eac628aa8df Chris Zankel 2008-02-12   89  	SAVE_CP_REGS_TAB(0)
c658eac628aa8df Chris Zankel 2008-02-12   90  	SAVE_CP_REGS_TAB(1)
c658eac628aa8df Chris Zankel 2008-02-12   91  	SAVE_CP_REGS_TAB(2)
c658eac628aa8df Chris Zankel 2008-02-12   92  	SAVE_CP_REGS_TAB(3)
c658eac628aa8df Chris Zankel 2008-02-12   93  	SAVE_CP_REGS_TAB(4)
c658eac628aa8df Chris Zankel 2008-02-12   94  	SAVE_CP_REGS_TAB(5)
c658eac628aa8df Chris Zankel 2008-02-12   95  	SAVE_CP_REGS_TAB(6)
c658eac628aa8df Chris Zankel 2008-02-12   96  	SAVE_CP_REGS_TAB(7)
5a0015d62668e64 Chris Zankel 2005-06-23   97  
c658eac628aa8df Chris Zankel 2008-02-12   98  .Lload_cp_regs_jump_table:
c658eac628aa8df Chris Zankel 2008-02-12   99  	LOAD_CP_REGS_TAB(0)
c658eac628aa8df Chris Zankel 2008-02-12  100  	LOAD_CP_REGS_TAB(1)
c658eac628aa8df Chris Zankel 2008-02-12  101  	LOAD_CP_REGS_TAB(2)
c658eac628aa8df Chris Zankel 2008-02-12  102  	LOAD_CP_REGS_TAB(3)
c658eac628aa8df Chris Zankel 2008-02-12  103  	LOAD_CP_REGS_TAB(4)
c658eac628aa8df Chris Zankel 2008-02-12  104  	LOAD_CP_REGS_TAB(5)
c658eac628aa8df Chris Zankel 2008-02-12  105  	LOAD_CP_REGS_TAB(6)
c658eac628aa8df Chris Zankel 2008-02-12  106  	LOAD_CP_REGS_TAB(7)
5a0015d62668e64 Chris Zankel 2005-06-23  107  
5dacbbef3d29598 Max Filippov 2018-11-25  108  	.previous
5dacbbef3d29598 Max Filippov 2018-11-25  109  
c658eac628aa8df Chris Zankel 2008-02-12  110  /*
3ffc2df9c76d3e1 Max Filippov 2018-11-26  111   * coprocessor_flush(struct thread_info*, index)
c658eac628aa8df Chris Zankel 2008-02-12  112   *                             a2        a3
c658eac628aa8df Chris Zankel 2008-02-12  113   *
3ffc2df9c76d3e1 Max Filippov 2018-11-26  114   * Save coprocessor registers for coprocessor 'index'.
c658eac628aa8df Chris Zankel 2008-02-12  115   * The register values are saved to or loaded from the coprocessor area 
c658eac628aa8df Chris Zankel 2008-02-12  116   * inside the task_info structure.
c658eac628aa8df Chris Zankel 2008-02-12  117   *
3ffc2df9c76d3e1 Max Filippov 2018-11-26  118   * Note that this function doesn't update the coprocessor_owner information!
c658eac628aa8df Chris Zankel 2008-02-12  119   *
c658eac628aa8df Chris Zankel 2008-02-12  120   */
c658eac628aa8df Chris Zankel 2008-02-12  121  
c658eac628aa8df Chris Zankel 2008-02-12  122  ENTRY(coprocessor_flush)
d1538c4675f37d0 Chris Zankel 2012-11-16  123  
d6d5f19e21d98c0 Max Filippov 2019-05-12  124  	/* reserve 4 bytes on stack to save a0 */
d6d5f19e21d98c0 Max Filippov 2019-05-12  125  	abi_entry(4)
d6d5f19e21d98c0 Max Filippov 2019-05-12  126  
c658eac628aa8df Chris Zankel 2008-02-12  127  	s32i	a0, a1, 0
c658eac628aa8df Chris Zankel 2008-02-12 @128  	movi	a0, .Lsave_cp_regs_jump_table
c658eac628aa8df Chris Zankel 2008-02-12  129  	addx8	a3, a3, a0
c658eac628aa8df Chris Zankel 2008-02-12  130  	l32i	a4, a3, 4
c658eac628aa8df Chris Zankel 2008-02-12  131  	l32i	a3, a3, 0
c658eac628aa8df Chris Zankel 2008-02-12  132  	add	a2, a2, a4
c658eac628aa8df Chris Zankel 2008-02-12  133  	beqz	a3, 1f
5dacbbef3d29598 Max Filippov 2018-11-25  134  	callx0	a3
c658eac628aa8df Chris Zankel 2008-02-12  135  1:	l32i	a0, a1, 0
d6d5f19e21d98c0 Max Filippov 2019-05-12  136  
d6d5f19e21d98c0 Max Filippov 2019-05-12  137  	abi_ret(4)
5a0015d62668e64 Chris Zankel 2005-06-23  138  
d1538c4675f37d0 Chris Zankel 2012-11-16  139  ENDPROC(coprocessor_flush)
d1538c4675f37d0 Chris Zankel 2012-11-16  140  
5a0015d62668e64 Chris Zankel 2005-06-23  141  /*
c658eac628aa8df Chris Zankel 2008-02-12  142   * Entry condition:
5a0015d62668e64 Chris Zankel 2005-06-23  143   *
c658eac628aa8df Chris Zankel 2008-02-12  144   *   a0:	trashed, original value saved on stack (PT_AREG0)
c658eac628aa8df Chris Zankel 2008-02-12  145   *   a1:	a1
c658eac628aa8df Chris Zankel 2008-02-12  146   *   a2:	new stack pointer, original in DEPC
99d5040ebc3cccc Max Filippov 2013-07-03  147   *   a3:	a3
c658eac628aa8df Chris Zankel 2008-02-12  148   *   depc:	a2, original value saved on stack (PT_DEPC)
99d5040ebc3cccc Max Filippov 2013-07-03  149   *   excsave_1:	dispatch table
5a0015d62668e64 Chris Zankel 2005-06-23  150   *
c658eac628aa8df Chris Zankel 2008-02-12  151   *   PT_DEPC >= VALID_DOUBLE_EXCEPTION_ADDRESS: double exception, DEPC
c658eac628aa8df Chris Zankel 2008-02-12  152   *	     <  VALID_DOUBLE_EXCEPTION_ADDRESS: regular exception
5a0015d62668e64 Chris Zankel 2005-06-23  153   */
5a0015d62668e64 Chris Zankel 2005-06-23  154  
c658eac628aa8df Chris Zankel 2008-02-12  155  ENTRY(fast_coprocessor_double)
d1538c4675f37d0 Chris Zankel 2012-11-16  156  
bc5378fcba97431 Max Filippov 2012-10-15  157  	wsr	a0, excsave1
2da03d4114b2587 Max Filippov 2017-12-09  158  	call0	unrecoverable_exception
c658eac628aa8df Chris Zankel 2008-02-12  159  
d1538c4675f37d0 Chris Zankel 2012-11-16  160  ENDPROC(fast_coprocessor_double)
c658eac628aa8df Chris Zankel 2008-02-12  161  
c658eac628aa8df Chris Zankel 2008-02-12  162  ENTRY(fast_coprocessor)
c658eac628aa8df Chris Zankel 2008-02-12  163  
c658eac628aa8df Chris Zankel 2008-02-12  164  	/* Save remaining registers a1-a3 and SAR */
c658eac628aa8df Chris Zankel 2008-02-12  165  
c658eac628aa8df Chris Zankel 2008-02-12  166  	s32i	a3, a2, PT_AREG3
bc5378fcba97431 Max Filippov 2012-10-15  167  	rsr	a3, sar
c658eac628aa8df Chris Zankel 2008-02-12  168  	s32i	a1, a2, PT_AREG1
c658eac628aa8df Chris Zankel 2008-02-12  169  	s32i	a3, a2, PT_SAR
c658eac628aa8df Chris Zankel 2008-02-12  170  	mov	a1, a2
bc5378fcba97431 Max Filippov 2012-10-15  171  	rsr	a2, depc
c658eac628aa8df Chris Zankel 2008-02-12  172  	s32i	a2, a1, PT_AREG2
5a0015d62668e64 Chris Zankel 2005-06-23  173  
5a0015d62668e64 Chris Zankel 2005-06-23  174  	/*
c658eac628aa8df Chris Zankel 2008-02-12  175  	 * The hal macros require up to 4 temporary registers. We use a3..a6.
5a0015d62668e64 Chris Zankel 2005-06-23  176  	 */
5a0015d62668e64 Chris Zankel 2005-06-23  177  
c658eac628aa8df Chris Zankel 2008-02-12  178  	s32i	a4, a1, PT_AREG4
c658eac628aa8df Chris Zankel 2008-02-12  179  	s32i	a5, a1, PT_AREG5
c658eac628aa8df Chris Zankel 2008-02-12  180  	s32i	a6, a1, PT_AREG6
c658eac628aa8df Chris Zankel 2008-02-12  181  
c658eac628aa8df Chris Zankel 2008-02-12  182  	/* Find coprocessor number. Subtract first CP EXCCAUSE from EXCCAUSE */
c658eac628aa8df Chris Zankel 2008-02-12  183  
bc5378fcba97431 Max Filippov 2012-10-15  184  	rsr	a3, exccause
c658eac628aa8df Chris Zankel 2008-02-12  185  	addi	a3, a3, -EXCCAUSE_COPROCESSOR0_DISABLED
c658eac628aa8df Chris Zankel 2008-02-12  186  
c658eac628aa8df Chris Zankel 2008-02-12  187  	/* Set corresponding CPENABLE bit -> (sar:cp-index, a3: 1<<cp-index)*/
c658eac628aa8df Chris Zankel 2008-02-12  188  
c658eac628aa8df Chris Zankel 2008-02-12  189  	ssl	a3			# SAR: 32 - coprocessor_number
c658eac628aa8df Chris Zankel 2008-02-12  190  	movi	a2, 1
bc5378fcba97431 Max Filippov 2012-10-15  191  	rsr	a0, cpenable
c658eac628aa8df Chris Zankel 2008-02-12  192  	sll	a2, a2
c658eac628aa8df Chris Zankel 2008-02-12  193  	or	a0, a0, a2
bc5378fcba97431 Max Filippov 2012-10-15  194  	wsr	a0, cpenable
c658eac628aa8df Chris Zankel 2008-02-12  195  	rsync
c658eac628aa8df Chris Zankel 2008-02-12  196  
c658eac628aa8df Chris Zankel 2008-02-12  197  	/* Retrieve previous owner. (a3 still holds CP number) */
c658eac628aa8df Chris Zankel 2008-02-12  198  
c658eac628aa8df Chris Zankel 2008-02-12  199  	movi	a0, coprocessor_owner	# list of owners
c658eac628aa8df Chris Zankel 2008-02-12  200  	addx4	a0, a3, a0		# entry for CP
c658eac628aa8df Chris Zankel 2008-02-12  201  	l32i	a4, a0, 0
c658eac628aa8df Chris Zankel 2008-02-12  202  
c658eac628aa8df Chris Zankel 2008-02-12  203  	beqz	a4, 1f			# skip 'save' if no previous owner
c658eac628aa8df Chris Zankel 2008-02-12  204  
c658eac628aa8df Chris Zankel 2008-02-12  205  	/* Disable coprocessor for previous owner. (a2 = 1 << CP number) */
c658eac628aa8df Chris Zankel 2008-02-12  206  
c658eac628aa8df Chris Zankel 2008-02-12  207  	l32i	a5, a4, THREAD_CPENABLE
c658eac628aa8df Chris Zankel 2008-02-12  208  	xor	a5, a5, a2		# (1 << cp-id) still in a2
c658eac628aa8df Chris Zankel 2008-02-12  209  	s32i	a5, a4, THREAD_CPENABLE
c658eac628aa8df Chris Zankel 2008-02-12  210  
c658eac628aa8df Chris Zankel 2008-02-12  211  	/*
c658eac628aa8df Chris Zankel 2008-02-12  212  	 * Get context save area and 'call' save routine. 
c658eac628aa8df Chris Zankel 2008-02-12  213  	 * (a4 still holds previous owner (thread_info), a3 CP number)
c658eac628aa8df Chris Zankel 2008-02-12  214  	 */
c658eac628aa8df Chris Zankel 2008-02-12  215  
c658eac628aa8df Chris Zankel 2008-02-12  216  	movi	a5, .Lsave_cp_regs_jump_table
c658eac628aa8df Chris Zankel 2008-02-12  217  	movi	a0, 2f			# a0: 'return' address
c658eac628aa8df Chris Zankel 2008-02-12  218  	addx8	a3, a3, a5		# a3: coprocessor number
c658eac628aa8df Chris Zankel 2008-02-12  219  	l32i	a2, a3, 4		# a2: xtregs offset
5dacbbef3d29598 Max Filippov 2018-11-25  220  	l32i	a3, a3, 0		# a3: jump address
c658eac628aa8df Chris Zankel 2008-02-12  221  	add	a2, a2, a4
5dacbbef3d29598 Max Filippov 2018-11-25  222  	jx	a3
c658eac628aa8df Chris Zankel 2008-02-12  223  
c658eac628aa8df Chris Zankel 2008-02-12  224  	/* Note that only a0 and a1 were preserved. */
c658eac628aa8df Chris Zankel 2008-02-12  225  
bc5378fcba97431 Max Filippov 2012-10-15  226  2:	rsr	a3, exccause
c658eac628aa8df Chris Zankel 2008-02-12  227  	addi	a3, a3, -EXCCAUSE_COPROCESSOR0_DISABLED
c658eac628aa8df Chris Zankel 2008-02-12  228  	movi	a0, coprocessor_owner
c658eac628aa8df Chris Zankel 2008-02-12  229  	addx4	a0, a3, a0
c658eac628aa8df Chris Zankel 2008-02-12  230  
c658eac628aa8df Chris Zankel 2008-02-12  231  	/* Set new 'owner' (a0 points to the CP owner, a3 contains the CP nr) */
c658eac628aa8df Chris Zankel 2008-02-12  232  
c658eac628aa8df Chris Zankel 2008-02-12  233  1:	GET_THREAD_INFO (a4, a1)
c658eac628aa8df Chris Zankel 2008-02-12  234  	s32i	a4, a0, 0
c658eac628aa8df Chris Zankel 2008-02-12  235  
c658eac628aa8df Chris Zankel 2008-02-12  236  	/* Get context save area and 'call' load routine. */
c658eac628aa8df Chris Zankel 2008-02-12  237  
c658eac628aa8df Chris Zankel 2008-02-12  238  	movi	a5, .Lload_cp_regs_jump_table
c658eac628aa8df Chris Zankel 2008-02-12  239  	movi	a0, 1f
c658eac628aa8df Chris Zankel 2008-02-12  240  	addx8	a3, a3, a5
c658eac628aa8df Chris Zankel 2008-02-12  241  	l32i	a2, a3, 4		# a2: xtregs offset
5dacbbef3d29598 Max Filippov 2018-11-25  242  	l32i	a3, a3, 0		# a3: jump address
c658eac628aa8df Chris Zankel 2008-02-12  243  	add	a2, a2, a4
5dacbbef3d29598 Max Filippov 2018-11-25  244  	jx	a3
c658eac628aa8df Chris Zankel 2008-02-12  245  
c658eac628aa8df Chris Zankel 2008-02-12  246  	/* Restore all registers and return from exception handler. */
c658eac628aa8df Chris Zankel 2008-02-12  247  
c658eac628aa8df Chris Zankel 2008-02-12  248  1:	l32i	a6, a1, PT_AREG6
c658eac628aa8df Chris Zankel 2008-02-12  249  	l32i	a5, a1, PT_AREG5
c658eac628aa8df Chris Zankel 2008-02-12  250  	l32i	a4, a1, PT_AREG4
c658eac628aa8df Chris Zankel 2008-02-12  251  
c658eac628aa8df Chris Zankel 2008-02-12  252  	l32i	a0, a1, PT_SAR
c658eac628aa8df Chris Zankel 2008-02-12  253  	l32i	a3, a1, PT_AREG3
c658eac628aa8df Chris Zankel 2008-02-12  254  	l32i	a2, a1, PT_AREG2
bc5378fcba97431 Max Filippov 2012-10-15  255  	wsr	a0, sar
c658eac628aa8df Chris Zankel 2008-02-12  256  	l32i	a0, a1, PT_AREG0
c658eac628aa8df Chris Zankel 2008-02-12  257  	l32i	a1, a1, PT_AREG1
c658eac628aa8df Chris Zankel 2008-02-12  258  
c658eac628aa8df Chris Zankel 2008-02-12  259  	rfe
c658eac628aa8df Chris Zankel 2008-02-12  260  
d1538c4675f37d0 Chris Zankel 2012-11-16  261  ENDPROC(fast_coprocessor)
d1538c4675f37d0 Chris Zankel 2012-11-16  262  
c658eac628aa8df Chris Zankel 2008-02-12  263  	.data
d1538c4675f37d0 Chris Zankel 2012-11-16  264  
c658eac628aa8df Chris Zankel 2008-02-12  265  ENTRY(coprocessor_owner)
d1538c4675f37d0 Chris Zankel 2012-11-16  266  
c658eac628aa8df Chris Zankel 2008-02-12  267  	.fill XCHAL_CP_MAX, 4, 0
c658eac628aa8df Chris Zankel 2008-02-12  268  
d1538c4675f37d0 Chris Zankel 2012-11-16  269  END(coprocessor_owner)
d1538c4675f37d0 Chris Zankel 2012-11-16  270  
c658eac628aa8df Chris Zankel 2008-02-12  271  #endif /* XTENSA_HAVE_COPROCESSORS */

:::::: The code at line 128 was first introduced by commit
:::::: c658eac628aa8df040dfe614556d95e6da3a9ffb [XTENSA] Add support for configurable registers and coprocessors

:::::: TO: Chris Zankel <chris@zankel.net>
:::::: CC: Chris Zankel <chris@zankel.net>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--fom6egumfp7zbdbd
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--fom6egumfp7zbdbd--
