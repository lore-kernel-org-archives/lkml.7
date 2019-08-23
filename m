Return-Path: <SRS0=31nU=WT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46F43C3A5A2
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 18:00:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 215D021848
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 18:00:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566583213;
	bh=NDvJ1QzGmaK9TQIh6SAFor70uhluXcdgV1e2jycGWBk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=vICTYFwX9Pm3WHr6MmD7IS/7dbWe95JjwZcF38IPzABcd1MdbAGh1vjwfUn7UDTII
	 zgu4BTksWgx9gUbx/2BwQEqTujs+NImbe7wJGjz3znRG5jiTSfTgr0BLxbkm7z0nFA
	 L5Xzt25pmTeHdELbwpP4SnAnABU/kc/ko1IO7mD8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390290AbfHWSAM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Aug 2019 14:00:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:45176 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388081AbfHWSAK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Aug 2019 14:00:10 -0400
Received: from localhost (lfbn-ncy-1-174-150.w83-194.abo.wanadoo.fr [83.194.254.150])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1034B21874;
        Fri, 23 Aug 2019 18:00:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566583209;
        bh=NDvJ1QzGmaK9TQIh6SAFor70uhluXcdgV1e2jycGWBk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZS6CeaWny0IFuOgnOJIKZDAovewPOgeTsuJaBlPzE7GOYooqtdoVc15hr2cGJImEf
         PWBj5pvnLTFeFR74uPcrrxy6qMlY/laTRrYLpCmWmlT4sKK6dyidFw5Y2u1V4UZwHr
         eiRaywWKK+SM4bGzz07GunPeDQozw+J5Gpbbaud4=
Date:   Fri, 23 Aug 2019 20:00:07 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        John Stultz <john.stultz@linaro.org>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [patch V2 22/38] posix-cpu-timers: Simplify
 set_process_cpu_timer()
Message-ID: <20190823180006.GC18880@lenoir>
References: <20190821190847.665673890@linutronix.de>
 <20190821192921.303316423@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190821192921.303316423@linutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 21, 2019 at 09:09:09PM +0200, Thomas Gleixner wrote:
> The expiry cache can now be accessed as an array. Replace the per clock
> checks with a simple comparison of the clock indexed array member.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
