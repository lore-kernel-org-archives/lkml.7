Return-Path: <SRS0=vU+5=XP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93C3FC49ED7
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 04:35:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E9542073F
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 04:35:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392215AbfITEf1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Sep 2019 00:35:27 -0400
Received: from mga11.intel.com ([192.55.52.93]:33057 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392019AbfITEf0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 00:35:26 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Sep 2019 21:34:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,527,1559545200"; 
   d="gz'50?scan'50,208,50";a="189825676"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 19 Sep 2019 21:34:48 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1iBAd6-000Byb-Am; Fri, 20 Sep 2019 12:34:48 +0800
Date:   Fri, 20 Sep 2019 12:34:09 +0800
From:   kbuild test robot <lkp@intel.com>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     kbuild-all@01.org, linux-kernel@vger.kernel.org
Subject: arch/mips/include/asm/octeon/cvmx-ipd.h:330:27: error: storage size
 of 'pip_sft_rst' isn't known
Message-ID: <201909201204.ZFCT2x0U%lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="iryjel3p6zy6grqp"
Content-Disposition: inline
X-Patchwork-Hint: ignore
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--iryjel3p6zy6grqp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Matthew,

FYI, the error/warning still remains.

tree:   https://kernel.googlesource.com/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   574cc4539762561d96b456dbc0544d8898bd4c6e
commit: 171a9bae68c72f2d1260c3825203760856e6793b staging/octeon: Allow test build on !MIPS
date:   7 weeks ago
config: mips-allmodconfig (attached as .config)
compiler: mips-linux-gcc (GCC) 7.4.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout 171a9bae68c72f2d1260c3825203760856e6793b
        # save the attached .config to linux build tree
        GCC_VERSION=7.4.0 make.cross ARCH=mips 

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from arch/mips/include/asm/octeon/octeon.h:11:0,
                    from drivers/staging/octeon/octeon-ethernet.h:19,
                    from drivers/staging/octeon/ethernet-sgmii.c:14:
   arch/mips/include/asm/octeon/cvmx.h: In function 'cvmx_writeq_csr':
   arch/mips/include/asm/octeon/cvmx.h:282:17: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
     cvmx_write_csr((__force uint64_t)csr_addr, val);
                    ^
   arch/mips/include/asm/octeon/cvmx.h: In function 'cvmx_readq_csr':
   arch/mips/include/asm/octeon/cvmx.h:299:23: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
     return cvmx_read_csr((__force uint64_t) csr_addr);
                          ^
   In file included from drivers/staging/octeon/octeon-ethernet.h:27:0,
                    from drivers/staging/octeon/ethernet-sgmii.c:14:
   arch/mips/include/asm/octeon/cvmx-ipd.h: In function 'cvmx_ipd_free_ptr':
>> arch/mips/include/asm/octeon/cvmx-ipd.h:330:27: error: storage size of 'pip_sft_rst' isn't known
       union cvmx_pip_sft_rst pip_sft_rst;
                              ^~~~~~~~~~~
>> arch/mips/include/asm/octeon/cvmx-ipd.h:331:36: error: 'CVMX_PIP_SFT_RST' undeclared (first use in this function); did you mean 'CVMX_CIU_SOFT_RST'?
       pip_sft_rst.u64 = cvmx_read_csr(CVMX_PIP_SFT_RST);
                                       ^~~~~~~~~~~~~~~~
                                       CVMX_CIU_SOFT_RST
   arch/mips/include/asm/octeon/cvmx-ipd.h:331:36: note: each undeclared identifier is reported only once for each function it appears in
   arch/mips/include/asm/octeon/cvmx-ipd.h:330:27: warning: unused variable 'pip_sft_rst' [-Wunused-variable]
       union cvmx_pip_sft_rst pip_sft_rst;
                              ^~~~~~~~~~~
--
   In file included from arch/mips/include/asm/octeon/octeon.h:11:0,
                    from drivers/staging/octeon/octeon-ethernet.h:19,
                    from drivers/staging/octeon/ethernet-spi.c:13:
   arch/mips/include/asm/octeon/cvmx.h: In function 'cvmx_writeq_csr':
   arch/mips/include/asm/octeon/cvmx.h:282:17: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
     cvmx_write_csr((__force uint64_t)csr_addr, val);
                    ^
   arch/mips/include/asm/octeon/cvmx.h: In function 'cvmx_readq_csr':
   arch/mips/include/asm/octeon/cvmx.h:299:23: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
     return cvmx_read_csr((__force uint64_t) csr_addr);
                          ^
   In file included from drivers/staging/octeon/octeon-ethernet.h:27:0,
                    from drivers/staging/octeon/ethernet-spi.c:13:
   arch/mips/include/asm/octeon/cvmx-ipd.h: In function 'cvmx_ipd_free_ptr':
>> arch/mips/include/asm/octeon/cvmx-ipd.h:330:27: error: storage size of 'pip_sft_rst' isn't known
       union cvmx_pip_sft_rst pip_sft_rst;
                              ^~~~~~~~~~~
>> arch/mips/include/asm/octeon/cvmx-ipd.h:331:36: error: 'CVMX_PIP_SFT_RST' undeclared (first use in this function); did you mean 'CVMX_CIU_SOFT_RST'?
       pip_sft_rst.u64 = cvmx_read_csr(CVMX_PIP_SFT_RST);
                                       ^~~~~~~~~~~~~~~~
                                       CVMX_CIU_SOFT_RST
   arch/mips/include/asm/octeon/cvmx-ipd.h:331:36: note: each undeclared identifier is reported only once for each function it appears in
   arch/mips/include/asm/octeon/cvmx-ipd.h:330:27: warning: unused variable 'pip_sft_rst' [-Wunused-variable]
       union cvmx_pip_sft_rst pip_sft_rst;
                              ^~~~~~~~~~~
   drivers/staging/octeon/ethernet-spi.c: In function 'cvm_oct_spi_init':
>> drivers/staging/octeon/ethernet-spi.c:198:19: error: 'OCTEON_IRQ_RML' undeclared (first use in this function); did you mean 'OCTEON_IS_MODEL'?
      r = request_irq(OCTEON_IRQ_RML, cvm_oct_spi_rml_interrupt,
                      ^~~~~~~~~~~~~~
                      OCTEON_IS_MODEL
   drivers/staging/octeon/ethernet-spi.c: In function 'cvm_oct_spi_uninit':
   drivers/staging/octeon/ethernet-spi.c:224:12: error: 'OCTEON_IRQ_RML' undeclared (first use in this function); did you mean 'OCTEON_IS_MODEL'?
      free_irq(OCTEON_IRQ_RML, &number_spi_ports);
               ^~~~~~~~~~~~~~
               OCTEON_IS_MODEL
--
   In file included from arch/mips/include/asm/octeon/octeon.h:11:0,
                    from drivers/staging/octeon/octeon-ethernet.h:19,
                    from drivers/staging/octeon/ethernet-tx.c:25:
   arch/mips/include/asm/octeon/cvmx.h: In function 'cvmx_writeq_csr':
   arch/mips/include/asm/octeon/cvmx.h:282:17: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
     cvmx_write_csr((__force uint64_t)csr_addr, val);
                    ^
   arch/mips/include/asm/octeon/cvmx.h: In function 'cvmx_readq_csr':
   arch/mips/include/asm/octeon/cvmx.h:299:23: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
     return cvmx_read_csr((__force uint64_t) csr_addr);
                          ^
   In file included from drivers/staging/octeon/octeon-ethernet.h:27:0,
                    from drivers/staging/octeon/ethernet-tx.c:25:
   arch/mips/include/asm/octeon/cvmx-ipd.h: In function 'cvmx_ipd_free_ptr':
>> arch/mips/include/asm/octeon/cvmx-ipd.h:330:27: error: storage size of 'pip_sft_rst' isn't known
       union cvmx_pip_sft_rst pip_sft_rst;
                              ^~~~~~~~~~~
>> arch/mips/include/asm/octeon/cvmx-ipd.h:331:36: error: 'CVMX_PIP_SFT_RST' undeclared (first use in this function); did you mean 'CVMX_CIU_SOFT_RST'?
       pip_sft_rst.u64 = cvmx_read_csr(CVMX_PIP_SFT_RST);
                                       ^~~~~~~~~~~~~~~~
                                       CVMX_CIU_SOFT_RST
   arch/mips/include/asm/octeon/cvmx-ipd.h:331:36: note: each undeclared identifier is reported only once for each function it appears in
   arch/mips/include/asm/octeon/cvmx-ipd.h:330:27: warning: unused variable 'pip_sft_rst' [-Wunused-variable]
       union cvmx_pip_sft_rst pip_sft_rst;
                              ^~~~~~~~~~~
   In file included from drivers/staging/octeon/ethernet-tx.c:26:0:
   drivers/staging/octeon/ethernet-tx.c: In function 'cvm_oct_xmit':
>> drivers/staging/octeon/ethernet-defines.h:30:38: error: 'CONFIG_CAVIUM_OCTEON_CVMSEG_SIZE' undeclared (first use in this function); did you mean 'CONFIG_MDIO_OCTEON_MODULE'?
    #define USE_ASYNC_IOBDMA            (CONFIG_CAVIUM_OCTEON_CVMSEG_SIZE > 0)
                                         ^
   drivers/staging/octeon/ethernet-tx.c:169:6: note: in expansion of macro 'USE_ASYNC_IOBDMA'
     if (USE_ASYNC_IOBDMA) {
         ^~~~~~~~~~~~~~~~
   In file included from arch/mips/include/asm/barrier.h:11:0,
                    from include/linux/compiler.h:256,
                    from include/linux/kernel.h:11,
                    from include/linux/list.h:9,
                    from include/linux/module.h:9,
                    from drivers/staging/octeon/ethernet-tx.c:8:
   drivers/staging/octeon/ethernet-tx.c:264:37: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
      hw_buffer.s.addr = XKPHYS_TO_PHYS((u64)skb->data);
                                        ^
   arch/mips/include/asm/addrspace.h:128:30: note: in definition of macro 'XKPHYS_TO_PHYS'
    #define XKPHYS_TO_PHYS(p)  ((p) & TO_PHYS_MASK)
                                 ^
   drivers/staging/octeon/ethernet-tx.c:268:37: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
      hw_buffer.s.addr = XKPHYS_TO_PHYS((u64)skb->data);
                                        ^
   arch/mips/include/asm/addrspace.h:128:30: note: in definition of macro 'XKPHYS_TO_PHYS'
    #define XKPHYS_TO_PHYS(p)  ((p) & TO_PHYS_MASK)
                                 ^
   drivers/staging/octeon/ethernet-tx.c:276:20: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
        XKPHYS_TO_PHYS((u64)skb_frag_address(fs));
                       ^
   arch/mips/include/asm/addrspace.h:128:30: note: in definition of macro 'XKPHYS_TO_PHYS'
    #define XKPHYS_TO_PHYS(p)  ((p) & TO_PHYS_MASK)
                                 ^
   drivers/staging/octeon/ethernet-tx.c:280:37: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
      hw_buffer.s.addr = XKPHYS_TO_PHYS((u64)CVM_OCT_SKB_CB(skb));
                                        ^
   arch/mips/include/asm/addrspace.h:128:30: note: in definition of macro 'XKPHYS_TO_PHYS'
    #define XKPHYS_TO_PHYS(p)  ((p) & TO_PHYS_MASK)
                                 ^
   drivers/staging/octeon/ethernet-tx.c: In function 'cvm_oct_tx_initialize':
>> drivers/staging/octeon/ethernet-tx.c:706:18: error: 'OCTEON_IRQ_TIMER1' undeclared (first use in this function); did you mean 'OCTEON_IS_MODEL'?
     i = request_irq(OCTEON_IRQ_TIMER1,
                     ^~~~~~~~~~~~~~~~~
                     OCTEON_IS_MODEL
   drivers/staging/octeon/ethernet-tx.c: In function 'cvm_oct_tx_shutdown':
   drivers/staging/octeon/ethernet-tx.c:717:11: error: 'OCTEON_IRQ_TIMER1' undeclared (first use in this function); did you mean 'OCTEON_IS_MODEL'?
     free_irq(OCTEON_IRQ_TIMER1, cvm_oct_device);
              ^~~~~~~~~~~~~~~~~
              OCTEON_IS_MODEL
--
   In file included from arch/mips/include/asm/octeon/octeon.h:11:0,
                    from drivers/staging/octeon/octeon-ethernet.h:19,
                    from drivers/staging/octeon/ethernet-rx.c:26:
   arch/mips/include/asm/octeon/cvmx.h: In function 'cvmx_writeq_csr':
   arch/mips/include/asm/octeon/cvmx.h:282:17: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
     cvmx_write_csr((__force uint64_t)csr_addr, val);
                    ^
   arch/mips/include/asm/octeon/cvmx.h: In function 'cvmx_readq_csr':
   arch/mips/include/asm/octeon/cvmx.h:299:23: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
     return cvmx_read_csr((__force uint64_t) csr_addr);
                          ^
   In file included from drivers/staging/octeon/octeon-ethernet.h:27:0,
                    from drivers/staging/octeon/ethernet-rx.c:26:
   arch/mips/include/asm/octeon/cvmx-ipd.h: In function 'cvmx_ipd_free_ptr':
>> arch/mips/include/asm/octeon/cvmx-ipd.h:330:27: error: storage size of 'pip_sft_rst' isn't known
       union cvmx_pip_sft_rst pip_sft_rst;
                              ^~~~~~~~~~~
>> arch/mips/include/asm/octeon/cvmx-ipd.h:331:36: error: 'CVMX_PIP_SFT_RST' undeclared (first use in this function); did you mean 'CVMX_CIU_SOFT_RST'?
       pip_sft_rst.u64 = cvmx_read_csr(CVMX_PIP_SFT_RST);
                                       ^~~~~~~~~~~~~~~~
                                       CVMX_CIU_SOFT_RST
   arch/mips/include/asm/octeon/cvmx-ipd.h:331:36: note: each undeclared identifier is reported only once for each function it appears in
   arch/mips/include/asm/octeon/cvmx-ipd.h:330:27: warning: unused variable 'pip_sft_rst' [-Wunused-variable]
       union cvmx_pip_sft_rst pip_sft_rst;
                              ^~~~~~~~~~~
   In file included from drivers/staging/octeon/ethernet-rx.c:27:0:
   drivers/staging/octeon/ethernet-rx.c: In function 'cvm_oct_poll':
>> drivers/staging/octeon/ethernet-defines.h:30:38: error: 'CONFIG_CAVIUM_OCTEON_CVMSEG_SIZE' undeclared (first use in this function); did you mean 'CONFIG_MDIO_OCTEON_MODULE'?
    #define USE_ASYNC_IOBDMA            (CONFIG_CAVIUM_OCTEON_CVMSEG_SIZE > 0)
                                         ^
   drivers/staging/octeon/ethernet-rx.c:190:6: note: in expansion of macro 'USE_ASYNC_IOBDMA'
     if (USE_ASYNC_IOBDMA) {
         ^~~~~~~~~~~~~~~~
   drivers/staging/octeon/ethernet-rx.c: In function 'cvm_oct_rx_initialize':
>> drivers/staging/octeon/ethernet-rx.c:472:25: error: 'OCTEON_IRQ_WORKQ0' undeclared (first use in this function); did you mean 'OCTEON_IS_MODEL'?
      oct_rx_group[i].irq = OCTEON_IRQ_WORKQ0 + i;
                            ^~~~~~~~~~~~~~~~~
                            OCTEON_IS_MODEL

vim +330 arch/mips/include/asm/octeon/cvmx-ipd.h

80ff0fd3ab6451 drivers/staging/octeon/cvmx-ipd.h David Daney 2009-05-05  154  
80ff0fd3ab6451 drivers/staging/octeon/cvmx-ipd.h David Daney 2009-05-05  155  /**
80ff0fd3ab6451 drivers/staging/octeon/cvmx-ipd.h David Daney 2009-05-05  156   * Supportive function for cvmx_fpa_shutdown_pool.
80ff0fd3ab6451 drivers/staging/octeon/cvmx-ipd.h David Daney 2009-05-05  157   */
80ff0fd3ab6451 drivers/staging/octeon/cvmx-ipd.h David Daney 2009-05-05  158  static inline void cvmx_ipd_free_ptr(void)
80ff0fd3ab6451 drivers/staging/octeon/cvmx-ipd.h David Daney 2009-05-05  159  {
80ff0fd3ab6451 drivers/staging/octeon/cvmx-ipd.h David Daney 2009-05-05  160  	/* Only CN38XXp{1,2} cannot read pointer out of the IPD */
80ff0fd3ab6451 drivers/staging/octeon/cvmx-ipd.h David Daney 2009-05-05  161  	if (!OCTEON_IS_MODEL(OCTEON_CN38XX_PASS1)
80ff0fd3ab6451 drivers/staging/octeon/cvmx-ipd.h David Daney 2009-05-05  162  	    && !OCTEON_IS_MODEL(OCTEON_CN38XX_PASS2)) {
80ff0fd3ab6451 drivers/staging/octeon/cvmx-ipd.h David Daney 2009-05-05  163  		int no_wptr = 0;
80ff0fd3ab6451 drivers/staging/octeon/cvmx-ipd.h David Daney 2009-05-05  164  		union cvmx_ipd_ptr_count ipd_ptr_count;
80ff0fd3ab6451 drivers/staging/octeon/cvmx-ipd.h David Daney 2009-05-05  165  		ipd_ptr_count.u64 = cvmx_read_csr(CVMX_IPD_PTR_COUNT);
80ff0fd3ab6451 drivers/staging/octeon/cvmx-ipd.h David Daney 2009-05-05  166  
80ff0fd3ab6451 drivers/staging/octeon/cvmx-ipd.h David Daney 2009-05-05  167  		/* Handle Work Queue Entry in cn56xx and cn52xx */
80ff0fd3ab6451 drivers/staging/octeon/cvmx-ipd.h David Daney 2009-05-05  168  		if (octeon_has_feature(OCTEON_FEATURE_NO_WPTR)) {
80ff0fd3ab6451 drivers/staging/octeon/cvmx-ipd.h David Daney 2009-05-05  169  			union cvmx_ipd_ctl_status ipd_ctl_status;
80ff0fd3ab6451 drivers/staging/octeon/cvmx-ipd.h David Daney 2009-05-05  170  			ipd_ctl_status.u64 = cvmx_read_csr(CVMX_IPD_CTL_STATUS);
80ff0fd3ab6451 drivers/staging/octeon/cvmx-ipd.h David Daney 2009-05-05  171  			if (ipd_ctl_status.s.no_wptr)
80ff0fd3ab6451 drivers/staging/octeon/cvmx-ipd.h David Daney 2009-05-05  172  				no_wptr = 1;
80ff0fd3ab6451 drivers/staging/octeon/cvmx-ipd.h David Daney 2009-05-05  173  		}
80ff0fd3ab6451 drivers/staging/octeon/cvmx-ipd.h David Daney 2009-05-05  174  
80ff0fd3ab6451 drivers/staging/octeon/cvmx-ipd.h David Daney 2009-05-05  175  		/* Free the prefetched WQE */
80ff0fd3ab6451 drivers/staging/octeon/cvmx-ipd.h David Daney 2009-05-05  176  		if (ipd_ptr_count.s.wqev_cnt) {
80ff0fd3ab6451 drivers/staging/octeon/cvmx-ipd.h David Daney 2009-05-05  177  			union cvmx_ipd_wqe_ptr_valid ipd_wqe_ptr_valid;
80ff0fd3ab6451 drivers/staging/octeon/cvmx-ipd.h David Daney 2009-05-05  178  			ipd_wqe_ptr_valid.u64 =
80ff0fd3ab6451 drivers/staging/octeon/cvmx-ipd.h David Daney 2009-05-05  179  			    cvmx_read_csr(CVMX_IPD_WQE_PTR_VALID);
80ff0fd3ab6451 drivers/staging/octeon/cvmx-ipd.h David Daney 2009-05-05  180  			if (no_wptr)
80ff0fd3ab6451 drivers/staging/octeon/cvmx-ipd.h David Daney 2009-05-05  181  				cvmx_fpa_free(cvmx_phys_to_ptr
80ff0fd3ab6451 drivers/staging/octeon/cvmx-ipd.h David Daney 2009-05-05  182  					      ((uint64_t) ipd_wqe_ptr_valid.s.
80ff0fd3ab6451 drivers/staging/octeon/cvmx-ipd.h David Daney 2009-05-05  183  					       ptr << 7), CVMX_FPA_PACKET_POOL,
80ff0fd3ab6451 drivers/staging/octeon/cvmx-ipd.h David Daney 2009-05-05  184  					      0);
80ff0fd3ab6451 drivers/staging/octeon/cvmx-ipd.h David Daney 2009-05-05  185  			else
80ff0fd3ab6451 drivers/staging/octeon/cvmx-ipd.h David Daney 2009-05-05  186  				cvmx_fpa_free(cvmx_phys_to_ptr
80ff0fd3ab6451 drivers/staging/octeon/cvmx-ipd.h David Daney 2009-05-05  187  					      ((uint64_t) ipd_wqe_ptr_valid.s.
80ff0fd3ab6451 drivers/staging/octeon/cvmx-ipd.h David Daney 2009-05-05  188  					       ptr << 7), CVMX_FPA_WQE_POOL, 0);
80ff0fd3ab6451 drivers/staging/octeon/cvmx-ipd.h David Daney 2009-05-05  189  		}
80ff0fd3ab6451 drivers/staging/octeon/cvmx-ipd.h David Daney 2009-05-05  190  
80ff0fd3ab6451 drivers/staging/octeon/cvmx-ipd.h David Daney 2009-05-05  191  		/* Free all WQE in the fifo */
80ff0fd3ab6451 drivers/staging/octeon/cvmx-ipd.h David Daney 2009-05-05  192  		if (ipd_ptr_count.s.wqe_pcnt) {
80ff0fd3ab6451 drivers/staging/octeon/cvmx-ipd.h David Daney 2009-05-05  193  			int i;
80ff0fd3ab6451 drivers/staging/octeon/cvmx-ipd.h David Daney 2009-05-05  194  			union cvmx_ipd_pwp_ptr_fifo_ctl ipd_pwp_ptr_fifo_ctl;
80ff0fd3ab6451 drivers/staging/octeon/cvmx-ipd.h David Daney 2009-05-05  195  			ipd_pwp_ptr_fifo_ctl.u64 =
80ff0fd3ab6451 drivers/staging/octeon/cvmx-ipd.h David Daney 2009-05-05  196  			    cvmx_read_csr(CVMX_IPD_PWP_PTR_FIFO_CTL);
80ff0fd3ab6451 drivers/staging/octeon/cvmx-ipd.h David Daney 2009-05-05  197  			for (i = 0; i < ipd_ptr_count.s.wqe_pcnt; i++) {
80ff0fd3ab6451 drivers/staging/octeon/cvmx-ipd.h David Daney 2009-05-05  198  				ipd_pwp_ptr_fifo_ctl.s.cena = 0;
80ff0fd3ab6451 drivers/staging/octeon/cvmx-ipd.h David Daney 2009-05-05  199  				ipd_pwp_ptr_fifo_ctl.s.raddr =
80ff0fd3ab6451 drivers/staging/octeon/cvmx-ipd.h David Daney 2009-05-05  200  				    ipd_pwp_ptr_fifo_ctl.s.max_cnts +
80ff0fd3ab6451 drivers/staging/octeon/cvmx-ipd.h David Daney 2009-05-05  201  				    (ipd_pwp_ptr_fifo_ctl.s.wraddr +
80ff0fd3ab6451 drivers/staging/octeon/cvmx-ipd.h David Daney 2009-05-05  202  				     i) % ipd_pwp_ptr_fifo_ctl.s.max_cnts;
80ff0fd3ab6451 drivers/staging/octeon/cvmx-ipd.h David Daney 2009-05-05  203  				cvmx_write_csr(CVMX_IPD_PWP_PTR_FIFO_CTL,
80ff0fd3ab6451 drivers/staging/octeon/cvmx-ipd.h David Daney 2009-05-05  204  					       ipd_pwp_ptr_fifo_ctl.u64);
80ff0fd3ab6451 drivers/staging/octeon/cvmx-ipd.h David Daney 2009-05-05  205  				ipd_pwp_ptr_fifo_ctl.u64 =
80ff0fd3ab6451 drivers/staging/octeon/cvmx-ipd.h David Daney 2009-05-05  206  				    cvmx_read_csr(CVMX_IPD_PWP_PTR_FIFO_CTL);
80ff0fd3ab6451 drivers/staging/octeon/cvmx-ipd.h David Daney 2009-05-05  207  				if (no_wptr)
80ff0fd3ab6451 drivers/staging/octeon/cvmx-ipd.h David Daney 2009-05-05  208  					cvmx_fpa_free(cvmx_phys_to_ptr
80ff0fd3ab6451 drivers/staging/octeon/cvmx-ipd.h David Daney 2009-05-05  209  						      ((uint64_t)
80ff0fd3ab6451 drivers/staging/octeon/cvmx-ipd.h David Daney 2009-05-05  210  						       ipd_pwp_ptr_fifo_ctl.s.
80ff0fd3ab6451 drivers/staging/octeon/cvmx-ipd.h David Daney 2009-05-05  211  						       ptr << 7),
80ff0fd3ab6451 drivers/staging/octeon/cvmx-ipd.h David Daney 2009-05-05  212  						      CVMX_FPA_PACKET_POOL, 0);
80ff0fd3ab6451 drivers/staging/octeon/cvmx-ipd.h David Daney 2009-05-05  213  				else
80ff0fd3ab6451 drivers/staging/octeon/cvmx-ipd.h David Daney 2009-05-05  214  					cvmx_fpa_free(cvmx_phys_to_ptr
80ff0fd3ab6451 drivers/staging/octeon/cvmx-ipd.h David Daney 2009-05-05  215  						      ((uint64_t)
80ff0fd3ab6451 drivers/staging/octeon/cvmx-ipd.h David Daney 2009-05-05  216  						       ipd_pwp_ptr_fifo_ctl.s.
80ff0fd3ab6451 drivers/staging/octeon/cvmx-ipd.h David Daney 2009-05-05  217  						       ptr << 7),
80ff0fd3ab6451 drivers/staging/octeon/cvmx-ipd.h David Daney 2009-05-05  218  						      CVMX_FPA_WQE_POOL, 0);
80ff0fd3ab6451 drivers/staging/octeon/cvmx-ipd.h David Daney 2009-05-05  219  			}
80ff0fd3ab6451 drivers/staging/octeon/cvmx-ipd.h David Daney 2009-05-05  220  			ipd_pwp_ptr_fifo_ctl.s.cena = 1;
80ff0fd3ab6451 drivers/staging/octeon/cvmx-ipd.h David Daney 2009-05-05  221  			cvmx_write_csr(CVMX_IPD_PWP_PTR_FIFO_CTL,
80ff0fd3ab6451 drivers/staging/octeon/cvmx-ipd.h David Daney 2009-05-05  222  				       ipd_pwp_ptr_fifo_ctl.u64);
80ff0fd3ab6451 drivers/staging/octeon/cvmx-ipd.h David Daney 2009-05-05  223  		}
80ff0fd3ab6451 drivers/staging/octeon/cvmx-ipd.h David Daney 2009-05-05  224  
80ff0fd3ab6451 drivers/staging/octeon/cvmx-ipd.h David Daney 2009-05-05  225  		/* Free the prefetched packet */
80ff0fd3ab6451 drivers/staging/octeon/cvmx-ipd.h David Daney 2009-05-05  226  		if (ipd_ptr_count.s.pktv_cnt) {
80ff0fd3ab6451 drivers/staging/octeon/cvmx-ipd.h David Daney 2009-05-05  227  			union cvmx_ipd_pkt_ptr_valid ipd_pkt_ptr_valid;
80ff0fd3ab6451 drivers/staging/octeon/cvmx-ipd.h David Daney 2009-05-05  228  			ipd_pkt_ptr_valid.u64 =
80ff0fd3ab6451 drivers/staging/octeon/cvmx-ipd.h David Daney 2009-05-05  229  			    cvmx_read_csr(CVMX_IPD_PKT_PTR_VALID);
80ff0fd3ab6451 drivers/staging/octeon/cvmx-ipd.h David Daney 2009-05-05  230  			cvmx_fpa_free(cvmx_phys_to_ptr
80ff0fd3ab6451 drivers/staging/octeon/cvmx-ipd.h David Daney 2009-05-05  231  				      (ipd_pkt_ptr_valid.s.ptr << 7),
80ff0fd3ab6451 drivers/staging/octeon/cvmx-ipd.h David Daney 2009-05-05  232  				      CVMX_FPA_PACKET_POOL, 0);
80ff0fd3ab6451 drivers/staging/octeon/cvmx-ipd.h David Daney 2009-05-05  233  		}
80ff0fd3ab6451 drivers/staging/octeon/cvmx-ipd.h David Daney 2009-05-05  234  
80ff0fd3ab6451 drivers/staging/octeon/cvmx-ipd.h David Daney 2009-05-05  235  		/* Free the per port prefetched packets */
80ff0fd3ab6451 drivers/staging/octeon/cvmx-ipd.h David Daney 2009-05-05  236  		if (1) {
80ff0fd3ab6451 drivers/staging/octeon/cvmx-ipd.h David Daney 2009-05-05  237  			int i;
80ff0fd3ab6451 drivers/staging/octeon/cvmx-ipd.h David Daney 2009-05-05  238  			union cvmx_ipd_prc_port_ptr_fifo_ctl
80ff0fd3ab6451 drivers/staging/octeon/cvmx-ipd.h David Daney 2009-05-05  239  			    ipd_prc_port_ptr_fifo_ctl;
80ff0fd3ab6451 drivers/staging/octeon/cvmx-ipd.h David Daney 2009-05-05  240  			ipd_prc_port_ptr_fifo_ctl.u64 =
80ff0fd3ab6451 drivers/staging/octeon/cvmx-ipd.h David Daney 2009-05-05  241  			    cvmx_read_csr(CVMX_IPD_PRC_PORT_PTR_FIFO_CTL);
80ff0fd3ab6451 drivers/staging/octeon/cvmx-ipd.h David Daney 2009-05-05  242  
80ff0fd3ab6451 drivers/staging/octeon/cvmx-ipd.h David Daney 2009-05-05  243  			for (i = 0; i < ipd_prc_port_ptr_fifo_ctl.s.max_pkt;
80ff0fd3ab6451 drivers/staging/octeon/cvmx-ipd.h David Daney 2009-05-05  244  			     i++) {
80ff0fd3ab6451 drivers/staging/octeon/cvmx-ipd.h David Daney 2009-05-05  245  				ipd_prc_port_ptr_fifo_ctl.s.cena = 0;
80ff0fd3ab6451 drivers/staging/octeon/cvmx-ipd.h David Daney 2009-05-05  246  				ipd_prc_port_ptr_fifo_ctl.s.raddr =
80ff0fd3ab6451 drivers/staging/octeon/cvmx-ipd.h David Daney 2009-05-05  247  				    i % ipd_prc_port_ptr_fifo_ctl.s.max_pkt;
80ff0fd3ab6451 drivers/staging/octeon/cvmx-ipd.h David Daney 2009-05-05  248  				cvmx_write_csr(CVMX_IPD_PRC_PORT_PTR_FIFO_CTL,
80ff0fd3ab6451 drivers/staging/octeon/cvmx-ipd.h David Daney 2009-05-05  249  					       ipd_prc_port_ptr_fifo_ctl.u64);
80ff0fd3ab6451 drivers/staging/octeon/cvmx-ipd.h David Daney 2009-05-05  250  				ipd_prc_port_ptr_fifo_ctl.u64 =
80ff0fd3ab6451 drivers/staging/octeon/cvmx-ipd.h David Daney 2009-05-05  251  				    cvmx_read_csr
80ff0fd3ab6451 drivers/staging/octeon/cvmx-ipd.h David Daney 2009-05-05  252  				    (CVMX_IPD_PRC_PORT_PTR_FIFO_CTL);
80ff0fd3ab6451 drivers/staging/octeon/cvmx-ipd.h David Daney 2009-05-05  253  				cvmx_fpa_free(cvmx_phys_to_ptr
80ff0fd3ab6451 drivers/staging/octeon/cvmx-ipd.h David Daney 2009-05-05  254  					      ((uint64_t)
80ff0fd3ab6451 drivers/staging/octeon/cvmx-ipd.h David Daney 2009-05-05  255  					       ipd_prc_port_ptr_fifo_ctl.s.
80ff0fd3ab6451 drivers/staging/octeon/cvmx-ipd.h David Daney 2009-05-05  256  					       ptr << 7), CVMX_FPA_PACKET_POOL,
80ff0fd3ab6451 drivers/staging/octeon/cvmx-ipd.h David Daney 2009-05-05  257  					      0);
80ff0fd3ab6451 drivers/staging/octeon/cvmx-ipd.h David Daney 2009-05-05  258  			}
80ff0fd3ab6451 drivers/staging/octeon/cvmx-ipd.h David Daney 2009-05-05  259  			ipd_prc_port_ptr_fifo_ctl.s.cena = 1;
80ff0fd3ab6451 drivers/staging/octeon/cvmx-ipd.h David Daney 2009-05-05  260  			cvmx_write_csr(CVMX_IPD_PRC_PORT_PTR_FIFO_CTL,
80ff0fd3ab6451 drivers/staging/octeon/cvmx-ipd.h David Daney 2009-05-05  261  				       ipd_prc_port_ptr_fifo_ctl.u64);
80ff0fd3ab6451 drivers/staging/octeon/cvmx-ipd.h David Daney 2009-05-05  262  		}
80ff0fd3ab6451 drivers/staging/octeon/cvmx-ipd.h David Daney 2009-05-05  263  
80ff0fd3ab6451 drivers/staging/octeon/cvmx-ipd.h David Daney 2009-05-05  264  		/* Free all packets in the holding fifo */
80ff0fd3ab6451 drivers/staging/octeon/cvmx-ipd.h David Daney 2009-05-05  265  		if (ipd_ptr_count.s.pfif_cnt) {
80ff0fd3ab6451 drivers/staging/octeon/cvmx-ipd.h David Daney 2009-05-05  266  			int i;
80ff0fd3ab6451 drivers/staging/octeon/cvmx-ipd.h David Daney 2009-05-05  267  			union cvmx_ipd_prc_hold_ptr_fifo_ctl
80ff0fd3ab6451 drivers/staging/octeon/cvmx-ipd.h David Daney 2009-05-05  268  			    ipd_prc_hold_ptr_fifo_ctl;
80ff0fd3ab6451 drivers/staging/octeon/cvmx-ipd.h David Daney 2009-05-05  269  
80ff0fd3ab6451 drivers/staging/octeon/cvmx-ipd.h David Daney 2009-05-05  270  			ipd_prc_hold_ptr_fifo_ctl.u64 =
80ff0fd3ab6451 drivers/staging/octeon/cvmx-ipd.h David Daney 2009-05-05  271  			    cvmx_read_csr(CVMX_IPD_PRC_HOLD_PTR_FIFO_CTL);
80ff0fd3ab6451 drivers/staging/octeon/cvmx-ipd.h David Daney 2009-05-05  272  
80ff0fd3ab6451 drivers/staging/octeon/cvmx-ipd.h David Daney 2009-05-05  273  			for (i = 0; i < ipd_ptr_count.s.pfif_cnt; i++) {
80ff0fd3ab6451 drivers/staging/octeon/cvmx-ipd.h David Daney 2009-05-05  274  				ipd_prc_hold_ptr_fifo_ctl.s.cena = 0;
80ff0fd3ab6451 drivers/staging/octeon/cvmx-ipd.h David Daney 2009-05-05  275  				ipd_prc_hold_ptr_fifo_ctl.s.raddr =
80ff0fd3ab6451 drivers/staging/octeon/cvmx-ipd.h David Daney 2009-05-05  276  				    (ipd_prc_hold_ptr_fifo_ctl.s.praddr +
80ff0fd3ab6451 drivers/staging/octeon/cvmx-ipd.h David Daney 2009-05-05  277  				     i) % ipd_prc_hold_ptr_fifo_ctl.s.max_pkt;
80ff0fd3ab6451 drivers/staging/octeon/cvmx-ipd.h David Daney 2009-05-05  278  				cvmx_write_csr(CVMX_IPD_PRC_HOLD_PTR_FIFO_CTL,
80ff0fd3ab6451 drivers/staging/octeon/cvmx-ipd.h David Daney 2009-05-05  279  					       ipd_prc_hold_ptr_fifo_ctl.u64);
80ff0fd3ab6451 drivers/staging/octeon/cvmx-ipd.h David Daney 2009-05-05  280  				ipd_prc_hold_ptr_fifo_ctl.u64 =
80ff0fd3ab6451 drivers/staging/octeon/cvmx-ipd.h David Daney 2009-05-05  281  				    cvmx_read_csr
80ff0fd3ab6451 drivers/staging/octeon/cvmx-ipd.h David Daney 2009-05-05  282  				    (CVMX_IPD_PRC_HOLD_PTR_FIFO_CTL);
80ff0fd3ab6451 drivers/staging/octeon/cvmx-ipd.h David Daney 2009-05-05  283  				cvmx_fpa_free(cvmx_phys_to_ptr
80ff0fd3ab6451 drivers/staging/octeon/cvmx-ipd.h David Daney 2009-05-05  284  					      ((uint64_t)
80ff0fd3ab6451 drivers/staging/octeon/cvmx-ipd.h David Daney 2009-05-05  285  					       ipd_prc_hold_ptr_fifo_ctl.s.
80ff0fd3ab6451 drivers/staging/octeon/cvmx-ipd.h David Daney 2009-05-05  286  					       ptr << 7), CVMX_FPA_PACKET_POOL,
80ff0fd3ab6451 drivers/staging/octeon/cvmx-ipd.h David Daney 2009-05-05  287  					      0);
80ff0fd3ab6451 drivers/staging/octeon/cvmx-ipd.h David Daney 2009-05-05  288  			}
80ff0fd3ab6451 drivers/staging/octeon/cvmx-ipd.h David Daney 2009-05-05  289  			ipd_prc_hold_ptr_fifo_ctl.s.cena = 1;
80ff0fd3ab6451 drivers/staging/octeon/cvmx-ipd.h David Daney 2009-05-05  290  			cvmx_write_csr(CVMX_IPD_PRC_HOLD_PTR_FIFO_CTL,
80ff0fd3ab6451 drivers/staging/octeon/cvmx-ipd.h David Daney 2009-05-05  291  				       ipd_prc_hold_ptr_fifo_ctl.u64);
80ff0fd3ab6451 drivers/staging/octeon/cvmx-ipd.h David Daney 2009-05-05  292  		}
80ff0fd3ab6451 drivers/staging/octeon/cvmx-ipd.h David Daney 2009-05-05  293  
80ff0fd3ab6451 drivers/staging/octeon/cvmx-ipd.h David Daney 2009-05-05  294  		/* Free all packets in the fifo */
80ff0fd3ab6451 drivers/staging/octeon/cvmx-ipd.h David Daney 2009-05-05  295  		if (ipd_ptr_count.s.pkt_pcnt) {
80ff0fd3ab6451 drivers/staging/octeon/cvmx-ipd.h David Daney 2009-05-05  296  			int i;
80ff0fd3ab6451 drivers/staging/octeon/cvmx-ipd.h David Daney 2009-05-05  297  			union cvmx_ipd_pwp_ptr_fifo_ctl ipd_pwp_ptr_fifo_ctl;
80ff0fd3ab6451 drivers/staging/octeon/cvmx-ipd.h David Daney 2009-05-05  298  			ipd_pwp_ptr_fifo_ctl.u64 =
80ff0fd3ab6451 drivers/staging/octeon/cvmx-ipd.h David Daney 2009-05-05  299  			    cvmx_read_csr(CVMX_IPD_PWP_PTR_FIFO_CTL);
80ff0fd3ab6451 drivers/staging/octeon/cvmx-ipd.h David Daney 2009-05-05  300  
80ff0fd3ab6451 drivers/staging/octeon/cvmx-ipd.h David Daney 2009-05-05  301  			for (i = 0; i < ipd_ptr_count.s.pkt_pcnt; i++) {
80ff0fd3ab6451 drivers/staging/octeon/cvmx-ipd.h David Daney 2009-05-05  302  				ipd_pwp_ptr_fifo_ctl.s.cena = 0;
80ff0fd3ab6451 drivers/staging/octeon/cvmx-ipd.h David Daney 2009-05-05  303  				ipd_pwp_ptr_fifo_ctl.s.raddr =
80ff0fd3ab6451 drivers/staging/octeon/cvmx-ipd.h David Daney 2009-05-05  304  				    (ipd_pwp_ptr_fifo_ctl.s.praddr +
80ff0fd3ab6451 drivers/staging/octeon/cvmx-ipd.h David Daney 2009-05-05  305  				     i) % ipd_pwp_ptr_fifo_ctl.s.max_cnts;
80ff0fd3ab6451 drivers/staging/octeon/cvmx-ipd.h David Daney 2009-05-05  306  				cvmx_write_csr(CVMX_IPD_PWP_PTR_FIFO_CTL,
80ff0fd3ab6451 drivers/staging/octeon/cvmx-ipd.h David Daney 2009-05-05  307  					       ipd_pwp_ptr_fifo_ctl.u64);
80ff0fd3ab6451 drivers/staging/octeon/cvmx-ipd.h David Daney 2009-05-05  308  				ipd_pwp_ptr_fifo_ctl.u64 =
80ff0fd3ab6451 drivers/staging/octeon/cvmx-ipd.h David Daney 2009-05-05  309  				    cvmx_read_csr(CVMX_IPD_PWP_PTR_FIFO_CTL);
80ff0fd3ab6451 drivers/staging/octeon/cvmx-ipd.h David Daney 2009-05-05  310  				cvmx_fpa_free(cvmx_phys_to_ptr
80ff0fd3ab6451 drivers/staging/octeon/cvmx-ipd.h David Daney 2009-05-05  311  					      ((uint64_t) ipd_pwp_ptr_fifo_ctl.
80ff0fd3ab6451 drivers/staging/octeon/cvmx-ipd.h David Daney 2009-05-05  312  					       s.ptr << 7),
80ff0fd3ab6451 drivers/staging/octeon/cvmx-ipd.h David Daney 2009-05-05  313  					      CVMX_FPA_PACKET_POOL, 0);
80ff0fd3ab6451 drivers/staging/octeon/cvmx-ipd.h David Daney 2009-05-05  314  			}
80ff0fd3ab6451 drivers/staging/octeon/cvmx-ipd.h David Daney 2009-05-05  315  			ipd_pwp_ptr_fifo_ctl.s.cena = 1;
80ff0fd3ab6451 drivers/staging/octeon/cvmx-ipd.h David Daney 2009-05-05  316  			cvmx_write_csr(CVMX_IPD_PWP_PTR_FIFO_CTL,
80ff0fd3ab6451 drivers/staging/octeon/cvmx-ipd.h David Daney 2009-05-05  317  				       ipd_pwp_ptr_fifo_ctl.u64);
80ff0fd3ab6451 drivers/staging/octeon/cvmx-ipd.h David Daney 2009-05-05  318  		}
80ff0fd3ab6451 drivers/staging/octeon/cvmx-ipd.h David Daney 2009-05-05  319  
80ff0fd3ab6451 drivers/staging/octeon/cvmx-ipd.h David Daney 2009-05-05  320  		/* Reset the IPD to get all buffers out of it */
80ff0fd3ab6451 drivers/staging/octeon/cvmx-ipd.h David Daney 2009-05-05  321  		{
80ff0fd3ab6451 drivers/staging/octeon/cvmx-ipd.h David Daney 2009-05-05  322  			union cvmx_ipd_ctl_status ipd_ctl_status;
80ff0fd3ab6451 drivers/staging/octeon/cvmx-ipd.h David Daney 2009-05-05  323  			ipd_ctl_status.u64 = cvmx_read_csr(CVMX_IPD_CTL_STATUS);
80ff0fd3ab6451 drivers/staging/octeon/cvmx-ipd.h David Daney 2009-05-05  324  			ipd_ctl_status.s.reset = 1;
80ff0fd3ab6451 drivers/staging/octeon/cvmx-ipd.h David Daney 2009-05-05  325  			cvmx_write_csr(CVMX_IPD_CTL_STATUS, ipd_ctl_status.u64);
80ff0fd3ab6451 drivers/staging/octeon/cvmx-ipd.h David Daney 2009-05-05  326  		}
80ff0fd3ab6451 drivers/staging/octeon/cvmx-ipd.h David Daney 2009-05-05  327  
80ff0fd3ab6451 drivers/staging/octeon/cvmx-ipd.h David Daney 2009-05-05  328  		/* Reset the PIP */
80ff0fd3ab6451 drivers/staging/octeon/cvmx-ipd.h David Daney 2009-05-05  329  		{
80ff0fd3ab6451 drivers/staging/octeon/cvmx-ipd.h David Daney 2009-05-05 @330  			union cvmx_pip_sft_rst pip_sft_rst;
80ff0fd3ab6451 drivers/staging/octeon/cvmx-ipd.h David Daney 2009-05-05 @331  			pip_sft_rst.u64 = cvmx_read_csr(CVMX_PIP_SFT_RST);
80ff0fd3ab6451 drivers/staging/octeon/cvmx-ipd.h David Daney 2009-05-05  332  			pip_sft_rst.s.rst = 1;
80ff0fd3ab6451 drivers/staging/octeon/cvmx-ipd.h David Daney 2009-05-05  333  			cvmx_write_csr(CVMX_PIP_SFT_RST, pip_sft_rst.u64);
80ff0fd3ab6451 drivers/staging/octeon/cvmx-ipd.h David Daney 2009-05-05  334  		}
80ff0fd3ab6451 drivers/staging/octeon/cvmx-ipd.h David Daney 2009-05-05  335  	}
80ff0fd3ab6451 drivers/staging/octeon/cvmx-ipd.h David Daney 2009-05-05  336  }
80ff0fd3ab6451 drivers/staging/octeon/cvmx-ipd.h David Daney 2009-05-05  337  

:::::: The code at line 330 was first introduced by commit
:::::: 80ff0fd3ab6451407a20c19b80c1643c4a6d6434 Staging: Add octeon-ethernet driver files.

:::::: TO: David Daney <ddaney@caviumnetworks.com>
:::::: CC: Ralf Baechle <ralf@linux-mips.org>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--iryjel3p6zy6grqp
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--iryjel3p6zy6grqp--
