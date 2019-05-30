Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63568C28CC0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 13:08:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CAE325937
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 13:08:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726724AbfE3NIC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 09:08:02 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:46007 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726169AbfE3NIC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 09:08:02 -0400
Received: by mail-lf1-f67.google.com with SMTP id m14so4935530lfp.12
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2019 06:08:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lo8Pf5qQPzDgv3LbnRe5hAmhzj8l8zc5AuLXNn3lbXo=;
        b=mNMv6Gri+EvzizfEAe691QdPd56yjsNcy5oimR0zmx5oiOamob63ZRxuk31d5N0YPK
         Sc4VOo3zZOOl9HSZikZ8JTzmOmwUpgsxahrB4bUwzIXzEWa0mEQ5GsyXleeB910Y9T8L
         miBr4OYE8hV8eG/sX8fdaaw2deNmacDI4gmrzpR6b1jpCBg/3GabLfnxvtepm8uUiu0/
         ym/pV+nkIiBFynKy4l5Amuo23FNQ8TU2sJxt0hg0pAtAHUFH9ARN0410lkhhUaihrBUN
         rGHLsY6T6DdGu+UWLs79ZcV8TRi9JrlIRf0/gTWvnkFfmmdXKLbgAbOn8xqK7jOeLIcW
         X/7g==
X-Gm-Message-State: APjAAAW3+HaC4YtAyFLz5Zl7qqwvF+gkHsKDlWe4Uy7eh4nOus6DyoIp
        VoUgGd87vV8rbCBnDe+tVpubf19dFbWpU1sIoAjfGA==
X-Google-Smtp-Source: APXvYqyavwnJULw4Wz7Yg0S3xURZgWHWuSrHKVYFeYqBmDka5ggDKKE/RR5194S1GfsiIfocaRV06vuTWRje8VGjYSQ=
X-Received: by 2002:a19:ec12:: with SMTP id b18mr2020933lfa.149.1559221680444;
 Thu, 30 May 2019 06:08:00 -0700 (PDT)
MIME-Version: 1.0
References: <1559212177-7072-1-git-send-email-bhsharma@redhat.com> <87v9xsnlu9.fsf@concordia.ellerman.id.au>
In-Reply-To: <87v9xsnlu9.fsf@concordia.ellerman.id.au>
From:   Bhupesh Sharma <bhsharma@redhat.com>
Date:   Thu, 30 May 2019 18:37:46 +0530
Message-ID: <CACi5LpM9v1YC_6HhA-uKghawzkEu=TTPVkomMmv2i-LGi8X7+g@mail.gmail.com>
Subject: Re: [PATCH] Documentation/stackprotector: powerpc supports stack protector
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org, Arnd Bergmann <arnd@arndb.de>,
        Bhupesh SHARMA <bhupesh.linux@gmail.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        corbet@lwn.net, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 30, 2019 at 6:25 PM Michael Ellerman <mpe@ellerman.id.au> wrote:
>
> Bhupesh Sharma <bhsharma@redhat.com> writes:
> > powerpc architecture (both 64-bit and 32-bit) supports stack protector
> > mechanism since some time now [see commit 06ec27aea9fc ("powerpc/64:
> > add stack protector support")].
> >
> > Update stackprotector arch support documentation to reflect the same.
> >
> > Signed-off-by: Bhupesh Sharma <bhsharma@redhat.com>
> > ---
> >  Documentation/features/debug/stackprotector/arch-support.txt | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/Documentation/features/debug/stackprotector/arch-support.txt b/Documentation/features/debug/stackprotector/arch-support.txt
> > index 9999ea521f3e..32bbdfc64c32 100644
> > --- a/Documentation/features/debug/stackprotector/arch-support.txt
> > +++ b/Documentation/features/debug/stackprotector/arch-support.txt
> > @@ -22,7 +22,7 @@
> >      |       nios2: | TODO |
> >      |    openrisc: | TODO |
> >      |      parisc: | TODO |
> > -    |     powerpc: | TODO |
> > +    |     powerpc: |  ok  |
> >      |       riscv: | TODO |
> >      |        s390: | TODO |
> >      |          sh: |  ok  |
> > --
> > 2.7.4
>
> Thanks.
>
> This should probably go via the documentation tree?
>
> Acked-by: Michael Ellerman <mpe@ellerman.id.au>

Thanks for the review Michael.
I am ok with this going through the documentation tree as well.

Regards,
Bhupesh
