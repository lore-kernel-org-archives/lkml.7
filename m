Return-Path: <SRS0=rUXN=XZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37768C4360C
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 09:32:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D14EF21855
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 09:32:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730414AbfI3JcU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Sep 2019 05:32:20 -0400
Received: from mga12.intel.com ([192.55.52.136]:6705 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730348AbfI3JcT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Sep 2019 05:32:19 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Sep 2019 02:32:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,565,1559545200"; 
   d="gz'50?scan'50,208,50";a="190205633"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 30 Sep 2019 02:32:14 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1iEs2Q-00059u-97; Mon, 30 Sep 2019 17:32:14 +0800
Date:   Mon, 30 Sep 2019 17:31:39 +0800
From:   kbuild test robot <lkp@intel.com>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     kbuild-all@01.org, linux-kernel@vger.kernel.org
Subject: arch/mips/include/asm/octeon/cvmx-ipd.h:330:27: error: storage size
 of 'pip_sft_rst' isn't known
Message-ID: <201909301731.nRI71gab%lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="7txk6qslkbmnlylp"
Content-Disposition: inline
X-Patchwork-Hint: ignore
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--7txk6qslkbmnlylp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Matthew,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   97f9a3c4eee55b0178b518ae7114a6a53372913d
commit: 171a9bae68c72f2d1260c3825203760856e6793b staging/octeon: Allow test build on !MIPS
date:   9 weeks ago
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
                    from drivers/staging/octeon/ethernet.c:22:
   arch/mips/include/asm/octeon/cvmx.h: In function 'cvmx_writeq_csr':
   arch/mips/include/asm/octeon/cvmx.h:282:17: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
     cvmx_write_csr((__force uint64_t)csr_addr, val);
                    ^
   arch/mips/include/asm/octeon/cvmx.h: In function 'cvmx_readq_csr':
   arch/mips/include/asm/octeon/cvmx.h:299:23: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
     return cvmx_read_csr((__force uint64_t) csr_addr);
                          ^
   In file included from drivers/staging/octeon/octeon-ethernet.h:27:0,
                    from drivers/staging/octeon/ethernet.c:22:
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

--7txk6qslkbmnlylp
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
fFCY/g+uYnJVy9oDAA==

--7txk6qslkbmnlylp--
