Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2854C3A59F
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 22:29:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 980E9217F5
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 22:29:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566858568;
	bh=1w9GIDlEJWDjZ63L7+0XjSR5Dgi5qyM5Pw3adISnHyU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=JP2QjC7zXVw032JaCXNd7ecoy+HZPynZsy/+hYuq+63Z1Y0kmLE75SCmF3lYQvRI1
	 UKaOe1KM1GFzWPzaRWUhoH7ZrgakukkUi34IOWpFUrSjJY1KQmtPGVv+FyfiIOkyv9
	 6NgIL+iVj5BoWvNr9pyib24qKuVWjYoENC8NyP8Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726556AbfHZW31 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 18:29:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:56308 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726020AbfHZW31 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 18:29:27 -0400
Received: from localhost (lfbn-ncy-1-174-150.w83-194.abo.wanadoo.fr [83.194.254.150])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1F2BE2080C;
        Mon, 26 Aug 2019 22:29:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566858566;
        bh=1w9GIDlEJWDjZ63L7+0XjSR5Dgi5qyM5Pw3adISnHyU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jP9UlAgPwJKcSQuFRNrlaRF+Rjh3AfBin6g9GqEkK8NeRxdEzCQdkbPUGGyTBmKzf
         8i2YVvG4EYqovDIPwcLBFNje771A6ca8fPf3VaQrN4zPTvoHicdq3Dz+LfzpB5S4OB
         mrb+AXxGxSY/YXCLc1Oh+pxjK4+C0rpKSzDIZQIM=
Date:   Tue, 27 Aug 2019 00:29:24 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        John Stultz <john.stultz@linaro.org>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [patch V2 33/38] posix-cpu-timers: Consolidate timer expiry
 further
Message-ID: <20190826222923.GH14309@lenoir>
References: <20190821190847.665673890@linutronix.de>
 <20190821192922.365469982@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190821192922.365469982@linutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 21, 2019 at 09:09:20PM +0200, Thomas Gleixner wrote:
> With the array based samples and expiry cache, the expiry function can use
> a loop to collect timers from the clock specific lists.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
