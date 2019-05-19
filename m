Return-Path: <SRS0=AA30=TT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.4 required=3.0 tests=DATE_IN_PAST_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05FB8C04AB4
	for <linux-kernel@archiver.kernel.org>; Sun, 19 May 2019 17:22:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8965204EC
	for <linux-kernel@archiver.kernel.org>; Sun, 19 May 2019 17:22:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727462AbfESRWS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 May 2019 13:22:18 -0400
Received: from sauhun.de ([88.99.104.3]:44792 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726436AbfESRWR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 May 2019 13:22:17 -0400
Received: from localhost (p5486CF3F.dip0.t-ipconnect.de [84.134.207.63])
        by pokefinder.org (Postfix) with ESMTPSA id AA86B2C36A9;
        Sun, 19 May 2019 11:06:42 +0200 (CEST)
Date:   Sun, 19 May 2019 11:06:42 +0200
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Kalle Valo <kvalo@codeaurora.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Arend van Spriel <arend.vanspriel@broadcom.com>,
        linux-rockchip@lists.infradead.org,
        Double Lo <double.lo@cypress.com>, briannorris@chromium.org,
        Madhan Mohan R <madhanmohan.r@cypress.com>, mka@chromium.org,
        Wright Feng <wright.feng@cypress.com>,
        Chi-Hsien Lin <chi-hsien.lin@cypress.com>,
        Jiong Wu <lohengrin1024@gmail.com>,
        Ritesh Harjani <riteshh@codeaurora.org>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Avri Altman <avri.altman@wdc.com>, Martin Hicks <mort@bork.org>
Subject: Re: [PATCH 2/3] mmc: core: API for temporarily disabling
 auto-retuning due to errors
Message-ID: <20190519090642.GA2279@kunai>
References: <20190517225420.176893-1-dianders@chromium.org>
 <20190517225420.176893-3-dianders@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="envbJBWh7q8WU6mo"
Content-Disposition: inline
In-Reply-To: <20190517225420.176893-3-dianders@chromium.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--envbJBWh7q8WU6mo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> Let's add an API that the SDIO card drivers can call that will
> temporarily disable the auto-tuning functionality.  Then we can add a
> call to this in the Broadcom WiFi driver and any other driver that
> might have similar needs.

Can't you fix the WiFi driver to return something else than -EILSEQ
before calling mmc_request_done() to skip the retuning?


--envbJBWh7q8WU6mo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlzhHJ4ACgkQFA3kzBSg
KbbeARAAjRwuYMVRg9/KiLaxQrOgOKoCgflbt6sCKz+IWQYwpHqy/NMeXxogeaZp
y/kpClhWulThbXbH5kiV59qh55aSNFsNM0yA+IZFwbye0fKtXEtkJIjBVAOfQDdz
PY2Jx2nNSJWWJeUzcfbW1LwvygH2a3Hon2p1/UubaqYvLPoZPCZmwVC/1LFdJPPN
fv2uN5ukpVcfmNBSbQUUaoMPZp6oeuAxHa1+58aQzpCMo3h329ERrcgkDDcw4WP9
K20azhSC961CnA7Syj84BsmlMnARaCyZ9S8atXXCtX6R5hbgUXLkBIcqtbfB+npd
j0sTjbHGDh7eaQ0l14Xh3FVSeHZiepGlupQ1wW6HuHkR1Be1mL6nEdCvSqT0mNHf
TsHkuq9Loh/95/eInWqtpGVM2XOpwDkN8czDOwwiO4ejRHaIEaoZX6FWeV80lDnX
emtFSLifF0VaH5GqM4HwOu3iXFBxpuj6zwnADaxYZqwnFNyi0+nvhp9W2tHyaLey
fcB6sw/i+2Knu5k2JnaSHZutc2hqY6lhoLaJyjQKMfk2fxRBmdimnt3u6bNV9U+N
Qo4IQM5w5wgRGUbUAcfo9/aLXnEdVbEuSy6QJdLgp7pZUBaIj4c5U7XROP6RQRFJ
6XB4ckAS0xBjDQ/mFNM/W2+Keu+9dcqNtDrAEn3vchAKecUJdO0=
=k7qP
-----END PGP SIGNATURE-----

--envbJBWh7q8WU6mo--
