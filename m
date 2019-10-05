Return-Path: <SRS0=6Pxm=X6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1842AC4CED1
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Oct 2019 05:44:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA50C222BE
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Oct 2019 05:44:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727080AbfJEFoB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Oct 2019 01:44:01 -0400
Received: from mga02.intel.com ([134.134.136.20]:43932 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725773AbfJEFoA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Oct 2019 01:44:00 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Oct 2019 22:43:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,259,1566889200"; 
   d="gz'50?scan'50,208,50";a="222366244"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 04 Oct 2019 22:43:56 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1iGcrD-000EvU-RS; Sat, 05 Oct 2019 13:43:55 +0800
Date:   Sat, 5 Oct 2019 13:43:08 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Wei Yang <richardw.yang@linux.intel.com>
Cc:     kbuild-all@01.org, mike.kravetz@oracle.com,
        akpm@linux-foundation.org, hughd@google.com, aarcange@redhat.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Wei Yang <richardw.yang@linux.intel.com>
Subject: Re: [PATCH] hugetlb: remove unused hstate in
 hugetlb_fault_mutex_hash()
Message-ID: <201910051348.hgPQ02gC%lkp@intel.com>
References: <20191005003302.785-1-richardw.yang@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="zhxecfwn5olozuon"
Content-Disposition: inline
In-Reply-To: <20191005003302.785-1-richardw.yang@linux.intel.com>
X-Patchwork-Hint: ignore
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--zhxecfwn5olozuon
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Wei,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on linus/master]
[cannot apply to v5.4-rc1 next-20191004]
[if your patch is applied to the wrong git tree, please drop us a note to help
improve the system. BTW, we also suggest to use '--base' option to specify the
base tree in git format-patch, please see https://stackoverflow.com/a/37406982]

url:    https://github.com/0day-ci/linux/commits/Wei-Yang/hugetlb-remove-unused-hstate-in-hugetlb_fault_mutex_hash/20191005-090034
config: x86_64-lkp (attached as .config)
compiler: gcc-7 (Debian 7.4.0-13) 7.4.0
reproduce:
        # save the attached .config to linux build tree
        make ARCH=x86_64 

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>

All error/warnings (new ones prefixed by >>):

   In file included from include/linux/kernel.h:16:0,
                    from include/asm-generic/bug.h:19,
                    from arch/x86/include/asm/bug.h:83,
                    from include/linux/bug.h:5,
                    from include/linux/mmdebug.h:5,
                    from include/linux/mm.h:9,
                    from mm/userfaultfd.c:8:
   mm/userfaultfd.c: In function '__mcopy_atomic_hugetlb':
>> mm/userfaultfd.c:262:40: error: 'h' undeclared (first use in this function)
      VM_BUG_ON(dst_addr & ~huge_page_mask(h));
                                           ^
   include/linux/build_bug.h:30:63: note: in definition of macro 'BUILD_BUG_ON_INVALID'
    #define BUILD_BUG_ON_INVALID(e) ((void)(sizeof((__force long)(e))))
                                                                  ^
>> mm/userfaultfd.c:262:3: note: in expansion of macro 'VM_BUG_ON'
      VM_BUG_ON(dst_addr & ~huge_page_mask(h));
      ^~~~~~~~~
   mm/userfaultfd.c:262:40: note: each undeclared identifier is reported only once for each function it appears in
      VM_BUG_ON(dst_addr & ~huge_page_mask(h));
                                           ^
   include/linux/build_bug.h:30:63: note: in definition of macro 'BUILD_BUG_ON_INVALID'
    #define BUILD_BUG_ON_INVALID(e) ((void)(sizeof((__force long)(e))))
                                                                  ^
>> mm/userfaultfd.c:262:3: note: in expansion of macro 'VM_BUG_ON'
      VM_BUG_ON(dst_addr & ~huge_page_mask(h));
      ^~~~~~~~~

vim +/h +262 mm/userfaultfd.c

c1a4de99fada21 Andrea Arcangeli 2015-09-04  167  
60d4d2d2b40e44 Mike Kravetz     2017-02-22  168  #ifdef CONFIG_HUGETLB_PAGE
60d4d2d2b40e44 Mike Kravetz     2017-02-22  169  /*
60d4d2d2b40e44 Mike Kravetz     2017-02-22  170   * __mcopy_atomic processing for HUGETLB vmas.  Note that this routine is
60d4d2d2b40e44 Mike Kravetz     2017-02-22  171   * called with mmap_sem held, it will release mmap_sem before returning.
60d4d2d2b40e44 Mike Kravetz     2017-02-22  172   */
60d4d2d2b40e44 Mike Kravetz     2017-02-22  173  static __always_inline ssize_t __mcopy_atomic_hugetlb(struct mm_struct *dst_mm,
60d4d2d2b40e44 Mike Kravetz     2017-02-22  174  					      struct vm_area_struct *dst_vma,
60d4d2d2b40e44 Mike Kravetz     2017-02-22  175  					      unsigned long dst_start,
60d4d2d2b40e44 Mike Kravetz     2017-02-22  176  					      unsigned long src_start,
60d4d2d2b40e44 Mike Kravetz     2017-02-22  177  					      unsigned long len,
60d4d2d2b40e44 Mike Kravetz     2017-02-22  178  					      bool zeropage)
60d4d2d2b40e44 Mike Kravetz     2017-02-22  179  {
1c9e8def43a345 Mike Kravetz     2017-02-22  180  	int vm_alloc_shared = dst_vma->vm_flags & VM_SHARED;
1c9e8def43a345 Mike Kravetz     2017-02-22  181  	int vm_shared = dst_vma->vm_flags & VM_SHARED;
60d4d2d2b40e44 Mike Kravetz     2017-02-22  182  	ssize_t err;
60d4d2d2b40e44 Mike Kravetz     2017-02-22  183  	pte_t *dst_pte;
60d4d2d2b40e44 Mike Kravetz     2017-02-22  184  	unsigned long src_addr, dst_addr;
60d4d2d2b40e44 Mike Kravetz     2017-02-22  185  	long copied;
60d4d2d2b40e44 Mike Kravetz     2017-02-22  186  	struct page *page;
60d4d2d2b40e44 Mike Kravetz     2017-02-22  187  	unsigned long vma_hpagesize;
60d4d2d2b40e44 Mike Kravetz     2017-02-22  188  	pgoff_t idx;
60d4d2d2b40e44 Mike Kravetz     2017-02-22  189  	u32 hash;
60d4d2d2b40e44 Mike Kravetz     2017-02-22  190  	struct address_space *mapping;
60d4d2d2b40e44 Mike Kravetz     2017-02-22  191  
60d4d2d2b40e44 Mike Kravetz     2017-02-22  192  	/*
60d4d2d2b40e44 Mike Kravetz     2017-02-22  193  	 * There is no default zero huge page for all huge page sizes as
60d4d2d2b40e44 Mike Kravetz     2017-02-22  194  	 * supported by hugetlb.  A PMD_SIZE huge pages may exist as used
60d4d2d2b40e44 Mike Kravetz     2017-02-22  195  	 * by THP.  Since we can not reliably insert a zero page, this
60d4d2d2b40e44 Mike Kravetz     2017-02-22  196  	 * feature is not supported.
60d4d2d2b40e44 Mike Kravetz     2017-02-22  197  	 */
60d4d2d2b40e44 Mike Kravetz     2017-02-22  198  	if (zeropage) {
60d4d2d2b40e44 Mike Kravetz     2017-02-22  199  		up_read(&dst_mm->mmap_sem);
60d4d2d2b40e44 Mike Kravetz     2017-02-22  200  		return -EINVAL;
60d4d2d2b40e44 Mike Kravetz     2017-02-22  201  	}
60d4d2d2b40e44 Mike Kravetz     2017-02-22  202  
60d4d2d2b40e44 Mike Kravetz     2017-02-22  203  	src_addr = src_start;
60d4d2d2b40e44 Mike Kravetz     2017-02-22  204  	dst_addr = dst_start;
60d4d2d2b40e44 Mike Kravetz     2017-02-22  205  	copied = 0;
60d4d2d2b40e44 Mike Kravetz     2017-02-22  206  	page = NULL;
60d4d2d2b40e44 Mike Kravetz     2017-02-22  207  	vma_hpagesize = vma_kernel_pagesize(dst_vma);
60d4d2d2b40e44 Mike Kravetz     2017-02-22  208  
60d4d2d2b40e44 Mike Kravetz     2017-02-22  209  	/*
60d4d2d2b40e44 Mike Kravetz     2017-02-22  210  	 * Validate alignment based on huge page size
60d4d2d2b40e44 Mike Kravetz     2017-02-22  211  	 */
60d4d2d2b40e44 Mike Kravetz     2017-02-22  212  	err = -EINVAL;
60d4d2d2b40e44 Mike Kravetz     2017-02-22  213  	if (dst_start & (vma_hpagesize - 1) || len & (vma_hpagesize - 1))
60d4d2d2b40e44 Mike Kravetz     2017-02-22  214  		goto out_unlock;
60d4d2d2b40e44 Mike Kravetz     2017-02-22  215  
60d4d2d2b40e44 Mike Kravetz     2017-02-22  216  retry:
60d4d2d2b40e44 Mike Kravetz     2017-02-22  217  	/*
60d4d2d2b40e44 Mike Kravetz     2017-02-22  218  	 * On routine entry dst_vma is set.  If we had to drop mmap_sem and
60d4d2d2b40e44 Mike Kravetz     2017-02-22  219  	 * retry, dst_vma will be set to NULL and we must lookup again.
60d4d2d2b40e44 Mike Kravetz     2017-02-22  220  	 */
60d4d2d2b40e44 Mike Kravetz     2017-02-22  221  	if (!dst_vma) {
27d02568f529e9 Mike Rapoport    2017-02-24  222  		err = -ENOENT;
60d4d2d2b40e44 Mike Kravetz     2017-02-22  223  		dst_vma = find_vma(dst_mm, dst_start);
60d4d2d2b40e44 Mike Kravetz     2017-02-22  224  		if (!dst_vma || !is_vm_hugetlb_page(dst_vma))
60d4d2d2b40e44 Mike Kravetz     2017-02-22  225  			goto out_unlock;
60d4d2d2b40e44 Mike Kravetz     2017-02-22  226  		/*
29ec90660d68bb Andrea Arcangeli 2018-11-30  227  		 * Check the vma is registered in uffd, this is
29ec90660d68bb Andrea Arcangeli 2018-11-30  228  		 * required to enforce the VM_MAYWRITE check done at
29ec90660d68bb Andrea Arcangeli 2018-11-30  229  		 * uffd registration time.
60d4d2d2b40e44 Mike Kravetz     2017-02-22  230  		 */
27d02568f529e9 Mike Rapoport    2017-02-24  231  		if (!dst_vma->vm_userfaultfd_ctx.ctx)
27d02568f529e9 Mike Rapoport    2017-02-24  232  			goto out_unlock;
27d02568f529e9 Mike Rapoport    2017-02-24  233  
60d4d2d2b40e44 Mike Kravetz     2017-02-22  234  		if (dst_start < dst_vma->vm_start ||
60d4d2d2b40e44 Mike Kravetz     2017-02-22  235  		    dst_start + len > dst_vma->vm_end)
60d4d2d2b40e44 Mike Kravetz     2017-02-22  236  			goto out_unlock;
1c9e8def43a345 Mike Kravetz     2017-02-22  237  
27d02568f529e9 Mike Rapoport    2017-02-24  238  		err = -EINVAL;
27d02568f529e9 Mike Rapoport    2017-02-24  239  		if (vma_hpagesize != vma_kernel_pagesize(dst_vma))
27d02568f529e9 Mike Rapoport    2017-02-24  240  			goto out_unlock;
27d02568f529e9 Mike Rapoport    2017-02-24  241  
1c9e8def43a345 Mike Kravetz     2017-02-22  242  		vm_shared = dst_vma->vm_flags & VM_SHARED;
60d4d2d2b40e44 Mike Kravetz     2017-02-22  243  	}
60d4d2d2b40e44 Mike Kravetz     2017-02-22  244  
60d4d2d2b40e44 Mike Kravetz     2017-02-22  245  	if (WARN_ON(dst_addr & (vma_hpagesize - 1) ||
60d4d2d2b40e44 Mike Kravetz     2017-02-22  246  		    (len - copied) & (vma_hpagesize - 1)))
60d4d2d2b40e44 Mike Kravetz     2017-02-22  247  		goto out_unlock;
60d4d2d2b40e44 Mike Kravetz     2017-02-22  248  
60d4d2d2b40e44 Mike Kravetz     2017-02-22  249  	/*
1c9e8def43a345 Mike Kravetz     2017-02-22  250  	 * If not shared, ensure the dst_vma has a anon_vma.
60d4d2d2b40e44 Mike Kravetz     2017-02-22  251  	 */
60d4d2d2b40e44 Mike Kravetz     2017-02-22  252  	err = -ENOMEM;
1c9e8def43a345 Mike Kravetz     2017-02-22  253  	if (!vm_shared) {
60d4d2d2b40e44 Mike Kravetz     2017-02-22  254  		if (unlikely(anon_vma_prepare(dst_vma)))
60d4d2d2b40e44 Mike Kravetz     2017-02-22  255  			goto out_unlock;
1c9e8def43a345 Mike Kravetz     2017-02-22  256  	}
60d4d2d2b40e44 Mike Kravetz     2017-02-22  257  
60d4d2d2b40e44 Mike Kravetz     2017-02-22  258  	while (src_addr < src_start + len) {
60d4d2d2b40e44 Mike Kravetz     2017-02-22  259  		pte_t dst_pteval;
60d4d2d2b40e44 Mike Kravetz     2017-02-22  260  
60d4d2d2b40e44 Mike Kravetz     2017-02-22  261  		BUG_ON(dst_addr >= dst_start + len);
60d4d2d2b40e44 Mike Kravetz     2017-02-22 @262  		VM_BUG_ON(dst_addr & ~huge_page_mask(h));
60d4d2d2b40e44 Mike Kravetz     2017-02-22  263  
60d4d2d2b40e44 Mike Kravetz     2017-02-22  264  		/*
ddeaab32a89f04 Mike Kravetz     2019-01-08  265  		 * Serialize via hugetlb_fault_mutex
60d4d2d2b40e44 Mike Kravetz     2017-02-22  266  		 */
b43a9990055958 Mike Kravetz     2018-12-28  267  		idx = linear_page_index(dst_vma, dst_addr);
ddeaab32a89f04 Mike Kravetz     2019-01-08  268  		mapping = dst_vma->vm_file->f_mapping;
2b52c262f0e75d Wei Yang         2019-10-05  269  		hash = hugetlb_fault_mutex_hash(mapping, idx, dst_addr);
60d4d2d2b40e44 Mike Kravetz     2017-02-22  270  		mutex_lock(&hugetlb_fault_mutex_table[hash]);
60d4d2d2b40e44 Mike Kravetz     2017-02-22  271  
60d4d2d2b40e44 Mike Kravetz     2017-02-22  272  		err = -ENOMEM;
60d4d2d2b40e44 Mike Kravetz     2017-02-22  273  		dst_pte = huge_pte_alloc(dst_mm, dst_addr, huge_page_size(h));
60d4d2d2b40e44 Mike Kravetz     2017-02-22  274  		if (!dst_pte) {
60d4d2d2b40e44 Mike Kravetz     2017-02-22  275  			mutex_unlock(&hugetlb_fault_mutex_table[hash]);
60d4d2d2b40e44 Mike Kravetz     2017-02-22  276  			goto out_unlock;
60d4d2d2b40e44 Mike Kravetz     2017-02-22  277  		}
60d4d2d2b40e44 Mike Kravetz     2017-02-22  278  
60d4d2d2b40e44 Mike Kravetz     2017-02-22  279  		err = -EEXIST;
60d4d2d2b40e44 Mike Kravetz     2017-02-22  280  		dst_pteval = huge_ptep_get(dst_pte);
60d4d2d2b40e44 Mike Kravetz     2017-02-22  281  		if (!huge_pte_none(dst_pteval)) {
60d4d2d2b40e44 Mike Kravetz     2017-02-22  282  			mutex_unlock(&hugetlb_fault_mutex_table[hash]);
60d4d2d2b40e44 Mike Kravetz     2017-02-22  283  			goto out_unlock;
60d4d2d2b40e44 Mike Kravetz     2017-02-22  284  		}
60d4d2d2b40e44 Mike Kravetz     2017-02-22  285  
60d4d2d2b40e44 Mike Kravetz     2017-02-22  286  		err = hugetlb_mcopy_atomic_pte(dst_mm, dst_pte, dst_vma,
60d4d2d2b40e44 Mike Kravetz     2017-02-22  287  						dst_addr, src_addr, &page);
60d4d2d2b40e44 Mike Kravetz     2017-02-22  288  
60d4d2d2b40e44 Mike Kravetz     2017-02-22  289  		mutex_unlock(&hugetlb_fault_mutex_table[hash]);
1c9e8def43a345 Mike Kravetz     2017-02-22  290  		vm_alloc_shared = vm_shared;
60d4d2d2b40e44 Mike Kravetz     2017-02-22  291  
60d4d2d2b40e44 Mike Kravetz     2017-02-22  292  		cond_resched();
60d4d2d2b40e44 Mike Kravetz     2017-02-22  293  
9e368259ad9883 Andrea Arcangeli 2018-11-30  294  		if (unlikely(err == -ENOENT)) {
60d4d2d2b40e44 Mike Kravetz     2017-02-22  295  			up_read(&dst_mm->mmap_sem);
60d4d2d2b40e44 Mike Kravetz     2017-02-22  296  			BUG_ON(!page);
60d4d2d2b40e44 Mike Kravetz     2017-02-22  297  
60d4d2d2b40e44 Mike Kravetz     2017-02-22  298  			err = copy_huge_page_from_user(page,
60d4d2d2b40e44 Mike Kravetz     2017-02-22  299  						(const void __user *)src_addr,
810a56b943e265 Mike Kravetz     2017-02-22  300  						pages_per_huge_page(h), true);
60d4d2d2b40e44 Mike Kravetz     2017-02-22  301  			if (unlikely(err)) {
60d4d2d2b40e44 Mike Kravetz     2017-02-22  302  				err = -EFAULT;
60d4d2d2b40e44 Mike Kravetz     2017-02-22  303  				goto out;
60d4d2d2b40e44 Mike Kravetz     2017-02-22  304  			}
60d4d2d2b40e44 Mike Kravetz     2017-02-22  305  			down_read(&dst_mm->mmap_sem);
60d4d2d2b40e44 Mike Kravetz     2017-02-22  306  
60d4d2d2b40e44 Mike Kravetz     2017-02-22  307  			dst_vma = NULL;
60d4d2d2b40e44 Mike Kravetz     2017-02-22  308  			goto retry;
60d4d2d2b40e44 Mike Kravetz     2017-02-22  309  		} else
60d4d2d2b40e44 Mike Kravetz     2017-02-22  310  			BUG_ON(page);
60d4d2d2b40e44 Mike Kravetz     2017-02-22  311  
60d4d2d2b40e44 Mike Kravetz     2017-02-22  312  		if (!err) {
60d4d2d2b40e44 Mike Kravetz     2017-02-22  313  			dst_addr += vma_hpagesize;
60d4d2d2b40e44 Mike Kravetz     2017-02-22  314  			src_addr += vma_hpagesize;
60d4d2d2b40e44 Mike Kravetz     2017-02-22  315  			copied += vma_hpagesize;
60d4d2d2b40e44 Mike Kravetz     2017-02-22  316  
60d4d2d2b40e44 Mike Kravetz     2017-02-22  317  			if (fatal_signal_pending(current))
60d4d2d2b40e44 Mike Kravetz     2017-02-22  318  				err = -EINTR;
60d4d2d2b40e44 Mike Kravetz     2017-02-22  319  		}
60d4d2d2b40e44 Mike Kravetz     2017-02-22  320  		if (err)
60d4d2d2b40e44 Mike Kravetz     2017-02-22  321  			break;
60d4d2d2b40e44 Mike Kravetz     2017-02-22  322  	}
60d4d2d2b40e44 Mike Kravetz     2017-02-22  323  
60d4d2d2b40e44 Mike Kravetz     2017-02-22  324  out_unlock:
60d4d2d2b40e44 Mike Kravetz     2017-02-22  325  	up_read(&dst_mm->mmap_sem);
60d4d2d2b40e44 Mike Kravetz     2017-02-22  326  out:
21205bf8f77b23 Mike Kravetz     2017-02-22  327  	if (page) {
21205bf8f77b23 Mike Kravetz     2017-02-22  328  		/*
21205bf8f77b23 Mike Kravetz     2017-02-22  329  		 * We encountered an error and are about to free a newly
1c9e8def43a345 Mike Kravetz     2017-02-22  330  		 * allocated huge page.
1c9e8def43a345 Mike Kravetz     2017-02-22  331  		 *
1c9e8def43a345 Mike Kravetz     2017-02-22  332  		 * Reservation handling is very subtle, and is different for
1c9e8def43a345 Mike Kravetz     2017-02-22  333  		 * private and shared mappings.  See the routine
1c9e8def43a345 Mike Kravetz     2017-02-22  334  		 * restore_reserve_on_error for details.  Unfortunately, we
1c9e8def43a345 Mike Kravetz     2017-02-22  335  		 * can not call restore_reserve_on_error now as it would
1c9e8def43a345 Mike Kravetz     2017-02-22  336  		 * require holding mmap_sem.
1c9e8def43a345 Mike Kravetz     2017-02-22  337  		 *
1c9e8def43a345 Mike Kravetz     2017-02-22  338  		 * If a reservation for the page existed in the reservation
1c9e8def43a345 Mike Kravetz     2017-02-22  339  		 * map of a private mapping, the map was modified to indicate
1c9e8def43a345 Mike Kravetz     2017-02-22  340  		 * the reservation was consumed when the page was allocated.
1c9e8def43a345 Mike Kravetz     2017-02-22  341  		 * We clear the PagePrivate flag now so that the global
21205bf8f77b23 Mike Kravetz     2017-02-22  342  		 * reserve count will not be incremented in free_huge_page.
21205bf8f77b23 Mike Kravetz     2017-02-22  343  		 * The reservation map will still indicate the reservation
21205bf8f77b23 Mike Kravetz     2017-02-22  344  		 * was consumed and possibly prevent later page allocation.
1c9e8def43a345 Mike Kravetz     2017-02-22  345  		 * This is better than leaking a global reservation.  If no
1c9e8def43a345 Mike Kravetz     2017-02-22  346  		 * reservation existed, it is still safe to clear PagePrivate
1c9e8def43a345 Mike Kravetz     2017-02-22  347  		 * as no adjustments to reservation counts were made during
1c9e8def43a345 Mike Kravetz     2017-02-22  348  		 * allocation.
1c9e8def43a345 Mike Kravetz     2017-02-22  349  		 *
1c9e8def43a345 Mike Kravetz     2017-02-22  350  		 * The reservation map for shared mappings indicates which
1c9e8def43a345 Mike Kravetz     2017-02-22  351  		 * pages have reservations.  When a huge page is allocated
1c9e8def43a345 Mike Kravetz     2017-02-22  352  		 * for an address with a reservation, no change is made to
1c9e8def43a345 Mike Kravetz     2017-02-22  353  		 * the reserve map.  In this case PagePrivate will be set
1c9e8def43a345 Mike Kravetz     2017-02-22  354  		 * to indicate that the global reservation count should be
1c9e8def43a345 Mike Kravetz     2017-02-22  355  		 * incremented when the page is freed.  This is the desired
1c9e8def43a345 Mike Kravetz     2017-02-22  356  		 * behavior.  However, when a huge page is allocated for an
1c9e8def43a345 Mike Kravetz     2017-02-22  357  		 * address without a reservation a reservation entry is added
1c9e8def43a345 Mike Kravetz     2017-02-22  358  		 * to the reservation map, and PagePrivate will not be set.
1c9e8def43a345 Mike Kravetz     2017-02-22  359  		 * When the page is freed, the global reserve count will NOT
1c9e8def43a345 Mike Kravetz     2017-02-22  360  		 * be incremented and it will appear as though we have leaked
1c9e8def43a345 Mike Kravetz     2017-02-22  361  		 * reserved page.  In this case, set PagePrivate so that the
1c9e8def43a345 Mike Kravetz     2017-02-22  362  		 * global reserve count will be incremented to match the
1c9e8def43a345 Mike Kravetz     2017-02-22  363  		 * reservation map entry which was created.
1c9e8def43a345 Mike Kravetz     2017-02-22  364  		 *
1c9e8def43a345 Mike Kravetz     2017-02-22  365  		 * Note that vm_alloc_shared is based on the flags of the vma
1c9e8def43a345 Mike Kravetz     2017-02-22  366  		 * for which the page was originally allocated.  dst_vma could
1c9e8def43a345 Mike Kravetz     2017-02-22  367  		 * be different or NULL on error.
21205bf8f77b23 Mike Kravetz     2017-02-22  368  		 */
1c9e8def43a345 Mike Kravetz     2017-02-22  369  		if (vm_alloc_shared)
1c9e8def43a345 Mike Kravetz     2017-02-22  370  			SetPagePrivate(page);
1c9e8def43a345 Mike Kravetz     2017-02-22  371  		else
21205bf8f77b23 Mike Kravetz     2017-02-22  372  			ClearPagePrivate(page);
60d4d2d2b40e44 Mike Kravetz     2017-02-22  373  		put_page(page);
21205bf8f77b23 Mike Kravetz     2017-02-22  374  	}
60d4d2d2b40e44 Mike Kravetz     2017-02-22  375  	BUG_ON(copied < 0);
60d4d2d2b40e44 Mike Kravetz     2017-02-22  376  	BUG_ON(err > 0);
60d4d2d2b40e44 Mike Kravetz     2017-02-22  377  	BUG_ON(!copied && !err);
60d4d2d2b40e44 Mike Kravetz     2017-02-22  378  	return copied ? copied : err;
60d4d2d2b40e44 Mike Kravetz     2017-02-22  379  }
60d4d2d2b40e44 Mike Kravetz     2017-02-22  380  #else /* !CONFIG_HUGETLB_PAGE */
60d4d2d2b40e44 Mike Kravetz     2017-02-22  381  /* fail at build time if gcc attempts to use this */
60d4d2d2b40e44 Mike Kravetz     2017-02-22  382  extern ssize_t __mcopy_atomic_hugetlb(struct mm_struct *dst_mm,
60d4d2d2b40e44 Mike Kravetz     2017-02-22  383  				      struct vm_area_struct *dst_vma,
60d4d2d2b40e44 Mike Kravetz     2017-02-22  384  				      unsigned long dst_start,
60d4d2d2b40e44 Mike Kravetz     2017-02-22  385  				      unsigned long src_start,
60d4d2d2b40e44 Mike Kravetz     2017-02-22  386  				      unsigned long len,
60d4d2d2b40e44 Mike Kravetz     2017-02-22  387  				      bool zeropage);
60d4d2d2b40e44 Mike Kravetz     2017-02-22  388  #endif /* CONFIG_HUGETLB_PAGE */
60d4d2d2b40e44 Mike Kravetz     2017-02-22  389  

:::::: The code at line 262 was first introduced by commit
:::::: 60d4d2d2b40e44cd36bfb6049e8d9e2055a24f8a userfaultfd: hugetlbfs: add __mcopy_atomic_hugetlb for huge page UFFDIO_COPY

:::::: TO: Mike Kravetz <mike.kravetz@oracle.com>
:::::: CC: Linus Torvalds <torvalds@linux-foundation.org>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--zhxecfwn5olozuon
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
vXyI/x8bFvrZ9tEBAA==

--zhxecfwn5olozuon--
