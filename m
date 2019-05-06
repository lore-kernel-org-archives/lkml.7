Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.5 required=3.0 tests=DATE_IN_PAST_03_06,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3468CC04AB5
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 07:38:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05A5D2087F
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 07:38:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557128297;
	bh=OXkh92WoJxCetKWr4gv5KeiDYO9V6OnVZCUYljGGixo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Q0WSI/txYiYFRF3N/Eg/OxhjyAhNLk/64YttGwkn+8wAeWvjFmv9DH+v5uE08gApB
	 uuilLUG5/8OUrpksMBTE4u4R41skd2+7+hu602VmJAP1XO2TaClrC7+QWtvkJcO7+a
	 Yr13cQCAvRW0qHfGhpZwQsSg4FA5Gd/MBT+LakIs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726503AbfEFHiP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 03:38:15 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:38894 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725864AbfEFHho (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 03:37:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=tzpXHk7pggK3a6IReCA75UnDglv4kzjtwAX41NwuIs4=; b=NjHcG+e5mciylrLgGpMM5XvoQ
        xOog8IPCBf1UzwcpqaA6fQTHSG8iv9C6CvC2qOUWzWc1Idw1jS0qia5310WtllkAjfaM+7p5dv1QQ
        FniGskOBWOn5W4M7Dick338AZbeW9tlV5ueQYGHR76aN7OvKeA+i2lFdJW9zctVOk0mJ4=;
Received: from kd111239184067.au-net.ne.jp ([111.239.184.67] helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hNYBt-0000s1-90; Mon, 06 May 2019 07:37:37 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 7342C441D41; Mon,  6 May 2019 04:53:45 +0100 (BST)
Date:   Mon, 6 May 2019 12:53:45 +0900
From:   Mark Brown <broonie@kernel.org>
To:     "S.j. Wang" <shengjiu.wang@nxp.com>
Cc:     Nicolin Chen <nicoleotsuka@gmail.com>,
        "timur@kernel.org" <timur@kernel.org>,
        "Xiubo.Lee@gmail.com" <Xiubo.Lee@gmail.com>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V4] ASoC: fsl_esai: Add pm runtime function
Message-ID: <20190506035345.GJ14916@sirena.org.uk>
References: <VE1PR04MB64794DF2979F3AD350A9EB3DE3370@VE1PR04MB6479.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="7e8BFhNxqpjiNKz7"
Content-Disposition: inline
In-Reply-To: <VE1PR04MB64794DF2979F3AD350A9EB3DE3370@VE1PR04MB6479.eurprd04.prod.outlook.com>
X-Cookie: -- I have seen the FUN --
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--7e8BFhNxqpjiNKz7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, May 05, 2019 at 03:28:59AM +0000, S.j. Wang wrote:

> We find that maybe it is caused by the Transfer-Encoding format.
> We sent the patch by the  --transfer-encoding=8bit, but in the receiver side
> it shows:
]
> Content-Type: text/plain; charset="utf-8"
> Content-Transfer-Encoding: base64

> It may be caused by our company's mail server. We are checking...

Ah, that looks likely...  not sure I have any great suggestions for how
to resolve it but at least it looks like progress on figuring out the
cause, I haven't been able to see anything wrong locally.

--7e8BFhNxqpjiNKz7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlzPr8gACgkQJNaLcl1U
h9DVeQf7ByKyqDU+F0dmHJsGDAll4nFkuDLq9wax+i1rjUCghvBhzq+0tNPf51Dk
oJT0+OmCtKJcYIu4Z7OsLBDr75SiQE83YxdWnaAGik49IJUA7ggTXCtXfpLcs2Vy
VtPc2H969t2crPjYI3AkUIJzYHB2GCwgsWvKmDeWS0c6Sb55eN5DptFsS6UuPcrI
CCOhBJvO9P85bBNjkMRAla+SM6GV77Uq5DC4iV7ert68gwp8pRVdMY1sNTx9J7BZ
soqk2U9xLPJtJUeZs89WKZy8mCW1BtFuvQAvt1W/mNJmkWWedc4FkAQgHV3b/pIn
z4slaJ2AqBkaAIC0hq6wGq8dKSVecQ==
=/QHA
-----END PGP SIGNATURE-----

--7e8BFhNxqpjiNKz7--
