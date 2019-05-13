Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9A1DC04AA7
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 17:38:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8C0920879
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 17:38:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557769101;
	bh=Iwov9G7FnWM8+oW1h2bpLYWmgjvy2/hKlYqyfJvFQV4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=eJhi/AXjMdVycvJs4aW007Ee7s2PsRDC1rMudTzlbO26fu6jBMCwlSRzhyfwnVvgk
	 0x26U9nonrJUJCp3Fk2nN0B5Pf4v+X7gS8Nm9W5BxSgctCJ7gX2PCh95JBBU8Kmg4D
	 7Ka6ybyzwaAHIcYuhZn7/74igon9CgeTvkSVF2nU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731734AbfEMRiU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 13:38:20 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:36776 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728708AbfEMRiU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 13:38:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=58jXVQ0+TtZLZlp36q1XVZdZ7OzoAlikobzpPMitF7I=; b=jT5J2Di2LshJRMWSh7hSj67gK
        +jNTUzKPGy6FPbwOScKuqm0MJ08slI2aAz1Ty+G1Z8hTIVKB6JCtE8d4dCD269AQg6YDx6fKxDyCH
        N243UqMqZE5we73hWPUVekVywZeEzXho+WHJ8sY3FVXC/i065tworR64f5JP/vFeFU8Bw=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hQEu1-0007F9-16; Mon, 13 May 2019 17:38:17 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 3B0081129232; Mon, 13 May 2019 18:38:16 +0100 (BST)
Date:   Mon, 13 May 2019 18:38:16 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v1 5/6] soc/tegra: regulators: Add regulators coupler
 for Tegra20
Message-ID: <20190513173816.GG5168@sirena.org.uk>
References: <20190414175939.12368-1-digetx@gmail.com>
 <20190414175939.12368-6-digetx@gmail.com>
 <20190508075706.GW14916@sirena.org.uk>
 <9756d8ca-0778-5185-5b6b-3168d63819ec@gmail.com>
 <20190512090627.GO21483@sirena.org.uk>
 <586b4f29-1937-2d7b-3944-c29311502878@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="2E/hm+v6kSLEYT3h"
Content-Disposition: inline
In-Reply-To: <586b4f29-1937-2d7b-3944-c29311502878@gmail.com>
X-Cookie: Must be over 18.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--2E/hm+v6kSLEYT3h
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, May 12, 2019 at 08:42:39PM +0300, Dmitry Osipenko wrote:
> 12.05.2019 12:06, Mark Brown =D0=BF=D0=B8=D1=88=D0=B5=D1=82:

> > This seems like it should be easy enough to describe - we just need
> > minimum and maximum spreads between pairs of rails.

> Yes, but the proper CORE/RTC minimum voltages shall be maintained until
> all drivers will get support for the voltage management, which likely to
> take a lot of time to get upstreamed. So I'd want to get at least some
> basics working for the start, later on it should be possible to consider
> generalization of the regulators coupling. Mark, are you okay with
> having the custom regulators coupler as an interim solution?

Let me think about it.  Interim solutions have this habit of hanging
around and the bit with needing to get all the drivers loaded is very
much an open and substantial question...  :/  Definitely not something
I'd close the door on at this point though.

--2E/hm+v6kSLEYT3h
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlzZq4cACgkQJNaLcl1U
h9CQ6wf+PvgtU7EJ2C1PXYPtCxlox08atULwBABD9ftnREB2Y8nHew4DsD+aJt1o
w3IaUDNm5Q+xv195r7SA7OmyEdfaL3SI/FviIlskTwr/m8it/7fg5mZp7A10wHoy
FBsy42N7DvCqQOpLKLGqN9BEjn2kLPB+LeTVeqhjhLhzh0mfF6hNsmY1Xi64pDW3
17EuV55sxfBFVfvho1pnRX9dbnJK3ZhUOjqCfig2B3nSXNGKx4SMa7JFmOFAXr8I
bfMundBb26g8He+AJ+Zc4WP2nmiRYZDjZEb/9zMWChAd3I1aGNCA1V7ySPpH+RqI
/AkdKVJLDk1ipcBaE15F1udmls8ACA==
=GaLr
-----END PGP SIGNATURE-----

--2E/hm+v6kSLEYT3h--
