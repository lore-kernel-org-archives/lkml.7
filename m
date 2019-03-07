Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIM_ADSP_ALL,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1202C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 19:08:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84B6520851
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 19:08:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cs.msu.ru header.i=@cs.msu.ru header.b="ZWauMF/F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726585AbfCGTI4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 14:08:56 -0500
Received: from imap.cs.msu.ru ([188.44.42.39]:56888 "EHLO mail.cs.msu.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726127AbfCGTIz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 14:08:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=cs.msu.ru;
         s=dkim; h=Subject:In-Reply-To:Content-Type:MIME-Version:References:
        Message-ID:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=ss6jH3fjMGzoHPAO2XvQXJY8wHC7mTWtZ7vaD6+SRd0=; b=ZWauMF/FsxhRYTzUEb/ijG5VnL
        1v4t1Pcw4ySg2uLsiBj1pighu7Rf2lyn6q2mEALUOpufYqKLi8mLXhv+e0uEOKu9cAKoWgaLB/yjE
        0ZZoaNxFIZ01048tELzDnvLjGssSTCrTQ5EoNBWkmrCbGzl4COKsbwExqOwblo6E7VvX2PVfHXC/d
        NtV73trUHWCMmiMCNhea8R7z18KZ5L0Ivapfu/PibRhL3GOt3u0T/Z/tipP0s6t+LinvbkG4i2p0M
        JyNqlmLWQlWuJrj7qBb2kxCh4fhe10eSQ7+FzmQsW/ssEGvN6NK9LuYDQBOaAtBLik/f/2BCEP0D2
        OpTQoRgA==;
Received: from [10.7.4.141] (port=33308 helo=cello)
        by mail.cs.msu.ru with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.91 (FreeBSD))
        (envelope-from <ar@cs.msu.ru>)
        id 1h1yNu-0003Bv-MS; Thu, 07 Mar 2019 22:08:50 +0300
Date:   Thu, 7 Mar 2019 22:08:49 +0300
From:   Arseny Maslennikov <ar@cs.msu.ru>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Michal Marek <michal.lkml@markovi.net>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Riku Voipio <riku.voipio@linaro.org>
Message-ID: <20190307190849.GB25561@cello>
References: <20190221215901.23970-1-ar@cs.msu.ru>
 <CAK7LNAQrN1e1GYRd760pWiAdgY9_7Jda3QD_zozTNHpHOim4Xg@mail.gmail.com>
 <20190307190530.GA25561@cello>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="TakKZr9L6Hm6aLOc"
Content-Disposition: inline
In-Reply-To: <20190307190530.GA25561@cello>
OpenPGP: url=http://grep.cs.msu.ru/~ar/pgp-key.asc
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: 10.7.4.141
X-SA-Exim-Mail-From: ar@cs.msu.ru
Subject: Re: [PATCH] scripts/package/Makefile: put proper config in source
 tarball
X-SA-Exim-Version: 4.2
X-SA-Exim-Scanned: Yes (on mail.cs.msu.ru)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--TakKZr9L6Hm6aLOc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 07, 2019 at 10:05:30PM +0300, Arseny Maslennikov wrote:
> On Fri, Mar 08, 2019 at 12:32:11AM +0900, Masahiro Yamada wrote:
> > On Fri, Feb 22, 2019 at 7:19 AM Arseny Maslennikov <ar@cs.msu.ru> wrote:
> > >
> > > It is widely known that one can build a kernel without a .config in t=
he
> > > source tree
> >=20
> > "without a .config in the source file"  means
> > KCONFIG_CONFIG will probably contain '..' or absolute path.
> >=20
> >=20
> >=20
> > ex1)  KCONFIG_CONFIG=3D../my_dir/.config
> >=20
> > ex2)  KCONFIG_CONFIG=3D/absolute/pass/to/my/.config
> >=20
>=20
> Hmm, I did not consider that; my bad, sorry.
>=20
> >=20
> >=20
> >=20
> >=20
> > > by setting KCONFIG_CONFIG equal to the actual configuration
> > > file path.
> > >
> > > When making a *-pkg target, make(1) prepares a source tarball and tri=
es
> > > to pack `.config' in there regardless of the value of KCONFIG_CONFIG,
> > > failing spectacularly if .config is absent and packing the wrong conf=
ig
> > > if it exists.
> > > Let's fix that.
> >=20
> >=20
> > Did you notice the log 'Removing leading ...' from tar
> > for case ex1), ex2) ?
> >=20
> >=20
> > masahiro@grover:~/ref/linux$ make -j8  KCONFIG_CONFIG=3D../.config  deb=
-pkg
> > make clean
> > /bin/bash ./scripts/package/mkdebian
> >   TAR     linux-5.0.0+.tar.gz
> > tar: Removing leading `../' from member names
>=20
> Yes, I know tar does that. I mostly use KCONFIG_CONFIG with a bunch of
> config files in the source tree, so did not experience this while making
> sure the change makes sense.
>=20
> >    ...
> >=20
> >=20
> > Even if I apply 3/3, it will produce a broken source package
> > since the tar will rip off the leading directory path,
> > then it mismatches to KCONFIG_CONFIG recorded in debian/rules.
> >=20
> > A simple case like KCONFIG_CONFIG=3Dmy.config will work,
> > but I am not convinced with 3/3.
> >=20
>=20
> So instead of this one and 3/3 we could ensure the source tarball
> contains a .config equal to the contents of KCONFIG_CONFIG provided to
> make(1), so the source package is fixed and its users are not confused.
>=20
> If the following is ok, I'll send a v2.
> A quick look at the generated orig tarball tells me it ought to work
> well.
>=20
> Something like this:
>=20
> diff --git a/scripts/package/Makefile b/scripts/package/Makefile
> index 100a0d28ad25..8530fe267a76 100644
> --- a/scripts/package/Makefile
> +++ b/scripts/package/Makefile
> @@ -44,6 +44,7 @@ if test "$(objtree)" !=3D "$(srctree)"; then \
>  fi ; \
>  $(srctree)/scripts/setlocalversion --save-scmversion; \
>  tar -cz $(RCS_TAR_IGNORE) -f $(2).tar.gz \
> +	--absolute-names --transform 's:^$(KCONFIG_CONFIG):.config:S' \

GNU tar seems to trim the paths of archive members first and only then
consider the --transform rules, so it does not work with
KCONFIG_CONFIG=3D../../my.config and the likes if -P/--absolute-names is
not provided.

>  	--transform 's:^:$(2)/:S' $(TAR_CONTENT) $(3); \
>  rm -f $(objtree)/.scmversion
> =20



--TakKZr9L6Hm6aLOc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE56JD3UKTLEu/ddrm9dQjyAYL01AFAlyBbEEACgkQ9dQjyAYL
01DRqhAA2dHa3Cx65JfXeF4ZDeLbIjUN1Yzvp3Gp3qRcoS1ournITx3P/x247VAw
/jf/MtU5fUq2xKDrrw9qYZaEsxm7D8zqkXR5Ir3y+4ow4EICPXCJ55w94h9evpam
3fKs3W32n/YnIxTvloxn0L5xYz2+d7C1h4RIIMdrCWkBrgNgfy/19RBFqeuU65yj
7wCC457n/aHGdLYwu1ebVIR3I2b59mxS6zL3RfLNFjCj88oaBHMpk59x2OuIlt23
v1urv5UsDuW+vZBCmh1v9PCUQanKTQpw5yJlFCx0VsO2AYN71OX80Stytoum7oq8
5WTx/a3Sz+X7yY5CRV8BExhL6eS2bnBvkHe4hUQIa1xEiDvkmuqLSo6rrgpNcTCI
LfnxVZ5GyM70gGsbXWXapKw+fdH0qyMNuIkb+cVFE/gECkymZZWnlOhwtiIKG2Aw
i7BwLrpun73QiEZJA9XI/LQ4KOBH6RVzQQhXdMPv2kK1JVUfGzsW54ZGEPNEwOMM
mAhGN6ZaCnAs6UJf+MOzTTUR7E5Y++5DbH+3VV6flnewNtrM8SL4a1qqy6WeI2R2
UvP1KxoFWWRSLIu/B2DbL27OcWghrLXy34Mklm4owBwPeKP6Bqo6jTRPcEa1ckIY
VVjqUxX+/GmaOct8LhdckUhjjx9flAI63bvTZIK1SlU+KII2/bM=
=wPvZ
-----END PGP SIGNATURE-----

--TakKZr9L6Hm6aLOc--
