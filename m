Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24C19C48BD6
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 16:22:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E84912133F
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 16:22:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561652565;
	bh=XANE2VhVUGz0tCaYce+E3tgK+iSMPwffhn6oVDGjCZw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=X02+9bDSp5ggWjmB6WWLqr1HKIh8OSeYTeito/+RK437weOgmsV7XkWWn9hI7CXVW
	 CGuuYOieYwmbo97bo+DiwwObz3ZjQB4ShM7mXW2GKas30MhwMD1oE1NxF/8YW+htIH
	 X0wjDakBb9gVX+UAjev6WQ2iO2Pg0ANudIY/Qy6A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726525AbfF0QWn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 12:22:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:50284 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726315AbfF0QWn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 12:22:43 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4B7A32080C;
        Thu, 27 Jun 2019 16:22:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561652562;
        bh=XANE2VhVUGz0tCaYce+E3tgK+iSMPwffhn6oVDGjCZw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LVg0EcdyXbOBXgTkd2XcOQaBxPyrPhiaqbNwgyqfwF/QwNgvl6UCKJ50T0o/RjiC4
         sDeBKd+ZeEM/5/qPs4soGGqNMWpA0kr7j5WkTng2+O1OeDYYMcO0fMrlHY7/x17Kli
         kVFw/fJcFWHDzB35wrdWFUO0CZj8yp0b4LBvKvtA=
Date:   Thu, 27 Jun 2019 17:22:37 +0100
From:   Will Deacon <will@kernel.org>
To:     Ganapatrao Kulkarni <gkulkarni@marvell.com>
Cc:     "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "Will.Deacon@arm.com" <Will.Deacon@arm.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "jnair@caviumnetworks.com" <jnair@caviumnetworks.com>,
        "Robert.Richter@cavium.com" <Robert.Richter@cavium.com>,
        "Jan.Glauber@cavium.com" <Jan.Glauber@cavium.com>,
        "gklkml16@gmail.com" <gklkml16@gmail.com>
Subject: Re: [PATCH 1/2] Documentation: perf: Update documentation for
 ThunderX2 PMU uncore driver
Message-ID: <20190627162236.y3wb5sle6yjbwtzm@willie-the-truck>
References: <1560534144-13896-1-git-send-email-gkulkarni@marvell.com>
 <1560534144-13896-2-git-send-email-gkulkarni@marvell.com>
 <20190627100118.nfveq4oktomqybtx@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190627100118.nfveq4oktomqybtx@willie-the-truck>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 27, 2019 at 11:01:18AM +0100, Will Deacon wrote:
> On Fri, Jun 14, 2019 at 05:42:45PM +0000, Ganapatrao Kulkarni wrote:
> > From: Ganapatrao Kulkarni <ganapatrao.kulkarni@marvell.com>
> > 
> > Add documentation for Cavium Coherent Processor Interconnect (CCPI2) PMU.
> > 
> > Signed-off-by: Ganapatrao Kulkarni <gkulkarni@marvell.com>
> > ---
> >  Documentation/perf/thunderx2-pmu.txt | 20 +++++++++++---------
> >  1 file changed, 11 insertions(+), 9 deletions(-)
> > 
> > diff --git a/Documentation/perf/thunderx2-pmu.txt b/Documentation/perf/thunderx2-pmu.txt
> > index dffc57143736..62243230abc3 100644
> > --- a/Documentation/perf/thunderx2-pmu.txt
> > +++ b/Documentation/perf/thunderx2-pmu.txt
> > @@ -2,24 +2,26 @@ Cavium ThunderX2 SoC Performance Monitoring Unit (PMU UNCORE)
> >  =============================================================
> >  
> >  The ThunderX2 SoC PMU consists of independent, system-wide, per-socket
> > -PMUs such as the Level 3 Cache (L3C) and DDR4 Memory Controller (DMC).
> > +PMUs such as the Level 3 Cache (L3C), DDR4 Memory Controller (DMC) and
> > +Cavium Coherent Processor Interconnect (CCPI2).
> >  
> >  The DMC has 8 interleaved channels and the L3C has 16 interleaved tiles.
> >  Events are counted for the default channel (i.e. channel 0) and prorated
> >  to the total number of channels/tiles.
> >  
> > -The DMC and L3C support up to 4 counters. Counters are independently
> > -programmable and can be started and stopped individually. Each counter
> > -can be set to a different event. Counters are 32-bit and do not support
> > -an overflow interrupt; they are read every 2 seconds.
> > +The DMC, L3C support up to 4 counters and CCPI2 support up to 8 counters.
> 
> The DMC and L3C support up to 4 counters, while the CCPI2 supports up to 8
> counters.
> 
> > +Counters are independently programmable and can be started and stopped
> > +individually. Each counter can be set to a different event. DMC and L3C
> > +Counters are 32-bit and do not support an overflow interrupt; they are read
> 
> Counters -> counters
> 
> > +every 2 seconds. CCPI2 counters are 64-bit.
> 
> Assuming CCPI2 also doesn't support an overflow interrupt, I'd reword these
> two sentences as:
> 
>   None of the counters support an overflow interrupt and therefore sampling
>   events are unsupported. The DMC and L3C counters are 32-bit and read every
>   2 seconds. The CCPI2 counters are 64-bit and assumed not to overflow in
>   normal operation.

Mark reminded me that these are system PMUs and therefore sampling is
unsupported irrespective of the presence of an overflow interrupt, so you
can drop that part from the text.

Sorry for the confusion,

Will
