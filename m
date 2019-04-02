Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FF06C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 13:42:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E503E2133D
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 13:42:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731866AbfDBNmm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 09:42:42 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:43674 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731522AbfDBNkM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 09:40:12 -0400
Received: from [167.98.27.226] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1hBJe4-0002oX-6A; Tue, 02 Apr 2019 14:40:08 +0100
Received: from ben by deadeye with local (Exim 4.92)
        (envelope-from <ben@decadent.org.uk>)
        id 1hBJdx-0004xP-Ss; Tue, 02 Apr 2019 14:40:01 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "Hugh Dickins" <hughd@google.com>,
        "KOSAKI Motohiro" <kosaki.motohiro@jp.fujitsu.com>,
        "Sasha Levin" <sasha.levin@oracle.com>,
        "Davidlohr Bueso" <dave@stgolabs.net>,
        "Dmitry Vyukov" <dvyukov@google.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        "Oleg Nesterov" <oleg@redhat.com>,
        "Rik van Riel" <riel@redhat.com>,
        "Linus Torvalds" <torvalds@linux-foundation.org>,
        "Vlastimil Babka" <vbabka@suse.cz>,
        "Christoph Lameter" <cl@linux.com>
Date:   Tue, 02 Apr 2019 14:38:28 +0100
Message-ID: <lsq.1554212308.726639264@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 86/99] mm Documentation: undoc non-linear vmas
In-Reply-To: <lsq.1554212307.17110877@decadent.org.uk>
X-SA-Exim-Connect-IP: 167.98.27.226
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.65-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Hugh Dickins <hughd@google.com>

commit 7a14239a8fff45a241b6943a3ac444d5b67fcbed upstream.

While updating some mm Documentation, I came across a few straggling
references to the non-linear vmas which were happily removed in v4.0.
Delete them.

Signed-off-by: Hugh Dickins <hughd@google.com>
Cc: Christoph Lameter <cl@linux.com>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Rik van Riel <riel@redhat.com>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
Cc: Davidlohr Bueso <dave@stgolabs.net>
Cc: Oleg Nesterov <oleg@redhat.com>
Cc: Sasha Levin <sasha.levin@oracle.com>
Cc: Dmitry Vyukov <dvyukov@google.com>
Cc: KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
[bwh: Backported to 3.16 in preparation for commit 017b1660df89
 "mm: migration: fix migration of huge PMD shared pages"]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 Documentation/filesystems/proc.txt   |  1 -
 Documentation/vm/page_migration      | 10 ++---
 Documentation/vm/unevictable-lru.txt | 63 +++-------------------------
 3 files changed, 9 insertions(+), 65 deletions(-)

--- a/Documentation/filesystems/proc.txt
+++ b/Documentation/filesystems/proc.txt
@@ -429,7 +429,6 @@ manner. The codes are the following:
     ac  - area is accountable
     nr  - swap space is not reserved for the area
     ht  - area uses huge tlb pages
-    nl  - non-linear mapping
     ar  - architecture specific flag
     dd  - do not include area into core dump
     sd  - soft-dirty flag
--- a/Documentation/vm/page_migration
+++ b/Documentation/vm/page_migration
@@ -99,12 +99,10 @@ Steps:
 4. The new page is prepped with some settings from the old page so that
    accesses to the new page will discover a page with the correct settings.
 
-5. All the page table references to the page are converted
-   to migration entries or dropped (nonlinear vmas).
-   This decrease the mapcount of a page. If the resulting
-   mapcount is not zero then we do not migrate the page.
-   All user space processes that attempt to access the page
-   will now wait on the page lock.
+5. All the page table references to the page are converted to migration
+   entries. This decreases the mapcount of a page. If the resulting
+   mapcount is not zero then we do not migrate the page. All user space
+   processes that attempt to access the page will now wait on the page lock.
 
 6. The radix tree lock is taken. This will cause all processes trying
    to access the page via the mapping to block on the radix tree spinlock.
--- a/Documentation/vm/unevictable-lru.txt
+++ b/Documentation/vm/unevictable-lru.txt
@@ -544,63 +544,17 @@ different reverse map mechanisms.
      is really unevictable or not.  In this case, try_to_unmap_anon() will
      return SWAP_AGAIN.
 
- (*) try_to_unmap_file() - linear mappings
+ (*) try_to_unmap_file()
 
      Unmapping of a mapped file page works the same as for anonymous mappings,
      except that the scan visits all VMAs that map the page's index/page offset
-     in the page's mapping's reverse map priority search tree.  It also visits
-     each VMA in the page's mapping's non-linear list, if the list is
-     non-empty.
+     in the page's mapping's reverse map interval search tree.
 
      As for anonymous pages, on encountering a VM_LOCKED VMA for a mapped file
      page, try_to_unmap_file() will attempt to acquire the associated
      mm_struct's mmap semaphore to mlock the page, returning SWAP_MLOCK if this
      is successful, and SWAP_AGAIN, if not.
 
- (*) try_to_unmap_file() - non-linear mappings
-
-     If a page's mapping contains a non-empty non-linear mapping VMA list, then
-     try_to_un{map|lock}() must also visit each VMA in that list to determine
-     whether the page is mapped in a VM_LOCKED VMA.  Again, the scan must visit
-     all VMAs in the non-linear list to ensure that the pages is not/should not
-     be mlocked.
-
-     If a VM_LOCKED VMA is found in the list, the scan could terminate.
-     However, there is no easy way to determine whether the page is actually
-     mapped in a given VMA - either for unmapping or testing whether the
-     VM_LOCKED VMA actually pins the page.
-
-     try_to_unmap_file() handles non-linear mappings by scanning a certain
-     number of pages - a "cluster" - in each non-linear VMA associated with the
-     page's mapping, for each file mapped page that vmscan tries to unmap.  If
-     this happens to unmap the page we're trying to unmap, try_to_unmap() will
-     notice this on return (page_mapcount(page) will be 0) and return
-     SWAP_SUCCESS.  Otherwise, it will return SWAP_AGAIN, causing vmscan to
-     recirculate this page.  We take advantage of the cluster scan in
-     try_to_unmap_cluster() as follows:
-
-	For each non-linear VMA, try_to_unmap_cluster() attempts to acquire the
-	mmap semaphore of the associated mm_struct for read without blocking.
-
-	If this attempt is successful and the VMA is VM_LOCKED,
-	try_to_unmap_cluster() will retain the mmap semaphore for the scan;
-	otherwise it drops it here.
-
-	Then, for each page in the cluster, if we're holding the mmap semaphore
-	for a locked VMA, try_to_unmap_cluster() calls mlock_vma_page() to
-	mlock the page.  This call is a no-op if the page is already locked,
-	but will mlock any pages in the non-linear mapping that happen to be
-	unlocked.
-
-	If one of the pages so mlocked is the page passed in to try_to_unmap(),
-	try_to_unmap_cluster() will return SWAP_MLOCK, rather than the default
-	SWAP_AGAIN.  This will allow vmscan to cull the page, rather than
-	recirculating it on the inactive list.
-
-	Again, if try_to_unmap_cluster() cannot acquire the VMA's mmap sem, it
-	returns SWAP_AGAIN, indicating that the page is mapped by a VM_LOCKED
-	VMA, but couldn't be mlocked.
-
 
 try_to_munlock() REVERSE MAP SCAN
 ---------------------------------
@@ -617,10 +571,9 @@ introduced a variant of try_to_unmap() c
 try_to_munlock() calls the same functions as try_to_unmap() for anonymous and
 mapped file pages with an additional argument specifying unlock versus unmap
 processing.  Again, these functions walk the respective reverse maps looking
-for VM_LOCKED VMAs.  When such a VMA is found for anonymous pages and file
-pages mapped in linear VMAs, as in the try_to_unmap() case, the functions
-attempt to acquire the associated mmap semaphore, mlock the page via
-mlock_vma_page() and return SWAP_MLOCK.  This effectively undoes the
+for VM_LOCKED VMAs.  When such a VMA is found, as in the try_to_unmap() case,
+the functions attempt to acquire the associated mmap semaphore, mlock the page
+via mlock_vma_page() and return SWAP_MLOCK.  This effectively undoes the
 pre-clearing of the page's PG_mlocked done by munlock_vma_page.
 
 If try_to_unmap() is unable to acquire a VM_LOCKED VMA's associated mmap
@@ -628,12 +581,6 @@ semaphore, it will return SWAP_AGAIN.  T
 recycle the page on the inactive list and hope that it has better luck with the
 page next time.
 
-For file pages mapped into non-linear VMAs, the try_to_munlock() logic works
-slightly differently.  On encountering a VM_LOCKED non-linear VMA that might
-map the page, try_to_munlock() returns SWAP_AGAIN without actually mlocking the
-page.  munlock_vma_page() will just leave the page unlocked and let vmscan deal
-with it - the usual fallback position.
-
 Note that try_to_munlock()'s reverse map walk must visit every VMA in a page's
 reverse map to determine that a page is NOT mapped into any VM_LOCKED VMA.
 However, the scan can terminate when it encounters a VM_LOCKED VMA and can

