Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CE40C433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 10:36:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F905216F4
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 10:36:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565606216;
	bh=SUwH9pIyIjc1JYBj35DZL/G76kPUojZ0LNv0jAlGAD0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=l8zK8MzLa4UuwI6JI5k476tgDbyxGyjTZERqOhCV6mDwMa/qTyb8MQmmXi+aRu5MQ
	 8Nodl1sq12yC02Dic1tpWTAzkRCaoYUujuPFS+Q3LewYtlyBfuDZEi1WbWd94rwl6v
	 8BMV/SIfUqhvpGLJoU1GgttdlgutnW448+aXDh4o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727955AbfHLKgz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 06:36:55 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:36486 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727276AbfHLKgy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 06:36:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=SUwH9pIyIjc1JYBj35DZL/G76kPUojZ0LNv0jAlGAD0=; b=erOlG55cUA6tiOT6+2H0bGoib
        IX4sEcb+LJGCJ+7A2h3fIxrXWTqsJFft+ws9m/HGU1EH0Rcnn6vWyUQyB1wfNudNH2QzVBogsFWuy
        4FGKwwVPo+ERG43bAp/4CAs23HFUc0ul4PqSe0xenSVz/XDDmGyPot9rXGM23Do6+ENfU=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1hx7h4-0000rc-UZ; Mon, 12 Aug 2019 10:36:50 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 3D2C427430B7; Mon, 12 Aug 2019 11:36:50 +0100 (BST)
Date:   Mon, 12 Aug 2019 11:36:50 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     soc@kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Subject: Re: [PATCH 08/16] ASoC: remove w90x900/nuc900 platform drivers
Message-ID: <20190812103650.GB4592@sirena.co.uk>
References: <20190809202749.742267-1-arnd@arndb.de>
 <20190809202749.742267-9-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="GRPZ8SYKNexpdSJ7"
Content-Disposition: inline
In-Reply-To: <20190809202749.742267-9-arnd@arndb.de>
X-Cookie: Decaffeinated coffee?  Just Say No.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--GRPZ8SYKNexpdSJ7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Aug 09, 2019 at 10:27:36PM +0200, Arnd Bergmann wrote:
> The ARM w90x900 platform is getting removed, so this driver is obsolete.

Acked-by: Mark Brown <broonie@kernel.org>

--GRPZ8SYKNexpdSJ7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl1RQUEACgkQJNaLcl1U
h9DOggf6A+rCl807lQPPc9jvHHoo/VB+g1cF17QNn1JsjP18wNo35uCHJsYOdPC+
LxdxpnoymsYTJxArM87ZGS4OZKKUtwmWVAsy7TxaxJFl0MwtGXvhtzX6BemVPv5Q
2MBWYqkBEbYufL/ldD0B/N6VCnwLwFnYr2iMNNeHg+9MCMblJkeU2GT0Zc3TdQea
VYnj0n3kIUUAAx+uLzLUXyotZ9O4F5R4JG0aDMastWN4fGtOscGwHQP7sDzmDRT3
AWHfuHEVCKOXn78Cpp1Xzum0eHFdBwz33GgrVt8qWtT9LeNOirtEemawzO5FKYZF
Kpt9q0gVAV2vnSXQAjmVBT1vVHgf7g==
=n+W8
-----END PGP SIGNATURE-----

--GRPZ8SYKNexpdSJ7--
