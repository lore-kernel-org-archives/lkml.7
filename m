Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 774B2C3F68F
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 21:12:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46095214D8
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 21:12:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="j7DF/qI0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730097AbgAGVMn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 16:12:43 -0500
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:5726 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729971AbgAGVMl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 16:12:41 -0500
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e14f4180001>; Tue, 07 Jan 2020 13:11:52 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Tue, 07 Jan 2020 13:12:40 -0800
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Tue, 07 Jan 2020 13:12:40 -0800
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 7 Jan
 2020 21:12:39 +0000
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 7 Jan
 2020 21:12:34 +0000
Received: from hqnvemgw03.nvidia.com (10.124.88.68) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Tue, 7 Jan 2020 21:12:34 +0000
Received: from rcampbell-dev.nvidia.com (Not Verified[10.110.48.66]) by hqnvemgw03.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5e14f4420000>; Tue, 07 Jan 2020 13:12:34 -0800
From:   Ralph Campbell <rcampbell@nvidia.com>
To:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
CC:     Jerome Glisse <jglisse@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Christoph Hellwig <hch@lst.de>,
        Jason Gunthorpe <jgg@mellanox.com>,
        "Bharata B Rao" <bharata@linux.ibm.com>,
        Michal Hocko <mhocko@kernel.org>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        Ralph Campbell <rcampbell@nvidia.com>
Subject: [PATCH 2/3] mm/migrate: clean up some minor coding style
Date:   Tue, 7 Jan 2020 13:12:07 -0800
Message-ID: <20200107211208.24595-3-rcampbell@nvidia.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200107211208.24595-1-rcampbell@nvidia.com>
References: <20200107211208.24595-1-rcampbell@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1578431512; bh=Vf0pB4HI28cYBjSSN8IQi6KhcITbO0HdT1itBlPjKpc=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:MIME-Version:X-NVConfidentiality:
         Content-Transfer-Encoding:Content-Type;
        b=j7DF/qI0bLyHqreWhntBW27ogsmLI61KKNQu+VKL0KRazewwSqxh5grYYLUvVQSSm
         N5OYjpMoWyKtnudEEvsw1BlyXCKSnqia9cDJrh7V0/jImou9o5Ae+LD413AM87tCJo
         lhng9efMI7T2+USkd283mTRsJW69ybDu2GR9pEwabYF0WF7bAMCS9RzkqOQMDgTc3i
         6Sehl+mRITJXRVNOr6MgdRBxdBiEXrwf9H2E8l95O7kf8/H5GjzKEbmJSzM06aHJH7
         Ibj617sW8N7kZ7F2WeGPA08g74ucXK3p3Arf7S5PQjt6hNLYASqBdVc67P1+aZgQvR
         C8TIh2uxZ2vmQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix some comment typos and coding style clean up in preparation for the
next patch. No functional changes.

Signed-off-by: Ralph Campbell <rcampbell@nvidia.com>
---
 mm/migrate.c | 34 +++++++++++++---------------------
 1 file changed, 13 insertions(+), 21 deletions(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index b7f5d9ada429..4b1a6d69afb5 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -986,7 +986,7 @@ static int move_to_new_page(struct page *newpage, struc=
t page *page,
 		}
=20
 		/*
-		 * Anonymous and movable page->mapping will be cleard by
+		 * Anonymous and movable page->mapping will be cleared by
 		 * free_pages_prepare so don't reset it here for keeping
 		 * the type to work PageAnon, for example.
 		 */
@@ -1199,8 +1199,7 @@ static ICE_noinline int unmap_and_move(new_page_t get=
_new_page,
 		/*
 		 * A page that has been migrated has all references
 		 * removed and will be freed. A page that has not been
-		 * migrated will have kepts its references and be
-		 * restored.
+		 * migrated will have kept its references and be restored.
 		 */
 		list_del(&page->lru);
=20
@@ -2759,27 +2758,18 @@ static void migrate_vma_insert_page(struct migrate_=
vma *migrate,
 	if (pte_present(*ptep)) {
 		unsigned long pfn =3D pte_pfn(*ptep);
=20
-		if (!is_zero_pfn(pfn)) {
-			pte_unmap_unlock(ptep, ptl);
-			mem_cgroup_cancel_charge(page, memcg, false);
-			goto abort;
-		}
+		if (!is_zero_pfn(pfn))
+			goto unlock_abort;
 		flush =3D true;
-	} else if (!pte_none(*ptep)) {
-		pte_unmap_unlock(ptep, ptl);
-		mem_cgroup_cancel_charge(page, memcg, false);
-		goto abort;
-	}
+	} else if (!pte_none(*ptep))
+		goto unlock_abort;
=20
 	/*
-	 * Check for usefaultfd but do not deliver the fault. Instead,
+	 * Check for userfaultfd but do not deliver the fault. Instead,
 	 * just back off.
 	 */
-	if (userfaultfd_missing(vma)) {
-		pte_unmap_unlock(ptep, ptl);
-		mem_cgroup_cancel_charge(page, memcg, false);
-		goto abort;
-	}
+	if (userfaultfd_missing(vma))
+		goto unlock_abort;
=20
 	inc_mm_counter(mm, MM_ANONPAGES);
 	page_add_new_anon_rmap(page, vma, addr, false);
@@ -2803,6 +2793,9 @@ static void migrate_vma_insert_page(struct migrate_vm=
a *migrate,
 	*src =3D MIGRATE_PFN_MIGRATE;
 	return;
=20
+unlock_abort:
+	pte_unmap_unlock(ptep, ptl);
+	mem_cgroup_cancel_charge(page, memcg, false);
 abort:
 	*src &=3D ~MIGRATE_PFN_MIGRATE;
 }
@@ -2835,9 +2828,8 @@ void migrate_vma_pages(struct migrate_vma *migrate)
 		}
=20
 		if (!page) {
-			if (!(migrate->src[i] & MIGRATE_PFN_MIGRATE)) {
+			if (!(migrate->src[i] & MIGRATE_PFN_MIGRATE))
 				continue;
-			}
 			if (!notified) {
 				notified =3D true;
=20
--=20
2.20.1

