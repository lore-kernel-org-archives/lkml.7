Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8DE8C10F0B
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 14:13:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D0DE2084C
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 14:13:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727398AbfDCOM7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 10:12:59 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:52020 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726105AbfDCOM7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 10:12:59 -0400
Received: from [167.98.27.226] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1hBgdN-0005XX-HX; Wed, 03 Apr 2019 15:12:57 +0100
Received: from ben by deadeye with local (Exim 4.92)
        (envelope-from <ben@decadent.org.uk>)
        id 1hBgdM-0000FY-VS; Wed, 03 Apr 2019 15:12:56 +0100
Message-ID: <d94ae606a6770faa019a867579dda34a8c7c5606.camel@decadent.org.uk>
Subject: Re: [PATCH 3.16 00/99] 3.16.65-rc1 review
From:   Ben Hutchings <ben@decadent.org.uk>
To:     Guenter Roeck <linux@roeck-us.net>, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        Denis Kirjanov <kda@linux-powerpc.org>
Date:   Wed, 03 Apr 2019 15:12:48 +0100
In-Reply-To: <af7bb5af-f0d1-d499-98b9-4c49d11aa39d@roeck-us.net>
References: <lsq.1554212307.17110877@decadent.org.uk>
         <af7bb5af-f0d1-d499-98b9-4c49d11aa39d@roeck-us.net>
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="=-Ss5XdWD7k2Mv0gt8wSOC"
User-Agent: Evolution 3.30.5-1 
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 167.98.27.226
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-Ss5XdWD7k2Mv0gt8wSOC
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2019-04-02 at 19:22 -0700, Guenter Roeck wrote:
> On 4/2/19 6:38 AM, Ben Hutchings wrote:
> > This is the start of the stable review cycle for the 3.16.65 release.
> > There are 99 patches in this series, which will be posted as responses
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> >=20
> > Responses should be made by Thu Apr 04 13:38:27 UTC 2019.
> > Anything received after that time might be too late.
> >=20
>=20
> For v3.16.64-99-gfff72cd6bb56:
>=20
> Build results:
> 	total: 137 pass: 132 fail: 5
> Failed builds:
> 	arm:allmodconfig
> 	i386:tools/perf
> 	powerpc:ppc64e_defconfig
> 	powerpc:cell_defconfig
> 	powerpc:maple_defconfig
> Qemu test results:
> 	total: 222 pass: 210 fail: 12
> Failed tests:
> 	ppc64:mac99:ppc64_book3s_defconfig:nosmp:initrd
> 	ppc64:mac99:ppc64_book3s_defconfig:smp:initrd
> 	ppc64:mac99:ppc64_book3s_defconfig:smp:ide:rootfs
> 	ppc64:mac99:ppc64_book3s_defconfig:smp:mmc:rootfs
> 	ppc64:mac99:ppc64_book3s_defconfig:smp:nvme:rootfs
> 	ppc64:mpc8544ds:ppc64_e5500_defconfig:nosmp:initrd
> 	ppc64:mpc8544ds:ppc64_e5500_defconfig:smp:initrd
> 	ppc64:ppce500:corenet64_smp_defconfig:e5500:initrd
> 	ppc64:ppce500:corenet64_smp_defconfig:e5500:nvme:rootfs
> 	ppc64:ppce500:corenet64_smp_defconfig:e5500:mmc:rootfs
> 	ppc64:ppce500:corenet64_smp_defconfig:e5500:scsi[53C895A]:rootfs
> 	ppc64:ppce500:corenet64_smp_defconfig:e5500:sata-sii3112:rootfs
>=20
>=20
> sound/pci/hda/hda_tegra.c: In function 'hda_tegra_suspend':
> sound/pci/hda/hda_tegra.c:256:25: error: implicit declaration of function=
 'azx_bus'
>=20
> arch/powerpc/kernel/signal_64.c: In function 'sys_rt_sigreturn':
> arch/powerpc/kernel/signal_64.c:713:7: error: 'msr' undeclared

Thanks, I've pushed build fixes (I think) for these two.

Ben.

--=20
Ben Hutchings
Q.  Which is the greater problem in the world today,
    ignorance or apathy?
A.  I don't know and I couldn't care less.



--=-Ss5XdWD7k2Mv0gt8wSOC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErCspvTSmr92z9o8157/I7JWGEQkFAlykv2AACgkQ57/I7JWG
EQncRQ/+KfU/rF7kGvh5AAKRYzp4iKM/Fga6p7s8MF/GwSZSFcvLH4+SPcHg36rf
+4fVTcrOn9JxddjdTX96zlJrtfJeINnPVXPUCWtXhP22q9RD7XTOa3ovD686lC/X
EBYPK0uPXOfI49EV5Bh6GbRZr37OzZ1psYCAOSImHDppaZRVQPR/zH5LlGqrPJVs
TMZu/nEU0TbPZGjiAOgRSQjkfQJyYVFLxsWy+dOZqmNvA3DdHG6Ix1wEhsB7cgyp
Nc6+UG+HFFIGyhQAvyFvdLB8AQzommCa/jyQ5E7pXuxrC9AaAGl6CJXx/Z6cPlSD
KDjhcmLS50EBRFdl/n+Kcte/lxPRL0m0iPs2ADFf3THUR5vbvtkagnxSdB/Z+ELr
sOHnwXjxgi/5onyFyertWIoIPQ8eKbSr+upBJ49XPVqlLUHMlTGt7YobF1acey9h
ifebawx0uYcA3hT/sVu1huvWRArPhEPUXV7m4y0jPb711zH4VCMRVvPdi0tUG/cW
GrjyNwBUeC0jemTLI6oUuJDWnUX9RkxEjPUwLdfEgbkuZUfRqG6QpITNNCg6HMBs
AmEm+VMWX1Ms5i/1Q8JLr8uygNjlEjxnK3RXi2fNXNh9aleiXmXQVnOswzvwLTjV
dE2IumiFK8Pe1EkTTA6bBSHOnpzSrDpkM3biUurGAFp1tdweVe4=
=62G8
-----END PGP SIGNATURE-----

--=-Ss5XdWD7k2Mv0gt8wSOC--
