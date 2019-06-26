Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BCDEC48BD6
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 13:53:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F2DE214DA
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 13:53:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727641AbfFZNxr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 09:53:47 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:48149 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726104AbfFZNxr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 09:53:47 -0400
Received: from p5b06daab.dip0.t-ipconnect.de ([91.6.218.171] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hg8Mq-0002TV-2x; Wed, 26 Jun 2019 15:53:44 +0200
Date:   Wed, 26 Jun 2019 15:53:43 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Tejun Heo <tj@kernel.org>
cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 0/6] workqueue: convert to raw_spinlock_t
In-Reply-To: <20190626134957.GT657710@devbig004.ftw2.facebook.com>
Message-ID: <alpine.DEB.2.21.1906261551190.32342@nanos.tec.linutronix.de>
References: <20190613145027.27753-1-bigeasy@linutronix.de> <20190626071719.psyftqdop4ny3zxd@linutronix.de> <20190626134957.GT657710@devbig004.ftw2.facebook.com>
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

> On Wed, Jun 26, 2019 at 09:17:19AM +0200, Sebastian Andrzej Siewior wrote:
> > On 2019-06-13 16:50:21 [+0200], To linux-kernel@vger.kernel.org wrote:
> > > Hi,
> > > 
> > > the workqueue code has been reworked in -RT to use raw_spinlock_t based
> > > locking. This change allows to schedule worker from preempt_disable()ed
> > > or IRQ disabled section on -RT. This is the last patch. The previous
> > > patches are prerequisites or tiny cleanup (like patch #1 and #2).
> > 
> > a gentle *ping*
> 
> I don't now what to make of the series.  AFAICS, there's no benefit to
> mainline.  What am I missing?

there is no downside either, right?

It helps with the ongoing RT integration into the mainline kernel and we
would appreciate if we can get the non controversial bits an pieces sorted.

Thanks,

	tglx


