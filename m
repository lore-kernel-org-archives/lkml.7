Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7C64CA9EAE
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 09:10:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 799F720717
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 09:10:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572340200;
	bh=qN8+XOYl0l917ICGh+4BRmUylPUXNJxkJKKOdPhKqmM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-ID:From;
	b=KkVcOFd0iSQfFOrOvMvsgSvwEkl1LlElyLCR4hAU9duGx1jYw8YYSbyceatyDIx+r
	 at3BpSz6aMwbNqUYnZwghziwaseC26+FiUQXqSNIkyKOJuCnWgHDBKoj7IcSW6O5sg
	 FTAI6cmVUfWpi2vejsqn39bWtdXlfOdYCEjyiZ/I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731133AbfJ2JJ7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 05:09:59 -0400
Received: from mga02.intel.com ([134.134.136.20]:29569 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727320AbfJ2JJ6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 05:09:58 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Oct 2019 02:09:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,243,1569308400"; 
   d="asc'?scan'208";a="401084207"
Received: from pipin.fi.intel.com (HELO pipin) ([10.237.72.175])
  by fmsmga006.fm.intel.com with ESMTP; 29 Oct 2019 02:09:51 -0700
From:   Felipe Balbi <balbi@kernel.org>
To:     John Stultz <john.stultz@linaro.org>,
        lkml <linux-kernel@vger.kernel.org>
Cc:     Yu Chen <chenyu56@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        ShuFan Lee <shufan_lee@richtek.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jun Li <lijun.kernel@gmail.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Jack Pham <jackp@codeaurora.org>, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, John Stultz <john.stultz@linaro.org>
Subject: Re: [PATCH v4 2/9] usb: dwc3: Execute GCTL Core Soft Reset while switch modes
In-Reply-To: <20191028215919.83697-3-john.stultz@linaro.org>
References: <20191028215919.83697-1-john.stultz@linaro.org> <20191028215919.83697-3-john.stultz@linaro.org>
Date:   Tue, 29 Oct 2019 11:09:47 +0200
Message-ID: <87pnifj4tg.fsf@gmail.com>
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
> From: Yu Chen <chenyu56@huawei.com>
>
> On the HiKey960, we need to do a GCTL soft reset when
> switching modes.
>
> Jack Pham also noted that in the Synopsys databook it
> mentions performing a GCTL CoreSoftReset when changing the
> PrtCapDir between device & host modes.
>
> So this patch always does a GCTL Core Soft Reset when
> changing the mode.
>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> CC: ShuFan Lee <shufan_lee@richtek.com>
> Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
> Cc: Chunfeng Yun <chunfeng.yun@mediatek.com>
> Cc: Yu Chen <chenyu56@huawei.com>
> Cc: Felipe Balbi <balbi@kernel.org>
> Cc: Hans de Goede <hdegoede@redhat.com>
> Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
> Cc: Jun Li <lijun.kernel@gmail.com>
> Cc: Valentin Schneider <valentin.schneider@arm.com>
> Cc: Jack Pham <jackp@codeaurora.org>
> Cc: linux-usb@vger.kernel.org
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Yu Chen <chenyu56@huawei.com>
> Signed-off-by: John Stultz <john.stultz@linaro.org>
> ---
> v3: Remove quirk conditional, as Jack Pham noted the
>     Synopsis databook states this should be done generally.
>     Also, at Jacks' suggestion, make the reset call before
>     changing the prtcap direction.
> ---
>  drivers/usb/dwc3/core.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>
> diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
> index 999ce5e84d3c..a039e35ec7ad 100644
> --- a/drivers/usb/dwc3/core.c
> +++ b/drivers/usb/dwc3/core.c
> @@ -112,6 +112,19 @@ void dwc3_set_prtcap(struct dwc3 *dwc, u32 mode)
>  	dwc->current_dr_role =3D mode;
>  }
>=20=20
> +static void dwc3_gctl_core_soft_reset(struct dwc3 *dwc)
> +{
> +	u32 reg;
> +
> +	reg =3D dwc3_readl(dwc->regs, DWC3_GCTL);
> +	reg |=3D DWC3_GCTL_CORESOFTRESET;
> +	dwc3_writel(dwc->regs, DWC3_GCTL, reg);
> +
> +	reg =3D dwc3_readl(dwc->regs, DWC3_GCTL);
> +	reg &=3D ~DWC3_GCTL_CORESOFTRESET;
> +	dwc3_writel(dwc->regs, DWC3_GCTL, reg);
> +}
> +
>  static void __dwc3_set_mode(struct work_struct *work)
>  {
>  	struct dwc3 *dwc =3D work_to_dwc(work);
> @@ -154,6 +167,9 @@ static void __dwc3_set_mode(struct work_struct *work)
>=20=20
>  	spin_lock_irqsave(&dwc->lock, flags);
>=20=20
> +	/* Execute a GCTL Core Soft Reset when switch mode */
> +	dwc3_gctl_core_soft_reset(dwc);
> +

This is totally unnecessary. We have several platforms supporting dual
role *without* this trick. The only reason why the databook mentions a
reset is because some registers are shadowed, meaning that they share
the same physical space and just appear as different things for SW. The
reason being that Synopsys wanted to reduce the area of the IP and
decided to shadow registers which are mutually exclusive.

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEElLzh7wn96CXwjh2IzL64meEamQYFAl24AdsACgkQzL64meEa
mQYG6w/+PhuVnHbENgibtiA17MLBxqUDMNcM8k1BFKTATCRhgTSg71W8idmJEq9B
yRXMmOsvgimR6e7xqp/UAjlvwkBTmGQ/40XAvCxijNjA+cnDa5c4rIhqu6VqZHnp
DYNqNkYm+JEQVepn4Hv5Bbq2yYnUxpgLdqnaqRS0RFMDAkcl1pZ2d9XR/CejK0Oo
rA96WgtQCW2hOCSwEhkctB2WcrSI2IlM1ga5FjuTDRxR+yaAN+GDk0QIcYfhDMlb
Njrikp/vnu7w5xCQ/ZsjNK4/2sQY658FMjPPncTbr2TpSsyD509EIIjvjTyFjEQA
dOZjPx5AvOMpHdGG+5MxqfkNnyHnOPlBxI3UjJz+p0yc1VyP7I9cYKLfeYfVFDcH
qNDv852Vr8gg0icrpiypjosNj0Lh7VG/jU2+c66NS5nLJPeOwAO14Vu86pOwkTJB
t86Ui++sD3pJrhswKKJ/bmhYg0VoGEE0bi3ypwSTLCVPmzovXkYFOjqhAM2InwSl
6zHYIoAuCLo7OxEHi6bbLYRdNyMljv8MxbwGFCSAy7BJlD6CJbWuxA+9XuQHjp1g
LNVXWQu1RGqDcXYKq/owlKciJvPrVmJkZvTBFr3vtlMRAWpua+QLmN/H2GJBhwSV
d4APBgDKffT1wXXoeFkcAE2FHuMTSLWezcG/Ndo9J2/5pL1z0rg=
=NuOU
-----END PGP SIGNATURE-----
--=-=-=--
