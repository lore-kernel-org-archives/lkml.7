Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D950C3A5A1
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 16:29:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CECC523400
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 16:29:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566491367;
	bh=tlhh3+hhbvu7mxMtCvbFv7IgAIhaeXKHfRMW4ns9H6c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=qYp5XYqDSNDzVOH1u+NYvZQPqyy8Bne3y5gOKjN1hQtNvYFk54nY/X8+buWd/1GbW
	 FmZrYvraHxt7bvfkt7rmW5l6q5l/Mgzw3CPWKPilr9EI6dfnBxGR5UnpXE6JJppTZa
	 TRNMHE39SwyzbwnXCi5bjcjTzxIz5w8bH+ocq3gk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389944AbfHVQ30 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 12:29:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:45520 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733046AbfHVQ30 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 12:29:26 -0400
Received: from localhost (lfbn-ncy-1-174-150.w83-194.abo.wanadoo.fr [83.194.254.150])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 14E21233FD;
        Thu, 22 Aug 2019 16:29:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566491365;
        bh=tlhh3+hhbvu7mxMtCvbFv7IgAIhaeXKHfRMW4ns9H6c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=U34MEWpexdwSosRskVgfFO5tTT1ZFqCfsj46ucCseGghRUzEG6pTTCuzBjTXkAsxC
         2cuhWEfH6Jw5dTbwBfdMlOyFNUHwC67lfNUcG4ptkinA2+pjFLi+Dhbjws6ewetmyL
         zGd7+EV/NBDx08wJtAzwaXmEhnu+Bgcw3+EmLsiw=
Date:   Thu, 22 Aug 2019 18:29:23 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        John Stultz <john.stultz@linaro.org>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [patch V2 19/38] posix-cpu-timers: Move expiry cache into struct
 posix_cputimers
Message-ID: <20190822162922.GB8025@lenoir>
References: <20190821190847.665673890@linutronix.de>
 <20190821192921.014444012@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190821192921.014444012@linutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 21, 2019 at 09:09:06PM +0200, Thomas Gleixner wrote:
> The expiry cache belongs into the posix_cputimers container where the other
> cpu timers information is.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
