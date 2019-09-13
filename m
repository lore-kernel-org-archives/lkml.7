Return-Path: <SRS0=WcLH=XI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1099BC49ED7
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 08:38:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6AD9208C2
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 08:38:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387572AbfIMIil convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Sep 2019 04:38:41 -0400
Received: from mail.savoirfairelinux.com ([208.88.110.44]:44378 "EHLO
        mail.savoirfairelinux.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387424AbfIMIil (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 04:38:41 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.savoirfairelinux.com (Postfix) with ESMTP id 468379C01CF;
        Fri, 13 Sep 2019 04:38:40 -0400 (EDT)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
        by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 0tdnGDu6uDPD; Fri, 13 Sep 2019 04:38:39 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.savoirfairelinux.com (Postfix) with ESMTP id 5428B9C02B2;
        Fri, 13 Sep 2019 04:38:39 -0400 (EDT)
X-Virus-Scanned: amavisd-new at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
        by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 1nWHepbN-k1n; Fri, 13 Sep 2019 04:38:39 -0400 (EDT)
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [192.168.48.237])
        by mail.savoirfairelinux.com (Postfix) with ESMTP id 13DF59C01CF;
        Fri, 13 Sep 2019 04:38:39 -0400 (EDT)
Date:   Fri, 13 Sep 2019 04:38:39 -0400 (EDT)
From:   Gilles Doffe <gilles.doffe@savoirfairelinux.com>
To:     Marco Felsch <m.felsch@pengutronix.de>
Cc:     devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        mark rutland <mark.rutland@arm.com>,
        festevam <festevam@gmail.com>, s hauer <s.hauer@pengutronix.de>,
        rennes <rennes@savoirfairelinux.com>,
        robh+dt <robh+dt@kernel.org>, linux-imx <linux-imx@nxp.com>,
        kernel <kernel@pengutronix.de>,
        =?utf-8?Q?J=C3=A9rome?= Oufella 
        <jerome.oufella@savoirfairelinux.com>,
        shawnguo <shawnguo@kernel.org>
Message-ID: <415531537.7768114.1568363919015.JavaMail.zimbra@savoirfairelinux.com>
In-Reply-To: <20190912101240.ml5jmdei5rvzesap@pengutronix.de>
References: <20190719104615.5329-1-gilles.doffe@savoirfairelinux.com> <20190722075341.e4ve45rneusiogtk@pengutronix.de> <978100557.7721358.1568282514403.JavaMail.zimbra@savoirfairelinux.com> <20190912101240.ml5jmdei5rvzesap@pengutronix.de>
Subject: Re: [PATCH v2] arm: dts: imx6qdl: add gpio expander pca9535
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Mailer: Zimbra 8.8.11_GA_3737 (ZimbraWebClient - GC76 (Linux)/8.8.11_GA_3737)
Thread-Topic: imx6qdl: add gpio expander pca9535
Thread-Index: Zvv68XcE8nddO8z0uGME4oRHp/yuRA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marco,

Ack for all, v3 incoming.

Thank you,
Gilles

----- Le 12 Sep 19, à 12:12, Marco Felsch m.felsch@pengutronix.de a écrit :

> Hi Gilles,
> 
> On 19-09-12 06:01, Gilles Doffe wrote:
>> Hi Marco,
>> 
>> Thanks for your reply and sorry about the delay.
> 
> No worries ;)
> 
>> ----- Le 22 Juil 19, à 9:53, Marco Felsch m.felsch@pengutronix.de a écrit :
>> 
>> > Hi Gilles,
>> > 
>> > can you adapt the patch title, I assumed that the base dtsi is adding a
>> > gpio-expander which makes no sense.
>> 
>> My first intent was to add the gpio-expander pca9535 into the imx6q-rex-pro.dts
>> and in a future imx6qp-rex-ultra.dts
>> However I noticed that the sgtl5000 was already in the dtsi.
>> It is maybe due to the fact that like the pca9535, the sgtl5000 is present on
>> the baseboard not on the SOM.
>> Thus I guess that baseboard stuff common to all rex SOM should be in
>> imx6qdl-rex.dtsi and not in the dts.
>> Does-it seem correct to you ?
> 
> Yes this is correct what Shawn and I mean is that you should adapt the
> commit title. Shawn already give you an example.
> 
>> > 
>> > On 19-07-19 12:46, Gilles DOFFE wrote:
>> >> The pca9535 gpio expander is present on the Rex baseboard, but missing
>> >> from the dtsi.
>> >> 
>> >> Add the new gpio controller and the associated interrupt line
>> >> MX6QDL_PAD_NANDF_CS3__GPIO6_IO16.
>> >> 
>> >> Signed-off-by: Gilles DOFFE <gilles.doffe@savoirfairelinux.com>
>> >> ---
>> > 
>> > Having a changelog would be nice too.
>> > 
>> >>  arch/arm/boot/dts/imx6qdl-rex.dtsi | 19 +++++++++++++++++++
>> >>  1 file changed, 19 insertions(+)
>> >> 
>> >> diff --git a/arch/arm/boot/dts/imx6qdl-rex.dtsi
>> >> b/arch/arm/boot/dts/imx6qdl-rex.dtsi
>> >> index 97f1659144ea..b517efb22fcb 100644
>> >> --- a/arch/arm/boot/dts/imx6qdl-rex.dtsi
>> >> +++ b/arch/arm/boot/dts/imx6qdl-rex.dtsi
>> >> @@ -136,6 +136,19 @@
>> >>  		compatible = "atmel,24c02";
>> >>  		reg = <0x57>;
>> >>  	};
>> >> +
>> >> +	pca9535: gpio8@27 {
>> >> +		compatible = "nxp,pca9535";
>> >> +		reg = <0x27>;
>> > 
>> > The i2c devices are orderd by their i2c-addresses starting from the
>> > lowest.
>> >
>> 
>> Ack.
>> 
>> >> +		gpio-controller;
>> >> +		#gpio-cells = <2>;
>> >> +		pinctrl-names = "default";
>> >> +		pinctrl-0 = <&pinctrl_pca9535>;
>> >> +		interrupt-parent = <&gpio6>;
>> >> +		interrupts = <16 IRQ_TYPE_LEVEL_LOW>;
>> >> +		interrupt-controller;
>> >> +		#interrupt-cells = <2>;
> 
> As you pointed out above this device isn't available on the
> imx6dl-rex-basic? You should add: 'status = "disabled";' if this is the
> case.
> 
> Regards,
>  Marco
> 
>> >> +	};
>> >>  };
>> >>  
>> >>  &i2c3 {
>> >> @@ -237,6 +250,12 @@
>> >>  			>;
>> >>  		};
>> >>  
>> >> +		pinctrl_pca9535: pca9535 {
>> >> +			fsl,pins = <
>> >> +				MX6QDL_PAD_NANDF_CS3__GPIO6_IO16	0x00017059
>> > 
>> > The pinmux below don't use the leading zero's if you are the first I
>> > would drop that.
>> > 
>> > Regards,
>> >  Marco
>> >
>> 
>> Ack.
>> 
>> Regards,
>> Gilles
>> 
> 
> --
> Pengutronix e.K.                           |                             |
> Industrial Linux Solutions                 | http://www.pengutronix.de/  |
> Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
> Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

-- 
Gilles DOFFE 
Senior Product Engineering Consultant | Rennes, Fr 
Bureau 
[ tel:+33972468980 | (+33) 9 72 46 89 80 ] p. : 601 
Cellulaire 
[ tel:+33660025866 | (+33) 6 60 02 58 66 ]
