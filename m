Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0B4DC10F00
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 15:43:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9201E21852
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 15:43:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554479001;
	bh=GOgLyq5QBzoqNiw/jYFcfoGprsdnF7AsBTYJcwppRhk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Ziok/kyJNFmRp/p46e1XJJ1yhQB2LtddsAcQzQti8O/Wot6U/Tf8mGCDq/gHsUthV
	 bklgS4cmuzTm2tPsLcjobv9hTnC+1cBfHOTIXBXQPMLphK7x/5iUAjjZ1dAsiw1TgU
	 VMBYw0aw/WHgHrZIllwb9NqzLccN/RUHEz/Jj02c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731483AbfDEPnU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 11:43:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:49506 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726291AbfDEPnU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 11:43:20 -0400
Received: from earth.universe (host-091-097-083-087.ewe-ip-backbone.de [91.97.83.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 38E202184B;
        Fri,  5 Apr 2019 15:43:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554478999;
        bh=GOgLyq5QBzoqNiw/jYFcfoGprsdnF7AsBTYJcwppRhk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MnXzkO3WTUA1IpX/ZQfts5jWYWlBJl6tbi0CezX0kJGyZrDEZpK+v93R1LQvQbz0o
         fxmmDcvgiHLXFEsW/yCowWQ5M+dMi8mxzm0L8xnxgN80dksYoffVoTWPrbQU1bePjo
         ucBeN/bVaKWtuQc1BPUhqDnptQ7f/3W3kH4P2IKY=
Received: by earth.universe (Postfix, from userid 1000)
        id 30F313C08D5; Fri,  5 Apr 2019 17:43:17 +0200 (CEST)
Date:   Fri, 5 Apr 2019 17:43:17 +0200
From:   Sebastian Reichel <sre@kernel.org>
To:     Artur Rojek <contact@artur-rojek.eu>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH v2 1/2] dt-bindings: power: supply: gpio-charger: Add
 status-gpios property
Message-ID: <20190405154317.suqovb4u2bgceqf7@earth.universe>
References: <20190226150437.3704-1-contact@artur-rojek.eu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="lgrrqna5ih6dueed"
Content-Disposition: inline
In-Reply-To: <20190226150437.3704-1-contact@artur-rojek.eu>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--lgrrqna5ih6dueed
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Feb 26, 2019 at 04:04:36PM +0100, Artur Rojek wrote:
> Add documentation for the "status-gpios" property.
> Update the "gpios" property with a valid example.
>=20
> Signed-off-by: Artur Rojek <contact@artur-rojek.eu>
> ---
>=20
> Changes:
>=20
> v2: - add a better description for the "status-gpios" property,
>     - add valid examples for the "gpios" and "status-gpios" properties
>=20
>  .../devicetree/bindings/power/supply/gpio-charger.txt       | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>=20
> diff --git a/Documentation/devicetree/bindings/power/supply/gpio-charger.=
txt b/Documentation/devicetree/bindings/power/supply/gpio-charger.txt
> index adbb5dc5b6e9..999cc245543c 100644
> --- a/Documentation/devicetree/bindings/power/supply/gpio-charger.txt
> +++ b/Documentation/devicetree/bindings/power/supply/gpio-charger.txt
> @@ -14,12 +14,16 @@ Required properties :
>       usb-cdp (USB charging downstream port)
>       usb-aca (USB accessory charger adapter)
> =20
> +Optional properties:
> + - status-gpios: GPIO indicating whether a battery is charging.

I think it's better to name this charge-status-gpios, since charger
may provide all kind of status GPIOs. For example the existing
gpios property (also bad name, but cannot be changed easily now),
which provides AC online status.

Otherwise the binding and the driver patch looks good to me.

-- Sebastian

--lgrrqna5ih6dueed
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlynd44ACgkQ2O7X88g7
+prPzw//XO6mDUEhOYJsXTr2FPrYOHrHWEs0rLyj3x+5rOaOuVTb5LXAPtE2iCNZ
8J5/tZ48z9gAm4K16h5N6LIyMewU29E43ouzDDVZ60/k28gOFsZ/tSDT/lgUZiQg
irKv/yjn1txoQcQbb+aHRdHpXp/SBKFcU4T1iDT8EsU7bN4a3GW4WZQJPpSvAQhh
eQCWBiPAadNIyfJcQjmnUPtG8YQT3TCVDV8cXjMwV9nfc+3FKkMtZXW7rrsqdrVC
pukRRokwok4ogfJ5UF8UPJ/KkDO7aerKJ1vu2Ms8u+Mkz7k+OJAlUffTevlUXJX8
agi+XJHumq0OelOvgr4jowJ+Yh0Y2jcGX2iaw4DomNC7UPVXkzwhdMzIsdUKfULE
vxaznLsAOjRODTCJ+Dnd6te3qFNmMIP3v2K/8dmrQinfUEJheuxGrxVyRalSRVtX
B1yO1c6aHdiRAuxxIx+UlDOgHv4xzhbL4lzCxCFVXz5jj9H4jwPpwyI/YblLpu/p
njCBTlwpffeDwzWubkbxm3qyvqJcQgab3Wr7B0Y182djl8URipKqzeCGHc55V1In
7s2SE7ViXp4dUe2BeO963FpFDL0HKmFDq/wDpy2ix3yPPZyISmnRBwcFPPO50/ue
Mn5VCHi50BMIZegBPUQsGoKh03TbrmPa+0XmdW8qeOiIYi+M9t4=
=SUiH
-----END PGP SIGNATURE-----

--lgrrqna5ih6dueed--
