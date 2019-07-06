Return-Path: <SRS0=CMjL=VD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04097C468AD
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Jul 2019 10:17:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D089F21670
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Jul 2019 10:17:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="b7vHXtwZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726053AbfGFKRf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Jul 2019 06:17:35 -0400
Received: from ozlabs.org ([203.11.71.1]:55637 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725934AbfGFKRf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Jul 2019 06:17:35 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45gnhW5FR1z9sNH;
        Sat,  6 Jul 2019 20:17:31 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1562408251;
        bh=AkBkKuvoUszo/2p12KAGs/crBCu2b11bqfRt75EiBdA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=b7vHXtwZJ9ySr6nc4QvNapA1Z8eOwzSVk26y5VjecyWBEeGJfKUgHRDzNWI6M/G9i
         42tL2U/2oQxtiltY6CHJzeEz7RAMno3XS0SJWaBJSeRFdcehW22CZwxMHhQPifGcve
         lFfoEytyHZtdTjOc9lY53ltpgBtP0hkqmP5TfQcUQFinxD1pBiyPWYcwqnPiqTopoE
         ARMKlxXf0Cu7+IqNw7NFZ07MXhoRpggQz+Lh4dNywCTvjRmVTvfZha5Pd7D721Inuq
         LdkMmzQAU9VRqLh+BBiH5s53b1aZJ0dh+fkxjsBVHjw0kQQfhYL+Se1rOg/1YNkbNs
         3ZS4KW1RMjSOg==
Date:   Sat, 6 Jul 2019 20:17:29 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: linux-next: Tree for Jul 4
Message-ID: <20190706201729.48548ede@canb.auug.org.au>
In-Reply-To: <20190706094647.GA17929@kroah.com>
References: <20190704220945.27728dd9@canb.auug.org.au>
        <20190704222450.021c9d71@canb.auug.org.au>
        <20190706083433.GB9249@kroah.com>
        <20190706194412.64c15c42@canb.auug.org.au>
        <20190706094647.GA17929@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/P/pgJNsB/CxxTA7Im0mlgh5"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/P/pgJNsB/CxxTA7Im0mlgh5
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Greg,

On Sat, 6 Jul 2019 11:46:47 +0200 Greg Kroah-Hartman <gregkh@linuxfoundatio=
n.org> wrote:
>
> On Sat, Jul 06, 2019 at 07:44:12PM +1000, Stephen Rothwell wrote:
> >=20
> > On Sat, 6 Jul 2019 10:34:33 +0200 Greg Kroah-Hartman <gregkh@linuxfound=
ation.org> wrote: =20
> > >
> > > On Thu, Jul 04, 2019 at 10:24:50PM +1000, Stephen Rothwell wrote: =20
> > > >=20
> > > > This release produces a whole lot (over 200) of this message in my =
qemu
> > > > boot tests:
> > > >=20
> > > > [    1.698497] debugfs: File 'sched' already present!
> > > >=20
> > > > Introduced by commit
> > > >=20
> > > >   43e23b6c0b01 ("debugfs: log errors when something goes wrong")
> > > >=20
> > > > from the driver-core tree.  I assume that the error(?) was already
> > > > happening, but it is now being reported.   =20
> > >=20
> > > What are you passing to qemu to get this?  I just tried it myself and
> > > see no error reports at all.  Have a .config I can use to try to
> > > reproduce this? =20
> >=20
> > It is a powerpc pseries_le_defconfig kernel and I run qemu like this:
> >=20
> > qemu-system-ppc64 -M pseries -m 2G -vga none -nographic -kernel vmlinux=
 -initrd rootfs.cpio.gz =20
>=20
> Hm, I think my rootfs initrd might be quite simple compared to yours (it
> drops me into a busybox shell).  Any pointers to where you created yours
> from?

Michael Ellerman gave it to me.  It is very simple.  Its /init is just

$ cat init
#!/bin/sh
# devtmpfs does not get automounted for initramfs
/bin/mount -t devtmpfs devtmpfs /dev
exec 0</dev/console
exec 1>/dev/console
exec 2>/dev/console
exec /sbin/init $*

and /sbin/init is a link to /bin/busybox

It is all run by an expect script that just waits for the login:
prompt, logs in a root and runs "halt".

All the debugfs messages appear before the kernel finished booting.
--=20
Cheers,
Stephen Rothwell

--Sig_/P/pgJNsB/CxxTA7Im0mlgh5
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl0gdTkACgkQAVBC80lX
0GxtMwgAg65k4ek0yHkqfCBG5PI9RuZtSI0V6Uej7ZTeOsREdXsphNAqdrNdsaaQ
f1I7g1Myw+HhY/j/NiWC6BNvdc78y3XqkiwhvwWnW5EHto+Fx9qtWEnIY2JB0xEn
myCBt9EpYCMYVaoMxOZ1RHKUAJ5uavJRoQAHCltiarvJIYrvAIE0vuUqk4Xbd1GK
tB9WZOQLbC3pvYlW+SFu/RtQmepWDNgv3iq4YJpU2MiYfAXvX1Fotqc3uSWCHaX6
jRTtCiMFedZvnR1DYyEa1Zk5nh3bY5E5ZdGcXHwvUIwx3EV9BKrk5fAiG9pmj5c4
k+63Prnj1+XZmElMZO5jNV1/iEpbuA==
=LkZ1
-----END PGP SIGNATURE-----

--Sig_/P/pgJNsB/CxxTA7Im0mlgh5--
