Return-Path: <SRS0=nCuq=XH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5EBEC5ACAE
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 09:50:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88B1820856
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 09:50:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568281800;
	bh=2vx3Ylpda9KqW9SLqKhw6P/yjf1K2+z15grS6ZZbc74=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=LirY3JCS8DaHa+z3TzBy+WpXxHVlDRajNrD2PcxQHmWVh9puVLbl2OEsuPa3MzA6r
	 OrG3R5Zf89O0YKNkQgXpVcIsDU9f5CwUERiNbtB4iTmwGfyOeRbIqs2uFr75BfMdXE
	 2rjqL6G/NflzyUWkL1BN/muwaZKdfONOrkfuNa9c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730962AbfILJt7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Sep 2019 05:49:59 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:60596 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730618AbfILJt7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Sep 2019 05:49:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ghy9SZ7ceK5GxKnnLg3gLpNTyopg6ZDzPUUphnrjouI=; b=XW6JL5hJgqDfiOEJDN5HucgoV
        8vzSXt8mm4Nw7WhBAfHJjtvNR8ihhyV/D7uND9INW5uLbJ9ORZjKmw1LxtyotP/ovq36FATtnV7YJ
        PUiF32ivg0+dobdRV88T4c6JEoru2V2lLd3aH2tQgBu+1eYQUAcUQGfiipCU2R1Z6iI+4=;
Received: from 195-23-252-136.net.novis.pt ([195.23.252.136] helo=fitzroy.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.org.uk>)
        id 1i8Ljg-0006Sh-W6; Thu, 12 Sep 2019 09:49:57 +0000
Received: by fitzroy.sirena.org.uk (Postfix, from userid 1000)
        id 59FF8D00AB0; Thu, 12 Sep 2019 10:49:56 +0100 (BST)
Date:   Thu, 12 Sep 2019 10:49:56 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Support Opensource <support.opensource@diasemi.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] regulator: da9211: fix obtaining "enable" GPIO
Message-ID: <20190912094956.GI2036@sirena.org.uk>
References: <20190910170246.GA56792@dtor-ws>
 <CACRpkdZLKriRzROqNyWE97n_gavWgZRXoqMMEyP_F9DFgYtobQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="d3slIU+tL1lDaIh/"
Content-Disposition: inline
In-Reply-To: <CACRpkdZLKriRzROqNyWE97n_gavWgZRXoqMMEyP_F9DFgYtobQ@mail.gmail.com>
X-Cookie: Be careful!  UGLY strikes 9 out of 10!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--d3slIU+tL1lDaIh/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Sep 12, 2019 at 10:23:44AM +0100, Linus Walleij wrote:

> Mark: please tag both of these for stable.

Too late, I already applied them.  If you ping Greg I'm sure
he'll pick them up (and there's a good chance Sasha will find
them anyway).

--d3slIU+tL1lDaIh/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl16FMMACgkQJNaLcl1U
h9CMTQgAgt36DJnjLX0pU4Essudfa0QFAi3OSdkwo6f/ZLCv/ncxkX0s4VbOS5o0
SxFdrbWJ1erp0Mfs34tnHY1CuqSlRRPk52IfVslhdA7QpsYnLL6XWbZhA5lgTHZy
rpDqj+xVGUhnZK+USuPTyzAw2Vb7Zwqoab5BtXR3ly0qKoBpWOYpUPRSN1jufBZk
XbLPpd7ciivIm2D4NYt2Lo7agvtPw6PYt7uiHx1tnKuFf8pTVLmzkltq4WwS7Efl
oehjhFn0KQ1Kq5S6ncjqjHBU9V7zVgYSLssKWb4QO1ichtSPZIr9+cOaBMtkGlPO
fj7QKRyQxy5BL9VaKWWcChnvW/MIPA==
=et5i
-----END PGP SIGNATURE-----

--d3slIU+tL1lDaIh/--
