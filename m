Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18512C43141
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 10:12:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1B2420728
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 10:12:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727306AbfKOKMI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 05:12:08 -0500
Received: from sauhun.de ([88.99.104.3]:59306 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725829AbfKOKMI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 05:12:08 -0500
Received: from localhost (p54B33606.dip0.t-ipconnect.de [84.179.54.6])
        by pokefinder.org (Postfix) with ESMTPSA id E65DD2C03E3;
        Fri, 15 Nov 2019 11:12:05 +0100 (CET)
Date:   Fri, 15 Nov 2019 11:12:05 +0100
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Eugeniu Rosca <erosca@de.adit-jv.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Niklas =?utf-8?Q?S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Simon Horman <horms+renesas@verge.net.au>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Eugeniu Rosca <roscaeugeniu@gmail.com>,
        Harish Jenny K N <harish_kandiga@mentor.com>,
        Andrew Gabbasov <andrew_gabbasov@mentor.com>
Subject: Re: [PATCH] mmc: renesas_sdhi_internal_dmac: Add MMC_CAP_ERASE to
 Gen3 SoCs
Message-ID: <20191115101205.GB2227@kunai>
References: <20191112134808.23546-1-erosca@de.adit-jv.com>
 <20191112204952.GA2976@kunai>
 <CAPDyKFq8oVk26ruNA_R8HDXhMGKhDeHnL0q82xi40g1aeo109A@mail.gmail.com>
 <20191114113743.GA19656@vmlxhi-102.adit-jv.com>
 <CAPDyKFp5iqrFDM1EWnYBwFmQAiAA5FADDLAyuVVBgMu4Sx=x5w@mail.gmail.com>
 <20191114201514.GA3058@kunai>
 <CAPDyKFpbu0tCWyUHRjVySRF3QR6Hzd8MXA+RhNeCjED1nPtkYg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="LpQ9ahxlCli8rRTG"
Content-Disposition: inline
In-Reply-To: <CAPDyKFpbu0tCWyUHRjVySRF3QR6Hzd8MXA+RhNeCjED1nPtkYg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--LpQ9ahxlCli8rRTG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> I think using a workqueue for scheduling a reset work with a timeout
> of 5 s, as in your case.

Sorry, I didn't get it. You think what exactly? Is it good / bad / ok
for now / ok in general?


--LpQ9ahxlCli8rRTG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAl3OefIACgkQFA3kzBSg
KbblBQ/9HgErqN5Lks0LB5r5uAF5wdOycdeKNnc/CQPztX6vJRiZpLH7l5fihnqz
PsXHSmMoKEKNOMTkaI7Gz0q0Il+H0yOeUEMCvN9MpzoNIIPhiiqBOuH0pQ2D80+f
4j1g19/WdVVTp2NYuzKxkzwNk7eUUJqjbo+k0R9Zph/PJ0duqe9TcbKQQoAgC4in
vpg/li9U0NAVR27GQ4l5+ouRWCmFNu0s0D6WZp7kkBz/cZSYfANswzbJNgP5VQgd
63SfaRev3VKxrOw4a9dJMdiQZyo9vPFYuyCFiQmuGHMKy1r8+y/EjLRdl5iSzenB
Pl/QrxzFXtQastX6aUxyplXE5KYRi+wB7aq5YQkWAiyTQ1Vc1sZKNpm8hw7W1Ryu
R/aNCRpUk9gEOTpOcz6yuSpJtqr7JA5WPdP+SkX5QvYjAFOq9wb1yMNrae09Ud78
dA5uzAg1k2LNkdMrf3q2KfmbDA+ZndOdXR8DAwSCNUi3V7/LSxWGVmzX0u9qtEXI
W+e49Rez56d7kQyfm2Yd9/vD//1Th2/EqyIrKP5V9lRunBDGfmmP2oG4eUbVcW7d
uTtEZc1jtwlgBKhbyYLrWhYHFCAHG6F9LxyjjpBDg8yNVBb9oh37jAVJzarJlYl9
lr+hfy7lV5OiPpU8ZZx+R9fkJEu3BbaBWXdnv/S8VHrRHOgtxG0=
=G8P7
-----END PGP SIGNATURE-----

--LpQ9ahxlCli8rRTG--
