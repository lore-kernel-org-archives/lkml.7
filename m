Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59973C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 17:57:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38338213A2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 17:57:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726927AbfCMR52 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 13:57:28 -0400
Received: from honk.sigxcpu.org ([24.134.29.49]:49174 "EHLO honk.sigxcpu.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726255AbfCMR51 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 13:57:27 -0400
Received: from localhost (localhost [127.0.0.1])
        by honk.sigxcpu.org (Postfix) with ESMTP id 47A45FB03;
        Wed, 13 Mar 2019 18:57:25 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at honk.sigxcpu.org
Received: from honk.sigxcpu.org ([127.0.0.1])
        by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id L-Z2SQhpN7Rt; Wed, 13 Mar 2019 18:57:23 +0100 (CET)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
        id 90A6A46646; Wed, 13 Mar 2019 18:57:22 +0100 (CET)
Date:   Wed, 13 Mar 2019 18:57:22 +0100
From:   Guido =?iso-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>
To:     Angus Ainslie <angus@akkea.ca>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Fabio Estevam <festevam@gmail.com>, kernel@pengutronix.de,
        Lucas Stach <l.stach@pengutronix.de>, abel.vesa@nxp.com,
        daniel.baluta@nxp.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] arm64: dts: fsl: librem5: Add a device tree for the
 Librem5 devkit
Message-ID: <20190313175722.GA2525@bogon.m.sigxcpu.org>
References: <20190311234655.30357-1-angus@akkea.ca>
 <20190311234655.30357-2-angus@akkea.ca>
 <20190312175935.GA2487@bogon.m.sigxcpu.org>
 <6f0337062d6652a4f05062b33f3393bb@www.akkea.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6f0337062d6652a4f05062b33f3393bb@www.akkea.ca>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
On Tue, Mar 12, 2019 at 11:59:10AM -0700, Angus Ainslie wrote:
> On 2019-03-12 10:59, Guido Günther wrote:
> > Hi,
> > On Mon, Mar 11, 2019 at 04:46:53PM -0700, Angus Ainslie (Purism) wrote:
> > > This is the development kit for the Librem 5. The current level of
> > > support
> > > yields a working console and is able to boot userspace from the
> > > network
> > > or eMMC.
> > > 
> > > Additional subsystems that are active :
> > > 
> > > - Both USB ports
> > > - SD card socket
> > > - WWAN modem
> > 
> > Why not add the LCD backlight and the touch controller as well?
> 
> I planned to leave those out until we have the display subsystem working on
> mainline.

I wouldn't leave out anything with known working drivers.
Cheers,
 -- Guido
