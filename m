Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67AECCA9EC3
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 09:17:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3297920717
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 09:17:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572340636;
	bh=M+eSYBC+zwUkFsv1ibb5Q4TaOPrWD1GW4zjVaR3lDxI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-ID:From;
	b=2kzYey0i1C593so+C2DPGadJHFyQ+5HiFhjBD8/09LhQQqvE8+TQFkXE6wdVfF0cg
	 RWoSK+wO2kBdOXCC1oVAxzYr747vfnuY//jdYn6llgWdYz5Dl0DJGWaeIbrsyZzNbE
	 HHRjwvdg3TVN/CuoR2R7lWIvP02ObXBAPvQrk31k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731803AbfJ2JRP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 05:17:15 -0400
Received: from mga11.intel.com ([192.55.52.93]:3237 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731694AbfJ2JRO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 05:17:14 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Oct 2019 02:17:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,243,1569308400"; 
   d="asc'?scan'208";a="374490234"
Received: from pipin.fi.intel.com (HELO pipin) ([10.237.72.175])
  by orsmga005.jf.intel.com with ESMTP; 29 Oct 2019 02:17:09 -0700
From:   Felipe Balbi <balbi@kernel.org>
To:     John Stultz <john.stultz@linaro.org>,
        lkml <linux-kernel@vger.kernel.org>
Cc:     John Stultz <john.stultz@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        ShuFan Lee <shufan_lee@richtek.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Yu Chen <chenyu56@huawei.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jun Li <lijun.kernel@gmail.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Jack Pham <jackp@codeaurora.org>, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v4 6/9] usb: dwc3: Rework resets initialization to be more flexible
In-Reply-To: <20191028215919.83697-7-john.stultz@linaro.org>
References: <20191028215919.83697-1-john.stultz@linaro.org> <20191028215919.83697-7-john.stultz@linaro.org>
Date:   Tue, 29 Oct 2019 11:17:05 +0200
Message-ID: <87h83rj4ha.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Hi,

John Stultz <john.stultz@linaro.org> writes:
> The dwc3 core binding specifies one reset.
>
> However some variants of the hardware my not have more.
                                        ^^
                                        may

According to synopsys databook, there's a single *input* reset signal on
this IP. What is this extra reset you have?

Is this, perhaps, specific to your glue layer around the synopsys ip?
Should, perhaps, your extra reset be managed by the glue layer?

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEElLzh7wn96CXwjh2IzL64meEamQYFAl24A5EACgkQzL64meEa
mQajVg/8C0zUku0Benos6tXfx/tAJJh/qhYsHfs0w1BvYtNy8KYfgq7yyUxX4zh5
2dbXhYsQ9fHdJgKPYrybO10XU6rPoWUrK+DOCAUjLx7Rj0P0SzkUI1UGXiCLNzvd
UEpOc14h8+KApJ239yKNWypZUdn+raYjMB2ZTtgjj7Smid8KvU5NBMVBuoOKKEm6
tIBw+Vsyzosjidd/fXIUkmJ/05dxh8BVUZcn76pfTMbdWPVyf6h0sGmkWCIPkHJ/
ac0Zow2zWML4LI2ZHDinWaqGS3lYf0r49UeiuNk6P+jnF0+OlhhUzY+XurlLEcI6
/ey9VqPG6j3/Hyx3EdBUlFDh3BzyQ12Pj41lCadzvPsjEQm/woUxzySByCaFGnp9
jXaJ3RerRbHcxoIfRuErdw2txreTr+HTWTpsBMPLv2immknoaI38qBBFWsTReDgi
2WgrJwr5O9ZLF/T2DpBM81WcZLCJQo6pzjetjb49XgJhCFDu0zSLV3A+72dWMR4R
2XTC73Ha5qwBWiHOSGZIWaEV3I4aBS9jENod8RuzstZwl+IJ+0ITy+DTN5C4LcVi
s05enHsr6vnk3LJkcA4v53yowDQbOimxWRM2/2a8Wrd4hTWPD/ohSzCr6S6uWY/E
+Uq6f1uiNzcx9AgTLaIInuloK27pv160JEs7Odw+ooaLDOwGObU=
=HQbL
-----END PGP SIGNATURE-----
--=-=-=--
