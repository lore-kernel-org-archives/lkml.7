Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 329D4C33C9E
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 12:14:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0965D2087F
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 12:14:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578399276;
	bh=UCFAzvzODA30p7oKdDE41Nymyo5qY+CgQ/3wu7CmCcM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=PUocOfE8gVjUo/zfpG2Vzb6PVd6Bvu/ZxcxLzIwKhDdIFFfNoVWusZOrulbOgx4Ph
	 7yv4LwljkTa6y/EnrDLE63Rm5CnKjNSGqxkxrqdqCmSAPvkNQ4GZKZh/9KYP3qgIuA
	 T6riEvx/rmoOJ/hvmefYg9Un6mKqZ526KXe5I5gQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727996AbgAGMOf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 07:14:35 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:33282 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727658AbgAGMOe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 07:14:34 -0500
Received: by mail-oi1-f194.google.com with SMTP id v140so17565491oie.0;
        Tue, 07 Jan 2020 04:14:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=t2wJ0fJXfZgRbl2tNM1OvC++nsuOLsTnBLRuZM1DuX4=;
        b=Y8VQgeLALQK/aitPxDy1F94n1gH1sJq2B7BBGbyk84UPeVXVrcj3z8DBLcCfUB/yD3
         TuUqbZ6AYpnbEwDSdj/Ry6O+1/Nkj7sJmhq/k3fO4v5cuw1/eZtpDsPs0W2wJZ60AfCx
         1KH8UAfiXGeq4gmmI75z35QHO6LGslqfkWR28AvWlkMkp6e2un9TGSChGFm1KAJbqFTY
         G3eIs+tUWQOlX/YlkXzVC0CCtNF/YFOhbAkT18Kisi7BcnSIfz/GBJvj3eroJHdAWq1p
         5XqY1U4Zl5qr9Kd72NM1c4uKVRNB9r1OqBx8569hodUdgmsVuVwrPdjkwKFrnsq2Sus3
         L10g==
X-Gm-Message-State: APjAAAVI6/SMtxa299CqWuqzvF4YK51yFAgRxF7Ki61n4Ekk6qu4+NBh
        c5ttFh5xqSo5PjlObKd4buIKu3HLl75KHsGtbiw=
X-Google-Smtp-Source: APXvYqz3WOWxsLHYg3F5eRfLXAY9lctkzltccKEWDiLVvsIFT+exQHsyxgvza3mOZXY11FLK9TqrQXcvgzLbmomrUEc=
X-Received: by 2002:aca:d6c8:: with SMTP id n191mr7335252oig.103.1578399273587;
 Tue, 07 Jan 2020 04:14:33 -0800 (PST)
MIME-Version: 1.0
References: <20200102231940.202896-1-semenzato@google.com> <20200102231940.202896-2-semenzato@google.com>
In-Reply-To: <20200102231940.202896-2-semenzato@google.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 7 Jan 2020 13:14:22 +0100
Message-ID: <CAJZ5v0gpaWSqf+V_NF8+H-w34tu-4dSvGz8Zfc7EKkpPZ2rd3g@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] Documentation: clarify limitations of hibernation
To:     Luigi Semenzato <semenzato@google.com>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Geoff Pike <gpike@google.com>, elliott@hpe.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 3, 2020 at 12:19 AM Luigi Semenzato <semenzato@google.com> wrote:
>
> Entering hibernation (suspend-to-disk) will fail if the kernel
> cannot allocate enough memory to create a snapshot of all pages
> in use; i.e., if memory in use is over 1/2 of total RAM.  This
> patch makes this limitation clearer in the documentation.  Without
> it, users may assume that hibernation can replace suspend-to-RAM
> when in fact its functionality is more limited.
>
> Signed-off-by: Luigi Semenzato <semenzato@google.com>
> ---
>  Documentation/admin-guide/pm/sleep-states.rst | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/admin-guide/pm/sleep-states.rst b/Documentation/admin-guide/pm/sleep-states.rst
> index cd3a28cb81f4..a2d5632b7856 100644
> --- a/Documentation/admin-guide/pm/sleep-states.rst
> +++ b/Documentation/admin-guide/pm/sleep-states.rst
> @@ -112,7 +112,9 @@ Hibernation
>  This state (also referred to as Suspend-to-Disk or STD) offers the greatest
>  energy savings and can be used even in the absence of low-level platform support
>  for system suspend.  However, it requires some low-level code for resuming the
> -system to be present for the underlying CPU architecture.
> +system to be present for the underlying CPU architecture.  Additionally, the
> +current implementation can enter the hibernation state only when memory
> +usage is sufficiently low (see "Limitations" below).

This really isn't about memory usage being "sufficiently low" (I told
you I could hibernate systems with almost 100% of RAM allocated before
hibernation), but about specific memory allocation patterns that may
prevent the hibernation code from being able to get enough memory on
demand.

So I would prefer the following alternative statement: "Additionally,
the hibernation state cannot be entered if the current memory usage
pattern of the system prevents the hibernation code from acquiring
enough memory (see "Limitations" below)."

>  Hibernation is significantly different from any of the system suspend variants.
>  It takes three system state changes to put it into hibernation and two system
> @@ -149,6 +151,14 @@ Hibernation is supported if the :c:macro:`CONFIG_HIBERNATION` kernel
>  configuration option is set.  However, this option can only be set if support
>  for the given CPU architecture includes the low-level code for system resume.
>
> +Limitations of Hibernation
> +==========================
> +
> +When entering hibernation, the kernel tries to allocate a chunk of memory large
> +enough to contain a copy of all pages in use, to use it for the system
> +snapshot.

This isn't precise enough, because "all pages in use" may be read as
"all pages of virtual memory in use" and "a chunk of memory" may be
misunderstood as "a contiguous region".

The following describes what the code really does more precisely IMO:

"When entering hibernation, the kernel tries to allocate enough memory
to store a copy of every physical page frame (in RAM) that is not
free, except for some special regions of physical memory explicitly
marked as "not to be saved". These allocations are made one page at a
time with the expectation that the memory management subsystem will
push out memory to the swap when it is not able to find a free
physical page frame. However, in some cases that expectation is not
met: for example when there is not enough swap space in the system or
when the total amount of anonymous pages (process data) exceeds 1/2 of
total RAM. In those cases the operation fails with ENOMEM."

>+  If the allocation fails, the system cannot hibernate and the

> +operation fails with ENOMEM.  This will happen, for instance, when the total
> +amount of anonymous pages (process data) exceeds 1/2 of total RAM.
>
>  Basic ``sysfs`` Interfaces for System Suspend and Hibernation
>  =============================================================
> --
> 2.24.1.735.g03f4e72817-goog
>
