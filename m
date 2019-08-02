Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14AF0C433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 08:51:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF5B8205F4
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 08:51:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="bhv7PrpZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404496AbfHBIv2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 04:51:28 -0400
Received: from mail.kmu-office.ch ([178.209.48.109]:44730 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731648AbfHBIv2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 04:51:28 -0400
Received: from webmail.kmu-office.ch (unknown [IPv6:2a02:418:6a02::a3])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id 397875C004F;
        Fri,  2 Aug 2019 10:51:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1564735885;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ViFlUbZIH2j98+ivvpISqsxLBF3nyNE80C/Y7Lye+Lo=;
        b=bhv7PrpZGNeJpxcSV8U7HrJBJjE+RstPAgkir7If8M/JOcUoCmodOqFKKwLPdU2CqGqmdA
        2p5XggEf7tQZAZAEAZAC9QuoYmX0x5VNWJbaKQA7/mkg7YkjzZqtPxzGSdCDuOdO+7/dWp
        gxQfUYOjUEL4NMo5yA0o/R+Y9A9+rC8=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Date:   Fri, 02 Aug 2019 10:51:25 +0200
From:   Stefan Agner <stefan@agner.ch>
To:     Philippe Schenker <philippe.schenker@toradex.com>
Cc:     festevam@gmail.com, s.hauer@pengutronix.de,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        kernel@pengutronix.de,
        Max Krummenacher <max.krummenacher@toradex.com>,
        mark.rutland@arm.com, devicetree@vger.kernel.org,
        michal.vokac@ysoft.com, shawnguo@kernel.org,
        Stefan Agner <stefan.agner@toradex.com>,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        linux-imx@nxp.com, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 07/20] ARM: dts: imx7-colibri: fix 1.8V/UHS support
In-Reply-To: <723f191c5893984c8fbe711163524dc7ebf09a5b.camel@toradex.com>
References: <20190731123750.25670-1-philippe.schenker@toradex.com>
 <20190731123750.25670-8-philippe.schenker@toradex.com>
 <CAOMZO5B5HnqpLrDjyGtqSQpVXmcoZuGLvCzKVUhwLb-_ZO_Xog@mail.gmail.com>
 <723f191c5893984c8fbe711163524dc7ebf09a5b.camel@toradex.com>
Message-ID: <de6bec64012876c07267024cd4b2d2d5@agner.ch>
X-Sender: stefan@agner.ch
User-Agent: Roundcube Webmail/1.3.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-07-31 16:52, Philippe Schenker wrote:
> On Wed, 2019-07-31 at 09:56 -0300, Fabio Estevam wrote:
>> On Wed, Jul 31, 2019 at 9:38 AM Philippe Schenker
>> <philippe.schenker@toradex.com> wrote:
>> > From: Stefan Agner <stefan.agner@toradex.com>
>> >
>> > Add pinmuxing and do not specify voltage restrictions in the
>> > module level device tree.
>>
>> It would be nice to explain the reason for doing this.
> 
> This commit is in preparation of another patch that didn't made into this
> patchset (downstream stuff in there). But I will do another patch on top that
> will use this patch here. That should anyway be in mainline.

I guess what Fabio meant here is explain this patch.

The commit message really could be improved, e.g.:

Add pinmuxing and do not specify voltage restrictions for the usdhc
instance
available on the modules edge connector. This allows to use SD-cards
with
higher transfer modes if supported by the carrier board.

--
Stefan

> 
> Philippe
> 
>>
>> > Signed-off-by: Stefan Agner <stefan.agner@toradex.com>
>> > Signed-off-by: Philippe Schenker <philippe.schenker@toradex.com>
>> > ---
>> >
>> > Changes in v2: None
>> >
>> >  arch/arm/boot/dts/imx7-colibri.dtsi | 23 ++++++++++++++++++++++-
>> >  1 file changed, 22 insertions(+), 1 deletion(-)
>> >
>> > diff --git a/arch/arm/boot/dts/imx7-colibri.dtsi b/arch/arm/boot/dts/imx7-
>> > colibri.dtsi
>> > index 16d1a1ed1aff..67f5e0c87fdc 100644
>> > --- a/arch/arm/boot/dts/imx7-colibri.dtsi
>> > +++ b/arch/arm/boot/dts/imx7-colibri.dtsi
>> > @@ -326,7 +326,6 @@
>> >  &usdhc1 {
>> >         pinctrl-names = "default";
>> >         pinctrl-0 = <&pinctrl_usdhc1 &pinctrl_cd_usdhc1>;
>> > -       no-1-8-v;
>> >         cd-gpios = <&gpio1 0 GPIO_ACTIVE_LOW>;
>> >         disable-wp;
>> >         vqmmc-supply = <&reg_LDO2>;
>> > @@ -671,6 +670,28 @@
>> >                 >;
>> >         };
>> >
>> > +       pinctrl_usdhc1_100mhz: usdhc1grp_100mhz {
>> > +               fsl,pins = <
>> > +                       MX7D_PAD_SD1_CMD__SD1_CMD       0x5a
>> > +                       MX7D_PAD_SD1_CLK__SD1_CLK       0x1a
>> > +                       MX7D_PAD_SD1_DATA0__SD1_DATA0   0x5a
>> > +                       MX7D_PAD_SD1_DATA1__SD1_DATA1   0x5a
>> > +                       MX7D_PAD_SD1_DATA2__SD1_DATA2   0x5a
>> > +                       MX7D_PAD_SD1_DATA3__SD1_DATA3   0x5a
>> > +               >;
>> > +       };
>> > +
>> > +       pinctrl_usdhc1_200mhz: usdhc1grp_200mhz {
>> > +               fsl,pins = <
>> > +                       MX7D_PAD_SD1_CMD__SD1_CMD       0x5b
>> > +                       MX7D_PAD_SD1_CLK__SD1_CLK       0x1b
>> > +                       MX7D_PAD_SD1_DATA0__SD1_DATA0   0x5b
>> > +                       MX7D_PAD_SD1_DATA1__SD1_DATA1   0x5b
>> > +                       MX7D_PAD_SD1_DATA2__SD1_DATA2   0x5b
>> > +                       MX7D_PAD_SD1_DATA3__SD1_DATA3   0x5b
>> > +               >;
>> > +       };
>>
>> You add the entries for 100MHz and 200MHz, but I don't see them being
>> referenced anywhere.
