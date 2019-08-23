Return-Path: <SRS0=31nU=WT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8AC5C3A5A2
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 22:50:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DBE321726
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 22:50:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566600605;
	bh=eYAG1X9WDD4xzkAH2NydWyQMeTuejVRrxVaVeNeAM3g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=hx7ZIDM+/r/9vVxGXpM3F2XnVT/XDoDKlNHkpP/ubpTKvu+iRd7ri0ZyU4AWLK7Tc
	 Ef7Rb/GBKBuxdtaQoxZ7u8AZGTTtuk+xMOip0NyFmcB8UPWITrUegnHg3zYRUUOCof
	 hvm039lxnmKAjC5elnGWDPXAa6KsNqkBGoTvMBNI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726530AbfHWWuE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Aug 2019 18:50:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:59400 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726371AbfHWWuE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Aug 2019 18:50:04 -0400
Received: from localhost (lfbn-ncy-1-174-150.w83-194.abo.wanadoo.fr [83.194.254.150])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D533E21019;
        Fri, 23 Aug 2019 22:50:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566600603;
        bh=eYAG1X9WDD4xzkAH2NydWyQMeTuejVRrxVaVeNeAM3g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nwDyPVI0ABH1BH39ifLtRuePnnK8IKLeqIKB2pjcb9JAiIYT0jTiN/pFB/HH0yCxu
         XG2ZKBZQ1DBs+0WmWijejD3UIakpEqFsjlYDdBKv8MgVdBx5AD5KaiZ1fYMr22hnwy
         ub7B4FT/ESGBLgLubP8CrkPtcrDmlUsnEgg9VUII=
Date:   Sat, 24 Aug 2019 00:50:01 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        John Stultz <john.stultz@linaro.org>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [patch V2 27/38] posix-cpu-timers: Remove cputime_expires
Message-ID: <20190823225000.GH18880@lenoir>
References: <20190821190847.665673890@linutronix.de>
 <20190821192921.790209622@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190821192921.790209622@linutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 21, 2019 at 09:09:14PM +0200, Thomas Gleixner wrote:
> The last users of the magic struct cputime based expiry cache are
> gone. Remove the leftovers.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
