Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26E6EC10F11
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 21:01:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C36B5214AE
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 21:01:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="bzp3sAWM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729080AbfDVVBN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 17:01:13 -0400
Received: from ozlabs.org ([203.11.71.1]:60521 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726896AbfDVVBN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 17:01:13 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 44nzWn5x9fz9s5c;
        Tue, 23 Apr 2019 07:01:09 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1555966870;
        bh=QzYkbtCXrhcwEshhbfP/q2k5peSpzg7jlKMOne3DI2E=;
        h=Date:From:To:Cc:Subject:From;
        b=bzp3sAWMziVug5eG2GUF4A4/6wPMPxbqmK7wDZruiR91dOwO2ZbB/6/zqZMGbtAE+
         yVo/BWSLJcli6MkuCXFBsQcGDzH60z1K3cqpEMOi0bFJGu1N7xbkW/JowvCZQN8ss1
         EYlBkJIunStd3pbIIlQ0ksx2EnV7ZzTm6fUSQ6A4ikpmjkI+sHZqokp6WDMKB5dUEI
         cqCXPL1GuKBgchYrOsr8BaHt6g7+/7IuEMVVr/a4A6TOiML4a3tnJVgsuH0Dk0hmPm
         BT+9tN6c6YnrTbwSornedutCwfCWF+MvPrBFSBYKDco7aGdgM/4jySZZkEJlB4eczS
         Xy3ympKURE10A==
Date:   Tue, 23 Apr 2019 07:01:08 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?UTF-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        KVM <kvm@vger.kernel.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        Paul Mackerras <paulus@ozlabs.org>
Subject: linux-next: Fixes tag needs some work in the kvm-fixes tree
Message-ID: <20190423070108.5069d3d8@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/cJEY4fCYAenYlXf.xvVhVVC"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/cJEY4fCYAenYlXf.xvVhVVC
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  345077c8e172 ("KVM: PPC: Book3S: Protect memslots while validating user a=
ddress")

Fixes tag

  Fixes: 42de7b9e2167 ("KVM: PPC: Validate TCEs against preregistered memor=
y page sizes", 2018-09-10)

has these problem(s):

  - the ", 2018-09-10" is unexpected in a Fixes tag
    Just use
	git log -1 --format=3D'Fixes: %h ("%s")'

--=20
Cheers,
Stephen Rothwell

--Sig_/cJEY4fCYAenYlXf.xvVhVVC
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAly+K5QACgkQAVBC80lX
0Gymzwf6Av3z+KQHk30XQxaQ6/SHXSCqD+K1qmLpD5CxLkVMdoshEZPA1nfID9le
DkQiV6WLSgm86zL7KMXhHFl7SgdCdBC4ySef4RuVdwROXDIVFjYnmNP9Uk0oafgE
LMYpsORDvz/S0SQlh8ayOHQIl1jTc/Cq41cZRl7ZngHLmP2iIw1xE0YVXBfx8+J9
1kE/nZLub7POwjVnn85DhrNOEVjF3TFxw+MODFEibBpMC4z7BkcxJUVfsghbUTjw
fKHOBevrXb7KrSy3OjWU5Kauf/ckHQJ7+P29R0U4g4ve56tsnmOfnf8rc59Z7BVV
+TSfSlY120XESkb0KF92eXJYWqcRuQ==
=C6H4
-----END PGP SIGNATURE-----

--Sig_/cJEY4fCYAenYlXf.xvVhVVC--
