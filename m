Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59F98C04AB4
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 08:53:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36EB520818
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 08:53:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726774AbfEPIxF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 04:53:05 -0400
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:41107 "EHLO
        relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726352AbfEPIxF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 04:53:05 -0400
X-Originating-IP: 80.215.246.107
Received: from localhost (unknown [80.215.246.107])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id 377AD4000E;
        Thu, 16 May 2019 08:52:57 +0000 (UTC)
Date:   Thu, 16 May 2019 10:52:57 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Jernej Skrabec <jernej.skrabec@siol.net>
Cc:     wens@csie.org, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com
Subject: Re: [PATCH v2] arm64: dts: allwinner: a64: orangepi-win: Add wifi
 and bluetooth nodes
Message-ID: <20190516085257.tbli227f7mm3daac@flea>
References: <20190514205445.11591-1-jernej.skrabec@siol.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="5iqdhuknfkakdubp"
Content-Disposition: inline
In-Reply-To: <20190514205445.11591-1-jernej.skrabec@siol.net>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--5iqdhuknfkakdubp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 14, 2019 at 10:54:45PM +0200, Jernej Skrabec wrote:
> The AP6212 is based on the Broadcom BCM43430 or BCM43438. The WiFi side
> identifies as BCM43430, while the Bluetooth side identifies as BCM43438.
>
> WiFi is connected to mmc1 and the Bluetooth side is connected to UART1
> in a 4 wire configuration. Same as the WiFi side, due to being the same
> chip and package, DLDO2 provides overall power via VBAT, and DLDO4
> provides I/O power via VDDIO. The RTC clock output provides the LPO low
> power clock at 32.768 kHz.
>
> This patch enables WiFi and Bluetooth on OrangePi Win boards and adds
> missing LPO clock on the WiFi side. PCM connection also exists for
> Bluetooth audio, but it's not used here.
>
> Bluetooth UART speed is set to 1.5 MBaud in order to be able transmit
> audio. While module supports even higher speeds, currently sunxi clock
> driver doesn't support higher speed.
>
> Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>

Queued for 5.3, thanks

Maxime

--
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--5iqdhuknfkakdubp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXN0k6QAKCRDj7w1vZxhR
xcpbAP94oL8fh1mlEB3a33RqRRsd7gvpgLccANADmt8VCZXoqwD/e406SIQCBsZn
wQUuZCMJTyAcG0gQw7aYdlXTEqtpaAg=
=3MUP
-----END PGP SIGNATURE-----

--5iqdhuknfkakdubp--
