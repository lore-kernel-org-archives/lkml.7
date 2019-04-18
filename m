Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3653C10F0B
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 07:59:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A262B2183F
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 07:59:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="GtmG1vtG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388137AbfDRH7O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 03:59:14 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:57899 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725747AbfDRH7N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 03:59:13 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 44lBML4blCz9s55;
        Thu, 18 Apr 2019 17:59:10 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1555574351;
        bh=AlhUs6IwDSuiAXVwWxkz/i3n97ZHVw6sIkR/gk1uEsc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=GtmG1vtGnfmJlAM69TCUAXMzun3CI+iVvhIMn7MCJWqKzv9IDv8GaYlkonM5aIaxp
         zRESfjwS3mWWzlRSzv/MwKoj8/YMnopfbzup42Dvdphfqd+qfWVJZz/VYUXVPTp9QT
         vGcDiGYyKUE5iLoA+Jo8ymcQJj0KWLGNP5eWjve1dokZLG/UvvSwVmNNliypV3E5N3
         k6RsGhunF6l6h64ToYJuZ2yMMwQymqTWdsmA4XKzMhuguoaw86mH/xIy5BvBFgsrTR
         GRQiWB60fMcPmYHuPHd0Rh8AtRQBB3tGEYDOsEXQI4Sy/v95VSWjLsn/cuagSvmEQv
         S4IP5Gs5BuVvQ==
Date:   Thu, 18 Apr 2019 17:59:09 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Marc Gonzalez <marc.w.gonzalez@free.fr>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Andy Gross <agross@kernel.org>,
        Linux Next <linux-next@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Jeffrey Hugo <jhugo@codeaurora.org>
Subject: Re: linux-next: manual merge of the phy-next tree with the qcom
 tree
Message-ID: <20190418175909.76f16930@canb.auug.org.au>
In-Reply-To: <d194fa50-8bff-544e-eb88-128810f525f9@free.fr>
References: <20190418152954.255015e1@canb.auug.org.au>
        <d194fa50-8bff-544e-eb88-128810f525f9@free.fr>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/+AshyETYX/BeJTHUPqiBhL2"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/+AshyETYX/BeJTHUPqiBhL2
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Marc,

On Thu, 18 Apr 2019 09:35:44 +0200 Marc Gonzalez <marc.w.gonzalez@free.fr> =
wrote:
>
> It is not clear to me what I could/should have done differently to avoid
> the conflict?

Nothing really, it will need to be fixed up when these trees are merged
into Linus' tree (or some other tree along the way).  It is not a big
problem as the conflict is pretty simple.  I send the emails just so
people can see what I think the resolution should be and correct me if
I am mistaken.

--=20
Cheers,
Stephen Rothwell

--Sig_/+AshyETYX/BeJTHUPqiBhL2
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAly4Lk0ACgkQAVBC80lX
0GzyxQgAjLDPt/0aB7gYWTpzZ4eyr5+ZNBefenCqyThvkmhre+oktf96SM94dk/S
Lo6H+dlw2JLJiSMaHKouImgFGAWcPY2iwRRhcSO2tv2HUdu2VNbXCoNf8qcGytO7
8e9HsyIOIsRAWAg00B6i1OKIZ802860yHj7ZPuYICCmELRlltamwPrcqKo/CFxGc
QV3zTFp8Cx9M8/ZQ+KrykfaCAbrOSmYRgYLoBr3ZinU5je4ucBVsZvE6s1M0TLAl
knn0CYx5U00w9IR+GqyulwSFRBa9HQhD4qI/+Xmo+BtkvlRs+/IMna6EIfsjIf4G
gksIPkytUs2j/fssD2t8LBlRRdGqxw==
=FrcR
-----END PGP SIGNATURE-----

--Sig_/+AshyETYX/BeJTHUPqiBhL2--
