Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2531C4360C
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 05:31:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDDAD20B7C
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 05:31:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="Iirjc6Ue"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732814AbfJJFbu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 01:31:50 -0400
Received: from mail.andi.de1.cc ([85.214.55.253]:43678 "EHLO mail.andi.de1.cc"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726065AbfJJFbu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 01:31:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20180802; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=XeuI5MFAYgl9UB+btYOjqdBCVNCwwywBGKPVGC8hSLM=; b=Iirjc6UetbEOoDwIi/1ND3/1pc
        f2Unf42Nl35GLD7oTlmfwvvci1/NxbR6QxE6kSz6nNXsVxE6c/tS1PZe+wwPwYTbxKAZqcoOiJitP
        kWTPW23fWQmeiG1xoozjRkOxJnB0o8VQOHwe+qIdZ6YrTvi6RmeQZ7TfETPokmaZP568=;
Received: from ip-109-41-65-123.web.vodafone.de ([109.41.65.123] helo=localhost)
        by mail.andi.de1.cc with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1iIR33-0002Aa-Vm; Thu, 10 Oct 2019 07:31:38 +0200
Received: from localhost ([::1])
        by localhost with esmtp (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1iIR31-0004zE-5i; Thu, 10 Oct 2019 07:31:35 +0200
Date:   Thu, 10 Oct 2019 07:31:29 +0200
From:   Andreas Kemnade <andreas@kemnade.info>
To:     Jonathan =?ISO-8859-1?Q?Neusch=E4fer?= <j.neuschaefer@gmx.net>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, manivannan.sadhasivam@linaro.org,
        andrew.smirnov@gmail.com, marex@denx.de, angus@akkea.ca,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Discussions about the Letux Kernel 
        <letux-kernel@openphoenux.org>,
        Marco Felsch <m.felsch@pengutronix.de>
Subject: Re: [PATCH v2 2/3] ARM: dts: add Netronix E60K02 board common file
Message-ID: <20191010073129.607f7b6f@kemnade.info>
In-Reply-To: <20191006223848.GE19803@latitude>
References: <20190930194332.12246-1-andreas@kemnade.info>
        <20190930194332.12246-3-andreas@kemnade.info>
        <20191006223848.GE19803@latitude>
X-Mailer: Claws Mail 3.14.1 (GTK+ 2.24.31; i686-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jonathan,

On Mon, 7 Oct 2019 00:38:48 +0200
Jonathan Neusch=E4fer <j.neuschaefer@gmx.net> wrote:

> Thanks for CCing me on this patchset. Nice to see more e-book reader
> related work!
>=20
btw. seems that we have a common target, since our ebook readers both
have a tps65185. It seems to be a good idea to comment things on the
i2c busses without proper bindings. That might help to find allies.

I will send a v3 with correct memory, better name for GLED
and the above-mentioned comments.

Regards,
Andreas

> A few comments and questions below.
>=20
> On Mon, Sep 30, 2019 at 09:43:31PM +0200, Andreas Kemnade wrote:
> > The Netronix board E60K02 can be found some several Ebook-Readers,
> > at least the Kobo Clara HD and the Tolino Shine 3. The board
> > is equipped with different SoCs requiring different pinmuxes. =20
>=20
> Do I understand it correctly that i.MX6SL and i.MX6SLL are pin-
> compatible so we can use the same pin numbers and GPIO handles in the
> DT?
>=20
> > +	leds {
> > +		compatible =3D "gpio-leds";
> > +		pinctrl-names =3D "default";
> > +		pinctrl-0 =3D <&pinctrl_led>;
> > +
> > +		GLED { =20
>=20
> What does "GLED" mean? It's not obvious to me.
> What user-visible purpose does this LED have, or where is it on the
> board?
>=20
> > +			gpios =3D <&gpio5 7 GPIO_ACTIVE_LOW>;
> > +			linux,default-trigger =3D "timer";
> > +		};
> > +	};
> > +
> > +	memory {
> > +		reg =3D <0x80000000 0x80000000>; =20
>=20
> 2 GiB of memory?
>=20
> > +			/* Core3_3V3 */ =20
>=20
> What are these labels (Core3_3V3, Core4_1V2, etc.)?
>=20
> > +			dcdc2_reg: DCDC2 {
> > +				regulator-name =3D "DCDC2";
> > +				regulator-always-on;
> > +				regulator-boot-on;
> > +				regulator-state-mem {
> > +					regulator-on-in-suspend;
> > +					regulator-suspend-max-microvolt =3D <3300000>;
> > +					regulator-suspend-min-microvolt =3D <3300000>;
> > +				};
> > +			}; =20
>=20
>=20
> Thanks,
> Jonathan Neusch=E4fer
