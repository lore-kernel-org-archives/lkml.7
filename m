Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D141C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 12:22:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38176218D8
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 12:22:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553170960;
	bh=iR8uM0bklS/kN9O9IuOgETxuL9ER8Fq7QxErIk0RqDM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=a2quux+TH9KjJYJrmQWkkK6Cy5fiTMhRXu4Zj0aZh+WuTDArE3w8YJeo0O1ySU2Wl
	 i5NA7gbAZzHqkrK1k0v1yAoWlFpilFoPyfMRHX4Xo7F2LFyvENpPWU9QcFfMquq8cV
	 uVKQIeichM5cPoZJteOxDaUxf958VsC72rACmLXA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728138AbfCUMWi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 08:22:38 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:53564 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727881AbfCUMWi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 08:22:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=BYkMOLwaE2uMLszqlEA8ToGzTayU62GiiQjixYsvHnQ=; b=c5VXFbQ7F0eaYENcRJ8+AM7SZ
        sItj+hWa76VW8b+Ezj+mNL0nh1/JTfB3ApXR8k6Hs3b3mWaP6oMYmWinnqhXl3mUhz1LnGOCKonqv
        sXIO5hb/zPfiZq+eXNm6THcLU31PIiYpuxmgA8IZOBEeNPEhfBruljHLt3taAFoTvTTBk=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1h6whq-0004tH-Dz; Thu, 21 Mar 2019 12:21:58 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id C2CFC11288EC; Thu, 21 Mar 2019 12:21:52 +0000 (GMT)
Date:   Thu, 21 Mar 2019 12:21:52 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Akshu Agrawal <Akshu.Agrawal@amd.com>,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Support Opensource <support.opensource@diasemi.com>
Subject: Re: [PATCH 1/3] ASoC: da7219: Update DAI clock binding info to cover
 WCLK/BCLK
Message-ID: <20190321122152.GA5684@sirena.org.uk>
References: <cover.1553017237.git.Adam.Thomson.Opensource@diasemi.com>
 <a2e2ae888b3c2fbcaab3e4791ce98f877e3d38ff.1553017237.git.Adam.Thomson.Opensource@diasemi.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="3V7upXqbjpZ4EhLz"
Content-Disposition: inline
In-Reply-To: <a2e2ae888b3c2fbcaab3e4791ce98f877e3d38ff.1553017237.git.Adam.Thomson.Opensource@diasemi.com>
X-Cookie: Hackers of the world, unite!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--3V7upXqbjpZ4EhLz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 19, 2019 at 05:49:30PM +0000, Adam Thomson wrote:

> -- #clock-cells :  Should be set to '<0>', only one clock source provided;
> -- clock-output-names : Name given for DAI clocks output;
> +- #clock-cells :  Should be set to '<1>', two clock sources provided;
> +- clock-output-names : Names given for DAI clock outputs (WCLK & BCLK);

This might need some handling later on as it's a binding change, however
I can't see any current users so hopefully nobody will notice.

--3V7upXqbjpZ4EhLz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlyTgeAACgkQJNaLcl1U
h9B0qAf+PFsG2TAKEIRT9VDw6jBv1x9NUTOiIOByLkIgFdaUQ9F+Ve0TdGxHQncO
5h7ubsO0hb7whjsTNTK7LjCQS5Ibz9b8Upilqtr3Mg9uHi/gJCpKwve7T0mzMeVZ
wHWk26x5BdInzZOKHn8V2lu8kBKAiapJ0/CUp2r7qOTPhsfQM/bNU+JaVf0JjTQv
D57JjwlCblHOvi5PN35jzz/f7d78C4cj573MDtV5YNVTjSmRZ0hneNpU4AsTQHhA
K/DNAGbPN7juXURKxQWTFFo7UTlRwBrpiV4e5KgpkKo/8i/i0Ue2IcOESDQodGVG
UlcKlS76bSdREljWeVz4MBqK9/BylA==
=UT0f
-----END PGP SIGNATURE-----

--3V7upXqbjpZ4EhLz--
