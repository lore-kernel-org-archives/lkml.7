Return-Path: <SRS0=bFUY=XM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59040C4CEC9
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 09:39:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 314DB20862
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 09:39:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728547AbfIQJj0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Sep 2019 05:39:26 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:41107 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727002AbfIQJjZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 05:39:25 -0400
Received: from [5.158.153.52] (helo=linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:RSA_AES_256_CBC_SHA1:256)
        (Exim 4.80)
        (envelope-from <kurt.kanzenbach@linutronix.de>)
        id 1iA9x9-0000M8-FJ; Tue, 17 Sep 2019 11:39:19 +0200
Date:   Tue, 17 Sep 2019 11:39:19 +0200
From:   Kurt Kanzenbach <kurt.kanzenbach@linutronix.de>
To:     Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Andy Tang <andy.tang@nxp.com>,
        Alexander Stein <alexander.stein@systec-electronic.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/2] irqchip: add support for Layerscape external
 interrupt lines
Message-ID: <20190917093918.GA8901@linutronix.de>
References: <20180125150230.7234-1-rasmus.villemoes@prevas.dk>
 <20180223210901.23480-1-rasmus.villemoes@prevas.dk>
 <20180223210901.23480-2-rasmus.villemoes@prevas.dk>
 <alpine.DEB.2.21.1803011308440.1396@nanos.tec.linutronix.de>
 <4684c3ce-b56a-334d-f556-6e8524d8126c@prevas.dk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="AhhlLboLdkugWU4S"
Content-Disposition: inline
In-Reply-To: <4684c3ce-b56a-334d-f556-6e8524d8126c@prevas.dk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--AhhlLboLdkugWU4S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

On Fri, May 04, 2018 at 09:44:25AM +0200, Rasmus Villemoes wrote:
> >> +static int
> >> +ls_extirq_set_type(struct irq_data *data, unsigned int type)
> >> +{
> >> +	irq_hw_number_t hwirq = data->hwirq;
> >> +	struct extirq_chip_data *chip_data = data->chip_data;
> >> +	u32 value, mask;
> >
> > Please order local variables in reverse fir tree fashion whenever
> > possible. That's way simpler to read:
> >
> > 	struct extirq_chip_data *chip_data = data->chip_data;
> > 	irq_hw_number_t hwirq = data->hwirq;
> > 	u32 value, mask;
>
> Fixed, thanks.

Did you send a sixth version of this patch set? It seems like the code
hasn't been merged, yet. I also need support for the external interrupt
lines on a different Layerscape.

Thanks,
Kurt

--AhhlLboLdkugWU4S
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEooWgvezyxHPhdEojeSpbgcuY8KYFAl2AqcYACgkQeSpbgcuY
8KbC2hAAoCZDi2xaYd2gH9b02qjCYtAn1mJu+ibwMc+1BYoHks2kUX/F3iB/ev/Z
X2dsFpF5fQaE1vBnKpSn8P8qCv+eQzfwWqJlt/RIqE2hFBK+1NChQk/oRIycC6Pj
xyi38aHLrisB9W7LM+rXsBdlxb0Dzz4L+5TJaGS92gXoNwVpJlwPiBe/kirtWCKc
cISaUjbjcY0fBVZwQ62QBiIWnXoXENFomtwzxzhesPkCNurbU67NfDEEF1mh56Oy
x0IawGVtnOxMYEewZa/ybGAAtICC2n/58CyOFi6pDB65QTjxwYypzO3nwV8Wfaps
XdhBM+mN7PAhBB4TVzEgiqUFJU/Lqh+9Cc6c/rZHynlxYiSCXwHOex4CIWd1UYcG
JCJFO6KFTWviPzU3eai9DROwpuIgy12Eo+C3X6II8I/jQxWkj54TTNR/LQ0ghcYl
06cOQlm86BAfqrY+6iTC3kSZ6EWCEys/kRplajDPeNHDaKuGoREFyNcmpa70hCfz
KNzOTqOfJd3lsrOIx8kbXOZ01h/4+BRcHKEhIME/LRz8o7UBAnavxy29BTEPKHXz
qyoAoIljxwUwTsk74mLvUZzoXNEQ95NpC7Z/bq+WAEgh8vdgMDKHsUn42Sa4hMnq
czD9MAPGcsP5TzpVoWmSZY4ZrG3FiPeqJvbpEzrU67Ltdeq+9t4=
=rHJv
-----END PGP SIGNATURE-----

--AhhlLboLdkugWU4S--
