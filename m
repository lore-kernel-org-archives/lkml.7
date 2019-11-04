Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1236BCA9ED2
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 01:21:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC34221D7C
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 01:21:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572830462;
	bh=HruCF1lEVR4Yi9ljTqDKuQaH4iqNuferBq6GJDj+boM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=NFCtP0+bdbxhZGfOsawKrv7PKfBgxXvAprVboD0xYsTh4u8PCmEYCA/ietLUTGZ6y
	 kGHDFeBVpLFbkxD+0RocwlpKuOMlxYAfSmMNRvdZ8wTQ5rHXAVoumIcb//H1QuzXXo
	 SnNyiXwHE7atS4D47Q3fWxHIeNub0Jt9VlDjn1hE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728690AbfKDBVB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Nov 2019 20:21:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:58354 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728290AbfKDBVB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Nov 2019 20:21:01 -0500
Received: from dragon (li1038-30.members.linode.com [45.33.96.30])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D25862190F;
        Mon,  4 Nov 2019 01:20:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572830460;
        bh=HruCF1lEVR4Yi9ljTqDKuQaH4iqNuferBq6GJDj+boM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ciEPjPArR92meJw1XkXoh0PGuTbdNq62vI9w1ewlhqH7lXAUfZKp7tvm62XbPTMtf
         fuhIZWnYYJXbeVLNAuZOYU4ukFG/ElgIQxAYLHldwAna/I3GB42W+Jgbtglzr/9aP7
         LezzUuYG54cDC5e29+5daHpUIb3lKboGGpPlqpCc=
Date:   Mon, 4 Nov 2019 09:20:35 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Marcel Ziswiler <marcel@ziswiler.com>
Cc:     Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        linux-kernel@vger.kernel.org, Stefan Agner <stefan@agner.ch>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        Rob Herring <robh+dt@kernel.org>, linux-imx@nxp.com,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 1/5] arm: dts: vf-colibri: fix typo in top-level
 module compatible
Message-ID: <20191104012034.GF24620@dragon>
References: <20191026090403.3057-1-marcel@ziswiler.com>
 <20191104011657.GE24620@dragon>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191104011657.GE24620@dragon>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 04, 2019 at 09:16:58AM +0800, Shawn Guo wrote:
> On Sat, Oct 26, 2019 at 11:03:59AM +0200, Marcel Ziswiler wrote:
> > From: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> > 
> > Fix typo in top-level module compatible.
> > 
> > Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> > 
> > ---
> > 
> > Changes in v2: New patch.
> > 
> >  arch/arm/boot/dts/vf500-colibri.dtsi | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/arch/arm/boot/dts/vf500-colibri.dtsi b/arch/arm/boot/dts/vf500-colibri.dtsi
> > index 237b0246fa84..92255f8893ce 100644
> > --- a/arch/arm/boot/dts/vf500-colibri.dtsi
> > +++ b/arch/arm/boot/dts/vf500-colibri.dtsi
> > @@ -44,7 +44,7 @@
> >  
> >  / {
> >  	model = "Toradex Colibri VF50 COM";
> > -	compatible = "toradex,vf610-colibri_vf50", "fsl,vf500";
> > +	compatible = "toradex,vf500-colibri_vf50", "fsl,vf500";
> 
> Do we need to update bindings doc for this?

Sorry. I should have read the whole series.

> 
> Also as a practise, we use 'ARM: ...' for arch/arm/ patches going through
> IMX tree.

I fixed it up and applied the series.

Shawn
