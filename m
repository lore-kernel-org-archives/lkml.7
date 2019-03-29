Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98E59C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 20:53:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61931218A3
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 20:53:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="r3YpB8fr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730323AbfC2UxZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 16:53:25 -0400
Received: from merlin.infradead.org ([205.233.59.134]:42478 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730151AbfC2UxZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 16:53:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=SXLIsWX+sIMJiNWtF0Uz0Css8O/+w93TgCqvxQgHdgU=; b=r3YpB8frv2MwYfBW++6LtXZqqh
        J8MQ1igNj30Dkbfak77RQSfJMVWXukSQuE2PYmgokaTkjdMQABrYXM0MhU7nwvqDf+OTOh1KKE4fi
        4l9TKnJ9txerl45TWGywTqNIW/Fck3uLrrNjEWmVLEk3bnGo45RD3bL+W9aTDLODdzCHHpDONmkh8
        BU/J8qGHl9wccB0rAugzNEWnKwv34ouxpnQajvFjL2kqzPhU/+aQZi/fO0qaCdTG59E6jvycqfr7x
        s6VORPvkkQdsFQEFohtLgxnkIgoCBW4RSyHii7MVdQhKREvcv4fBnPBqYppVbFKTEov7XbyV2HrK/
        jesYArHA==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h9yV6-0008NG-8l; Fri, 29 Mar 2019 20:53:20 +0000
Subject: Re: [PATCH v2] gcov: fix when CONFIG_MODULES is not set
To:     Nick Desaulniers <ndesaulniers@google.com>, oberpar@linux.ibm.com,
        akpm@linux-foundation.org
Cc:     Greg Hackmann <ghackmann@android.com>, Tri Vo <trong@android.com>,
        linux-mm@kvack.org, kbuild-all@01.org,
        kbuild test robot <lkp@intel.com>,
        linux-kernel@vger.kernel.org
References: <eea3ce6a-732b-5c1d-9975-eddaeee21cf5@infradead.org>
 <20190329181839.139301-1-ndesaulniers@google.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <83226cfb-afa7-0174-896c-d9f7a6193cf4@infradead.org>
Date:   Fri, 29 Mar 2019 13:53:17 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190329181839.139301-1-ndesaulniers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/29/19 11:18 AM, Nick Desaulniers wrote:
> Fixes commit 8c3d220cb6b5 ("gcov: clang support")

There is a certain format for Fixes: and that's not quite it. :(

> Cc: Greg Hackmann <ghackmann@android.com>
> Cc: Tri Vo <trong@android.com>
> Cc: Peter Oberparleiter <oberpar@linux.ibm.com>
> Cc: linux-mm@kvack.org
> Cc: kbuild-all@01.org
> Reported-by: Randy Dunlap <rdunlap@infradead.org>
> Reported-by: kbuild test robot <lkp@intel.com>
> Link: https://marc.info/?l=linux-mm&m=155384681109231&w=2
> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>

Acked-by: Randy Dunlap <rdunlap@infradead.org> # build-tested

Thanks.

> ---
>  kernel/gcov/gcc_3_4.c | 4 ++++
>  kernel/gcov/gcc_4_7.c | 4 ++++
>  2 files changed, 8 insertions(+)
> 
> diff --git a/kernel/gcov/gcc_3_4.c b/kernel/gcov/gcc_3_4.c
> index 801ee4b0b969..8fc30f178351 100644
> --- a/kernel/gcov/gcc_3_4.c
> +++ b/kernel/gcov/gcc_3_4.c
> @@ -146,7 +146,11 @@ void gcov_info_unlink(struct gcov_info *prev, struct gcov_info *info)
>   */
>  bool gcov_info_within_module(struct gcov_info *info, struct module *mod)
>  {
> +#ifdef CONFIG_MODULES
>  	return within_module((unsigned long)info, mod);
> +#else
> +	return false;
> +#endif
>  }
>  
>  /* Symbolic links to be created for each profiling data file. */
> diff --git a/kernel/gcov/gcc_4_7.c b/kernel/gcov/gcc_4_7.c
> index ec37563674d6..0b6886d4a4dd 100644
> --- a/kernel/gcov/gcc_4_7.c
> +++ b/kernel/gcov/gcc_4_7.c
> @@ -159,7 +159,11 @@ void gcov_info_unlink(struct gcov_info *prev, struct gcov_info *info)
>   */
>  bool gcov_info_within_module(struct gcov_info *info, struct module *mod)
>  {
> +#ifdef CONFIG_MODULES
>  	return within_module((unsigned long)info, mod);
> +#else
> +	return false;
> +#endif
>  }
>  
>  /* Symbolic links to be created for each profiling data file. */
> 


-- 
~Randy
