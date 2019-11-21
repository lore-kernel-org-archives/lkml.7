Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C147CC432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 02:30:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9593A20885
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 02:30:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574303457;
	bh=bjayYKI6tB4bYcrey6gcjI71vQErSkVfqxKMrb/YFTU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=zIkDwVxIKahFHGbWbu8nmmnLJptsKaxKygtI0hISgAiJD/cPqVwJAW8xNgHMZQWKI
	 QF/vM++aSEkWw7fKLvLRW7wSshqT6kb0MEnMoU+MUr3SgdN+YjMPOD7h6+PU8wi3QX
	 wDBhp9OvNFlJibUfhmv+ZjaBp35fN8P2PcTemgqs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726840AbfKUCa4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 21:30:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:52662 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725936AbfKUCaz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 21:30:55 -0500
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6E46520878
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2019 02:30:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574303454;
        bh=bjayYKI6tB4bYcrey6gcjI71vQErSkVfqxKMrb/YFTU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=zkmt51GVdTcs4AvXlxnGSPT73ncqOfuKAUIad17KVY5jKdJqFmTT6LzedL/69IxlJ
         6ZNgtmeczkBwXIslq/5HzkjfNrn1YAYkcIYzm9D6CH5CawOl9YcNVOEgaWuWxyHe75
         4mZ2Odzm59jt4PedHdsVIu/wAajdBse8XEBwS8io=
Received: by mail-lj1-f181.google.com with SMTP id 139so1429105ljf.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2019 18:30:54 -0800 (PST)
X-Gm-Message-State: APjAAAUosJ5wcm57qrWQ8vQ0eUl5gEliESTj2VOuCzqUcVla/C5DA3a3
        Lq2W6Q1rNjGz8kHVdJCK2uX2Jevo19yXkhIz8Rs=
X-Google-Smtp-Source: APXvYqxODvb1JLjSW+ODtE5/s3ywWEMbWQXd/v+wFKGd4b3thMSxY7bSIuvQMkQUwNDrzNuBUdreDH84NfX34hCFuRc=
X-Received: by 2002:a2e:9842:: with SMTP id e2mr5139949ljj.93.1574303452599;
 Wed, 20 Nov 2019 18:30:52 -0800 (PST)
MIME-Version: 1.0
References: <20191120133822.12909-1-krzk@kernel.org> <82f7c786-c240-66bd-895a-d71cd6977807@suse.com>
In-Reply-To: <82f7c786-c240-66bd-895a-d71cd6977807@suse.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Thu, 21 Nov 2019 10:30:41 +0800
X-Gmail-Original-Message-ID: <CAJKOXPdLyhaLzseFfMd7-eYN9+cJb9xqX_1Avf11kPgUp2EUKg@mail.gmail.com>
Message-ID: <CAJKOXPdLyhaLzseFfMd7-eYN9+cJb9xqX_1Avf11kPgUp2EUKg@mail.gmail.com>
Subject: Re: [Xen-devel] [PATCH] xen: Fix Kconfig indentation
To:     Jan Beulich <jbeulich@suse.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Stefano Stabellini <sstabellini@kernel.org>,
        xen-devel@lists.xenproject.org,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Nov 2019 at 22:02, Jan Beulich <jbeulich@suse.com> wrote:
>
> On 20.11.2019 14:38, Krzysztof Kozlowski wrote:
> > Adjust indentation from spaces to tab (+optional two spaces) as in
> > coding style with command like:
> >       $ sed -e 's/^        /\t/' -i */Kconfig
> >
> > Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> > ---
> >  drivers/xen/Kconfig | 22 +++++++++++-----------
> >  1 file changed, 11 insertions(+), 11 deletions(-)
> >
> > diff --git a/drivers/xen/Kconfig b/drivers/xen/Kconfig
> > index b71f1ad1013c..cba949c0f8b3 100644
> > --- a/drivers/xen/Kconfig
> > +++ b/drivers/xen/Kconfig
> > @@ -110,12 +110,12 @@ config XEN_COMPAT_XENFS
> >         depends on XENFS
> >         default y
> >         help
> > -         The old xenstore userspace tools expect to find "xenbus"
> > -         under /proc/xen, but "xenbus" is now found at the root of the
> > -         xenfs filesystem.  Selecting this causes the kernel to create
> > -         the compatibility mount point /proc/xen if it is running on
> > -         a xen platform.
> > -         If in doubt, say yes.
> > +      The old xenstore userspace tools expect to find "xenbus"
> > +      under /proc/xen, but "xenbus" is now found at the root of the
> > +      xenfs filesystem.  Selecting this causes the kernel to create
> > +      the compatibility mount point /proc/xen if it is running on
> > +      a xen platform.
> > +      If in doubt, say yes.
>
> Here and ...
>
> > @@ -123,7 +123,7 @@ config XEN_SYS_HYPERVISOR
> >         select SYS_HYPERVISOR
> >         default y
> >         help
> > -         Create entries under /sys/hypervisor describing the Xen
> > +      Create entries under /sys/hypervisor describing the Xen
> >        hypervisor environment.  When running native or in another
> >        virtual environment, /sys/hypervisor will still be present,
> >        but will have no xen contents.
>
> ... here you end up with a tab and one space, whereas ...
>
> > @@ -271,7 +271,7 @@ config XEN_ACPI_PROCESSOR
> >       depends on XEN && XEN_DOM0 && X86 && ACPI_PROCESSOR && CPU_FREQ
> >       default m
> >       help
> > -          This ACPI processor uploads Power Management information to the Xen
> > +       This ACPI processor uploads Power Management information to the Xen
> >         hypervisor.
> >
> >         To do that the driver parses the Power Management data and uploads
> > @@ -280,7 +280,7 @@ config XEN_ACPI_PROCESSOR
> >         SMM so that other drivers (such as ACPI cpufreq scaling driver) will
> >         not load.
> >
> > -          To compile this driver as a module, choose M here: the module will be
> > +       To compile this driver as a module, choose M here: the module will be
> >         called xen_acpi_processor  If you do not know what to choose, select
> >         M here. If the CPUFREQ drivers are built in, select Y here.
> >
> > @@ -313,8 +313,8 @@ config XEN_SYMS
> >         depends on X86 && XEN_DOM0 && XENFS
> >         default y if KALLSYMS
> >         help
> > -          Exports hypervisor symbols (along with their types and addresses) via
> > -          /proc/xen/xensyms file, similar to /proc/kallsyms
> > +       Exports hypervisor symbols (along with their types and addresses) via
> > +       /proc/xen/xensyms file, similar to /proc/kallsyms
>
> ... everywhere else you have a tab and two spaces, as I would
> have expected.
>
> Furthermore in various cases you leave space indented the
> directives other than "help". With a title like the one this
> patch has I'd expect all indentation issues to be taken care of.

Thanks for pointing it out. Indeed I did not fix all violations -
sometimes there are also 7 spaces, or tab+{1,3} spaces. I'll send a
follow up.

Best regards,
Krzysztof
