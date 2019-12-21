Return-Path: <SRS0=ztpy=2L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10A7BC2D0C3
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Dec 2019 17:23:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB9AE2070C
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Dec 2019 17:23:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727100AbfLURXR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Dec 2019 12:23:17 -0500
Received: from mga12.intel.com ([192.55.52.136]:50598 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726567AbfLURXR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Dec 2019 12:23:17 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Dec 2019 09:23:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,340,1571727600"; 
   d="gz'50?scan'50,208,50";a="222710684"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 21 Dec 2019 09:23:13 -0800
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1iiiTA-000GsD-M6; Sun, 22 Dec 2019 01:23:12 +0800
Date:   Sun, 22 Dec 2019 01:22:47 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Anup Patel <anup@brainfault.org>
Subject: include/asm-generic/hugetlb.h:7:9: error: incompatible types when
 returning type 'int' but 'pte_t {aka struct <anonymous>}' was expected
Message-ID: <201912220142.Zy1GSLrP%lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="bncffq7mtx7knk7w"
Content-Disposition: inline
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--bncffq7mtx7knk7w
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   6210469417fd967ec72dea56723593beefeecafb
commit: 6bd33e1ece528f67646db33bf97406b747dafda0 riscv: add nommu support
date:   5 weeks ago
config: riscv-randconfig-a001-20191222 (attached as .config)
compiler: riscv64-linux-gcc (GCC) 7.5.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout 6bd33e1ece528f67646db33bf97406b747dafda0
        # save the attached .config to linux build tree
        GCC_VERSION=7.5.0 make.cross ARCH=riscv 

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/gpu/drm/drm_gem.c: In function 'drm_gem_mmap_obj':
>> drivers/gpu/drm/drm_gem.c:1116:22: error: implicit declaration of function 'pgprot_writecombine' [-Werror=implicit-function-declaration]
     vma->vm_page_prot = pgprot_writecombine(vm_get_page_prot(vma->vm_flags));
                         ^~~~~~~~~~~~~~~~~~~
>> drivers/gpu/drm/drm_gem.c:1116:20: error: incompatible types when assigning to type 'pgprot_t {aka struct <anonymous>}' from type 'int'
     vma->vm_page_prot = pgprot_writecombine(vm_get_page_prot(vma->vm_flags));
                       ^
   cc1: some warnings being treated as errors
--
   drivers/gpu/drm/drm_gem_shmem_helper.c: In function 'drm_gem_shmem_vmap_locked':
>> drivers/gpu/drm/drm_gem_shmem_helper.c:261:17: error: implicit declaration of function 'pgprot_writecombine' [-Werror=implicit-function-declaration]
            VM_MAP, pgprot_writecombine(PAGE_KERNEL));
                    ^~~~~~~~~~~~~~~~~~~
>> drivers/gpu/drm/drm_gem_shmem_helper.c:261:17: error: incompatible type for argument 4 of 'vmap'
   In file included from include/asm-generic/io.h:887:0,
                    from arch/riscv/include/asm/io.h:148,
                    from include/linux/scatterlist.h:9,
                    from include/linux/dma-buf.h:18,
                    from drivers/gpu/drm/drm_gem_shmem_helper.c:6:
   include/linux/vmalloc.h:119:14: note: expected 'pgprot_t {aka struct <anonymous>}' but argument is of type 'int'
    extern void *vmap(struct page **pages, unsigned int count,
                 ^~~~
   cc1: some warnings being treated as errors
--
   drivers/gpu/drm/udl/udl_gem.c: In function 'update_vm_cache_attr':
>> drivers/gpu/drm/udl/udl_gem.c:70:4: error: implicit declaration of function 'pgprot_writecombine' [-Werror=implicit-function-declaration]
       pgprot_writecombine(vm_get_page_prot(vma->vm_flags));
       ^~~~~~~~~~~~~~~~~~~
>> drivers/gpu/drm/udl/udl_gem.c:69:21: error: incompatible types when assigning to type 'pgprot_t {aka struct <anonymous>}' from type 'int'
      vma->vm_page_prot =
                        ^
   cc1: some warnings being treated as errors
--
   drivers/gpu/drm/vgem/vgem_drv.c: In function 'vgem_prime_vmap':
>> drivers/gpu/drm/vgem/vgem_drv.c:392:33: error: implicit declaration of function 'pgprot_writecombine' [-Werror=implicit-function-declaration]
     return vmap(pages, n_pages, 0, pgprot_writecombine(PAGE_KERNEL));
                                    ^~~~~~~~~~~~~~~~~~~
>> drivers/gpu/drm/vgem/vgem_drv.c:392:33: error: incompatible type for argument 4 of 'vmap'
   In file included from include/asm-generic/io.h:887:0,
                    from arch/riscv/include/asm/io.h:148,
                    from include/linux/scatterlist.h:9,
                    from include/linux/dma-buf.h:18,
                    from drivers/gpu/drm/vgem/vgem_drv.c:33:
   include/linux/vmalloc.h:119:14: note: expected 'pgprot_t {aka struct <anonymous>}' but argument is of type 'int'
    extern void *vmap(struct page **pages, unsigned int count,
                 ^~~~
   drivers/gpu/drm/vgem/vgem_drv.c: In function 'vgem_prime_mmap':
>> drivers/gpu/drm/vgem/vgem_drv.c:421:20: error: incompatible types when assigning to type 'pgprot_t {aka struct <anonymous>}' from type 'int'
     vma->vm_page_prot = pgprot_writecombine(vm_get_page_prot(vma->vm_flags));
                       ^
   drivers/gpu/drm/vgem/vgem_drv.c: In function 'vgem_prime_vmap':
   drivers/gpu/drm/vgem/vgem_drv.c:393:1: warning: control reaches end of non-void function [-Wreturn-type]
    }
    ^
   cc1: some warnings being treated as errors
--
   In file included from arch/riscv//kernel/riscv_ksyms.c:6:0:
>> arch/riscv//kernel/riscv_ksyms.c:13:15: error: '__asm_copy_to_user' undeclared here (not in a function); did you mean '__copy_to_user'?
    EXPORT_SYMBOL(__asm_copy_to_user);
                  ^
   include/linux/export.h:102:16: note: in definition of macro '___export_symbol_common'
     extern typeof(sym) sym;      \
                   ^~~
   include/linux/export.h:169:34: note: in expansion of macro '___EXPORT_SYMBOL'
    #define __EXPORT_SYMBOL(sym,sec) ___EXPORT_SYMBOL(sym,sec)
                                     ^~~~~~~~~~~~~~~~
   include/linux/export.h:179:29: note: in expansion of macro '__EXPORT_SYMBOL'
    #define EXPORT_SYMBOL(sym)  __EXPORT_SYMBOL(sym, "")
                                ^~~~~~~~~~~~~~~
   arch/riscv//kernel/riscv_ksyms.c:13:1: note: in expansion of macro 'EXPORT_SYMBOL'
    EXPORT_SYMBOL(__asm_copy_to_user);
    ^~~~~~~~~~~~~
>> arch/riscv//kernel/riscv_ksyms.c:14:15: error: '__asm_copy_from_user' undeclared here (not in a function); did you mean '__asm_copy_to_user'?
    EXPORT_SYMBOL(__asm_copy_from_user);
                  ^
   include/linux/export.h:102:16: note: in definition of macro '___export_symbol_common'
     extern typeof(sym) sym;      \
                   ^~~
   include/linux/export.h:169:34: note: in expansion of macro '___EXPORT_SYMBOL'
    #define __EXPORT_SYMBOL(sym,sec) ___EXPORT_SYMBOL(sym,sec)
                                     ^~~~~~~~~~~~~~~~
   include/linux/export.h:179:29: note: in expansion of macro '__EXPORT_SYMBOL'
    #define EXPORT_SYMBOL(sym)  __EXPORT_SYMBOL(sym, "")
                                ^~~~~~~~~~~~~~~
   arch/riscv//kernel/riscv_ksyms.c:14:1: note: in expansion of macro 'EXPORT_SYMBOL'
    EXPORT_SYMBOL(__asm_copy_from_user);
    ^~~~~~~~~~~~~
--
   In file included from arch/riscv/include/asm/hugetlb.h:5:0,
                    from include/linux/hugetlb.h:444,
                    from arch/riscv//mm/hugetlbpage.c:2:
   include/asm-generic/hugetlb.h: In function 'mk_huge_pte':
>> include/asm-generic/hugetlb.h:7:9: error: implicit declaration of function 'mk_pte'; did you mean '__pte'? [-Werror=implicit-function-declaration]
     return mk_pte(page, pgprot);
            ^~~~~~
            __pte
>> include/asm-generic/hugetlb.h:7:9: error: incompatible types when returning type 'int' but 'pte_t {aka struct <anonymous>}' was expected
     return mk_pte(page, pgprot);
            ^~~~~~~~~~~~~~~~~~~~
   include/asm-generic/hugetlb.h: In function 'huge_pte_write':
>> include/asm-generic/hugetlb.h:12:9: error: implicit declaration of function 'pte_write'; did you mean 'pgd_write'? [-Werror=implicit-function-declaration]
     return pte_write(pte);
            ^~~~~~~~~
            pgd_write
   include/asm-generic/hugetlb.h: In function 'huge_pte_dirty':
>> include/asm-generic/hugetlb.h:17:9: error: implicit declaration of function 'pte_dirty'; did you mean 'info_dirty'? [-Werror=implicit-function-declaration]
     return pte_dirty(pte);
            ^~~~~~~~~
            info_dirty
   include/asm-generic/hugetlb.h: In function 'huge_pte_mkwrite':
>> include/asm-generic/hugetlb.h:22:9: error: implicit declaration of function 'pte_mkwrite'; did you mean 'pgd_write'? [-Werror=implicit-function-declaration]
     return pte_mkwrite(pte);
            ^~~~~~~~~~~
            pgd_write
   include/asm-generic/hugetlb.h:22:9: error: incompatible types when returning type 'int' but 'pte_t {aka struct <anonymous>}' was expected
     return pte_mkwrite(pte);
            ^~~~~~~~~~~~~~~~
   include/asm-generic/hugetlb.h: In function 'huge_pte_mkdirty':
>> include/asm-generic/hugetlb.h:27:9: error: implicit declaration of function 'pte_mkdirty'; did you mean 'huge_pte_mkdirty'? [-Werror=implicit-function-declaration]
     return pte_mkdirty(pte);
            ^~~~~~~~~~~
            huge_pte_mkdirty
   include/asm-generic/hugetlb.h:27:9: error: incompatible types when returning type 'int' but 'pte_t {aka struct <anonymous>}' was expected
     return pte_mkdirty(pte);
            ^~~~~~~~~~~~~~~~
   include/asm-generic/hugetlb.h: In function 'huge_pte_modify':
>> include/asm-generic/hugetlb.h:32:9: error: implicit declaration of function 'pte_modify'; did you mean 'lease_modify'? [-Werror=implicit-function-declaration]
     return pte_modify(pte, newprot);
            ^~~~~~~~~~
            lease_modify
   include/asm-generic/hugetlb.h:32:9: error: incompatible types when returning type 'int' but 'pte_t {aka struct <anonymous>}' was expected
     return pte_modify(pte, newprot);
            ^~~~~~~~~~~~~~~~~~~~~~~~
   include/asm-generic/hugetlb.h: In function 'huge_pte_clear':
>> include/asm-generic/hugetlb.h:39:2: error: implicit declaration of function 'pte_clear'; did you mean 'pud_clear'? [-Werror=implicit-function-declaration]
     pte_clear(mm, addr, ptep);
     ^~~~~~~~~
     pud_clear
   include/asm-generic/hugetlb.h: In function 'set_huge_pte_at':
>> include/asm-generic/hugetlb.h:56:2: error: implicit declaration of function 'set_pte_at'; did you mean 'set_huge_pte_at'? [-Werror=implicit-function-declaration]
     set_pte_at(mm, addr, ptep, pte);
     ^~~~~~~~~~
     set_huge_pte_at
   include/asm-generic/hugetlb.h: In function 'huge_ptep_get_and_clear':
>> include/asm-generic/hugetlb.h:64:9: error: implicit declaration of function 'ptep_get_and_clear'; did you mean 'huge_ptep_get_and_clear'? [-Werror=implicit-function-declaration]
     return ptep_get_and_clear(mm, addr, ptep);
            ^~~~~~~~~~~~~~~~~~
            huge_ptep_get_and_clear
   include/asm-generic/hugetlb.h:64:9: error: incompatible types when returning type 'int' but 'pte_t {aka struct <anonymous>}' was expected
     return ptep_get_and_clear(mm, addr, ptep);
            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/asm-generic/hugetlb.h: In function 'huge_ptep_clear_flush':
>> include/asm-generic/hugetlb.h:72:2: error: implicit declaration of function 'ptep_clear_flush'; did you mean 'huge_ptep_clear_flush'? [-Werror=implicit-function-declaration]
     ptep_clear_flush(vma, addr, ptep);
     ^~~~~~~~~~~~~~~~
     huge_ptep_clear_flush
   include/asm-generic/hugetlb.h: In function 'huge_pte_none':
>> include/asm-generic/hugetlb.h:79:9: error: implicit declaration of function 'pte_none'; did you mean 'pud_none'? [-Werror=implicit-function-declaration]
     return pte_none(pte);
            ^~~~~~~~
            pud_none
   include/asm-generic/hugetlb.h: In function 'huge_pte_wrprotect':
>> include/asm-generic/hugetlb.h:86:9: error: implicit declaration of function 'pte_wrprotect'; did you mean 'huge_pte_wrprotect'? [-Werror=implicit-function-declaration]
     return pte_wrprotect(pte);
            ^~~~~~~~~~~~~
            huge_pte_wrprotect
   include/asm-generic/hugetlb.h:86:9: error: incompatible types when returning type 'int' but 'pte_t {aka struct <anonymous>}' was expected
     return pte_wrprotect(pte);
            ^~~~~~~~~~~~~~~~~~
   include/asm-generic/hugetlb.h: In function 'huge_ptep_set_wrprotect':
>> include/asm-generic/hugetlb.h:109:2: error: implicit declaration of function 'ptep_set_wrprotect'; did you mean 'huge_ptep_set_wrprotect'? [-Werror=implicit-function-declaration]
     ptep_set_wrprotect(mm, addr, ptep);
     ^~~~~~~~~~~~~~~~~~
     huge_ptep_set_wrprotect
   include/asm-generic/hugetlb.h: In function 'huge_ptep_set_access_flags':
>> include/asm-generic/hugetlb.h:118:9: error: implicit declaration of function 'ptep_set_access_flags'; did you mean 'huge_ptep_set_access_flags'? [-Werror=implicit-function-declaration]
     return ptep_set_access_flags(vma, addr, ptep, pte, dirty);
            ^~~~~~~~~~~~~~~~~~~~~
            huge_ptep_set_access_flags
   arch/riscv//mm/hugetlbpage.c: In function 'pmd_huge':
>> arch/riscv//mm/hugetlbpage.c:13:9: error: implicit declaration of function 'pmd_present'; did you mean 'pud_present'? [-Werror=implicit-function-declaration]
     return pmd_present(pmd) &&
            ^~~~~~~~~~~
            pud_present
   cc1: some warnings being treated as errors

vim +7 include/asm-generic/hugetlb.h

106c992a5ebef2 Gerald Schaefer 2013-04-29    4  
106c992a5ebef2 Gerald Schaefer 2013-04-29    5  static inline pte_t mk_huge_pte(struct page *page, pgprot_t pgprot)
106c992a5ebef2 Gerald Schaefer 2013-04-29    6  {
106c992a5ebef2 Gerald Schaefer 2013-04-29   @7  	return mk_pte(page, pgprot);
106c992a5ebef2 Gerald Schaefer 2013-04-29    8  }
106c992a5ebef2 Gerald Schaefer 2013-04-29    9  
26794942461f43 David Miller    2013-10-02   10  static inline unsigned long huge_pte_write(pte_t pte)
106c992a5ebef2 Gerald Schaefer 2013-04-29   11  {
106c992a5ebef2 Gerald Schaefer 2013-04-29  @12  	return pte_write(pte);
106c992a5ebef2 Gerald Schaefer 2013-04-29   13  }
106c992a5ebef2 Gerald Schaefer 2013-04-29   14  
26794942461f43 David Miller    2013-10-02   15  static inline unsigned long huge_pte_dirty(pte_t pte)
106c992a5ebef2 Gerald Schaefer 2013-04-29   16  {
106c992a5ebef2 Gerald Schaefer 2013-04-29  @17  	return pte_dirty(pte);
106c992a5ebef2 Gerald Schaefer 2013-04-29   18  }
106c992a5ebef2 Gerald Schaefer 2013-04-29   19  
106c992a5ebef2 Gerald Schaefer 2013-04-29   20  static inline pte_t huge_pte_mkwrite(pte_t pte)
106c992a5ebef2 Gerald Schaefer 2013-04-29   21  {
106c992a5ebef2 Gerald Schaefer 2013-04-29  @22  	return pte_mkwrite(pte);
106c992a5ebef2 Gerald Schaefer 2013-04-29   23  }
106c992a5ebef2 Gerald Schaefer 2013-04-29   24  
106c992a5ebef2 Gerald Schaefer 2013-04-29   25  static inline pte_t huge_pte_mkdirty(pte_t pte)
106c992a5ebef2 Gerald Schaefer 2013-04-29   26  {
106c992a5ebef2 Gerald Schaefer 2013-04-29  @27  	return pte_mkdirty(pte);
106c992a5ebef2 Gerald Schaefer 2013-04-29   28  }
106c992a5ebef2 Gerald Schaefer 2013-04-29   29  
106c992a5ebef2 Gerald Schaefer 2013-04-29   30  static inline pte_t huge_pte_modify(pte_t pte, pgprot_t newprot)
106c992a5ebef2 Gerald Schaefer 2013-04-29   31  {
106c992a5ebef2 Gerald Schaefer 2013-04-29  @32  	return pte_modify(pte, newprot);
106c992a5ebef2 Gerald Schaefer 2013-04-29   33  }
106c992a5ebef2 Gerald Schaefer 2013-04-29   34  
d018498ccc9277 Alexandre Ghiti 2018-10-26   35  #ifndef __HAVE_ARCH_HUGE_PTE_CLEAR
106c992a5ebef2 Gerald Schaefer 2013-04-29   36  static inline void huge_pte_clear(struct mm_struct *mm, unsigned long addr,
9386fac34c7cbe Punit Agrawal   2017-07-06   37  		    pte_t *ptep, unsigned long sz)
106c992a5ebef2 Gerald Schaefer 2013-04-29   38  {
106c992a5ebef2 Gerald Schaefer 2013-04-29  @39  	pte_clear(mm, addr, ptep);
106c992a5ebef2 Gerald Schaefer 2013-04-29   40  }
9386fac34c7cbe Punit Agrawal   2017-07-06   41  #endif
106c992a5ebef2 Gerald Schaefer 2013-04-29   42  
1e5f50fc9d0a65 Alexandre Ghiti 2018-10-26   43  #ifndef __HAVE_ARCH_HUGETLB_FREE_PGD_RANGE
1e5f50fc9d0a65 Alexandre Ghiti 2018-10-26   44  static inline void hugetlb_free_pgd_range(struct mmu_gather *tlb,
1e5f50fc9d0a65 Alexandre Ghiti 2018-10-26   45  		unsigned long addr, unsigned long end,
1e5f50fc9d0a65 Alexandre Ghiti 2018-10-26   46  		unsigned long floor, unsigned long ceiling)
1e5f50fc9d0a65 Alexandre Ghiti 2018-10-26   47  {
1e5f50fc9d0a65 Alexandre Ghiti 2018-10-26   48  	free_pgd_range(tlb, addr, end, floor, ceiling);
1e5f50fc9d0a65 Alexandre Ghiti 2018-10-26   49  }
cea685d556330b Alexandre Ghiti 2018-10-26   50  #endif
1e5f50fc9d0a65 Alexandre Ghiti 2018-10-26   51  
cea685d556330b Alexandre Ghiti 2018-10-26   52  #ifndef __HAVE_ARCH_HUGE_SET_HUGE_PTE_AT
cea685d556330b Alexandre Ghiti 2018-10-26   53  static inline void set_huge_pte_at(struct mm_struct *mm, unsigned long addr,
cea685d556330b Alexandre Ghiti 2018-10-26   54  		pte_t *ptep, pte_t pte)
cea685d556330b Alexandre Ghiti 2018-10-26   55  {
cea685d556330b Alexandre Ghiti 2018-10-26  @56  	set_pte_at(mm, addr, ptep, pte);
cea685d556330b Alexandre Ghiti 2018-10-26   57  }
1e5f50fc9d0a65 Alexandre Ghiti 2018-10-26   58  #endif
1e5f50fc9d0a65 Alexandre Ghiti 2018-10-26   59  
a4d838536c6e5c Alexandre Ghiti 2018-10-26   60  #ifndef __HAVE_ARCH_HUGE_PTEP_GET_AND_CLEAR
a4d838536c6e5c Alexandre Ghiti 2018-10-26   61  static inline pte_t huge_ptep_get_and_clear(struct mm_struct *mm,
a4d838536c6e5c Alexandre Ghiti 2018-10-26   62  		unsigned long addr, pte_t *ptep)
a4d838536c6e5c Alexandre Ghiti 2018-10-26   63  {
a4d838536c6e5c Alexandre Ghiti 2018-10-26  @64  	return ptep_get_and_clear(mm, addr, ptep);
a4d838536c6e5c Alexandre Ghiti 2018-10-26   65  }
a4d838536c6e5c Alexandre Ghiti 2018-10-26   66  #endif
a4d838536c6e5c Alexandre Ghiti 2018-10-26   67  
fe632225bdbd49 Alexandre Ghiti 2018-10-26   68  #ifndef __HAVE_ARCH_HUGE_PTEP_CLEAR_FLUSH
fe632225bdbd49 Alexandre Ghiti 2018-10-26   69  static inline void huge_ptep_clear_flush(struct vm_area_struct *vma,
fe632225bdbd49 Alexandre Ghiti 2018-10-26   70  		unsigned long addr, pte_t *ptep)
fe632225bdbd49 Alexandre Ghiti 2018-10-26   71  {
fe632225bdbd49 Alexandre Ghiti 2018-10-26  @72  	ptep_clear_flush(vma, addr, ptep);
fe632225bdbd49 Alexandre Ghiti 2018-10-26   73  }
fe632225bdbd49 Alexandre Ghiti 2018-10-26   74  #endif
fe632225bdbd49 Alexandre Ghiti 2018-10-26   75  
cae72abc1af0c1 Alexandre Ghiti 2018-10-26   76  #ifndef __HAVE_ARCH_HUGE_PTE_NONE
cae72abc1af0c1 Alexandre Ghiti 2018-10-26   77  static inline int huge_pte_none(pte_t pte)
cae72abc1af0c1 Alexandre Ghiti 2018-10-26   78  {
cae72abc1af0c1 Alexandre Ghiti 2018-10-26  @79  	return pte_none(pte);
cae72abc1af0c1 Alexandre Ghiti 2018-10-26   80  }
cae72abc1af0c1 Alexandre Ghiti 2018-10-26   81  #endif
cae72abc1af0c1 Alexandre Ghiti 2018-10-26   82  
c4916a008665a6 Alexandre Ghiti 2018-10-26   83  #ifndef __HAVE_ARCH_HUGE_PTE_WRPROTECT
c4916a008665a6 Alexandre Ghiti 2018-10-26   84  static inline pte_t huge_pte_wrprotect(pte_t pte)
c4916a008665a6 Alexandre Ghiti 2018-10-26   85  {
c4916a008665a6 Alexandre Ghiti 2018-10-26  @86  	return pte_wrprotect(pte);
c4916a008665a6 Alexandre Ghiti 2018-10-26   87  }
c4916a008665a6 Alexandre Ghiti 2018-10-26   88  #endif
c4916a008665a6 Alexandre Ghiti 2018-10-26   89  
78d6e4e8ea8700 Alexandre Ghiti 2018-10-26   90  #ifndef __HAVE_ARCH_PREPARE_HUGEPAGE_RANGE
78d6e4e8ea8700 Alexandre Ghiti 2018-10-26   91  static inline int prepare_hugepage_range(struct file *file,
78d6e4e8ea8700 Alexandre Ghiti 2018-10-26   92  		unsigned long addr, unsigned long len)
78d6e4e8ea8700 Alexandre Ghiti 2018-10-26   93  {
78d6e4e8ea8700 Alexandre Ghiti 2018-10-26   94  	struct hstate *h = hstate_file(file);
78d6e4e8ea8700 Alexandre Ghiti 2018-10-26   95  
78d6e4e8ea8700 Alexandre Ghiti 2018-10-26   96  	if (len & ~huge_page_mask(h))
78d6e4e8ea8700 Alexandre Ghiti 2018-10-26   97  		return -EINVAL;
78d6e4e8ea8700 Alexandre Ghiti 2018-10-26   98  	if (addr & ~huge_page_mask(h))
78d6e4e8ea8700 Alexandre Ghiti 2018-10-26   99  		return -EINVAL;
78d6e4e8ea8700 Alexandre Ghiti 2018-10-26  100  
78d6e4e8ea8700 Alexandre Ghiti 2018-10-26  101  	return 0;
78d6e4e8ea8700 Alexandre Ghiti 2018-10-26  102  }
78d6e4e8ea8700 Alexandre Ghiti 2018-10-26  103  #endif
78d6e4e8ea8700 Alexandre Ghiti 2018-10-26  104  
8e581d433bf796 Alexandre Ghiti 2018-10-26  105  #ifndef __HAVE_ARCH_HUGE_PTEP_SET_WRPROTECT
8e581d433bf796 Alexandre Ghiti 2018-10-26  106  static inline void huge_ptep_set_wrprotect(struct mm_struct *mm,
8e581d433bf796 Alexandre Ghiti 2018-10-26  107  		unsigned long addr, pte_t *ptep)
8e581d433bf796 Alexandre Ghiti 2018-10-26  108  {
8e581d433bf796 Alexandre Ghiti 2018-10-26 @109  	ptep_set_wrprotect(mm, addr, ptep);
8e581d433bf796 Alexandre Ghiti 2018-10-26  110  }
8e581d433bf796 Alexandre Ghiti 2018-10-26  111  #endif
8e581d433bf796 Alexandre Ghiti 2018-10-26  112  
facf6d5b8b6c42 Alexandre Ghiti 2018-10-26  113  #ifndef __HAVE_ARCH_HUGE_PTEP_SET_ACCESS_FLAGS
facf6d5b8b6c42 Alexandre Ghiti 2018-10-26  114  static inline int huge_ptep_set_access_flags(struct vm_area_struct *vma,
facf6d5b8b6c42 Alexandre Ghiti 2018-10-26  115  		unsigned long addr, pte_t *ptep,
facf6d5b8b6c42 Alexandre Ghiti 2018-10-26  116  		pte_t pte, int dirty)
facf6d5b8b6c42 Alexandre Ghiti 2018-10-26  117  {
facf6d5b8b6c42 Alexandre Ghiti 2018-10-26 @118  	return ptep_set_access_flags(vma, addr, ptep, pte, dirty);
facf6d5b8b6c42 Alexandre Ghiti 2018-10-26  119  }
facf6d5b8b6c42 Alexandre Ghiti 2018-10-26  120  #endif
facf6d5b8b6c42 Alexandre Ghiti 2018-10-26  121  

:::::: The code at line 7 was first introduced by commit
:::::: 106c992a5ebef28193cf5958e49ceff5e4aebb04 mm/hugetlb: add more arch-defined huge_pte functions

:::::: TO: Gerald Schaefer <gerald.schaefer@de.ibm.com>
:::::: CC: Linus Torvalds <torvalds@linux-foundation.org>

---
0-DAY kernel test infrastructure                 Open Source Technology Center
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org Intel Corporation

--bncffq7mtx7knk7w
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--bncffq7mtx7knk7w--
