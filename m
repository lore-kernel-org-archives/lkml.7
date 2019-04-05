Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9556CC4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 15:52:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A3CD21855
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 15:52:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554479545;
	bh=uCqjH6WSiHEuIJm7zv5pX1DuQt11Ycw4+/0/9uTHxuE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=R3Ie6RqoVurDi1Pi9qhnbfLSck9jpk4gPhgrK9YhIGGnQaUAxCA5BcKjGAUjKjOtN
	 jwk8RvJOnaUTzvEtVqpOhga6uwmfsHAoHtpgrISIg/OvPFPO3kptSLOgZWDu7W1eQF
	 tg7RHdlUbZ374gwsIkrrjgc+9ywQyT8XdiPfxB9w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731305AbfDEPwY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 11:52:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:52574 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726643AbfDEPwY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 11:52:24 -0400
Received: from earth.universe (host-091-097-083-087.ewe-ip-backbone.de [91.97.83.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DE7E32146F;
        Fri,  5 Apr 2019 15:52:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554479543;
        bh=uCqjH6WSiHEuIJm7zv5pX1DuQt11Ycw4+/0/9uTHxuE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cqoGgsVNW4mPt6XPndxs+CwsAanm7TyhKEQGGabTvrP6YfEV2FOpJZT297TRSuxJD
         IovnrXkFh9F3ZD/+jDArZ0NVD4+nmFjulHHjpANN+NqNRtacpyXfNMXYFHEUfL3lWl
         mZvGdG+kRtPZ05jqGP2nqUCPMbFFZxYjeUDOs2Is=
Received: by earth.universe (Postfix, from userid 1000)
        id E13743C08D5; Fri,  5 Apr 2019 17:52:20 +0200 (CEST)
Date:   Fri, 5 Apr 2019 17:52:20 +0200
From:   Sebastian Reichel <sre@kernel.org>
To:     Claudiu.Beznea@microchip.com
Cc:     robh+dt@kernel.org, mark.rutland@arm.com,
        Nicolas.Ferre@microchip.com, alexandre.belloni@bootlin.com,
        Ludovic.Desroches@microchip.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 0/3] add support for SAM9X60's shutdown controller
Message-ID: <20190405155220.rsxrvv2yopij73de@earth.universe>
References: <1550756716-3032-1-git-send-email-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="lcyamu3phuxokejg"
Content-Disposition: inline
In-Reply-To: <1550756716-3032-1-git-send-email-claudiu.beznea@microchip.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--lcyamu3phuxokejg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Feb 21, 2019 at 01:45:44PM +0000, Claudiu.Beznea@microchip.com wrot=
e:
> From: Claudiu Beznea <claudiu.beznea@microchip.com>
>=20
> Hi,
>=20
> This series adapt SAMA5D2's shutdown controller driver to work for
> SAM9X60's shutdown controller. The difference is that SAM9X60 have
> option for RTT timer wakeup.
>=20
> Thank you,
> Claudiu Beznea

Thanks, queued.

-- Sebastian

>=20
> Changes in v2:
> - collect Acked-by tags
> - in patch 3/3 use "optional microchip,sam9x60-shdwc properties"
>   string to specify that the introduced property is only for
>   microchip,sam9x60-shdwc as specified above in case of
>   atmel,<chip>-shdwc shutdown controllers
> - in patch 3/3 keep only the optional property introduced by
>   microchip,sam9x60-shwdwc (atmel,wakeup-rtt-timer)
>=20
> Claudiu Beznea (3):
>   power: reset: at91-poweroff: add RTT wakeup capability
>   power: reset: at91-poweroff: add support for SAM9X60
>   dt-bindings: arm: atmel: add binding for SAM9X60 shutdown controller
>=20
>  .../devicetree/bindings/arm/atmel-sysregs.txt      |  6 +++++-
>  drivers/power/reset/at91-sama5d2_shdwc.c           | 25 ++++++++++++++++=
++++++
>  2 files changed, 30 insertions(+), 1 deletion(-)
>=20
> --=20
> 2.7.4
>=20

--lcyamu3phuxokejg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlynebQACgkQ2O7X88g7
+pqpPxAAqI8P+IVyhLmkU+Aes/7au2rBLOAfw5K9NPNj10VzVsfa7dZnpimaWvhX
EqYXyPdPbcj5tAlRlWoVb77bgJvT4JaOQNS25fjR9gxx1IF0nTJm6ggcauFwECZM
3iZ1O0cvZkMAeSlEW9eto9mg18lgUHDI8SDl5RqiEAa7KDKSrKr9/tKEt/K/Kdvz
VA0QtNliTeTG9oYA8JhcPdjQqEpEcwWwoitB2MPWUHcoPw3HIxNRKBQRGjEdsgFQ
rtmk33qHqlobo8gKcv69SCd+wvLu4pht444G5KVrkUdBTwb2rKnvyVqz+BIyxbFv
fknCj9ZEi3AQMLwEkhQv+0LUvcT7aKGyvSnd2wTbI5//w6H/m3/aNCRD2wV/Qlfl
eEFyHSmG3sLw5xJOkqNP0RTqUIDWrKMuIqY4C2sruEgfmVACiKhRWemQwWAHLqXQ
yi1YwaTZbVkqZcgcYI5un8xJqlBUTy41vR6cI/IHrstWYrfX+FPv/oMT/muXurxa
D1Sz3uwRI+kaakIgfvELyV3t2gxM5qokZ3ndQikPDrScnl8h2a7GLjRIjO3vpljT
EqCl2utcFlj7sJIJUSMsbt/JYzwn60Rc9zCvGBs08Mpm4rHL4SRnMtXhYbiF7gtm
1hsmLNo5NdLxnRizxtCm3WRJKxb/+t0jf9bEBVCkqqndhLTvIGw=
=zRv5
-----END PGP SIGNATURE-----

--lcyamu3phuxokejg--
