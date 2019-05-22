Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 960F9C072A4
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 08:30:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 691E4204EC
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 08:30:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558513834;
	bh=5S6RxRIhK7LmYwNwDZdpP3Oig4cYnbDSbf2KlMY3wr4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Y2DOjQwjC3mpBGYcUSiudtUYHdbkeYUCz8N6bjSL5pU+J7cQEM3nnwWKAbSB881JD
	 AWpC1EGKJliIvKxhiEoDnvhUyIGSOwuGk/5Gm4X9TowMQRRNgC1HWmyvb+QteG7JVF
	 G3FtVNV4Ag7gKr8gxFCyPc02fo/WAQFs9x7UyigI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728635AbfEVIad (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 04:30:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:50300 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726358AbfEVIad (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 04:30:33 -0400
Received: from dragon (98.142.130.235.16clouds.com [98.142.130.235])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 27B36204EC;
        Wed, 22 May 2019 08:30:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558513830;
        bh=5S6RxRIhK7LmYwNwDZdpP3Oig4cYnbDSbf2KlMY3wr4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kdqgrnyAVly1Pf4LmDAgDiXMnWSM9G9ZBsQjsDei2RBNUfNBcWLl4LI8ETBpaiBHr
         0GOuPlJ7s0PjrqHWgSp5a/7wp1j6Dao/8iRNfc8PxyK8a3AMNMtEInL08PDx/PgTqy
         0gKScf9utb5BwfoBnjqz/w6tERvpAEP+nE16r1RI=
Date:   Wed, 22 May 2019 16:29:31 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Joe Perches <joe@perches.com>
Cc:     Angus Ainslie <angus@akkea.ca>, angus.ainslie@puri.sm,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-kernel-owner@vger.kernel.org
Subject: Re: [PATCH v9 1/3] arm64: dts: fsl: librem5: Add a device tree for
 the Librem5 devkit
Message-ID: <20190522082929.GA9261@dragon>
References: <20190513145539.28174-1-angus@akkea.ca>
 <20190513145539.28174-2-angus@akkea.ca>
 <0f355f524122cb4dd6388431495a9d182e3ed9d6.camel@perches.com>
 <11c9a715ee0599e50359eb5ad5bd093e@www.akkea.ca>
 <a2a45d8f881d877027e2c32faf71c7a3f4897324.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a2a45d8f881d877027e2c32faf71c7a3f4897324.camel@perches.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 13, 2019 at 09:05:27AM -0700, Joe Perches wrote:
> On Mon, 2019-05-13 at 08:35 -0700, Angus Ainslie wrote:
> > Hi Joe,
> 
> Hi.
> 
> > On 2019-05-13 08:11, Joe Perches wrote:
> > > On Mon, 2019-05-13 at 07:55 -0700, Angus Ainslie (Purism) wrote:
> > > > This is for the development kit board for the Librem 5. The current 
> > > > level
> > > > of support yields a working console and is able to boot userspace from
> > > > the network or eMMC.
> > > []
> > > > diff --git a/arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts 
> > > > b/arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts
> > > > new file mode 100644
> > > 
> > > Perhaps add an entry in the MAINTAINERS file for this
> > > .dts file similar to other freescale boards?
> > 
> > The MAINTAINERS files has this entry
> > 
> > ARM/FREESCALE IMX / MXC ARM ARCHITECTURE
> > M:  Shawn Guo <shawnguo@kernel.org>
> > M:  Sascha Hauer <s.hauer@pengutronix.de>
> > R:  Pengutronix Kernel Team <kernel@pengutronix.de>
> > R:  Fabio Estevam <festevam@gmail.com>
> > R:  NXP Linux Team <linux-imx@nxp.com>
> > L:  linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
> > S:  Maintained
> > T:  git git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git
> > N:  imx
> > N:  mxs
> > X:  drivers/media/i2c/
> > 
> > Shouldn't the "N: imx" cover this board already ?
> 
> Yes, it would, but not 'exclusively' by the get_maintainer.pl
> script.

We moved to 'N' match with commit da8b7f0fb02b ("MAINTAINERS: add all
files matching "imx" and "mxs" to the IMX entry").  As long as
get_maintainer.pl reports those M/R/L addresses, we are fine, I think.

Shawn
