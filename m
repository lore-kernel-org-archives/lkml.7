Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B24F1C48BE9
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 10:49:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B1C920674
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 10:49:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="FYRfER6l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729385AbfFXKtP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 06:49:15 -0400
Received: from ozlabs.org ([203.11.71.1]:58643 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726960AbfFXKtP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 06:49:15 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45XQyZ6Kbzz9s4Y;
        Mon, 24 Jun 2019 20:49:10 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1561373352;
        bh=KPlgWvFZiDZ5hy8Bt/xNt0/hF2ihC/57SqKILC0Tmxc=;
        h=Date:From:To:Cc:Subject:From;
        b=FYRfER6lqUeB9CRm57EPLNuxXAV98Neh00396z86XrwwId6ZQYeyl63JMwkVs9B2K
         EPwKyYlcFZFJTez0F1jDIm4fKifcyHsR4eRv6OA2Mz/svUZR/OwbDX6jPiv8gbLeH1
         /+4axwQKJiWEJNhOCvX8m5RTQ9sISzEyN4c2ItusanqRT9FXXMYvLiZvuFUL8I9Amk
         65Q7Okb9AtktgqM5orXDGJPiFWikrtZ0GCC0Fn19pl7/lhfhfzdIk3SzAGfJgn69cQ
         Ii+4xL+P/6sv6pPVkYM2uXPkYjr36NX8a0PZPP56bycLzcq9WOnvD3vkC9b4FWom4R
         V1CGPBNSTpG4A==
Date:   Mon, 24 Jun 2019 20:49:08 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Dave Airlie <airlied@linux.ie>,
        DRI <dri-devel@lists.freedesktop.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Hellstrom <thellstrom@vmware.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>
Subject: linux-next: manual merge of the akpm-current tree with the drm tree
Message-ID: <20190624204908.64a33862@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/smpkyf3iKW.KYSxeqEWRcnh"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/smpkyf3iKW.KYSxeqEWRcnh
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the akpm-current tree got a conflict in:

  mm/memory.c

between commit:

  29875a52915e ("mm: Add an apply_to_pfn_range interface")

from the drm tree and commit:

  e972cea08fb3 ("mm/pgtable: drop pgtable_t variable from pte_fn_t function=
s")

from the akpm-current tree.

I fixed it up (see below my signature, then added the following merge
resolution patch as well) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Mon, 24 Jun 2019 20:40:46 +1000
Subject: [PATCH] merge fixup for "mm: Add an apply_to_pfn_range interface"

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 include/linux/mm.h    | 2 +-
 mm/as_dirty_helpers.c | 8 ++------
 2 files changed, 3 insertions(+), 7 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 87d53de3dee4..4404e18443ef 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2673,7 +2673,7 @@ extern int apply_to_page_range(struct mm_struct *mm, =
unsigned long address,
 			       unsigned long size, pte_fn_t fn, void *data);
=20
 struct pfn_range_apply;
-typedef int (*pter_fn_t)(pte_t *pte, pgtable_t token, unsigned long addr,
+typedef int (*pter_fn_t)(pte_t *pte, unsigned long addr,
 			 struct pfn_range_apply *closure);
 struct pfn_range_apply {
 	struct mm_struct *mm;
diff --git a/mm/as_dirty_helpers.c b/mm/as_dirty_helpers.c
index f600e31534fb..7c863626c2a4 100644
--- a/mm/as_dirty_helpers.c
+++ b/mm/as_dirty_helpers.c
@@ -26,7 +26,6 @@ struct apply_as {
 /**
  * apply_pt_wrprotect - Leaf pte callback to write-protect a pte
  * @pte: Pointer to the pte
- * @token: Page table token, see apply_to_pfn_range()
  * @addr: The virtual page address
  * @closure: Pointer to a struct pfn_range_apply embedded in a
  * struct apply_as
@@ -36,8 +35,7 @@ struct apply_as {
  *
  * Return: Always zero.
  */
-static int apply_pt_wrprotect(pte_t *pte, pgtable_t token,
-			      unsigned long addr,
+static int apply_pt_wrprotect(pte_t *pte, unsigned long addr,
 			      struct pfn_range_apply *closure)
 {
 	struct apply_as *aas =3D container_of(closure, typeof(*aas), base);
@@ -78,7 +76,6 @@ struct apply_as_clean {
 /**
  * apply_pt_clean - Leaf pte callback to clean a pte
  * @pte: Pointer to the pte
- * @token: Page table token, see apply_to_pfn_range()
  * @addr: The virtual page address
  * @closure: Pointer to a struct pfn_range_apply embedded in a
  * struct apply_as_clean
@@ -91,8 +88,7 @@ struct apply_as_clean {
  *
  * Return: Always zero.
  */
-static int apply_pt_clean(pte_t *pte, pgtable_t token,
-			  unsigned long addr,
+static int apply_pt_clean(pte_t *pte, unsigned long addr,
 			  struct pfn_range_apply *closure)
 {
 	struct apply_as *aas =3D container_of(closure, typeof(*aas), base);
--=20
2.20.1

--=20
Cheers,
Stephen Rothwell

diff --cc mm/memory.c
index 462aa47f8878,f8a75528658a..e7e37fcbd687
--- a/mm/memory.c
+++ b/mm/memory.c
@@@ -2037,12 -2036,11 +2035,11 @@@ static int apply_to_pte_range(struct pf
  {
  	pte_t *pte;
  	int err;
- 	pgtable_t token;
  	spinlock_t *uninitialized_var(ptl);
 =20
 -	pte =3D (mm =3D=3D &init_mm) ?
 +	pte =3D (closure->mm =3D=3D &init_mm) ?
  		pte_alloc_kernel(pmd, addr) :
 -		pte_alloc_map_lock(mm, pmd, addr, &ptl);
 +		pte_alloc_map_lock(closure->mm, pmd, addr, &ptl);
  	if (!pte)
  		return -ENOMEM;
 =20
@@@ -2050,10 -2048,8 +2047,8 @@@
 =20
  	arch_enter_lazy_mmu_mode();
 =20
- 	token =3D pmd_pgtable(*pmd);
-=20
  	do {
- 		err =3D closure->ptefn(pte++, token, addr, closure);
 -		err =3D fn(pte++, addr, data);
++		err =3D closure->ptefn(pte++, addr, closure);
  		if (err)
  			break;
  	} while (addr +=3D PAGE_SIZE, addr !=3D end);

--Sig_/smpkyf3iKW.KYSxeqEWRcnh
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl0QqqQACgkQAVBC80lX
0Gy/HggAlUflCFAigIJCuwLXm9046cFZXhb3qCiDEGTFMH4jS/XFDxZ8TuO26F2t
KKQU5tJbR9JD1OiU0Wop4WrpudTLPM10Tk9U1ppYQSrHUYU3cvE/bNrB+Ca5JqQ3
9Gy6CnxMA7Uh7x9KhdeOdrYrbLVoR2rqsgmEdbssTG46mQG9G3C7by+hj0zHh9IY
i75/DBJbCnIy+RRMYXyLR8cYhER32z81nlJhJBlZILn/KLbfXV8/ABji8hzEeOCE
QKuDhJnyNp/cqoi4Eq6eEf+JJAWPqQT3VOA+TW87maDcOqadurFG6JBrV5ligshz
VqMZYeF8H/SayiEwmLFL1+yGiKP8aw==
=nei6
-----END PGP SIGNATURE-----

--Sig_/smpkyf3iKW.KYSxeqEWRcnh--
