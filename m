Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8438C43218
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 07:52:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94887208E3
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 07:52:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404493AbfFKHwk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 03:52:40 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:57158 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404084AbfFKHwk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 03:52:40 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1haba9-00046K-LL; Tue, 11 Jun 2019 09:52:37 +0200
Date:   Tue, 11 Jun 2019 09:52:37 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Christoph Hellwig <hch@lst.de>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/3] x86/fpu: don't use current->mm to check for a kthread
Message-ID: <20190611075236.r54rclevt2ehetdv@linutronix.de>
References: <20190604071524.12835-1-hch@lst.de>
 <20190604175411.GA27477@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190604175411.GA27477@lst.de>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-06-04 19:54:12 [+0200], Christoph Hellwig wrote:
> current->mm can be non-NULL if a kthread calls use_mm.  Check for
> PF_KTHREAD instead to decide when to store user mode FP state.
> 
> Fixes: 2722146eb784 ("x86/fpu: Remove fpu->initialized")
> Reported-by: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Acked-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

For the whole series.

Sebastian
