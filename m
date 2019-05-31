Return-Path: <SRS0=bMiL=T7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7389EC04AB6
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 07:30:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 434632650C
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 07:30:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559287800;
	bh=Sx1m5/E8D/5A8KuMvDlpJkX5r56naO8qUsBat8C+qgk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=HOWrQjA0wpV7IT3fguvwWlIHWZfM6j+Wb4kd4k27o7X0xlcEZqByJvqPVNrRsgKgg
	 WrD3WtmJHchuhI3K0HM5aFWo+7Gfmm37TJp9P1iRdwQq7vRdBlXyvARqH87KyKHys2
	 fuMAt/Lts7Fc9dfS5eTE0hGwcsjFonn28CPVCl7w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726877AbfEaH37 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 May 2019 03:29:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:42208 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725955AbfEaH36 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 May 2019 03:29:58 -0400
Received: from dragon (98.142.130.235.16clouds.com [98.142.130.235])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E55FA264E7;
        Fri, 31 May 2019 07:29:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559287798;
        bh=Sx1m5/E8D/5A8KuMvDlpJkX5r56naO8qUsBat8C+qgk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mTrEKnP3igGNFyinU5WlegALoxSzHevTxDMhvJML01Fxvds9diY9kGh0ptqTEVba6
         jZt+kT6htNw5fnBs9nk4d0FTlH5KiAWoPM3Y6WcCd31Ggzsfzo/Mgb3lVBrxVqA5jx
         jhOcrry6DTnI5nrlsGw61OpHny4D+zMtZFL6SIw8=
Date:   Fri, 31 May 2019 15:28:33 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Daniel Baluta <daniel.baluta@gmail.com>
Cc:     Fabio Estevam <festevam@gmail.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Anson Huang <anson.huang@nxp.com>,
        "S.j. Wang" <shengjiu.wang@nxp.com>, Peng Fan <peng.fan@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "m.felsch@pengutronix.de" <m.felsch@pengutronix.de>
Subject: Re: [PATCH v3 2/2] arm64: dts: imx8mm-evk: Enable audio codec wm8524
Message-ID: <20190531072832.GC23453@dragon>
References: <20190515144210.25596-1-daniel.baluta@nxp.com>
 <20190515144210.25596-3-daniel.baluta@nxp.com>
 <CAOMZO5A6Gv5k3up0AtKrhQPyMLMe_8SXift68KEP2J+j8D_cJg@mail.gmail.com>
 <CAOMZO5BTqwnun6d7G1vcHUu_Rs+xfvgxTzamWnBPy76W7eeF_A@mail.gmail.com>
 <CAEnQRZD98TKduVLshGrBANRB6NT7Se6CXD0cgd5XRYa6grAo4Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEnQRZD98TKduVLshGrBANRB6NT7Se6CXD0cgd5XRYa6grAo4Q@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 28, 2019 at 10:10:43AM +0300, Daniel Baluta wrote:
> On Mon, May 20, 2019 at 10:33 PM Fabio Estevam <festevam@gmail.com> wrote:
> >
> > On Thu, May 16, 2019 at 3:35 PM Fabio Estevam <festevam@gmail.com> wrote:
> > >
> > > On Wed, May 15, 2019 at 11:42 AM Daniel Baluta <daniel.baluta@nxp.com> wrote:
> > >
> > > > +               simple-audio-card,codec {
> > > > +                       sound-dai = <&wm8524>;
> > > > +                       clocks = <&clk IMX8MM_CLK_SAI3_ROOT>;
> > >
> > > IMX8MM_CLK_SAI3_ROOT is the internal clock that drives the SAI3
> > > interface, not an external clock that feeds the codec.
> > >
> > > It seems you should remove this 'clocks' entry.
> >
> > Just checked the schematics and the SAI3_MCLK pin clocks the codec, so
> > the representation is correct:
> >
> > Reviewed-by: Fabio Estevam <festevam@gmail.com>
> 
> Shawn,
> 
> Can you have a look?

I cannot apply this one, because there are '=20' in the patch content.

Shawn
