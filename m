Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89B8CC49EAB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 10:01:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58E012190F
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 10:01:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388191AbfKEKBi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 05:01:38 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:40774 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388108AbfKEKBi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 05:01:38 -0500
Received: from [5.158.153.52] (helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1iRveW-0000FL-L6; Tue, 05 Nov 2019 11:01:33 +0100
Date:   Tue, 5 Nov 2019 11:01:32 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Arul Jeniston <arul.jeniston@gmail.com>
cc:     viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, arul_mc@dell.com
Subject: Re: [PATCH] FS: timerfd: Fix unexpected return value of timerfd_read
 function.
In-Reply-To: <CACAVd4grhGVVSYpwjof5YiS1duZ2_SFjvXtctP+cmR5Actkjyg@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1911051100471.17054@nanos.tec.linutronix.de>
References: <20190816083246.169312-1-arul.jeniston@gmail.com> <CACAVd4izozzXNF9qwNcXC+EUx5n1sfsNeb9JNXNJF56LdZkkYg@mail.gmail.com> <alpine.DEB.2.21.1908191646350.2147@nanos.tec.linutronix.de> <CACAVd4j60pn=td5hh485SJOcoYZ_jWQDQg2DVasSodPtsaupkw@mail.gmail.com>
 <alpine.DEB.2.21.1908191752580.2147@nanos.tec.linutronix.de> <CACAVd4iRN7=eq_B1+Yb-xcspU-Sg1dmMo_=VtLXXVPkjN1hY5Q@mail.gmail.com> <alpine.DEB.2.21.1908191943280.1796@nanos.tec.linutronix.de> <CACAVd4jAJ5QcOH=q=Q9kAz20X4_nAc7=vVU_gPWTS1UuiGK-fg@mail.gmail.com>
 <alpine.DEB.2.21.1908201036200.2223@nanos.tec.linutronix.de> <CACAVd4jT4Ke7giPmKSzt+Wo3Ro-g9zWDRz_GHaRcs0Nb3_rkBw@mail.gmail.com> <CACAVd4gRoQih6f_K7kMzr=AwA_DvP0OksxBKj1bGPsP2F_9sFg@mail.gmail.com> <alpine.DEB.2.21.1909051707150.1902@nanos.tec.linutronix.de>
 <CACAVd4hS1i--fxWaarXP2psagW-JmBoLAJRrfu9gkRc49Ja4pg@mail.gmail.com> <alpine.DEB.2.21.1909071630000.1902@nanos.tec.linutronix.de> <CACAVd4grhGVVSYpwjof5YiS1duZ2_SFjvXtctP+cmR5Actkjyg@mail.gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Arul,

On Tue, 5 Nov 2019, Arul Jeniston wrote:
> >  So I'm going to send a patch to document that in the manpage.
> 
> Did you get a chance to make the manpage patch? if yes, please help us
> by sharing the link where we can find the patch.

No. I would have Cc'ed you when posting. It's somewhere on my todo list.

Thanks,

	tglx
