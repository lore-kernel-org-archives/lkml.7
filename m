Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7294CCA9EC0
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 18:50:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BC6B208C0
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 18:50:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="eUpu78bc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728755AbfJ1Sud (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 14:50:33 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:16677 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727218AbfJ1Suc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 14:50:32 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5db7387f0000>; Mon, 28 Oct 2019 11:50:39 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Mon, 28 Oct 2019 11:50:31 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Mon, 28 Oct 2019 11:50:31 -0700
Received: from DRHQMAIL107.nvidia.com (10.27.9.16) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 28 Oct
 2019 18:50:31 +0000
Received: from [10.110.48.28] (10.124.1.5) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 28 Oct
 2019 18:50:31 +0000
Subject: Re: [PATCH v2] mm: gup: fix comment of __get_user_pages()
To:     Liu Xiang <liuxiang_1999@126.com>, <linux-mm@kvack.org>
CC:     <linux-kernel@vger.kernel.org>
References: <1571929472-3091-1-git-send-email-liuxiang_1999@126.com>
From:   John Hubbard <jhubbard@nvidia.com>
X-Nvconfidentiality: public
Message-ID: <fb21ae4a-4a9e-ad39-e12c-47ab8e89efc4@nvidia.com>
Date:   Mon, 28 Oct 2019 11:50:31 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1571929472-3091-1-git-send-email-liuxiang_1999@126.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 DRHQMAIL107.nvidia.com (10.27.9.16)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1572288639; bh=qI+ScbIYK3tKHWcv4xTLxpN+77OnrhD6yaRlomUj77o=;
        h=X-PGP-Universal:Subject:To:CC:References:From:X-Nvconfidentiality:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=eUpu78bcwWNDur+3tpuy4cBcQqDu6PtoW55Bm9git1S59DhOZDo7cRXgqvcGvJckF
         iTTaoaiTHoBWgilKAFSIoJt+wGzw2BebGI/cM2OmQXdq30/KK6tX225B5OSfHuAFMT
         vSkvGvB2HjCI/t/y744YhYhBXFFKkBccQYnBoE+obgU4Zq5lIPLQUSP9FY5Mq/KrW8
         Ut00PAwLwTFJEWnjuqwyLk8xvKuEolrOux4lWWhIjWLuQRPv90Rp9zzBT2LRDTEAmW
         nSLFSv0easfO3/39AgiMh4uiMlh999Aw1xjj78zPK3IGci3UiMywM3X5tc76lV/Ak4
         eodhCmAyb0pWQ==
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

Just remembered: this identical paragraph is also written in the 
get_user_pages_remote() comments. It would be ideal to apply the same fix to 
that identical blob of text.


thanks,
-- 
John Hubbard
NVIDIA

>   *
>   * Must be called with mmap_sem held.  It may be released.  See below.
>   *
> 
