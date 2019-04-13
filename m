Return-Path: <SRS0=NhyN=SP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C62F3C10F11
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 08:30:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B89421721
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 08:30:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="ItvMDago"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727341AbfDMIa6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Apr 2019 04:30:58 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:59517 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725776AbfDMIa6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Apr 2019 04:30:58 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 44h7JG52VVz9s3q;
        Sat, 13 Apr 2019 18:30:53 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1555144255;
        bh=3UX9GKxt2rpfj1v4VeV4cSr/1WKxN8UYwUGBsD7lgfw=;
        h=Date:From:To:Cc:Subject:From;
        b=ItvMDago4mUAK6aAhQOwHY2aiM3ReEgdMZvRkPlnAsQD87kwxMVrjlkdCTIb3CEte
         czRf39ixYeSFnqJLZK0Oez71pzU+WKpnbegZ5koEr7O/2pDArYwg5QqZOh3DPkz7Xm
         cwiWsgWNo4ACKCY0OFK+ySpWRCnyv1cPCVYvqg+dp7khgY5jg+Pr96rZUS+o6cvQHx
         wNcsY6tZ1+k5Tn5fdN6eKsiBWZyEfPIWvsmk14QPjr/5tugFnywYZ+7rwUsuCMYvOo
         vw85sjqaJ4zqa5Qnyd71GRj+O7Bo/6OaZMoyG41joUVOjF5U6D7yD+0+EriO4NkWBq
         cbJz868mxU0lw==
Date:   Sat, 13 Apr 2019 18:30:53 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     David Miller <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Marc Dionne <marc.dionne@auristor.com>,
        David Howells <dhowells@redhat.com>
Subject: linux-next: Signed-off-by missing for commit in the net tree
Message-ID: <20190413183053.1b76c35b@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/+MjACQHjKPsP5gNOZfYW+T7"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/+MjACQHjKPsP5gNOZfYW+T7
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commit

  4611da30d679 ("rxrpc: Make rxrpc_kernel_check_life() indicate if call com=
pleted")

is missing a Signed-off-by from its author.

--=20
Cheers,
Stephen Rothwell

--Sig_/+MjACQHjKPsP5gNOZfYW+T7
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlyxnj0ACgkQAVBC80lX
0Gx2OAf8DgLal02CQgNRci7eoFeqg+U20weTqJ0sNWVqqc9QB4YBctPVeRvRQP3Y
kVDEgBmAAWwXORhCmk08uAEtoZo1XDX/Xq81kBfqWhfilVgFeNDQOWAtA8zuGyz3
e6pHVruqoAIgMtREToKrEYrNjiEddti3iGA7vYkDmh/sjVhC0i3M/+XM2aJyl98V
uHOvxsbfUEkBAAByjRSA+3V+Cf7eWCndPzPPTqVeJAAqCHi1QKEy/24zvQr5z0HC
0nopspXhys72V4iw8wEJkp6TX5UPkuJVp2kIi+iFgrk+1N6TU/iSrfn5Ze7LnOh0
WyY2FwSiAwIMUnW2U3D96fL8ptSY5Q==
=YDem
-----END PGP SIGNATURE-----

--Sig_/+MjACQHjKPsP5gNOZfYW+T7--
