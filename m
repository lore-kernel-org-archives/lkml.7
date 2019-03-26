Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC9F2C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 15:32:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79B2D20857
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 15:32:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553614362;
	bh=HhOrKWvRHBv9fmQwzjqMNqhO3P7S8NS7LERw87r+0Io=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=DEO+fPXDqzKQmdxvrTKxO3hNBPDYKaAuW2yQFgtqgG8/CTpsgKttROhefFZV9HApL
	 cola/iyArD7VFZTkxu99UrNDiDiw+cFOCgJCFNhVvtgUyZNI/CBpfzzJ0CqAbmG3PE
	 AVA1Qa/1xS033PnadYVVl5HWsxeaKQhFuLlUl6aQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731951AbfCZPcl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 11:32:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:42720 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727492AbfCZPck (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 11:32:40 -0400
Received: from localhost (unknown [77.138.135.184])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 589EC20811;
        Tue, 26 Mar 2019 15:32:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553614360;
        bh=HhOrKWvRHBv9fmQwzjqMNqhO3P7S8NS7LERw87r+0Io=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=yuKd+89q66Qybm0VWiO82n2mw4AD8C+syxmK5cWjAij4sw7TCSGmBi/+tBcpHk7po
         PLtfv8or545phvbLDMmg+ANiYAFoJ9y5fZtcam0VPD0i4QoeRDztbky6zIZMEq50Yf
         cR099NwoDuYrqrooTEVIslGmUzhtVpX8WWPDA34U=
Date:   Tue, 26 Mar 2019 17:32:35 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86 <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        linux-pm <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -next] x86/apic: Reduce print level of CPU limit
 announcement
Message-ID: <20190326153235.GH22899@mtr-leonro.mtl.com>
References: <20190326120213.28633-1-leon@kernel.org>
 <CAJZ5v0jbb+fEWWHdnZEKNOhUy=ZTsDMxy7Rwahp8O-jpBy-K9w@mail.gmail.com>
 <20190326144137.GB22899@mtr-leonro.mtl.com>
 <CAJZ5v0h1w+ZWV24SnX0g9NZORuVWHnyOjZ9Jue2_yUvvFpJB6g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="cYtjc4pxslFTELvY"
Content-Disposition: inline
In-Reply-To: <CAJZ5v0h1w+ZWV24SnX0g9NZORuVWHnyOjZ9Jue2_yUvvFpJB6g@mail.gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--cYtjc4pxslFTELvY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 26, 2019 at 04:12:27PM +0100, Rafael J. Wysocki wrote:
> On Tue, Mar 26, 2019 at 3:41 PM Leon Romanovsky <leon@kernel.org> wrote:
> >
> > On Tue, Mar 26, 2019 at 01:29:54PM +0100, Rafael J. Wysocki wrote:
> > > On Tue, Mar 26, 2019 at 1:02 PM Leon Romanovsky <leon@kernel.org> wrote:
> > > >
> > > > From: Leon Romanovsky <leonro@mellanox.com>
> > > >
> > > > Kernel is booted with less possible CPUs (possible_cpus kernel boot
> > > > option) than available CPUs will have prints like this:
> > > >
> > > > [    1.131039] APIC: NR_CPUS/possible_cpus limit of 8 reached. Processor 55/0x1f ignored.
> > > > [    1.132228] ACPI: Unable to map lapic to logical cpu number
> > > >
> > > > Those warnings are printed for every not-enabled CPU and on the systems
> > > > with large number of such CPUs, we see a lot of those prints for default
> > > > print level.
> > > >
> > > > Simple conversion of those prints to be in debug level removes them
> > > > while leaving the option to debug system.
> > >
> > > But generally dynamic debug must be enabled in order for pr_debug()
> > > prints to be visible which is kind of cumbersome to do via the command
> > > line.
> >
> > It is doable and documented pretty well, which is uncommon :)
> > https://www.kernel.org/doc/html/latest/admin-guide/dynamic-debug-howto.html#debug-messages-during-boot-process
>
> I know.
>
> That's what I mean by "kind of cumbersome", because you need to know
> which debug messages to enable upfront.
>
> > >
> > > > Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
> > > > ---
> > > >  arch/x86/kernel/acpi/boot.c | 2 +-
> > > >  arch/x86/kernel/apic/apic.c | 6 +++---
> > > >  2 files changed, 4 insertions(+), 4 deletions(-)
> > > >
> > > > diff --git a/arch/x86/kernel/acpi/boot.c b/arch/x86/kernel/acpi/boot.c
> > > > index 8dcbf6890714..3ef8ab89c02d 100644
> > > > --- a/arch/x86/kernel/acpi/boot.c
> > > > +++ b/arch/x86/kernel/acpi/boot.c
> > > > @@ -770,7 +770,7 @@ int acpi_map_cpu(acpi_handle handle, phys_cpuid_t physid, u32 acpi_id,
> > > >
> > > >         cpu = acpi_register_lapic(physid, acpi_id, ACPI_MADT_ENABLED);
> > > >         if (cpu < 0) {
> > > > -               pr_info(PREFIX "Unable to map lapic to logical cpu number\n");
> > > > +               pr_debug(PREFIX "Unable to map lapic to logical cpu number\n");
> > >
> > > And this one is printed sometimes when something really goes wrong
> > > which may be really hard to debug otherwise, so there is value in the
> > > info level here.
> > >
> > > Would it be possible to avoid printing it just in some cases?
> >
> > This can do the trick:
> >
> > diff --git a/arch/x86/kernel/acpi/boot.c b/arch/x86/kernel/acpi/boot.c
> > index 3ef8ab89c02d..00212b3991e0 100644
> > --- a/arch/x86/kernel/acpi/boot.c
> > +++ b/arch/x86/kernel/acpi/boot.c
> > @@ -770,7 +770,10 @@ int acpi_map_cpu(acpi_handle handle, phys_cpuid_t physid, u32 acpi_id,
> >
> >         cpu = acpi_register_lapic(physid, acpi_id, ACPI_MADT_ENABLED);
> >         if (cpu < 0) {
> > -               pr_debug(PREFIX "Unable to map lapic to logical cpu number\n");
> > +               if (cpu == -ENOENT)
> > +                       pr_debug(PREFIX "Unable to map lapic to logical cpu number\n");
>
> I don't think it is necessary to print this in the -ENOENT case, as
> there is a message for that case that will be printed anyway.

Agree, how do you want me to progress? Should I resend patch?

Thanks

--cYtjc4pxslFTELvY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJcmkYTAAoJEORje4g2clinbvIP/03hZF2YlaSIGnsLZP1fCy1h
p9LF5oeHShh6x3gR5c9Cl3i+HEu475f5kqAj/HOF3NijXeZmmT0mTnOPSP2pw14I
fuZ8EoVC0vhVb19jGmivw5bD0DlVXrfq88vExyEDmRtxqik+kzMIU33n34r0LqXQ
zLWwkAyMnGXsywhdtqAYMNV0QDo9QCalLHBe0sHTd9HbPV2oiqB0z+wgwoCdmwKW
jsEvU99cPNxFcoz+CIFu1t12cvZAb3znyck6tdsaS/IuzkKMW+0q34RgWdd2Au9h
07/ifPC5tRRS5TTNNeUC4MOqp4szQdU72TW7SBkMuu1JqfKJJKk8hZKirWZLfrYi
9SkqRDRrW8VpVuszHdbomW13XClABbX6itMOuHAinHkhwqihlPf0n1LmEpMaaffK
sWGjn3/cY+c6xlhOvTgHbvYBF4EHJWTheL/1A08nRLWA/dxFA71NfL1X1au2Xu78
/Uz/dH9b14NcgfWEUQuTBmBrtPwwxa1hSNJT2sC796aaPYwl1qAoI6CIGARcwfyb
htn27dWa7Vo4Qrw7uuWWGngrTv8YCpWzEZfGi16Q1oe5h4WvefBRnhFwHdvc8WyV
L5TH1Y5MZ3I/sRMHodQRld031Wxs9bjNOv+Rb4pzxSW5QM3Aj5ciQeDLvjfVVWfP
xnki36E7+w3KFD1dZh+L
=+0N5
-----END PGP SIGNATURE-----

--cYtjc4pxslFTELvY--
