Return-Path: <SRS0=jE6e=VN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6167CC76192
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 22:31:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 167E1217F4
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 22:31:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388948AbfGPWb1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jul 2019 18:31:27 -0400
Received: from mga12.intel.com ([192.55.52.136]:57009 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728766AbfGPWbX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jul 2019 18:31:23 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Jul 2019 15:31:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,271,1559545200"; 
   d="gz'50?scan'50,208,50";a="172678928"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 16 Jul 2019 15:31:16 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1hnVye-0009W0-Bu; Wed, 17 Jul 2019 06:31:16 +0800
Date:   Wed, 17 Jul 2019 06:31:03 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Michel Thierry <michel.thierry@intel.com>
Cc:     kbuild-all@01.org, linux-kernel@vger.kernel.org,
        tipbuild@zytor.com, Thomas Gleixner <tglx@linutronix.de>,
        Lucas De Marchi <lucas.demarchi@intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>
Subject: [tip:x86/urgent 6/9] arch/x86/kernel/early-quirks.c:518:67: warning:
 missing braces around initializer
Message-ID: <201907170655.gqywAWjW%lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="kc3xsxctshrul645"
Content-Disposition: inline
X-Patchwork-Hint: ignore
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--kc3xsxctshrul645
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://kernel.googlesource.com/pub/scm/linux/kernel/git/tip/tip.git x86/urgent
head:   907cb11da7a725445dccc6c2ca2d428739f6cd71
commit: 080ac61bad4a3307880bb982cec48b225912b362 [6/9] x86/gpu: Add TGL stolen memory support
config: i386-defconfig (attached as .config)
compiler: gcc-7 (Debian 7.4.0-6) 7.4.0
reproduce:
        git checkout 080ac61bad4a3307880bb982cec48b225912b362
        # save the attached .config to linux build tree
        make ARCH=i386 

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   arch/x86/kernel/early-quirks.c:552:2: error: implicit declaration of function 'INTEL_TGL_12_IDS'; did you mean 'INTEL_ICL_11_IDS'? [-Werror=implicit-function-declaration]
     INTEL_TGL_12_IDS(&gen11_early_ops),
     ^~~~~~~~~~~~~~~~
     INTEL_ICL_11_IDS
   arch/x86/kernel/early-quirks.c:552:2: error: initializer element is not constant
   arch/x86/kernel/early-quirks.c:552:2: note: (near initialization for 'intel_early_ids[261].vendor')
>> arch/x86/kernel/early-quirks.c:518:67: warning: missing braces around initializer [-Wmissing-braces]
    static const struct pci_device_id intel_early_ids[] __initconst = {
                                                                      ^
   arch/x86/kernel/early-quirks.c:552:2:
     INTEL_TGL_12_IDS(&gen11_early_ops),
     {
    };
    }
   cc1: some warnings being treated as errors

vim +518 arch/x86/kernel/early-quirks.c

db0c8d8b031d2b5 arch/x86/kernel/early-quirks.c    Paulo Zanoni     2018-05-04  517  
ee0629cfd3c16c7 arch/x86/kernel/early-quirks.c    Joonas Lahtinen  2016-04-22 @518  static const struct pci_device_id intel_early_ids[] __initconst = {
ee0629cfd3c16c7 arch/x86/kernel/early-quirks.c    Joonas Lahtinen  2016-04-22  519  	INTEL_I830_IDS(&i830_early_ops),
ee0629cfd3c16c7 arch/x86/kernel/early-quirks.c    Joonas Lahtinen  2016-04-22  520  	INTEL_I845G_IDS(&i845_early_ops),
ee0629cfd3c16c7 arch/x86/kernel/early-quirks.c    Joonas Lahtinen  2016-04-22  521  	INTEL_I85X_IDS(&i85x_early_ops),
ee0629cfd3c16c7 arch/x86/kernel/early-quirks.c    Joonas Lahtinen  2016-04-22  522  	INTEL_I865G_IDS(&i865_early_ops),
ee0629cfd3c16c7 arch/x86/kernel/early-quirks.c    Joonas Lahtinen  2016-04-22  523  	INTEL_I915G_IDS(&gen3_early_ops),
ee0629cfd3c16c7 arch/x86/kernel/early-quirks.c    Joonas Lahtinen  2016-04-22  524  	INTEL_I915GM_IDS(&gen3_early_ops),
ee0629cfd3c16c7 arch/x86/kernel/early-quirks.c    Joonas Lahtinen  2016-04-22  525  	INTEL_I945G_IDS(&gen3_early_ops),
ee0629cfd3c16c7 arch/x86/kernel/early-quirks.c    Joonas Lahtinen  2016-04-22  526  	INTEL_I945GM_IDS(&gen3_early_ops),
8d9c20e1d1e3833 arch/x86/kernel/early-quirks.c    Carlos Santa     2016-08-17  527  	INTEL_VLV_IDS(&gen6_early_ops),
86d35d4e7625f7c arch/x86/kernel/early-quirks.c    Tvrtko Ursulin   2019-03-26  528  	INTEL_PINEVIEW_G_IDS(&gen3_early_ops),
86d35d4e7625f7c arch/x86/kernel/early-quirks.c    Tvrtko Ursulin   2019-03-26  529  	INTEL_PINEVIEW_M_IDS(&gen3_early_ops),
ee0629cfd3c16c7 arch/x86/kernel/early-quirks.c    Joonas Lahtinen  2016-04-22  530  	INTEL_I965G_IDS(&gen3_early_ops),
ee0629cfd3c16c7 arch/x86/kernel/early-quirks.c    Joonas Lahtinen  2016-04-22  531  	INTEL_G33_IDS(&gen3_early_ops),
ee0629cfd3c16c7 arch/x86/kernel/early-quirks.c    Joonas Lahtinen  2016-04-22  532  	INTEL_I965GM_IDS(&gen3_early_ops),
ee0629cfd3c16c7 arch/x86/kernel/early-quirks.c    Joonas Lahtinen  2016-04-22  533  	INTEL_GM45_IDS(&gen3_early_ops),
ee0629cfd3c16c7 arch/x86/kernel/early-quirks.c    Joonas Lahtinen  2016-04-22  534  	INTEL_G45_IDS(&gen3_early_ops),
ee0629cfd3c16c7 arch/x86/kernel/early-quirks.c    Joonas Lahtinen  2016-04-22  535  	INTEL_IRONLAKE_D_IDS(&gen3_early_ops),
ee0629cfd3c16c7 arch/x86/kernel/early-quirks.c    Joonas Lahtinen  2016-04-22  536  	INTEL_IRONLAKE_M_IDS(&gen3_early_ops),
ee0629cfd3c16c7 arch/x86/kernel/early-quirks.c    Joonas Lahtinen  2016-04-22  537  	INTEL_SNB_D_IDS(&gen6_early_ops),
ee0629cfd3c16c7 arch/x86/kernel/early-quirks.c    Joonas Lahtinen  2016-04-22  538  	INTEL_SNB_M_IDS(&gen6_early_ops),
ee0629cfd3c16c7 arch/x86/kernel/early-quirks.c    Joonas Lahtinen  2016-04-22  539  	INTEL_IVB_M_IDS(&gen6_early_ops),
ee0629cfd3c16c7 arch/x86/kernel/early-quirks.c    Joonas Lahtinen  2016-04-22  540  	INTEL_IVB_D_IDS(&gen6_early_ops),
8d9c20e1d1e3833 arch/x86/kernel/early-quirks.c    Carlos Santa     2016-08-17  541  	INTEL_HSW_IDS(&gen6_early_ops),
8d9c20e1d1e3833 arch/x86/kernel/early-quirks.c    Carlos Santa     2016-08-17  542  	INTEL_BDW_IDS(&gen8_early_ops),
ee0629cfd3c16c7 arch/x86/kernel/early-quirks.c    Joonas Lahtinen  2016-04-22  543  	INTEL_CHV_IDS(&chv_early_ops),
ee0629cfd3c16c7 arch/x86/kernel/early-quirks.c    Joonas Lahtinen  2016-04-22  544  	INTEL_SKL_IDS(&gen9_early_ops),
ee0629cfd3c16c7 arch/x86/kernel/early-quirks.c    Joonas Lahtinen  2016-04-22  545  	INTEL_BXT_IDS(&gen9_early_ops),
ee0629cfd3c16c7 arch/x86/kernel/early-quirks.c    Joonas Lahtinen  2016-04-22  546  	INTEL_KBL_IDS(&gen9_early_ops),
33aa69ed8aacd92 arch/x86/kernel/early-quirks.c    Lucas De Marchi  2017-12-13  547  	INTEL_CFL_IDS(&gen9_early_ops),
bc384c77e3bb3df arch/x86/kernel/early-quirks.c    Paulo Zanoni     2017-01-24  548  	INTEL_GLK_IDS(&gen9_early_ops),
2e1e9d48939edad arch/x86/kernel/early-quirks.c    Paulo Zanoni     2017-07-05  549  	INTEL_CNL_IDS(&gen9_early_ops),
db0c8d8b031d2b5 arch/x86/kernel/early-quirks.c    Paulo Zanoni     2018-05-04  550  	INTEL_ICL_11_IDS(&gen11_early_ops),
d53fef0be4a5f2f arch/x86/kernel/early-quirks.c    Rodrigo Vivi     2019-03-15  551  	INTEL_EHL_IDS(&gen11_early_ops),
080ac61bad4a330 arch/x86/kernel/early-quirks.c    Michel Thierry   2019-07-12 @552  	INTEL_TGL_12_IDS(&gen11_early_ops),
814c5f1f52a4beb arch/x86/kernel/early-quirks.c    Jesse Barnes     2013-07-26  553  };
814c5f1f52a4beb arch/x86/kernel/early-quirks.c    Jesse Barnes     2013-07-26  554  
55f56fc46020ea5 arch/x86/kernel/early-quirks.c    Matthew Auld     2017-12-11  555  struct resource intel_graphics_stolen_res __ro_after_init = DEFINE_RES_MEM(0, 0);
55f56fc46020ea5 arch/x86/kernel/early-quirks.c    Matthew Auld     2017-12-11  556  EXPORT_SYMBOL(intel_graphics_stolen_res);
55f56fc46020ea5 arch/x86/kernel/early-quirks.c    Matthew Auld     2017-12-11  557  
ee0629cfd3c16c7 arch/x86/kernel/early-quirks.c    Joonas Lahtinen  2016-04-22  558  static void __init
ee0629cfd3c16c7 arch/x86/kernel/early-quirks.c    Joonas Lahtinen  2016-04-22  559  intel_graphics_stolen(int num, int slot, int func,
ee0629cfd3c16c7 arch/x86/kernel/early-quirks.c    Joonas Lahtinen  2016-04-22  560  		      const struct intel_early_ops *early_ops)
814c5f1f52a4beb arch/x86/kernel/early-quirks.c    Jesse Barnes     2013-07-26  561  {
6f9fa996c9bf3d8 arch/x86/kernel/early-quirks.c    Joonas Lahtinen  2017-12-11  562  	resource_size_t base, size;
6f9fa996c9bf3d8 arch/x86/kernel/early-quirks.c    Joonas Lahtinen  2017-12-11  563  	resource_size_t end;
814c5f1f52a4beb arch/x86/kernel/early-quirks.c    Jesse Barnes     2013-07-26  564  
ee0629cfd3c16c7 arch/x86/kernel/early-quirks.c    Joonas Lahtinen  2016-04-22  565  	size = early_ops->stolen_size(num, slot, func);
ee0629cfd3c16c7 arch/x86/kernel/early-quirks.c    Joonas Lahtinen  2016-04-22  566  	base = early_ops->stolen_base(num, slot, func, size);
ee0629cfd3c16c7 arch/x86/kernel/early-quirks.c    Joonas Lahtinen  2016-04-22  567  
ee0629cfd3c16c7 arch/x86/kernel/early-quirks.c    Joonas Lahtinen  2016-04-22  568  	if (!size || !base)
ee0629cfd3c16c7 arch/x86/kernel/early-quirks.c    Joonas Lahtinen  2016-04-22  569  		return;
ee0629cfd3c16c7 arch/x86/kernel/early-quirks.c    Joonas Lahtinen  2016-04-22  570  
01e5d3b42e2047d arch/x86/kernel/early-quirks.c    Chris Wilson     2016-05-09  571  	end = base + size - 1;
55f56fc46020ea5 arch/x86/kernel/early-quirks.c    Matthew Auld     2017-12-11  572  
55f56fc46020ea5 arch/x86/kernel/early-quirks.c    Matthew Auld     2017-12-11  573  	intel_graphics_stolen_res.start = base;
55f56fc46020ea5 arch/x86/kernel/early-quirks.c    Matthew Auld     2017-12-11  574  	intel_graphics_stolen_res.end = end;
55f56fc46020ea5 arch/x86/kernel/early-quirks.c    Matthew Auld     2017-12-11  575  
55f56fc46020ea5 arch/x86/kernel/early-quirks.c    Matthew Auld     2017-12-11  576  	printk(KERN_INFO "Reserving Intel graphics memory at %pR\n",
55f56fc46020ea5 arch/x86/kernel/early-quirks.c    Matthew Auld     2017-12-11  577  	       &intel_graphics_stolen_res);
ee0629cfd3c16c7 arch/x86/kernel/early-quirks.c    Joonas Lahtinen  2016-04-22  578  
814c5f1f52a4beb arch/x86/kernel/early-quirks.c    Jesse Barnes     2013-07-26  579  	/* Mark this space as reserved */
09821ff1d50a1ec arch/x86/kernel/early-quirks.c    Ingo Molnar      2017-01-28  580  	e820__range_add(base, size, E820_TYPE_RESERVED);
f9748fa04585104 arch/x86/kernel/early-quirks.c    Ingo Molnar      2017-01-28  581  	e820__update_table(e820_table);
814c5f1f52a4beb arch/x86/kernel/early-quirks.c    Jesse Barnes     2013-07-26  582  }
ee0629cfd3c16c7 arch/x86/kernel/early-quirks.c    Joonas Lahtinen  2016-04-22  583  
ee0629cfd3c16c7 arch/x86/kernel/early-quirks.c    Joonas Lahtinen  2016-04-22  584  static void __init intel_graphics_quirks(int num, int slot, int func)
ee0629cfd3c16c7 arch/x86/kernel/early-quirks.c    Joonas Lahtinen  2016-04-22  585  {
ee0629cfd3c16c7 arch/x86/kernel/early-quirks.c    Joonas Lahtinen  2016-04-22  586  	const struct intel_early_ops *early_ops;
ee0629cfd3c16c7 arch/x86/kernel/early-quirks.c    Joonas Lahtinen  2016-04-22  587  	u16 device;
ee0629cfd3c16c7 arch/x86/kernel/early-quirks.c    Joonas Lahtinen  2016-04-22  588  	int i;
ee0629cfd3c16c7 arch/x86/kernel/early-quirks.c    Joonas Lahtinen  2016-04-22  589  
ee0629cfd3c16c7 arch/x86/kernel/early-quirks.c    Joonas Lahtinen  2016-04-22  590  	device = read_pci_config_16(num, slot, func, PCI_DEVICE_ID);
ee0629cfd3c16c7 arch/x86/kernel/early-quirks.c    Joonas Lahtinen  2016-04-22  591  
ee0629cfd3c16c7 arch/x86/kernel/early-quirks.c    Joonas Lahtinen  2016-04-22  592  	for (i = 0; i < ARRAY_SIZE(intel_early_ids); i++) {
ee0629cfd3c16c7 arch/x86/kernel/early-quirks.c    Joonas Lahtinen  2016-04-22  593  		kernel_ulong_t driver_data = intel_early_ids[i].driver_data;
ee0629cfd3c16c7 arch/x86/kernel/early-quirks.c    Joonas Lahtinen  2016-04-22  594  
ee0629cfd3c16c7 arch/x86/kernel/early-quirks.c    Joonas Lahtinen  2016-04-22  595  		if (intel_early_ids[i].device != device)
ee0629cfd3c16c7 arch/x86/kernel/early-quirks.c    Joonas Lahtinen  2016-04-22  596  			continue;
ee0629cfd3c16c7 arch/x86/kernel/early-quirks.c    Joonas Lahtinen  2016-04-22  597  
ee0629cfd3c16c7 arch/x86/kernel/early-quirks.c    Joonas Lahtinen  2016-04-22  598  		early_ops = (typeof(early_ops))driver_data;
ee0629cfd3c16c7 arch/x86/kernel/early-quirks.c    Joonas Lahtinen  2016-04-22  599  
ee0629cfd3c16c7 arch/x86/kernel/early-quirks.c    Joonas Lahtinen  2016-04-22  600  		intel_graphics_stolen(num, slot, func, early_ops);
ee0629cfd3c16c7 arch/x86/kernel/early-quirks.c    Joonas Lahtinen  2016-04-22  601  
814c5f1f52a4beb arch/x86/kernel/early-quirks.c    Jesse Barnes     2013-07-26  602  		return;
814c5f1f52a4beb arch/x86/kernel/early-quirks.c    Jesse Barnes     2013-07-26  603  	}
814c5f1f52a4beb arch/x86/kernel/early-quirks.c    Jesse Barnes     2013-07-26  604  }
814c5f1f52a4beb arch/x86/kernel/early-quirks.c    Jesse Barnes     2013-07-26  605  
62187910b0fc7a7 arch/x86/kernel/early-quirks.c    Feng Tang        2014-04-24  606  static void __init force_disable_hpet(int num, int slot, int func)
62187910b0fc7a7 arch/x86/kernel/early-quirks.c    Feng Tang        2014-04-24  607  {
62187910b0fc7a7 arch/x86/kernel/early-quirks.c    Feng Tang        2014-04-24  608  #ifdef CONFIG_HPET_TIMER
3d45ac4b35cbdf9 arch/x86/kernel/early-quirks.c    Jan Beulich      2015-10-19  609  	boot_hpet_disable = true;
62187910b0fc7a7 arch/x86/kernel/early-quirks.c    Feng Tang        2014-04-24  610  	pr_info("x86/hpet: Will disable the HPET for this platform because it's not reliable\n");
62187910b0fc7a7 arch/x86/kernel/early-quirks.c    Feng Tang        2014-04-24  611  #endif
62187910b0fc7a7 arch/x86/kernel/early-quirks.c    Feng Tang        2014-04-24  612  }
62187910b0fc7a7 arch/x86/kernel/early-quirks.c    Feng Tang        2014-04-24  613  
abb2bafd295fe96 arch/x86/kernel/early-quirks.c    Lukas Wunner     2016-06-12  614  #define BCM4331_MMIO_SIZE	16384
abb2bafd295fe96 arch/x86/kernel/early-quirks.c    Lukas Wunner     2016-06-12  615  #define BCM4331_PM_CAP		0x40
abb2bafd295fe96 arch/x86/kernel/early-quirks.c    Lukas Wunner     2016-06-12  616  #define bcma_aread32(reg)	ioread32(mmio + 1 * BCMA_CORE_SIZE + reg)
abb2bafd295fe96 arch/x86/kernel/early-quirks.c    Lukas Wunner     2016-06-12  617  #define bcma_awrite32(reg, val)	iowrite32(val, mmio + 1 * BCMA_CORE_SIZE + reg)
abb2bafd295fe96 arch/x86/kernel/early-quirks.c    Lukas Wunner     2016-06-12  618  
abb2bafd295fe96 arch/x86/kernel/early-quirks.c    Lukas Wunner     2016-06-12  619  static void __init apple_airport_reset(int bus, int slot, int func)
abb2bafd295fe96 arch/x86/kernel/early-quirks.c    Lukas Wunner     2016-06-12  620  {
abb2bafd295fe96 arch/x86/kernel/early-quirks.c    Lukas Wunner     2016-06-12  621  	void __iomem *mmio;
abb2bafd295fe96 arch/x86/kernel/early-quirks.c    Lukas Wunner     2016-06-12  622  	u16 pmcsr;
abb2bafd295fe96 arch/x86/kernel/early-quirks.c    Lukas Wunner     2016-06-12  623  	u64 addr;
abb2bafd295fe96 arch/x86/kernel/early-quirks.c    Lukas Wunner     2016-06-12  624  	int i;
abb2bafd295fe96 arch/x86/kernel/early-quirks.c    Lukas Wunner     2016-06-12  625  
630b3aff8a51c90 arch/x86/kernel/early-quirks.c    Lukas Wunner     2017-08-01  626  	if (!x86_apple_machine)
abb2bafd295fe96 arch/x86/kernel/early-quirks.c    Lukas Wunner     2016-06-12  627  		return;
abb2bafd295fe96 arch/x86/kernel/early-quirks.c    Lukas Wunner     2016-06-12  628  
abb2bafd295fe96 arch/x86/kernel/early-quirks.c    Lukas Wunner     2016-06-12  629  	/* Card may have been put into PCI_D3hot by grub quirk */
abb2bafd295fe96 arch/x86/kernel/early-quirks.c    Lukas Wunner     2016-06-12  630  	pmcsr = read_pci_config_16(bus, slot, func, BCM4331_PM_CAP + PCI_PM_CTRL);
abb2bafd295fe96 arch/x86/kernel/early-quirks.c    Lukas Wunner     2016-06-12  631  
abb2bafd295fe96 arch/x86/kernel/early-quirks.c    Lukas Wunner     2016-06-12  632  	if ((pmcsr & PCI_PM_CTRL_STATE_MASK) != PCI_D0) {
abb2bafd295fe96 arch/x86/kernel/early-quirks.c    Lukas Wunner     2016-06-12  633  		pmcsr &= ~PCI_PM_CTRL_STATE_MASK;
abb2bafd295fe96 arch/x86/kernel/early-quirks.c    Lukas Wunner     2016-06-12  634  		write_pci_config_16(bus, slot, func, BCM4331_PM_CAP + PCI_PM_CTRL, pmcsr);
abb2bafd295fe96 arch/x86/kernel/early-quirks.c    Lukas Wunner     2016-06-12  635  		mdelay(10);
abb2bafd295fe96 arch/x86/kernel/early-quirks.c    Lukas Wunner     2016-06-12  636  
abb2bafd295fe96 arch/x86/kernel/early-quirks.c    Lukas Wunner     2016-06-12  637  		pmcsr = read_pci_config_16(bus, slot, func, BCM4331_PM_CAP + PCI_PM_CTRL);
abb2bafd295fe96 arch/x86/kernel/early-quirks.c    Lukas Wunner     2016-06-12  638  		if ((pmcsr & PCI_PM_CTRL_STATE_MASK) != PCI_D0) {
a7a3153a98d5811 arch/x86/kernel/early-quirks.c    Joe Perches      2018-05-09  639  			pr_err("pci 0000:%02x:%02x.%d: Cannot power up Apple AirPort card\n",
a7a3153a98d5811 arch/x86/kernel/early-quirks.c    Joe Perches      2018-05-09  640  			       bus, slot, func);
abb2bafd295fe96 arch/x86/kernel/early-quirks.c    Lukas Wunner     2016-06-12  641  			return;
abb2bafd295fe96 arch/x86/kernel/early-quirks.c    Lukas Wunner     2016-06-12  642  		}
abb2bafd295fe96 arch/x86/kernel/early-quirks.c    Lukas Wunner     2016-06-12  643  	}
abb2bafd295fe96 arch/x86/kernel/early-quirks.c    Lukas Wunner     2016-06-12  644  
abb2bafd295fe96 arch/x86/kernel/early-quirks.c    Lukas Wunner     2016-06-12  645  	addr  =      read_pci_config(bus, slot, func, PCI_BASE_ADDRESS_0);
abb2bafd295fe96 arch/x86/kernel/early-quirks.c    Lukas Wunner     2016-06-12  646  	addr |= (u64)read_pci_config(bus, slot, func, PCI_BASE_ADDRESS_1) << 32;
abb2bafd295fe96 arch/x86/kernel/early-quirks.c    Lukas Wunner     2016-06-12  647  	addr &= PCI_BASE_ADDRESS_MEM_MASK;
abb2bafd295fe96 arch/x86/kernel/early-quirks.c    Lukas Wunner     2016-06-12  648  
abb2bafd295fe96 arch/x86/kernel/early-quirks.c    Lukas Wunner     2016-06-12  649  	mmio = early_ioremap(addr, BCM4331_MMIO_SIZE);
abb2bafd295fe96 arch/x86/kernel/early-quirks.c    Lukas Wunner     2016-06-12  650  	if (!mmio) {
a7a3153a98d5811 arch/x86/kernel/early-quirks.c    Joe Perches      2018-05-09  651  		pr_err("pci 0000:%02x:%02x.%d: Cannot iomap Apple AirPort card\n",
a7a3153a98d5811 arch/x86/kernel/early-quirks.c    Joe Perches      2018-05-09  652  		       bus, slot, func);
abb2bafd295fe96 arch/x86/kernel/early-quirks.c    Lukas Wunner     2016-06-12  653  		return;
abb2bafd295fe96 arch/x86/kernel/early-quirks.c    Lukas Wunner     2016-06-12  654  	}
abb2bafd295fe96 arch/x86/kernel/early-quirks.c    Lukas Wunner     2016-06-12  655  
abb2bafd295fe96 arch/x86/kernel/early-quirks.c    Lukas Wunner     2016-06-12  656  	pr_info("Resetting Apple AirPort card (left enabled by EFI)\n");
abb2bafd295fe96 arch/x86/kernel/early-quirks.c    Lukas Wunner     2016-06-12  657  
abb2bafd295fe96 arch/x86/kernel/early-quirks.c    Lukas Wunner     2016-06-12  658  	for (i = 0; bcma_aread32(BCMA_RESET_ST) && i < 30; i++)
abb2bafd295fe96 arch/x86/kernel/early-quirks.c    Lukas Wunner     2016-06-12  659  		udelay(10);
abb2bafd295fe96 arch/x86/kernel/early-quirks.c    Lukas Wunner     2016-06-12  660  
abb2bafd295fe96 arch/x86/kernel/early-quirks.c    Lukas Wunner     2016-06-12  661  	bcma_awrite32(BCMA_RESET_CTL, BCMA_RESET_CTL_RESET);
abb2bafd295fe96 arch/x86/kernel/early-quirks.c    Lukas Wunner     2016-06-12  662  	bcma_aread32(BCMA_RESET_CTL);
abb2bafd295fe96 arch/x86/kernel/early-quirks.c    Lukas Wunner     2016-06-12  663  	udelay(1);
abb2bafd295fe96 arch/x86/kernel/early-quirks.c    Lukas Wunner     2016-06-12  664  
abb2bafd295fe96 arch/x86/kernel/early-quirks.c    Lukas Wunner     2016-06-12  665  	bcma_awrite32(BCMA_RESET_CTL, 0);
abb2bafd295fe96 arch/x86/kernel/early-quirks.c    Lukas Wunner     2016-06-12  666  	bcma_aread32(BCMA_RESET_CTL);
abb2bafd295fe96 arch/x86/kernel/early-quirks.c    Lukas Wunner     2016-06-12  667  	udelay(10);
abb2bafd295fe96 arch/x86/kernel/early-quirks.c    Lukas Wunner     2016-06-12  668  
abb2bafd295fe96 arch/x86/kernel/early-quirks.c    Lukas Wunner     2016-06-12  669  	early_iounmap(mmio, BCM4331_MMIO_SIZE);
abb2bafd295fe96 arch/x86/kernel/early-quirks.c    Lukas Wunner     2016-06-12  670  }
62187910b0fc7a7 arch/x86/kernel/early-quirks.c    Feng Tang        2014-04-24  671  
c6b48324325ffb6 arch/x86/kernel/early-quirks.c    Neil Horman      2008-01-30  672  #define QFLAG_APPLY_ONCE 	0x1
c6b48324325ffb6 arch/x86/kernel/early-quirks.c    Neil Horman      2008-01-30  673  #define QFLAG_APPLIED		0x2
c6b48324325ffb6 arch/x86/kernel/early-quirks.c    Neil Horman      2008-01-30  674  #define QFLAG_DONE		(QFLAG_APPLY_ONCE|QFLAG_APPLIED)
dfa4698c50bf85b arch/x86_64/kernel/early-quirks.c Andi Kleen       2006-09-26  675  struct chipset {
c6b48324325ffb6 arch/x86/kernel/early-quirks.c    Neil Horman      2008-01-30  676  	u32 vendor;
c6b48324325ffb6 arch/x86/kernel/early-quirks.c    Neil Horman      2008-01-30  677  	u32 device;
c6b48324325ffb6 arch/x86/kernel/early-quirks.c    Neil Horman      2008-01-30  678  	u32 class;
c6b48324325ffb6 arch/x86/kernel/early-quirks.c    Neil Horman      2008-01-30  679  	u32 class_mask;
c6b48324325ffb6 arch/x86/kernel/early-quirks.c    Neil Horman      2008-01-30  680  	u32 flags;
c6b48324325ffb6 arch/x86/kernel/early-quirks.c    Neil Horman      2008-01-30  681  	void (*f)(int num, int slot, int func);
dfa4698c50bf85b arch/x86_64/kernel/early-quirks.c Andi Kleen       2006-09-26  682  };
dfa4698c50bf85b arch/x86_64/kernel/early-quirks.c Andi Kleen       2006-09-26  683  
c993c7355df5528 arch/x86_64/kernel/early-quirks.c Andrew Morton    2007-04-08  684  static struct chipset early_qrk[] __initdata = {
c6b48324325ffb6 arch/x86/kernel/early-quirks.c    Neil Horman      2008-01-30  685  	{ PCI_VENDOR_ID_NVIDIA, PCI_ANY_ID,
c6b48324325ffb6 arch/x86/kernel/early-quirks.c    Neil Horman      2008-01-30  686  	  PCI_CLASS_BRIDGE_PCI, PCI_ANY_ID, QFLAG_APPLY_ONCE, nvidia_bugs },
c6b48324325ffb6 arch/x86/kernel/early-quirks.c    Neil Horman      2008-01-30  687  	{ PCI_VENDOR_ID_VIA, PCI_ANY_ID,
c6b48324325ffb6 arch/x86/kernel/early-quirks.c    Neil Horman      2008-01-30  688  	  PCI_CLASS_BRIDGE_PCI, PCI_ANY_ID, QFLAG_APPLY_ONCE, via_bugs },
c6b48324325ffb6 arch/x86/kernel/early-quirks.c    Neil Horman      2008-01-30  689  	{ PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_K8_NB,
c6b48324325ffb6 arch/x86/kernel/early-quirks.c    Neil Horman      2008-01-30  690  	  PCI_CLASS_BRIDGE_HOST, PCI_ANY_ID, 0, fix_hypertransport_config },
33fb0e4eb53f16a arch/x86/kernel/early-quirks.c    Andreas Herrmann 2008-10-07  691  	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_IXP400_SMBUS,
33fb0e4eb53f16a arch/x86/kernel/early-quirks.c    Andreas Herrmann 2008-10-07  692  	  PCI_CLASS_SERIAL_SMBUS, PCI_ANY_ID, 0, ati_bugs },
26adcfbf00e0726 arch/x86/kernel/early-quirks.c    Andreas Herrmann 2008-10-14  693  	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_SBX00_SMBUS,
26adcfbf00e0726 arch/x86/kernel/early-quirks.c    Andreas Herrmann 2008-10-14  694  	  PCI_CLASS_SERIAL_SMBUS, PCI_ANY_ID, 0, ati_bugs_contd },
03bbcb2e7e29283 arch/x86/kernel/early-quirks.c    Neil Horman      2013-04-16  695  	{ PCI_VENDOR_ID_INTEL, 0x3403, PCI_CLASS_BRIDGE_HOST,
03bbcb2e7e29283 arch/x86/kernel/early-quirks.c    Neil Horman      2013-04-16  696  	  PCI_BASE_CLASS_BRIDGE, 0, intel_remapping_check },
803075dba31c17a arch/x86/kernel/early-quirks.c    Neil Horman      2013-07-17  697  	{ PCI_VENDOR_ID_INTEL, 0x3405, PCI_CLASS_BRIDGE_HOST,
803075dba31c17a arch/x86/kernel/early-quirks.c    Neil Horman      2013-07-17  698  	  PCI_BASE_CLASS_BRIDGE, 0, intel_remapping_check },
03bbcb2e7e29283 arch/x86/kernel/early-quirks.c    Neil Horman      2013-04-16  699  	{ PCI_VENDOR_ID_INTEL, 0x3406, PCI_CLASS_BRIDGE_HOST,
03bbcb2e7e29283 arch/x86/kernel/early-quirks.c    Neil Horman      2013-04-16  700  	  PCI_BASE_CLASS_BRIDGE, 0, intel_remapping_check },
814c5f1f52a4beb arch/x86/kernel/early-quirks.c    Jesse Barnes     2013-07-26  701  	{ PCI_VENDOR_ID_INTEL, PCI_ANY_ID, PCI_CLASS_DISPLAY_VGA, PCI_ANY_ID,
ee0629cfd3c16c7 arch/x86/kernel/early-quirks.c    Joonas Lahtinen  2016-04-22  702  	  QFLAG_APPLY_ONCE, intel_graphics_quirks },
62187910b0fc7a7 arch/x86/kernel/early-quirks.c    Feng Tang        2014-04-24  703  	/*
b58d930750135d6 arch/x86/kernel/early-quirks.c    Feng Tang        2015-06-15  704  	 * HPET on the current version of the Baytrail platform has accuracy
b58d930750135d6 arch/x86/kernel/early-quirks.c    Feng Tang        2015-06-15  705  	 * problems: it will halt in deep idle state - so we disable it.
b58d930750135d6 arch/x86/kernel/early-quirks.c    Feng Tang        2015-06-15  706  	 *
b58d930750135d6 arch/x86/kernel/early-quirks.c    Feng Tang        2015-06-15  707  	 * More details can be found in section 18.10.1.3 of the datasheet:
b58d930750135d6 arch/x86/kernel/early-quirks.c    Feng Tang        2015-06-15  708  	 *
b58d930750135d6 arch/x86/kernel/early-quirks.c    Feng Tang        2015-06-15  709  	 *    http://www.intel.com/content/dam/www/public/us/en/documents/datasheets/atom-z8000-datasheet-vol-1.pdf
62187910b0fc7a7 arch/x86/kernel/early-quirks.c    Feng Tang        2014-04-24  710  	 */
62187910b0fc7a7 arch/x86/kernel/early-quirks.c    Feng Tang        2014-04-24  711  	{ PCI_VENDOR_ID_INTEL, 0x0f00,
62187910b0fc7a7 arch/x86/kernel/early-quirks.c    Feng Tang        2014-04-24  712  		PCI_CLASS_BRIDGE_HOST, PCI_ANY_ID, 0, force_disable_hpet},
abb2bafd295fe96 arch/x86/kernel/early-quirks.c    Lukas Wunner     2016-06-12  713  	{ PCI_VENDOR_ID_BROADCOM, 0x4331,
abb2bafd295fe96 arch/x86/kernel/early-quirks.c    Lukas Wunner     2016-06-12  714  	  PCI_CLASS_NETWORK_OTHER, PCI_ANY_ID, 0, apple_airport_reset},
dfa4698c50bf85b arch/x86_64/kernel/early-quirks.c Andi Kleen       2006-09-26  715  	{}
dfa4698c50bf85b arch/x86_64/kernel/early-quirks.c Andi Kleen       2006-09-26  716  };
dfa4698c50bf85b arch/x86_64/kernel/early-quirks.c Andi Kleen       2006-09-26  717  
850c321027c2e31 arch/x86/kernel/early-quirks.c    Lukas Wunner     2016-06-12  718  static void __init early_pci_scan_bus(int bus);
850c321027c2e31 arch/x86/kernel/early-quirks.c    Lukas Wunner     2016-06-12  719  
15650a2f644a2f1 arch/x86/kernel/early-quirks.c    Jesse Barnes     2008-06-16  720  /**
15650a2f644a2f1 arch/x86/kernel/early-quirks.c    Jesse Barnes     2008-06-16  721   * check_dev_quirk - apply early quirks to a given PCI device
15650a2f644a2f1 arch/x86/kernel/early-quirks.c    Jesse Barnes     2008-06-16  722   * @num: bus number
15650a2f644a2f1 arch/x86/kernel/early-quirks.c    Jesse Barnes     2008-06-16  723   * @slot: slot number
15650a2f644a2f1 arch/x86/kernel/early-quirks.c    Jesse Barnes     2008-06-16  724   * @func: PCI function
15650a2f644a2f1 arch/x86/kernel/early-quirks.c    Jesse Barnes     2008-06-16  725   *
15650a2f644a2f1 arch/x86/kernel/early-quirks.c    Jesse Barnes     2008-06-16  726   * Check the vendor & device ID against the early quirks table.
15650a2f644a2f1 arch/x86/kernel/early-quirks.c    Jesse Barnes     2008-06-16  727   *
850c321027c2e31 arch/x86/kernel/early-quirks.c    Lukas Wunner     2016-06-12  728   * If the device is single function, let early_pci_scan_bus() know so we don't
15650a2f644a2f1 arch/x86/kernel/early-quirks.c    Jesse Barnes     2008-06-16  729   * poke at this device again.
15650a2f644a2f1 arch/x86/kernel/early-quirks.c    Jesse Barnes     2008-06-16  730   */
15650a2f644a2f1 arch/x86/kernel/early-quirks.c    Jesse Barnes     2008-06-16  731  static int __init check_dev_quirk(int num, int slot, int func)
dfa4698c50bf85b arch/x86_64/kernel/early-quirks.c Andi Kleen       2006-09-26  732  {
c6b48324325ffb6 arch/x86/kernel/early-quirks.c    Neil Horman      2008-01-30  733  	u16 class;
c6b48324325ffb6 arch/x86/kernel/early-quirks.c    Neil Horman      2008-01-30  734  	u16 vendor;
c6b48324325ffb6 arch/x86/kernel/early-quirks.c    Neil Horman      2008-01-30  735  	u16 device;
dfa4698c50bf85b arch/x86_64/kernel/early-quirks.c Andi Kleen       2006-09-26  736  	u8 type;
850c321027c2e31 arch/x86/kernel/early-quirks.c    Lukas Wunner     2016-06-12  737  	u8 sec;
dfa4698c50bf85b arch/x86_64/kernel/early-quirks.c Andi Kleen       2006-09-26  738  	int i;
c6b48324325ffb6 arch/x86/kernel/early-quirks.c    Neil Horman      2008-01-30  739  
7bcbc78dea92fdf arch/x86/kernel/early-quirks.c    Neil Horman      2008-01-30  740  	class = read_pci_config_16(num, slot, func, PCI_CLASS_DEVICE);
7bcbc78dea92fdf arch/x86/kernel/early-quirks.c    Neil Horman      2008-01-30  741  
c6b48324325ffb6 arch/x86/kernel/early-quirks.c    Neil Horman      2008-01-30  742  	if (class == 0xffff)
15650a2f644a2f1 arch/x86/kernel/early-quirks.c    Jesse Barnes     2008-06-16  743  		return -1; /* no class, treat as single function */
dfa4698c50bf85b arch/x86_64/kernel/early-quirks.c Andi Kleen       2006-09-26  744  
7bcbc78dea92fdf arch/x86/kernel/early-quirks.c    Neil Horman      2008-01-30  745  	vendor = read_pci_config_16(num, slot, func, PCI_VENDOR_ID);
dfa4698c50bf85b arch/x86_64/kernel/early-quirks.c Andi Kleen       2006-09-26  746  
7bcbc78dea92fdf arch/x86/kernel/early-quirks.c    Neil Horman      2008-01-30  747  	device = read_pci_config_16(num, slot, func, PCI_DEVICE_ID);
c6b48324325ffb6 arch/x86/kernel/early-quirks.c    Neil Horman      2008-01-30  748  
c6b48324325ffb6 arch/x86/kernel/early-quirks.c    Neil Horman      2008-01-30  749  	for (i = 0; early_qrk[i].f != NULL; i++) {
c6b48324325ffb6 arch/x86/kernel/early-quirks.c    Neil Horman      2008-01-30  750  		if (((early_qrk[i].vendor == PCI_ANY_ID) ||
c6b48324325ffb6 arch/x86/kernel/early-quirks.c    Neil Horman      2008-01-30  751  			(early_qrk[i].vendor == vendor)) &&
c6b48324325ffb6 arch/x86/kernel/early-quirks.c    Neil Horman      2008-01-30  752  			((early_qrk[i].device == PCI_ANY_ID) ||
c6b48324325ffb6 arch/x86/kernel/early-quirks.c    Neil Horman      2008-01-30  753  			(early_qrk[i].device == device)) &&
c6b48324325ffb6 arch/x86/kernel/early-quirks.c    Neil Horman      2008-01-30  754  			(!((early_qrk[i].class ^ class) &
c6b48324325ffb6 arch/x86/kernel/early-quirks.c    Neil Horman      2008-01-30  755  			    early_qrk[i].class_mask))) {
7bcbc78dea92fdf arch/x86/kernel/early-quirks.c    Neil Horman      2008-01-30  756  				if ((early_qrk[i].flags &
7bcbc78dea92fdf arch/x86/kernel/early-quirks.c    Neil Horman      2008-01-30  757  				     QFLAG_DONE) != QFLAG_DONE)
c6b48324325ffb6 arch/x86/kernel/early-quirks.c    Neil Horman      2008-01-30  758  					early_qrk[i].f(num, slot, func);
c6b48324325ffb6 arch/x86/kernel/early-quirks.c    Neil Horman      2008-01-30  759  				early_qrk[i].flags |= QFLAG_APPLIED;
c6b48324325ffb6 arch/x86/kernel/early-quirks.c    Neil Horman      2008-01-30  760  			}
dfa4698c50bf85b arch/x86_64/kernel/early-quirks.c Andi Kleen       2006-09-26  761  	}
dfa4698c50bf85b arch/x86_64/kernel/early-quirks.c Andi Kleen       2006-09-26  762  
dfa4698c50bf85b arch/x86_64/kernel/early-quirks.c Andi Kleen       2006-09-26  763  	type = read_pci_config_byte(num, slot, func,
dfa4698c50bf85b arch/x86_64/kernel/early-quirks.c Andi Kleen       2006-09-26  764  				    PCI_HEADER_TYPE);
850c321027c2e31 arch/x86/kernel/early-quirks.c    Lukas Wunner     2016-06-12  765  
850c321027c2e31 arch/x86/kernel/early-quirks.c    Lukas Wunner     2016-06-12  766  	if ((type & 0x7f) == PCI_HEADER_TYPE_BRIDGE) {
850c321027c2e31 arch/x86/kernel/early-quirks.c    Lukas Wunner     2016-06-12  767  		sec = read_pci_config_byte(num, slot, func, PCI_SECONDARY_BUS);
850c321027c2e31 arch/x86/kernel/early-quirks.c    Lukas Wunner     2016-06-12  768  		if (sec > num)
850c321027c2e31 arch/x86/kernel/early-quirks.c    Lukas Wunner     2016-06-12  769  			early_pci_scan_bus(sec);
850c321027c2e31 arch/x86/kernel/early-quirks.c    Lukas Wunner     2016-06-12  770  	}
850c321027c2e31 arch/x86/kernel/early-quirks.c    Lukas Wunner     2016-06-12  771  
dfa4698c50bf85b arch/x86_64/kernel/early-quirks.c Andi Kleen       2006-09-26  772  	if (!(type & 0x80))
15650a2f644a2f1 arch/x86/kernel/early-quirks.c    Jesse Barnes     2008-06-16  773  		return -1;
15650a2f644a2f1 arch/x86/kernel/early-quirks.c    Jesse Barnes     2008-06-16  774  
15650a2f644a2f1 arch/x86/kernel/early-quirks.c    Jesse Barnes     2008-06-16  775  	return 0;
dfa4698c50bf85b arch/x86_64/kernel/early-quirks.c Andi Kleen       2006-09-26  776  }
7bcbc78dea92fdf arch/x86/kernel/early-quirks.c    Neil Horman      2008-01-30  777  
850c321027c2e31 arch/x86/kernel/early-quirks.c    Lukas Wunner     2016-06-12  778  static void __init early_pci_scan_bus(int bus)
7bcbc78dea92fdf arch/x86/kernel/early-quirks.c    Neil Horman      2008-01-30  779  {
8659c406ade32f4 arch/x86/kernel/early-quirks.c    Andi Kleen       2009-01-09  780  	int slot, func;
7bcbc78dea92fdf arch/x86/kernel/early-quirks.c    Neil Horman      2008-01-30  781  
7bcbc78dea92fdf arch/x86/kernel/early-quirks.c    Neil Horman      2008-01-30  782  	/* Poor man's PCI discovery */
7bcbc78dea92fdf arch/x86/kernel/early-quirks.c    Neil Horman      2008-01-30  783  	for (slot = 0; slot < 32; slot++)
15650a2f644a2f1 arch/x86/kernel/early-quirks.c    Jesse Barnes     2008-06-16  784  		for (func = 0; func < 8; func++) {
15650a2f644a2f1 arch/x86/kernel/early-quirks.c    Jesse Barnes     2008-06-16  785  			/* Only probe function 0 on single fn devices */
850c321027c2e31 arch/x86/kernel/early-quirks.c    Lukas Wunner     2016-06-12  786  			if (check_dev_quirk(bus, slot, func))
15650a2f644a2f1 arch/x86/kernel/early-quirks.c    Jesse Barnes     2008-06-16  787  				break;
15650a2f644a2f1 arch/x86/kernel/early-quirks.c    Jesse Barnes     2008-06-16  788  		}
dfa4698c50bf85b arch/x86_64/kernel/early-quirks.c Andi Kleen       2006-09-26  789  }
850c321027c2e31 arch/x86/kernel/early-quirks.c    Lukas Wunner     2016-06-12  790  
850c321027c2e31 arch/x86/kernel/early-quirks.c    Lukas Wunner     2016-06-12  791  void __init early_quirks(void)
850c321027c2e31 arch/x86/kernel/early-quirks.c    Lukas Wunner     2016-06-12  792  {
850c321027c2e31 arch/x86/kernel/early-quirks.c    Lukas Wunner     2016-06-12  793  	if (!early_pci_allowed())
850c321027c2e31 arch/x86/kernel/early-quirks.c    Lukas Wunner     2016-06-12  794  		return;
850c321027c2e31 arch/x86/kernel/early-quirks.c    Lukas Wunner     2016-06-12  795  
850c321027c2e31 arch/x86/kernel/early-quirks.c    Lukas Wunner     2016-06-12  796  	early_pci_scan_bus(0);
850c321027c2e31 arch/x86/kernel/early-quirks.c    Lukas Wunner     2016-06-12  797  }

:::::: The code at line 518 was first introduced by commit
:::::: ee0629cfd3c16c716801c84e939ff5db5e23f54d drm/i915: Function per early graphics quirk

:::::: TO: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
:::::: CC: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--kc3xsxctshrul645
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
unKVYYxOj5rFddVTSsT/A2zXQlUW1gEA

--kc3xsxctshrul645--
