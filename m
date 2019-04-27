Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22C92C43218
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 18:21:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E69912087E
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 18:21:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556389290;
	bh=2y00pJ7Sy1RH0RaBP1rlxte+4YT4TxklyGy1xA/5XG8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=r+OA/3UdEDWGRihSRbHCiUbCp021o1n75mZpYJrTez2znU9EzYf3SdayDoB/RZYg+
	 IgdMOy7/cCHM/d9gd1/JLT7zphyhEAPDrqRyhlG4yhogI+OUpltENjl3Kp8PMK3T+u
	 XEsm+13gkkLnDhqmSEgVb7a/CSIbczYR1SzyToYc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726336AbfD0SV2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 14:21:28 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:34232 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726053AbfD0SV2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 14:21:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=p01vbJpyOWJAdEXdJU0OCfw6W6SYYsQSTTr9W3aE80M=; b=oJ1uFElZv1svSo9snDycG0e8y
        X48y5Srs/Ekw8ZvHe6Od0d3EayaPfXx2H79dKk9/lxbXPDG1wUIDDzU+rWqiyA+ExIDZSzmVRqvLb
        8MGoXm/TgudGdCH7HjrW0xDCfvA5HEc3F4yFVR5AXbzxsQDSWOsafg76J0wJBGqUEV0MU=;
Received: from [211.55.52.15] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hKRwq-00053h-RE; Sat, 27 Apr 2019 18:21:17 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 54AE1441D3B; Sat, 27 Apr 2019 19:21:13 +0100 (BST)
Date:   Sun, 28 Apr 2019 03:21:13 +0900
From:   Mark Brown <broonie@kernel.org>
To:     Jorge Ramirez <jorge.ramirez-ortiz@linaro.org>
Cc:     lgirdwood@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        bjorn.andersson@linaro.org, vinod.koul@linaro.org,
        niklas.cassel@linaro.org, khasim.mohammed@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 2/3] drivers: regulator: qcom: add PMS405 SPMI regulator
Message-ID: <20190427182113.GL14916@sirena.org.uk>
References: <1548675904-18324-1-git-send-email-jorge.ramirez-ortiz@linaro.org>
 <1548675904-18324-3-git-send-email-jorge.ramirez-ortiz@linaro.org>
 <20190204090301.GC23441@sirena.org.uk>
 <95276ca0-6896-a595-867a-184a518fa31f@linaro.org>
 <20190425183736.GF23183@sirena.org.uk>
 <022b3c6a-e356-3c5a-3c46-c6edcf4f8cd5@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="sCNd3Ivk/oijKKf1"
Content-Disposition: inline
In-Reply-To: <022b3c6a-e356-3c5a-3c46-c6edcf4f8cd5@linaro.org>
X-Cookie: -- I have seen the FUN --
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--sCNd3Ivk/oijKKf1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Apr 25, 2019 at 09:44:00PM +0200, Jorge Ramirez wrote:

> the way I see it, if I follow your suggestion and since we are not
> allowed to extend spmi_regulator_find_range(), the only options are:

> 1) duplicate verbatim this whole function
> (spmi_regulator_select_voltage_same_range) with a minor change (this
> amount of code duplication in the kernel seems rather unnecessary to me)

> 2) modify the struct spmi_regulator definition with a new operation that
> calls a different implementation of find range (seems a massive overkill)

Since the point of this change is AFAICT that this regulator only has a
single linear range it seems like it should just be able to use the
existing generic functions shouldn't it?  It just needs it's own
set/get_voltage_sel() operations.  As far as I can see the main thing
the driver is doing with the custom stuff is handling the fact that
there's multiple ranges but that's not an issue for this regulator.
It's possible I'm missing something there but that was the main thing
(and we do have some generic support for multiple linear ranges in the
helper code already, can't remember why this driver isn't using that -
the ranges overlap IIRC?).

TBH looking at the uses of find_range() I'm not sure they're 100%
sensible as they are - the existing _time_sel() is assuming we only need
to work out the ramp time between voltages in the same range which is
going to have trouble.

--sCNd3Ivk/oijKKf1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlzEnZYACgkQJNaLcl1U
h9Be2wf/Ts0rAq3XrujapmG1sE36u6DgwDxHfPpMSejg40goWEljc2BT0WnUwqiC
NRj8O2f8zXZJ6jEofNYk6dOO17ej93naTtIO34nDIU7KSB0q0DhyApUTMwGiFuC9
b5Aoa1EvRAaqQ/Pr9n8XUHnDxgCJsMzDxz9w6dXlT0fgDnvoFnQAL1OYaHZjwb72
Sgp/3sJSpniaTGO+F3QaSV/lmGJ/7bMRvvNSQZOpwYc10YRmuFOGcGw2WZp71G4q
XUlyxvscZ77dvHs3p/p87mwuzJID6ZTxnIFcH3ScemFJE6DDSN4aRb1gfVZtrOIS
qdrDP4sKHBDd+xxxcUqJVBtZaWHK/Q==
=RPrf
-----END PGP SIGNATURE-----

--sCNd3Ivk/oijKKf1--
