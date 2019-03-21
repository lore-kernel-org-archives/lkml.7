Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70673C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 09:30:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D139218D9
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 09:30:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728189AbfCUJaR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 05:30:17 -0400
Received: from relay12.mail.gandi.net ([217.70.178.232]:39695 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728001AbfCUJaQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 05:30:16 -0400
Received: from localhost (aaubervilliers-681-1-92-153.w90-88.abo.wanadoo.fr [90.88.33.153])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id A90AD20002A;
        Thu, 21 Mar 2019 09:30:12 +0000 (UTC)
Date:   Thu, 21 Mar 2019 10:30:12 +0100
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Chen-Yu Tsai <wens@kernel.org>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com,
        Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH v3 3/9] power: supply: axp20x_usb_power: allow disabling
 input current limiting
Message-ID: <20190321093012.kg72voxs5kw5xtzu@flea>
References: <20190321084850.20769-1-wens@kernel.org>
 <20190321084850.20769-4-wens@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="g72eht37btz5vbkz"
Content-Disposition: inline
In-Reply-To: <20190321084850.20769-4-wens@kernel.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--g72eht37btz5vbkz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

The rest of the series is
Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>

On Thu, Mar 21, 2019 at 04:48:44PM +0800, Chen-Yu Tsai wrote:
> From: Chen-Yu Tsai <wens@csie.org>
>
> The AXP PMICs allow the user to disable current limiting on the VBUS
> input. While read-out of this setting was already supported by the
> driver, it did not allow the user to configure the PMIC to disable
> current limiting.
>
> Add support for this.
>
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

Do we really want to do that though? That could have some pretty bad
consequences.

Maxime

--
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--g72eht37btz5vbkz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXJNZpAAKCRDj7w1vZxhR
xaEzAP4oukbF6SvGASg+RlSVeccvlfUXq8LnZ5QBPnYVFK2kdQEA4PIgT2v1vqEO
eI5AqADiKVPkXYAsmCyEruzUSD4izgg=
=Ani2
-----END PGP SIGNATURE-----

--g72eht37btz5vbkz--
