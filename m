Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2A98C04AAF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 07:58:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D08EE2173C
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 07:58:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726730AbfEUH66 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 03:58:58 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:37686 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726006AbfEUH65 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 03:58:57 -0400
Received: by mail-qt1-f196.google.com with SMTP id o7so19442699qtp.4;
        Tue, 21 May 2019 00:58:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=p/GfCtmqLs5V/u3rJvsxM4G96Nj4OiIWtjGPDXWU4uA=;
        b=jLnCfR2vsrdnKWBSb6GSRnA6qNEfNJpXLXqEsTVJPNofKhvr/j+N+2lZvRKte7LCfS
         0my86ONw5n8HQBSaRtKJ+BElyravA7BSM45BA5jq+hkAhE5KKcGkUw+ZvxTMO4t+P4+D
         SPDhEQAB1zwQK35oi34ZUtmoMfXFBkFY7ySL+CvDJ7vikIwBi6yYcrVdVePEipq//020
         MA0/cAjY8Dg0Btv0I+fvMWtXu+OsP1OtTZCBz7/eXKKCKpAAHJVwhz1ULYM4t2/FjidN
         OPQCkX7H2zsQgJuVPu9XUH/ZxLHb/RP6jYrv4t6zvnGpJAjzNFwtl7e91lAWUm0v5Z6z
         2fcg==
X-Gm-Message-State: APjAAAXtgOIXjoWGWp58pQP9iuaF1hZxLJbUWGTZUivfF4XUmiBkVCoL
        7Sq98GpHx3Rp3a9G4k05AlomOVDygY1IDYXs6GA=
X-Google-Smtp-Source: APXvYqwkirlL3CuKj+uX44c7QQd2fsAJT8BtPUv/1D9DqAqk5D4aO7JgxiLtFRG4Izd+ZQNr2CWDOKfTgD54eRrRwa8=
X-Received: by 2002:a05:6214:c4:: with SMTP id f4mr14416531qvs.93.1558425535884;
 Tue, 21 May 2019 00:58:55 -0700 (PDT)
MIME-Version: 1.0
References: <0b74e9ad12360b56bc0a3c2ca972798c424f2610.1548790896.git.lsun@mellanox.com>
 <1558115345-32476-1-git-send-email-lsun@mellanox.com> <20190520155658.GA14165@kroah.com>
 <DB6PR05MB32232CA5DD05D1A923A28215A1060@DB6PR05MB3223.eurprd05.prod.outlook.com>
 <20190520191209.GA29776@kroah.com> <DB6PR05MB3223F25A2E2B78053FE96D5BA1060@DB6PR05MB3223.eurprd05.prod.outlook.com>
In-Reply-To: <DB6PR05MB3223F25A2E2B78053FE96D5BA1060@DB6PR05MB3223.eurprd05.prod.outlook.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 21 May 2019 09:58:38 +0200
Message-ID: <CAK8P3a0AfEo8+EDBoOS8PfOeKGZUhgXoT7xz+pG9YNUDPdfR_A@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] platform/mellanox: Add bootctl driver for Mellanox
 BlueField Soc
To:     Liming Sun <lsun@mellanox.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andy@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        Vadim Pasternak <vadimp@mellanox.com>,
        David Woods <dwoods@mellanox.com>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 20, 2019 at 10:44 PM Liming Sun <lsun@mellanox.com> wrote:
> > -----Original Message-----
> > From: Greg KH <gregkh@linuxfoundation.org>
> > Sent: Monday, May 20, 2019 3:12 PM
> > To: Liming Sun <lsun@mellanox.com>
> > Cc: Andy Shevchenko <andy@infradead.org>; Darren Hart <dvhart@infradead.org>; Vadim Pasternak <vadimp@mellanox.com>; David
> > Woods <dwoods@mellanox.com>; platform-driver-x86@vger.kernel.org; linux-kernel@vger.kernel.org
> > Subject: Re: [PATCH v5 1/2] platform/mellanox: Add bootctl driver for Mellanox BlueField Soc
> >
> > On Mon, May 20, 2019 at 06:07:44PM +0000, Liming Sun wrote:
> > > > > +static struct platform_driver mlxbf_bootctl_driver = {
> > > > > +       .probe = mlxbf_bootctl_probe,
> > > > > +       .driver = {
> > > > > +               .name = "mlxbf-bootctl",
> > > > > +               .groups = mlxbf_bootctl_groups,
> > > > > +               .acpi_match_table = mlxbf_bootctl_acpi_ids,
> > > >
> > > > Why is an acpi driver a platform driver?  Isn't there a "real" acpi
> > > > driver interface you should be tieing into instead?
> > > >
> > > > Only use a platform driver as an absolute last resort.  I don't think
> > > > that is the case here.
> > >
> > > The driver is trying to configure boot-swapping and display secure state,
> > > and is defined/initiated in ACPI table in UEFI. It seems a little hard to
> > > categorize this driver to any existing subsystem. Any suggestion
> > > where it might be a better fit (like drivers/misc, drivers/firmware, etc)?
> > > Please correct me if I misunderstand the comments. Thanks!.
> >
> > The comment was asking why an acpi driver is a platform driver, but then
> > I went and looked now at a bunch of acpi drivers, and they all are
> > platform drivers :(
> >
> > Anyway, drivers/acpi/ seems like the best place for this file, right?
>
> My understanding is that the "drivers/acpi" is mainly for the acpi common code.
> The vendor or platform specific drivers are spread in other various directories,
> most of which are 'platform' drivers.

It depends on how closely you are following the acpi specification.
If you just implement access to a standard ACPI feature, or you have
added your interface to the ACPI specification, then the driver
should work on any system that supports this feature.

> For this driver, we didn't find better sub-component for it, thus put it under
> 'drivers/platform/mellanox' which is vendor specific driver by its name.

drivers/platform/mellanox/ would be a good place for drivers running on
a host platform with a bluefield accelerator card as an add-on, but as I
understand, this is a driver that actually just runs in Linux on the bluefield
itself, so it should go in a different place.

We use drivers/soc/ for things that are specific to one SoC, and that
are typically used by other drivers, but that don't have (and should not
have) a generic abstraction, which probably is not the case here either.

What we do have in drivers/power/reset is a couple of drivers that
set the "reboot reason", communicating that to the firmware for the
next boot, using the reboot_mode_register() interface. I don't
know too much about that interface, but maybe you can use that
instead of adding another sysfs interface?

If you have a complex firmware on the system that you can talk
to, there is also drivers/firmware/ as another option to put
abstractions into.

         Arnd
