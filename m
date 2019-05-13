Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E388C04AA7
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 16:47:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4D522084A
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 16:47:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557766066;
	bh=Cmw1azSGePo9Tra/A8IT2nSO3d5ZUZMjnBUWCbl/Rss=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=YLHN6X3ygfWVeNkbpAvtJS4Jg0ZZ3v8qMiTKXzWEKJNzJ3nnDOuA4yr4/zqmkuT83
	 VIXK4IjSG8TaTLprcJ+wrnL9+/9jdU+hKbZyxLrWEDgd+fNhnBurKRX+0K4wSq3P2T
	 bFIUJwV6K+let6y8z2Qql05KTtPKqIllTQYjtPMo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730956AbfEMQro (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 12:47:44 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:36592 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730873AbfEMQro (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 12:47:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Cmw1azSGePo9Tra/A8IT2nSO3d5ZUZMjnBUWCbl/Rss=; b=dO6tK1Z1EZNsMRpXZLq++xomk
        Q2rTVnHpb2EAabfPPyzIAMHAlkVQHuONJk3MJELQLHa4mAJTF0GaN+7ttlxTSFXwW4FHbPuu+dDQU
        Q6p9OuA7khdxrbeS+JIpwan8YSHFNxaquTD+kFXuAycKJcWLdFXQFj02NGBAk5ewRVknA=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hQE73-00078A-2H; Mon, 13 May 2019 16:47:41 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id AA0E91129232; Mon, 13 May 2019 17:47:38 +0100 (BST)
Date:   Mon, 13 May 2019 17:47:38 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Doug Anderson <dianders@chromium.org>
Cc:     Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Brian Norris <briannorris@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/4] Revert "platform/chrome: cros_ec_spi: Transfer
 messages at high priority"
Message-ID: <20190513164738.GE5168@sirena.org.uk>
References: <20190510223437.84368-1-dianders@chromium.org>
 <20190510223437.84368-5-dianders@chromium.org>
 <20190512074538.GE21483@sirena.org.uk>
 <CAD=FV=Xg96SGg-JDjEJRtC6jACcN9Xizcr-zV4rQwXYvuEvmRA@mail.gmail.com>
 <20190513160153.GD5168@sirena.org.uk>
 <CAD=FV=Xm-2oxit7doVAYJr28c-xHqUdt9PQC=WYpYfsAyUxuaw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="zjcmjzIkjQU2rmur"
Content-Disposition: inline
In-Reply-To: <CAD=FV=Xm-2oxit7doVAYJr28c-xHqUdt9PQC=WYpYfsAyUxuaw@mail.gmail.com>
X-Cookie: Must be over 18.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--zjcmjzIkjQU2rmur
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, May 13, 2019 at 09:03:28AM -0700, Doug Anderson wrote:
> On Mon, May 13, 2019 at 9:02 AM Mark Brown <broonie@kernel.org> wrote:

> > I'm not saying the other changes aren't helping, I'm saying that it's
> > not clear that this revert is improving things.

> If I add a call to force the pumping to happen on the SPI thread then
> the commit I'm reverting here is useless though, isn't it?

Well, I'm not convinced that that change is ideal anyway and it does
leave you vulnerable to further changes in the SPI core pushing things
out to calling context which feels like it isn't going to be helping
robustness.

--zjcmjzIkjQU2rmur
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlzZn6kACgkQJNaLcl1U
h9BaBwf/YLbKPIH1GfhSAIJxQR6QQOaXbxIW/A+t1Jg0dZHRhJPuF7L2TL9bo+A9
aU2XQE4/MDEHMZ2/pAMwm4iB/AI/1XtXAsizVcJApEtEyivGklahbXpmLX9B3pRA
hYuD1loKDS10tOIuXuNIH6kDs36n1mHdCIpvJ7cqQEkYXE43P8vEgnqYfvrjNA7q
UY0XmxAECBZNVOExqqRPupnt1aAsJefXDtW6D7cdrAq92etDMCn1i6VAdBp++3f5
v76rZOdAihbWBJV+AGX5hIpO7m5a7fHZNELJu7tJu1G6kahBLbB/XtQKoOTSUObs
ffKy1s8njB0vrGUu7QFr4KP0hjnQ4g==
=aiE6
-----END PGP SIGNATURE-----

--zjcmjzIkjQU2rmur--
