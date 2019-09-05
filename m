Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7CE6C3A5A5
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 12:40:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 986A3244A2
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 12:40:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567687222;
	bh=frrUAbKZOoRiP4tMYIeBV0rXiqQT9kSwdAcdX0rpjMY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=R0gYdiwo5Qmolk0MSyCrvGRoqe6hpN0U4VWGXdQWqiVrYFwYonkMabpEhwyg14uJc
	 wCj9TesksX0aLiJZ7OkB1wX33ZFH3QNLsv9A/KEnSIePwULeS3M5oFNoDmBEDObWm+
	 PTdLTecN2Pn2R88nzgQescLtWFhPBYW/r2Zibeu4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389053AbfIEMkV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 08:40:21 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:35752 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730959AbfIEMkV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 08:40:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=T3FCFMN2z9Bt1GK8k3lpSyj2uENPY0dUEXr7VygNtFI=; b=G2bixAfMhR1u99XuvPXclaQZA
        EDcHSToBuaWXxAm/tT74GMleq2mBrO1d4/MaIah/qObMNDAFDiAslubrLpAaKnCUIsPZNU42io1u8
        EAOo7eDdGzWpvlL6oX+L22CxJLkFbFdHtCzvNTcFWOrnLlJwCVLxEspaRDt7lU5ZVJ0WI=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1i5r3g-0004X8-0K; Thu, 05 Sep 2019 12:40:16 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 0F1422742D07; Thu,  5 Sep 2019 13:40:14 +0100 (BST)
Date:   Thu, 5 Sep 2019 13:40:14 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Steven Price <steven.price@arm.com>
Cc:     Rob Herring <robh@kernel.org>, David Airlie <airlied@linux.ie>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drm/panfrost: Fix regulator_get_optional() misuse
Message-ID: <20190905124014.GA4053@sirena.co.uk>
References: <20190904123032.23263-1-broonie@kernel.org>
 <CAL_JsqK8hn8aHa0e-QhT5=dMqCd0_HzNWMHM1YbEC_2z8n-tXg@mail.gmail.com>
 <feaf7338-9aa1-5065-7a83-028aeadd5578@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="tThc/1wpZn/ma/RB"
Content-Disposition: inline
In-Reply-To: <feaf7338-9aa1-5065-7a83-028aeadd5578@arm.com>
X-Cookie: You humans are all alike.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--tThc/1wpZn/ma/RB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Sep 05, 2019 at 10:37:53AM +0100, Steven Price wrote:

> Ah, I didn't realise that regulator_get() will return a dummy regulator
> if none is provided in the DT. In theory that seems like a nicer
> solution to my two commits. However there's still a problem - the dummy
> regulator returned from regulator_get() reports errors when
> regulator_set_voltage() is called. So I get errors like this:

> [  299.861165] panfrost e82c0000.mali: Cannot set voltage 1100000 uV
> [  299.867294] devfreq devfreq0: dvfs failed with (-22) error

> (And therefore the frequency isn't being changed)

> Ideally we want a dummy regulator that will silently ignore any
> regulator_set_voltage() calls.

Is that safe?  You can't rely on being able to change voltages even if
there's a physical regulator available, system constraints or the
results of sharing the regulator with other users may prevent changes.
I guess at the minute the code is assuming that if you can't vary the
regulator it's fixed at the maximum voltage and that it's safe to run at
a lower clock with a higher voltage (some devices don't like doing that).
If the device always starts up at full speed I guess that's OK.  It's
certainly in general a bad idea to do this in general, we can't tell how
important it is to the consumer that they actually get the voltage that
they asked for - for some applications like this it's just adding to the
power saving it's likely fine but for others it might break things.

If you're happy to change the frequency without the ability to vary the
voltage you can query what's supported through the API (the simplest
interface is regulator_is_supported_voltage()).  You should do the
regulator API queries at initialization time since they can be a bit
expensive, the usual pattern would be to go through your OPP table and
disable states where you can't support the voltage but you *could* also
flag states where you just don't set the voltage.  That seems especially
reasonable if no voltages in the range the device supports can be set.

I do note that the current code requires exactly specified voltages with
no variation which doesn't match the behaviour you say you're OK with
here, what you're describing sounds like the driver should be specifying
a voltage range from the hardware specified maximum down to whatever the
minimum the OPP supports rather than exactly the OPP voltage.  As things
are you might also run into voltages that can't be hit exactly (eg, in
the Exynos 5433 case in mainline a regulator that only offers steps of
2mV will error out trying to set several of the OPPs).

--tThc/1wpZn/ma/RB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl1xAisACgkQJNaLcl1U
h9Dktwf/cU2P46lDZKOxus22wJ39FsrKnSMmarYUxJuVwMOvHiUCedJgRxcjMSJG
8qxD91/c5mLJn2adGdZx/3Wrf0RbY/EEjpk/Ru3sbFl/LEow2OwsAWLG9U/RBmJV
GfPwPTRgCOcKIJIEnrCkJV/XjaJhVdAQ6akUaOQtE8N5/+UAgi1qnmDkwndsLPcJ
SPvfK7oVN4/xtwxmwomTqz92oCIlcfwubjEl07jZB/DZARaN6LjhGFj18aHSiZqM
HV/6gNWaxeVMUpQktnuKzW5fGhAPmutN/+67cx0S9pUXIOeHENz8pE/H9RGeLKo0
oiXGbcDp/ied1I8DHJF8j5PiQ0qUdw==
=aLW0
-----END PGP SIGNATURE-----

--tThc/1wpZn/ma/RB--
