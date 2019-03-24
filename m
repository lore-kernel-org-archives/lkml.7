Return-Path: <SRS0=2kAr=R3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22801C10F00
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 12:01:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3D3E222D6
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 12:01:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553428910;
	bh=qErxrAmqSaxiuqF6E1wBrvr336HeuYhicO0wUOifk1M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=JQTZKS9Iw8EBFdlp6rFQIc0FT+oi99f/Al7SwHriWrp/QgZ0S/j33hw5Hf3jYqBIC
	 EnBCke1nDv7MYQWDodw8I8Fco9G00KXJndObICAXZhfEpxtzL6F4QlYlQj1Jbi/yUv
	 s9YE6Y4nk5/UhQpMqharxd3wDLiyDY0WFZ4QVxMU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728268AbfCXMBs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Mar 2019 08:01:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:44458 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726160AbfCXMBs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Mar 2019 08:01:48 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B97F9222D1;
        Sun, 24 Mar 2019 12:01:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553428907;
        bh=qErxrAmqSaxiuqF6E1wBrvr336HeuYhicO0wUOifk1M=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=nA1iHzPcrBx2Serb/GNcRgfoTT+R6oHlBDHyk7IC48hxXC6+do/pdeGohSYyaVO0J
         2RNDq19OmrcWZ+UDftvKN46CeO1nONyBt6/zA72Oct36EKzn/jTdB+ScIjy6IXrtNI
         IWC7zuAFdPIHULT6t4gCr6i8AUuUnuqy3sXrqGF0=
Date:   Sun, 24 Mar 2019 12:01:39 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andreas Klinger <ak@it-klinger.de>
Cc:     devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com, afaerber@suse.de,
        arnd@arndb.de, davem@davemloft.net, gregkh@linuxfoundation.org,
        johan@kernel.org, khilman@baylibre.com, knaack.h@gmx.de,
        lars@metafoo.de, linux-kernel@vger.kernel.org,
        martin.blumenstingl@googlemail.com, mchehab+samsung@kernel.org,
        m.othacehe@gmail.com, nicolas.ferre@microchip.com,
        pmeerw@pmeerw.net, robh@kernel.org, songqiang1304521@gmail.com,
        treding@nvidia.com, techsupport@maxbotix.com
Subject: Re: [PATCH v3 1/4] dt-bindings: Add vendor prefix for MaxBotix
Message-ID: <20190324120139.573814dc@archlinux>
In-Reply-To: <20190317203458.bgculdjvtt44zkch@arbad>
References: <20190317203458.bgculdjvtt44zkch@arbad>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 17 Mar 2019 21:35:00 +0100
Andreas Klinger <ak@it-klinger.de> wrote:

> Add MaxBotix, which is a vendor of ultrasonic rangers in different
> varieties and interfaces.
>=20
> Signed-off-by: Andreas Klinger <ak@it-klinger.de>
> Reviewed-by: Andreas F=C3=A4rber <afaerber@suse.de>
> Reviewed-by: Rob Herring <robh@kernel.org>
Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to play with it.

Thanks,

Jonathan

> ---
>  Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Docu=
mentation/devicetree/bindings/vendor-prefixes.txt
> index 389508584f48..added54a1108 100644
> --- a/Documentation/devicetree/bindings/vendor-prefixes.txt
> +++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
> @@ -225,6 +225,7 @@ lsi	LSI Corp. (LSI Logic)
>  lwn	Liebherr-Werk Nenzing GmbH
>  macnica	Macnica Americas
>  marvell	Marvell Technology Group Ltd.
> +maxbotix	MaxBotix Inc.
>  maxim	Maxim Integrated Products
>  mbvl	Mobiveil Inc.
>  mcube	mCube

