Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65BDAC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 17:53:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FE5A2087C
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 17:53:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553622827;
	bh=o4YqH7dLiSibMUC53uHT71CWwwVl0PEoUkggetO6MnQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=l+CKh1x0lry+FL19LBK70CrWeWhu6BNw8wbk/VvZfyPY2wqPoFBKq6k0gXF93gcC7
	 8z+LAvK8Xn7vlBBAc0vCWSjzt+J5QfTVJwZuXYR1OjIBNGphXnygM/+gNzbwmwG8//
	 CrpvI3iaGIzOK6N1DmZWTVUCW/ZXAxh2GS1v8/Cw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732293AbfCZRxp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 13:53:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:40800 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727492AbfCZRxp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 13:53:45 -0400
Received: from localhost (unknown [77.138.135.184])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 316E32082F;
        Tue, 26 Mar 2019 17:53:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553622823;
        bh=o4YqH7dLiSibMUC53uHT71CWwwVl0PEoUkggetO6MnQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=coi7jjvn69Rkj3PdmtrWqfh0sb4IjyLTAUZKtqFuG72SOQDtqtfmKQWp1CszjDsep
         YtNQ6NoxtM3EI1VP/v7bX1JcNjhWtigzZjrf80BSd/SwEF2nPlg/Zv+7LVjRa2oTwJ
         lWoLPtkmWppDx449eaJV/eBX0dHplPrxfkLXi1/w=
Date:   Tue, 26 Mar 2019 19:53:38 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86 <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        linux-pm <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -next] x86/apic: Reduce print level of CPU limit
 announcement
Message-ID: <20190326175338.GK22899@mtr-leonro.mtl.com>
References: <20190326120213.28633-1-leon@kernel.org>
 <CAJZ5v0jbb+fEWWHdnZEKNOhUy=ZTsDMxy7Rwahp8O-jpBy-K9w@mail.gmail.com>
 <20190326144137.GB22899@mtr-leonro.mtl.com>
 <CAJZ5v0h1w+ZWV24SnX0g9NZORuVWHnyOjZ9Jue2_yUvvFpJB6g@mail.gmail.com>
 <20190326153235.GH22899@mtr-leonro.mtl.com>
 <CAJZ5v0i2FKvKHZMttJjZR+FY_UGkku-C3=fg9FhNv-OWpu7ayA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="h3LYUU6HlUDSAOzy"
Content-Disposition: inline
In-Reply-To: <CAJZ5v0i2FKvKHZMttJjZR+FY_UGkku-C3=fg9FhNv-OWpu7ayA@mail.gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--h3LYUU6HlUDSAOzy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 26, 2019 at 05:30:22PM +0100, Rafael J. Wysocki wrote:
> On Tue, Mar 26, 2019 at 4:32 PM Leon Romanovsky <leon@kernel.org> wrote:
> >
> > On Tue, Mar 26, 2019 at 04:12:27PM +0100, Rafael J. Wysocki wrote:
> > > On Tue, Mar 26, 2019 at 3:41 PM Leon Romanovsky <leon@kernel.org> wrote:
> > > >
> > > > On Tue, Mar 26, 2019 at 01:29:54PM +0100, Rafael J. Wysocki wrote:
> > > > > On Tue, Mar 26, 2019 at 1:02 PM Leon Romanovsky <leon@kernel.org> wrote:
> > > > > >
> > > > > > From: Leon Romanovsky <leonro@mellanox.com>
> > > > > >
> > > > > > Kernel is booted with less possible CPUs (possible_cpus kernel boot
> > > > > > option) than available CPUs will have prints like this:
> > > > > >
> > > > > > [    1.131039] APIC: NR_CPUS/possible_cpus limit of 8 reached. Processor 55/0x1f ignored.
> > > > > > [    1.132228] ACPI: Unable to map lapic to logical cpu number
> > > > > >
> > > > > > Those warnings are printed for every not-enabled CPU and on the systems
> > > > > > with large number of such CPUs, we see a lot of those prints for default
> > > > > > print level.
> > > > > >
> > > > > > Simple conversion of those prints to be in debug level removes them
> > > > > > while leaving the option to debug system.
> > > > >
> > > > > But generally dynamic debug must be enabled in order for pr_debug()
> > > > > prints to be visible which is kind of cumbersome to do via the command
> > > > > line.
> > > >
> > > > It is doable and documented pretty well, which is uncommon :)
> > > > https://www.kernel.org/doc/html/latest/admin-guide/dynamic-debug-howto.html#debug-messages-during-boot-process
> > >
> > > I know.
> > >
> > > That's what I mean by "kind of cumbersome", because you need to know
> > > which debug messages to enable upfront.
> > >
> > > > >
> > > > > > Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
> > > > > > ---
> > > > > >  arch/x86/kernel/acpi/boot.c | 2 +-
> > > > > >  arch/x86/kernel/apic/apic.c | 6 +++---
> > > > > >  2 files changed, 4 insertions(+), 4 deletions(-)
> > > > > >
> > > > > > diff --git a/arch/x86/kernel/acpi/boot.c b/arch/x86/kernel/acpi/boot.c
> > > > > > index 8dcbf6890714..3ef8ab89c02d 100644
> > > > > > --- a/arch/x86/kernel/acpi/boot.c
> > > > > > +++ b/arch/x86/kernel/acpi/boot.c
> > > > > > @@ -770,7 +770,7 @@ int acpi_map_cpu(acpi_handle handle, phys_cpuid_t physid, u32 acpi_id,
> > > > > >
> > > > > >         cpu = acpi_register_lapic(physid, acpi_id, ACPI_MADT_ENABLED);
> > > > > >         if (cpu < 0) {
> > > > > > -               pr_info(PREFIX "Unable to map lapic to logical cpu number\n");
> > > > > > +               pr_debug(PREFIX "Unable to map lapic to logical cpu number\n");
> > > > >
> > > > > And this one is printed sometimes when something really goes wrong
> > > > > which may be really hard to debug otherwise, so there is value in the
> > > > > info level here.
> > > > >
> > > > > Would it be possible to avoid printing it just in some cases?
> > > >
> > > > This can do the trick:
> > > >
> > > > diff --git a/arch/x86/kernel/acpi/boot.c b/arch/x86/kernel/acpi/boot.c
> > > > index 3ef8ab89c02d..00212b3991e0 100644
> > > > --- a/arch/x86/kernel/acpi/boot.c
> > > > +++ b/arch/x86/kernel/acpi/boot.c
> > > > @@ -770,7 +770,10 @@ int acpi_map_cpu(acpi_handle handle, phys_cpuid_t physid, u32 acpi_id,
> > > >
> > > >         cpu = acpi_register_lapic(physid, acpi_id, ACPI_MADT_ENABLED);
> > > >         if (cpu < 0) {
> > > > -               pr_debug(PREFIX "Unable to map lapic to logical cpu number\n");
> > > > +               if (cpu == -ENOENT)
> > > > +                       pr_debug(PREFIX "Unable to map lapic to logical cpu number\n");
> > >
> > > I don't think it is necessary to print this in the -ENOENT case, as
> > > there is a message for that case that will be printed anyway.
> >
> > Agree, how do you want me to progress? Should I resend patch?
>
> Yes, please.

I looked in the code and seems like there is one place only in acpi_register_lapic() which returns
EINVAL without any debug prints and that flow can't be because we are providing ACPI_MADT_ENABLED
as an input.

It looks like that we can safely remove the print from acpi_map_cpu().

Thanks

--h3LYUU6HlUDSAOzy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJcmmciAAoJEORje4g2cling8kP/iUYQgumQgx58xkSnNyck74T
NQvusFOsYFmTCpWw9gpa214WJMTvY6GT7O5sJRprjN2r8XkqPZSCN+TZf5KTzEdb
3GoFudZ3ACwSubeoOF/A/2/YTKfe6NR4YG7HW99gwmmWj5o7YAaWanBMQDxDijdz
Mrt/ux5lyF6xFV1/ySM+liTY0y0SxrygUNGFv3xhr2s3X3cTrQ63A/OfRM0H7MMw
Emq/bRH1c3av6L3rHEeuhqc5gPtAG0h62wOSQKemKWUQQVQJxo65TZ3j5KThNath
Jdhjc6ziVxRVPeuFaJ57bl6OQ+1cgcTHHSgeK0RT57ZDZHXK99KqvE9NO7aGpI/n
klBpuJZAgrZOnrl+8O7vbZyVX4gMn+k73SkEHhnk0oOb4AXOUPAWLbaJ6hNarA+e
484E0NOCvIPTt1jt8ipXdHtD7/kac2xoFgedBwgJPo3sTV1P5vMJvMjZZVY8LK6i
OArDloiW3gSczHabgvWlsXLC8XXn6vGGYRWXxI/LrMRbD9a1Bkmffo5MnTc3WUoE
ggfoGCLxOmPgRrc4ZwF6Y4oASqMy5zhUStT5UmzlseCLaNoHkPKY0y0H3CDNyzsV
DpwkZMu8zcX5vLW6vYxCFX3vqn9NPVSuMRyEEcJQ8UcFMD0JgSh0+n4ciu26re3d
0+ht0gA8ZuPU89h7p7Od
=7TMX
-----END PGP SIGNATURE-----

--h3LYUU6HlUDSAOzy--
