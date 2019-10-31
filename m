Return-Path: <SRS0=21RF=YY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D558CA9ECB
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 22:36:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54E6B20873
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 22:36:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="bP/zDnr+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727582AbfJaWg1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Oct 2019 18:36:27 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:16672 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726506AbfJaWg0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 18:36:26 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5dbb61f00000>; Thu, 31 Oct 2019 15:36:32 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 31 Oct 2019 15:36:26 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 31 Oct 2019 15:36:26 -0700
Received: from [10.110.48.28] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 31 Oct
 2019 22:36:25 +0000
Subject: Re: [PATCH v3] mm: gup: fix comments of __get_user_pages() and
 get_user_pages_remote()
To:     Liu Xiang <liuxiang_1999@126.com>, <linux-mm@kvack.org>
CC:     <linux-kernel@vger.kernel.org>
References: <1572443533-3118-1-git-send-email-liuxiang_1999@126.com>
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <97e9ade2-609d-504a-f5cb-e64f01826a4b@nvidia.com>
Date:   Thu, 31 Oct 2019 15:36:25 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1572443533-3118-1-git-send-email-liuxiang_1999@126.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1572561392; bh=c8HttT1T3U+ZTLW69hILmDnuPRctoCffgOQnWmjjfdE=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=bP/zDnr+IV8RBp6yeyTwNn8XGoaW4shXs3D3OgQHOL8SJGZgmYURzN1ZM3sgnxLmz
         TF7osmvq3QOQWBb5nGIkqR+2HX+V8+HFWs2AK4NZMnqjqThxpzoal9NLxBCdR904Tg
         tQJqZBBbNAkEy1VXBJ9212H1WUgNT5ji5FOQLxIzgbYbVahwYrf1MMPPA3gaBZxCC/
         mMXdn8LP+/iMUn3m3KwCfB9A9lk9ZD+dt8qRldo3liD32LLXv1QGfFGZ+aj00+RJZm
         kuaBcmm88l4RSASRIzgURE/DSm/z8ChZunQVc1MucMgdzsIwa6PAVddJK+6FE6fKfw
         o6TP/XmlptQ9w==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/30/19 6:52 AM, Liu Xiang wrote:
> Fix comments of __get_user_pages() and get_user_pages_remote(),
> make them more clear.
> 
> Suggested-by: John Hubbard <jhubbard@nvidia.com>
> Signed-off-by: Liu Xiang <liuxiang_1999@126.com>
> 
> ---
> 
> Changes in v3:
>  as suggested by John, apply the same fix to get_user_pages_remote().
> ---
>  mm/gup.c | 32 ++++++++++++++++++++++----------
>  1 file changed, 22 insertions(+), 10 deletions(-)


Reviewed-by: John Hubbard <jhubbard@nvidia.com>

thanks,
-- 
John Hubbard
NVIDIA

> 
> diff --git a/mm/gup.c b/mm/gup.c
> index 8f236a3..c36c621 100644
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
> @@ -1107,11 +1113,17 @@ static __always_inline long __get_user_pages_locked(struct task_struct *tsk,
>   *		subsequently whether VM_FAULT_RETRY functionality can be
>   *		utilised. Lock must initially be held.
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
>   * Must be called with mmap_sem held for read or write.
>   *
> 
