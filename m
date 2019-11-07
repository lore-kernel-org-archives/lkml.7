Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF2E1C43331
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 19:22:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D26D321882
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 19:22:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726604AbfKGTWk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 14:22:40 -0500
Received: from sauhun.de ([88.99.104.3]:45468 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725497AbfKGTWk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 14:22:40 -0500
Received: from localhost (x4e37fafe.dyn.telefonica.de [78.55.250.254])
        by pokefinder.org (Postfix) with ESMTPSA id 893F22C053A;
        Thu,  7 Nov 2019 20:22:37 +0100 (CET)
Date:   Thu, 7 Nov 2019 20:22:36 +0100
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Luca Ceresoli <luca@lucaceresoli.net>
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 01/12] i2c: replace i2c_new_probed_device with an
 ERR_PTR variant
Message-ID: <20191107192236.GA961@kunai>
References: <20191106095033.25182-1-wsa+renesas@sang-engineering.com>
 <20191106095033.25182-2-wsa+renesas@sang-engineering.com>
 <cd25c799-bb10-aa59-8705-b079eff2165e@lucaceresoli.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="BOKacYhQ+x31HxR3"
Content-Disposition: inline
In-Reply-To: <cd25c799-bb10-aa59-8705-b079eff2165e@lucaceresoli.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--BOKacYhQ+x31HxR3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Luca,

> I beg your pardon for the newbie question, perhaps a stupid one, kind of
> nitpicking, and not even strictly related to this patch, but what's the
> reason for these functions being declared extern?

I did this for consistency reasons. I agree that the 'extern' keyword
could need some second thought, yet I think that should be a seperate
patchset. And that does not have priority for me, so if someone is
interested... :)

> For the rest LGTM, I did some grep checks before/after the patchset, ran
> some build tests, and everything looks fine.

Cool, thanks for your review!

All the best,

   Wolfram


--BOKacYhQ+x31HxR3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAl3EbvgACgkQFA3kzBSg
KbZnUBAAqSXjKtHx8DfxjUUBGdokkq2sI804mQs+pZMf9AnfcaYXg0K4s8MXKkU4
FkTLxSx0YvFCek2Uj79mqz+6enZQ7BbtHjD27Cv9OTYdG2rRTiDj7klqL1L7wZII
ShG0ABY9s35DWS/XpBnT+PivvXHEv2qv78CQvreMGowwdaMlDLvfJvZgrNBr0ndg
vaLDR+2IGt1MMY7QqbQQOeH4kKsAVIYruAvcy1eZm4hDRBxUo2mq5wiG7ERWTXuW
/FXXXUa5/+6ty5sWyPnsvVE8c3yvC7O6/ejEuMlRHCVjL++20Yshka6X84UPOSlv
xCiDz+4r2L1UhNYM0sqBiP8zli1MfNsdVHlWVQtmm4pjIrWXzLlEuRlQm94DLZob
mUXugpUVXiy+CIPy2SVdvDnXGETFLuYx9kY/YMy0U7DPFnEcK7XCUA3Vj+Bfj73Y
yllFHHg7aeZvg7lfQvx4BIek9VzggAVs4qdreH9i5T2mPPPp+f7EM8diLzYjuJDG
3oWwtGYqdB5y0U2pZB6+AHGMfB7kgALP3dYxGshBKHiOnJmpz9UL77zP3gbn7I+E
CclNZNqtdDdGBJiOLETAYKBbpC7zXwt3dnbdZ72ZH1fcFPBjcDMFBjz1h49kHNpp
6Ig1J/nRkSpLi/RluOy1VrkOhCJaWDK7hMctS5BCm89T+xLYGFA=
=iIbZ
-----END PGP SIGNATURE-----

--BOKacYhQ+x31HxR3--
