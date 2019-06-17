Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88279C31E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 15:45:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BC682084A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 15:45:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560786302;
	bh=W2ApH5dPv1yN0+v2tlxAMEjXqIOkZyz/SmmL6jpSBOo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=lR8KCOEOznjfIZHC0vqNozW2+neFylqYdva69r+CHt06r8aUGODA+v6cr88BneedD
	 NB/UriPORxVeQGnC+J/JBnmxIgA4n8kxrGMT/MBLwM8CiVedXVgPsacpl40CZW3MKN
	 ntcwt9cpA9kJVLdgsGVPmHPz4g4WjfY9dUoPYNX0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728334AbfFQPpA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 11:45:00 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:57644 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726292AbfFQPpA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 11:45:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=abiEFLdLM5bKoC/xwI6l9zjIRnj1imHHSsabySegASw=; b=i//avOnePiyWK6TuEr3iyKH7N
        Vyr9zfFf7bxM/t3PagBBpsFQIpDOrzQvlSXRhGZUhbEP9w7CPDf1E+zoKd+oVh2kCDz0MerBHg/Hq
        dQ91xgIWxzdc0b2nOjUqQUm5+WKtYFXE6i6CwzLb+ORBGLn6/pw54lLIn3rNPIKVW+Z3U=;
Received: from [2001:470:1f1d:6b5:7e7a:91ff:fede:4a45] (helo=finisterre.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hctoV-00023a-SV; Mon, 17 Jun 2019 15:44:56 +0000
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
        id 3E942440046; Mon, 17 Jun 2019 16:44:55 +0100 (BST)
Date:   Mon, 17 Jun 2019 16:44:55 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 6/8] regulator: core: Don't attach generic coupler to
 Tegra SoC regulators
Message-ID: <20190617154455.GA5316@sirena.org.uk>
References: <20190603235904.19097-1-digetx@gmail.com>
 <20190603235904.19097-7-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="27E2kr7c9faIxYHh"
Content-Disposition: inline
In-Reply-To: <20190603235904.19097-7-digetx@gmail.com>
X-Cookie: Editing is a rewording activity.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--27E2kr7c9faIxYHh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jun 04, 2019 at 02:59:02AM +0300, Dmitry Osipenko wrote:

>  static int generic_coupler_attach(struct regulator_coupler *coupler,
>  				  struct regulator_dev *rdev)
>  {
> +	/*
> +	 * Generic coupler isn't suitable for NVIVIA Tegra SoC's, at least
> +	 * for now. Hence filter out the unwanted regulators as they shall be
> +	 * managed by a platform-specific coupler.
> +	 */
> +	if (of_property_read_bool(rdev->dev.of_node, "tegra-core-regulator") ||
> +	    of_property_read_bool(rdev->dev.of_node, "tegra-rtc-regulator") ||
> +	    of_property_read_bool(rdev->dev.of_node, "tegra-cpu-regulator"))
> +		return -EPERM;
> +

I'm having a hard time loving this as it requires explicit DT changes
for implementation.  I'm thinking that since the couplers are going to
need to be built in it'd be better to make sure that any custom ones get
registered first and then only bind the generic coupler to anything they
reject.

--27E2kr7c9faIxYHh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl0HtXYACgkQJNaLcl1U
h9Cs2gf/S5a8DWJTtoEHbG3ws7VHQpSeAm4iqr2UgbzOBEkdCHLdjK0r2Iu3LU2l
KpNbc46t5ZXSQjLIuQ3apaG1mBvinvL5AAX93z4uxez5NAnREGp6NbbP2Ph0bfBe
BMNr3a8K1FBZdaqi2lUjFJS1ZWaUB2Npz32XrgD4Cmhlw+y1Rrl7NPT9HztYaCa5
Jc7shPryXFXmczy12EARskXg2bcLlQ/Ne92dHRXKZEn2hMwW/1ehTNHadMHHBLjT
bikjaqGSNIvd9LlxcbzpBvukrgCaaT8ENLHPCVmeB3gag3n55alTU5ZnUIhpAXyp
eaXOfvK5Zmo08r+D59q1tU61z1s0JA==
=ZHI+
-----END PGP SIGNATURE-----

--27E2kr7c9faIxYHh--
