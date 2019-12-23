Return-Path: <SRS0=RKSG=2N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A9C4C2D0D4
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 07:18:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BB1520709
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 07:18:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577085511;
	bh=+xZCTXHEyRCDiG9GABKQf4z73/JeJ/82+LVQggHUV4Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=QQi79X0/F6SX/9njbKE5dOBv/2rTTd9375LiHhIrRTq3i9uZTB81scGGBsFRpqYDo
	 uCsiurF7ERIP16SOKyCjoB553CeL1giQayCs95X4XDaDVE9KW1UAH3WD+wWGV5VwC7
	 ebzoKzTXWz5oxcoJ4WbnVPRAXo3+Bg8PF+pERJno=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726243AbfLWHSa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Dec 2019 02:18:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:43326 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725810AbfLWHS3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Dec 2019 02:18:29 -0500
Received: from dragon (98.142.130.235.16clouds.com [98.142.130.235])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1B42F206B7;
        Mon, 23 Dec 2019 07:18:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577085508;
        bh=+xZCTXHEyRCDiG9GABKQf4z73/JeJ/82+LVQggHUV4Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NO7thX31ekyQ86+u0f0xQWbM16nK8c6pi9PpYNibBKFHJIcPkv4M9Sn8Gb0O/uRBn
         NgfY/xCASxjNaTxG0Wdl8/peWyKvIMYSU8m/BuYobLWssYsWugMTf3D21TtmTG++dB
         PGNRVlb/DtbVX4700KGjyGjrEiRQU3mWz1QDglN8=
Date:   Mon, 23 Dec 2019 15:18:06 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Martin Kepplinger <martin.kepplinger@puri.sm>
Cc:     robh@kernel.org, mark.rutland@arm.com, kernel@pengutronix.de,
        linux-imx@nxp.com, kernel@puri.sm, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: imx8mq-librem5-devkit: add accelerometer and
 gyro sensor
Message-ID: <20191223071805.GR11523@dragon>
References: <20191203130336.18763-1-martin.kepplinger@puri.sm>
 <f8b4710b-4430-a42f-d29a-8f2f4d22b46e@puri.sm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f8b4710b-4430-a42f-d29a-8f2f4d22b46e@puri.sm>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 16, 2019 at 10:32:15AM +0100, Martin Kepplinger wrote:
> On 03.12.19 14:03, Martin Kepplinger wrote:
> > Now that there is driver support, describe the accel and gyro sensor parts
> > of the LSM9DS1 IMU.
> > 
> > Signed-off-by: Martin Kepplinger <martin.kepplinger@puri.sm>
> > ---
> >  arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts | 7 +++++++
> >  1 file changed, 7 insertions(+)
> > 
> > diff --git a/arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts b/arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts
> > index 683a11035643..7a92704c53ec 100644
> > --- a/arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts
> > +++ b/arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts
> > @@ -415,6 +415,13 @@
> >  	pinctrl-0 = <&pinctrl_i2c3>;
> >  	status = "okay";
> >  
> > +	accel_gyro@6a {

We prefer to use hyphen than underscore in node name.  Also nodes with
unit-address should be sorted in the address.

Shawn

> > +		compatible = "st,lsm9ds1-imu";
> > +		reg = <0x6a>;
> > +		vdd-supply = <&reg_3v3_p>;
> > +		vddio-supply = <&reg_3v3_p>;
> > +	};
> > +
> >  	magnetometer@1e	{
> >  		compatible = "st,lsm9ds1-magn";
> >  		reg = <0x1e>;
> > 
> 
> (adding / fixing people in CC)
> 
> Are there any questions about this addition or the followup fix?
> 
> thanks a lot,
> 
>                                martin
