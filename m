Return-Path: <SRS0=31nU=WT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47E50C3A5A2
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 10:50:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 189C32166E
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 10:50:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566557448;
	bh=yxp5UOti4R1xBPBqA/dNUmgQ3NvW7i84TKOl//Cm3xo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=QMZlm1FY3cIdn7OFTeQ50VoRwf7TAQvpY27Sfv47Mnd32HP3t1IOKxBrvUnylPjrf
	 3kKl0gGm7ScoN7PKw5mBmWZ9bwTeQhu4TGWTw5emW+MrSWsaSwTOCk/3DWPDPEZPJi
	 OQL1GEaQf//dNwaFHjXgcweY2kURvTSDJT17ErtY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392490AbfHWKur (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Aug 2019 06:50:47 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:36728 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730991AbfHWKuq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Aug 2019 06:50:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=060aY2SvBvRsi+LXzaIKeXVNx7xgGjdwSKM7GY3p9xA=; b=oduc+DsbRrpu3jf0jLDJS5FOa
        63bXAeIN9aWbEeoL51nMfK5x6c28+tpCDRmWuMMu0MSZrQtkD+cqNFuOorJnjeT7UtivPMrgsGylP
        //rqxYzJSU/Kg8mUk9WgH/Pcju0lhsLM+Ocmi14qa8yaj+ZIcsd7buVSuU7VRTbg5YxF0=;
Received: from [92.54.175.117] (helo=fitzroy.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.org.uk>)
        id 1i179Y-0002uZ-UD; Fri, 23 Aug 2019 10:50:44 +0000
Received: by fitzroy.sirena.org.uk (Postfix, from userid 1000)
        id 95F21D02CD0; Fri, 23 Aug 2019 11:50:44 +0100 (BST)
Date:   Fri, 23 Aug 2019 11:50:44 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Vladimir Oltean <olteanv@gmail.com>
Cc:     linux-spi@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org, netdev <netdev@vger.kernel.org>
Subject: Re: [PATCH v2 2/5] spi: spi-fsl-dspi: Exit the ISR with IRQ_NONE
 when it's not ours
Message-ID: <20190823105044.GO23391@sirena.co.uk>
References: <20190822211514.19288-1-olteanv@gmail.com>
 <20190822211514.19288-3-olteanv@gmail.com>
 <20190823102816.GN23391@sirena.co.uk>
 <CA+h21hoUfbW8Gpyfa+a-vqVp_qARYoq1_eyFfZFh-5USNGNE2g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="hl1kWnBARzJiTscN"
Content-Disposition: inline
In-Reply-To: <CA+h21hoUfbW8Gpyfa+a-vqVp_qARYoq1_eyFfZFh-5USNGNE2g@mail.gmail.com>
X-Cookie: Don't SANFORIZE me!!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--hl1kWnBARzJiTscN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Aug 23, 2019 at 01:30:27PM +0300, Vladimir Oltean wrote:
> On Fri, 23 Aug 2019 at 13:28, Mark Brown <broonie@kernel.org> wrote:

> > It would be better to have done this as the first patch before
> > the restructuring, that way we could send this as a fix - the
> > refactoring while good doesn't really fit with stable.

> Did you see this?
> https://lkml.org/lkml/2019/8/22/1542

I'm not online enough to readily follow that link right now, I
did apply another patch for a similar issue though.  If that's
a different version of the same change please don't do that,
sending multiple conflicting versions of the same thing creates
conflicts and makes everything harder to work with.

Please include human readable descriptions of things like commits and
issues being discussed in e-mail in your mails, this makes them much
easier for humans to read especially when they have no internet access.
I do frequently catch up on my mail on flights or while otherwise
travelling so this is even more pressing for me than just being about
making things a bit easier to read.

--hl1kWnBARzJiTscN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl1fxQMACgkQJNaLcl1U
h9AOHgf8CAS5RBRoxTFZUsrmCEnLyMFYb7aueuSKLUE+iKi+G3NldiLt7pzFIU9d
svVlmYRKAks8vzJMW/BxQgaB+YfMGd8dUWEqCs2XORYRDLRd8MM5OIXZ89kda74l
SOBsfcmjetVLeO9Ws85HuXjl+zSyl3Rxa4AjW5B9hgIjw6gDZqCuA8bkUFq3xmTN
GMB3B+QB+friWpL3FuMcJiv6+PQU5Ing/NzphvWj18U6o5pzfxwQkv0iYVdhxsbN
2CtENUmGQ7A9IffnFv1FrRykxq16/VWEUjYblhuiTS5sYNRKiOmywWILnghWEGZZ
betTGkaDXFODaV43fus34BO8Ynd/7g==
=/HjI
-----END PGP SIGNATURE-----

--hl1kWnBARzJiTscN--
