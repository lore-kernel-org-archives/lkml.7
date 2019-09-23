Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAD34C432C1
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 23:25:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8986D205F4
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 23:25:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407787AbfIWXZ0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 19:25:26 -0400
Received: from mga05.intel.com ([192.55.52.43]:10863 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729276AbfIWXZ0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 19:25:26 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Sep 2019 16:25:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,542,1559545200"; 
   d="scan'208";a="189199929"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 23 Sep 2019 16:25:24 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1iCXhs-0001D6-D8; Tue, 24 Sep 2019 07:25:24 +0800
Date:   Tue, 24 Sep 2019 07:25:12 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     kbuild-all@01.org, linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [tip:WIP.core/toplevel 4/6] drivers/sound/pci/hda/hda_proc.c:516:18:
 sparse: sparse: bad integer constant expression
Message-ID: <201909240752.Tbg8mV2x%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Patchwork-Hint: ignore
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://kernel.googlesource.com/pub/scm/linux/kernel/git/tip/tip.git WIP.core/toplevel
head:   166a63584297d3e1e1d7d380ee13dfe1a871ab04
commit: 7eff58ad913615232613491bec0f54d34ce73bda [4/6] toplevel: Fix up drivers/sound/ movement effects
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.1-rc1-7-g2b96cd8-dirty
        git checkout 7eff58ad913615232613491bec0f54d34ce73bda
        make ARCH=x86_64 allmodconfig
        make C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__'

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)

   include/linux/sched.h:595:43: sparse: sparse: bad integer constant expression
   include/linux/sched.h:595:73: sparse: sparse: invalid named zero-width bitfield `value'
   include/linux/sched.h:596:43: sparse: sparse: bad integer constant expression
   include/linux/sched.h:596:67: sparse: sparse: invalid named zero-width bitfield `bucket_id'
>> drivers/sound/pci/hda/hda_proc.c:516:18: sparse: sparse: bad integer constant expression
   drivers/sound/pci/hda/hda_proc.c:517:18: sparse: sparse: bad integer constant expression
   drivers/sound/pci/hda/hda_proc.c:518:18: sparse: sparse: bad integer constant expression
   drivers/sound/pci/hda/hda_proc.c:519:18: sparse: sparse: bad integer constant expression
   drivers/sound/pci/hda/hda_proc.c:520:18: sparse: sparse: bad integer constant expression
   drivers/sound/pci/hda/hda_proc.c:521:18: sparse: sparse: bad integer constant expression
   drivers/sound/pci/hda/hda_proc.c:522:18: sparse: sparse: bad integer constant expression
   drivers/sound/pci/hda/hda_proc.c:523:18: sparse: sparse: bad integer constant expression
--
   include/linux/sched.h:595:43: sparse: sparse: bad integer constant expression
   include/linux/sched.h:595:73: sparse: sparse: invalid named zero-width bitfield `value'
   include/linux/sched.h:596:43: sparse: sparse: bad integer constant expression
   include/linux/sched.h:596:67: sparse: sparse: invalid named zero-width bitfield `bucket_id'
>> drivers/sound/soc/atmel/mchp-i2s-mcc.c:242:59: sparse: sparse: dubious one-bit signed bitfield
   drivers/sound/soc/atmel/mchp-i2s-mcc.c:243:63: sparse: sparse: dubious one-bit signed bitfield
   drivers/sound/soc/atmel/mchp-i2s-mcc.c:244:57: sparse: sparse: dubious one-bit signed bitfield
   drivers/sound/soc/atmel/mchp-i2s-mcc.c:245:57: sparse: sparse: dubious one-bit signed bitfield
--
>> drivers/sound/soc/sunxi/sun8i-adda-pr-regmap.c:95:16: sparse: sparse: incorrect type in argument 3 (different address spaces) @@    expected void *bus_context @@    got void [noderef] <asvoid *bus_context @@
>> drivers/sound/soc/sunxi/sun8i-adda-pr-regmap.c:95:16: sparse:    expected void *bus_context
>> drivers/sound/soc/sunxi/sun8i-adda-pr-regmap.c:95:16: sparse:    got void [noderef] <asn:2> *base

vim +516 drivers/sound/pci/hda/hda_proc.c

797760ab14db4e sound/pci/hda/hda_proc.c Andrew Paprocki 2008-01-18  511  
797760ab14db4e sound/pci/hda/hda_proc.c Andrew Paprocki 2008-01-18  512  static void print_power_state(struct snd_info_buffer *buffer,
797760ab14db4e sound/pci/hda/hda_proc.c Andrew Paprocki 2008-01-18  513  			      struct hda_codec *codec, hda_nid_t nid)
797760ab14db4e sound/pci/hda/hda_proc.c Andrew Paprocki 2008-01-18  514  {
cc75cdfe1d6458 sound/pci/hda/hda_proc.c Takashi Iwai    2015-08-17  515  	static const char * const names[] = {
83d605fd63e704 sound/pci/hda/hda_proc.c Wu Fengguang    2009-11-18 @516  		[ilog2(AC_PWRST_D0SUP)]		= "D0",
83d605fd63e704 sound/pci/hda/hda_proc.c Wu Fengguang    2009-11-18  517  		[ilog2(AC_PWRST_D1SUP)]		= "D1",
83d605fd63e704 sound/pci/hda/hda_proc.c Wu Fengguang    2009-11-18  518  		[ilog2(AC_PWRST_D2SUP)]		= "D2",
83d605fd63e704 sound/pci/hda/hda_proc.c Wu Fengguang    2009-11-18  519  		[ilog2(AC_PWRST_D3SUP)]		= "D3",
83d605fd63e704 sound/pci/hda/hda_proc.c Wu Fengguang    2009-11-18  520  		[ilog2(AC_PWRST_D3COLDSUP)]	= "D3cold",
83d605fd63e704 sound/pci/hda/hda_proc.c Wu Fengguang    2009-11-18  521  		[ilog2(AC_PWRST_S3D3COLDSUP)]	= "S3D3cold",
83d605fd63e704 sound/pci/hda/hda_proc.c Wu Fengguang    2009-11-18  522  		[ilog2(AC_PWRST_CLKSTOP)]	= "CLKSTOP",
83d605fd63e704 sound/pci/hda/hda_proc.c Wu Fengguang    2009-11-18  523  		[ilog2(AC_PWRST_EPSS)]		= "EPSS",
83d605fd63e704 sound/pci/hda/hda_proc.c Wu Fengguang    2009-11-18  524  	};
83d605fd63e704 sound/pci/hda/hda_proc.c Wu Fengguang    2009-11-18  525  
9ba17b4d132f56 sound/pci/hda/hda_proc.c Takashi Iwai    2015-03-03  526  	int sup = param_read(codec, nid, AC_PAR_POWER_STATE);
797760ab14db4e sound/pci/hda/hda_proc.c Andrew Paprocki 2008-01-18  527  	int pwr = snd_hda_codec_read(codec, nid, 0,
797760ab14db4e sound/pci/hda/hda_proc.c Andrew Paprocki 2008-01-18  528  				     AC_VERB_GET_POWER_STATE, 0);
1d260d7b3b03f9 sound/pci/hda/hda_proc.c Takashi Iwai    2015-08-17  529  	if (sup != -1) {
1d260d7b3b03f9 sound/pci/hda/hda_proc.c Takashi Iwai    2015-08-17  530  		int i;
1d260d7b3b03f9 sound/pci/hda/hda_proc.c Takashi Iwai    2015-08-17  531  
1d260d7b3b03f9 sound/pci/hda/hda_proc.c Takashi Iwai    2015-08-17  532  		snd_iprintf(buffer, "  Power states: ");
1d260d7b3b03f9 sound/pci/hda/hda_proc.c Takashi Iwai    2015-08-17  533  		for (i = 0; i < ARRAY_SIZE(names); i++) {
1d260d7b3b03f9 sound/pci/hda/hda_proc.c Takashi Iwai    2015-08-17  534  			if (sup & (1U << i))
1d260d7b3b03f9 sound/pci/hda/hda_proc.c Takashi Iwai    2015-08-17  535  				snd_iprintf(buffer, " %s", names[i]);
1d260d7b3b03f9 sound/pci/hda/hda_proc.c Takashi Iwai    2015-08-17  536  		}
1d260d7b3b03f9 sound/pci/hda/hda_proc.c Takashi Iwai    2015-08-17  537  		snd_iprintf(buffer, "\n");
1d260d7b3b03f9 sound/pci/hda/hda_proc.c Takashi Iwai    2015-08-17  538  	}
83d605fd63e704 sound/pci/hda/hda_proc.c Wu Fengguang    2009-11-18  539  
ce63f3ba256a48 sound/pci/hda/hda_proc.c Wang Xingchao   2012-06-06  540  	snd_iprintf(buffer, "  Power: setting=%s, actual=%s",
797760ab14db4e sound/pci/hda/hda_proc.c Andrew Paprocki 2008-01-18  541  		    get_pwr_state(pwr & AC_PWRST_SETTING),
797760ab14db4e sound/pci/hda/hda_proc.c Andrew Paprocki 2008-01-18  542  		    get_pwr_state((pwr & AC_PWRST_ACTUAL) >>
797760ab14db4e sound/pci/hda/hda_proc.c Andrew Paprocki 2008-01-18  543  				  AC_PWRST_ACTUAL_SHIFT));
ce63f3ba256a48 sound/pci/hda/hda_proc.c Wang Xingchao   2012-06-06  544  	if (pwr & AC_PWRST_ERROR)
ce63f3ba256a48 sound/pci/hda/hda_proc.c Wang Xingchao   2012-06-06  545  		snd_iprintf(buffer, ", Error");
ce63f3ba256a48 sound/pci/hda/hda_proc.c Wang Xingchao   2012-06-06  546  	if (pwr & AC_PWRST_CLK_STOP_OK)
ce63f3ba256a48 sound/pci/hda/hda_proc.c Wang Xingchao   2012-06-06  547  		snd_iprintf(buffer, ", Clock-stop-OK");
ce63f3ba256a48 sound/pci/hda/hda_proc.c Wang Xingchao   2012-06-06  548  	if (pwr & AC_PWRST_SETTING_RESET)
ce63f3ba256a48 sound/pci/hda/hda_proc.c Wang Xingchao   2012-06-06  549  		snd_iprintf(buffer, ", Setting-reset");
ce63f3ba256a48 sound/pci/hda/hda_proc.c Wang Xingchao   2012-06-06  550  	snd_iprintf(buffer, "\n");
797760ab14db4e sound/pci/hda/hda_proc.c Andrew Paprocki 2008-01-18  551  }
797760ab14db4e sound/pci/hda/hda_proc.c Andrew Paprocki 2008-01-18  552  

:::::: The code at line 516 was first introduced by commit
:::::: 83d605fd63e704419ccb92d48b735c6890ce3d6a ALSA: hda - show EPSS capability in proc

:::::: TO: Wu Fengguang <fengguang.wu@intel.com>
:::::: CC: Takashi Iwai <tiwai@suse.de>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
