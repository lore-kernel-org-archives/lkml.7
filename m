Return-Path: <SRS0=Ba5y=Y3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4C41CA9EB0
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Nov 2019 16:22:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92D022084D
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Nov 2019 16:22:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572798166;
	bh=MdoURyUZcQbm9ELJ4P+9FxCOSf3poCqyZ7a+DoWIQyE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=y/nO/wT9L/m0zLY6Wan7KtjNdVoPeBU/PNUWke0XzSJ2+S7lQGWRUxJPjd+va6MyL
	 iMTSRQHPTJb34znyexTBFB3zkECQbpkgEmq5JGi+GYfCkEfMjv7qF4jvoQ5291Th7t
	 LDQZQsmONFpdOCsKjF0dB124K7EXdPrqPLjpmBHM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727843AbfKCQWp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Nov 2019 11:22:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:46716 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727733AbfKCQWp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Nov 2019 11:22:45 -0500
Received: from localhost (lfbn-1-10718-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 08E2120848;
        Sun,  3 Nov 2019 16:22:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572798164;
        bh=MdoURyUZcQbm9ELJ4P+9FxCOSf3poCqyZ7a+DoWIQyE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=g/cUA6VvRX7z30gTnCo/+VC+PGcOH9r5T840xs199WPGBApWOGRy2Wm5LUaX4j0pY
         EoI5jgyoy363VH9KVlPR4UtMIYvtwz2tccFji240s4eGESkaS7oL7T8mNgz3hl/c98
         xgD8raEyuuEVMwpz5R+QWGG1CM7lg+36MzEpGLbI=
Date:   Sun, 3 Nov 2019 17:22:41 +0100
From:   Maxime Ripard <mripard@kernel.org>
To:     Karl Palsson <karlp@tweak.net.au>
Cc:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "wens@csie.org" <wens@csie.org>
Subject: Re: [PATCH 3/3] ARM: dts: sun8i: add FriendlyARM NanoPi Duo2-IoT Box
Message-ID: <20191103162241.GE7001@gilmour>
References: <20191101091050.iw3n4qiqyueoymif@hendrix>
 <kCnyFRBTNPaksjpFGz3Vnx92t6yIivNcqixk5m2h238c@mailpile>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="u65IjBhB3TIa72Vp"
Content-Disposition: inline
In-Reply-To: <kCnyFRBTNPaksjpFGz3Vnx92t6yIivNcqixk5m2h238c@mailpile>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--u65IjBhB3TIa72Vp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Nov 01, 2019 at 09:55:41AM -0000, Karl Palsson wrote:
>
> Maxime Ripard <mripard@kernel.org> wrote:
> > On Thu, Oct 31, 2019 at 11:12:16PM +0000, Karl Palsson wrote:
> > > The IoT-Box is a dock for the NanoPi Duo2, adding two USB host ports, a
> > > 10/100 ethernet port, a variety of pin headers for i2c and uarts, and a
> > > quad band 2G GSM module, a SIM800C.
> > >
> > > Full documentation and schematics available from vendor:
> > > http://wiki.friendlyarm.com/wiki/index.php/NanoPi_Duo2_IoT-Box
> > >
> > > Signed-off-by: Karl Palsson <karlp@tweak.net.au>
> >
> > It seems like it's something that can be connected /
> > disconnected at will?
> >
> > If so, then it should be an overlay, not a full blown DTS.
>
> Fine with me, I wasn't sure on the best procedure for things like
> this. It's not something you plug / unplug at run time, you'd
> tend to just always have this, or not. Is it best to just have
> user space distributions handle selecting the overlay then? and
> they maintain the overlay file?

Another option would be to do it at the bootloader level, based on a
discovery mechanism (eeproms storing data / the overlay itself, the
presence of some devices on buses that you can probe (i2c, mmc, etc).

> I'd considered overlays something for _per user_ customization,
> but I'm perfectly happy if it it's intended to be used for per
> product customization too if that's the right method.

Overlays are for dynamic configuration. The user customization is one
of its use case, but add-on boards are another (being used by the RPi
and the Beaglebones), just like FPGA configuration for example.

Maxime

--u65IjBhB3TIa72Vp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXb7+0QAKCRDj7w1vZxhR
xUOhAQDZpbpB1JhUwpEpa1m0lL+I/g1BtVN/bGFs5sVjL+uXpAD/eo1qcpSUyU3K
al1o/BWKh2teIAwI9z/EMruIiD4CZgk=
=8zLz
-----END PGP SIGNATURE-----

--u65IjBhB3TIa72Vp--
