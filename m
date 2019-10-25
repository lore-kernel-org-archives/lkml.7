Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EDD0CA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 20:26:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FF5721D81
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 20:26:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728437AbfJYU0p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 16:26:45 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:19870 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728400AbfJYU0p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 16:26:45 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x9PKQi3o099451
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2019 16:26:44 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2vv59cn4d8-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2019 16:26:43 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <rppt@linux.ibm.com>;
        Fri, 25 Oct 2019 21:26:41 +0100
Received: from b06avi18878370.portsmouth.uk.ibm.com (9.149.26.194)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 25 Oct 2019 21:26:38 +0100
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x9PKQbYV43057426
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Oct 2019 20:26:38 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DF2C511C050;
        Fri, 25 Oct 2019 20:26:37 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 446F611C052;
        Fri, 25 Oct 2019 20:26:37 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.148.205.37])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Fri, 25 Oct 2019 20:26:37 +0000 (GMT)
Date:   Fri, 25 Oct 2019 23:26:35 +0300
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     Chris Packham <chris.packham@alliedtelesis.co.nz>
Cc:     corbet@lwn.net, willy@infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/3] docs/core-api: memory-allocation: remove uses of
 c:func:
References: <20191024195016.11054-1-chris.packham@alliedtelesis.co.nz>
 <20191024195016.11054-3-chris.packham@alliedtelesis.co.nz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191024195016.11054-3-chris.packham@alliedtelesis.co.nz>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-GCONF: 00
x-cbid: 19102520-0016-0000-0000-000002BDA562
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19102520-0017-0000-0000-0000331EF0B4
Message-Id: <20191025202634.GD8710@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-10-25_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1910250187
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 25, 2019 at 08:50:15AM +1300, Chris Packham wrote:
> These are no longer needed as the documentation build will automatically
> add the cross references.
> 
> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
> ---
> 
> Notes:
>     It should be noted that kvmalloc() and kmem_cache_destroy() lack a
>     kerneldoc header, a side-effect of this change is that the :c:func:
>     fallback of making them bold is lost. This is probably best fixed by
>     adding a kerneldoc header to their source.

You are more than welcome to add them ;-)
     
>     Changes in v2:
>     - new
> 
>  Documentation/core-api/memory-allocation.rst | 49 +++++++++-----------
>  1 file changed, 23 insertions(+), 26 deletions(-)
> 
> diff --git a/Documentation/core-api/memory-allocation.rst b/Documentation/core-api/memory-allocation.rst
> index dcf851b4520f..e47d48655085 100644
> --- a/Documentation/core-api/memory-allocation.rst
> +++ b/Documentation/core-api/memory-allocation.rst
> @@ -88,10 +88,10 @@ Selecting memory allocator
>  ==========================
>  
>  The most straightforward way to allocate memory is to use a function
> -from the :c:func:`kmalloc` family. And, to be on the safe side it's
> -best to use routines that set memory to zero, like
> -:c:func:`kzalloc`. If you need to allocate memory for an array, there
> -are :c:func:`kmalloc_array` and :c:func:`kcalloc` helpers.
> +from the kmalloc() family. And, to be on the safe side it's best to use
> +routines that set memory to zero, like kzalloc(). If you need to
> +allocate memory for an array, there are kmalloc_array() and kcalloc()
> +helpers.
>  
>  The maximal size of a chunk that can be allocated with `kmalloc` is
>  limited. The actual limit depends on the hardware and the kernel
> @@ -102,29 +102,26 @@ The address of a chunk allocated with `kmalloc` is aligned to at least
>  ARCH_KMALLOC_MINALIGN bytes.  For sizes which are a power of two, the
>  alignment is also guaranteed to be at least the respective size.
>  
> -For large allocations you can use :c:func:`vmalloc` and
> -:c:func:`vzalloc`, or directly request pages from the page
> -allocator. The memory allocated by `vmalloc` and related functions is
> -not physically contiguous.
> +For large allocations you can use vmalloc() and vzalloc(), or directly
> +request pages from the page allocator. The memory allocated by `vmalloc`
> +and related functions is not physically contiguous.
>  
>  If you are not sure whether the allocation size is too large for
> -`kmalloc`, it is possible to use :c:func:`kvmalloc` and its
> -derivatives. It will try to allocate memory with `kmalloc` and if the
> -allocation fails it will be retried with `vmalloc`. There are
> -restrictions on which GFP flags can be used with `kvmalloc`; please
> -see :c:func:`kvmalloc_node` reference documentation. Note that
> -`kvmalloc` may return memory that is not physically contiguous.
> +`kmalloc`, it is possible to use kvmalloc() and its derivatives. It will
> +try to allocate memory with `kmalloc` and if the allocation fails it
> +will be retried with `vmalloc`. There are restrictions on which GFP
> +flags can be used with `kvmalloc`; please see kvmalloc_node() reference
> +documentation. Note that `kvmalloc` may return memory that is not
> +physically contiguous.
>  
>  If you need to allocate many identical objects you can use the slab
> -cache allocator. The cache should be set up with
> -:c:func:`kmem_cache_create` or :c:func:`kmem_cache_create_usercopy`
> -before it can be used. The second function should be used if a part of
> -the cache might be copied to the userspace.  After the cache is
> -created :c:func:`kmem_cache_alloc` and its convenience wrappers can
> -allocate memory from that cache.
> -
> -When the allocated memory is no longer needed it must be freed. You
> -can use :c:func:`kvfree` for the memory allocated with `kmalloc`,
> -`vmalloc` and `kvmalloc`. The slab caches should be freed with
> -:c:func:`kmem_cache_free`. And don't forget to destroy the cache with
> -:c:func:`kmem_cache_destroy`.
> +cache allocator. The cache should be set up with kmem_cache_create() or
> +kmem_cache_create_usercopy() before it can be used. The second function
> +should be used if a part of the cache might be copied to the userspace.
> +After the cache is created kmem_cache_alloc() and its convenience
> +wrappers can allocate memory from that cache.
> +
> +When the allocated memory is no longer needed it must be freed. You can
> +use kvfree() for the memory allocated with `kmalloc`, `vmalloc` and
> +`kvmalloc`. The slab caches should be freed with kmem_cache_free(). And
> +don't forget to destroy the cache with kmem_cache_destroy().
> -- 
> 2.23.0
> 

-- 
Sincerely yours,
Mike.

