Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 229BEC10F14
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 19:13:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00A1C20873
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 19:13:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730410AbfJCTNW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 15:13:22 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:56203 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726677AbfJCTNV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 15:13:21 -0400
Received: from [213.220.153.21] (helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1iG6XP-0007ex-8g; Thu, 03 Oct 2019 19:13:19 +0000
Date:   Thu, 3 Oct 2019 21:13:18 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Aleksa Sarai <cyphar@cyphar.com>,
        Kees Cook <keescook@chromium.org>,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
Subject: Re: [PATCH] usercopy: Add parentheses around assignment in
 test_copy_struct_from_user
Message-ID: <20191003191318.q6jvzuf46gjygpux@wittgenstein>
References: <20191003171121.2723619-1-natechancellor@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191003171121.2723619-1-natechancellor@gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 03, 2019 at 10:11:21AM -0700, Nathan Chancellor wrote:
> Clang warns:
> 
> lib/test_user_copy.c:96:10: warning: using the result of an assignment
> as a condition without parentheses [-Wparentheses]
>         if (ret |= test(umem_src == NULL, "kmalloc failed"))
>             ~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> lib/test_user_copy.c:96:10: note: place parentheses around the
> assignment to silence this warning
>         if (ret |= test(umem_src == NULL, "kmalloc failed"))
>                 ^
>             (                                              )
> lib/test_user_copy.c:96:10: note: use '!=' to turn this compound
> assignment into an inequality comparison
>         if (ret |= test(umem_src == NULL, "kmalloc failed"))
>                 ^~
>                 !=
> 
> Add the parentheses as it suggests because this is intentional.
> 
> Fixes: f5a1a536fa14 ("lib: introduce copy_struct_from_user() helper")
> Link: https://github.com/ClangBuiltLinux/linux/issues/731
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>

Applied to:
https://git.kernel.org/pub/scm/linux/kernel/git/brauner/linux.git/log/?h=copy_struct_from_user

Thanks!
Christian
