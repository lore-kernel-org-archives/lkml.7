Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 599C1C2D0C9
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 11:41:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3048720663
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 11:41:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="GccihxoX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729057AbfLLLlT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 06:41:19 -0500
Received: from bilbo.ozlabs.org ([203.11.71.1]:44751 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726492AbfLLLlS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 06:41:18 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 47YX1m1gydz9sPK;
        Thu, 12 Dec 2019 22:41:16 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1576150876;
        bh=sRxXvqqup9OlL6t/QMMLSYZXP3qqEkteyJSA5xyxJck=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=GccihxoXa+VmxMCCbUEgQ4u3xedJQ/aP3v/4Ro6VAoDjGlCyBYDNkJ1rj81TaKBfx
         /73J5+5t+yTjDrB3xYVRKl0iW3NUnY+ujQcX+RHihy+wMhEeaRtTsvyp6C2SkYa38d
         qizWjBovKOaHWpjBS2xOlPgLz41KQNbh/e320nKnDIWaboUnsrUg1gbLy+3dYVZpk3
         eTx+ZR6VT8/QzYEeg6D1fYYovwyPimHhMuQymwO6eK7U5waRBtIjSfyJzpQBmFVbmA
         XprUKEeQlCKEo0OWhMT+uq8pn5ESibq8jmddn6WSFlY+WdbQ4zQkeAqB106PDS3pi/
         uLIWLM903ITOw==
Date:   Thu, 12 Dec 2019 22:40:50 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Eric Dumazet <edumazet@google.com>
Subject: Re: linux-next: build warning after merge of the rcu tree
Message-ID: <20191212224050.3ef73e82@canb.auug.org.au>
In-Reply-To: <20191212060200.GW2889@paulmck-ThinkPad-P72>
References: <20191212160622.021517d3@canb.auug.org.au>
        <20191212060200.GW2889@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/pEvJI8MKcKppz9u_G=by=hJ";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/pEvJI8MKcKppz9u_G=by=hJ
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Paul,

On Wed, 11 Dec 2019 22:02:00 -0800 "Paul E. McKenney" <paulmck@kernel.org> =
wrote:
>
> On Thu, Dec 12, 2019 at 04:06:22PM +1100, Stephen Rothwell wrote:
> >=20
> > x86_64-linux-gnu-gcc (Debian 9.2.1-21) 9.2.1 20191130 =20
>=20
> I don't see this warning with gcc version 7.4.0.  Just out of curiosity,
> what are you running, Stephen?

See above (9.2.1). ;-)

--=20
Cheers,
Stephen Rothwell

--Sig_/pEvJI8MKcKppz9u_G=by=hJ
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl3yJ0IACgkQAVBC80lX
0GzaxwgAmtzzx2UkHFwce0sqego5C/AuS0s1DSVKcEwn1nYdhD07xxJGTOuO2KS1
0IdFGyy+Lly5MoNh9rAwrMYPB6umbDsKIlKtmIdrYGZO/FvJD6bE4rX6D96WO50f
0BoMsTCzaFBWSHviNHZV8daudCNn6cuNIx6tCKmLiSpnbTSZSt6kntm6nRZuT9zU
Z2YgFqnhlylCSXJNVlG+HUJc3xgkO/ZpkK3B3ZxcUfUzjuf4y6VIs67TPXTw2Jcp
PvQva8fPj3x+O/I8AOYrBuWcf2TcqUwdYESs95p8uuIyS4klhOActfL6gpk7Gewf
alUYxJbb2eRaRKzyF0YCwJQL+wqHkA==
=jdz0
-----END PGP SIGNATURE-----

--Sig_/pEvJI8MKcKppz9u_G=by=hJ--
