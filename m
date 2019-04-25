Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39D15C10F03
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 12:40:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C379020644
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 12:40:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729670AbfDYMka (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 08:40:30 -0400
Received: from mga02.intel.com ([134.134.136.20]:20751 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725965AbfDYMka (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 08:40:30 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Apr 2019 05:40:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,393,1549958400"; 
   d="asc'?scan'208";a="138735172"
Received: from pipin.fi.intel.com (HELO pipin) ([10.237.72.175])
  by orsmga006.jf.intel.com with ESMTP; 25 Apr 2019 05:40:22 -0700
From:   Felipe Balbi <felipe.balbi@linux.intel.com>
To:     Douglas Anderson <dianders@chromium.org>,
        Minas Harutyunyan <hminas@synopsys.com>, heiko@sntech.de
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        Artur Petrosyan <Arthur.Petrosyan@synopsys.com>,
        amstan@chromium.org, linux-rockchip@lists.infradead.org,
        William Wu <william.wu@rock-chips.com>,
        linux-usb@vger.kernel.org, Stefan Wahren <stefan.wahren@i2se.com>,
        Randy Li <ayaka@soulik.info>, zyw@rock-chips.com,
        mka@chromium.org, ryandcase@chromium.org,
        Amelie Delaunay <amelie.delaunay@st.com>, jwerner@chromium.org,
        dinguyen@opensource.altera.com,
        Elaine Zhang <zhangqing@rock-chips.com>,
        Douglas Anderson <dianders@chromium.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v2 3/5] Documentation: dt-bindings: Add snps,need-phy-for-wake for dwc2 USB
In-Reply-To: <20190418001356.124334-4-dianders@chromium.org>
References: <20190418001356.124334-1-dianders@chromium.org> <20190418001356.124334-4-dianders@chromium.org>
Date:   Thu, 25 Apr 2019 15:40:18 +0300
Message-ID: <87pnpas1fx.fsf@linux.intel.com>
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

Douglas Anderson <dianders@chromium.org> writes:

> Some SoCs with a dwc2 USB controller may need to keep the PHY on to
> support remote wakeup.  Allow specifying this as a device tree
> property.
>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
> For relevant prior discussion on this patch, see:
>
> https://lkml.kernel.org/r/1435017144-2971-3-git-send-email-dianders@chrom=
ium.org
>
> I didn't make any changes from the prior version since I never found
> out what Rob thought of my previous arguments.  If folks want a
> change, perhaps they could choose from these options:
>
> 1. Assume that all dwc2 hosts would like to keep their PHY on for
>    suspend if there's a USB wakeup enabled, thus we totally drop this
>    binding.  This doesn't seem super great to me since I'd bet that
>    many devices that use dwc2 weren't designed for USB wakeup (they
>    may not keep enough clocks or rails on) so we might be wasting
>    power for nothing.
> 2. Rename this property to "snps,wakeup-from-suspend-with-phy" to make
>    it more obvious that this property is intended both to document
>    that wakeup from suspend is possible and that we need the PHY for
>    said wakeup.
> 3. Rename this property to "snps,can-wakeup-from-suspend" and assume
>    it's implicit that if we can wakeup from suspend that we need to
>    keep the PHY on.  If/when someone shows that a device exists using
>    dwc2 where we can wakeup from suspend without the PHY they can add
>    a new property.
>
> Changes in v2: None
>
>  Documentation/devicetree/bindings/usb/dwc2.txt | 3 +++
>  1 file changed, 3 insertions(+)

checking file Documentation/devicetree/bindings/usb/dwc2.txt
Hunk #1 FAILED at 37.
Hunk #2 succeeded at 52 (offset -1 lines).
1 out of 2 hunks FAILED
=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEElLzh7wn96CXwjh2IzL64meEamQYFAlzBqrIACgkQzL64meEa
mQYE0w//cCr/Wc2ZD2abiUr+FHaO2iz3BvODX3EHdzur4BMpo/KZK9JnKw4m4RUa
L0qSu3RYrcbBW0h/zU+cy41VXKz+WBMJVgpl3TWUJ4AiTLrfQHzDNLvEXssyukkd
t3xocK2DAbDh6IMBriCDFsogXcLAuEQmPiuXZmj7fEtdFqymdCuFDijqT7GNCHNq
toCH4ajwUlvtjWbutwAUEl+o4Hq91nQqyZfKRhHu6Q43fLXyqQzHdDFKn041J7+f
5bxgb3TGihobUYBNX2cGRgJBXl36fn1E+PlhFIBk7e8/09ZmF+oQaP6eU1n+jbkC
S2BSNRO2+Cvnnylp7XTrj88QUyNv+hqiSC3lkmWoyE7IbP7LphW0K0J8h0t70P0t
yg+7/HG1m/AhJxSSrBqUXtHdgJeCBoLjOZgRzdNccDS4vzJVId8hsZX17und9Xmg
UCuHgLwrF+69vqD4HgVBWhFlh/BawSwgxOmih/VskGPoVIObtyxCqKqflPoEiAYT
DtF0S6fWKk0Ko+BfCaPTg548QecBuu3uo4DO0XOu3GaYAraV9Sn2VkoJYXTDF+ny
lv5+dRw+cY3c7UVgg41kd7Tq1Hbhuuv/IFmIg1yR1qY0gSGuLOjEYKjooa4cIblB
AE63sGvm4y81n9AChloTq4x3NabubgLpcr8GCFuSUiDz+zwHiiY=
=tY5t
-----END PGP SIGNATURE-----
--=-=-=--
