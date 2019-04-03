Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A03E1C10F06
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 07:37:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62F5221473
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 07:37:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554277028;
	bh=gESy1rfCd7Ge0G5zKRxH6fJQvcNaIeJDJbThl7DdqBs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Of9e+wlUKXd37olSW6Ni5u1Z6UZKHpbGVeX+b1Ba7pePuwjDRg4NCQXO9g59mZpDh
	 LnG/27PNiUayFlALCvkNPJkQe9INjqs5l+c8XBK3BUbrCKzKyNNb/5jwiaz1xUN5sy
	 7okTWOekfzVf2CZSGvNf8uH1JG0U0P4Hv+NeQqjY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728625AbfDCHhH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 03:37:07 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:51556 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725970AbfDCHhH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 03:37:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=gESy1rfCd7Ge0G5zKRxH6fJQvcNaIeJDJbThl7DdqBs=; b=PuWlan4k//HFOa0/lF6OcZxAl
        +/0iKTQ14Y0ga3KrpU+SS6QwG3LrYYWOIuVtSxWyA42Jsq6cNNwHaG3zMz4srvqJX/NPOns1XsadN
        LyjbNC7HekBhqxPKYYUcilQGR/TTPc0FHeHPF98fm9yy3V47rlp4SRl46I89hjnCewy/s=;
Received: from [147.50.13.10] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hBaS6-0004w5-M4; Wed, 03 Apr 2019 07:36:54 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id ADE64440082; Wed,  3 Apr 2019 14:36:51 +0700 (+07)
Date:   Wed, 3 Apr 2019 14:36:51 +0700
From:   Mark Brown <broonie@kernel.org>
To:     Anders Roxell <anders.roxell@linaro.org>
Cc:     lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        matthias.bgg@gmail.com, alsa-devel@alsa-project.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: Mediatek: MT8183: DA7219: fix build error
Message-ID: <20190403073651.GF5748@sirena.org.uk>
References: <20190403065547.19382-1-anders.roxell@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="GV0iVqYguTV4Q9ER"
Content-Disposition: inline
In-Reply-To: <20190403065547.19382-1-anders.roxell@linaro.org>
X-Cookie: Replace with same type.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--GV0iVqYguTV4Q9ER
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Apr 03, 2019 at 08:55:47AM +0200, Anders Roxell wrote:
> When building CONFIG_SND_SOC_MT8183_DA7219_MAX98357A=m the following
> errro pops up:

Someone else already fixed this.

--GV0iVqYguTV4Q9ER
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlykYpAACgkQJNaLcl1U
h9DaPwf/S1wjvRWPfxeHpWLXscVDG+bKetdtPUEpZcwafkkUEy+8kj+v3YWEkLIk
qE32Mkq7cMOzg0MliqtcujhRmXGlKF0AGHtFRjAohv9othesOBuFVhYGa7KHd+C2
eP/q/QtY3G6CwjwkA8WEiC410owyG6lLsq7E+7HVmOLrwwWlvM1yRpUQXsCQRrHs
Yz1v8c/dbEMLZCK2mL3YHZdjg+aTVCt8rKYPkzY3VSIish1B28Dmqc99j9SxKr14
5zxBPzxcbF5YJn6E7mG1kkpIWmNnAfj2I7e5DTaE5SfIjgNTgyrlGiHu4fi3NZ5g
yjsM0YILNiS6k7S21cCEKrpT5yyXPw==
=RBI4
-----END PGP SIGNATURE-----

--GV0iVqYguTV4Q9ER--
