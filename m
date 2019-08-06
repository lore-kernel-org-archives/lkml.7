Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D973C31E40
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 13:19:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AFE6214C6
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 13:19:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565097572;
	bh=fwhYa36kicYLd4QAPZrcY2nHdSADWgG7TogiOuwcMIE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=pdLhr+WsSn1bV8O/t1VQDJTZvQdLPb+bjb2gwBxteoztVhbCV3xY3IPSJ2ZbApfLP
	 RXPuhKcQY6x1zhumMlp3o6lzzWuxIOhQgi9oLfsyGLihgRx+P3BMj6UZqQcGexBcHC
	 6lkOhUSYCZsbz34aVOBpArRP2GVw+w3jUT+KR1Tw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731859AbfHFNTa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 09:19:30 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:52606 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726877AbfHFNTa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 09:19:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=/YlBTsdKaLWiGTA3PgSDfUuNoWKMNUoS35CDFJHvndg=; b=wXJ0GPsyXW3kOHbFTuOfhIXfp
        0tuUwVVQ+VRWj3g0WdMV33xltNLalzNIVhnDTNZDPy2Fe1tzCgG9SqLtQVatAaFR5x8CJSkD366pG
        +5lBZ03HBwKvUTXDBjjdUqHE5Ld3Msmt8mKMtFauycD6ygiJnL6CchvyIAr1gSV+HvmYI=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.org.uk>)
        id 1huzN8-0004aT-5B; Tue, 06 Aug 2019 13:19:26 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 274A02742B67; Tue,  6 Aug 2019 14:19:25 +0100 (BST)
Date:   Tue, 6 Aug 2019 14:19:25 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Konstantin Ryabitsev <mricon@kernel.org>
Subject: Re: [GIT PULL] regulator fixes for v5.3
Message-ID: <20190806131925.GC4527@sirena.org.uk>
References: <20190805143431.GH6432@sirena.org.uk>
 <CAADWXX_DXyBx5soZdYMcGtVB-MFhCy0C590ez=OH09eA+c1Kvw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="5G06lTa6Jq83wMTw"
Content-Disposition: inline
In-Reply-To: <CAADWXX_DXyBx5soZdYMcGtVB-MFhCy0C590ez=OH09eA+c1Kvw@mail.gmail.com>
X-Cookie: All men have the right to wait in line.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--5G06lTa6Jq83wMTw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 05, 2019 at 11:42:29AM -0700, Linus Torvalds wrote:

Adding Konstantin.

>  these got marked as spam once again, because
>=20
>    dmarc=3Dfail (p=3DNONE sp=3DNONE dis=3DNONE) header.from=3Dkernel.org
>=20
> and I think it's because you have
>=20
>    DKIM-Signature: v=3D1; a=3Drsa-sha256; q=3Ddns/txt; c=3Drelaxed/relaxe=
d;
> d=3Dsirena.org.uk;
>=20
> but then you have
>=20
>    From: Mark Brown <broonie@kernel.org>
>=20
> so the DKIM signature is all correct, but it's correct for
> sirena.org.uk, not for the sender information..

Well, AFAICT this is your mail provider deciding to impose their own
requirements on things.  (and for clarity it's only the From: that has
kernel.org, the envelope sender has sirena.org.uk.)

The DKIM signature there says that the sirena.org.uk systems are
asserting that they take responsibility for the headers they sign, this
is true and says nothing about the content of those headers other than
you can tell if they were modified since leaving sirena.org.uk.  The
DMARC check is a separate one based on the domain reported in the
address, kernel.org has one which explicitly advertises having no policy
and only filtering 1% of outbound mail so shouldn't really mean anything
for processing.  DMARC can flag that there has to be a DKIM signature
=66rom the domain in the headers but kernel.org doesn't do that.

We *do* have a SPF record for kernel.org which I think isn't helping
since it flags all hosts as being SOFTFAIL (the last match is ~all)
which is supposed to be something along the lines of accept but flag, I
can see your provider deciding that spam is the appropriate tag there.
As far as I can see that'd also flag mail sent by things like the
patchwork tracker bot similarly (it sends from mail.kernel.org which
isn't advertised as a sender).

I suspect Google will only be happy if I inject mail through them,
possibly also if I filter kernel.org mail to redirect via kernel.org
though that might still trip them up.

--5G06lTa6Jq83wMTw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl1JflwACgkQJNaLcl1U
h9BM4wf/Rx59c60W/6jq29u9EAPRAe3iUem2n9OYioKpZU+gVTmr08lf0m3nB6ih
cTi5ehzBOSic1SyflKvj1tzT0DV971WRZvj2Z0mUppcNrv37ouUYxJf3qg8n5N+k
qSS/1yHme62GA0nNvBa6vt/ZG8OwhAOB9T3fC5h5UlPx3ikh49TA3BAxjPcLHNmX
VLCXVQrju0Tai8mCMpP9ugZnUXlG9Fmwu+ixw7c5kAkmAP3FjS/BsJAX5vCXlioe
TvUIA0qEmezB1AeoVZiY6/f5L46Qucb82sQbjBzKOOxO+a/CAHOhPLWxQOVasnED
2IJmcn574cSJqu9OAPEQipJ3787wQg==
=l47q
-----END PGP SIGNATURE-----

--5G06lTa6Jq83wMTw--
