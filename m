Return-Path: <SRS0=xe0T=ZQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 413B0C43215
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Nov 2019 09:21:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11EA2207FC
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Nov 2019 09:21:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726765AbfKXJVq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Nov 2019 04:21:46 -0500
Received: from jabberwock.ucw.cz ([46.255.230.98]:35438 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725980AbfKXJVq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Nov 2019 04:21:46 -0500
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id AD4911C1EAF; Sun, 24 Nov 2019 10:21:44 +0100 (CET)
Date:   Sun, 24 Nov 2019 10:21:43 +0100
From:   Pavel Machek <pavel@denx.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 4.19 025/220] SUNRPC: Fix priority queue fairness
Message-ID: <20191124092143.GA31120@amd>
References: <20191122100912.732983531@linuxfoundation.org>
 <20191122100914.283665562@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="7JfCtLOvnd9MIVvH"
Content-Disposition: inline
In-Reply-To: <20191122100914.283665562@linuxfoundation.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--7JfCtLOvnd9MIVvH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri 2019-11-22 11:26:30, Greg Kroah-Hartman wrote:
> From: Trond Myklebust <trond.myklebust@hammerspace.com>
>=20
> [ Upstream commit f42f7c283078ce3c1e8368b140e270755b1ae313 ]
>=20
> Fix up the priority queue to not batch by owner, but by queue, so that
> we allow '1 << priority' elements to be dequeued before switching to
> the next priority queue.
> The owner field is still used to wake up requests in round robin order
> by owner to avoid single processes hogging the RPC layer by loading the
> queues.


>  include/linux/sunrpc/sched.h |   2 -
>  net/sunrpc/sched.c           | 109 +++++++++++++++++------------------
>  2 files changed, 54 insertions(+), 57 deletions(-)

While this might improve things, it is not fixing a serious bug.

Plus, it is over limit for stable.

Best regards,
								Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--7JfCtLOvnd9MIVvH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl3aS6cACgkQMOfwapXb+vLt+gCgtW8z0jM4oPxIc0G2qQrdmIqr
GRsAoIf+WnKF9jLMujiStSY2R8+gldEI
=6TmO
-----END PGP SIGNATURE-----

--7JfCtLOvnd9MIVvH--
