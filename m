Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05C1EC3A5A1
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 14:15:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCF2C21743
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 14:15:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566483329;
	bh=X7qg/4sJ8kjLWq7LP64u/qzLlHOXJVQQQ2TJg2qBsVs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=gOZPyvBvNB04NTe/sVQm3JUJ8skTYHUhTj9Ll56qF333QBiKKySsSx7WLcLfqaXZV
	 +BWThcKk6y6ZYNMEYMzF7KhkCP0yK7p7zGrjWHVMZxHAr0UqMN8BrXKGfpL3UEfWSm
	 T/2T7dqfTRbKQYVJWSnUH//FNLGLGuwLqmccWF7k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387579AbfHVOP2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 10:15:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:46588 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726687AbfHVOP2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 10:15:28 -0400
Received: from localhost (lfbn-ncy-1-174-150.w83-194.abo.wanadoo.fr [83.194.254.150])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2219B205ED;
        Thu, 22 Aug 2019 14:15:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566483327;
        bh=X7qg/4sJ8kjLWq7LP64u/qzLlHOXJVQQQ2TJg2qBsVs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PJGOwa0UYsGUqqdnFrhnHDalkdQk9ZGof1CN4khquhRqOTi9NGOAvkODvL2eiMhIM
         gsAzo4im/3ATarP5GKLt6vdGqovwBQ6u2JdirOLeC9pi/d047SOlf3XRUJO0ioke3X
         HkqzrQAnm9/1GzoN9Rycl02Sqjn/WCXlyjNGiWpE=
Date:   Thu, 22 Aug 2019 16:15:25 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        John Stultz <john.stultz@linaro.org>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [patch V2 12/38] posix-cpu-timers: Remove pointless return value
 check
Message-ID: <20190822141524.GP22020@lenoir>
References: <20190821190847.665673890@linutronix.de>
 <20190821192920.339725769@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190821192920.339725769@linutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 21, 2019 at 09:08:59PM +0200, Thomas Gleixner wrote:
> set_process_cpu_timer() checks already whether the clock id is valid. No
> point in checking the return value of the sample function. That allows to
> simplify the sample function later.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
