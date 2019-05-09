Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBED0C04AB2
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 22:48:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4FCB217D7
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 22:48:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726857AbfEIWsh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 18:48:37 -0400
Received: from anholt.net ([50.246.234.109]:39358 "EHLO anholt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726694AbfEIWsh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 18:48:37 -0400
Received: from localhost (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id 58A1110A34BF;
        Thu,  9 May 2019 15:48:36 -0700 (PDT)
X-Virus-Scanned: Debian amavisd-new at anholt.net
Received: from anholt.net ([127.0.0.1])
        by localhost (kingsolver.anholt.net [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id cbl6gorFW7wH; Thu,  9 May 2019 15:48:35 -0700 (PDT)
Received: from eliezer.anholt.net (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id 5649610A34B6;
        Thu,  9 May 2019 15:48:35 -0700 (PDT)
Received: by eliezer.anholt.net (Postfix, from userid 1000)
        id D7D482FE3AA9; Thu,  9 May 2019 15:48:34 -0700 (PDT)
From:   Eric Anholt <eric@anholt.net>
To:     Florian Fainelli <f.fainelli@gmail.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "open list\:COMMON CLK FRAMEWORK" <linux-clk@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        bcm-kernel-feedback-list@broadcom.com, wahrenst@gmx.net,
        stefan.wahren@i2se.com
Subject: Re: [PATCH 1/2] clk: bcm: Make BCM2835 clock drivers selectable
In-Reply-To: <20190509202956.6320-2-f.fainelli@gmail.com>
References: <20190509202956.6320-1-f.fainelli@gmail.com> <20190509202956.6320-2-f.fainelli@gmail.com>
User-Agent: Notmuch/0.22.2+1~gb0bcfaa (http://notmuchmail.org) Emacs/26.1 (x86_64-pc-linux-gnu)
Date:   Thu, 09 May 2019 15:48:34 -0700
Message-ID: <87zhnvqm65.fsf@anholt.net>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain

Florian Fainelli <f.fainelli@gmail.com> writes:

> Make the BCM2835 clock driver selectable by other
> architectures/platforms. ARCH_BRCMSTB will be selecting that driver in
> the next commit since new chips like 7211 use the same CPRMAN clock
> controller that this driver supports.

These two are:

Reviewed-by: Eric Anholt <eric@anholt.net>

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE/JuuFDWp9/ZkuCBXtdYpNtH8nugFAlzUrkIACgkQtdYpNtH8
nuh7Zg//UNWYC5bsxmrRB4YpTfPJsmTMI2PN2Ax9N5pmQtBEesNnhvu9j/0rMDaZ
Y2r6pKD17+BdtFZwoAin8WuvpSBIUUx3h1VO2eYeHkpPxiKQDsErC/UJFkW0TPn7
jfNDq7ZWLScQOfNt2VP1RKwGGItx/eVwBhx+ogfWBgDNas/sc5HFB8LPrWFdgf3y
wbChlm+3CcJz0jSvl+Kl6eJzZEjWaEOms1V4jyG65rBQ5hyGcnVEUM5N/OFX0gGG
SDwLueGoCYZ/PSs7ThXHi9LU+1uGicj0MgQbkpm0O4XIRyW8akuPzAA4nFZwEnKr
SA7MnELFlYmRHaXsqgt1KKpyxvuDFhfTGSTlwX5kI2B5s2mjRczuYZm0OVkVKue/
uRXwpkXm5Fu0Qclx1abpx7I5Wg6nLhMT8+e664XK0mWi6mzKcHaVq//MzEdAtfeV
pTYeG/hPl1N4ZZYUVHxAekKEBpUiPqVqgzmtJT8dlznpQ0lblOeSO9MN3ORAhz4Z
Q2BduRuHTlbpyLTrNYNuKn9V6i3hpMlsvTQHck2QG4YFVwzmAMqtw4ItVSBrTm92
LOCQnxEtt0g863S/MhX9M2JGFxqe1AIfnOcXriTQlr9S0ddwvfvxUZ6W9NcJB0aC
4XFzWzPaUPYsvk72TKJaNPNv1PmhI47+xXR0MO3quhAJaOBpk5M=
=CcFF
-----END PGP SIGNATURE-----
--=-=-=--
