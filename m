Return-Path: <SRS0=bFUY=XM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4A91C4CEC9
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 07:34:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2AF220644
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 07:34:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404488AbfIQHeh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Sep 2019 03:34:37 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:44951 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404465AbfIQHeg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 03:34:36 -0400
Received: from static-dcd-cqq-121001.business.bouyguestelecom.com ([212.194.121.1] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1iA80O-0001j7-JQ; Tue, 17 Sep 2019 07:34:32 +0000
Date:   Tue, 17 Sep 2019 09:34:32 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Seth Forshee <seth.forshee@canonical.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched: Add __ASSEMBLY__ guards around struct clone_args
Message-ID: <20190917073431.6k2gumjah7htzqan@wittgenstein>
References: <20190917071853.12385-1-seth.forshee@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190917071853.12385-1-seth.forshee@canonical.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 17, 2019 at 09:18:53AM +0200, Seth Forshee wrote:
> The addition of struct clone_args to uapi/linux/sched.h is not
> protected by __ASSEMBLY__ guards, causing a FTBFS for glibc on
> RISC-V. Add the guards to fix this.
> 
> Fixes: 7f192e3cd316 ("fork: add clone3")
> Signed-off-by: Seth Forshee <seth.forshee@canonical.com>

Applied to:
https://git.kernel.org/pub/scm/linux/kernel/git/brauner/linux.git/log/?h=fixes

Just replaced FTBS with "failure to build from source" since I had to
search for this and also added Cc: <stable@vger.kernel.org> for 5.3.

Thanks!
Christian
