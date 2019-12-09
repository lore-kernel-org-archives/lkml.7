Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB9E6C04E30
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 16:53:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85A66207FF
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 16:53:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575910398;
	bh=k3WgWl5UbXv5MieBdR01WsYTXtWFKoGPrB4Yk7jToYk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=FG1/wm+rim6YVb4Rg93bQ+D4u7sT08f8jjKrB5ZjiJJap3XOmGfGAGrLwE9GKNwWD
	 g6QhyioAbGUPzK6/TyUM45Gt/mKLFwTh9kSesdW0aMbBlIW7pLzU/tnik09r4pQfkp
	 sSXhk9A8dIr3IuM4booyJTuInrVeCHwDfmE0D4fc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726720AbfLIQxR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 11:53:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:43140 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725904AbfLIQxR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 11:53:17 -0500
Received: from localhost (lfbn-1-10718-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4A012207FD;
        Mon,  9 Dec 2019 16:53:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575910396;
        bh=k3WgWl5UbXv5MieBdR01WsYTXtWFKoGPrB4Yk7jToYk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kcq2/sSYcppBI8w2mxwBtMccK3ngl1WPRnkKmwdW/ZNj+vNMsr4mlmrcD5kWFhsVD
         tgixkVrldVEmGq7NE1u1XEAcOAxFVrxzQHXfJ+Zo1Oq3LRhM6DZSJq0YcntMBv2ufG
         hJMIrkWRlmrK3sD/SfqwRCLVOjmNvxT5iCZByjkE=
Date:   Mon, 9 Dec 2019 17:53:14 +0100
From:   Maxime Ripard <mripard@kernel.org>
To:     =?utf-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Cc:     Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] arm64: dts: allwinner: Convert to new-style SPDX license
 identifiers
Message-ID: <20191209165314.mostdak54qgo2r3y@gilmour.lan>
References: <20191123132435.22093-1-peron.clem@gmail.com>
 <20191128174204.tbr5ldilkadw42gc@gilmour.lan>
 <CAJiuCccY7AFsd22bOxKZW=BAne5YEG0vmnVmUNFamU9cpW_vNA@mail.gmail.com>
 <20191202191205.2izimptezz5rf5kp@gilmour.lan>
 <CAJiuCcdKi9vedvCWz1BvCS8B0h9rEX1oafZzdok9noFsnvg1NA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAJiuCcdKi9vedvCWz1BvCS8B0h9rEX1oafZzdok9noFsnvg1NA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 02, 2019 at 08:45:44PM +0100, Cl=E9ment P=E9ron wrote:
> > > > > diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.=
dts b/arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts
> > > > > index f335f7482a73..84b7e9936300 100644
> > > > > --- a/arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts
> > > > > +++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts
> > > > > @@ -1,4 +1,4 @@
> > > > > -// SPDX-License-Identifier: (GPL-2.0+ or MIT)
> > > > > +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> > > > >  /*
> > > > >   * Copyright (C) 2019 Cl=E9ment P=E9ron <peron.clem@gmail.com>
> > > > >   */
> > > >
> > > > And I'm not sure what this one (and the next) is?
> > >
> > > The license expressions in dual licensed files is wrong here, "OR"
> > > should be uppercase.
> > > I can move it to a separate commit if you like.
> >
>
> > Ah, right, indeed, this should be in a separate patch.
> So how many patch do you recommend here ?
>
> 1 for the or -> OR style fix.
> 1 to change to SPDX.
> and 1 to use the same // style everywhere ?

Yep :)

Maxime
