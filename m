Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8FE7C7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 00:31:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DE5D20644
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 00:31:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="GroEowRP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726431AbfG2Abi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Jul 2019 20:31:38 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:40055 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726216AbfG2Abh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Jul 2019 20:31:37 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45xgbp5h33z9s3l;
        Mon, 29 Jul 2019 10:31:34 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1564360295;
        bh=+JTon61vz1+YQHFE94AbS2eZpOMWfyvWSxXSDsfyxy8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=GroEowRPhDqwkchQUSkgl6VRvtoatP01fbTBL+bZv7bh/2Jo+prb+Tp1EkMoSVOnc
         3ZCWekF1FZPMOfYCl+k+ZLz71r2Ekxd33NhaJeqdgbw3d7tJ0laAGlMbL17XliBkyF
         oexSKAHtAO7CzBfnZ4x5riOnxLXj0B+uo3wWJSKqaaT9f3zKSea9iw/dnj2cWBBkxy
         84lzGhPrb5D+lcOpuMzp/1TrfbTX+HnikV2EH+7rdynUv9yX1QHSWq7j3sQF/y97Dv
         oXpd4WzBbIU2Yh1hKKRAqwcGTYZ6wBdaTKqFXj6sC9VVDIvjrbnwNWWlk5kPGEcZ2t
         xuKLaHVFdP3bg==
Date:   Mon, 29 Jul 2019 10:31:33 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Intel Graphics <intel-gfx@lists.freedesktop.org>,
        DRI <dri-devel@lists.freedesktop.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Imre Deak <imre.deak@intel.com>
Subject: Re: linux-next: manual merge of the drm-intel tree with the
 kspp-gustavo tree
Message-ID: <20190729103133.5a3deb85@canb.auug.org.au>
In-Reply-To: <20190723110331.1967d000@canb.auug.org.au>
References: <20190723110331.1967d000@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/DqgcD_x8eYr0_R2i9O0jMTP";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/DqgcD_x8eYr0_R2i9O0jMTP
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Tue, 23 Jul 2019 11:03:31 +1000 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> Today's linux-next merge of the drm-intel tree got a conflict in:
>=20
>   drivers/gpu/drm/i915/display/intel_dp.c
>=20
> between commit:
>=20
>   b6ac32eac063 ("drm/i915: Mark expected switch fall-throughs")

This is now commit

  2defb94edb44 (""drm/i915: Mark expected switch fall-throughs")

from Linus' tree.

> from the kspp-gustavo tree and commit:
>=20
>   bc85328ff431 ("drm/i915: Move the TypeC port handling code to a separat=
e file")
>   4f36afb26cbe ("drm/i915: Sanitize the TypeC FIA lane configuration deco=
ding")
>=20
> from the drm-intel tree.
>=20
> I fixed it up (bc85328ff431 moved the function updated by b6ac32eac063
> and 4f36afb26cbe added an equivalent fixup) and can carry the fix as
> necessary. This is now fixed as far as linux-next is concerned, but any
> non trivial conflicts should be mentioned to your upstream maintainer
> when your tree is submitted for merging.  You may also want to consider
> cooperating with the maintainer of the conflicting tree to minimise any
> particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/DqgcD_x8eYr0_R2i9O0jMTP
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl0+PmUACgkQAVBC80lX
0Gz6bQf+KJXRHgo9OonMtR1Pc5z36XAnT9kMF0gp1cqGpTIdX0avC7dzI/tkcpS1
hdUOEYF1oc0DHbeb1HHWyRjfoPUgL9EUJwxCATyOuFv7V3UKbTxOZ3N5wSC1z5Yb
lA8IiuOW9xkyf4Pbf6BOYCErtzyicskwARI3AzW7qCHgRe3+WpGaV6LayJzuOcX6
TRefqb/dFGeo2ly9mkvcPpY8CgT5rKCjWchgbGICNqyGH9LMMH2jIxIfyXjV09AX
q9sXlyVxeJTNP8Eqpb2C/TBbaceCvRNt3/iLpuL4ZYdFr4QaMVJvOj6accgzpvCV
p3EWr5ky/iGRDcekwNbkyVVmsMEz1A==
=TFsE
-----END PGP SIGNATURE-----

--Sig_/DqgcD_x8eYr0_R2i9O0jMTP--
