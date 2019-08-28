Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3F08C3A5A6
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 14:13:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB2AF2189D
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 14:13:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567001588;
	bh=gL7z5ChKllbLpdWmKIBPVig3m93sy76t12f/1Mh8DKY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=cpnImM47/NC1+iLB8ISpdJxdsb7QIsZ/5qZyXsnIa+XHTnveJ95b8qlfJ0ceUdwzP
	 VxndN0r4ti4U0M4agIDFQFnDbcwRJ/P2HiKrzmE0ueGEQXGCFMtqgctPjLMqpPzU4C
	 h14UNxn5ekARLKvWjYABhlwIUpSRU+Al/143GabM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726858AbfH1ONH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 10:13:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:33680 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726341AbfH1ONH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 10:13:07 -0400
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 32ADB22CED;
        Wed, 28 Aug 2019 14:13:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567001586;
        bh=gL7z5ChKllbLpdWmKIBPVig3m93sy76t12f/1Mh8DKY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=WEhiCTXdi4fb4bZWj1AIjfZ73k7/5yYNOuYIcqLtiBfKEPCUGVbnSYg/nx6HXExhF
         VlpXj/0+xzuk2nMM09kHUsLFHtd5NyGrS38Z8+spQewykKxHz5kdvV8tIVAqToHRAN
         680fpIlJFP5rAlEo7HaKFYR2rg+bhz7Nyj+DxK34=
Received: by mail-wm1-f54.google.com with SMTP id e8so4960234wme.1;
        Wed, 28 Aug 2019 07:13:06 -0700 (PDT)
X-Gm-Message-State: APjAAAU0OtRw7ERJ3trpa51tOlUCXMi4mT9/pg8JsOBlyKXSk7EAuQR+
        uHZFJg269At9gizdKNdnNSTnpDSBj4bqtlaADBs=
X-Google-Smtp-Source: APXvYqyvtZp0hGYOWR199wSoneS+urPpShsXAkZ5mBE0gaAAJUGXa5TM3Sm+zxrr1ZMa1J4BQm+mOEFz7NRW+khosGQ=
X-Received: by 2002:a7b:c4d2:: with SMTP id g18mr5221745wmk.79.1567001584618;
 Wed, 28 Aug 2019 07:13:04 -0700 (PDT)
MIME-Version: 1.0
References: <1566999319-8151-1-git-send-email-rppt@linux.ibm.com>
In-Reply-To: <1566999319-8151-1-git-send-email-rppt@linux.ibm.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Wed, 28 Aug 2019 22:12:52 +0800
X-Gmail-Original-Message-ID: <CAJF2gTTF0W18kPzXP8hOA64FuOx=atxFnCk0syEhP7s7LOm0Kw@mail.gmail.com>
Message-ID: <CAJF2gTTF0W18kPzXP8hOA64FuOx=atxFnCk0syEhP7s7LOm0Kw@mail.gmail.com>
Subject: Re: [PATCH] csky: use generic free_initrd_mem()
To:     Mike Rapoport <rppt@linux.ibm.com>
Cc:     linux-csky@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Acked-by: Guo Ren <guoren@kernel.org>

On Wed, Aug 28, 2019 at 9:35 PM Mike Rapoport <rppt@linux.ibm.com> wrote:
>
> The csky implementation of free_initrd_mem() is an open-coded version of
> free_reserved_area() without poisoning.
>
> Remove it and make csky use the generic version of free_initrd_mem().
>
> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> ---
>  arch/csky/mm/init.c | 16 ----------------
>  1 file changed, 16 deletions(-)
>
> diff --git a/arch/csky/mm/init.c b/arch/csky/mm/init.c
> index eb0dc9e..d4c2292 100644
> --- a/arch/csky/mm/init.c
> +++ b/arch/csky/mm/init.c
> @@ -60,22 +60,6 @@ void __init mem_init(void)
>         mem_init_print_info(NULL);
>  }
>
> -#ifdef CONFIG_BLK_DEV_INITRD
> -void free_initrd_mem(unsigned long start, unsigned long end)
> -{
> -       if (start < end)
> -               pr_info("Freeing initrd memory: %ldk freed\n",
> -                       (end - start) >> 10);
> -
> -       for (; start < end; start += PAGE_SIZE) {
> -               ClearPageReserved(virt_to_page(start));
> -               init_page_count(virt_to_page(start));
> -               free_page(start);
> -               totalram_pages_inc();
> -       }
> -}
> -#endif
> -
>  extern char __init_begin[], __init_end[];
>
>  void free_initmem(void)
> --
> 2.7.4
>


-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
