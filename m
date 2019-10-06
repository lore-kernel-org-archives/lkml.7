Return-Path: <SRS0=Dm7n=X7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02E17C10F14
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 11:00:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC5E12084B
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 11:00:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726633AbfJFLAs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Oct 2019 07:00:48 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:43555 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726224AbfJFLAr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Oct 2019 07:00:47 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 27F0D80471; Sun,  6 Oct 2019 13:00:31 +0200 (CEST)
Date:   Sun, 6 Oct 2019 13:00:45 +0200
From:   Pavel Machek <pavel@denx.de>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Mat King <mathewk@google.com>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, gregkh@linuxfoundation.org,
        rafael@kernel.org, Ross Zwisler <zwisler@google.com>,
        Rajat Jain <rajatja@google.com>,
        Lee Jones <lee.jones@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Alexander Schremmer <alex@alexanderweb.de>
Subject: Re: New sysfs interface for privacy screens
Message-ID: <20191006110045.GB24605@amd>
References: <CAL_quvRknSSVvXN3q_Se0hrziw2oTNS3ENNoeHYhvciCRq9Yww@mail.gmail.com>
 <20191002094650.3fc06a85@lwn.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="bCsyhTFzCvuiizWE"
Content-Disposition: inline
In-Reply-To: <20191002094650.3fc06a85@lwn.net>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--bCsyhTFzCvuiizWE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed 2019-10-02 09:46:50, Jonathan Corbet wrote:
> On Tue, 1 Oct 2019 10:09:46 -0600
> Mat King <mathewk@google.com> wrote:
>=20
> > I have been looking into adding Linux support for electronic privacy
> > screens which is a feature on some new laptops which is built into the
> > display and allows users to turn it on instead of needing to use a
> > physical privacy filter. In discussions with my colleagues the idea of
> > using either /sys/class/backlight or /sys/class/leds but this new
> > feature does not seem to quite fit into either of those classes.
>=20
> FWIW, it seems that you're not alone in this; 5.4 got some support for
> such screens if I understand things correctly:
>=20
>   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/comm=
it/?id=3D110ea1d833ad

Hmm. We may want to revert that one because it does more damage :-(.
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--bCsyhTFzCvuiizWE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl2ZyV0ACgkQMOfwapXb+vLMsgCgvF0IGuV68NhxRO0Vrfpn9drc
tRMAoLOK4nrZ6f33bOuuV/8VbK9F49Xk
=iq5R
-----END PGP SIGNATURE-----

--bCsyhTFzCvuiizWE--
