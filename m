Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BA78C31E53
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 01:50:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3348920861
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 01:50:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="KcBy97c0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727572AbfFQBuN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Jun 2019 21:50:13 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:34541 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727389AbfFQBuN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jun 2019 21:50:13 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45RvKt2lMNz9s4Y;
        Mon, 17 Jun 2019 11:50:10 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1560736210;
        bh=3f09zyB+nf7vSi9D60d4OAYGJx3mH6NNA7J3+YwHLVw=;
        h=Date:From:To:Cc:Subject:From;
        b=KcBy97c08d7V/oj9+cFZikIZ+CnslOJhpjq4YbGDNVHHWBYjoKJ4mAMY5+KdGuMzz
         dN20aypSzXvnYiAdxPzzoGNgFC/SS9IMqn+KjEfwNj1bhHNltHaO90TwZbcy35d4yr
         PETCELi+kUpQiemkOYZ2b6qDcZvMUUv5HDXS+7F5z0Z/0/s1hwtGtgahKl+rw/mQ4V
         Hsb9GF9uYNkaid4eVw1k/zQt4uZ7IM9Y1oW086d4iAhrWThczn6nWBb/Jy6xT1aQKe
         djQU/l5kFVTj5PygzcxwsQylGmOBZ5Ge+dHL9dRqrKoZ22/VM8lufzl303Wch7Wq+D
         TLgg84o1ZausQ==
Date:   Mon, 17 Jun 2019 11:50:09 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     David Miller <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dexuan Cui <decui@microsoft.com>,
        Sunil Muthuswamy <sunilmut@microsoft.com>
Subject: linux-next: manual merge of the net-next tree with the net tree
Message-ID: <20190617115009.4646a2b7@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/iCK4/pEP2NusE+B8BnfnmQp"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/iCK4/pEP2NusE+B8BnfnmQp
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the net-next tree got a conflict in:

  net/vmw_vsock/hyperv_transport.c

between commit:

  d424a2afd7da ("hv_sock: Suppress bogus "may be used uninitialized" warnin=
gs")

from the net tree and commit:

  ac383f58f3c9 ("hv_sock: perf: Allow the socket buffer size options to inf=
luence the actual socket buffers")

from the net-next tree.

I fixed it up (the latter include the former fix) and can carry the fix
as necessary. This is now fixed as far as linux-next is concerned, but
any non trivial conflicts should be mentioned to your upstream maintainer
when your tree is submitted for merging.  You may also want to consider
cooperating with the maintainer of the conflicting tree to minimise any
particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/iCK4/pEP2NusE+B8BnfnmQp
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl0G8dEACgkQAVBC80lX
0GyWJQf/QY+k2yttQXWg3Ipi/bmAuT1OQb3f3JTfsJqUeTNR8R8KIRKYi0zCVIAw
mEfW9wZ3jYwgV7lXx/5laIHyNEtZWPtKG2hwsf3im99YIuWt6h8oqwpDFXidoGqM
7YwKL1yba2OCHeklhXT1tR3nNWn/XIt6dvqwNCsOSUWwb6V5jMb4AG44jHOutP0B
pLjqNsCFX9EDm+q3Tc/ChUrolzhK8gLckCvcJVbMWqsxUopoZzMeddusHlfzDVhe
/3nfqoTnUvXs7bQVFkGibkZmoAjR3NvLWYmquLg7xYpvCMhgpeLX/fE2wvOe67bv
v5bfKJXfAlOObvVnksSjp5NhG17txA==
=CJhF
-----END PGP SIGNATURE-----

--Sig_/iCK4/pEP2NusE+B8BnfnmQp--
