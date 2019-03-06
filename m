Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAF2CC43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 18:16:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFECC20684
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 18:16:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="uojk0uA9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730782AbfCFSQR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 13:16:17 -0500
Received: from pandora.armlinux.org.uk ([78.32.30.218]:35320 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728424AbfCFSQR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 13:16:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=QelMipGIOdThBNtgxzwvwkQDN7dtdyFkTWUD4rHKJHo=; b=uojk0uA9P19Wfl5VjPHqk7rX8
        bNtFsZHTeaw3c9A6wztBrOZh8NRH38y+LQiLg2BRiy0J15qwFl434+Y7kXdv1JgtqllYoy+SYANoy
        SxtJqy19Of9J6EL54WtaMaVfltQjGS3JE/VgDiRZZsOI4jXuJMOdtZBXgi+u2cdnhBzJsu2Kc8S8A
        O9QakBrNay8Vb0Ax4YFyfJIFg4zpOtEMRKzKCmUWQtcT0uPKB4G8PBDvLBnDiKNHkYeyOTwMXV6+1
        jYhnyc6iGI+vB1KmeMUU/zntej8yQGNwFuRbg2HnT/6+f1TzdaHUc6thdvh+RZ3xZCnE9S58ip7az
        UU0Kr2h6w==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:51632)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1h1b5E-0000nE-HX; Wed, 06 Mar 2019 18:16:00 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.89)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1h1b5B-0004G7-OD; Wed, 06 Mar 2019 18:15:57 +0000
Date:   Wed, 6 Mar 2019 18:15:57 +0000
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, soc@kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        arm-soc <arm@kernel.org>
Subject: Re: [GIT PULL 3/6] ARM: SoC driver updates for 5.1
Message-ID: <20190306181557.fndmy5oks3sximeo@shell.armlinux.org.uk>
References: <CAK8P3a1mnNrpf5moqi4x9BaTNpE9ZUgs-VBjXoG7=AxENwYtbQ@mail.gmail.com>
 <CAK8P3a1-j-rr1MKnVqD8__YnqPsP8y4S_TWr+TRJScRvkrFymA@mail.gmail.com>
 <CAHk-=wgdJKaDt=Dp_DS+LL3bzRZUo2VHHMZU_VUMukSPzRJPUw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgdJKaDt=Dp_DS+LL3bzRZUo2VHHMZU_VUMukSPzRJPUw@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 06, 2019 at 10:09:28AM -0800, Linus Torvalds wrote:
> On Wed, Mar 6, 2019 at 7:34 AM Arnd Bergmann <arnd@arndb.de> wrote:
> >
> >   git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/armsoc-drivers
> 
> This caused a surprising number of kernel file rebuilds for me, and
> the reason was
> 
> >  include/linux/mod_devicetable.h                                     |   9 +
> 
> It turns out that the above is indirectly included from a _lot_ of
> code device header files.
> 
> The reason seems to be the various 'struct *_device_id' declarations,
> that then all the different header files want.
> 
> So a tiny change in an oddball header file causes a lot of recompiles.
> 
> Oh well. I don't know if there is anything to be done, but I did react
> to how some surprising changes cause a lot of build activity, and it's
> not always obvious.

Would it be worth splitting up mod_devicetable.h and having drivers
include just the bus-specific device table header(s) that the driver
requires?

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
