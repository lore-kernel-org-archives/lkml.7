Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	TVD_SUBJ_WIPE_DEBT,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93547C33CA2
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 09:10:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F14F206ED
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 09:10:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578561003;
	bh=haZEqFJpGZtGMsjVB13sXDjxCq2aK0w6Eef5tnBpYpQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=GpVHAeMXwgCjtE3jsV00YEF+dMjQFJ5El7QaKnvBmw4pYeZFNeOFyS19lIXE9CFcf
	 Tx97jSwj/qt0c82HkSmC+yqyRI1YTzw0+ZLitCz/gJfwEam6Tpb/6XUe/zyYzBmyYp
	 ywI/wgNS0TwX8nhSHI58XxPPCiz+e3Oq+dGEEc1M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729023AbgAIJKC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 04:10:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:58308 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728605AbgAIJKB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 04:10:01 -0500
Received: from T480 (98.142.130.235.16clouds.com [98.142.130.235])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EEAF820673;
        Thu,  9 Jan 2020 09:09:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578561001;
        bh=haZEqFJpGZtGMsjVB13sXDjxCq2aK0w6Eef5tnBpYpQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=2v03/I4mCgexgzf5xwrck+WPVo8KiwMI2YiJmYh28wkaiogxsAYRtgA5mrhq46/0i
         dxgxlyrmYDXAwKeEbmGPIDf5i8YdPOD60zvADN+yhhszuD1dGr0YT6ndAAkbrlq3HB
         xUk/r87D8k6nhOtUgwmpDAQrIXlygmqjLN53Ro/s=
Date:   Thu, 9 Jan 2020 17:09:51 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Anson Huang <anson.huang@nxp.com>
Cc:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "andreas@kemnade.info" <andreas@kemnade.info>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH 1/5] ARM: dts: imx6qdl-sabresd: Remove incorrect power
 supply assignment
Message-ID: <20200109090950.GJ4456@T480>
References: <1577670071-1322-1-git-send-email-Anson.Huang@nxp.com>
 <20200109080600.GH4456@T480>
 <DB3PR0402MB39168406714A06869C33D037F5390@DB3PR0402MB3916.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DB3PR0402MB39168406714A06869C33D037F5390@DB3PR0402MB3916.eurprd04.prod.outlook.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 09, 2020 at 08:25:03AM +0000, Anson Huang wrote:
> Hi, Shawn
> 
> > Subject: Re: [PATCH 1/5] ARM: dts: imx6qdl-sabresd: Remove incorrect
> > power supply assignment
> > 
> > On Mon, Dec 30, 2019 at 09:41:07AM +0800, Anson Huang wrote:
> > > The vdd3p0's input should be from external USB VBUS directly, NOT
> > 
> > Shouldn't USB VBUS usually be 5V?  It doesn't seem to match 3.0V which is
> > suggested by vdd3p0 name.
> > 
> > > PMIC's sw2, so remove the power supply assignment for vdd3p0.
> > >
> > > Fixes: 93385546ba36 ("ARM: dts: imx6qdl-sabresd: Assign corresponding
> > > power supply for LDOs")
> > 
> > Is it only a description correcting or is it fixing a real problem?  I'm trying to
> > understand it is a 5.5-rc material or can be applied for 5.6.
> > 
> 
> It is fixing a real problem about USB LDO voltage, that is why we noticed this issue.

Okay, please describe the problem a little bit in the commit log.  Also
squash the series into one patch, which is easier to be merged into -rc
as a fix.

My question above that USB VUBS is 5V which doesn't match 3.0V
suggested by vdd3p0 name remains unaddressed though.

Shawn
