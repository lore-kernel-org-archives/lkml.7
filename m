Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADA82C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 10:17:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8494220878
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 10:17:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728061AbfDXKRP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 06:17:15 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:36961 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726039AbfDXKRO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 06:17:14 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 8DF68809EA; Wed, 24 Apr 2019 12:17:03 +0200 (CEST)
Date:   Wed, 24 Apr 2019 12:17:11 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     kernel list <linux-kernel@vger.kernel.org>, rjw@rjwysocki.net,
        linux-pm@vger.kernel.org, sfr@canb.auug.org.au,
        linux-next@vger.kernel.org, hdegoede@redhat.com, axboe@kernel.dk,
        linux-ide@vger.kernel.org
Subject: Re: next-20190408..0418: Suspend/resume problems on Thinkpad X60
Message-ID: <20190424101711.GB32457@amd>
References: <20190408173928.GB13260@amd>
 <20190412102812.GA24977@amd>
 <20190423102239.GA15531@amd>
 <fed0549d-a789-294c-d899-304911106113@acm.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="98e8jtXdkpgskNou"
Content-Disposition: inline
In-Reply-To: <fed0549d-a789-294c-d899-304911106113@acm.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--98e8jtXdkpgskNou
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue 2019-04-23 07:09:42, Bart Van Assche wrote:
> On 4/23/19 3:22 AM, Pavel Machek wrote:
> >>> It boots ok (unlike mainline -- I'm debugging that), and I can suspend
> >>> and resume... but then cursor in X is moving and I can talk to
> >>> applications cached in memory, but any access to disk hangs.
> >>
> >> Mainline problem was identified.
> >>
> >> But resume is still broken. I took advantage of fact that I can still
> >> do cached commands, and got complete dmesg. I'm attaching it.
> >=20
> > Still broken in 0418. Ideas would be welcome at this point.
>=20
> Have you already tried the debugging steps explained in
> Documentation/power to obtain more information about the nature of the
> suspend/resume problem?

That won't help, as system resumes ok, then disk hangs.

Does it work for you?

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--98e8jtXdkpgskNou
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlzAN6cACgkQMOfwapXb+vJezgCgoWVWmfeF9ahvqokqnECrFOcX
h9UAmwaJqzgcLU/tD0reSxmWbm8ChQPv
=RDqQ
-----END PGP SIGNATURE-----

--98e8jtXdkpgskNou--
