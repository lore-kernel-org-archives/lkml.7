Return-Path: <SRS0=tJqY=VY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C306CC7618B
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jul 2019 06:13:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94BE020840
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jul 2019 06:13:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728079AbfG0GN4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Jul 2019 02:13:56 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:50888 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725905AbfG0GN4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Jul 2019 02:13:56 -0400
Received: from pd9ef1cb8.dip0.t-ipconnect.de ([217.239.28.184] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hrFxp-0000c9-4B; Sat, 27 Jul 2019 08:13:53 +0200
Date:   Sat, 27 Jul 2019 08:13:51 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Andrew Morton <akpm@linux-foundation.org>
cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>, linux-mm@kvack.org
Subject: Re: [PATCH 2/7] vmpressure: Use spinlock_t instead of struct
 spinlock
In-Reply-To: <20190726155033.d10771437e26dd5007f91a08@linux-foundation.org>
Message-ID: <alpine.DEB.2.21.1907270813370.1791@nanos.tec.linutronix.de>
References: <20190704153803.12739-1-bigeasy@linutronix.de> <20190704153803.12739-3-bigeasy@linutronix.de> <alpine.DEB.2.21.1907261409260.1791@nanos.tec.linutronix.de> <20190726155033.d10771437e26dd5007f91a08@linux-foundation.org>
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

On Fri, 26 Jul 2019, Andrew Morton wrote:
> On Fri, 26 Jul 2019 14:09:50 +0200 (CEST) Thomas Gleixner <tglx@linutronix.de> wrote:
> 
> > On Thu, 4 Jul 2019, Sebastian Andrzej Siewior wrote:
> > 
> > Polite reminder ...
> 
> Already upstream!

Ooops.
