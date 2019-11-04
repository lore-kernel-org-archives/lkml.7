Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A676CA9ED3
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 12:46:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01DE9222C1
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 12:46:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572871586;
	bh=uu6hMcwvil/xb9dqy8jjyGW+1kTfPIrio1g2NerX6OE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=0K+C7xJneH8JW1TT1E61LpsFVwVjwUJF5CcCrlkYhMjvnQPxQOpxdsjLCZHZi/w2Z
	 5y1hfeVXxKXLFiFVfYVI0ginTSD7X6/F7BMnBcU7UNXI9U4/UkrNp3OVU3dijMcu1X
	 EobFu5K707lvC/ry0UB8E6uNBDll+n2HGhCV75UU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728904AbfKDMqY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 07:46:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:55266 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727236AbfKDMqY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 07:46:24 -0500
Received: from dragon (li1038-30.members.linode.com [45.33.96.30])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 11BD8218BA;
        Mon,  4 Nov 2019 12:46:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572871583;
        bh=uu6hMcwvil/xb9dqy8jjyGW+1kTfPIrio1g2NerX6OE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Dxf2qdCcOkPEg/SW5EDL+yx9RaRwjiVhtnRit11I3Y0pAfi0DJ5GvvIuch+W02iXF
         1c/lS5US48HKzpmbDWvTmti++TWT0jI3XG/Vlkf6AM5BYboyPPtELDCYqzZRZKfO3O
         kbzIXvY/7wzA+S6xm9qMwBXQAHY3NXdT7iNrG4iI=
Date:   Mon, 4 Nov 2019 20:45:55 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Schrempf Frieder <frieder.schrempf@kontron.de>
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 09/11] ARM: dts: imx6ul-kontron-n6x1x-s: Disable the
 snvs-poweroff driver
Message-ID: <20191104124553.GY24620@dragon>
References: <20191031142112.12431-1-frieder.schrempf@kontron.de>
 <20191031142112.12431-10-frieder.schrempf@kontron.de>
 <20191104074346.GT24620@dragon>
 <626ad87a-eb1d-4dca-7cd3-8c5f38025aec@kontron.de>
 <7da30a17-d16c-3cde-12a8-430ff3eec692@kontron.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7da30a17-d16c-3cde-12a8-430ff3eec692@kontron.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 04, 2019 at 11:18:19AM +0000, Schrempf Frieder wrote:
> On 04.11.19 09:06, Frieder Schrempf wrote:
> > Hi Shawn,
> > 
> > On 04.11.19 08:43, Shawn Guo wrote:
> >> On Thu, Oct 31, 2019 at 02:24:27PM +0000, Schrempf Frieder wrote:
> >>> From: Frieder Schrempf <frieder.schrempf@kontron.de>
> >>>
> >>> The snvs-poweroff driver can power off the system by pulling the
> >>> PMIC_ON_REQ signal low, to let the PMIC disable the power.
> >>> The Kontron SoMs do not have this signal connected, so let's remove
> >>> the node.
> >>>
> >>> This seems to fix a real issue when the signal is asserted at
> >>> poweroff, but not actually causing the power to turn off. It was
> >>> observed, that in this case the system would not shut down properly.
> >>
> >> I do not quite follow on this.  How does disabling snvs_poweroff fix the
> >> issue?  The root cause of system not shut down properly seems to be that
> >> PMIC doesn't shut down power.  This looks like a clean-up rather than
> >> bug fix.
> > 
> > I don't know the exact reasons, but we had issues on these boards when 
> > doing a "poweroff". The kernel would print something like the log below.
> > Disabling the snvs-poweroff solved this.
> > 
> > But note that this has last been reproduced on v4.14. So I'm not sure if 
> > this is still a problem with the current kernel.
> > 
> > #######
> > reboot: Power down
> > Unable to poweroff system
> > 
> > ====================================
> > WARNING: halt/675 still has locks held!
> > 4.14.104-exceet #1 Not tainted
> > ------------------------------------
> > 1 lock held by halt/675:
> >   #0:  (reboot_mutex){+.+.}, at: [<c0145a98>] SyS_reboot+0x14c/0x1dc
> > #######
> > 
> >>
> >>>
> >>> Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
> >>> Fixes: 1ea4b76cdfde ("ARM: dts: imx6ul-kontron-n6310: Add Kontron 
> >>> i.MX6UL N6310 SoM and boards")
> >>
> >> If you think this is really a bug fix, it should be applied to the file
> >> before renaming rather than the one after renaming.
> > 
> > I will try to reproduce the issue with the current kernel and depending 
> > on the results either drop the Fixes tag or move the patch before the 
> > renaming.
> 
> I just tried this with 5.4-rc5 and the issue persists. When 
> snvs-poweroff is enabled without the hardware actually being able to 
> power down via PMIC I get a locking WARNING from the kernel. Probably 
> because the system is still running, when it's already supposed to be 
> shut down by the PMIC.

I still do not get it.  Are you saying that with snvs-poweroff being
disabled, your system is now able to be shut down properly by PMIC?

Shawn

> 
> So this fixes a real problem and therefore I will keep the Fixes tag and 
> move the patch to the proper place in this series.
