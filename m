Return-Path: <SRS0=fBTF=VC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 734BCC0651F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 03:14:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47EF5216E3
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 03:14:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="GhC55MLd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727770AbfGEDOm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jul 2019 23:14:42 -0400
Received: from ozlabs.org ([203.11.71.1]:35949 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726404AbfGEDOm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 23:14:42 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45g0M01Bpkz9sCJ;
        Fri,  5 Jul 2019 13:14:36 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1562296478;
        bh=9605ZP4bn3MDqq1dxNaUUk8pwn4UP4BwvE48o+dZvLc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=GhC55MLdQI6+V6yk9r3D9bck989EmS1gkht04wQVl4SzEPMOQYHM/P5vA63uV7sqg
         FN+idxpEy1o7z/fQ33UoAB7/CqSXXme3SgQrm0EIAYsAVnWT4VXNRh+aCNM7xZiwOh
         wIextEEub2oHRaqXTc+x6FzGXhtvwK3ly1PNvJurf4J43hMZJ37/caL8YSp5W8PNTI
         EEJOFnmWsUbaWQ+0RRkYBowGKqsPL9Uy3JWkfYLYXGRfv7NIWOTi+s2IrIuSWkiNkr
         P5fYU/z0+rTc5hjbZExP4Q+2OsKXy8bD3CoYWNRAwIR6BXe6faQASmYntNmoEtbEeX
         XJ1xe+wWT0B2Q==
Date:   Fri, 5 Jul 2019 13:14:35 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mark Brown <broonie@kernel.org>, linux-fsdevel@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mm@kvack.org,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        mhocko@suse.cz, mm-commits@vger.kernel.org,
        Michal Wajdeczko <michal.wajdeczko@intel.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Intel Graphics <intel-gfx@lists.freedesktop.org>,
        DRI <dri-devel@lists.freedesktop.org>,
        Chris Wilson <chris@chris-wilson.co.uk>
Subject: Re: mmotm 2019-07-04-15-01 uploaded (gpu/drm/i915/oa/)
Message-ID: <20190705131435.58c2be19@canb.auug.org.au>
In-Reply-To: <CAK7LNAQc1xYoet1o8HJVGKuonUV40MZGpK7eHLyUmqet50djLw@mail.gmail.com>
References: <20190704220152.1bF4q6uyw%akpm@linux-foundation.org>
        <80bf2204-558a-6d3f-c493-bf17b891fc8a@infradead.org>
        <CAK7LNAQc1xYoet1o8HJVGKuonUV40MZGpK7eHLyUmqet50djLw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/cNeLSVReMpluqwcRRAFLlp8"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/cNeLSVReMpluqwcRRAFLlp8
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Masahiro,

On Fri, 5 Jul 2019 12:05:49 +0900 Masahiro Yamada <yamada.masahiro@socionex=
t.com> wrote:
>
> On Fri, Jul 5, 2019 at 10:09 AM Randy Dunlap <rdunlap@infradead.org> wrot=
e:
> >
> > I get a lot of these but don't see/know what causes them:
> >
> > ../scripts/Makefile.build:42: ../drivers/gpu/drm/i915/oa/Makefile: No s=
uch file or directory
> > make[6]: *** No rule to make target '../drivers/gpu/drm/i915/oa/Makefil=
e'.  Stop.
> > ../scripts/Makefile.build:498: recipe for target 'drivers/gpu/drm/i915/=
oa' failed
> > make[5]: *** [drivers/gpu/drm/i915/oa] Error 2
> > ../scripts/Makefile.build:498: recipe for target 'drivers/gpu/drm/i915'=
 failed
> > =20
>=20
> I checked next-20190704 tag.
>=20
> I see the empty file
> drivers/gpu/drm/i915/oa/Makefile
>=20
> Did someone delete it?

Commit

  5ed7a0cf3394 ("drm/i915: Move OA files to separate folder")

from the drm-intel tree seems to have created it as an empty file.

--=20
Cheers,
Stephen Rothwell

--Sig_/cNeLSVReMpluqwcRRAFLlp8
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl0ewJsACgkQAVBC80lX
0GzYcQf+OqWJhVTJLbJLiBqRgQanYK7S/8DokAFj+dkgb9foQZIjp8ln1by3QDXg
gGAcxB9xEuIW1oxR6QUXlrWJtEJuC55Ka6LHo9DzUxF1ul9WgHLnWftKegzKG6+d
5mcol7HG8rVryx7FeEErXxZmubGS/Ws/1kh8KuZriCw2bgyZFp4Y73gqwrfGi7Pl
+PDWw1W9dnZj+mrwFMFGOA7CTKFab2paP+YOXTjrdjc0QxzaCNZjBpjT1Mo0nNbm
IJQwtCSQWTmLwfK+GEuxAQO3Z37B92G9ckWHqysmubvaWpYop3V2QUUN0PKfPdgN
s/qoynBRgRZo5pZ+E+9pICS8pwhjSQ==
=Z/Nz
-----END PGP SIGNATURE-----

--Sig_/cNeLSVReMpluqwcRRAFLlp8--
