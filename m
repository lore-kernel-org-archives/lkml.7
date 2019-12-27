Return-Path: <SRS0=GVTe=2R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BA33C2D0CE
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Dec 2019 23:06:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00FED20828
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Dec 2019 23:06:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577487968;
	bh=smORAKnjUvCbDNHhwDd2LxYOhxeyxeun23/67oJlJ74=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=z+pTUe6qNoAgO/VqeQPsj87n6RUj2gKnzJCBBj7b3tG7aKMxX8hod8eAoM/ntCwIj
	 ruJ8PF1vxcoxQUANNZi9/whZrvg2uwr6rNs1dF+GOikOOY3pMEqyrHX8YWLlPFRnbw
	 1fX+mBaiccDvfXM3WWr/3rXgfEYNIXXQ5z9HVHbY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726465AbfL0XGH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Dec 2019 18:06:07 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:42742 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726220AbfL0XGG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Dec 2019 18:06:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=uo5gwvZX1uDmAXJCobtVZcEzJivK6+plImhSXfcTazg=; b=E8YSckFiwq8AmTe/jo3dd4d1H
        VrHrnqCBw7M3qZk/dbLor5AstRRROVDahgcKr1OIui8etXF+Jst+I0kB2opBTJ4jWIkuw3IjnjpFD
        V0OPmSjLSDqv2pcmawtgZdG5BP0LcCNM1LWmKgDcJ0lBguVtGfcrx0RA60erZ3w4jjFcE=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=fitzroy.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.org.uk>)
        id 1ikySj-0006bK-Ax; Fri, 27 Dec 2019 22:52:05 +0000
Received: by fitzroy.sirena.org.uk (Postfix, from userid 1000)
        id CCB0DD01A22; Fri, 27 Dec 2019 22:52:04 +0000 (GMT)
Date:   Fri, 27 Dec 2019 22:52:04 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Peter Seiderer <ps.report@gmx.net>
Cc:     linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        Annaliese McDermond <nh6z@nh6z.net>,
        Takashi Iwai <tiwai@suse.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Liam Girdwood <lgirdwood@gmail.com>
Subject: Re: [PATCH v1] ASoC: tlv320aic32x4: handle regmap_read error
 gracefully
Message-ID: <20191227225204.GQ27497@sirena.org.uk>
References: <20191227152056.9903-1-ps.report@gmx.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="90KBcPA0h13nTGdQ"
Content-Disposition: inline
In-Reply-To: <20191227152056.9903-1-ps.report@gmx.net>
X-Cookie: I have many CHARTS and DIAGRAMS..
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--90KBcPA0h13nTGdQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 27, 2019 at 04:20:56PM +0100, Peter Seiderer wrote:
> Fixes:
>=20
> [    5.169310] Division by zero in kernel.
> [    5.200998] CPU: 1 PID: 1 Comm: swapper/0 Not tainted 5.3.18-20191021-=
1+ #14
> [    5.203049] cdc_acm 2-1.6:1.0: ttyACM0: USB ACM device
> [    5.208198] Hardware name: Freescale i.MX6 Quad/DualLite (Device Tree)
> [    5.220084] Backtrace:
> [    5.222628] [<8010f60c>] (dump_backtrace) from [<8010f9a8>] (show_stac=
k+0x20/0x24)

Please think hard before including complete backtraces in upstream
reports, they are very large and contain almost no useful information
relative to their size so often obscure the relevant content in your
message. If part of the backtrace is usefully illustrative then it's
usually better to pull out the relevant sections.

--90KBcPA0h13nTGdQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl4GixQACgkQJNaLcl1U
h9A2XAf/ftJi8y2gf6jp5exddrR2eCgueTtnjQZXReQ7py0ARP6uZOB4OeAMQr4I
SpEg97JgYdyPaS8GZbklpT5Vy740Dk7j9fJYQpyMv/VWzRV9csz1vSqJCzIhnMRz
m38aujNV1+ddXB1g1xDLcd76wD2M+RM+JCUb+Z6x7e8CK2JMe9YllQVHLkp0pSh+
zwmxEpTajmb976EdW8z8fFseuWub7BSDFw0aO7lqeekEM/hqFjX5IqkXLatTatVE
uXyR7PwBUudPDLlxwcnI9wP/4dfl3f+b7N/V0/CQnYe/lDXrwYB6I8jFlyqQbXmh
VvSW8YZOaXPoWhSI0+mDvbM58wkXaQ==
=2cP3
-----END PGP SIGNATURE-----

--90KBcPA0h13nTGdQ--
