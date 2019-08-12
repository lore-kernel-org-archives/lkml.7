Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA833C433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 11:10:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 761DC20842
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 11:10:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565608216;
	bh=tS6IR6P1x92K78yk6lWGvErb+OAt9xyhyDY3++Qc7xo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=qlP5HPAM3kr0bhcKnScQfWc34caUI7nSsOQey7CFSMg8p9oe7htU260lChzU8a598
	 Sa8dtSnFWsLyeaDH4MwRXPKPk7RxPEreeIldnYCmrMC6Uvcl6OK6aZRpUF98j68zrd
	 DAyDxwNK/3bh44aHoGWahU/vSZU4XKFNd6S95rTk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728090AbfHLLKP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 07:10:15 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:35984 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727235AbfHLLKO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 07:10:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=vED+9cQ0sertdJ1ms2MKGbJLYJH7mjscNUgYcRMgoP8=; b=nBG/fX81cclUONp6sUQcuMu7E
        JluFxxkl0XrObYtk/lHbAKQ1I4vVR2I/xm3HeDy6A2oL/efLgCopfTe4tA7twrHPvqdWF/x+ACcYq
        sbKy/2Kpke0l+H62/MuFWww6VzAPB3gLYUJjeASrhWnLN+4BE4mzRJW16Qk/5FwcaFGs8=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1hx8DM-000134-51; Mon, 12 Aug 2019 11:10:12 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 94A3527430B7; Mon, 12 Aug 2019 12:10:11 +0100 (BST)
Date:   Mon, 12 Aug 2019 12:10:11 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Raag Jadav <raagjadav@gmail.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Liam Girdwood <lgirdwood@gmail.com>
Subject: Re: [PATCH 1/2] regulator: act8865: operating mode and suspend state
 support
Message-ID: <20190812111011.GF4592@sirena.co.uk>
References: <1565423335-3213-1-git-send-email-raagjadav@gmail.com>
 <1565423335-3213-2-git-send-email-raagjadav@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="QXO0/MSS4VvK6f+D"
Content-Disposition: inline
In-Reply-To: <1565423335-3213-2-git-send-email-raagjadav@gmail.com>
X-Cookie: Decaffeinated coffee?  Just Say No.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--QXO0/MSS4VvK6f+D
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Aug 10, 2019 at 01:18:54PM +0530, Raag Jadav wrote:

> +static int act8865_set_mode(struct regulator_dev *rdev, unsigned int mode)
> +{
> +	struct act8865 *act8865 = rdev_get_drvdata(rdev);
> +	struct regmap *regmap = rdev->regmap;
> +	int id = rdev_get_id(rdev);
> +	int reg, ret, val = 0;

This function doesn't check if the mode is _FIXED - if it is then I'd
expect to get an error when trying to set the mode (I'm assuming that
means fixed in hardware).

> +static unsigned int act8865_get_mode(struct regulator_dev *rdev)
> +{
> +	struct act8865 *act8865 = rdev_get_drvdata(rdev);
> +	int id = rdev_get_id(rdev);
> +
> +	if (id < ACT8865_ID_DCDC1 || id >= ACT8865_ID_MAX)
> +		return -EINVAL;
> +
> +	return act8865->op_mode[id];
> +}

This should be reading the value back from the hardware.

--QXO0/MSS4VvK6f+D
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl1RSRIACgkQJNaLcl1U
h9BhNQf7B2/bNkk+XZ0e/tSVOzn00nt73fznt5qCrh7/yAtFkVxdf6LjfSE1npvK
SueIulSiA0j0bCBr//JcD19lDdGzdrCH3+bc6vRFfFSOo5tJfqsm/gCYJg8k86uS
1uT4fRIJfp0dVtG0CADCY1mxAY3bltg8TRHKudtQHv9bV5Wm0iV7oQrcSrttowCk
HgsoWDMg6VHDp+kxoPt1GzP7vlIB85KOGpjq7wY0/LCPih+/rwbmvTC36KXtrD9o
3bm949Pf2aw/x1EQ8ImqVBpJmtq8gWTjhjMe7VWwhu5LuLu2UD22HvkkcA9pp7tB
LEr7wsIbp2dzxwUgLWZZgVDRzNRDyg==
=N1iA
-----END PGP SIGNATURE-----

--QXO0/MSS4VvK6f+D--
