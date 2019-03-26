Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 018B9C10F05
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 10:57:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4B1120856
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 10:57:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553597825;
	bh=/L3t67LqpUi7diaC5PJQh+kjEi5mkouoy+99kkJKkx0=;
	h=Subject:From:To:Cc:Date:List-ID:From;
	b=YXJ82ADN+INKF2LiUFHYRs4Kn9Mai3Hyu/S2TdC8IsuXyTY8yngDQQN0KeC055QN4
	 fZxdg0nPp7RmrSALuJ7uYsN+9vnLKaNqAitRNMImmtalAJc/GhZHlfsVRkyvJNeQrP
	 nKRqyX5tT3a0LL+IVX0HhDzkOjpHPJTzshbALyzg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730377AbfCZK5E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 06:57:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:34832 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726258AbfCZK5E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 06:57:04 -0400
Received: from tleilax.poochiereds.net (cpe-71-70-156-158.nc.res.rr.com [71.70.156.158])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DB0492084B;
        Tue, 26 Mar 2019 10:57:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553597823;
        bh=/L3t67LqpUi7diaC5PJQh+kjEi5mkouoy+99kkJKkx0=;
        h=Subject:From:To:Cc:Date:From;
        b=fSOxcT9eNhO7qwXFtTcQH4RTdnMjKOBlrQPBaigUdvM2UQG1KXeXQiCj68Rm6EsmS
         mT38OJxdv/cq1jKxfxCaW1TddfU19oBP3wdSv5TQ36L1OYyFY3h/ZWLCBNY8E6LBmL
         q45+2JIAO8K72uwdt1+i1AohhavvMY6OHoMgsNtA=
Message-ID: <73ec5fc30bc902ba836eb9dabc8bf92023aa427c.camel@kernel.org>
Subject: [GIT PULL] file locking bugfix for v5.1
From:   Jeff Layton <jlayton@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     NeilBrown <neilb@suse.com>, "asn@redhat.com" <asn@redhat.com>,
        "bfields@vger.kernel.org" <bfields@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Date:   Tue, 26 Mar 2019 06:56:55 -0400
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-CVQdXV0PzGpvEqhWIUCr"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-CVQdXV0PzGpvEqhWIUCr
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

The following changes since commit 8c2ffd9174779014c3fe1f96d9dc3641d9175f00=
:

  Linux 5.1-rc2 (2019-03-24 14:02:26 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jlayton/linux.git tags/lock=
s-v5.1

for you to fetch changes up to 945ab8f6de94430c23a82f3cf2e3f6d6f2945ff7:

  locks: wake any locks blocked on request before deadlock check (2019-03-2=
5 08:36:24 -0400)

----------------------------------------------------------------
Hi Linus,

Just a single fix for a bug that crept into POSIX lock deadlock
detection in v5.0.
----------------------------------------------------------------
Jeff Layton (1):
      locks: wake any locks blocked on request before deadlock check

 fs/locks.c | 5 +++++
 1 file changed, 5 insertions(+)
--=20
Jeff Layton <jlayton@kernel.org>

--=-CVQdXV0PzGpvEqhWIUCr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQJHBAABCAAxFiEES8DXskRxsqGE6vXTAA5oQRlWghUFAlyaBXcTHGpsYXl0b25A
a2VybmVsLm9yZwAKCRAADmhBGVaCFV0yD/9XkhKQiCl5KW46ozZ3X9YsZq0jEPCm
bTlRs1QD+qhzL/j4Z2tB+BYxHXZiTcUZJgZ99OeipQenSalqhNdWJ+LudU53Gi1D
U8sr/uwjkfwAJP6boob17eonvZmN6pNhNkScA49KgnJ+NA/QSjIAIJUJ5BccGVuc
kvlQYUZTT54kAZfOAEXhcfPwTt/GoFHNT+8EVT/UhG8zHQANIxjkyZgp5vUc9bm2
93cXqs7GdbzHQ/Mjha4vf9MOuoQ5t4Ee1GZGDz+SC2ZPzKfgURzikLQB75GxiMrQ
ncLQPTFSL0kKi3BIemo6bRFFnHyrfGUBl0SHdfGXdjqLUmqKsoauQ59TRJBNOxrk
UfIHmalSaQ0G+vFclP/HlGPMNaxEXKJsy1gce0R/GzSD2Bb2HNlhocW/wlu/8fIA
8TZKqK0uFY0wGN2CcPpFQkIaLHNoQi0lGbu1xYOt/n62Av0MPKlc7uQEn43dhNDg
0NBatgUV3kofzk8xaf4eRD5rh9O+l/EB0eTHPZOptr1hzmP6jQyZb8uYVzTvQxMX
Ww6w5c+Sg4QPkSwiBCiFpOjwk4JZLu/vTv3G+shG1CE1/U2voRaDhowUVF62wulr
WegsWnePXq54PnB3mXtNbbx1P2zXJGjhAVxd6bved+WmCRo3R9VLmeFjFo2w5xjZ
i2YGVa6JeSQ5gA==
=Lpgl
-----END PGP SIGNATURE-----

--=-CVQdXV0PzGpvEqhWIUCr--

