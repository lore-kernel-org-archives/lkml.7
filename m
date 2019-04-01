Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 315E9C4360F
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 08:43:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A80120828
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 08:43:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728635AbfDAInI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 04:43:08 -0400
Received: from sauhun.de ([88.99.104.3]:49474 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725932AbfDAInH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 04:43:07 -0400
Received: from localhost (p54B331B1.dip0.t-ipconnect.de [84.179.49.177])
        by pokefinder.org (Postfix) with ESMTPSA id 4C81E2C7BF4;
        Mon,  1 Apr 2019 10:43:05 +0200 (CEST)
Date:   Mon, 1 Apr 2019 10:43:04 +0200
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Support Opensource <support.opensource@diasemi.com>,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH 2/2] rtc: da9063: switch to
 rtc_time64_to_tm/rtc_tm_to_time64
Message-ID: <20190401084304.pt7psdvp5kupwpol@ninjato>
References: <20190321101557.26857-1-alexandre.belloni@bootlin.com>
 <20190321101557.26857-2-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="nz63zlo56blhlsxs"
Content-Disposition: inline
In-Reply-To: <20190321101557.26857-2-alexandre.belloni@bootlin.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--nz63zlo56blhlsxs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 21, 2019 at 11:15:57AM +0100, Alexandre Belloni wrote:
> Call the 64bit versions of rtc_tm time conversion now that the range is
> enforced by the core.
>=20
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

FWIW, RTC still works on my 32bit system:

Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>


--nz63zlo56blhlsxs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlyhzxgACgkQFA3kzBSg
KbYz4g//dIRF8keT4mvB44rXOv5VgFqC/ROR8CiGK5jzGDRZadsFajQzV+Kur8sC
ZW8mPFbKfKYsa7/u7OyMaNP9MjF0aZo8Z8N0qZVTTat6+ns8goLEYscLfne9EbCG
5UngacjzRmiZy4B6xGg9k/sWOu3FOycTC3R0iuAf3cyYLZvi4DMNCwiGXWS7U5Yl
kNI57PtddIMxAEyVoJGLeM6389d530yMDuiz6nB52fxdDK4dbWqo8LpgTu+SWVzu
LZdKjj73JDt1Gb0+7E1tQXyfC42iPqGS/hQZ0QbjVPNCA8zjmJnbYLf7K/mGz89U
RCXsrFqgncKyQdCpwinXYDhYBxZwE6MeqmhHVgGOj3CkD5myZaEArNH2wgJGk/PA
BVAU67j1TINWLJMT8dKzy8U7X4TzpYBWpI9+NXmlQ7jCXXYv3Z1GN8f1UvKgFoak
Dq/0uaDg/dZxn2KQpfHhvCJ4T6nppQVgiqBUHtmd6kKGjA4tYC4QjRHA00w0c6Dm
DcLzb/EXLbynCtn23bDPKJH9NbfIwk8Mya1flYPMBU9R7AMA9NdsNvNDQHe2fXTz
T2QxNcS4owSWfYNzxu3CuKyxbI86JfIdTDkOMNqZiYXbrprfGI1CIkupVza6Iutu
fS4did4Q0quXIFCwyeM7EphPSdkrbb24zV0w7Fle6wB6odxbY7c=
=8Hfr
-----END PGP SIGNATURE-----

--nz63zlo56blhlsxs--
