Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7B84C433FF
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 04:56:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79F64217F4
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 04:56:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="aoktEEZS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727060AbfHEE4m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 00:56:42 -0400
Received: from ozlabs.org ([203.11.71.1]:44983 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725782AbfHEE4m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 00:56:42 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 46258R3JH2z9s7T;
        Mon,  5 Aug 2019 14:56:39 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1564980999;
        bh=p8BMlV7M4nkyaQOehup2eIdyDBxqmogaxnZMP6CJ71g=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=aoktEEZSTrNzUtqIiuiwhwHtbWNOeZu6ucL0Uw0RyKU+HEDDPzCRMxupIpX4DenN7
         qm+VrLHgEsJ3pm45E0auRKP9cbHe18cVxUKYME/YGMRt0wCVm3aQuVmb12dX8Fvyv+
         4MJeKDn12KNJJZPstKi/6FEulpKPbskm7fo+KbKhG8tQhnYaB9HUnahsom/qTvdA9d
         1GQ+6K7EjWXQDsjkNGyPAHZiGekOmkAeAsScY1XhI32M/avNWVHP9L/Ji6OB4x9h6s
         Npuop2iUZ3Ut+Lw3B2dEm1YBfw8j1o3VD58mI2tcSrGZG+Ifi6y6fYrEt2Ez6oQh3c
         whYv46RNNXUQA==
Date:   Mon, 5 Aug 2019 14:56:38 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Greg KH <greg@kroah.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Saravana Kannan <saravanak@google.com>
Subject: Re: linux-next: build warning after merge of the driver-core tree
Message-ID: <20190805145638.222e58b1@canb.auug.org.au>
In-Reply-To: <20190805130403.06dc27b4@canb.auug.org.au>
References: <20190805130403.06dc27b4@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/4PfON9VtgcPaDTbu955TQ=_";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/4PfON9VtgcPaDTbu955TQ=_
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Mon, 5 Aug 2019 13:04:03 +1000 Stephen Rothwell <sfr@canb.auug.org.au> w=
rote:
>
> After merging the driver-core tree, today's linux-next build (powerpc
> ppc64_defconfig) produced this warning:
>=20
> drivers/of/platform.c:674:12: warning: 'of_link_to_suppliers' defined but=
 not used [-Wunused-function]
>  static int of_link_to_suppliers(struct device *dev)
>             ^~~~~~~~~~~~~~~~~~~~
>=20
> Introduced by commit
>=20
>   690ff7881b26 ("of/platform: Add functional dependency link from DT bind=
ings")

It also produced this warning:

drivers/of/platform.c: In function 'of_link_property':
drivers/of/platform.c:650:18: warning: ?: using integer constants in boolea=
n context [-Wint-in-bool-context]
  return done ? 0 : -ENODEV;

--=20
Cheers,
Stephen Rothwell

--Sig_/4PfON9VtgcPaDTbu955TQ=_
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl1HtwYACgkQAVBC80lX
0GyyJgf/bzKrhKVCAa2puKBZfCT3dn6q6UHG7YthvIrDFHur08h8LX+xbyl9LGaR
oagxjiGkHOdReuklsvqcxH1L8/0zveAW+XSAw6iES98HlcM4j5RQUr5yMU9w1WJm
b7uPTFiLhs/skr6+lgB6IpXGoYX5/jIU26f5DpFGbOQCMJ6NqcsTKjxbNFjGG2Gp
7JbWYdjbkdykOiMbRBDau21aen2WnCYlD6HcBJkY/ot2AMUhrZdAGQQ3rI0R+lft
RC7GPfcXUu4uuWlhhYTV+EBivyyvTLcK0FZMRTUwkq9G4XaVcSHijxG6ykPIrh9s
gkqD1mTYrB0GqHT8/yoTjYvQoIOxJg==
=k5qX
-----END PGP SIGNATURE-----

--Sig_/4PfON9VtgcPaDTbu955TQ=_--
