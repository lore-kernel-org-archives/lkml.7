Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 615FBC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 03:25:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B43E2086C
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 03:25:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554089104;
	bh=mIti3NJP5HePOZKpxwXKG4pijkoMnU/zdCS+Q0bDww0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=RXBIbKKkqO9SKiGAhCpSfeUoAzcKaDQpkshIxvEGCVcIzpCnTFLh6TKVkCuwgH0t9
	 Wrs8zEtzdtS/qMK1sV1SNA37e6AM5O9fJvioXtJGgtLgSIq/AIc3ZyzkvgtebIji6M
	 U+xSUkM68gL8UvnNq8hJV6Wbr3HsUFtgwohXK1Gw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731791AbfDADZB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 Mar 2019 23:25:01 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:44454 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731593AbfDADZB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Mar 2019 23:25:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=B/u91fJg9z6pdyQb8tyJO8Tr8lJ3BHtHYPy/ezmTlkQ=; b=u7enVTOKDDjDon0TGvh0mqnLx
        W4Xr5ndRsmLHwXf4FRKT9DzWfoGk2Gi8YxkzuQf9V4u9Wg7F3aizEl/hDiAaRrZtbQ5XHV1qr/nlL
        hsyu2Ke/8NFDbnMVW6LWlaxH2dtVQjEG+55lwgug5DJtV9P27xVKVas58vcuUaSxaW1RQ=;
Received: from [147.50.13.10] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hAnZ4-0006b5-3S; Mon, 01 Apr 2019 03:24:50 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 3E56A440082; Mon,  1 Apr 2019 04:24:46 +0100 (BST)
Date:   Mon, 1 Apr 2019 10:24:46 +0700
From:   Mark Brown <broonie@kernel.org>
To:     tony.zou.hq@gmail.com
Cc:     alsa-devel@alsa-project.org, lgirdwood@gmail.com, perex@perex.cz,
        tiwai@suse.com, linux-kernel@vger.kernel.org,
        dbasehore@chromium.org,
        Tony Zou <zoutao@huaqin.corp-partner.google.com>
Subject: Re: [PATCH] max98357a:add dai without triggered by pcm
Message-ID: <20190401032446.GC2059@sirena.org.uk>
References: <1553824319-2155-1-git-send-email-tony.zou.hq@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="NKoe5XOeduwbEQHU"
Content-Disposition: inline
In-Reply-To: <1553824319-2155-1-git-send-email-tony.zou.hq@gmail.com>
X-Cookie: Use extra care when cleaning on stairs.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--NKoe5XOeduwbEQHU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Mar 29, 2019 at 09:51:59AM +0800, tony.zou.hq@gmail.com wrote:

> max98357a's enable pin need setting independently
> when max98357a is shared I2S with other codec.

> add dai "max98357a-hifi" without pcm trigger,
> and use "Spk PA Switch" to set the enable pin.

This sounds like a really bad idea - if you have multiple CODECs on a
single DAI link tell the core about it, don't try to bodge around it.
There's support for multiple CODECs on a DAI link already.

> +static const char * const ext_spk_text[] = {
> +	"Off", "On"
> +};

Simple on/off switches should be normal switch controls, not enums.

--NKoe5XOeduwbEQHU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlyhhH0ACgkQJNaLcl1U
h9A7fQf/TGuwFPOLhzC1e1gDmXDsj0NA96/Oa+cFlvnMd17vFxuOQGPBwlzy99hN
khhn6GBVGwfLdyuclW9mnF5lYJ32j16ldn+dIo2mYqadACyJO+S5S//LdqnMytry
nxRvZSBxgKRf0WMXRaU9IdujR9zn8Ioc0EnfjCPuoFjIYrpoipBEqwqBQH9/ZQZN
/A8SeMiEKyViTrKEY5OHFbEkypoBcJ7vaxRSymE69AOZSBzeFWaLSFk8paIdGhLE
xpt6ueKQQco6+NBCkAnzwcIG7ClZdCCOjpNo3Z89LIlUNh6TH9jmgGzlK/l5/K7C
lZLorfIPFx8P+9o/RmGE6iu6xx6PHQ==
=t5bB
-----END PGP SIGNATURE-----

--NKoe5XOeduwbEQHU--
