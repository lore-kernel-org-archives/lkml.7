Return-Path: <SRS0=ztpy=2L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E765C2D0C0
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Dec 2019 13:15:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C17812072B
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Dec 2019 13:15:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726905AbfLUNPW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Dec 2019 08:15:22 -0500
Received: from mga05.intel.com ([192.55.52.43]:27327 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726583AbfLUNPW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Dec 2019 08:15:22 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Dec 2019 05:15:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,338,1571727600"; 
   d="gz'50?scan'50,208,50";a="418229924"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 21 Dec 2019 05:15:18 -0800
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1iiebG-0008Zy-Go; Sat, 21 Dec 2019 21:15:18 +0800
Date:   Sat, 21 Dec 2019 21:14:41 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Mike Rapoport <rppt@linux.ibm.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: arch/nds32/include/asm/pgtable.h:360:44: error: passing argument 1
 of 'pmd_offset' from incompatible pointer type
Message-ID: <201912212139.yptX8CsV%lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="zm7po33nwv5koids"
Content-Disposition: inline
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--zm7po33nwv5koids
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   f1fd1610cbb6655883d1838ac79e53301596685d
commit: 7c2763c42326a071220077513a9cae90db46b818 nds32: use pgtable-nopmd instead of 4level-fixup
date:   2 weeks ago
config: nds32-randconfig-a001-20191217 (attached as .config)
compiler: nds32le-linux-gcc (GCC) 9.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout 7c2763c42326a071220077513a9cae90db46b818
        # save the attached .config to linux build tree
        GCC_VERSION=9.2.0 make.cross ARCH=nds32 

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>

All error/warnings (new ones prefixed by >>):

   In file included from arch/nds32/include/asm/cacheflush.h:43,
                    from include/linux/highmem.h:12,
                    from arch/nds32/mm/highmem.c:5:
   include/asm-generic/cacheflush.h:50:20: error: static declaration of 'flush_icache_range' follows non-static declaration
      50 | static inline void flush_icache_range(unsigned long start, unsigned long end)
         |                    ^~~~~~~~~~~~~~~~~~
   In file included from include/linux/highmem.h:12,
                    from arch/nds32/mm/highmem.c:5:
   arch/nds32/include/asm/cacheflush.h:11:6: note: previous declaration of 'flush_icache_range' was here
      11 | void flush_icache_range(unsigned long start, unsigned long end);
         |      ^~~~~~~~~~~~~~~~~~
   In file included from arch/nds32/include/asm/cacheflush.h:43,
                    from include/linux/highmem.h:12,
                    from arch/nds32/mm/highmem.c:5:
   include/asm-generic/cacheflush.h:54:20: error: static declaration of 'flush_icache_page' follows non-static declaration
      54 | static inline void flush_icache_page(struct vm_area_struct *vma,
         |                    ^~~~~~~~~~~~~~~~~
   In file included from include/linux/highmem.h:12,
                    from arch/nds32/mm/highmem.c:5:
   arch/nds32/include/asm/cacheflush.h:12:6: note: previous declaration of 'flush_icache_page' was here
      12 | void flush_icache_page(struct vm_area_struct *vma, struct page *page);
         |      ^~~~~~~~~~~~~~~~~
   In file included from arch/nds32/include/asm/page.h:57,
                    from include/linux/mm_types_task.h:16,
                    from include/linux/mm_types.h:5,
                    from include/linux/mmzone.h:21,
                    from include/linux/gfp.h:6,
                    from include/linux/xarray.h:14,
                    from include/linux/radix-tree.h:18,
                    from include/linux/fs.h:15,
                    from include/linux/highmem.h:5,
                    from arch/nds32/mm/highmem.c:5:
   arch/nds32/mm/highmem.c: In function 'kmap_atomic':
>> arch/nds32/include/asm/pgtable.h:360:44: error: passing argument 1 of 'pmd_offset' from incompatible pointer type [-Werror=incompatible-pointer-types]
     360 | #define pgd_offset(mm, address) ((mm)->pgd + pgd_index(address))
         |                                 ~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~
         |                                            |
         |                                            pgd_t * {aka long unsigned int *}
   arch/nds32/include/asm/memory.h:33:29: note: in definition of macro '__phys_to_virt'
      33 | #define __phys_to_virt(x) ((x) - PHYS_OFFSET + PAGE_OFFSET)
         |                             ^
>> arch/nds32/include/asm/pgtable.h:193:55: note: in expansion of macro '__va'
     193 | #define pmd_page_kernel(pmd)         ((unsigned long) __va(pmd_val(pmd) & PAGE_MASK))
         |                                                       ^~~~
>> include/asm-generic/pgtable-nop4d.h:41:24: note: in expansion of macro 'pgd_val'
      41 | #define p4d_val(x)    (pgd_val((x).pgd))
         |                        ^~~~~~~
>> include/asm-generic/pgtable-nopud.h:50:24: note: in expansion of macro 'p4d_val'
      50 | #define pud_val(x)    (p4d_val((x).p4d))
         |                        ^~~~~~~
>> include/asm-generic/pgtable-nopmd.h:49:24: note: in expansion of macro 'pud_val'
      49 | #define pmd_val(x)    (pud_val((x).pud))
         |                        ^~~~~~~
>> arch/nds32/include/asm/pgtable.h:193:60: note: in expansion of macro 'pmd_val'
     193 | #define pmd_page_kernel(pmd)         ((unsigned long) __va(pmd_val(pmd) & PAGE_MASK))
         |                                                            ^~~~~~~
>> arch/nds32/include/asm/pgtable.h:190:56: note: in expansion of macro 'pmd_page_kernel'
     190 | #define pte_offset_kernel(dir, address)      ((pte_t *)pmd_page_kernel(*(dir)) + pte_index(address))
         |                                                        ^~~~~~~~~~~~~~~
>> arch/nds32/mm/highmem.c:52:9: note: in expansion of macro 'pte_offset_kernel'
      52 |  ptep = pte_offset_kernel(pmd_off_k(vaddr), vaddr);
         |         ^~~~~~~~~~~~~~~~~
>> arch/nds32/include/asm/pgtable.h:362:33: note: in expansion of macro 'pgd_offset'
     362 | #define pgd_offset_k(addr)      pgd_offset(&init_mm, addr)
         |                                 ^~~~~~~~~~
>> arch/nds32/include/asm/pgtable.h:198:39: note: in expansion of macro 'pgd_offset_k'
     198 | #define pmd_off_k(address) pmd_offset(pgd_offset_k(address), address)
         |                                       ^~~~~~~~~~~~
>> arch/nds32/mm/highmem.c:52:27: note: in expansion of macro 'pmd_off_k'
      52 |  ptep = pte_offset_kernel(pmd_off_k(vaddr), vaddr);
         |                           ^~~~~~~~~
   In file included from arch/nds32/include/asm/pgtable.h:7,
                    from include/linux/mm.h:99,
                    from include/linux/highmem.h:8,
                    from arch/nds32/mm/highmem.c:5:
   include/asm-generic/pgtable-nopmd.h:44:42: note: expected 'pud_t *' {aka 'struct <anonymous> *'} but argument is of type 'pgd_t *' {aka 'long unsigned int *'}
      44 | static inline pmd_t * pmd_offset(pud_t * pud, unsigned long address)
         |                                  ~~~~~~~~^~~
   In file included from arch/nds32/include/asm/page.h:57,
                    from include/linux/mm_types_task.h:16,
                    from include/linux/mm_types.h:5,
                    from include/linux/mmzone.h:21,
                    from include/linux/gfp.h:6,
                    from include/linux/xarray.h:14,
                    from include/linux/radix-tree.h:18,
                    from include/linux/fs.h:15,
                    from include/linux/highmem.h:5,
                    from arch/nds32/mm/highmem.c:5:
   arch/nds32/mm/highmem.c: In function '__kunmap_atomic':
>> arch/nds32/include/asm/pgtable.h:360:44: error: passing argument 1 of 'pmd_offset' from incompatible pointer type [-Werror=incompatible-pointer-types]
     360 | #define pgd_offset(mm, address) ((mm)->pgd + pgd_index(address))
         |                                 ~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~
         |                                            |
         |                                            pgd_t * {aka long unsigned int *}
   arch/nds32/include/asm/memory.h:33:29: note: in definition of macro '__phys_to_virt'
      33 | #define __phys_to_virt(x) ((x) - PHYS_OFFSET + PAGE_OFFSET)
         |                             ^
>> arch/nds32/include/asm/pgtable.h:193:55: note: in expansion of macro '__va'
     193 | #define pmd_page_kernel(pmd)         ((unsigned long) __va(pmd_val(pmd) & PAGE_MASK))
         |                                                       ^~~~
>> include/asm-generic/pgtable-nop4d.h:41:24: note: in expansion of macro 'pgd_val'
      41 | #define p4d_val(x)    (pgd_val((x).pgd))
         |                        ^~~~~~~
>> include/asm-generic/pgtable-nopud.h:50:24: note: in expansion of macro 'p4d_val'
      50 | #define pud_val(x)    (p4d_val((x).p4d))
         |                        ^~~~~~~
>> include/asm-generic/pgtable-nopmd.h:49:24: note: in expansion of macro 'pud_val'
      49 | #define pmd_val(x)    (pud_val((x).pud))
         |                        ^~~~~~~
>> arch/nds32/include/asm/pgtable.h:193:60: note: in expansion of macro 'pmd_val'
     193 | #define pmd_page_kernel(pmd)         ((unsigned long) __va(pmd_val(pmd) & PAGE_MASK))
         |                                                            ^~~~~~~
>> arch/nds32/include/asm/pgtable.h:190:56: note: in expansion of macro 'pmd_page_kernel'
     190 | #define pte_offset_kernel(dir, address)      ((pte_t *)pmd_page_kernel(*(dir)) + pte_index(address))
         |                                                        ^~~~~~~~~~~~~~~
   arch/nds32/mm/highmem.c:72:10: note: in expansion of macro 'pte_offset_kernel'
      72 |   ptep = pte_offset_kernel(pmd_off_k(vaddr), vaddr);
         |          ^~~~~~~~~~~~~~~~~
>> arch/nds32/include/asm/pgtable.h:362:33: note: in expansion of macro 'pgd_offset'
     362 | #define pgd_offset_k(addr)      pgd_offset(&init_mm, addr)
         |                                 ^~~~~~~~~~
>> arch/nds32/include/asm/pgtable.h:198:39: note: in expansion of macro 'pgd_offset_k'
     198 | #define pmd_off_k(address) pmd_offset(pgd_offset_k(address), address)
         |                                       ^~~~~~~~~~~~
   arch/nds32/mm/highmem.c:72:28: note: in expansion of macro 'pmd_off_k'
      72 |   ptep = pte_offset_kernel(pmd_off_k(vaddr), vaddr);
         |                            ^~~~~~~~~
   In file included from arch/nds32/include/asm/pgtable.h:7,
                    from include/linux/mm.h:99,
                    from include/linux/highmem.h:8,
                    from arch/nds32/mm/highmem.c:5:
   include/asm-generic/pgtable-nopmd.h:44:42: note: expected 'pud_t *' {aka 'struct <anonymous> *'} but argument is of type 'pgd_t *' {aka 'long unsigned int *'}
      44 | static inline pmd_t * pmd_offset(pud_t * pud, unsigned long address)
         |                                  ~~~~~~~~^~~
   cc1: some warnings being treated as errors

vim +/pmd_offset +360 arch/nds32/include/asm/pgtable.h

2e1aecb970b766 Greentime Hu 2017-10-24  188  
2e1aecb970b766 Greentime Hu 2017-10-24  189  #define pte_index(address)                   (((address) >> PAGE_SHIFT) & (PTRS_PER_PTE - 1))
2e1aecb970b766 Greentime Hu 2017-10-24 @190  #define pte_offset_kernel(dir, address)	     ((pte_t *)pmd_page_kernel(*(dir)) + pte_index(address))
2e1aecb970b766 Greentime Hu 2017-10-24  191  #define pte_offset_map(dir, address)	     ((pte_t *)page_address(pmd_page(*(dir))) + pte_index(address))
2e1aecb970b766 Greentime Hu 2017-10-24  192  #define pte_offset_map_nested(dir, address)  pte_offset_map(dir, address)
2e1aecb970b766 Greentime Hu 2017-10-24 @193  #define pmd_page_kernel(pmd)	  	     ((unsigned long) __va(pmd_val(pmd) & PAGE_MASK))
2e1aecb970b766 Greentime Hu 2017-10-24  194  
2e1aecb970b766 Greentime Hu 2017-10-24  195  #define pte_unmap(pte)		do { } while (0)
2e1aecb970b766 Greentime Hu 2017-10-24  196  #define pte_unmap_nested(pte)	do { } while (0)
2e1aecb970b766 Greentime Hu 2017-10-24  197  
2e1aecb970b766 Greentime Hu 2017-10-24 @198  #define pmd_off_k(address)	pmd_offset(pgd_offset_k(address), address)
2e1aecb970b766 Greentime Hu 2017-10-24  199  
2e1aecb970b766 Greentime Hu 2017-10-24  200  #define set_pte_at(mm,addr,ptep,pteval) set_pte(ptep,pteval)
2e1aecb970b766 Greentime Hu 2017-10-24  201  /*
2e1aecb970b766 Greentime Hu 2017-10-24  202   * Set a level 1 translation table entry, and clean it out of
2e1aecb970b766 Greentime Hu 2017-10-24  203   * any caches such that the MMUs can load it correctly.
2e1aecb970b766 Greentime Hu 2017-10-24  204   */
2e1aecb970b766 Greentime Hu 2017-10-24  205  static inline void set_pmd(pmd_t * pmdp, pmd_t pmd)
2e1aecb970b766 Greentime Hu 2017-10-24  206  {
2e1aecb970b766 Greentime Hu 2017-10-24  207  
2e1aecb970b766 Greentime Hu 2017-10-24  208  	*pmdp = pmd;
2e1aecb970b766 Greentime Hu 2017-10-24  209  #if !defined(CONFIG_CPU_DCACHE_DISABLE) && !defined(CONFIG_CPU_DCACHE_WRITETHROUGH)
2e1aecb970b766 Greentime Hu 2017-10-24  210  	__asm__ volatile ("\n\tcctl %0, L1D_VA_WB"::"r" (pmdp):"memory");
2e1aecb970b766 Greentime Hu 2017-10-24  211  	__nds32__msync_all();
2e1aecb970b766 Greentime Hu 2017-10-24  212  	__nds32__dsb();
2e1aecb970b766 Greentime Hu 2017-10-24  213  #endif
2e1aecb970b766 Greentime Hu 2017-10-24  214  }
2e1aecb970b766 Greentime Hu 2017-10-24  215  
2e1aecb970b766 Greentime Hu 2017-10-24  216  /*
2e1aecb970b766 Greentime Hu 2017-10-24  217   * Set a PTE and flush it out
2e1aecb970b766 Greentime Hu 2017-10-24  218   */
2e1aecb970b766 Greentime Hu 2017-10-24  219  static inline void set_pte(pte_t * ptep, pte_t pte)
2e1aecb970b766 Greentime Hu 2017-10-24  220  {
2e1aecb970b766 Greentime Hu 2017-10-24  221  
2e1aecb970b766 Greentime Hu 2017-10-24  222  	*ptep = pte;
2e1aecb970b766 Greentime Hu 2017-10-24  223  #if !defined(CONFIG_CPU_DCACHE_DISABLE) && !defined(CONFIG_CPU_DCACHE_WRITETHROUGH)
2e1aecb970b766 Greentime Hu 2017-10-24  224  	__asm__ volatile ("\n\tcctl %0, L1D_VA_WB"::"r" (ptep):"memory");
2e1aecb970b766 Greentime Hu 2017-10-24  225  	__nds32__msync_all();
2e1aecb970b766 Greentime Hu 2017-10-24  226  	__nds32__dsb();
2e1aecb970b766 Greentime Hu 2017-10-24  227  #endif
2e1aecb970b766 Greentime Hu 2017-10-24  228  }
2e1aecb970b766 Greentime Hu 2017-10-24  229  
2e1aecb970b766 Greentime Hu 2017-10-24  230  /*
2e1aecb970b766 Greentime Hu 2017-10-24  231   * The following only work if pte_present() is true.
2e1aecb970b766 Greentime Hu 2017-10-24  232   * Undefined behaviour if not..
2e1aecb970b766 Greentime Hu 2017-10-24  233   */
2e1aecb970b766 Greentime Hu 2017-10-24  234  
2e1aecb970b766 Greentime Hu 2017-10-24  235  /*
2e1aecb970b766 Greentime Hu 2017-10-24  236   * pte_write: 	     this page is writeable for user mode
2e1aecb970b766 Greentime Hu 2017-10-24  237   * pte_read:         this page is readable for user mode
2e1aecb970b766 Greentime Hu 2017-10-24  238   * pte_kernel_write: this page is writeable for kernel mode
2e1aecb970b766 Greentime Hu 2017-10-24  239   *
2e1aecb970b766 Greentime Hu 2017-10-24  240   * We don't have pte_kernel_read because kernel always can read.
2e1aecb970b766 Greentime Hu 2017-10-24  241   *
2e1aecb970b766 Greentime Hu 2017-10-24  242   * */
2e1aecb970b766 Greentime Hu 2017-10-24  243  
2e1aecb970b766 Greentime Hu 2017-10-24  244  #define pte_present(pte)        (pte_val(pte) & _PAGE_V)
2e1aecb970b766 Greentime Hu 2017-10-24  245  #define pte_write(pte)          ((pte_val(pte) & _PAGE_M_MASK) == _PAGE_M_URW_KRW)
2e1aecb970b766 Greentime Hu 2017-10-24  246  #define pte_read(pte)		(((pte_val(pte) & _PAGE_M_MASK) == _PAGE_M_UR_KR) || \
2e1aecb970b766 Greentime Hu 2017-10-24  247  				((pte_val(pte) & _PAGE_M_MASK) == _PAGE_M_UR_KRW) || \
2e1aecb970b766 Greentime Hu 2017-10-24  248  				((pte_val(pte) & _PAGE_M_MASK) == _PAGE_M_URW_KRW))
2e1aecb970b766 Greentime Hu 2017-10-24  249  #define pte_kernel_write(pte)   (((pte_val(pte) & _PAGE_M_MASK) == _PAGE_M_URW_KRW) || \
2e1aecb970b766 Greentime Hu 2017-10-24  250  				((pte_val(pte) & _PAGE_M_MASK) == _PAGE_M_UR_KRW) || \
2e1aecb970b766 Greentime Hu 2017-10-24  251  				((pte_val(pte) & _PAGE_M_MASK) == _PAGE_M_KRW) || \
2e1aecb970b766 Greentime Hu 2017-10-24  252  				(((pte_val(pte) & _PAGE_M_MASK) == _PAGE_M_XKRW) && pte_exec(pte)))
2e1aecb970b766 Greentime Hu 2017-10-24  253  #define pte_exec(pte)		(pte_val(pte) & _PAGE_E)
2e1aecb970b766 Greentime Hu 2017-10-24  254  #define pte_dirty(pte)		(pte_val(pte) & _PAGE_D)
2e1aecb970b766 Greentime Hu 2017-10-24  255  #define pte_young(pte)		(pte_val(pte) & _PAGE_YOUNG)
2e1aecb970b766 Greentime Hu 2017-10-24  256  
2e1aecb970b766 Greentime Hu 2017-10-24  257  /*
2e1aecb970b766 Greentime Hu 2017-10-24  258   * The following only works if pte_present() is not true.
2e1aecb970b766 Greentime Hu 2017-10-24  259   */
2e1aecb970b766 Greentime Hu 2017-10-24  260  #define pte_file(pte)		(pte_val(pte) & _PAGE_FILE)
2e1aecb970b766 Greentime Hu 2017-10-24  261  #define pte_to_pgoff(x)		(pte_val(x) >> 2)
2e1aecb970b766 Greentime Hu 2017-10-24  262  #define pgoff_to_pte(x)		__pte(((x) << 2) | _PAGE_FILE)
2e1aecb970b766 Greentime Hu 2017-10-24  263  
2e1aecb970b766 Greentime Hu 2017-10-24  264  #define PTE_FILE_MAX_BITS	29
2e1aecb970b766 Greentime Hu 2017-10-24  265  
2e1aecb970b766 Greentime Hu 2017-10-24  266  #define PTE_BIT_FUNC(fn,op) \
2e1aecb970b766 Greentime Hu 2017-10-24  267  static inline pte_t pte_##fn(pte_t pte) { pte_val(pte) op; return pte; }
2e1aecb970b766 Greentime Hu 2017-10-24  268  
2e1aecb970b766 Greentime Hu 2017-10-24  269  static inline pte_t pte_wrprotect(pte_t pte)
2e1aecb970b766 Greentime Hu 2017-10-24  270  {
2e1aecb970b766 Greentime Hu 2017-10-24  271  	pte_val(pte) = pte_val(pte) & ~_PAGE_M_MASK;
2e1aecb970b766 Greentime Hu 2017-10-24  272  	pte_val(pte) = pte_val(pte) | _PAGE_M_UR_KR;
2e1aecb970b766 Greentime Hu 2017-10-24  273  	return pte;
2e1aecb970b766 Greentime Hu 2017-10-24  274  }
2e1aecb970b766 Greentime Hu 2017-10-24  275  
2e1aecb970b766 Greentime Hu 2017-10-24  276  static inline pte_t pte_mkwrite(pte_t pte)
2e1aecb970b766 Greentime Hu 2017-10-24  277  {
2e1aecb970b766 Greentime Hu 2017-10-24  278  	pte_val(pte) = pte_val(pte) & ~_PAGE_M_MASK;
2e1aecb970b766 Greentime Hu 2017-10-24  279  	pte_val(pte) = pte_val(pte) | _PAGE_M_URW_KRW;
2e1aecb970b766 Greentime Hu 2017-10-24  280  	return pte;
2e1aecb970b766 Greentime Hu 2017-10-24  281  }
2e1aecb970b766 Greentime Hu 2017-10-24  282  
2e1aecb970b766 Greentime Hu 2017-10-24  283  PTE_BIT_FUNC(exprotect, &=~_PAGE_E);
2e1aecb970b766 Greentime Hu 2017-10-24  284  PTE_BIT_FUNC(mkexec, |=_PAGE_E);
2e1aecb970b766 Greentime Hu 2017-10-24  285  PTE_BIT_FUNC(mkclean, &=~_PAGE_D);
2e1aecb970b766 Greentime Hu 2017-10-24  286  PTE_BIT_FUNC(mkdirty, |=_PAGE_D);
2e1aecb970b766 Greentime Hu 2017-10-24  287  PTE_BIT_FUNC(mkold, &=~_PAGE_YOUNG);
2e1aecb970b766 Greentime Hu 2017-10-24  288  PTE_BIT_FUNC(mkyoung, |=_PAGE_YOUNG);
2e1aecb970b766 Greentime Hu 2017-10-24  289  static inline int pte_special(pte_t pte)
2e1aecb970b766 Greentime Hu 2017-10-24  290  {
2e1aecb970b766 Greentime Hu 2017-10-24  291  	return 0;
2e1aecb970b766 Greentime Hu 2017-10-24  292  }
2e1aecb970b766 Greentime Hu 2017-10-24  293  
2e1aecb970b766 Greentime Hu 2017-10-24  294  static inline pte_t pte_mkspecial(pte_t pte)
2e1aecb970b766 Greentime Hu 2017-10-24  295  {
2e1aecb970b766 Greentime Hu 2017-10-24  296  	return pte;
2e1aecb970b766 Greentime Hu 2017-10-24  297  }
2e1aecb970b766 Greentime Hu 2017-10-24  298  
2e1aecb970b766 Greentime Hu 2017-10-24  299  /*
2e1aecb970b766 Greentime Hu 2017-10-24  300   * Mark the prot value as uncacheable and unbufferable.
2e1aecb970b766 Greentime Hu 2017-10-24  301   */
2e1aecb970b766 Greentime Hu 2017-10-24  302  #define pgprot_noncached(prot)	   __pgprot((pgprot_val(prot)&~_PAGE_C_MASK) | _PAGE_C_DEV)
2e1aecb970b766 Greentime Hu 2017-10-24  303  #define pgprot_writecombine(prot)  __pgprot((pgprot_val(prot)&~_PAGE_C_MASK) | _PAGE_C_DEV_WB)
2e1aecb970b766 Greentime Hu 2017-10-24  304  
2e1aecb970b766 Greentime Hu 2017-10-24  305  #define pmd_none(pmd)         (pmd_val(pmd)&0x1)
2e1aecb970b766 Greentime Hu 2017-10-24  306  #define pmd_present(pmd)      (!pmd_none(pmd))
2e1aecb970b766 Greentime Hu 2017-10-24  307  #define	pmd_bad(pmd)	      pmd_none(pmd)
2e1aecb970b766 Greentime Hu 2017-10-24  308  
2e1aecb970b766 Greentime Hu 2017-10-24  309  #define copy_pmd(pmdpd,pmdps)	set_pmd((pmdpd), *(pmdps))
2e1aecb970b766 Greentime Hu 2017-10-24  310  #define pmd_clear(pmdp)		set_pmd((pmdp), __pmd(1))
2e1aecb970b766 Greentime Hu 2017-10-24  311  
2e1aecb970b766 Greentime Hu 2017-10-24  312  static inline pmd_t __mk_pmd(pte_t * ptep, unsigned long prot)
2e1aecb970b766 Greentime Hu 2017-10-24  313  {
2e1aecb970b766 Greentime Hu 2017-10-24  314  	unsigned long ptr = (unsigned long)ptep;
2e1aecb970b766 Greentime Hu 2017-10-24  315  	pmd_t pmd;
2e1aecb970b766 Greentime Hu 2017-10-24  316  
2e1aecb970b766 Greentime Hu 2017-10-24  317  	/*
2e1aecb970b766 Greentime Hu 2017-10-24  318  	 * The pmd must be loaded with the physical
2e1aecb970b766 Greentime Hu 2017-10-24  319  	 * address of the PTE table
2e1aecb970b766 Greentime Hu 2017-10-24  320  	 */
2e1aecb970b766 Greentime Hu 2017-10-24  321  
2e1aecb970b766 Greentime Hu 2017-10-24  322  	pmd_val(pmd) = __virt_to_phys(ptr) | prot;
2e1aecb970b766 Greentime Hu 2017-10-24  323  	return pmd;
2e1aecb970b766 Greentime Hu 2017-10-24  324  }
2e1aecb970b766 Greentime Hu 2017-10-24  325  
2e1aecb970b766 Greentime Hu 2017-10-24  326  #define pmd_page(pmd)        virt_to_page(__va(pmd_val(pmd)))
2e1aecb970b766 Greentime Hu 2017-10-24  327  
2e1aecb970b766 Greentime Hu 2017-10-24  328  /*
2e1aecb970b766 Greentime Hu 2017-10-24  329   * Permanent address of a page. We never have highmem, so this is trivial.
2e1aecb970b766 Greentime Hu 2017-10-24  330   */
2e1aecb970b766 Greentime Hu 2017-10-24  331  #define pages_to_mb(x)       ((x) >> (20 - PAGE_SHIFT))
2e1aecb970b766 Greentime Hu 2017-10-24  332  
2e1aecb970b766 Greentime Hu 2017-10-24  333  /*
2e1aecb970b766 Greentime Hu 2017-10-24  334   * Conversion functions: convert a page and protection to a page entry,
2e1aecb970b766 Greentime Hu 2017-10-24  335   * and a page entry and page directory to the page they refer to.
2e1aecb970b766 Greentime Hu 2017-10-24  336   */
2e1aecb970b766 Greentime Hu 2017-10-24  337  #define mk_pte(page,prot)	pfn_pte(page_to_pfn(page),prot)
2e1aecb970b766 Greentime Hu 2017-10-24  338  
2e1aecb970b766 Greentime Hu 2017-10-24  339  /*
2e1aecb970b766 Greentime Hu 2017-10-24  340   * The "pgd_xxx()" functions here are trivial for a folded two-level
2e1aecb970b766 Greentime Hu 2017-10-24  341   * setup: the pgd is never bad, and a pmd always exists (as it's folded
2e1aecb970b766 Greentime Hu 2017-10-24  342   * into the pgd entry)
2e1aecb970b766 Greentime Hu 2017-10-24  343   */
2e1aecb970b766 Greentime Hu 2017-10-24  344  #define pgd_none(pgd)		(0)
2e1aecb970b766 Greentime Hu 2017-10-24  345  #define pgd_bad(pgd)		(0)
2e1aecb970b766 Greentime Hu 2017-10-24  346  #define pgd_present(pgd)  	(1)
2e1aecb970b766 Greentime Hu 2017-10-24  347  #define pgd_clear(pgdp)		do { } while (0)
2e1aecb970b766 Greentime Hu 2017-10-24  348  
2e1aecb970b766 Greentime Hu 2017-10-24  349  #define page_pte_prot(page,prot)     	mk_pte(page, prot)
2e1aecb970b766 Greentime Hu 2017-10-24  350  #define page_pte(page)		        mk_pte(page, __pgprot(0))
2e1aecb970b766 Greentime Hu 2017-10-24  351  /*
2e1aecb970b766 Greentime Hu 2017-10-24  352   *     L1PTE = $mr1 + ((virt >> PMD_SHIFT) << 2);
2e1aecb970b766 Greentime Hu 2017-10-24  353   *     L2PTE = (((virt >> PAGE_SHIFT) & (PTRS_PER_PTE -1 )) << 2);
2e1aecb970b766 Greentime Hu 2017-10-24  354   *     PPN = (phys & 0xfffff000);
2e1aecb970b766 Greentime Hu 2017-10-24  355   *
2e1aecb970b766 Greentime Hu 2017-10-24  356  */
2e1aecb970b766 Greentime Hu 2017-10-24  357  
2e1aecb970b766 Greentime Hu 2017-10-24  358  /* to find an entry in a page-table-directory */
2e1aecb970b766 Greentime Hu 2017-10-24  359  #define pgd_index(address)      (((address) >> PGDIR_SHIFT) & (PTRS_PER_PGD - 1))
2e1aecb970b766 Greentime Hu 2017-10-24 @360  #define pgd_offset(mm, address)	((mm)->pgd + pgd_index(address))
2e1aecb970b766 Greentime Hu 2017-10-24  361  /* to find an entry in a kernel page-table-directory */
2e1aecb970b766 Greentime Hu 2017-10-24 @362  #define pgd_offset_k(addr)      pgd_offset(&init_mm, addr)
2e1aecb970b766 Greentime Hu 2017-10-24  363  

:::::: The code at line 360 was first introduced by commit
:::::: 2e1aecb970b7662cf3d53d2d18a54c17f1eb55b8 nds32: MMU definitions

:::::: TO: Greentime Hu <greentime@andestech.com>
:::::: CC: Greentime Hu <greentime@andestech.com>

---
0-DAY kernel test infrastructure                 Open Source Technology Center
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org Intel Corporation

--zm7po33nwv5koids
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--zm7po33nwv5koids--
