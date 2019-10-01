Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8488EC352AA
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 17:30:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 598FF2133F
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 17:30:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569951018;
	bh=K69iFAnjPBsNGd80jcNgFIDiMKUmvK6sd80+LuyZPWs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=FUZZOZERCaSatVNE1dB8dEDCniTINDTAnYnkmS5ELlRTuxvmxbsb+mtaq/FvBINyw
	 hw1K8VH5w1o3G5PRSiEGxUOUcQhPGps+GPlqPZO9kzmpoKXZhklodZ06eisSzcRSv2
	 7GB0OzL99OoTF8yJiVWNEvfPy7XXLvK8z5dKZa+0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730557AbfJARaR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 13:30:17 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:35120 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727721AbfJARaR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 13:30:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=lTpgWj/lyGtni4J5FE3WcdA3ifqDB8F61MancmRFDZg=; b=vUbZIQnOOGi7W7s9lj1TMqWRC
        yO20baUmYZDsdtuApUVxVzFG5CbwY5MfFgLMA6Qa4kca7r1Ny1PULNyujxF0m2xtRYykLB/ktEWWv
        etnJvn7TtcqmdIx3UOpgg2Q/fqmt8gNunVeX03s9nTi0yWN4DIpUWzmPc10xDkKf1eO2Y=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1iFLy2-0005mV-JZ; Tue, 01 Oct 2019 17:29:42 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 7977927429C0; Tue,  1 Oct 2019 18:29:41 +0100 (BST)
Date:   Tue, 1 Oct 2019 18:29:41 +0100
From:   Mark Brown <broonie@kernel.org>
To:     "Deucher, Alexander" <Alexander.Deucher@amd.com>
Cc:     "RAVULAPATI, VISHNU VARDHAN RAO" 
        <Vishnuvardhanrao.Ravulapati@amd.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        "Mukunda, Vijendar" <Vijendar.Mukunda@amd.com>,
        Maruthi Srinivas Bayyavarapu <Maruthi.Bayyavarapu@amd.com>,
        Colin Ian King <colin.king@canonical.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." 
        <alsa-devel@alsa-project.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/7] ASoC: amd: No need PCI-MSI interrupts
Message-ID: <20191001172941.GC4786@sirena.co.uk>
References: <1569891524-18875-1-git-send-email-Vishnuvardhanrao.Ravulapati@amd.com>
 <BN6PR12MB18093C8EDE60811B3D917DEAF79D0@BN6PR12MB1809.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Y5rl02BVI9TCfPar"
Content-Disposition: inline
In-Reply-To: <BN6PR12MB18093C8EDE60811B3D917DEAF79D0@BN6PR12MB1809.namprd12.prod.outlook.com>
X-Cookie: Keep refrigerated.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Y5rl02BVI9TCfPar
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Oct 01, 2019 at 05:23:43PM +0000, Deucher, Alexander wrote:

> > ACP-PCI controller driver does not depends msi interrupts.
> > So removed msi related pci functions which have no use and does not impact
> > on existing functionality.

> In general, however, aren't MSIs preferred to legacy interrupts?

As I understand it.  Or at the very least I'm not aware of any situation
where they're harmful.  It'd be good to have a clear explanation of why
we're removing the support.

> Doesn't the driver have to opt into MSI support?  As such, won't
> removing this code effectively disable MSI support?

Yes.

--Y5rl02BVI9TCfPar
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl2TjQQACgkQJNaLcl1U
h9DC/gf8C6vOACPQWvbRJO9LfPWnIyOnAhpmiVNNeGV59bbMmSRSjT3zuIsVNoMe
6J498TvqIOcb2NxSsGukipQbrWSYomHT7+XmgDjXSQGPGkZ86bgiP95O+ZqKAXqT
1RjADLkZQpQMsmDSqFeWNJP0dlYrIs9uPmUCuhI+bHdtiF6Sc2cJL9wtiHZDXS3T
qmFaFOu4+1bGoKNDITbdLBEAsn7mSmLc0GolWCrf9BeymlF4Vuarm9fx6GP3JBlf
G/UN8F8FEfvNa+3dGj+TyU7D+0uErLvwhy+d0Cm5eiw//fgjQhrNyDp7EbRlvbrr
v/RCUHZ9c4/5k6QHNr8OUNcCB7rURw==
=5uDK
-----END PGP SIGNATURE-----

--Y5rl02BVI9TCfPar--
