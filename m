Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32D46C43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 01:57:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 057B620644
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 01:57:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="Rzd7Wwh1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726770AbfFXB5j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Jun 2019 21:57:39 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:49529 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726416AbfFXB50 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jun 2019 21:57:26 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45XBHj4b2fz9sNk;
        Mon, 24 Jun 2019 11:18:09 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1561339090;
        bh=dKWqYqiQ43IXw7uRXmq4Og/WGeJ5CqQGoMCUg/cqTzk=;
        h=Date:From:To:Cc:Subject:From;
        b=Rzd7Wwh19ca62JJVEBtyosh+5VJdbMPGBaNzrPw6xvfiYJEzWIX/8ZJ9YFZklw7/Y
         TF8/wATgqdjembLEeIxeLGOx67VKRUGrgh9CJt2FAdU+2aHeCt5n22ZmQcmNf4AF/D
         WE5/kOo/k24Rt+zuNzubWnx30lVJpcQh5EgaeyupbO295rRLdsvp3uHGuARWmRHx9Y
         hx5QBHgWwcEXxu1AehzCfu0t4Jqfq6yp3zDNynMmul8/NsJqqJYjXEs1vhxXwTZS4+
         qvCVGqKp93DFvDsvkTu81F/4HK13EZvMSHbPGC1rHZVVkrhw0Gc6DiFNk2p5yOPxfl
         IRrf7Tvl5mQzA==
Date:   Mon, 24 Jun 2019 11:18:08 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: linux-next: manual merge of the hwmon-staging tree with Linus' tree
Message-ID: <20190624111808.59e2258f@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/l1Uao6wQiQSV=qS6.2pFurn"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/l1Uao6wQiQSV=qS6.2pFurn
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the hwmon-staging tree got a conflict in:

  drivers/hwmon/iio_hwmon.c

between commit:

  d2912cb15bdd ("treewide: Replace GPLv2 boilerplate/reference with SPDX - =
rule 500")

from Linus' tree and commit:

  2119f92b6b66 ("hwmon: Convert remaining drivers to use SPDX identifier")

from the hwmon-staging tree.

I fixed it up (Ijust used the version from Linus' tree - GPL-2.0-only
v. GPL-2.0) and can carry the fix as necessary. This is now fixed as
far as linux-next is concerned, but any non trivial conflicts should be
mentioned to your upstream maintainer when your tree is submitted for
merging.  You may also want to consider cooperating with the maintainer
of the conflicting tree to minimise any particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/l1Uao6wQiQSV=qS6.2pFurn
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl0QJNAACgkQAVBC80lX
0GxtAQf9El3MCE4vFEdNgOiwDr0LAQ+Ue43nuaPDBbL+8RKW2Qj25n8tEqa9tDcy
FUoqhe0Z2EwQJEVTUAA+ON/5ynS9d9mC9EJQhZHTkppjQ686EsaNPyc6IR9weOwu
PUU4TpH2fx58s9UFC9WIB7QNyJFMIBCiz0jdJmjoH+pjiDIqb5ei5ycFe6yCG1UJ
KVQ9pf1ZY2eUGYPLgJBdbcfhepCoeCkn3USJ1liArOp/XF1B559WedAQjKSXK+Tj
D6yoo7yl4DhdSJtS/3sH0CEZERpgQBVxZVkvHa4LBux8rb18RmKQM+NrabX5kcfg
2Ak8Te7Gm+xU6Z6yXEWzrUqDDKi0Dg==
=5snR
-----END PGP SIGNATURE-----

--Sig_/l1Uao6wQiQSV=qS6.2pFurn--
