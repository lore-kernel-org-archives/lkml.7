Return-Path: <SRS0=+gZy=2O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CF19C2D0D0
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Dec 2019 06:45:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F18F206B7
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Dec 2019 06:45:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="K9BhtTDi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726203AbfLXGpf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Dec 2019 01:45:35 -0500
Received: from mail25.static.mailgun.info ([104.130.122.25]:59999 "EHLO
        mail25.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726157AbfLXGpf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Dec 2019 01:45:35 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1577169934; h=Content-Transfer-Encoding: Content-Type:
 MIME-Version: Message-ID: Date: Subject: In-Reply-To: References: Cc:
 To: From: Sender; bh=y1omERZmcgskIaqOr8CISIffUQ7b0HcT2oXAlwX2yc0=; b=K9BhtTDi91nsu09ls1aPqGaOlAxIRqw+Mcl5YQuEKsLAPAM+pzAZhcO3vOA7ZO/QkjO/ci2Z
 An3y4rw5tRr9omZeBoul1QhV57MzplMkaLG9pel3MNmMeSmDZXvOOSWPpujkqJMdcAoP3uw8
 h+P88kCbXU1GsqGLrMgmna4vf50=
X-Mailgun-Sending-Ip: 104.130.122.25
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e01b3fb.7fc3cd8a3228-smtp-out-n03;
 Tue, 24 Dec 2019 06:45:15 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id A8E95C4479D; Tue, 24 Dec 2019 06:45:15 +0000 (UTC)
Received: from Pillair (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: pillair)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 278B0C433A2;
        Tue, 24 Dec 2019 06:45:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 278B0C433A2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=pillair@codeaurora.org
From:   <pillair@codeaurora.org>
To:     "'Matthias Kaehlcke'" <mka@chromium.org>
Cc:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>
References: <1576741521-30102-1-git-send-email-pillair@codeaurora.org> <20191219174755.GY228856@google.com>
In-Reply-To: <20191219174755.GY228856@google.com>
Subject: RE: [PATCH v2] arm64: dts: qcom: sc7180: Add WCN3990 WLAN module device node
Date:   Tue, 24 Dec 2019 12:15:10 +0530
Message-ID: <01fc01d5ba25$b2b12dd0$18138970$@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQIjIEokzq12Ktb+lJAmDlq61u6HBQGTLv1bpyFwBpA=
Content-Language: en-us
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi MItthias,

> -----Original Message-----
> From: Matthias Kaehlcke <mka@chromium.org>
> Sent: Thursday, December 19, 2019 11:18 PM
> To: Rakesh Pillai <pillair@codeaurora.org>
> Cc: devicetree@vger.kernel.org; linux-arm-kernel@lists.infradead.org; =
linux-
> kernel@vger.kernel.org; linux-arm-msm@vger.kernel.org
> Subject: Re: [PATCH v2] arm64: dts: qcom: sc7180: Add WCN3990 WLAN
> module device node
>=20
> On Thu, Dec 19, 2019 at 01:15:21PM +0530, Rakesh Pillai wrote:
> > Add device node for the ath10k SNOC platform driver probe
> > and add resources required for WCN3990 on sc7180 soc.
> >
> > Signed-off-by: Rakesh Pillai <pillair@codeaurora.org>
> > ---
>=20
> This does not apply cleanly against the current qcom/arm64-for-5.6
> or for-next branch, looks like you need to rebase.
>=20
> >  arch/arm64/boot/dts/qcom/sc7180-idp.dts |  5 +++++
> >  arch/arm64/boot/dts/qcom/sc7180.dtsi    | 28
> ++++++++++++++++++++++++++++
> >  2 files changed, 33 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/qcom/sc7180-idp.dts
> b/arch/arm64/boot/dts/qcom/sc7180-idp.dts
> > index 189254f..b2ca143f 100644
> > --- a/arch/arm64/boot/dts/qcom/sc7180-idp.dts
> > +++ b/arch/arm64/boot/dts/qcom/sc7180-idp.dts
> > @@ -248,6 +248,11 @@
> >  	status =3D "okay";
> >  };
> >
> > +&wifi {
> > +	status =3D "okay";
> > +	qcom,msa_fixed_perm;
>=20
> What is the status of the patch adding this flag?

This patch is currently under review =
(https://patchwork.kernel.org/patch/11236535/)
It hasn=E2=80=99t been acked yet.

>=20
> > +};
> > +
> >  /* PINCTRL - additions to nodes defined in sc7180.dtsi */
> >
> >  &qup_i2c2_default {
> > diff --git a/arch/arm64/boot/dts/qcom/sc7180.dtsi
> b/arch/arm64/boot/dts/qcom/sc7180.dtsi
> > index 666e9b9..ce2d2a5 100644
> > --- a/arch/arm64/boot/dts/qcom/sc7180.dtsi
> > +++ b/arch/arm64/boot/dts/qcom/sc7180.dtsi
> > @@ -42,6 +42,12 @@
> >  			compatible =3D "qcom,cmd-db";
> >  			no-map;
> >  		};
> > +
> > +		wlan_fw_mem: memory@93900000 {
> > +			compatible =3D "removed-dma-pool";
> > +			no-map;
> > +			reg =3D <0 0x93900000 0 0x200000>;
> > +		};
> >  	};
> >
> >  	cpus {
> > @@ -1119,6 +1125,28 @@
> >  				#clock-cells =3D <1>;
> >  			};
> >  		};
> > +
> > +		wifi: wifi@18800000 {
> > +			status =3D "disabled";
>=20
> nit: the convention seems to be to add this at the end of the node,
> which IMO makes sense since most other fields provide more =
'interesting'
> information.

I will send out an updated patchset, moving "status=3Ddisabled" down

