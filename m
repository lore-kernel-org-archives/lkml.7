Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9C1FC31E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 15:23:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D5A620833
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 15:23:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560785028;
	bh=FZH6ukGxu83EFcMC2pDUo5sjU52idyr9mfWoxcQSb8E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=BG50raI8gAFTZdoul45IuUGFQUXh29Ge+3gl27aPNeWPFZg0PLvMt+Kn2/NHVEiLe
	 lp2QCYIDsIdVVmeMkhbxlschIgrvM1NhvzWCJZ+T+BBH31hPD548ycaNxyG0cptei9
	 1lW7Vst3/2crhCMOry5hM0MUkj98fhQEWmX7ugrg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728426AbfFQPXq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 11:23:46 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:50056 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726215AbfFQPXp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 11:23:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=8C2RKXkQRfYqFChj5UHmnTcYUmNVBUlMQMcooU9hEyY=; b=E9TNbSnLi1vaGDH3PAblQKIXF
        S31sNkOKRYFy6sniLOfUI1RXEoiMRdxIixESHsYLn4A5uErcUl3r6YIt7d0Ihew5JvpXd9rOf40f2
        SBtdngRTsYMTQ6Pzjp2VZdeUjgnsXUFbVlPk/SXoUDfHmeSpZR3Nnh5V6eeZwB5vEczmQ=;
Received: from [2001:470:1f1d:6b5:7e7a:91ff:fede:4a45] (helo=finisterre.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hctTx-0001wa-L8; Mon, 17 Jun 2019 15:23:41 +0000
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
        id D784C440046; Mon, 17 Jun 2019 16:23:40 +0100 (BST)
Date:   Mon, 17 Jun 2019 16:23:40 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/8] regulator: core: Introduce API for regulators
 coupling customization
Message-ID: <20190617152340.GX5316@sirena.org.uk>
References: <20190603235904.19097-1-digetx@gmail.com>
 <20190603235904.19097-2-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Swav0nNPrA3tWuBp"
Content-Disposition: inline
In-Reply-To: <20190603235904.19097-2-digetx@gmail.com>
X-Cookie: Editing is a rewording activity.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Swav0nNPrA3tWuBp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jun 04, 2019 at 02:58:57AM +0300, Dmitry Osipenko wrote:
> Right now regulator core supports only one type of regulators coupling,
> the "voltage max-spread" which keeps voltages of coupled regulators in a
> given range from each other. A more sophisticated coupling may be required
> in practice, one example is the NVIDIA Tegra SoC's which besides the
> max-spreading have other restrictions that must be adhered. Introduce API
> that allow platforms to provide their own customized coupling algorithms.

So, I don't completely hate this and I'm not sure there's any good
solutions here...

> + * @balance_voltage: Callback invoked when voltage of a coupled regulator is
> + *                   changing. The callee should perform voltage balancing
> + *                   and change voltage of the coupled regulators.

Some documentation on what the context for calling this is (locking and
so on) and how it should do the adjustments it wants to do would be
good.

--Swav0nNPrA3tWuBp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl0HsHsACgkQJNaLcl1U
h9AZ/wf+Pme+NJZgnNHaUP/TA5RgftsxYHZ1bXA8oSKUiZBT9rTdOHx9ZD+S+W0A
gw+3s/TA8Ih05PlGrB9IHVsJErrUKUUemfGB9vK2HLYP5B6FRTAXexN/4jJ3xEZ2
gBbhAAEbzvE9QtOcJEx2bjtHXAVtfsteRJ0vrvm2Ws+Hyvav7vjyAoJ8J8Q7acww
g7fo7iYuiUy7GV3g9GeE/R6y8iKE1/+B3QHKk1q3HY6l1a+Dfpf4/tk8lwR8QSN5
MxwjIb9benyzSlJvaf/sibjUJbXmKaGB145bY2TV6xTz7LOB8CwxwV6nyP//joGB
MdEI1WNmiyjzfwYe31h3sRxWhPviVg==
=S4Pq
-----END PGP SIGNATURE-----

--Swav0nNPrA3tWuBp--
