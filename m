Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C10BC48BD6
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 14:51:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB18A20659
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 14:51:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726905AbfF0OvU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 10:51:20 -0400
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:33743 "EHLO
        relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726443AbfF0OvU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 10:51:20 -0400
X-Originating-IP: 86.250.200.211
Received: from localhost (lfbn-1-17395-211.w86-250.abo.wanadoo.fr [86.250.200.211])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id 7C33440016;
        Thu, 27 Jun 2019 14:51:16 +0000 (UTC)
Date:   Thu, 27 Jun 2019 16:51:16 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Rob Herring <robh@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] dt-bindings: nvmem: Add YAML schemas for the generic
 NVMEM bindings
Message-ID: <20190627145116.piof4sokhlt3n3fu@flea>
References: <20190627080959.4488-1-srinivas.kandagatla@linaro.org>
 <CAL_Jsq+er-MZY-Vuez3B48fb05AH9UzNZck=BK6xHutuXdfDTQ@mail.gmail.com>
 <6775b9b9-b712-0b37-fa4c-ace9527f5fc9@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="uv4o3fvyylrkncxn"
Content-Disposition: inline
In-Reply-To: <6775b9b9-b712-0b37-fa4c-ace9527f5fc9@linaro.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--uv4o3fvyylrkncxn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

On Thu, Jun 27, 2019 at 02:58:24PM +0100, Srinivas Kandagatla wrote:
> On 27/06/2019 14:55, Rob Herring wrote:
> > But you didn't update the license to (GPL-2.0 OR BSD-2-Clause). See below.
>
> I did forward what Maxime has sent me.
>
> Maxime, are you okay if I do that changes to this patch and resend?

Sorry, Rob mentionned that it was a question for Linaro, and I just
forgot this question entirely.

You're the primary author here, so I guess you should be the one
telling me whether it's ok :)

On my side, I'm fine with this, but this isn't relevant.

Maxime

--
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--uv4o3fvyylrkncxn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXRTX5AAKCRDj7w1vZxhR
xcsPAQCgb58LNKYcJJiWmLuyOSMr1WBMyxBygUIjvnLoRjIcEwD/ZCb4wZ4sKY+o
75/Xj6Hj/El4vu62keZEHd50pUp9yAY=
=YEyU
-----END PGP SIGNATURE-----

--uv4o3fvyylrkncxn--
