Return-Path: <SRS0=CA45=ZK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF869C432C3
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 13:08:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A72D020748
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 13:08:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574082539;
	bh=QWwGQ8Jle04VHUoAqH05/Lg+HHObUs0mhD24cnNIWGg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=tMoP3YOGLmjvQasbNN2BIg/9huqmUjIcM93r3svkVxhrnU9m+u4yGPrFvbxP16mNF
	 CjLJjMh0o+uSCFmWB3X2z3ybR1jfrLguiAaXXsocmdqk2DPHV1JAAuHHqbedtyVstF
	 c+DwT4JXfBGZyimBlPZOs3HdDTO/E//SilgmTR3w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726774AbfKRNI6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 08:08:58 -0500
Received: from foss.arm.com ([217.140.110.172]:34484 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726178AbfKRNI6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 08:08:58 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8D7DA1FB;
        Mon, 18 Nov 2019 05:08:57 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F0A143F6C4;
        Mon, 18 Nov 2019 05:08:56 -0800 (PST)
Date:   Mon, 18 Nov 2019 13:08:55 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc:     lgirdwood@gmail.com, alsa-devel@alsa-project.org,
        kuninori.morimoto.gx@renesas.com, linus.walleij@linaro.org,
        robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] bindings: sound: pcm3168a: Document optional RST gpio
Message-ID: <20191118130855.GE9761@sirena.org.uk>
References: <20191113124734.27984-1-peter.ujfalusi@ti.com>
 <20191113124734.27984-2-peter.ujfalusi@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Rgf3q3z9SdmXC6oT"
Content-Disposition: inline
In-Reply-To: <20191113124734.27984-2-peter.ujfalusi@ti.com>
X-Cookie: no maintenance:
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Rgf3q3z9SdmXC6oT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Nov 13, 2019 at 02:47:33PM +0200, Peter Ujfalusi wrote:
> On boards where the RST line is not pulled up, but it is connected to a
> GPIO line this property must present in order to be able to enable the
> codec.

Please submit patches using subject lines reflecting the style for the
subsystem, this makes it easier for people to identify relevant patches.
Look at what existing commits in the area you're changing are doing and
make sure your subject lines visually resemble what they're doing.
There's no need to resubmit to fix this alone.

--Rgf3q3z9SdmXC6oT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl3Sl+YACgkQJNaLcl1U
h9CQRAf+IOHuqykiR2XV9orGZa0JGfA9jN/HKH9JdghHPcxQ0jzR/dfC3kNnBy/l
QAeSXU6vF5LuJx75MIHsf6Dx15bZ0kZ0WKpJnI9Fqn+k/PKeXWPhBB+6sPet4msQ
A5opWLa03tkaXlmNZd14uQrEV6Zbir9q9WT5UqAvM7Ceb3k1jDKRBb7tWvPUggTi
Rk2DeiXEHNOWWa0eekadtR453n2MTfUtmEncqiKzZu2+PGOI5sz+banoXhgaXlim
Jwbk83xfZ/HrgB6Wqvw2pneJ+1fEsu8aix6z8ty3UWhPwcIuNqNZGyOlVPjGYUTm
5g86BZwQ18875HSZ3tAi1meDwJt1cA==
=7OaS
-----END PGP SIGNATURE-----

--Rgf3q3z9SdmXC6oT--
