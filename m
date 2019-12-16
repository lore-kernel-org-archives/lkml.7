Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8BE1C43603
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 12:23:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76200206EC
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 12:23:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576498982;
	bh=iqMqtQQV0SVYXKLuUzzUIl4DJZ0CDKW1xjZhpNX9mQI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=c9r7PtLp3Hx/8Vmqo+A0zGZAO2McOX+SNLhPf3AIUGn1pZuZzORRQ9h2MxHt2QfZ4
	 oS9ud4P1l9U7bQ0cHhmnKKOZdDZV+HUrgW4ZVOJlSVlw6pcQkJ867un1OOa6QndS06
	 RER6LBRv6nysV901UkcT8vQhBOJKu0VdR27KqAlw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727632AbfLPMXB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 07:23:01 -0500
Received: from foss.arm.com ([217.140.110.172]:53358 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727486AbfLPMXA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 07:23:00 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4DB851FB;
        Mon, 16 Dec 2019 04:23:00 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BE57D3F719;
        Mon, 16 Dec 2019 04:22:59 -0800 (PST)
Date:   Mon, 16 Dec 2019 12:22:58 +0000
From:   Mark Brown <broonie@kernel.org>
To:     "Angus Ainslie (Purism)" <angus@akkea.ca>
Cc:     kernel@puri.sm, Liam Girdwood <lgirdwood@gmail.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] Add the broadmobi BM818
Message-ID: <20191216122258.GC4161@sirena.org.uk>
References: <20191214235550.31257-1-angus@akkea.ca>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ghzN8eJ9Qlbqn3iT"
Content-Disposition: inline
In-Reply-To: <20191214235550.31257-1-angus@akkea.ca>
X-Cookie: Backed up the system lately?
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ghzN8eJ9Qlbqn3iT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Dec 14, 2019 at 03:55:48PM -0800, Angus Ainslie (Purism) wrote:

> Angus Ainslie (Purism) (2):
>   sound: codecs: gtm601: add Broadmobi bm818 sound profile
>   dt-bindings: sound: gtm601: add the broadmobi interface

As I said in reply to v1:

| These subject styles don't even agree with each other :( - please
| try to be consistent with the style for the subsystem (the latter
| one matches, the first one doesn't).

--ghzN8eJ9Qlbqn3iT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl33dyEACgkQJNaLcl1U
h9CPKwf/Yi58Hf8HxHeOBIXk0Y27oK1tnQS/WvB4x3RVFfqXyikECz5ERE6pdUzc
5fpXeRbxwO7kTznK/2YE6aP0S332ZVMhxt3nG/BqJLSjn/a6EzSFGQ6jiHSQ1Kvj
YqGNOyPONPfN37I4h5j6oviotmeLr2QhhL7wySQsifL9L21S/xVVyy3lj6H8HgS/
e6AqlPkavFIEW3OaGI3Tj9x1iO4TG8tadg+2IlggE46MZunxvlXhrQuLwPxeZSQ5
65revyyoOPDRbDHMIOVaK/v2598LDohjgKyxRXD2IXiiz2X48IHcT71f6vSk+Bo2
YcUYhAEeMUrSq5ZwzcvtJl2vV2clFA==
=B/1w
-----END PGP SIGNATURE-----

--ghzN8eJ9Qlbqn3iT--
