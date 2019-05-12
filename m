Return-Path: <SRS0=t4ha=TM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.5 required=3.0 tests=DATE_IN_PAST_06_12,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79AA3C46460
	for <linux-kernel@archiver.kernel.org>; Sun, 12 May 2019 17:06:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 431AF21855
	for <linux-kernel@archiver.kernel.org>; Sun, 12 May 2019 17:06:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557680762;
	bh=f837t7wkxZIMOzshlMu0zDIInaF9MAanPNYe70Y3pQg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=zHJ49XaoZi3BpAvUIuOw9FUU3L63dnEfmXMpuOFzNRvXNszQQaO+3BywifuSf2B5h
	 HDWp5TlbqCv8BpuQfcCAZY4nQzOxp6/8gRNVIiEXS0GnM47pD2yO1VCevj9tDFMxEX
	 R8sRCyl83uHJ0mXEvSMWeC5N9jB4ejqLOfmK82DM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727073AbfELRF4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 May 2019 13:05:56 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:49684 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727015AbfELRFv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 May 2019 13:05:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=9RG2AODhAu0ddI6bREDEwdc3wqRcusF77Y1+ZDoUoqI=; b=Z5MaOZyQWC3c99sXzxJ2QgNM4
        GhhJ95ow9EFGIB1Z3aBaNn0yZ0YLAVrYBDO8eZ4LpYM+zKWIN7545KbFXZEc1BQM45klI5sCGKxfH
        p9MdXFRu9k9EqApl0snS8Md197flO+KVS0KtZLk7az3fDlQj3eg6eM2bbGhmgmSkEsarE=;
Received: from [81.145.206.43] (helo=finisterre.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hPrut-00044V-N5; Sun, 12 May 2019 17:05:39 +0000
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
        id A1BE644003B; Sun, 12 May 2019 08:54:17 +0100 (BST)
Date:   Sun, 12 May 2019 16:54:17 +0900
From:   Mark Brown <broonie@kernel.org>
To:     Viorel Suman <viorel.suman@nxp.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        "S.j. Wang" <shengjiu.wang@nxp.com>,
        Julia Lawall <Julia.Lawall@lip6.fr>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Colin Ian King <colin.king@canonical.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        Viorel Suman <viorel.suman@gmail.com>
Subject: Re: [PATCH 1/2] ASoC: ak4458: rstn_control - return a non-zero on
 error only
Message-ID: <20190512075417.GG21483@sirena.org.uk>
References: <1557408607-25115-1-git-send-email-viorel.suman@nxp.com>
 <1557408607-25115-2-git-send-email-viorel.suman@nxp.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="RMedoP2+Pr6Rq0N2"
Content-Disposition: inline
In-Reply-To: <1557408607-25115-2-git-send-email-viorel.suman@nxp.com>
X-Cookie: HOST SYSTEM RESPONDING, PROBABLY UP...
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--RMedoP2+Pr6Rq0N2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, May 09, 2019 at 01:30:36PM +0000, Viorel Suman wrote:

> -	return ret;
> +	/* Return a negative error code only. */
> +	return (ret < 0 ? ret : 0);

Please write normal conditional statements to help people who have to
read the code.

--RMedoP2+Pr6Rq0N2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlzX0SgACgkQJNaLcl1U
h9Bpqgf/Z4TM2ROcn75WSzHPLXR43KHE2salosbyrC5M/Mg9blRgsevh8gtJwHCW
e2IYJiCmHH80IKs6jMo2MOCXJZ4ib5XsvEd3ZUa1vAiajsIUEqUxJxBTgJY/8Lj6
KvgIc6i7qfd+8gtgvwenOntPYH1vdcJvDlI2pgLtJX1mA8zA8WAqkv8kwbHddQQp
c03uvUyOErkh0duoT4f5WBfsnky2kQh0oZWfREtPdLq4O/mck4zUCj+XJ5Ah0UMs
HP09a4nkC21r+NyYb7tJ2kqs7Mf89F/UW3B2xEx9Xdi0IDsYnONIF95UfIberk5V
jtLqEpVlKdRGgZxNUnqqpsIJmbrpUw==
=G/aP
-----END PGP SIGNATURE-----

--RMedoP2+Pr6Rq0N2--
