Return-Path: <SRS0=xBSd=Z4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7658C43603
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 23:55:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABAA4217F4
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 23:55:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="L9gtEI+G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726461AbfLFXzq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Dec 2019 18:55:46 -0500
Received: from ozlabs.org ([203.11.71.1]:43575 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726374AbfLFXzp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Dec 2019 18:55:45 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 47V8by1GqVz9sPK;
        Sat,  7 Dec 2019 10:55:42 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1575676542;
        bh=VAZs08nopNKFpod49C7L5cDgUDWcf8h+c3itE59eop0=;
        h=Date:From:To:Cc:Subject:From;
        b=L9gtEI+GTv8BN4pqQZmp1uA97lN3RO0N0WKWrd25YlvZwDK+nj9VgQ8bPrL0Apoek
         D5i4rNUT1tt7fDApEsBHpTcyTMDB/PDO6wQMiL5I7SA8CX15UBTWXB6wluP4sUt8ZC
         F96a+se6/OVTyeAkfCpFSdcJQ3BZW7uAVVsIbyo2a2ZPApee1O+MtqIsQZdqJHrGe0
         UcAiefiz/J/gZLdzKPw5ZRLoxhPXu1vhtHcbhdhDD8pBUSRQLPEu/dqqVDOEjskQ22
         Tlo4v3Ww/Y2NtHaVgZeFTKCSt7o3nf9x7NPQlC8QVQvDxFHbRQe+ISKVx4Zmz29zhs
         TvitHHHf3Dt6Q==
Date:   Sat, 7 Dec 2019 10:55:36 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the thermal tree
Message-ID: <20191207105536.6641fff9@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/s7pQ6z3wBMQgm.N21oIm.O4";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/s7pQ6z3wBMQgm.N21oIm.O4
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commits

  d6532afcabab ("MAINTAINERS: thermal: Change the git tree location")
  e7738e756835 ("MAINTAINERS: thermal: Eduardo's email is bouncing")
  f26ae7d94c8d ("thermal: power_allocator: Fix Kconfig warning")

are missing a Signed-off-by from their committers.

--=20
Cheers,
Stephen Rothwell

--Sig_/s7pQ6z3wBMQgm.N21oIm.O4
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl3q6ngACgkQAVBC80lX
0GwUEQf/fOv/hWQT4VzfDJxG7JEEcgqtVgHi5GOvE7mL6xm464bG1MJ3BkrUOJyz
Dh80wCE+TtVtQv3j8/UUWeQY+x8Q7lwQ5Grc1uQXOjineMN7dZCfjYdLIUy7GoGw
39/WAGoLphe+z2ViBs+ZzvaW1x/eV/6Exn3h9SHSeGiqTY41IOkXOtc4W3DaA+t+
uATAQGXrGQ7SrLja1IS1rwjp7YnOppGF7XTWROw13+4Cxe8B+z7K8kK5hrcRGp4+
4wXT+OOrbr3oo2WTWBO5H/33fiv/O4Gwa/UXAM9c+gfYbzsdGcxeCEVAYSa/C7UM
d3iq4uUc4dR6/0Bys/wqRw8dSIG5Kw==
=Pr7m
-----END PGP SIGNATURE-----

--Sig_/s7pQ6z3wBMQgm.N21oIm.O4--
