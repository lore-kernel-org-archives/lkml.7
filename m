Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B942EC072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 18:44:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9688D217F9
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 18:44:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732045AbfEXSof (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 14:44:35 -0400
Received: from foss.arm.com ([217.140.101.70]:48922 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728594AbfEXSof (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 14:44:35 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 13250A78;
        Fri, 24 May 2019 11:44:35 -0700 (PDT)
Received: from fuggles.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2632D3F703;
        Fri, 24 May 2019 11:44:34 -0700 (PDT)
Date:   Fri, 24 May 2019 19:44:31 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     Anders Roxell <anders.roxell@linaro.org>
Cc:     peterz@infradead.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] locking/lockdep: remove print_lock_trace function
Message-ID: <20190524184431.GF9697@fuggles.cambridge.arm.com>
References: <20190516191326.27003-1-anders.roxell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190516191326.27003-1-anders.roxell@linaro.org>
User-Agent: Mutt/1.11.1+86 (6f28e57d73f2) ()
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 16, 2019 at 09:13:26PM +0200, Anders Roxell wrote:
> gcc warns that function print_lock_trace() is unused if
> CONFIG_PROVE_LOCKING isn't set.
> 
> ../kernel/locking/lockdep.c:2820:13: warning: ‘print_lock_trace’ defined
>    but not used [-Wunused-function]
>  static void print_lock_trace(struct lock_trace *trace, unsigned int
>    spaces)
> 
> Rework so we remove the function if CONFIG_PROVE_LOCKING isn't set.
> 
> Fixes: c120bce78065 ("lockdep: Simplify stack trace handling")
> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
> ---
>  kernel/locking/lockdep.c | 4 ----
>  1 file changed, 4 deletions(-)

Acked-by: Will Deacon <will.deacon@arm.com>

Will
