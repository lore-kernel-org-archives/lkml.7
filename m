Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B83BFC2D0C9
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 12:17:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9851A214AF
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 12:17:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729150AbfLLMRu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 07:17:50 -0500
Received: from jabberwock.ucw.cz ([46.255.230.98]:40678 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728996AbfLLMRu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 07:17:50 -0500
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 136581C246E; Thu, 12 Dec 2019 13:17:48 +0100 (CET)
Date:   Thu, 12 Dec 2019 13:17:47 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Sasha Levin <sashal@kernel.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Tony Lindgren <tony@atomide.com>,
        Merlijn Wajer <merlijn@wizzup.org>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 5.4 130/350] power: supply: cpcap-battery: Check
 voltage before orderly_poweroff
Message-ID: <20191212121747.GA17876@duo.ucw.cz>
References: <20191210210735.9077-1-sashal@kernel.org>
 <20191210210735.9077-91-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="huq684BweRXVnRxX"
Content-Disposition: inline
In-Reply-To: <20191210210735.9077-91-sashal@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--huq684BweRXVnRxX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue 2019-12-10 16:03:55, Sasha Levin wrote:
> From: Tony Lindgren <tony@atomide.com>
>=20
> [ Upstream commit 639c1524da3b273d20c42ff2387d08eb4b12e903 ]
>=20
> We can get the low voltage interrupt trigger sometimes way too early,
> maybe because of CPU load spikes. This causes orderly_poweroff() be
> called too easily.
>=20
> Let's check the voltage before orderly_poweroff in case it was not
> yet a permanent condition. We will be getting more interrupts anyways
> if the condition persists.
>=20
> Let's also show the measured voltages for low battery and battery
> empty warnings since we have them.

This is a tweak of power management parameters, not a fix for serious
bug.

Plus, it needs a lot of testing it did not get, yet.

Please drop from stable.
								Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--huq684BweRXVnRxX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCXfIv6wAKCRAw5/Bqldv6
8neQAKCuma2iqj3Mcwse+dL2ttWbLhR9vACglinMiBDLg/OwKBaFGXYSaNEjmiI=
=7UBu
-----END PGP SIGNATURE-----

--huq684BweRXVnRxX--
