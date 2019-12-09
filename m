Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D82CC43603
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 16:24:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 664E920692
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 16:24:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575908662;
	bh=MNTrXGO26GOoZkz8HHd8p6GEzK7hstiNRPpnnNhceSM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=0X4ZIqIUMDjwJpuE8Om4H9dudzLCvgPhxsgkNUEsLtjB9Xgm3dGmG9BJi92A4RKGR
	 nZtq0vSdK/tP/LhhhFV/ZYYSZm0O8Fi8w1o48CbPCf/Vl7gJD148aEBwQp743TjFcr
	 cSmqjm0L4PRczfn/8ntoeNXyLEX2Ckqw2Yas0SZM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726691AbfLIQYV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 11:24:21 -0500
Received: from foss.arm.com ([217.140.110.172]:37490 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726230AbfLIQYU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 11:24:20 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 188571FB;
        Mon,  9 Dec 2019 08:24:20 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8AFA53F718;
        Mon,  9 Dec 2019 08:24:19 -0800 (PST)
Date:   Mon, 9 Dec 2019 16:24:17 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Chuhong Yuan <hslester96@gmail.com>
Cc:     Brian Austin <brian.austin@cirrus.com>,
        Paul Handrigan <Paul.Handrigan@cirrus.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        James Schulman <james.schulman@cirrus.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: cs42l42: add missed regulator_bulk_disable in
 remove and fix probe failure
Message-ID: <20191209162417.GD5483@sirena.org.uk>
References: <20191206075209.18068-1-hslester96@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ieNMXl1Fr3cevapt"
Content-Disposition: inline
In-Reply-To: <20191206075209.18068-1-hslester96@gmail.com>
X-Cookie: We read to say that we have read.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ieNMXl1Fr3cevapt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 06, 2019 at 03:52:09PM +0800, Chuhong Yuan wrote:
> The driver forgets to call regulator_bulk_disable() in remove like that
> in probe failure.
> Besides, some failed branches in probe do not handle failure correctly.
> Add the missed call and revise wrong direct returns to fix it.

Same issue with runtime PM here. =20

Also please submit one patch per change, each with a clear changelog, as
covered in SubmittingPatches.  This makes it much easier to review
things since it's easier to tell if the patch does what it was intended
to do.  When splitting patches up git gui can be helpful, you can stage
and unstage individual lines by right clicking on them.

--ieNMXl1Fr3cevapt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl3udTEACgkQJNaLcl1U
h9Bqbgf9GTYhOs7Nn3KkyBrYfs9NAQYMhCp8xOVquBih5sU9TwD7H0AG8fXJH2Eu
p8jFyERHbkF5DMeHKeP/hzl67ozizN+Iy4JS1DeBMlskvgX1Bu3B465+/MVFREbA
ivJEXS9KlF8BXHjFiy512SvsxYjtcdq8sYsO6SNi+yGDd1dGxYfXefVolMkapckR
FbJ/hWFj+xJl7x9fEcoi1JeowSVu6Pg03UmoyA2B00pLA1DUR8nxbHCV/oHfK8GV
631fB7i6WCh9OdI2pZqE9xVgHPjnbctVoV5S9K5B0nqabr+2gA5yLHHBY5bqz4DH
otFYGNuL1eFWPBSiNsVG8Q6Ex7tEfA==
=ZgZ0
-----END PGP SIGNATURE-----

--ieNMXl1Fr3cevapt--
