Return-Path: <SRS0=t4ha=TM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABA53C04A6B
	for <linux-kernel@archiver.kernel.org>; Sun, 12 May 2019 17:07:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 777222173B
	for <linux-kernel@archiver.kernel.org>; Sun, 12 May 2019 17:07:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557680850;
	bh=ZT19wvlgjKJQHr5ZOzfBDLgbI9ZF9AB4lIaP8wO/tjs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=qk/Wnb3VSYOicsqrZQSDwWQI4OLBioRpHI62dYUnCukDdaA02aMpc7+eg8QHSl8Ro
	 Kg1PA9Hjp/vEmJsWWwEQ5a+Woy5FSuY6P/s5opa8Cth2+ZK77R/MiPb3kJ4YOn4eMh
	 wEd2pyvhi5x2LP7zJha+BtGMVi3t9O5mmL44NDi4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727033AbfELRH3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 May 2019 13:07:29 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:52418 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726669AbfELRH3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 May 2019 13:07:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=G5xlJDa6zk0mg1D7OFpmjSf2+dxHmYsbAjbOgtF2WVI=; b=cl3dzex1TWMNPiBpesr65Eo7F
        H9HVQq0TuFUpVsHX6kptGrMiUcMeHxfVc8fG3sNL3EIFW+VKSMfcpTBTeS+d5PLybyPfUyzr1fcXu
        F1TQyTLbAcBSu8IXgsuB8MXptkbna1IYhHGmDBpkTI7Wcy5opdxLgWRyyN7+bHahNrssM=;
Received: from [81.145.206.43] (helo=finisterre.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hPrwV-00046h-5C; Sun, 12 May 2019 17:07:19 +0000
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
        id 2298B44000C; Sun, 12 May 2019 18:07:17 +0100 (BST)
Date:   Sun, 12 May 2019 18:07:17 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Mallikarjun Kasoju <mkasoju@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 6/6] regulator: max77620: Support Maxim 77663
Message-ID: <20190512170717.GS21483@sirena.org.uk>
References: <20190505154325.30026-1-digetx@gmail.com>
 <20190505154325.30026-7-digetx@gmail.com>
 <f8f67e00-0544-c999-92e0-3998c2f70ee7@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="jo46wx5DSA4a/gWG"
Content-Disposition: inline
In-Reply-To: <f8f67e00-0544-c999-92e0-3998c2f70ee7@gmail.com>
X-Cookie: HOST SYSTEM RESPONDING, PROBABLY UP...
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--jo46wx5DSA4a/gWG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, May 12, 2019 at 05:08:15PM +0300, Dmitry Osipenko wrote:

> Just want to get yours attention to that Lee picked up the patches into
> the MFD tree, excluding this patch. I assume this one will have to go
> via the regulator's tree.

Please don't send content free pings and please allow a reasonable time
for review.  People get busy, go on holiday, attend conferences and so=20
on so unless there is some reason for urgency (like critical bug fixes)
please allow at least a couple of weeks for review.  If there have been
review comments then people may be waiting for those to be addressed.

Sending content free pings adds to the mail volume (if they are seen at
all) which is often the problem and since they can't be reviewed
directly if something has gone wrong you'll have to resend the patches
anyway, so sending again is generally a better approach though there are
some other maintainers who like them - if in doubt look at how patches
for the subsystem are normally handled.

--jo46wx5DSA4a/gWG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlzYUrwACgkQJNaLcl1U
h9Av/Af6A7eNJJBMhZupsKDyFp3/A06DY0GmX/yFWFZsvWD8tC+lwGKriot3sRsO
hgzEGPzGKHsPap5Co+eJMK5qju+hoCTxr0EXsJGz7jUV4yvNF9kVP9vjDFDdiB3q
h7i54gvLBADsp9iaxm/1zlXsVtXoAeONz+g401sWi2tBo49EMSixuSZVuX6mEo3N
+UoZRX+jK87XBL10ewBMdtrYMqrr2h6X3Wd8WH9010x/ug49Iem7Oq7XgL18vnrt
lyfJnNOKB7x2ebWfjrfh2vyk9F0zoRhH7Jn/6qzlAvEbSkTQNF8EaCYQEVJ3kujM
a3UExN7W25SrNbX2yjcj0Z7+te8Z/Q==
=est8
-----END PGP SIGNATURE-----

--jo46wx5DSA4a/gWG--
