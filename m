Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E309C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 08:41:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 472ED2086C
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 08:41:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728638AbfDAIlv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 04:41:51 -0400
Received: from sauhun.de ([88.99.104.3]:49444 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725880AbfDAIlt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 04:41:49 -0400
Received: from localhost (p54B331B1.dip0.t-ipconnect.de [84.179.49.177])
        by pokefinder.org (Postfix) with ESMTPSA id CA0F12C7BF4;
        Mon,  1 Apr 2019 10:41:46 +0200 (CEST)
Date:   Mon, 1 Apr 2019 10:41:43 +0200
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Support Opensource <support.opensource@diasemi.com>,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH 1/2] rtc: da9063: set range
Message-ID: <20190401084143.uqbiktkt2vltgrxa@ninjato>
References: <20190321101557.26857-1-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="b3rvplhtfnempyen"
Content-Disposition: inline
In-Reply-To: <20190321101557.26857-1-alexandre.belloni@bootlin.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--b3rvplhtfnempyen
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 21, 2019 at 11:15:56AM +0100, Alexandre Belloni wrote:
> The DA9062 and DA9063 have a year register that can go up to 0x3F.
>=20
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

Thanks for this patch! Didn't know about the devm_rtc_device_register()
conversion going on. Glad I learned about it.

Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

I couldn't test the upper limit (DA9063 hooked to a 32bit system here),
but lower limit works and RTC in general works.

Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>


--b3rvplhtfnempyen
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlyhzsIACgkQFA3kzBSg
KbYQtg/9FQ6u1OHsikX0RGFF3u6dcvdV5e2S+GjGfuRxydrHSCvAq60cWhyM4Fp7
rLQwgjexZWD8akfTpjLaWGJUf6tMN1nqVzK7iHMZnHXr+QWEu0QFk5nPdpKPc3Gf
FFM/a7gr68mI/AvwU0Dv3Ma3fzKIcC3qIdjgGOu/6c1lj3BGK5y+GkuAanJYZ5YU
leYiDqMpqvTlWI9X6vkdY2+JyfQqdpwZ1q5ONar11U9+ZH4vnQ7f63WylapoHcr/
n6ve35kUJ+RUqozsw8aAjdlAhMBElzRASV/2bXFu6+zcMdINZD6D47kr6SiRb6U3
ciav2yFsC+2/CiDFMng9aYffA+kYlD+T7vAa//6v6bRN3zsd2vtGWZjpAZQCpZtI
NOCUCXCAWEQBLr+P6NQm3n1gI8jSF7p70YDOnusl66QZ4TVniUn111J+QYTDmu01
M42St57hVMx8CQJEXOpinxHzUtix9XzHosRBZktD3HtZlV4gDevPYDc4Et0O2LL1
4QcbHz9XREHnAJwDqp9At1wC/NPzkXC7+cxn8XfN6MmASyVffwdRD+FfryBXvyQ8
+YGSlJsYm0Psj4Qkll1FQROtd4G2k/5X9e8cF1XrCXB+7swDx7Oj/wjO3sLo4I0t
6e1HYcbDX/Ho2h3C45htgJp7ltMULJ/rzbWlWNHqCsQ+DY/XCAk=
=a3tQ
-----END PGP SIGNATURE-----

--b3rvplhtfnempyen--
