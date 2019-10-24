Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 822ECCA9EAF
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 17:40:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5947320650
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 17:40:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="anHytsPE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503896AbfJXRk0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 13:40:26 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:6176 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729458AbfJXRkZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 13:40:25 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5db1e20d0000>; Thu, 24 Oct 2019 10:40:29 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 24 Oct 2019 10:40:25 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 24 Oct 2019 10:40:25 -0700
Received: from DRHQMAIL107.nvidia.com (10.27.9.16) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 24 Oct
 2019 17:40:24 +0000
Received: from [10.110.48.28] (10.124.1.5) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 24 Oct
 2019 17:40:24 +0000
Subject: Re: [PATCH v2] mm: gup: fix comment of __get_user_pages()
To:     Liu Xiang <liuxiang_1999@126.com>, <linux-mm@kvack.org>
CC:     <linux-kernel@vger.kernel.org>
References: <1571929472-3091-1-git-send-email-liuxiang_1999@126.com>
X-Nvconfidentiality: public
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <91d727c8-d2d3-8498-d3ff-8032da9a055d@nvidia.com>
Date:   Thu, 24 Oct 2019 10:40:24 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1571929472-3091-1-git-send-email-liuxiang_1999@126.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 DRHQMAIL107.nvidia.com (10.27.9.16)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1571938829; bh=n7We2NgiNuh1YUglpKmrd+msDu/DGyBImzj+mPZ4P8A=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=anHytsPEY3EL2wS/3U/3lK9AYPqWUJqjQi5HFB1jA4FMRKp4/suPKiIJL6u0HnhlG
         Kr1L+nA2XiRPJRF6r7OLLvgxgS0DTr03CNKyvqgkJI5ZQxmZ75Wlnq5xA/+hVXeJ/d
         KEZ2nJopfe6SUsPt7ssx69XrRM5OJ2qtN17jOMLdw0kz9TiqfvQ4kNR/fVZ9Zi8gdT
         xqnKCGXksCa+Ugh75yi4mke/BfWoj7HSRo3buus09sFuTdbLKEbLqDNJjNQUdhkjBo
         97F4olg7tVtoHPCG9784gzZGpdSFhAmT3Q3UAPcOZLdHR6Nxwo8OZTPpevrWzhmptw
         ea7UkKY7eLotw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/24/19 8:04 AM, Liu Xiang wrote:
> Fix comment of __get_user_pages() and make it more clear.
> 
> Suggested-by: John Hubbard <jhubbard@nvidia.com>
> Signed-off-by: Liu Xiang <liuxiang_1999@126.com>
> ---
> 
> Changes in v2:
>  as suggested by John, rewrite the comment about return value.
> 
>  mm/gup.c | 16 +++++++++++-----
>  1 file changed, 11 insertions(+), 5 deletions(-)
> 

Reviewed-by: John Hubbard <jhubbard@nvidia.com>


thanks,
-- 
John Hubbard
NVIDIA

> diff --git a/mm/gup.c b/mm/gup.c
> index 8f236a3..bc6a254 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -734,11 +734,17 @@ static int check_vma_flags(struct vm_area_struct *vma, unsigned long gup_flags)
>   *		Or NULL if the caller does not require them.
>   * @nonblocking: whether waiting for disk IO or mmap_sem contention
>   *
> - * Returns number of pages pinned. This may be fewer than the number
> - * requested. If nr_pages is 0 or negative, returns 0. If no pages
> - * were pinned, returns -errno. Each page returned must be released
> - * with a put_page() call when it is finished with. vmas will only
> - * remain valid while mmap_sem is held.
> + * Returns either number of pages pinned (which may be less than the
> + * number requested), or an error. Details about the return value:
> + *
> + * -- If nr_pages is 0, returns 0.
> + * -- If nr_pages is >0, but no pages were pinned, returns -errno.
> + * -- If nr_pages is >0, and some pages were pinned, returns the number of
> + *    pages pinned. Again, this may be less than nr_pages.
> + *
> + * The caller is responsible for releasing returned @pages, via put_page().
> + *
> + * @vmas are valid only as long as mmap_sem is held.
>   *
>   * Must be called with mmap_sem held.  It may be released.  See below.
>   *
> 
