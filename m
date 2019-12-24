Return-Path: <SRS0=+gZy=2O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8A50C2D0C3
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Dec 2019 21:55:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A31D206CB
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Dec 2019 21:55:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726259AbfLXVsj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Dec 2019 16:48:39 -0500
Received: from mga06.intel.com ([134.134.136.31]:13668 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726214AbfLXVsi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Dec 2019 16:48:38 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Dec 2019 13:48:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,353,1571727600"; 
   d="gz'50?scan'50,208,50";a="419093369"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 24 Dec 2019 13:48:35 -0800
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1ijs2d-0009nV-1P; Wed, 25 Dec 2019 05:48:35 +0800
Date:   Wed, 25 Dec 2019 05:47:36 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Wei Yang <richardw.yang@linux.intel.com>
Cc:     kbuild-all@lists.01.org, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        kirill.shutemov@linux.intel.com,
        Wei Yang <richardw.yang@linux.intel.com>
Subject: Re: [PATCH] mm/rmap.c: split huge pmd when it really is
Message-ID: <201912250506.jQXZsjAu%lkp@intel.com>
References: <20191223022435.30653-1-richardw.yang@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="h4m5at7nxyv73coq"
Content-Disposition: inline
In-Reply-To: <20191223022435.30653-1-richardw.yang@linux.intel.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--h4m5at7nxyv73coq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Wei,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on mmotm/master]
[also build test ERROR on linus/master v5.5-rc3 next-20191220]
[if your patch is applied to the wrong git tree, please drop us a note to help
improve the system. BTW, we also suggest to use '--base' option to specify the
base tree in git format-patch, please see https://stackoverflow.com/a/37406982]

url:    https://github.com/0day-ci/linux/commits/Wei-Yang/mm-rmap-c-split-huge-pmd-when-it-really-is/20191225-023217
base:   git://git.cmpxchg.org/linux-mmotm.git master
config: i386-tinyconfig (attached as .config)
compiler: gcc-7 (Debian 7.5.0-3) 7.5.0
reproduce:
        # save the attached .config to linux build tree
        make ARCH=i386 

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>

All error/warnings (new ones prefixed by >>):

   In file included from include/asm-generic/bug.h:19:0,
                    from arch/x86/include/asm/bug.h:83,
                    from include/linux/bug.h:5,
                    from include/linux/mmdebug.h:5,
                    from include/linux/mm.h:9,
                    from mm/rmap.c:48:
   mm/rmap.c: In function 'try_to_unmap_one':
>> include/linux/compiler.h:350:38: error: call to '__compiletime_assert_1375' declared with attribute error: BUILD_BUG failed
     _compiletime_assert(condition, msg, __compiletime_assert_, __LINE__)
                                         ^
   include/linux/kernel.h:37:48: note: in definition of macro 'IS_ALIGNED'
    #define IS_ALIGNED(x, a)  (((x) & ((typeof(x))(a) - 1)) == 0)
                                                   ^
>> include/linux/compiler.h:338:2: note: in expansion of macro '__compiletime_assert'
     __compiletime_assert(condition, msg, prefix, suffix)
     ^~~~~~~~~~~~~~~~~~~~
   include/linux/compiler.h:350:2: note: in expansion of macro '_compiletime_assert'
     _compiletime_assert(condition, msg, __compiletime_assert_, __LINE__)
     ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
    #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
                                        ^~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:59:21: note: in expansion of macro 'BUILD_BUG_ON_MSG'
    #define BUILD_BUG() BUILD_BUG_ON_MSG(1, "BUILD_BUG failed")
                        ^~~~~~~~~~~~~~~~
>> include/linux/huge_mm.h:282:27: note: in expansion of macro 'BUILD_BUG'
    #define HPAGE_PMD_SIZE ({ BUILD_BUG(); 0; })
                              ^~~~~~~~~
>> mm/rmap.c:1375:23: note: in expansion of macro 'HPAGE_PMD_SIZE'
      IS_ALIGNED(address, HPAGE_PMD_SIZE)) {
                          ^~~~~~~~~~~~~~

vim +/HPAGE_PMD_SIZE +1375 mm/rmap.c

  1336	
  1337	/*
  1338	 * @arg: enum ttu_flags will be passed to this argument
  1339	 */
  1340	static bool try_to_unmap_one(struct page *page, struct vm_area_struct *vma,
  1341			     unsigned long address, void *arg)
  1342	{
  1343		struct mm_struct *mm = vma->vm_mm;
  1344		struct page_vma_mapped_walk pvmw = {
  1345			.page = page,
  1346			.vma = vma,
  1347			.address = address,
  1348		};
  1349		pte_t pteval;
  1350		struct page *subpage;
  1351		bool ret = true;
  1352		struct mmu_notifier_range range;
  1353		enum ttu_flags flags = (enum ttu_flags)arg;
  1354	
  1355		/* munlock has nothing to gain from examining un-locked vmas */
  1356		if ((flags & TTU_MUNLOCK) && !(vma->vm_flags & VM_LOCKED))
  1357			return true;
  1358	
  1359		if (IS_ENABLED(CONFIG_MIGRATION) && (flags & TTU_MIGRATION) &&
  1360		    is_zone_device_page(page) && !is_device_private_page(page))
  1361			return true;
  1362	
  1363		/*
  1364		 * There are two places set TTU_SPLIT_HUGE_PMD
  1365		 *
  1366		 *     unmap_page()
  1367		 *     shrink_page_list()
  1368		 *
  1369		 * In both cases, the "page" here is the PageHead() of the THP.
  1370		 *
  1371		 * If the page is not a real PMD huge page, e.g. after mremap(), it is
  1372		 * not necessary to split.
  1373		 */
  1374		if ((flags & TTU_SPLIT_HUGE_PMD) &&
> 1375			IS_ALIGNED(address, HPAGE_PMD_SIZE)) {
  1376			split_huge_pmd_address(vma, address,
  1377					flags & TTU_SPLIT_FREEZE, page);
  1378		}
  1379	
  1380		/*
  1381		 * For THP, we have to assume the worse case ie pmd for invalidation.
  1382		 * For hugetlb, it could be much worse if we need to do pud
  1383		 * invalidation in the case of pmd sharing.
  1384		 *
  1385		 * Note that the page can not be free in this function as call of
  1386		 * try_to_unmap() must hold a reference on the page.
  1387		 */
  1388		mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, 0, vma, vma->vm_mm,
  1389					address,
  1390					min(vma->vm_end, address + page_size(page)));
  1391		if (PageHuge(page)) {
  1392			/*
  1393			 * If sharing is possible, start and end will be adjusted
  1394			 * accordingly.
  1395			 */
  1396			adjust_range_if_pmd_sharing_possible(vma, &range.start,
  1397							     &range.end);
  1398		}
  1399		mmu_notifier_invalidate_range_start(&range);
  1400	
  1401		while (page_vma_mapped_walk(&pvmw)) {
  1402	#ifdef CONFIG_ARCH_ENABLE_THP_MIGRATION
  1403			/* PMD-mapped THP migration entry */
  1404			if (!pvmw.pte && (flags & TTU_MIGRATION)) {
  1405				VM_BUG_ON_PAGE(PageHuge(page) || !PageTransCompound(page), page);
  1406	
  1407				set_pmd_migration_entry(&pvmw, page);
  1408				continue;
  1409			}
  1410	#endif
  1411	
  1412			/*
  1413			 * If the page is mlock()d, we cannot swap it out.
  1414			 * If it's recently referenced (perhaps page_referenced
  1415			 * skipped over this mm) then we should reactivate it.
  1416			 */
  1417			if (!(flags & TTU_IGNORE_MLOCK)) {
  1418				if (vma->vm_flags & VM_LOCKED) {
  1419					/* PTE-mapped THP are never mlocked */
  1420					if (!PageTransCompound(page)) {
  1421						/*
  1422						 * Holding pte lock, we do *not* need
  1423						 * mmap_sem here
  1424						 */
  1425						mlock_vma_page(page);
  1426					}
  1427					ret = false;
  1428					page_vma_mapped_walk_done(&pvmw);
  1429					break;
  1430				}
  1431				if (flags & TTU_MUNLOCK)
  1432					continue;
  1433			}
  1434	
  1435			/* Unexpected PMD-mapped THP? */
  1436			VM_BUG_ON_PAGE(!pvmw.pte, page);
  1437	
  1438			subpage = page - page_to_pfn(page) + pte_pfn(*pvmw.pte);
  1439			address = pvmw.address;
  1440	
  1441			if (PageHuge(page)) {
  1442				if (huge_pmd_unshare(mm, &address, pvmw.pte)) {
  1443					/*
  1444					 * huge_pmd_unshare unmapped an entire PMD
  1445					 * page.  There is no way of knowing exactly
  1446					 * which PMDs may be cached for this mm, so
  1447					 * we must flush them all.  start/end were
  1448					 * already adjusted above to cover this range.
  1449					 */
  1450					flush_cache_range(vma, range.start, range.end);
  1451					flush_tlb_range(vma, range.start, range.end);
  1452					mmu_notifier_invalidate_range(mm, range.start,
  1453								      range.end);
  1454	
  1455					/*
  1456					 * The ref count of the PMD page was dropped
  1457					 * which is part of the way map counting
  1458					 * is done for shared PMDs.  Return 'true'
  1459					 * here.  When there is no other sharing,
  1460					 * huge_pmd_unshare returns false and we will
  1461					 * unmap the actual page and drop map count
  1462					 * to zero.
  1463					 */
  1464					page_vma_mapped_walk_done(&pvmw);
  1465					break;
  1466				}
  1467			}
  1468	
  1469			if (IS_ENABLED(CONFIG_MIGRATION) &&
  1470			    (flags & TTU_MIGRATION) &&
  1471			    is_zone_device_page(page)) {
  1472				swp_entry_t entry;
  1473				pte_t swp_pte;
  1474	
  1475				pteval = ptep_get_and_clear(mm, pvmw.address, pvmw.pte);
  1476	
  1477				/*
  1478				 * Store the pfn of the page in a special migration
  1479				 * pte. do_swap_page() will wait until the migration
  1480				 * pte is removed and then restart fault handling.
  1481				 */
  1482				entry = make_migration_entry(page, 0);
  1483				swp_pte = swp_entry_to_pte(entry);
  1484				if (pte_soft_dirty(pteval))
  1485					swp_pte = pte_swp_mksoft_dirty(swp_pte);
  1486				set_pte_at(mm, pvmw.address, pvmw.pte, swp_pte);
  1487				/*
  1488				 * No need to invalidate here it will synchronize on
  1489				 * against the special swap migration pte.
  1490				 *
  1491				 * The assignment to subpage above was computed from a
  1492				 * swap PTE which results in an invalid pointer.
  1493				 * Since only PAGE_SIZE pages can currently be
  1494				 * migrated, just set it to page. This will need to be
  1495				 * changed when hugepage migrations to device private
  1496				 * memory are supported.
  1497				 */
  1498				subpage = page;
  1499				goto discard;
  1500			}
  1501	
  1502			if (!(flags & TTU_IGNORE_ACCESS)) {
  1503				if (ptep_clear_flush_young_notify(vma, address,
  1504							pvmw.pte)) {
  1505					ret = false;
  1506					page_vma_mapped_walk_done(&pvmw);
  1507					break;
  1508				}
  1509			}
  1510	
  1511			/* Nuke the page table entry. */
  1512			flush_cache_page(vma, address, pte_pfn(*pvmw.pte));
  1513			if (should_defer_flush(mm, flags)) {
  1514				/*
  1515				 * We clear the PTE but do not flush so potentially
  1516				 * a remote CPU could still be writing to the page.
  1517				 * If the entry was previously clean then the
  1518				 * architecture must guarantee that a clear->dirty
  1519				 * transition on a cached TLB entry is written through
  1520				 * and traps if the PTE is unmapped.
  1521				 */
  1522				pteval = ptep_get_and_clear(mm, address, pvmw.pte);
  1523	
  1524				set_tlb_ubc_flush_pending(mm, pte_dirty(pteval));
  1525			} else {
  1526				pteval = ptep_clear_flush(vma, address, pvmw.pte);
  1527			}
  1528	
  1529			/* Move the dirty bit to the page. Now the pte is gone. */
  1530			if (pte_dirty(pteval))
  1531				set_page_dirty(page);
  1532	
  1533			/* Update high watermark before we lower rss */
  1534			update_hiwater_rss(mm);
  1535	
  1536			if (PageHWPoison(page) && !(flags & TTU_IGNORE_HWPOISON)) {
  1537				pteval = swp_entry_to_pte(make_hwpoison_entry(subpage));
  1538				if (PageHuge(page)) {
  1539					hugetlb_count_sub(compound_nr(page), mm);
  1540					set_huge_swap_pte_at(mm, address,
  1541							     pvmw.pte, pteval,
  1542							     vma_mmu_pagesize(vma));
  1543				} else {
  1544					dec_mm_counter(mm, mm_counter(page));
  1545					set_pte_at(mm, address, pvmw.pte, pteval);
  1546				}
  1547	
  1548			} else if (pte_unused(pteval) && !userfaultfd_armed(vma)) {
  1549				/*
  1550				 * The guest indicated that the page content is of no
  1551				 * interest anymore. Simply discard the pte, vmscan
  1552				 * will take care of the rest.
  1553				 * A future reference will then fault in a new zero
  1554				 * page. When userfaultfd is active, we must not drop
  1555				 * this page though, as its main user (postcopy
  1556				 * migration) will not expect userfaults on already
  1557				 * copied pages.
  1558				 */
  1559				dec_mm_counter(mm, mm_counter(page));
  1560				/* We have to invalidate as we cleared the pte */
  1561				mmu_notifier_invalidate_range(mm, address,
  1562							      address + PAGE_SIZE);
  1563			} else if (IS_ENABLED(CONFIG_MIGRATION) &&
  1564					(flags & (TTU_MIGRATION|TTU_SPLIT_FREEZE))) {
  1565				swp_entry_t entry;
  1566				pte_t swp_pte;
  1567	
  1568				if (arch_unmap_one(mm, vma, address, pteval) < 0) {
  1569					set_pte_at(mm, address, pvmw.pte, pteval);
  1570					ret = false;
  1571					page_vma_mapped_walk_done(&pvmw);
  1572					break;
  1573				}
  1574	
  1575				/*
  1576				 * Store the pfn of the page in a special migration
  1577				 * pte. do_swap_page() will wait until the migration
  1578				 * pte is removed and then restart fault handling.
  1579				 */
  1580				entry = make_migration_entry(subpage,
  1581						pte_write(pteval));
  1582				swp_pte = swp_entry_to_pte(entry);
  1583				if (pte_soft_dirty(pteval))
  1584					swp_pte = pte_swp_mksoft_dirty(swp_pte);
  1585				set_pte_at(mm, address, pvmw.pte, swp_pte);
  1586				/*
  1587				 * No need to invalidate here it will synchronize on
  1588				 * against the special swap migration pte.
  1589				 */
  1590			} else if (PageAnon(page)) {
  1591				swp_entry_t entry = { .val = page_private(subpage) };
  1592				pte_t swp_pte;
  1593				/*
  1594				 * Store the swap location in the pte.
  1595				 * See handle_pte_fault() ...
  1596				 */
  1597				if (unlikely(PageSwapBacked(page) != PageSwapCache(page))) {
  1598					WARN_ON_ONCE(1);
  1599					ret = false;
  1600					/* We have to invalidate as we cleared the pte */
  1601					mmu_notifier_invalidate_range(mm, address,
  1602								address + PAGE_SIZE);
  1603					page_vma_mapped_walk_done(&pvmw);
  1604					break;
  1605				}
  1606	
  1607				/* MADV_FREE page check */
  1608				if (!PageSwapBacked(page)) {
  1609					if (!PageDirty(page)) {
  1610						/* Invalidate as we cleared the pte */
  1611						mmu_notifier_invalidate_range(mm,
  1612							address, address + PAGE_SIZE);
  1613						dec_mm_counter(mm, MM_ANONPAGES);
  1614						goto discard;
  1615					}
  1616	
  1617					/*
  1618					 * If the page was redirtied, it cannot be
  1619					 * discarded. Remap the page to page table.
  1620					 */
  1621					set_pte_at(mm, address, pvmw.pte, pteval);
  1622					SetPageSwapBacked(page);
  1623					ret = false;
  1624					page_vma_mapped_walk_done(&pvmw);
  1625					break;
  1626				}
  1627	
  1628				if (swap_duplicate(entry) < 0) {
  1629					set_pte_at(mm, address, pvmw.pte, pteval);
  1630					ret = false;
  1631					page_vma_mapped_walk_done(&pvmw);
  1632					break;
  1633				}
  1634				if (arch_unmap_one(mm, vma, address, pteval) < 0) {
  1635					set_pte_at(mm, address, pvmw.pte, pteval);
  1636					ret = false;
  1637					page_vma_mapped_walk_done(&pvmw);
  1638					break;
  1639				}
  1640				if (list_empty(&mm->mmlist)) {
  1641					spin_lock(&mmlist_lock);
  1642					if (list_empty(&mm->mmlist))
  1643						list_add(&mm->mmlist, &init_mm.mmlist);
  1644					spin_unlock(&mmlist_lock);
  1645				}
  1646				dec_mm_counter(mm, MM_ANONPAGES);
  1647				inc_mm_counter(mm, MM_SWAPENTS);
  1648				swp_pte = swp_entry_to_pte(entry);
  1649				if (pte_soft_dirty(pteval))
  1650					swp_pte = pte_swp_mksoft_dirty(swp_pte);
  1651				set_pte_at(mm, address, pvmw.pte, swp_pte);
  1652				/* Invalidate as we cleared the pte */
  1653				mmu_notifier_invalidate_range(mm, address,
  1654							      address + PAGE_SIZE);
  1655			} else {
  1656				/*
  1657				 * This is a locked file-backed page, thus it cannot
  1658				 * be removed from the page cache and replaced by a new
  1659				 * page before mmu_notifier_invalidate_range_end, so no
  1660				 * concurrent thread might update its page table to
  1661				 * point at new page while a device still is using this
  1662				 * page.
  1663				 *
  1664				 * See Documentation/vm/mmu_notifier.rst
  1665				 */
  1666				dec_mm_counter(mm, mm_counter_file(page));
  1667			}
  1668	discard:
  1669			/*
  1670			 * No need to call mmu_notifier_invalidate_range() it has be
  1671			 * done above for all cases requiring it to happen under page
  1672			 * table lock before mmu_notifier_invalidate_range_end()
  1673			 *
  1674			 * See Documentation/vm/mmu_notifier.rst
  1675			 */
  1676			page_remove_rmap(subpage, PageHuge(page));
  1677			put_page(page);
  1678		}
  1679	
  1680		mmu_notifier_invalidate_range_end(&range);
  1681	
  1682		return ret;
  1683	}
  1684	

---
0-DAY kernel test infrastructure                 Open Source Technology Center
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org Intel Corporation

--h4m5at7nxyv73coq
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--h4m5at7nxyv73coq--
