Return-Path: <SRS0=lz0T=XK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD93DC4CEC7
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Sep 2019 12:29:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F597214D8
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Sep 2019 12:29:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="KrX8c7JG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730588AbfIOM3v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Sep 2019 08:29:51 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:36718 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730448AbfIOM3v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Sep 2019 08:29:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=9p2NJ7BXbD4NZDyoxVh3Cv5cepB8PS65/rD5Ce0NUf8=; b=KrX8c7JGi47gemy02Slr+/J2I
        Gp+EfycmlV+P7bdYQMrEWbtqcLDuOzSbj1JGG17tjfAGeax2abW9RwMmsOagJKPiLZoCzWCS0yLO/
        skHja8Lhgeaz1ZO7mxNfWnlmX5ZdLaoZkB1e0BnNk0wYZgeIHdz5QRmH4/qONolqj2QjjGKwfQJ+H
        pxUsvux0tRGxGMJ1d2fMSqU3COP6SYBs6TpSs1ClB2d565FL9lt/wcy9rafohvBMje86YF//3iaH/
        2+2d1MZzquM+XAyGnAdLPs/a2Zqwiuo6jbQrv5qspFU/G3wAkzzG/YbvT0cxL61VoL+eFf+xNuOB1
        53tmQ+uKw==;
Received: from shell.armlinux.org.uk ([2002:4e20:1eda:1:5054:ff:fe00:4ec]:39810)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1i9Tes-0006Iq-Jp; Sun, 15 Sep 2019 13:29:38 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1i9Tej-0007lP-9q; Sun, 15 Sep 2019 13:29:29 +0100
Date:   Sun, 15 Sep 2019 13:29:29 +0100
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Baruch Siach <baruch@tkos.co.il>
Cc:     Andrew Lunn <andrew@lunn.ch>, tinywrkb <tinywrkb@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        open list <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] ARM: dts: imx6dl: SolidRun: add phy node with 100Mb/s
 max-speed
Message-ID: <20190915122929.GB25745@shell.armlinux.org.uk>
References: <20190910155507.491230-1-tinywrkb@gmail.com>
 <20190910185033.GD9761@lunn.ch>
 <87muf6oyvr.fsf@tarshish>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87muf6oyvr.fsf@tarshish>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 15, 2019 at 09:30:00AM +0300, Baruch Siach wrote:
> Hi Andrew,
> 
> On Tue, Sep 10 2019, Andrew Lunn wrote:
> > On Tue, Sep 10, 2019 at 06:55:07PM +0300, tinywrkb wrote:
> >> Cubox-i Solo/DualLite carrier board has 100Mb/s magnetics while the
> >> Atheros AR8035 PHY on the MicroSoM v1.3 CPU module is a 1GbE PHY device.
> >>
> >> Since commit 5502b218e001 ("net: phy: use phy_resolve_aneg_linkmode in
> >> genphy_read_status") ethernet is broken on Cubox-i Solo/DualLite devices.
> >
> > Hi Tinywrkb
> >
> > You emailed lots of people, but missed the PHY maintainers :-(
> >
> > Are you sure this is the patch which broken it? Did you do a git
> > bisect.
> 
> Tinywrkb confirmed to me in private communication that revert of
> 5502b218e001 fixes Ethernet for him on effected system.
> 
> He also referred me to an old Cubox-i spec that lists 10/100 Ethernet
> only for i.MX6 Solo/DualLite variants of Cubox-i. It turns out that
> there was a plan to use a different 10/100 PHY for Solo/DualLite
> SOMs. This plan never materialized. All SolidRun i.MX6 SOMs use the same
> AR8035 PHY that supports 1Gb.
> 
> Commit 5502b218e001 might be triggering a hardware issue on the affected
> Cubox-i. I could not reproduce the issue here with Cubox-i and a Dual
> SOM variant running v5.3-rc8. I have no Solo/DualLite variant handy at
> the moment.

With 5.3 due out today, I'll be updating my systems to that, which will
include quite a few variants of the Hummingboard.

It looks like one of my Solo Hummingboards (running a fully up to date
Fedora 28) has encountered a problem, so needs a reboot...

systemd-journald[436]: Failed to retrieve credentials for PID 17906, ignoring: Cannot allocate memory
systemd-journald[436]: Failed to open runtime journal: Cannot allocate memory

# ps aux
USER       PID %CPU %MEM    VSZ   RSS TTY      STAT START   TIME COMMAND
...
root       436  0.0  5.2 3128140 26392 ?       Ss   Aug03   1:20 /usr/lib/systemd/systemd-journald
# uptime
 13:28:41 up 42 days, 19:13,  1 user,  load average: 0.00, 0.03, 0.00

Looks like systemd-journald has a rather bad memory leak...

#include <std-complaints-about-systemd>

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
