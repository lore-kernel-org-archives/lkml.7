Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7477C04A6B
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 02:33:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76BBB216C4
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 02:33:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557369192;
	bh=hGPnm5tbZN7czfBP3tH3xRO8abftaq/KoRmkBsPvr4A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=MTRX1bl3g3KJll9GQBiy2H7TbUAyrDxKOvb2nz0bIJC+dz4gZIfgBTWQVM2bkNv9/
	 soz2ycRAIadJ8EkquRzm0TAOxcJHgS54Zopcsol0Hu3JcVWEfpBJ5IctewhRuOg+4r
	 eZV8/R8pXjL5D34qQrHX2iP5igpy0i6OKU+IpEWQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726704AbfEICdL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 22:33:11 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:59490 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725891AbfEICdK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 22:33:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=A5G/1lWkrleN9QL1gRcbrpqWq59CDY9vHWndd24sW9I=; b=T88tg49MHvWq6cI1ntmfSSKGU
        PiatX9xQ/RVBZZd7JsltR5BYTdxzV6Bfczl4KEPeOrSrTLVJYFDT1StKYHkbbvQp+PRF1hFgD/69l
        3zhHUVy2ck01ZEEbCHuk7H2VwpEA3HRdM10GTpoxKpoG3z9B21TkSFySPEC9JPRkpkz0E=;
Received: from kd111239184245.au-net.ne.jp ([111.239.184.245] helo=finisterre.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hOYrc-0001RR-RR; Thu, 09 May 2019 02:32:53 +0000
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
        id 9304E44000C; Thu,  9 May 2019 03:32:47 +0100 (BST)
Date:   Thu, 9 May 2019 11:32:47 +0900
From:   Mark Brown <broonie@kernel.org>
To:     Curtis Malainey <cujomalainey@google.com>
Cc:     Fletcher Woodruff <fletcherw@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ben Zhang <benzh@chromium.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Oder Chiou <oder_chiou@realtek.com>,
        Takashi Iwai <tiwai@suse.com>,
        Curtis Malainey <cujomalainey@chromium.org>,
        alsa-devel@alsa-project.org
Subject: Re: [PATCH v5 1/3] ASoC: rt5677: allow multiple interrupt sources
Message-ID: <20190509023247.GT14916@sirena.org.uk>
References: <20190507220115.90395-1-fletcherw@chromium.org>
 <20190507220115.90395-2-fletcherw@chromium.org>
 <20190508073623.GT14916@sirena.org.uk>
 <CAOReqxgYV3SdXot84Xa4X7=MCZdzWmb2N+jaWzjxgmdoMRx5Mw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="sOuRR0jXHR3ukxKL"
Content-Disposition: inline
In-Reply-To: <CAOReqxgYV3SdXot84Xa4X7=MCZdzWmb2N+jaWzjxgmdoMRx5Mw@mail.gmail.com>
X-Cookie: -- I have seen the FUN --
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--sOuRR0jXHR3ukxKL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, May 08, 2019 at 02:39:32PM -0700, Curtis Malainey wrote:

> Pixelbooks (Samus Chromebook) are the only devices that use this part.
> Realtek has confirmed this. Therefore we only have to worry about
> breaking ourselves. That being said I agree there is likely a better

And there are no other parts that are software compatible enough to
share the same driver?

> way to handle general abstraction here. We will need the explicit irq
> handling since I will be following these patches up with patches that
> enable hotwording on the codec (we will be sending the firmware to
> linux-firmware as well that is needed for the process.)

OK.  Like I said it might also be clearer split into multiple patches,
it was just really difficult to tell what was going on with the diff
there.

--sOuRR0jXHR3ukxKL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlzTkU4ACgkQJNaLcl1U
h9DsMgf8DlzUF2AXtzerym+DDHSpdLJct9B0sDS+4a3l7aJ0l4BGoN8UBK9D9bks
KJq5h9X/JaOojry4WTfrdZtm2rFTa0ztIvtIsNBahAHzYGplUafHmr3lOdsWviUa
IyQk8XARXYWfm0mB0Pdfe58BDY+Y74naM1H6WypF5S1nfCmg2vo4++C1DmV7L56J
7ZdDnceJqVUpW6hyCsp1dRP6Ot8ICzKbUWZABTYVWj/a/CcowwUl+P5/eX5zhM1A
Iy2LN3nZcQE/C7OcG1HB8rZhz+enKCURNLGHHWKmfOuDa8yZR7MS0Q8fFTTwbwow
kPYJXq28b3JoVxlrpjiAFcNg5JUiZQ==
=izHs
-----END PGP SIGNATURE-----

--sOuRR0jXHR3ukxKL--
