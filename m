Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 558DFC43219
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 10:00:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24A0620679
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 10:00:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556272843;
	bh=mn346CSu8AGmXvwMRdqA8nJ2ThsJ7M+4+LdXOI5+8sc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=zWvc3LjW301QHZCXyb3hwJmldSP1Y/sukoqulaw4LXZzfvmaJ+yqaEshnvrEnE+1C
	 23mXuv1MzfZgtxPxgYEHSr6dhwyX2Z1IeUsyWJ+T9l6+QDoGmpaUo5MmJt/cUtYISc
	 FZBPg9rzs9xZ75sP/rdv9WPRWkJzq9Y9XaJneagc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726379AbfDZKAl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 06:00:41 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:51922 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726013AbfDZKAl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 06:00:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=mn346CSu8AGmXvwMRdqA8nJ2ThsJ7M+4+LdXOI5+8sc=; b=U7W3mf8F48v++PmxSq3WfzClF
        9ZxiItNonlX+qzYCBdS16iaiF72O5OXOmCMXV0Ahz/55mjB0KaaGkpcp7pv5TrHQtQnvClwYkh/Ut
        HNplbWnCmzLvMgbz4MQNtPkfKZbBX2bK0KzwSfYDhk+6tBFoOlBZNgnsjd00Cm1ToUAZw=;
Received: from [37.205.61.202] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hJxec-0003j3-Oa; Fri, 26 Apr 2019 10:00:26 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 7BA16441D3B; Fri, 26 Apr 2019 11:00:25 +0100 (BST)
Date:   Fri, 26 Apr 2019 11:00:25 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Daniel Baluta <daniel.baluta@nxp.com>
Cc:     "S.j. Wang" <shengjiu.wang@nxp.com>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "timur@kernel.org" <timur@kernel.org>,
        "nicoleotsuka@gmail.com" <nicoleotsuka@gmail.com>,
        "Xiubo.Lee@gmail.com" <Xiubo.Lee@gmail.com>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "perex@perex.cz" <perex@perex.cz>,
        "tiwai@suse.com" <tiwai@suse.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH 2/3 v2] ASoC: fsl_sai: Add support for runtime pm
Message-ID: <20190426100025.GD14916@sirena.org.uk>
References: <20190421193853.10188-1-daniel.baluta@nxp.com>
 <20190421193853.10188-3-daniel.baluta@nxp.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="3Pql8miugIZX0722"
Content-Disposition: inline
In-Reply-To: <20190421193853.10188-3-daniel.baluta@nxp.com>
X-Cookie: -- I have seen the FUN --
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--3Pql8miugIZX0722
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Apr 21, 2019 at 07:39:09PM +0000, Daniel Baluta wrote:
> Basically the same actions as for system PM, so make use
> of pm_runtime_force_suspend/pm_runtime_force_resume.

This doesn't apply against current code, please check and resend.

--3Pql8miugIZX0722
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlzC1rgACgkQJNaLcl1U
h9AExAf7BpbUDjxFUvENyjvPWZ5XP867EfiNhim76zTqqHzpoH6NdAdYYpKqzPpl
QsTiG7FvS4/Z//RJen1ItB6wD1jGOBubB85+TgfpNdn5YaLdLDw97EzUuAli+4vD
gpmQ0oDJS1TUnSMjPD8CyHIFA5nJWvkshNRR27ljTjPDAeZuCEbSSa/LH7iQMiZQ
LSe8wuCFsmXZqjPiTvx8f/iLDFbNE+LUx/rDOJOBMi5xUEjNkCFqYSAPDVX6MR8G
ymOod7dDfcHydFiV7oZsYXADShq3m43D9q758l/5dpZcj40PRcL2S8AtJkMPpsw8
Qsu6uF/CA1cXAdH2++ECFdvG3BU10A==
=Pwh6
-----END PGP SIGNATURE-----

--3Pql8miugIZX0722--
