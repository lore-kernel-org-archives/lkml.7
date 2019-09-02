Return-Path: <SRS0=8hmg=W5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 395CCC3A59E
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 12:39:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04662216C8
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 12:39:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567427992;
	bh=uIbUtItTl0J4R6RWkfXdkun0EQq9wsjOggu6QKWEGAw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=UYgBjYJrP2amGe48T/xAPA+eQZ+Rh/MAg7hj3Zf5RcRlhFMyeNJq+aAH30q6qMczN
	 4QBW074u1cnmIA8jfk/odlUqc4g0Yzcy5ihTvSi70NtQeDz4rEG2bOSd3ryoLVt7ry
	 5Td6zrMLeN5Z/L+ZpFqfoWDv7sX/YkjXCqYNS4/k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730719AbfIBMjv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Sep 2019 08:39:51 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:47446 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730672AbfIBMjv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 08:39:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=4kBJEx+Qu3mSPv+hNIjzoykytvR4h7p7UM0vTM6s1vA=; b=q8ijxkngdjzFHlHeGzQ+04Tbg
        S6qaZsvAE7t3yLIEKlaNgveLU8PEQG2luelC4qffbo8hYlHlt1e6e3nWdmNOq/bgn4pReBd87Yb+d
        TWBi2CoUsD2MmTmBG1rq+jWZbVkwekhCsmOh7OjmPp+5rvj2fNylXm1etnnxXI3aSpWq4=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1i4lcX-0003GM-F8; Mon, 02 Sep 2019 12:39:45 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id B6FAE2742CCB; Mon,  2 Sep 2019 13:39:44 +0100 (BST)
Date:   Mon, 2 Sep 2019 13:39:44 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Daniel Baluta <daniel.baluta@nxp.com>
Cc:     festevam@gmail.com, nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com,
        shengjiu.wang@nxp.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, timur@kernel.org,
        gabrielcsmo@gmail.com, NXP Linux Team <linux-imx@nxp.com>,
        Cosmin-Gabriel Samoila <cosmin.samoila@nxp.com>
Subject: Re: [PATCH] ASoC: fsl_sai: Set SAI Channel Mode to Output Mode
Message-ID: <20190902123944.GB5819@sirena.co.uk>
References: <20190830225514.5283-1-daniel.baluta@nxp.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="IiVenqGWf+H9Y6IX"
Content-Disposition: inline
In-Reply-To: <20190830225514.5283-1-daniel.baluta@nxp.com>
X-Cookie: Lost ticket pays maximum rate.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--IiVenqGWf+H9Y6IX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Aug 31, 2019 at 01:55:14AM +0300, Daniel Baluta wrote:

> Fix this by setting CHMOD to Output Mode so that pins will output zero
> when slots are masked or channels are disabled.

This patch seems to do this unconditionally.  This is fine for
configurations where the SoC is the only thing driving the bus but will
mean that for TDM configurations where something else also drives some
of the slots we'll end up with both devices driving simultaneously.  The
safest thing would be to set this only if TDM isn't configured.

--IiVenqGWf+H9Y6IX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl1tDY8ACgkQJNaLcl1U
h9B6eQf/fWHBjGPAP86B03a4INm+HF3NUTJW3RUX7OufxZ6nXwI99zy/47e5hK4r
RrYrDlh5Ybe5Dl6gK1/4VrO/SFMg6PyOJjpjwAijXRjW3y3CqiZe5e9bhLVoIcrM
zAERB9q0o82bPAsKxlCqkG69MKZrHnDPH7pBAXM2kPRyn6QXQwWV8qqE2Rpfkto2
ZprQEwsRlwatAPn4WfHBN7OsZy3BeVZqhT2VLD9GkF0zBdBhZEvO4opbj7cbQHdc
Jdrw3AFvgUYHsjsNx+x1uVVy7DY1r/V2yh8ly8+WMn204eYDR8aKnm5oO0OpoN6o
ibcFAnroXympSUaJvtWjiAzS0QBTBQ==
=Wb+0
-----END PGP SIGNATURE-----

--IiVenqGWf+H9Y6IX--
