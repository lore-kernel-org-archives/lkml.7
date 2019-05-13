Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E289C04AA7
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 16:05:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AA5F2084E
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 16:05:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731196AbfEMQFe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 12:05:34 -0400
Received: from smtprelay0192.hostedemail.com ([216.40.44.192]:39066 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730269AbfEMQFd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 12:05:33 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id D35CA180A8CCE;
        Mon, 13 May 2019 16:05:31 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: band11_4ce277087f652
X-Filterd-Recvd-Size: 3941
Received: from XPS-9350.home (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf14.hostedemail.com (Postfix) with ESMTPA;
        Mon, 13 May 2019 16:05:28 +0000 (UTC)
Message-ID: <a2a45d8f881d877027e2c32faf71c7a3f4897324.camel@perches.com>
Subject: Re: [PATCH v9 1/3] arm64: dts: fsl: librem5: Add a device tree for
 the Librem5 devkit
From:   Joe Perches <joe@perches.com>
To:     Angus Ainslie <angus@akkea.ca>
Cc:     angus.ainslie@puri.sm, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-kernel-owner@vger.kernel.org
Date:   Mon, 13 May 2019 09:05:27 -0700
In-Reply-To: <11c9a715ee0599e50359eb5ad5bd093e@www.akkea.ca>
References: <20190513145539.28174-1-angus@akkea.ca>
         <20190513145539.28174-2-angus@akkea.ca>
         <0f355f524122cb4dd6388431495a9d182e3ed9d6.camel@perches.com>
         <11c9a715ee0599e50359eb5ad5bd093e@www.akkea.ca>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-05-13 at 08:35 -0700, Angus Ainslie wrote:
> Hi Joe,

Hi.

> On 2019-05-13 08:11, Joe Perches wrote:
> > On Mon, 2019-05-13 at 07:55 -0700, Angus Ainslie (Purism) wrote:
> > > This is for the development kit board for the Librem 5. The current 
> > > level
> > > of support yields a working console and is able to boot userspace from
> > > the network or eMMC.
> > []
> > > diff --git a/arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts 
> > > b/arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts
> > > new file mode 100644
> > 
> > Perhaps add an entry in the MAINTAINERS file for this
> > .dts file similar to other freescale boards?
> 
> The MAINTAINERS files has this entry
> 
> ARM/FREESCALE IMX / MXC ARM ARCHITECTURE
> M:  Shawn Guo <shawnguo@kernel.org>
> M:  Sascha Hauer <s.hauer@pengutronix.de>
> R:  Pengutronix Kernel Team <kernel@pengutronix.de>
> R:  Fabio Estevam <festevam@gmail.com>
> R:  NXP Linux Team <linux-imx@nxp.com>
> L:  linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
> S:  Maintained
> T:  git git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git
> N:  imx
> N:  mxs
> X:  drivers/media/i2c/
> 
> Shouldn't the "N: imx" cover this board already ?

Yes, it would, but not 'exclusively' by the get_maintainer.pl
script.

> Maybe I misunderstood, are you suggesting I add an new entry for "F: 
> arch/arm64/boot/dts/freescale/*" ?

I don't believe an F: arch/arm64/boot/dts/freescale/*
pattern would be appropriate as there is already another
section with this path as a pattern.

ARM/FREESCALE LAYERSCAPE ARM ARCHITECTURE
M:	Shawn Guo <shawnguo@kernel.org>
M:	Li Yang <leoyang.li@nxp.com>
L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
S:	Maintained
T:	git git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git
F:	arch/arm/boot/dts/ls1021a*
F:	arch/arm64/boot/dts/freescale/fsl-*
F:	arch/arm64/boot/dts/freescale/qoriq-*

I suggest perhaps just adding a more specific entry of

F:	arch/arm64/boot/dts/freescale/imx*

And just FYI:

F: entries should be preferred over N: entries as
filename collisions with other regex matches are common.

Controlling the mismatches as was done with the X: exclusion
for drivers/media/i2c/ may not scale if another filename
is added into the kernel tree that is not maintained by you
that matches either of the imx or mxs pattern.

It's not really a significant issue though you may get a few
patches for files you don't care about at some point.

cheers, Joe

