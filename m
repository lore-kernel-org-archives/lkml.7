Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44EBBC43381
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 04:35:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09F7B2084B
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 04:35:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554179726;
	bh=zEaKNPMHSOay4bkJUft3m/yZCIaTzJ8Nx2sBbvZyJZ4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=140oRWCYXfPMggzkHen+lJotmKkw9rTpcnOO7oaUt8Ysd5lcFc9zaXHI8H6M9y8yo
	 +5cYW7R59g0ots182lEjbIcFyjl0V/pvrvLC0CoU0ihYeF6nVjRzYsBUUws9ipNCTw
	 6qeioxp+rS3bBYCuh5WEeY5sw9vEWpvNqz4cRWQQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727041AbfDBEfZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 00:35:25 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:39186 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725959AbfDBEfY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 00:35:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=zEaKNPMHSOay4bkJUft3m/yZCIaTzJ8Nx2sBbvZyJZ4=; b=hNOibDv8WNtAo0k93NrzGU3bw
        WzJiyN84r4Nqqoh8RpBpV0Tn0QsqRJs5FRGMMZhHEvPCCMRvXj0wbMzjCoBzwXs8ULN3kW/TwDWKl
        DmQjC7M9yM5b8WAXPFs/fUGiAy+EEt7tzw9On7baSu9S51yUZBxrytVQ/a2eFsQzDMrYk=;
Received: from [147.50.13.10] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hBB8j-0005jU-4I; Tue, 02 Apr 2019 04:35:13 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id BEA99440082; Tue,  2 Apr 2019 05:35:09 +0100 (BST)
Date:   Tue, 2 Apr 2019 11:35:09 +0700
From:   Mark Brown <broonie@kernel.org>
To:     Jon Hunter <jonathanh@nvidia.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org,
        Curtis Malainey <cujomalainey@google.com>,
        linux-tegra@vger.kernel.org
Subject: Re: [PATCH] ASoC: soc-core: Fix probe deferral following prelink
 failure
Message-ID: <20190402043509.GQ2059@sirena.org.uk>
References: <1551706274-22571-1-git-send-email-jonathanh@nvidia.com>
 <4eb94b41-7e16-7b39-5c14-a7d180ce67df@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="rUztinBX/EQDJOOk"
Content-Disposition: inline
In-Reply-To: <4eb94b41-7e16-7b39-5c14-a7d180ce67df@nvidia.com>
X-Cookie: Use extra care when cleaning on stairs.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--rUztinBX/EQDJOOk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Apr 01, 2019 at 01:22:09PM +0100, Jon Hunter wrote:

> FYI, I am seeing that the deferral of soundcards failing with v5.1-rc3
> because the above has not been merged yet. Just wanted to let you know
> in case this one was not marked for v5.1.

I don't have this patch at all AFAICT.

--rUztinBX/EQDJOOk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlyi5noACgkQJNaLcl1U
h9CexAf/eATHuzU+lN7Fozhx+OPt6qbOXgrnTNzEDfg/ztwUxwpP+qjxGaHamdc8
/p9OWg+WxH5Fv0SxBqyR6dNQOwcGf1nf9Ps4MhxWIJxbQvZqRziuQ6yyowC/X8yj
7eAPfUB/yOQ1BpYCQe7eVB+BuJsjq2do6I8DgRuWN3gXm9QUqS2fHipkH13sVNPN
TnRXQRKGN++BwG6GKUOAG+Z11dmyEHK7WXiLyMVoL4CQ9x5kENZsbVDmMsrSgtOp
HgMkDFbzopCSWPhoUpvLbBONbKzJGgw2XtThg7xWEkz3rUz0Jtwrb8afGbvusf2g
uBIYtkXI1nVf/gX/dpoixJjq3Ub56w==
=xAaC
-----END PGP SIGNATURE-----

--rUztinBX/EQDJOOk--
