Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04295C3A5A7
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 22:49:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D994A215EA
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 22:49:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727299AbfICWta (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 18:49:30 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:34764 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725990AbfICWt3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 18:49:29 -0400
Received: from p5de0b6c5.dip0.t-ipconnect.de ([93.224.182.197] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1i5Hc2-0006tz-Pu; Wed, 04 Sep 2019 00:49:23 +0200
Date:   Wed, 4 Sep 2019 00:49:21 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Michael <michael@mipisi.de>
cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-rtc@vger.kernel.org, John Stultz <john.stultz@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: Problem when function alarmtimer_suspend returns 0 if time delta
 is zero
In-Reply-To: <4fc3a016-ec2f-a15e-5fd1-6794a001e2d9@mipisi.de>
Message-ID: <alpine.DEB.2.21.1909040047210.1902@nanos.tec.linutronix.de>
References: <S1728511AbfHaSEm/20190831180442Z+580@vger.kernel.org> <08fbdf25-faa1-aa13-4f13-d30acbf27dda@mipisi.de> <20190902074917.GA21922@piout.net> <alpine.DEB.2.21.1909021247250.3955@nanos.tec.linutronix.de>
 <4fc3a016-ec2f-a15e-5fd1-6794a001e2d9@mipisi.de>
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

On Tue, 3 Sep 2019, Michael wrote:

> Thomas,
> 
> thank you very much for your patch. Unfortunately currently I can only test it
> with a kernel 4.1.52 but i've tried to patch
> your new logic into my older kernel version.

<formletter>

 https://people.kernel.org/tglx/notes-about-netiquette

</formletter>

