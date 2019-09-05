Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,LOCALPART_IN_SUBJECT,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 324F6C3A5AB
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 06:02:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F354522BEF
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 06:02:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="cQFOWKcI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731332AbfIEGCt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 02:02:49 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:55361 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726175AbfIEGCs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 02:02:48 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 46P98Q2S8Wz9sBF;
        Thu,  5 Sep 2019 16:02:46 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1567663366;
        bh=uUwByufKpnFTkAp/bGgn90W1r1vFi14mgdTW1FMySiw=;
        h=Date:From:To:Cc:Subject:From;
        b=cQFOWKcIti5p/B2VuY8sM0NSfUx3ow6BUwj3QT0TWWYmnh9PsHqsit4bfYShOD96Z
         0j29VhLsCiGiDGN48qDLf3RlmW86kHe4MH/LF4R2qgdq6w8zp1u3oV2hTQN2sM8JFQ
         DiW79WM4YN4flLzGwhBRTueEEdekV5Yr9XwNCliBozmkReMBk4bZX9FkhBwkJqVB8j
         ZopJ3MFAjDqwpkLz5eseFb+RBSKHanPgEnKwQU/DDFWM+Qza597VVSr04nse4Y+DPM
         lAwP8RORPiBMzJdfazf94m8mXE+DwXw8OJyGZKFLu57/F+ujxgXe/pbCBR7Me6r/w7
         2OnecaFUfCiEQ==
Date:   Thu, 5 Sep 2019 16:02:37 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Linux-Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux-kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: no release today
Message-ID: <20190905160237.2e972a89@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Ob.n=vBwyb3Yk1MRhgx8y4I";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Ob.n=vBwyb3Yk1MRhgx8y4I
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

As I said yesterday, there will be no release today, or any day until
September 30.

--=20
Cheers,
Stephen Rothwell

--Sig_/Ob.n=vBwyb3Yk1MRhgx8y4I
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl1wpP0ACgkQAVBC80lX
0GwTjwgAkG71xe53hMTmDnsuAb2tDr4VtADU+Up8niCXJdyWpQA1qlCBe9OtZjHj
XO8b+sFwjoOkObNGhrsw3yi4g4dUZ6p1CIFC++4Z7XXETR3+3bHQPM4mEqz7dGYd
ImoEp83Q3XrBemfWvCOTZzwSQ+FN+s+tS9NXU8m2qWEb+BJlEkBTzfqNx61u/KFP
s0IDeiDSxJZXV956UpKGk5RpatAzvyD46BnQCb8lrAAwfvlNwUBEszPDQN+9Zcti
8AxdaCMuu1nlSkPfG38iTqsyc3+d1BvVKlSnnq8NWnN9j4vEflJnQqW3ezd/tpin
cIBbbPxqZfMZE+Fz948ZkRAfbUtB3w==
=kl9O
-----END PGP SIGNATURE-----

--Sig_/Ob.n=vBwyb3Yk1MRhgx8y4I--
