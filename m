Return-Path: <SRS0=RThv=TD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE607C43219
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 03:41:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8164D2075C
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 03:41:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="j/jyItxx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726352AbfECDl3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 23:41:29 -0400
Received: from ozlabs.org ([203.11.71.1]:35919 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726114AbfECDl3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 23:41:29 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 44wHwz723Xz9s6w;
        Fri,  3 May 2019 13:41:23 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1556854886;
        bh=koi7Ud/RfiN4TwBIW5OXTphbrmqZiG+QMYCuwH7iX9w=;
        h=Date:From:To:Cc:Subject:From;
        b=j/jyItxxq60RWt2WUVkHFOAzQN9vzXLGUjDSHVd0xnl4C4eYSK+GFve8TevtWFMJS
         Ifh+ETu4gGwmhQ6gftlQhO/7L8XXtasuDdqA5oI9J3FOiXBCVQO5tmQXZC5z5tZLej
         8X1HjenWFKPyWO5+Ka8ia9/ofjN9YjZBWwGoEk2qoZBfKLbvygIvIcmEx5Ed6sgCZq
         UvQJ9D99x2LVw7c/zY4YJU/Qi5rP3AJL8C453ox/cYC3cXBKpUDx2W4ALdj00/ftSc
         KmxseyCqzMDkV8L4f+wBPTQOdT8DC10f6ssgMY/nwf1wHfnoKzo68uCuakpDwQ+NZx
         olSueh+08JnFw==
Date:   Fri, 3 May 2019 13:41:23 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Jessica Yu <jeyu@kernel.org>, Al Viro <viro@ZenIV.linux.org.uk>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>, Tri Vo <trong@android.com>
Subject: linux-next: manual merge of the modules tree with the vfs tree
Message-ID: <20190503134123.1a8e0e32@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/Uv+4TJ6VcVkqL+B4tO5Z4/a"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Uv+4TJ6VcVkqL+B4tO5Z4/a
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the modules tree got a conflict in:

  include/linux/module.h

between commit:

  007ec26cdc9f ("vfs: Implement logging through fs_context")

from the vfs tree and commit:

  dadec066d8fa ("module: add stubs for within_module functions")

from the modules tree.

I fixed it up (both these commits added the stub for
within_module_core, so I just used the latter) and can carry the fix as
necessary. This is now fixed as far as linux-next is concerned, but any
non trivial conflicts should be mentioned to your upstream maintainer
when your tree is submitted for merging.  You may also want to consider
cooperating with the maintainer of the conflicting tree to minimise any
particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/Uv+4TJ6VcVkqL+B4tO5Z4/a
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlzLuGMACgkQAVBC80lX
0GxhrwgAhf8teN/1PGmnZgZ+65oXrlqBdWdVAnjlfaDaRgpJOcZPqp7eQqaQwjBc
lSMiGUYaKZsfFm7VxWPZSrGRyUMCuov8u7YBJBEO1I08vb1MwJlRB2sncPE5ONBt
X1PF9lOq2cMxdqQ/W6kBeIWKEEUTrMcbt4C5FjYEekoR9xKmWeprbbhcot3Kwle3
4TOlYhBCQZaQ0C0xSpFkyd9Q6Cge7QOuzZatKdoqW1rBmBDBtJzrlWkUeeDz4Jjr
tafp4uxxMXgm7VKr7vX02M1l68IVSKz378o1WO0I8RZ3c2p2/Zt5acq2s29vDFfy
/wpyKYipnQNM22V4TMQJIJEhJ6+RNA==
=6kSX
-----END PGP SIGNATURE-----

--Sig_/Uv+4TJ6VcVkqL+B4tO5Z4/a--
