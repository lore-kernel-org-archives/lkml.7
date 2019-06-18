Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECA07C31E51
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 06:47:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4747205F4
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 06:47:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560840451;
	bh=VejpOgqd5R4dMXfFuMAOUrMQQHjjtWsjAe1WJUq7tzE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Rk80VnWGSt7m/dZTCJ4CGmtg5fyXqMpZY3dVmr+PqAeNY/ncuahq/ym2K8plMJvNc
	 FinALprclm99YOE4ecaeSh/L7hUEL6tBfSvgqZTicFcuBtRjqJdYURMGNX3ComOtUP
	 q/xCFDA/eyeMkUFyk0IRyNs8r0dIvuZzys8u87Ug=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728701AbfFRGr0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 02:47:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:53896 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726238AbfFRGrX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 02:47:23 -0400
Received: from dragon (li1322-146.members.linode.com [45.79.223.146])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0ADC12166E;
        Tue, 18 Jun 2019 06:32:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560839527;
        bh=VejpOgqd5R4dMXfFuMAOUrMQQHjjtWsjAe1WJUq7tzE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=o9lgizXWTgD+9aai+vLwwtARXKwM5HOKlNCOCmCgEGt+S9gFyV6yEFZLYmjT86xhI
         /Z/8CMZTqodJdtW30kwJFw7O8SG2nwR+YGgHikRJ9kOOCMTCd5otlbTQNPzk+NT++Q
         fc070xBZggbbSzDwsPwfeBHXhp0RsTxetBmdRJ98=
Date:   Tue, 18 Jun 2019 14:31:16 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Leo Li <leoyang.li@nxp.com>
Cc:     Madalin-cristian Bucur <madalin.bucur@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Vinod Koul <vkoul@kernel.org>,
        Grant Likely <grant.likely@arm.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        lkml <linux-kernel@vger.kernel.org>,
        "wsa@the-dreams.de" <wsa@the-dreams.de>
Subject: Re: [PATCH] arm64: defconfig: Enable FSL_EDMA driver
Message-ID: <20190618063114.GA29468@dragon>
References: <20190422183056.16375-1-leoyang.li@nxp.com>
 <20190510030525.GC15856@dragon>
 <CADRPPNT2G20j2pvSEyqX=_WNDPrcNR+xCR_XZukbnSW19wFLNA@mail.gmail.com>
 <20190613004508.GA20747@dragon>
 <VE1PR04MB6687EE0E22DA0697A0A7038F8FEF0@VE1PR04MB6687.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <VE1PR04MB6687EE0E22DA0697A0A7038F8FEF0@VE1PR04MB6687.eurprd04.prod.outlook.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 13, 2019 at 02:01:11PM +0000, Leo Li wrote:
> 
> 
> > -----Original Message-----
> > From: Shawn Guo <shawnguo@kernel.org>
> > Sent: Wednesday, June 12, 2019 7:45 PM
> > To: Leo Li <leoyang.li@nxp.com>
> > Cc: Madalin-cristian Bucur <madalin.bucur@nxp.com>; Rob Herring
> > <robh+dt@kernel.org>; Aisheng Dong <aisheng.dong@nxp.com>; Vinod Koul
> > <vkoul@kernel.org>; Grant Likely <grant.likely@arm.com>; moderated
> > list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE <linux-arm-
> > kernel@lists.infradead.org>; lkml <linux-kernel@vger.kernel.org>
> > Subject: Re: [PATCH] arm64: defconfig: Enable FSL_EDMA driver
> > 
> > On Wed, Jun 12, 2019 at 03:01:29PM -0500, Li Yang wrote:
> > > On Thu, May 9, 2019 at 10:15 PM Shawn Guo <shawnguo@kernel.org>
> > wrote:
> > > >
> > > > On Mon, Apr 22, 2019 at 01:30:56PM -0500, Li Yang wrote:
> > > > > Enables the FSL EDMA driver by default.  This also works around an
> > > > > issue that imx-i2c driver keeps deferring the probe because of the
> > > > > DMA is not ready.  And currently the DMA engine framework can not
> > > > > correctly tell if the DMA channels will truly become available
> > > > > later (it will never be available if the DMA driver is not enabled).
> > > > >
> > > > > This will cause indefinite messages like below:
> > > > > [    3.335829] imx-i2c 2180000.i2c: can't get pinctrl, bus recovery not
> > supported
> > > > > [    3.344455] ina2xx 0-0040: power monitor ina220 (Rshunt = 1000
> > uOhm)
> > > > > [    3.350917] lm90 0-004c: 0-004c supply vcc not found, using dummy
> > regulator
> > > > > [    3.362089] imx-i2c 2180000.i2c: can't get pinctrl, bus recovery not
> > supported
> > > > > [    3.370741] ina2xx 0-0040: power monitor ina220 (Rshunt = 1000
> > uOhm)
> > > > > [    3.377205] lm90 0-004c: 0-004c supply vcc not found, using dummy
> > regulator
> > > > > [    3.388455] imx-i2c 2180000.i2c: can't get pinctrl, bus recovery not
> > supported
> > > > > .....
> > > > >
> > > > > Signed-off-by: Li Yang <leoyang.li@nxp.com>
> > > >
> > > > Applied, thanks.
> > >
> > > Hi Shawn,
> > >
> > > Is it possible to move this patch to the -fix series so that it can
> > > reach the mainline earlier?  It is having a boot failure in mainline
> > > for platforms using this device without this workaround.
> > 
> > Why would I2C device deferring cause boot failure on a platform?  I'm just
> > trying to understand severity of the problem.
> 
> Currently the probe of imx-i2c will be retried immediately after it is deferred when the optional dependency on DMA driver is not met.  This will cause an indefinite loop of probe-defer-probe and keep printing the message as shown in the commit message.
> 

Indefinite loop of probe-defer-probe is not a boot failure to me.  But I
will try to send it as fix, and see if arm-soc folk will take it.

Shawn
