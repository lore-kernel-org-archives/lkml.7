Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAA6CC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 19:20:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73DAC217F5
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 19:20:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729210AbfCMTUT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 15:20:19 -0400
Received: from mga14.intel.com ([192.55.52.115]:17230 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728059AbfCMTUK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 15:20:10 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Mar 2019 12:20:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,475,1544515200"; 
   d="scan'208";a="125214350"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 13 Mar 2019 12:20:05 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1h49Q4-000HVa-VW; Thu, 14 Mar 2019 03:20:04 +0800
Date:   Thu, 14 Mar 2019 03:15:31 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Souptick Joarder <jrdr.linux@gmail.com>
Cc:     kbuild-all@01.org, linux-kernel@vger.kernel.org,
        William Kucharski <william.kucharski@oracle.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: mm/memory.c:3968:21: sparse: incorrect type in assignment (different
 base types)
Message-ID: <201903140301.VeDCo2VR%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   5453a3df2a5eb49bc24615d4cf0d66b2aae05e5f
commit: 3d3539018d2cbd12e5af4a132636ee7fd8d43ef0 mm: create the new vm_fault_t type
date:   6 days ago
reproduce:
        # apt-get install sparse
        git checkout 3d3539018d2cbd12e5af4a132636ee7fd8d43ef0
        make ARCH=x86_64 allmodconfig
        make C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__'


sparse warnings: (new ones prefixed by >>)

   include/asm-generic/tlb.h:149:22: sparse: expression using sizeof(void)
   include/asm-generic/tlb.h:149:22: sparse: expression using sizeof(void)
   include/asm-generic/tlb.h:150:20: sparse: expression using sizeof(void)
   include/asm-generic/tlb.h:150:20: sparse: expression using sizeof(void)
   include/asm-generic/tlb.h:149:22: sparse: expression using sizeof(void)
   include/asm-generic/tlb.h:149:22: sparse: expression using sizeof(void)
   include/asm-generic/tlb.h:150:20: sparse: expression using sizeof(void)
   include/asm-generic/tlb.h:150:20: sparse: expression using sizeof(void)
   include/asm-generic/tlb.h:149:22: sparse: expression using sizeof(void)
   include/asm-generic/tlb.h:149:22: sparse: expression using sizeof(void)
   include/asm-generic/tlb.h:150:20: sparse: expression using sizeof(void)
   include/asm-generic/tlb.h:150:20: sparse: expression using sizeof(void)
   include/asm-generic/tlb.h:149:22: sparse: expression using sizeof(void)
   include/asm-generic/tlb.h:149:22: sparse: expression using sizeof(void)
   include/asm-generic/tlb.h:150:20: sparse: expression using sizeof(void)
   include/asm-generic/tlb.h:150:20: sparse: expression using sizeof(void)
   include/asm-generic/tlb.h:149:22: sparse: expression using sizeof(void)
   include/asm-generic/tlb.h:149:22: sparse: expression using sizeof(void)
   include/asm-generic/tlb.h:150:20: sparse: expression using sizeof(void)
   include/asm-generic/tlb.h:150:20: sparse: expression using sizeof(void)
   mm/memory.c:1275:31: sparse: expression using sizeof(void)
   mm/memory.c:1275:31: sparse: expression using sizeof(void)
   mm/memory.c:1280:15: sparse: expression using sizeof(void)
   mm/memory.c:1280:15: sparse: expression using sizeof(void)
   mm/memory.c:3389:24: sparse: expression using sizeof(void)
   mm/memory.c:3389:24: sparse: expression using sizeof(void)
   mm/memory.c:3400:21: sparse: expression using sizeof(void)
   mm/memory.c:3400:21: sparse: expression using sizeof(void)
   mm/memory.c:3400:21: sparse: expression using sizeof(void)
   mm/memory.c:3400:21: sparse: expression using sizeof(void)
   mm/memory.c:3400:21: sparse: expression using sizeof(void)
   mm/memory.c:3400:21: sparse: expression using sizeof(void)
   mm/memory.c:3400:21: sparse: expression using sizeof(void)
   mm/memory.c:3400:21: sparse: expression using sizeof(void)
   mm/memory.c:3400:21: sparse: expression using sizeof(void)
   mm/memory.c:3400:21: sparse: expression using sizeof(void)
   mm/memory.c:3400:21: sparse: expression using sizeof(void)
   mm/memory.c:3400:21: sparse: expression using sizeof(void)
   mm/memory.c:3400:21: sparse: expression using sizeof(void)
   mm/memory.c:3400:21: sparse: expression using sizeof(void)
>> mm/memory.c:3968:21: sparse: incorrect type in assignment (different base types) @@    expected restricted vm_fault_t [usertype] ret @@    got e] ret @@
   mm/memory.c:3968:21:    expected restricted vm_fault_t [usertype] ret
   mm/memory.c:3968:21:    got int
   mm/memory.c:833:17: sparse: context imbalance in 'copy_pte_range' - different lock contexts for basic block
   mm/memory.c:1436:16: sparse: context imbalance in '__get_locked_pte' - different lock contexts for basic block
   mm/memory.c:1745:17: sparse: context imbalance in 'remap_pte_range' - different lock contexts for basic block
   mm/memory.c:1978:17: sparse: context imbalance in 'apply_to_pte_range' - unexpected unlock
   mm/memory.c:2427:17: sparse: context imbalance in 'wp_pfn_shared' - unexpected unlock
   mm/memory.c:2489:19: sparse: context imbalance in 'do_wp_page' - different lock contexts for basic block
   mm/memory.c:3071:19: sparse: context imbalance in 'pte_alloc_one_map' - different lock contexts for basic block
   mm/memory.c:3314:17: sparse: context imbalance in 'finish_fault' - unexpected unlock
   mm/memory.c:3426:9: sparse: context imbalance in 'do_fault_around' - unexpected unlock
   mm/memory.c:4076:12: sparse: context imbalance in '__follow_pte_pmd' - different lock contexts for basic block
   mm/memory.c:4153:5: sparse: context imbalance in 'follow_pte_pmd' - different lock contexts for basic block

vim +3968 mm/memory.c

^1da177e Linus Torvalds     2005-04-16  3935  
9a95f3cf Paul Cassella      2014-08-06  3936  /*
9a95f3cf Paul Cassella      2014-08-06  3937   * By the time we get here, we already hold the mm semaphore
9a95f3cf Paul Cassella      2014-08-06  3938   *
9a95f3cf Paul Cassella      2014-08-06  3939   * The mmap_sem may have been released depending on flags and our
9a95f3cf Paul Cassella      2014-08-06  3940   * return value.  See filemap_fault() and __lock_page_or_retry().
9a95f3cf Paul Cassella      2014-08-06  3941   */
2b740303 Souptick Joarder   2018-08-23  3942  vm_fault_t handle_mm_fault(struct vm_area_struct *vma, unsigned long address,
dcddffd4 Kirill A. Shutemov 2016-07-26  3943  		unsigned int flags)
519e5247 Johannes Weiner    2013-09-12  3944  {
2b740303 Souptick Joarder   2018-08-23  3945  	vm_fault_t ret;
519e5247 Johannes Weiner    2013-09-12  3946  
519e5247 Johannes Weiner    2013-09-12  3947  	__set_current_state(TASK_RUNNING);
519e5247 Johannes Weiner    2013-09-12  3948  
519e5247 Johannes Weiner    2013-09-12  3949  	count_vm_event(PGFAULT);
2262185c Roman Gushchin     2017-07-06  3950  	count_memcg_event_mm(vma->vm_mm, PGFAULT);
519e5247 Johannes Weiner    2013-09-12  3951  
519e5247 Johannes Weiner    2013-09-12  3952  	/* do counter updates before entering really critical section. */
519e5247 Johannes Weiner    2013-09-12  3953  	check_sync_rss_stat(current);
519e5247 Johannes Weiner    2013-09-12  3954  
de0c799b Laurent Dufour     2017-09-08  3955  	if (!arch_vma_access_permitted(vma, flags & FAULT_FLAG_WRITE,
de0c799b Laurent Dufour     2017-09-08  3956  					    flags & FAULT_FLAG_INSTRUCTION,
de0c799b Laurent Dufour     2017-09-08  3957  					    flags & FAULT_FLAG_REMOTE))
de0c799b Laurent Dufour     2017-09-08  3958  		return VM_FAULT_SIGSEGV;
de0c799b Laurent Dufour     2017-09-08  3959  
519e5247 Johannes Weiner    2013-09-12  3960  	/*
519e5247 Johannes Weiner    2013-09-12  3961  	 * Enable the memcg OOM handling for faults triggered in user
519e5247 Johannes Weiner    2013-09-12  3962  	 * space.  Kernel faults are handled more gracefully.
519e5247 Johannes Weiner    2013-09-12  3963  	 */
519e5247 Johannes Weiner    2013-09-12  3964  	if (flags & FAULT_FLAG_USER)
29ef680a Michal Hocko       2018-08-17  3965  		mem_cgroup_enter_user_fault();
519e5247 Johannes Weiner    2013-09-12  3966  
bae473a4 Kirill A. Shutemov 2016-07-26  3967  	if (unlikely(is_vm_hugetlb_page(vma)))
bae473a4 Kirill A. Shutemov 2016-07-26 @3968  		ret = hugetlb_fault(vma->vm_mm, vma, address, flags);
bae473a4 Kirill A. Shutemov 2016-07-26  3969  	else
dcddffd4 Kirill A. Shutemov 2016-07-26  3970  		ret = __handle_mm_fault(vma, address, flags);
519e5247 Johannes Weiner    2013-09-12  3971  
49426420 Johannes Weiner    2013-10-16  3972  	if (flags & FAULT_FLAG_USER) {
29ef680a Michal Hocko       2018-08-17  3973  		mem_cgroup_exit_user_fault();
49426420 Johannes Weiner    2013-10-16  3974  		/*
49426420 Johannes Weiner    2013-10-16  3975  		 * The task may have entered a memcg OOM situation but
49426420 Johannes Weiner    2013-10-16  3976  		 * if the allocation error was handled gracefully (no
49426420 Johannes Weiner    2013-10-16  3977  		 * VM_FAULT_OOM), there is no need to kill anything.
49426420 Johannes Weiner    2013-10-16  3978  		 * Just clean up the OOM state peacefully.
49426420 Johannes Weiner    2013-10-16  3979  		 */
49426420 Johannes Weiner    2013-10-16  3980  		if (task_in_memcg_oom(current) && !(ret & VM_FAULT_OOM))
49426420 Johannes Weiner    2013-10-16  3981  			mem_cgroup_oom_synchronize(false);
49426420 Johannes Weiner    2013-10-16  3982  	}
3812c8c8 Johannes Weiner    2013-09-12  3983  
519e5247 Johannes Weiner    2013-09-12  3984  	return ret;
519e5247 Johannes Weiner    2013-09-12  3985  }
e1d6d01a Jesse Barnes       2014-12-12  3986  EXPORT_SYMBOL_GPL(handle_mm_fault);
519e5247 Johannes Weiner    2013-09-12  3987  

:::::: The code at line 3968 was first introduced by commit
:::::: bae473a423f65e480db83c85b5e92254f6dfcb28 mm: introduce fault_env

:::::: TO: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
:::::: CC: Linus Torvalds <torvalds@linux-foundation.org>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
