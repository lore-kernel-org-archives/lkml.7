Return-Path: <SRS0=GVTe=2R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AED56C2D0DA
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Dec 2019 12:56:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 899F520882
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Dec 2019 12:56:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727023AbfL0M4a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Dec 2019 07:56:30 -0500
Received: from honk.sigxcpu.org ([24.134.29.49]:33262 "EHLO honk.sigxcpu.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726377AbfL0M4a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Dec 2019 07:56:30 -0500
Received: from localhost (localhost [127.0.0.1])
        by honk.sigxcpu.org (Postfix) with ESMTP id 37C1CFB03;
        Fri, 27 Dec 2019 13:56:28 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at honk.sigxcpu.org
Received: from honk.sigxcpu.org ([127.0.0.1])
        by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id sWRGWaFKenMz; Fri, 27 Dec 2019 13:56:27 +0100 (CET)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
        id A042649799; Fri, 27 Dec 2019 13:56:26 +0100 (CET)
Date:   Fri, 27 Dec 2019 13:56:26 +0100
From:   Guido =?iso-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Dan Murphy <dmurphy@ti.com>, linux-leds@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] leds: lm3692x: Disable chip on brightness 0
Message-ID: <20191227125626.GA26038@bogon.m.sigxcpu.org>
References: <cover.1577272495.git.agx@sigxcpu.org>
 <e1dc56c07235063a9c0afbfc8c227b92b39ec3d4.1577272495.git.agx@sigxcpu.org>
 <20191226102956.GH4033@amd>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191226102956.GH4033@amd>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pavel,
On Thu, Dec 26, 2019 at 11:29:56AM +0100, Pavel Machek wrote:
> On Wed 2019-12-25 12:16:39, Guido Günther wrote:
> > Otherwise there's a noticeable glow even with brightness 0. Also
> > turning off the regulator can save additional power.
> 
> Ok, this will make set brightness slower, but I guess it makes sense.
> 
> Can you try to toggling brightness quickly from userspace, maybe even
> from two threads, to ensure nothing really goes wrong there?

I ran brightness setting in a tight loop from 0 to max from two threads
100 times without issues.

> 
> Hmm. And if this is independend of the other series, tell me and I can
> apply v2.

There's minor merge conflict so to make sure this does not get dependent
on the order i've folded this to the end of the

    "leds: lm3692x: Allow to set ovp and brigthness mode"

series with your Acked-by's folded in. I'll wait a couple of days and
then send out a v3.

Cheers and thanks for having a look,
 -- Guido

> 
> Best regards,
> 								Pavel
> -- 
> (english) http://www.livejournal.com/~pavelmachek
> (cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html


