Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53570C10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 20:01:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2842220880
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 20:01:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727208AbfDHUBu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 16:01:50 -0400
Received: from mx2.suse.de ([195.135.220.15]:60682 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726220AbfDHUBt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 16:01:49 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 29768B018;
        Mon,  8 Apr 2019 20:01:48 +0000 (UTC)
Date:   Mon, 8 Apr 2019 13:01:41 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Kees Cook <keescook@chromium.org>
Cc:     Shuah Khan <shuah@kernel.org>,
        Stanislav Kinsbursky <skinsbursky@parallels.com>,
        Manfred Spraul <manfred@colorfullife.com>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests/ipc: Fix msgque compiler warnings
Message-ID: <20190408200141.uusxqlqly6tab6h7@linux-r8p5>
References: <20190408171344.GA22803@beast>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20190408171344.GA22803@beast>
User-Agent: NeoMutt/20180323
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 08 Apr 2019, Kees Cook wrote:

>This fixes the various compiler warnings when building the msgque
>selftest. The primary change is using sys/msg.h instead of linux/msg.h
>directly to gain the API declarations.
>
>Fixes: 3a665531a3b7 ("selftests: IPC message queue copy feature test")
>Signed-off-by: Kees Cook <keescook@chromium.org>

(Not really related to this patch)

Given that the selftest/ipc/ only consists of this test, I wonder if
the test should just be moved to ltp, where the ipc tests are a lot
more complete and robust -- and which I've been using for years for
basic testing code changes.

Don't get me wrong, I'm all for having ipc tests in the kernel, but it
seems rather impractical to have them in both places considering the
relevance of ltp in the community and how long they have existed there.

I'm also speaking on the basis that by ipc we are referring only to
sysv and posix flavors.

Thanks,
Davidlohr
