Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2516FC432C3
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 21:34:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17E0E206E3
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 21:35:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726912AbfKMVe5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 16:34:57 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:39119 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726189AbfKMVe5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 16:34:57 -0500
Received: from p5b06da22.dip0.t-ipconnect.de ([91.6.218.34] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1iV0Hr-0006m5-6C; Wed, 13 Nov 2019 22:34:51 +0100
Date:   Wed, 13 Nov 2019 22:34:50 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     "Harris, Robert" <robert.harris@alertlogic.com>
cc:     Ingo Molnar <mingo@kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "dvhart@infradead.org" <dvhart@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Help requested: futex(..., FUTEX_WAIT_PRIVATE, ...) returns
 EPERM
In-Reply-To: <90781C7F-BF54-4913-8548-2FE815CCAC95@alertlogic.com>
Message-ID: <alpine.DEB.2.21.1911132220090.2507@nanos.tec.linutronix.de>
References: <E0332978-739B-4546-9C3F-975216C349D2@alertlogic.com> <alpine.DEB.2.21.1911130956150.1833@nanos.tec.linutronix.de> <90781C7F-BF54-4913-8548-2FE815CCAC95@alertlogic.com>
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

On Wed, 13 Nov 2019, Harris, Robert wrote:
> > On 13 Nov 2019, at 09:04, Thomas Gleixner <tglx@linutronix.de> wrote:
> > On Tue, 12 Nov 2019, Harris, Robert wrote:
> >> Understanding the circumstances under which EPERM can be returned for
> >> FUTEX_WAIT_PRIVATE would be useful but it is not a documented failure
> >> mode.  I have spent some time looking through futex.c but have not
> >> found anything yet.  I would be grateful for a hint from someone more
> >> knowledgeable.
> >
> > sys_futex(FUTEX_WAIT_PRIVATE) does not return -EPERM. Only the PI variants
> > do that.
> 
> In that case I would appreciate a second pair of eyes.  The error I see
> (intermittently) is

The code looks innocent enough. As I don't know whether the kernel version
you mentioned is a vanilla 4.19.184 from the stable tree or some patched up
frankenkernel which pretends to have this version number, I can't be sure
that this is an issue in that particular kernel.

In the vanilla 4.19.184 I really cant find how that would return EPERM for
regular futexes.

Thanks,

	tglx


