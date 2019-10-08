Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D58DEC4360C
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 11:50:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF9EF206C2
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 11:50:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570535432;
	bh=TnCK/FJHSQzNMdHj08vt9f6JynyG3tVaHYmfhv1ar4A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=qiXQOtD+KU6JP2HKvX9fhtc2FjTvRc82VHceAPjsXXriay/5BS83hEFEtinlw1OwW
	 DURRwNynxzP7Y14Ypr0yFw5HFXdirJ4A+aiieP9OfDWgpUdSgLghtfM+V8d9tFdvfp
	 zdp2uY2EoSkiHn/GVZqeMhpi55kWyHTfn4Kw4mus=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730754AbfJHLuc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 07:50:32 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:59860 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730503AbfJHLub (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 07:50:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=HU5Z8WYkEcy2A0wU6XIUSzSQGNyQSuE2XR7coM1PA08=; b=l/T7t9Ub/pYvcCITICGEh94C5
        u4ZwpFmxbsiOdc0nusHOtfMzz8pB9HThddX24FyCbpmAslty2U1sAn6/NmMv5e6J8qsMMMmOu6gNT
        2a8D3OT0j99z5tB7aCyAch+KsV/5kMz1JnN+yDCAApZq+CGtrUqaGFMVVK//O+9z7f2kI=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1iHo0Y-0008Cn-Pl; Tue, 08 Oct 2019 11:50:26 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 02C082742998; Tue,  8 Oct 2019 12:50:25 +0100 (BST)
Date:   Tue, 8 Oct 2019 12:50:25 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     linux-kernel@vger.kernel.org, Dmitry Osipenko <digetx@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-samsung-soc@vger.kernel.org
Subject: Re: [PATCH] regulator: core: Skip balancing of the enabled
 regulators in regulator_enable()
Message-ID: <20191008115025.GF4382@sirena.co.uk>
References: <CGME20191008101720eucas1p2e0d1bca6e696848bf689067e05620679@eucas1p2.samsung.com>
 <20191008101709.13827-1-m.szyprowski@samsung.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="eNMatiwYGLtwo1cJ"
Content-Disposition: inline
In-Reply-To: <20191008101709.13827-1-m.szyprowski@samsung.com>
X-Cookie: Do not disturb.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--eNMatiwYGLtwo1cJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Oct 08, 2019 at 12:17:09PM +0200, Marek Szyprowski wrote:
> Commit f8702f9e4aa7 ("regulator: core: Use ww_mutex for regulators
> locking"), regardless of the subject, added additional call to
> regulator_balance_voltage() during regulator_enable(). This is basically
> a good idea, however it causes some issue for the regulators which are
> already enabled at boot and are critical for system operation (for example
> provides supply to the CPU).

If regulators are essential to system operation they should be marked as
always-on...

> CPUfreq or other drivers typically call regulator_enable() on such
> regulators during their probe, although the regulators are already enabled
> by bootloader. The mentioned patch however added a call to
> regulator_balance_voltage(), what in case of system boot, where no
> additional requirements are set yet, typically causes to limit the voltage
> to the minimal value defined at regulator constraints. This causes a crash
> of the system when voltage on the CPU regulator is set to the lowest
> possible value without adjusting the operation frequency. Fix this by
> adding a check if regulator is already enabled - if so, then skip the
> balancing procedure. The voltage will be balanced later anyway once the
> required voltage value is requested.

This then means that for users that might legitimately enable and
disable regulators that need to be constrained are forced to change the
voltage when they enable the regualtors in order to have their
constraints take effect which seems bad.  I'd rather change the the
cpufreq consumers to either not do the enable (since there really should
be an always-on constraint this should be redundant, we might need to
fix the core to take account of their settings though I think we lost
that) or to set the voltage to whatever they need prior to doing their
first enable, that seems more robust.

--eNMatiwYGLtwo1cJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl2ceAEACgkQJNaLcl1U
h9DWoAf/dbUB8lRI6R+Hiquem9S07NhSAZKa1EzqebKLcAZ9dLQMvsXS+i8xm+uY
fUCKtKGaxmGAq8NE3Mf9rrwR3J4xRt0HmJNcQjH7zlb+rq8Vg2m6dwr+Vk1sm+AK
gHX0zgtg8sCvTJekKSso8/kb/ac/qhKn7MZAryUFaXLvOWWdwGlPjl49BrqEAej0
GCem17IW9Xa8qZ3F+woV41hdO95n8HmTS9nj0NWhZGFUu9LCAea3cMp5QcQ6AUNS
099DSn2Y/opczEuevMQALSFMiAvBToZRUzO1+HuEfwjpxbKY1ErJ/yIMUySnZQI2
m+88vWiJU1TxV7C3gTg/cAeuEhr9FQ==
=dYbd
-----END PGP SIGNATURE-----

--eNMatiwYGLtwo1cJ--
