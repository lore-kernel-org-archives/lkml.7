Return-Path: <SRS0=TxL2=YH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AC43ECE58C
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 18:34:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FE5220873
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 18:34:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730651AbfJNSed (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 14:34:33 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:40294 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729942AbfJNSec (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 14:34:32 -0400
Received: from p5b06da22.dip0.t-ipconnect.de ([91.6.218.34] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1iK5Ao-0005Xr-Rk; Mon, 14 Oct 2019 20:34:26 +0200
Date:   Mon, 14 Oct 2019 20:34:15 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Benjamin GAIGNARD <benjamin.gaignard@st.com>
cc:     "fweisbec@gmail.com" <fweisbec@gmail.com>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "marc.zyngier@arm.com" <marc.zyngier@arm.com>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>
Subject: Re: [PATCH] tick: check if broadcast device could really be
 stopped
In-Reply-To: <c3565734-05e3-0a9d-1101-92c4be476ae6@st.com>
Message-ID: <alpine.DEB.2.21.1910142032590.1880@nanos.tec.linutronix.de>
References: <20191009160246.17898-1-benjamin.gaignard@st.com> <alpine.DEB.2.21.1910141441350.2531@nanos.tec.linutronix.de> <a4b4b785-c471-a3c2-2c41-01bd9865e479@st.com> <alpine.DEB.2.21.1910141535500.2531@nanos.tec.linutronix.de> <16f7e8e9-eefe-5973-a08a-3e1823d20034@st.com>
 <alpine.DEB.2.21.1910141620100.2531@nanos.tec.linutronix.de> <c3565734-05e3-0a9d-1101-92c4be476ae6@st.com>
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

On Mon, 14 Oct 2019, Benjamin GAIGNARD wrote:
> On 10/14/19 4:28 PM, Thomas Gleixner wrote:
> > Unless you have a solution which works under all circumstances (and the
> > current patch definitely does not) then you have to deal with the
> > requirement of the broadcast timer (either physical or software based).
> 
> If I follow you I need, for my system, a software based broadcast timer 
> (tick-broadcast-hrtimer ?).

Yes, if you don't have a physical one.
 
> If that is correct I 'just' need to add a call to
> tick_setup_hrtimer_broadcast() in arch/arm/kernel/time.c

Correct.

Thanks,

	tglx
