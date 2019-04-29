Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90E88C43219
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 07:00:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F95F206BF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 07:00:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556521232;
	bh=vfjSvfpGNgLP8L2mLtJnKveVyNRoCGT1elcG9HkpdE0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=aJvM5NBCAAkwHxtOnqR9zAP6As4Bij4yNbum3SGRD77kG2NSVy5pGCXr4TtoApFDq
	 hqOYEcRJ2dBvbltXnEs6LzhJTSzY/Q0T520JzR8u6wbCFAlTRNTQzYE1IiUiR79xTK
	 9JMirhcgFtfFnY4HgqqWYS8RWfPZPNhLQ4ncq6bE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727380AbfD2HAb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 03:00:31 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:34360 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726846AbfD2HAa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 03:00:30 -0400
Received: by mail-oi1-f196.google.com with SMTP id v10so7502716oib.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2019 00:00:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8Nnztq5EFzs0VFDOgJg6pP40Rk1vMCUk9oDKTDGzCvE=;
        b=YvOS7X4B1pLGCNLCBkSj78w4W3pFFSU1OgPANQlXq/ztL4tVWui9K4tWj8epb0z5RU
         ifrpDnxf8tbnHK0axdimxQBJXnEePXAAfsqMjLJTvxDdrQMs+XUzQPS4kUj6DIKFeej8
         uz49obTaflW9yQB3nR2t0cyUdHTAzrt4Z3sTuY/6zxV4EKAR49M15EcftkX6cuabJVhy
         1wo/6ys5Nr+JxQmQBNmSlhc34wAH45DI87mWwjYzQFgK8hqQfGPLFrYDF8nwlZIs9I0E
         PHtFdjk7fSiEehRWFOFRs8JNnhM7iky5zHyWOFWeWVmDp9dndylXyollD0MCWGqpIqAp
         wfHA==
X-Gm-Message-State: APjAAAXNMN+GPhzC0FE2B00//oq/FtaRl51lsQb9REPMNpIBoSm99Oad
        BYF/ZS10rDNmIN8NP0pzEXFhG42DcJVbOXjART28/A==
X-Google-Smtp-Source: APXvYqyjQ6pWrycwMZfhWSdAKW168em7cZFmjv0dMc5BGLqVwcDjDYvgAp8MV9l+yTAdRJqeN78JHHpIM1uu0qGLf/8=
X-Received: by 2002:aca:5304:: with SMTP id h4mr3863938oib.115.1556521229953;
 Mon, 29 Apr 2019 00:00:29 -0700 (PDT)
MIME-Version: 1.0
References: <20190427235652.3799-1-tobin@kernel.org>
In-Reply-To: <20190427235652.3799-1-tobin@kernel.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 29 Apr 2019 09:00:14 +0200
Message-ID: <CAJZ5v0hV773sBOgiz=kZifL05HYWYWwKWVE0Xn74EFytT7nGLg@mail.gmail.com>
Subject: Re: [PATCH] kobject: Improve doc clarity kobject_init_and_add()
To:     "Tobin C. Harding" <tobin@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 28, 2019 at 1:57 AM Tobin C. Harding <tobin@kernel.org> wrote:
>
> Function kobject_init_and_add() is currently misused in a number of
> places in the kernel.  On error return kobject_put() must be called but
> is at times not.
>
> Make the function documentation more explicit about calling
> kobject_put() in the error path.
>
> Signed-off-by: Tobin C. Harding <tobin@kernel.org>

Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> ---
>  lib/kobject.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/lib/kobject.c b/lib/kobject.c
> index aa89edcd2b63..58d1d7a64203 100644
> --- a/lib/kobject.c
> +++ b/lib/kobject.c
> @@ -437,9 +437,12 @@ EXPORT_SYMBOL(kobject_add);
>   * @parent: pointer to the parent of this kobject.
>   * @fmt: the name of the kobject.
>   *
> - * This function combines the call to kobject_init() and
> - * kobject_add().  The same type of error handling after a call to
> - * kobject_add() and kobject lifetime rules are the same here.
> + * This function combines the call to kobject_init() and kobject_add().
> + *
> + * If this function returns an error, kobject_put() must be called to
> + * properly clean up the memory associated with the object.  This is the
> + * same type of error handling after a call to kobject_add() and kobject
> + * lifetime rules are the same here.
>   */
>  int kobject_init_and_add(struct kobject *kobj, struct kobj_type *ktype,
>                          struct kobject *parent, const char *fmt, ...)
> --
> 2.21.0
>
