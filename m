Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIM_ADSP_ALL,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B291C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 19:05:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A39620675
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 19:05:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cs.msu.ru header.i=@cs.msu.ru header.b="QCNSxpKa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726536AbfCGTFo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 14:05:44 -0500
Received: from imap.cs.msu.ru ([188.44.42.39]:64541 "EHLO mail.cs.msu.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726318AbfCGTFn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 14:05:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=cs.msu.ru;
         s=dkim; h=Subject:In-Reply-To:Content-Type:MIME-Version:References:
        Message-ID:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=07ZT7sdwBOVBcsFDW6KEYrhfpu5RXTx8PWmnMddWpAc=; b=QCNSxpKaVt7aucbD4aWZKk4ejB
        qG0kAPQdl/7rQAsLIobKdmc+fF4GKure/ojaj+V039ovMlhyX7aTA9rHuivDXPuqg1yhjb7LhxbOQ
        ZG0nuyYEyPPNaUgFePgNGIBPjaGu0hA5cATIiajwCEc79w6k8TMxDwFQ6K0HPmc6uVVUcNvCF93bZ
        0/9mu6smBw39wpvWhBxfe6EyXAfchG4O9AuFN7Cg32pscW/ptC/sqgSa/ain/e9QZc8ITxJm+m7vc
        ykM6ClIO3aLv8OHfRSb60SpNwULvJUF6LUA4gjR6KBhVvsZdXtm4aGIwucOvKrTUKBCrBethQJGtj
        DxfgfOjw==;
Received: from [10.7.4.141] (port=33306 helo=cello)
        by mail.cs.msu.ru with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.91 (FreeBSD))
        (envelope-from <ar@cs.msu.ru>)
        id 1h1yKk-000Lth-0O; Thu, 07 Mar 2019 22:05:34 +0300
Date:   Thu, 7 Mar 2019 22:05:30 +0300
From:   Arseny Maslennikov <ar@cs.msu.ru>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Michal Marek <michal.lkml@markovi.net>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Riku Voipio <riku.voipio@linaro.org>
Message-ID: <20190307190530.GA25561@cello>
References: <20190221215901.23970-1-ar@cs.msu.ru>
 <CAK7LNAQrN1e1GYRd760pWiAdgY9_7Jda3QD_zozTNHpHOim4Xg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="d6Gm4EdcadzBjdND"
Content-Disposition: inline
In-Reply-To: <CAK7LNAQrN1e1GYRd760pWiAdgY9_7Jda3QD_zozTNHpHOim4Xg@mail.gmail.com>
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


--d6Gm4EdcadzBjdND
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 08, 2019 at 12:32:11AM +0900, Masahiro Yamada wrote:
> On Fri, Feb 22, 2019 at 7:19 AM Arseny Maslennikov <ar@cs.msu.ru> wrote:
> >
> > It is widely known that one can build a kernel without a .config in the
> > source tree
>=20
> "without a .config in the source file"  means
> KCONFIG_CONFIG will probably contain '..' or absolute path.
>=20
>=20
>=20
> ex1)  KCONFIG_CONFIG=3D../my_dir/.config
>=20
> ex2)  KCONFIG_CONFIG=3D/absolute/pass/to/my/.config
>=20

Hmm, I did not consider that; my bad, sorry.

>=20
>=20
>=20
>=20
> > by setting KCONFIG_CONFIG equal to the actual configuration
> > file path.
> >
> > When making a *-pkg target, make(1) prepares a source tarball and tries
> > to pack `.config' in there regardless of the value of KCONFIG_CONFIG,
> > failing spectacularly if .config is absent and packing the wrong config
> > if it exists.
> > Let's fix that.
>=20
>=20
> Did you notice the log 'Removing leading ...' from tar
> for case ex1), ex2) ?
>=20
>=20
> masahiro@grover:~/ref/linux$ make -j8  KCONFIG_CONFIG=3D../.config  deb-p=
kg
> make clean
> /bin/bash ./scripts/package/mkdebian
>   TAR     linux-5.0.0+.tar.gz
> tar: Removing leading `../' from member names

Yes, I know tar does that. I mostly use KCONFIG_CONFIG with a bunch of
config files in the source tree, so did not experience this while making
sure the change makes sense.

>    ...
>=20
>=20
> Even if I apply 3/3, it will produce a broken source package
> since the tar will rip off the leading directory path,
> then it mismatches to KCONFIG_CONFIG recorded in debian/rules.
>=20
> A simple case like KCONFIG_CONFIG=3Dmy.config will work,
> but I am not convinced with 3/3.
>=20

So instead of this one and 3/3 we could ensure the source tarball
contains a .config equal to the contents of KCONFIG_CONFIG provided to
make(1), so the source package is fixed and its users are not confused.

If the following is ok, I'll send a v2.
A quick look at the generated orig tarball tells me it ought to work
well.

Something like this:

diff --git a/scripts/package/Makefile b/scripts/package/Makefile
index 100a0d28ad25..8530fe267a76 100644
--- a/scripts/package/Makefile
+++ b/scripts/package/Makefile
@@ -44,6 +44,7 @@ if test "$(objtree)" !=3D "$(srctree)"; then \
 fi ; \
 $(srctree)/scripts/setlocalversion --save-scmversion; \
 tar -cz $(RCS_TAR_IGNORE) -f $(2).tar.gz \
+	--absolute-names --transform 's:^$(KCONFIG_CONFIG):.config:S' \
 	--transform 's:^:$(2)/:S' $(TAR_CONTENT) $(3); \
 rm -f $(objtree)/.scmversion
=20

--d6Gm4EdcadzBjdND
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE56JD3UKTLEu/ddrm9dQjyAYL01AFAlyBa3QACgkQ9dQjyAYL
01CxSw/9HJEvBrWN5BU6rEohXfDzq1odRKDg/VVHBaogxpUilnCMhg79UPyTr2Te
Wl9Nobm4merPTYI94gHkYPNOV40Fk649cvfFq/zVJc0bna/SG1r3mDsJsGjaeeLF
/6LNpJslkCVS1+EStvKkkdTAPNVChMjkISCyRNR8LffXGnh8dJbBPNeB9SwSd41N
1BiVWWm4nx1Ol479jYzHdETpn3uQLectT/YrCienqQJdPKTsEfvdnCj/nu8Bhte1
Ztbwe2dAlxeM2+E57vvnT5vzLTxsCt7Sn3LycPbM+42cl9EQwcPt56eKAk7+DSe1
zRZ9RaKG9VMz7kiBd9HJZX0UsDKoMcZWHgOeqxlpZ6g849R//FMwM/K2M1dW4RTS
fQHDkBzklglbSd35OB7Fdi5YG/gYltD1hpjHht1yhECPjquNbJMkMz+S7Cqyox8M
TRUuqpwjJXS+RfVHp9rtaqB4Wv8XxArVkyQbJLhlWOo1wIM/IzCR2QjfJC6hSRIH
jB1/Qrh0kqLadjMmHcxTKk2J8hRG93W+79UPPcuVBaEWYUsUerKlSG9EVdWOwqxE
4WNujYXr0nWcjCjUFupJaPafc9KKDvnwZGzxFZ9ixpH2JzLPrr9niXfZAElJbn2a
IhtbTCb7FwpQZhzYEGtv4LGcf2YCFIxxmpdAiSlhHstSt52/8oQ=
=/0Sk
-----END PGP SIGNATURE-----

--d6Gm4EdcadzBjdND--
