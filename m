Return-Path: <SRS0=wfQU=S6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCE81C43219
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Apr 2019 07:07:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A73E9204FD
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Apr 2019 07:07:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="T2XRQITE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726531AbfD1HHS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Apr 2019 03:07:18 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:46721 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726133AbfD1HHR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Apr 2019 03:07:17 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 44sJkq3Vp6z9s7T;
        Sun, 28 Apr 2019 17:07:15 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1556435235;
        bh=48LKTtK+e30HGxn2cN204m1w9/dkP/GkIu3RuJug4OM=;
        h=Date:From:To:Cc:Subject:From;
        b=T2XRQITEY8W5EhGWu/DGH3wex/oPQq6znvdiB4Mb0prrZGv/SSPN8kVn1bI76iucX
         T7n65+7GjZRgoOfG6ZYbsbH7ls7rdSENC3lWYgKA1DwRqIseCfs+q1a51tURSshrhU
         jnc+EXPGib2KxmWcRmziHcGBu6TXpYfoHVxy5rz7IwhEUI4Yhh7DhLWPUPonkhNLes
         u7MzP8Nb7dKGyPu21+vckBIuQnTfZyfwiYrHUJ/oI2C1kdbHtuopjdtWyNdqe+s4EC
         54Hzi6JrjG0HAcDi7l4zLMl/gAaBdvjKcQUYQZdhpj1VU1w0Bt9KtPOxdqJz3hZ0W5
         CG3N8ncyQjXuA==
Date:   Sun, 28 Apr 2019 17:07:13 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Philipp Rudo <prudo@linux.ibm.com>
Subject: linux-next: Fixes tag needs some work in the s390 tree
Message-ID: <20190428170713.770e1bfc@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/0kVjR4O274LwqJPu/Jm+bpT"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/0kVjR4O274LwqJPu/Jm+bpT
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  2875248b5e1a ("s390/kexec_file: Fix potential segment overlap in ELF load=
er")

Fixes tag

  Fixes: 91a05d9e1d6b ("s390/kexec_file: Add ELF loader")

has these problem(s):

  - Target SHA1 does not exist

Did you mean

Fixes: 8be018827154 ("s390/kexec_file: Add ELF loader")

--=20
Cheers,
Stephen Rothwell

--Sig_/0kVjR4O274LwqJPu/Jm+bpT
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlzFUSEACgkQAVBC80lX
0GxQoQf/W8KM8sclN38B6l1gUVTRGhez6cbWfWWFqF/YVVoThbRFE/9LLBz4g9LO
enAgykYBtM6hhipGzYZr52Rt4Z1HK73eHbmBLincOb8KZK/YUf6IuVbKdIF6vSjb
X5BHIltPp0g9u/LTptv1ApItLU1uNQgW1Z1ItqpXytkwtw2SSgv7Yv5EEBGL67Gc
fwzEzNOy+st2rU1UaCF9dlzCMFWMDoF5V6dQweEORarFQp+RPQkXva21iv9s+1o+
pgQKFhahGLcpLWVSQTdj1QgO9FZgRv5lc6rygk8MM78lvZG5bMarD/H2f3VGm0os
WYzeVEhwbboKrmY3cU4+O8W8lCrA2g==
=SyRY
-----END PGP SIGNATURE-----

--Sig_/0kVjR4O274LwqJPu/Jm+bpT--
