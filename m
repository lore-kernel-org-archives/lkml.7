Return-Path: <SRS0=IBEs=VB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62F5EC0651F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 15:45:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4235C218A0
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 15:45:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727876AbfGDPpz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jul 2019 11:45:55 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:59403 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727394AbfGDPpw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 11:45:52 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1hj3vi-00055v-3l; Thu, 04 Jul 2019 17:45:50 +0200
Date:   Thu, 4 Jul 2019 17:45:50 +0200
From:   'Sebastian Andrzej Siewior' <bigeasy@linutronix.de>
To:     David Laight <David.Laight@ACULAB.COM>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 0/7] Use spinlock_t instead of struct spinlock
Message-ID: <20190704154549.q32q4kf4z7hdye7j@linutronix.de>
References: <20190704153803.12739-1-bigeasy@linutronix.de>
 <4456003dfa654444b8af7b7be9a9c30e@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4456003dfa654444b8af7b7be9a9c30e@AcuMS.aculab.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-07-04 15:39:41 [+0000], David Laight wrote:
> I thought it was policy to avoid typedefs?
> Probably because you can only define them once.

We don't have many of them but we have them and should stick to them.

|$ git grep -A4 "spinlock de" scripts/
|scripts/checkpatch.pl:# check for struct spinlock declarations
|scripts/checkpatch.pl-          if ($line =~ /^.\s*\bstruct\s+spinlock\s+\w+\s*;/) {
|scripts/checkpatch.pl-                  WARN("USE_SPINLOCK_T",
|scripts/checkpatch.pl-                       "struct spinlock should be spinlock_t\n" . $herecurr);
|scripts/checkpatch.pl-          }

> 	David

Sebastian
