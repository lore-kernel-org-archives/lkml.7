Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C5AAC3A5A1
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 14:07:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CC65233FC
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 14:07:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566482832;
	bh=6Q864FYY4/HBduQ+sQ/y/22Mq1RXMXDNwMdAd0odO7s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=mnKi4WKc2MrQyPEPmo6qhdkDAp5LlpgiP2WrMTm+RKGkFxiJlRrtOhCDto3u/jJPE
	 jq1/4pSBMmUFWjvVOHaPoKQghUF/7N/KQllCm30I//1Se+VG4v236KGwo947Lk8j3B
	 XdHaaEhpCZSJ6umHE6WHTIOVugi1fY9ZQM4kZ6PQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732967AbfHVOHL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 10:07:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:44264 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725987AbfHVOHL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 10:07:11 -0400
Received: from localhost (lfbn-ncy-1-174-150.w83-194.abo.wanadoo.fr [83.194.254.150])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A3EA422CE3;
        Thu, 22 Aug 2019 14:07:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566482830;
        bh=6Q864FYY4/HBduQ+sQ/y/22Mq1RXMXDNwMdAd0odO7s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tHn6AFP8kpVWK/koEfACur+OcTyuE2pdd1uaud8QmsD80f55EjAdD7FcjXaoXZqWu
         JGUZ+YrM4lbzZptTC5kQVfJP/dzXpJc92dMch47Bv3Vo/8n73AQYCKigNo8ya3YI3z
         X2R5l594jFl+l776ZsiDSDXU+Dh1QHbETK1byCk8=
Date:   Thu, 22 Aug 2019 16:07:07 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        John Stultz <john.stultz@linaro.org>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [patch V2 10/38] posix-cpu-timers: Use clock ID in
 posix_cpu_timer_get()
Message-ID: <20190822140706.GN22020@lenoir>
References: <20190821190847.665673890@linutronix.de>
 <20190821192920.155487201@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190821192920.155487201@linutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 21, 2019 at 09:08:57PM +0200, Thomas Gleixner wrote:
> Extract the clock ID (PROF/VIRT/SCHED) from the clock selector and use it
> as argument to the sample functions. That allows to simplify them once all
> callers are fixed.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
