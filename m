Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E786CA9EBC
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 11:34:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0234820679
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 11:34:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571916894;
	bh=zYu/dXer5u/VUFfPBAUTgmknjpEgfPNLcXJ/0E1S8L0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=MmrAlaC3Njx3DCBW5pnL+x+ttZUW49t/fsP0B3Qie1jGgxSfPeGnaemzpel6xzvBg
	 I8pqwrB6cV7lLRDTLSjPDpQyKoYsk5abr99aBzNQ+2jhU5curB3WMLdKRAgv8m4uHP
	 1A1ZfTgHCYuRqxtT2+Mp3Ct/CpwOKgXwjkz57v9c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409213AbfJXLew (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 07:34:52 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:43046 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725283AbfJXLew (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 07:34:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=zYu/dXer5u/VUFfPBAUTgmknjpEgfPNLcXJ/0E1S8L0=; b=LhvNFFdzJvXOUO83h2NEw4uon
        6DEMRCSXJ02rM36UaeXAGpyCQgllHBpDF0+Qv5g4s+0+oIF4EODOkW5G8drbc3DtjDpS2yP1n6Ict
        LUQL2UC/K5C4mcJgpgt71w+F8ZSFewDissDmSN2M+5xYxQdF979KfvRZrPUoGWDn16Mws=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1iNbO9-0003P6-Lm; Thu, 24 Oct 2019 11:34:45 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id DD08E274293C; Thu, 24 Oct 2019 12:34:44 +0100 (BST)
Date:   Thu, 24 Oct 2019 12:34:44 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     Takashi Iwai <tiwai@suse.de>, Liam Girdwood <lgirdwood@gmail.com>,
        alsa-devel@alsa-project.org,
        Russell King <rmk+kernel@armlinux.org.uk>,
        linux-kernel@vger.kernel.org
Subject: Re: [alsa-devel] [PATCH 0/2] ASoC: hdmi-codec: fix locking issue
Message-ID: <20191024113444.GF5207@sirena.co.uk>
References: <20191023161203.28955-1-jbrunet@baylibre.com>
 <s5ha79rph1j.wl-tiwai@suse.de>
 <1jv9sfcpr8.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="3yNHWXBV/QO9xKNm"
Content-Disposition: inline
In-Reply-To: <1jv9sfcpr8.fsf@starbuckisacylon.baylibre.com>
X-Cookie: What foods these morsels be!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--3yNHWXBV/QO9xKNm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Oct 23, 2019 at 07:53:31PM +0200, Jerome Brunet wrote:

> With the revert, we are back to the bit ops. Even if it works, Mark's
> original comment on the bit ops still stands I think. This is why I'm
> proposing patch 2 but I don't really mind if it is applied or not.

Yeah, it's not *required* but the atomic operations have lots of spiky
edges so a simpler locking construct would have less chance of running
into trouble later when someone's updating the code.

--3yNHWXBV/QO9xKNm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl2xjFQACgkQJNaLcl1U
h9B8Kwf+Jg2QiKBt6TLiix2B5dhQZdYmJEpilzMEzc5b+2MXGLi68PkPqJGiLBF3
Y3sqkh/oeZxKDlBeFLpvpTVKszZjaYKe/pBAstw5HHYCI5TTrXD0zEGxQ1x4/FTr
+24kfJQqxxdL/vyi5uWSobaSGpgD/gd9T0u2e2nsmFKehOK7aTJCt6sD+Sh3mQCn
wo6X1ZqLZmLdDt3cQFJoJ4TDE5tlnETgu4KoCFW7gMG/TSdjF0cfThHV7SCmWsIa
6ucoDHEi8YXEC2I6c10QEmxf5Vc/QJfyblfbibYUqjfDeNFA7i2Zh62ZvuduePk+
n1M+ixOpZpLiFk1DgTdJgIDimtwyqw==
=/3nu
-----END PGP SIGNATURE-----

--3yNHWXBV/QO9xKNm--
