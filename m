Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6A82C3A59D
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 09:35:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 875AD233A0
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 09:35:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387497AbfHVJfB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 05:35:01 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:59589 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725799AbfHVJe7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 05:34:59 -0400
Received: from p5de0b6c5.dip0.t-ipconnect.de ([93.224.182.197] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1i0jUe-0006rH-AS; Thu, 22 Aug 2019 11:34:56 +0200
Date:   Thu, 22 Aug 2019 11:34:55 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Chris Clayton <chris2553@googlemail.com>
cc:     LKML <linux-kernel@vger.kernel.org>, vincenzo.frascino@arm.com,
        catalin.marinas@arm.com, Will Deacon <will.deacon@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Andy Lutomirski <luto@kernel.org>
Subject: Re: Regression in 5.3-rc1 and later
In-Reply-To: <alpine.DEB.2.21.1908221059370.1983@nanos.tec.linutronix.de>
Message-ID: <alpine.DEB.2.21.1908221134110.1983@nanos.tec.linutronix.de>
References: <faaa3843-09a6-1a21-3448-072eeed1ea00@googlemail.com> <alpine.DEB.2.21.1908221047250.1983@nanos.tec.linutronix.de> <alpine.DEB.2.21.1908221059370.1983@nanos.tec.linutronix.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Chris,

On Thu, 22 Aug 2019, Thomas Gleixner wrote:
> On Thu, 22 Aug 2019, Thomas Gleixner wrote:
> > 
> > Can you please provide the output of:
> > 
> >   dmesg | grep -i TSC
> 
> Full dmesg for both scenarios (12min and >14min) would be appreciated as well.

Hold off with that. I think I found the issue.

Thanks,

	tglx
