Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7B6ECA9EC0
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 12:46:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAC7A20873
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 12:46:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572266769;
	bh=b7lPYDXYrqw+a+RkkhgfIVByGS9gFwh0+pd1efwDy3I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=NpsvTGg/Zjn246f0zmSun517K7XpuNF2hLwJhvVIyawdOPb9tvkgV7ZH02vI/Qsos
	 8vNtz4NrSc2NrBJsoQC46AliZsssBtfe6z/4FXzlYbP2kU/ehLfmDHj9AViE+kGf56
	 YDndVv1UYRHHdrZFgsdU8p4o3TVkiwZRmkw8fmps=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728712AbfJ1MqI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 08:46:08 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:45860 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727316AbfJ1MqH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 08:46:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=DgGDsAKyVUrx9Nc+HZOfio84g/UIrh4y/xJCFt/W6J0=; b=Av+JWi2PYySHmGGqfcn9/DwAM
        8Er7eLGpMySNIDrrA2wRQ5KuAqoEGCzyOGCX/r5H1/enGxu9vdEEgN1SiVXV7MgMKTganDVo9KSxC
        j02bcrlm3BO06NU2ZjtnJPf8XAQOZoWgjq3Sv25Iun56y4ljdgQUS0LtiBGIRrhv6vDXQ=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1iP4PE-000879-3S; Mon, 28 Oct 2019 12:45:56 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 36A4827403CF; Mon, 28 Oct 2019 12:45:54 +0000 (GMT)
Date:   Mon, 28 Oct 2019 12:45:54 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andrey Zhizhikin <andrey.z@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>, lgirdwood@gmail.com,
        lee.jones@linaro.org, linux-kernel@vger.kernel.org,
        Andrey Zhizhikin <andrey.zhizhikin@leica-geosystems.com>
Subject: Re: [PATCH 0/2] add regulator driver and mfd cell for Intel Cherry
 Trail Whiskey Cove PMIC
Message-ID: <20191028124554.GF5015@sirena.co.uk>
References: <20191024142939.25920-1-andrey.zhizhikin@leica-geosystems.com>
 <20191025075335.GC32742@smile.fi.intel.com>
 <20191025075540.GD32742@smile.fi.intel.com>
 <166c9855-910d-a70c-ba86-6aebe5f2346d@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="FeAIMMcddNRN4P4/"
Content-Disposition: inline
In-Reply-To: <166c9855-910d-a70c-ba86-6aebe5f2346d@intel.com>
X-Cookie: The Moral Majority is neither.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--FeAIMMcddNRN4P4/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Oct 28, 2019 at 02:41:46PM +0200, Adrian Hunter wrote:
> On 25/10/19 10:55 AM, Andy Shevchenko wrote:

> > Since it's about UHS/SD, Cc to Adrian as well.

> My only concern is that the driver might conflict with ACPI methods trying
> to do the same thing, e.g. there is one ACPI SDHC instance from GPDWin DSDT
> with code like this:

That's certainly what's idiomatic for ACPI (though machine specific
quirks are too!).  The safe thing to do would be to only register the
supply on systems where we know there's no ACPI method.

--FeAIMMcddNRN4P4/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl224wEACgkQJNaLcl1U
h9AxlAf/SAa8Vkyd7mcOgehlR6dCb2OslCyfWMSOyWw+PotW+Zu0E16J6oPQwxo+
qPepODTVkei2w0TlI5hF2o1PQmqXcQHPTGKOUMlifn9JiHy4BugJYfW6pUd8FGCr
Uz8XeC31AnXh9IStgNiBvkYj1KghKQOAejR92w7Out3EDymy8fNaSupvIbEXF08L
qC5/jeTCfUkeCbz4zzPkkUgjB4asELfbYpAWxOMkRYL8K4ojaGMLGdi3pMDHf+oi
FCrZx0HGWU4mYLbrlAE644epQbekCtikb0+XaZvF98hCPSPZMyXtF0Br610cFHZW
TM8Yn76fhsUwxD1Dque0Nh39kOpChg==
=M+zR
-----END PGP SIGNATURE-----

--FeAIMMcddNRN4P4/--
