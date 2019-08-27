Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E9DCC3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 11:55:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 634F620828
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 11:55:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566906909;
	bh=u5sVvWWTQtVk3WkPhw+QEZWRpWedWxCNA3xGXk9Xixc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-ID:From;
	b=tDpdOpzX8fl2uhOD88QXKew8/TZea9XM/AhGjPVtr+b7gqBNJQdOkrGf0SBsQnAFX
	 7qw9Qoi0PaME8r2PTnxB2S8KY/FZMd1NX5+CscxAZ4EPEoImA+PlDCccWBnUSnAgSe
	 tanoyel9SahINZQNx8o4b7eRVXS8xjESl307mGPs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729322AbfH0LzI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 07:55:08 -0400
Received: from mga17.intel.com ([192.55.52.151]:44534 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725850AbfH0LzH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 07:55:07 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Aug 2019 04:55:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,437,1559545200"; 
   d="asc'?scan'208";a="380013415"
Received: from pipin.fi.intel.com (HELO pipin) ([10.237.72.175])
  by fmsmga005.fm.intel.com with ESMTP; 27 Aug 2019 04:55:04 -0700
From:   Felipe Balbi <balbi@kernel.org>
To:     Ran Wang <ran.wang_1@nxp.com>, Yinbo Zhu <yinbo.zhu@nxp.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-usb\@vger.kernel.org" <linux-usb@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Cc:     Xiaobo Xie <xiaobo.xie@nxp.com>, Jiafei Pan <jiafei.pan@nxp.com>
Subject: RE: [EXT] Re: [PATCH v1] usb: dwc3: remove the call trace of USBx_GFLADJ
In-Reply-To: <DB8PR04MB682695EEB3E358BDB3E2D5D0F1A00@DB8PR04MB6826.eurprd04.prod.outlook.com>
References: <20190729064607.8131-1-yinbo.zhu@nxp.com> <875zn8nt31.fsf@gmail.com> <VI1PR04MB41580DBF1A0C2DC143EE9CE3E9D30@VI1PR04MB4158.eurprd04.prod.outlook.com> <87h86nvtqo.fsf@gmail.com> <VI1PR04MB4158B49129BE9E3C00997555E9AC0@VI1PR04MB4158.eurprd04.prod.outlook.com> <87v9uzt1dr.fsf@gmail.com> <DB8PR04MB682695EEB3E358BDB3E2D5D0F1A00@DB8PR04MB6826.eurprd04.prod.outlook.com>
Date:   Tue, 27 Aug 2019 14:55:00 +0300
Message-ID: <87sgpmx1pn.fsf@gmail.com>
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

Ran Wang <ran.wang_1@nxp.com> writes:
>> Yinbo Zhu <yinbo.zhu@nxp.com> writes:
>> >> Yinbo Zhu <yinbo.zhu@nxp.com> writes:
>> >> >> > diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
>> >> >> > index
>> >> >> > 98bce85c29d0..a133d8490322 100644
>> >> >> > --- a/drivers/usb/dwc3/core.c
>> >> >> > +++ b/drivers/usb/dwc3/core.c
>> >> >> > @@ -300,8 +300,7 @@ static void
>> >> >> > dwc3_frame_length_adjustment(struct
>> >> >> > dwc3 *dwc)
>> >> >> >
>> >> >> >       reg =3D dwc3_readl(dwc->regs, DWC3_GFLADJ);
>> >> >> >       dft =3D reg & DWC3_GFLADJ_30MHZ_MASK;
>> >> >> > -     if (!dev_WARN_ONCE(dwc->dev, dft =3D=3D dwc->fladj,
>> >> >> > -         "request value same as default, ignoring\n")) {
>> >> >> > +     if (dft !=3D dwc->fladj) {
>> >> >>
>> >> >> if the value isn't different, why do you want to change it?
>> >> >>
>> >> >> --
>> >> >> Balbi
>> >> > Hi Balbi,
>> >> >
>> >> > I don't change any value. I was remove that call trace.
>> >>
>> >> Sure you do. The splat only shows when you request a FLADJ value
>> >> that's the same as the one already in the register. The reason you
>> >> see the splat is because your requested value is what's already in th=
e HW.
>> >>
>> >> So, again, why are you adding this device tree property if the value
>> >> is already the correct one?
>> >>
>> >> > In addition that GFLADJ_30MHZ value intial value is 0, and it's
>> >> > value must be 0x20, if not, usb will not work.
>> >>
>> >> it's not zero, otherwise the splat wouldn't trigger. You're
>> >> requesting the value that's already in your register by default.
>> >>
>> >> --
>> >> Balbi
>> >
>> > Hi Balbi,
>> >
>> > According that rm doc that GFLADJ_30MHZ has a default value is 0x20,
>> > when GFLADJ_30MHZ_REG_SEL is 0, this 0x20 is a hard-coded value.
>> >
>> > But in fact, that default value is 0, please you note!
>> >
>> > Then according that xhci spec 5.2.4, that register the sixth bit if is
>> > 0, then that can support Frame Lenth Timing value.
>> >
>> > So set GFLADJ_30MHZ_REG_SEL to 1 for use FLADJ, then I find that it
>> > must use 0x20 usb will work well, even thoug xhci can permit
>> > GFLADJ_30MHZ use other value
>>=20
>> You only get the splat because you try to sent GFLADJ to 0x20 and it's A=
LREADY
>> 0x20. This means that you don't need the property in DTS.
>>=20
>> > In addition about what you said is about dts patch, and that patch had
>> > merged by upstream, patch owner isn't me,
>>=20
>> Well, then remove the setting from DTS, since clearly it's not needed.
>
> Please considering below scenarios on the same board which needs GFLADJ p=
roperty on kernel DTS:
>
> 1. Board boot to U-Boot first, then load kernel. In this case, we need ke=
rnel DTS
>     help to get GFLADJ setting right, everything is as expected.
>
> 2. Board boot to U-Boot console, then execute 'usb start' under U-Boot co=
nsole to init
>     DWC3 controller, then load kernel. In this case, actually GFLADJ is c=
orrectly
>     configured already, and the GFLADJ config double-checking is fine (be=
cause kernel
>     cannot know if U-Boot has initialized it or not), but warning looks n=
ot necessary.
>
> 3. Board boot to kernel, GFLADJ get set from DTS, then system suspend & r=
esume. In this case
>     when resuming, GFLADJ setting has been restored correctly, so here we=
 might not need
>     send out the warning message (double-checking might be fine).
>
> So, what's your suggestion to remove this looks non-necessary warning mes=
sage?

now this is well explained! So the value in the register is *NOT* 0x20
by default, however, u-boot _can_ use dwc3 if we're flashing, then it'll
result in the splat.

Okay, this is a valid scenario that the kernel should consider. I agree
that we should remove the WARN() from there.

Thanks

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEElLzh7wn96CXwjh2IzL64meEamQYFAl1lGhQACgkQzL64meEa
mQZ3ghAAqsTDKjntUdQKZSxR0oUcnoQ52EY8S3wDuIxJnZUBOk4Z12V7RNH6IWkg
1WmxlRS0aYpguZGp6XR4Vw6y0i2RuyZ6mq6MiXq4sF3I8pqhgrMFQEbxrVjyRvGH
BWf0zlKNLH1XCqgX18ENKSWWGAzpR0/SXPtFhGdonnfiIZn+NfdId1jWjfxyOPIc
/p/5VaWvlSazbAF37rJWGHrW6MwqltIApBdJXMdW7nwXsFWi9vnMvlBbnUzvcEr2
BV+KCjWFuUvdG3bMU92mO/xUx0OOl7jhKSn7LcsBFL/5A0HayYZCB5LqOm9sWgJG
MSir+vSmnZV1XKqQcLK64SchsaNaq1DvT9lUR2VPAh0GeGKxaU5iVvX60LC8vV7a
ZwSb4OF5qYBNhYK6M1ezbxPD/xyWp0f6Vaqo1ryYcUNjC3KmV8i0YR4cgxE7ROUG
NAIESWRvT+LBabddMsjPmeT6yub5xj1jugtC/oNsuybE41KRCRsqDTK9NzfSm89p
mR+/JPNeqBCF2KpBHaySUWAXfCThlv/arNHQgzfFlZ/FMNMiF/kvTOh9Nv6RGARG
n/qpkU91GbWBMg3Fp0iuZq1tRTFV7h9DYNtCKhaMTr8sNHut5SoulYF+O3DJun6m
IK+wbyXFLzNNCFSq1n57pNAR1cd5HzR53afWiGMghtUmvvhJCbs=
=X0Hb
-----END PGP SIGNATURE-----
--=-=-=--
