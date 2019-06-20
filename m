Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20612C43613
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 04:34:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E965A20B1F
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 04:34:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="HjzA0sXG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726419AbfFTEd6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 00:33:58 -0400
Received: from ozlabs.org ([203.11.71.1]:59903 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725871AbfFTEd6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 00:33:58 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45TpqR30LBz9s00;
        Thu, 20 Jun 2019 14:33:55 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1561005235;
        bh=nct7F0FjO8LwJgjN7g0osADsaNMzm2I9wrABE2yt5R8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=HjzA0sXGD90kYovtwyP7Yn0/MPKCSorfO7lUlg2iDd97IaQuZhXhSPH+q4SV5SGUW
         uXBXGglR4o0vDgKY6Olw/JkueNnmgLL4V73EnlgzUBC9TgLUT+DVxgLbPLCriLpJfK
         wXXzSefYppIOih1FdlvqgYyXWCDMAGKMIXfu17QHMbdEOAodpyYeBxXxhhYup0l/XK
         j34mzlTw4rD9JgSD0UwtGi1RAF+GUhZei67zpEGt0DZMOdtk0BtSKj02/gs9M8kPF3
         o+FvQJ3G3n983qIAJ2uqz8NJhn0MC/w3orXyckVvJQiwTOkqfB5l9BcE/0JM0Urub3
         sAMCfg8B00dZw==
Date:   Thu, 20 Jun 2019 14:33:54 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     David Howells <dhowells@redhat.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: adding some trees to linux-next
Message-ID: <20190620143354.6f9daff0@canb.auug.org.au>
In-Reply-To: <18975.1560956941@warthog.procyon.org.uk>
References: <18975.1560956941@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/0IBaTnRMS94QDbr25rslXLB"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/0IBaTnRMS94QDbr25rslXLB
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi David,

On Wed, 19 Jun 2019 16:09:01 +0100 David Howells <dhowells@redhat.com> wrot=
e:
>
> Could you add my keys-next and afs-next branches to linux-next?  They can=
 be
> found here:
>=20
> git://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git#keys-=
next
> git://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git#afs-n=
ext

Added from today.

Thanks for adding your subsystem tree as a participant of linux-next.  As
you may know, this is not a judgement of your code.  The purpose of
linux-next is for integration testing and to lower the impact of
conflicts between subsystems in the next merge window.=20

You will need to ensure that the patches/commits in your tree/series have
been:
     * submitted under GPL v2 (or later) and include the Contributor's
        Signed-off-by,
     * posted to the relevant mailing list,
     * reviewed by you (or another maintainer of your subsystem tree),
     * successfully unit tested, and=20
     * destined for the current or next Linux merge window.

Basically, this should be just what you would send to Linus (or ask him
to fetch).  It is allowed to be rebased if you deem it necessary.

--=20
Cheers,
Stephen Rothwell=20
sfr@canb.auug.org.au

--Sig_/0IBaTnRMS94QDbr25rslXLB
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl0LDLIACgkQAVBC80lX
0Gw8tQf/Uwo+5lvHcBzmM1bs+Z2WIWWnFBV6rQhjDP6dIJN/R+w42uAlGvAugd84
J7kwsvWRLYWC55f3KzGbPnrX4bD9oZzfmPVIjzc7jFVwFaREnX8I1EVxlQryGPLn
G1aoDoTsGeYwXmaJbAc4t+KB84FiZyIgrvCwRsxkci1nnl+hPex7eylQTVmvgcfI
biqc+aTqzXYjs4I39bnISkM2BiRdkDMzo1fukGMYSaP0Z1dXe5YA1w3SrrJIwzOF
joIIzpZpZekL1XybZyM5/OKomVtueXPd1uAP16A2Tg3246HtfOs56iEImxSQ/oGq
onDI8zachwk1lBlglCRDh60yUX2mag==
=3uOV
-----END PGP SIGNATURE-----

--Sig_/0IBaTnRMS94QDbr25rslXLB--
