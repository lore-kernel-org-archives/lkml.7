Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84BC7C072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 11:11:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D4D3217F9
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 11:11:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558696276;
	bh=bP+JIZdMCq3mFksR+O8CGhak1958qiz5uli+/aUERDM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Tc8H5oQhFR2L+BQFv5lE/9DTLjCJmaruSymbQNfAKxWalv3hMFg0lKqxlPLURo/IB
	 Z5sb9bIQZZlnOOuHADFQdrJFO7DShcjK2gvYWnBaj+uKmob+upypetqd830k2bQj6d
	 Q6N8gNuf+8cFg6/8XCTbO9I5JMv97UrVgqlxNc7Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390968AbfEXLLP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 07:11:15 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:52574 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390920AbfEXLLM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 07:11:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=6LU7sDJKxPMA6OFCSaUXHyqjt8vt2VZhmSa0y+SVYGI=; b=NEjqqlOstTB1P+pLf2ReDgqAP
        Qlva+QxzNTcWA2+n6SO1OhUe8ldQHcVMCK8O4wZOt7E0xptV7GqbhFu/oTzUSAZD5iEBV0ypM5vVs
        27z2md8tfsvRAgyjtiNMqctJ2EfYTARqGCRUnMrmLcyAo49tAqgZ0mvXP9+WU6DTyTyCo=;
Received: from 188.29.164.87.threembb.co.uk ([188.29.164.87] helo=finisterre.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hU86C-00036y-Ss; Fri, 24 May 2019 11:10:57 +0000
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
        id 4E5BC440046; Fri, 24 May 2019 12:10:54 +0100 (BST)
Date:   Fri, 24 May 2019 12:10:54 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Jon Hunter <jonathanh@nvidia.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Subject: Re: [PATCH] Revert "ASoC: simple-card: Fix configuration of DAI
 format"
Message-ID: <20190524111054.GA2456@sirena.org.uk>
References: <1558688044-22025-1-git-send-email-jonathanh@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="6TrnltStXW4iwmi0"
Content-Disposition: inline
In-Reply-To: <1558688044-22025-1-git-send-email-jonathanh@nvidia.com>
X-Cookie: The other line moves faster.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--6TrnltStXW4iwmi0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, May 24, 2019 at 09:54:04AM +0100, Jon Hunter wrote:
> Revert commit 069d037aea98 ("ASoC: simple-card: Fix configuration of
> DAI format"). During further review, it turns out that the actual issue
> was caused by an incorrectly formatted device-tree node describing the
> soundcard.

Please use subject lines matching the style for the subsystem.  This
makes it easier for people to identify relevant patches.

--6TrnltStXW4iwmi0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlzn0TsACgkQJNaLcl1U
h9D7hgf+KnlthPCAcNyZh9TNU0VlaxTKG3nZmDHU6QQg/BOOt48b+aWZBg7UIuHi
ii8RJQsiBLnRhDUs8COFEcoyDMwlCaFcyn31Gtfno7H2IvZgWHgN9zff1hkibOZ+
571fGi0LS3x+5htd4wNPQQdNSai7uSTVR4NYGl2jh9H3fLLRU16PatCRlT5xQoyO
lEc+c6Ag/greLJbHgoT5bJf0GSOTaGcATCI2NWmTx86dyZ568Fs7gEDKGph7Md8h
NGMHhk8Wew0avn6epDR2opQhXFP1pqD9KK/TUm0GgRX0x2gqauePZeq6W2ucgQD1
CuA1xZr3ytSJsWyVaP1GGMEPph0iRw==
=NXV0
-----END PGP SIGNATURE-----

--6TrnltStXW4iwmi0--
