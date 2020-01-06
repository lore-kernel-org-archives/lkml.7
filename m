Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A026C33C9A
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 09:44:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F85F20848
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 09:44:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726307AbgAFJos (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 04:44:48 -0500
Received: from honk.sigxcpu.org ([24.134.29.49]:33898 "EHLO honk.sigxcpu.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726080AbgAFJor (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 04:44:47 -0500
Received: from localhost (localhost [127.0.0.1])
        by honk.sigxcpu.org (Postfix) with ESMTP id 99DCAFB03;
        Mon,  6 Jan 2020 10:44:45 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at honk.sigxcpu.org
Received: from honk.sigxcpu.org ([127.0.0.1])
        by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 2JLKIb8Jk-A7; Mon,  6 Jan 2020 10:44:44 +0100 (CET)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
        id 03BB649C60; Mon,  6 Jan 2020 10:44:43 +0100 (CET)
Date:   Mon, 6 Jan 2020 10:44:43 +0100
From:   Guido =?iso-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Dan Murphy <dmurphy@ti.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/9] leds: lm3692x: Allow to set ovp and brigthness
 mode
Message-ID: <20200106094443.GB13043@bogon.m.sigxcpu.org>
References: <cover.1578134779.git.agx@sigxcpu.org>
 <20200105234708.GA7598@amd>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200105234708.GA7598@amd>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
On Mon, Jan 06, 2020 at 12:47:08AM +0100, Pavel Machek wrote:
> Hi!
> 
> > Overvoltage protection and brightness mode are currently hardcoded
> > as 29V and disabled in the driver. Make these configurable via DT.
> > 
> > Besides addressing review comments v3 folds in the patches to
> > disable the chip and turn of the regulator on brightness 0 from
> > 
> >   https://lore.kernel.org/linux-leds/20191226101419.GE4033@amd/T/#t
> > 
> > Besides addressing review comments v2 also allows to limit the maximum led
> > current.
> 
> > Patches are against next-20191220.
> 
> I applied everything but the "exponential" changes and the last
> one. I'll apply the last one if I get version that applies on top of
> leds tree.

Thanks! Can I do anything to get the exponential part in? Is it because
you want the exponential mode to move to the backlight binding?

Cheers,
 -- Guido

> 
> Best regards,
> 									Pavel
> 
> -- 
> (english) http://www.livejournal.com/~pavelmachek
> (cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html


