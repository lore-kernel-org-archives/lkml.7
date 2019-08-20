Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B722C3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 13:48:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16BCF22DA9
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 13:48:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566308931;
	bh=t8fy6w3wYr+VsVEY4fDmv6C2ARiBO6J32fRoc4rxhh0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=xIIeUW/5rpgIWOVzQJF1aIwNBgQElwW7dN3V4/rRln3YuDihCF5o5WEQWSOBTzxkj
	 hbgUHqmzqhbPm7ltHhXcBvc5rmfBC00KVQ5qjFPP//yvLVpJ/bAGz+F0NoY7MlJusC
	 5xKVXwj5SPSwnIqKvaNtRygjTYt0vh4WUJWyUxfs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730310AbfHTNsu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 09:48:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:43348 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729833AbfHTNst (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 09:48:49 -0400
Received: from localhost (lfbn-ncy-1-174-150.w83-194.abo.wanadoo.fr [83.194.254.150])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 52F062087E;
        Tue, 20 Aug 2019 13:48:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566308928;
        bh=t8fy6w3wYr+VsVEY4fDmv6C2ARiBO6J32fRoc4rxhh0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=N17Z5BV0r5SK9N1g5HhyznCv9cz9nSOIGjDSM/uIMHTpuUztLZ8QTH8zGD5qul66u
         7ckOgJv3VaFlSCr/AhgCSCB69pa/S9oQfGAVLYBdCVvE3HF8BTxSObsPwd/x7RTyj3
         KieTgMg4l4QQir1d3pV30kjIPQkpxSKctnbW39R0=
Date:   Tue, 20 Aug 2019 15:48:46 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        John Stultz <john.stultz@linaro.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>
Subject: Re: [patch 01/44] posix-timers: Cleanup forward declarations and
 includes
Message-ID: <20190820134845.GD2093@lenoir>
References: <20190819143141.221906747@linutronix.de>
 <20190819143801.472005793@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190819143801.472005793@linutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 19, 2019 at 04:31:42PM +0200, Thomas Gleixner wrote:
>  - Rename struct siginfo to kernel_siginfo
>  - Add a forward declaration for task_struct and remove sched.h include
>  - Remove timex.h include as it is not needed
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
