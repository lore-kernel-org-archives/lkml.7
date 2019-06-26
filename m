Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43111C48BD3
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 14:12:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C7C8208CB
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 14:12:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727830AbfFZOMT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 10:12:19 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:48534 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725958AbfFZOMT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 10:12:19 -0400
Received: from p5b06daab.dip0.t-ipconnect.de ([91.6.218.171] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hg8em-0003AX-BH; Wed, 26 Jun 2019 16:12:16 +0200
Date:   Wed, 26 Jun 2019 16:12:15 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Tejun Heo <tj@kernel.org>
cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 0/6] workqueue: convert to raw_spinlock_t
In-Reply-To: <20190626140112.GU657710@devbig004.ftw2.facebook.com>
Message-ID: <alpine.DEB.2.21.1906261608260.32342@nanos.tec.linutronix.de>
References: <20190613145027.27753-1-bigeasy@linutronix.de> <20190626071719.psyftqdop4ny3zxd@linutronix.de> <20190626134957.GT657710@devbig004.ftw2.facebook.com> <alpine.DEB.2.21.1906261551190.32342@nanos.tec.linutronix.de>
 <20190626140112.GU657710@devbig004.ftw2.facebook.com>
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

Tejun,

On Wed, 26 Jun 2019, Tejun Heo wrote:
> On Wed, Jun 26, 2019 at 03:53:43PM +0200, Thomas Gleixner wrote:
> > > I don't now what to make of the series.  AFAICS, there's no benefit to
> > > mainline.  What am I missing?
> > 
> > there is no downside either, right?
> 
> Sure, but that usually isn't enough for merging patches, right?

Depends :)
 
> > It helps with the ongoing RT integration into the mainline kernel and we
> > would appreciate if we can get the non controversial bits an pieces sorted.
> 
> I see.  I understand the intention and it was a lot clearer when the
> changes were beneficial to mainline kernel too and I'm not sure this
> is a decision we wanna make per-subsystem.  Maybe I'm just out of
> loop.  Are we generally doing this?

We are working hard to get the remaining pieces in and to the best of my
knowledge there is no hard resistance against merging them.

What we are trying at the moment is to reduce the surface of the bulk of RT
changes and get the 'innocent' ones in. If you feel more comfortable, then
we can surely redo the series and pick 1,2,6 for now and keep 3-5 for the
final submission.

Thanks,

	tglx

