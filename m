Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 573B1CA9EA0
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 21:14:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F74B20B7C
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 21:14:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="tRhao/z9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732653AbfJVVOx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 17:14:53 -0400
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:55694 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731585AbfJVVOw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 17:14:52 -0400
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id A6D0D886BF;
        Wed, 23 Oct 2019 10:14:46 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1571778886;
        bh=cHGy9gkvHsdoch+q0GVyNly2OTiia7z5Wk+Y8tgUOno=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=tRhao/z9Z/e6JBVs0dqM+M4/Ir7JrQOEDQ8+0VO6AjmMxVEy6X8iH2Op77DN/v+Z/
         znjMJZFJiltiyoaIvu/QqGGod2haRJ46tzBZI+ujD6JmRgYEpxRbxHfRjvlhOXq2tJ
         odwVlgQHCHbjbGj1HL9grAENbE6U5llRqN0rgikc9Xou8yA5l2WpTD+1lC11LMBwGb
         qhBBUOHf8cYsZxmgLOIvPolMGGVYol39VpaO9tIImwJedh96aOBYfnXAbYuKtdVrxu
         w8kP0NJ4cRu5bwv5W2TLhght3W9NSXd8ZY8zcTaeY68R3/GXEiINx7dh2LyYXaYXWk
         hu/vqudPJFUzQ==
Received: from smtp (Not Verified[10.32.16.33]) by mmarshal3.atlnz.lc with Trustwave SEG (v7,5,8,10121)
        id <B5daf71460001>; Wed, 23 Oct 2019 10:14:46 +1300
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.20])
        by smtp (Postfix) with ESMTP id 699A813EED4;
        Wed, 23 Oct 2019 10:14:50 +1300 (NZDT)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
        id 40884280059; Wed, 23 Oct 2019 10:14:46 +1300 (NZDT)
From:   Chris Packham <chris.packham@alliedtelesis.co.nz>
To:     corbet@lwn.net
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH v2 1/2] docs/core-api: memory-allocation: remove uses of c:func:
Date:   Wed, 23 Oct 2019 10:14:37 +1300
Message-Id: <20191022211438.3938-2-chris.packham@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191022211438.3938-1-chris.packham@alliedtelesis.co.nz>
References: <20191022211438.3938-1-chris.packham@alliedtelesis.co.nz>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
x-atlnz-ls: pat
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These are no longer needed as the documentation build will automatically
add the cross references.

Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
---

Notes:
    It should be noted that kvmalloc() and kmem_cache_destroy() lack a
    kerneldoc header, a side-effect of this change is that the :c:func:
    fallback of making them bold is lost. This is probably best fixed by
    adding a kerneldoc header to their source.
   =20
    Changes in v2:
    - new

 Documentation/core-api/memory-allocation.rst | 49 +++++++++-----------
 1 file changed, 23 insertions(+), 26 deletions(-)

diff --git a/Documentation/core-api/memory-allocation.rst b/Documentation=
/core-api/memory-allocation.rst
index e59779aa7615..14e22accdee7 100644
--- a/Documentation/core-api/memory-allocation.rst
+++ b/Documentation/core-api/memory-allocation.rst
@@ -88,39 +88,36 @@ Selecting memory allocator
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
=20
 The most straightforward way to allocate memory is to use a function
-from the :c:func:`kmalloc` family. And, to be on the safe side it's
-best to use routines that set memory to zero, like
-:c:func:`kzalloc`. If you need to allocate memory for an array, there
-are :c:func:`kmalloc_array` and :c:func:`kcalloc` helpers.
+from the kmalloc() family. And, to be on the safe side it's best to use
+routines that set memory to zero, like kzalloc(). If you need to
+allocate memory for an array, there are kmalloc_array() and kcalloc()
+helpers.
=20
 The maximal size of a chunk that can be allocated with `kmalloc` is
 limited. The actual limit depends on the hardware and the kernel
 configuration, but it is a good practice to use `kmalloc` for objects
 smaller than page size.
=20
-For large allocations you can use :c:func:`vmalloc` and
-:c:func:`vzalloc`, or directly request pages from the page
-allocator. The memory allocated by `vmalloc` and related functions is
-not physically contiguous.
+For large allocations you can use vmalloc() and vzalloc(), or directly
+request pages from the page allocator. The memory allocated by `vmalloc`
+and related functions is not physically contiguous.
=20
 If you are not sure whether the allocation size is too large for
-`kmalloc`, it is possible to use :c:func:`kvmalloc` and its
-derivatives. It will try to allocate memory with `kmalloc` and if the
-allocation fails it will be retried with `vmalloc`. There are
-restrictions on which GFP flags can be used with `kvmalloc`; please
-see :c:func:`kvmalloc_node` reference documentation. Note that
-`kvmalloc` may return memory that is not physically contiguous.
+`kmalloc`, it is possible to use kvmalloc() and its derivatives. It will
+try to allocate memory with `kmalloc` and if the allocation fails it
+will be retried with `vmalloc`. There are restrictions on which GFP
+flags can be used with `kvmalloc`; please see kvmalloc_node() reference
+documentation. Note that `kvmalloc` may return memory that is not
+physically contiguous.
=20
 If you need to allocate many identical objects you can use the slab
-cache allocator. The cache should be set up with
-:c:func:`kmem_cache_create` or :c:func:`kmem_cache_create_usercopy`
-before it can be used. The second function should be used if a part of
-the cache might be copied to the userspace.  After the cache is
-created :c:func:`kmem_cache_alloc` and its convenience wrappers can
-allocate memory from that cache.
-
-When the allocated memory is no longer needed it must be freed. You
-can use :c:func:`kvfree` for the memory allocated with `kmalloc`,
-`vmalloc` and `kvmalloc`. The slab caches should be freed with
-:c:func:`kmem_cache_free`. And don't forget to destroy the cache with
-:c:func:`kmem_cache_destroy`.
+cache allocator. The cache should be set up with kmem_cache_create() or
+kmem_cache_create_usercopy() before it can be used. The second function
+should be used if a part of the cache might be copied to the userspace.
+After the cache is created kmem_cache_alloc() and its convenience
+wrappers can allocate memory from that cache.
+
+When the allocated memory is no longer needed it must be freed. You can
+use kvfree() for the memory allocated with `kmalloc`, `vmalloc` and
+`kvmalloc`. The slab caches should be freed with kmem_cache_free(). And
+don't forget to destroy the cache with kmem_cache_destroy().
--=20
2.23.0

