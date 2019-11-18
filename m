Return-Path: <SRS0=CA45=ZK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2AEFC432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 15:58:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90BEA21D7B
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 15:58:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574092736;
	bh=WGUyht43nf3Ysupp83CRX60A+0vqDIHoxyJ66cyu/X4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=MTvImOiy0QpP6839+pRS/KNuNkmCWBdNmF+i5CYH0LuKMJ+LTtRMn3vSmARFf4tEB
	 pIv80RwsPUIacklkArzPUvlzaQQV978bvpbkuGXIe4l1AKlBIdho2NMp0fWRzKotTw
	 /g+zUZm9CRXd6mtm1gghotwc/r1UR//SHUO/WSkI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727440AbfKRP6z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 10:58:55 -0500
Received: from foss.arm.com ([217.140.110.172]:36374 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726654AbfKRP6z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 10:58:55 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CA4A0DA7;
        Mon, 18 Nov 2019 07:58:54 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 383F93F703;
        Mon, 18 Nov 2019 07:58:54 -0800 (PST)
Date:   Mon, 18 Nov 2019 15:58:52 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: linux-next: build failure after merge of the sound-asoc-fixes
 tree
Message-ID: <20191118155852.GG9761@sirena.org.uk>
References: <20191113081035.7e7f9bc2@canb.auug.org.au>
 <20191115093410.4a7938f5@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="VACxsDaSTfeluoxK"
Content-Disposition: inline
In-Reply-To: <20191115093410.4a7938f5@canb.auug.org.au>
X-Cookie: no maintenance:
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--VACxsDaSTfeluoxK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Nov 15, 2019 at 09:34:10AM +1100, Stephen Rothwell wrote:
> On Wed, 13 Nov 2019 08:10:35 +1100 Stephen Rothwell <sfr@canb.auug.org.au> wrote:

> > Caused by commit

> >   1d3e9077307f ("ASoC: SOF: Intel: Fix CFL and CML FW nocodec binary names.")

> > I have reverted that commit for today.

> I am still reverting that commit.

I've reverted the commit, I was a bit disappointed that none of the
Intel people responded but I see you didn't CC Pierre who sent the
commit so he won't have seen your report - I missed that due to the CC
to Liam who was also in the chain.

--VACxsDaSTfeluoxK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl3Sv7sACgkQJNaLcl1U
h9DHngf+Lk/nMXn9Ke2ii81Adts6Wz5RxLcXRnq8Sne4aNyn6ThYRKQFasDP2foa
GnaBqv8VpdvJnG41LpmYylfzq2I1cM2p3zNNsxwjJbCPOUbJNFIOVFYTQTUnl5jU
h10fighSuVVSqRP8TlyWvqOjivOvO9diMtMvQiaurLUz1uRsExBAWravvwvrd+Jq
KmNrB1kX/D7iOWN4WSwzXkX29cG8q9NdLlUC16Dk5Ube9RBKmBIC0b7FG3ueXFTm
tz1ppAjO1O1VqnBk8731nlZhT4f9U+xkDTL0yP5FhZdGTDQzcrER1vallW0lYcTU
Pve+ggG6HE7YykLeSrlwSX7FZ6OJaQ==
=812C
-----END PGP SIGNATURE-----

--VACxsDaSTfeluoxK--
