Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5486BC432C3
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 20:25:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 357882088F
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 20:25:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726825AbfKTUZV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 15:25:21 -0500
Received: from namei.org ([65.99.196.166]:41352 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725854AbfKTUZU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 15:25:20 -0500
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id xAKKOefM008893;
        Wed, 20 Nov 2019 20:24:40 GMT
Date:   Thu, 21 Nov 2019 07:24:40 +1100 (AEDT)
From:   James Morris <jmorris@namei.org>
To:     Borislav Petkov <bp@alien8.de>
cc:     Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Zhang Xiaoxu <zhangxiaoxu5@huawei.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        tyhicks@canonical.com, colin.king@canonical.com,
        linux-security-module@vger.kernel.org,
        Matthew Garrett <mjg59@google.com>
Subject: Re: [PATCH] x86/mtrr: Require CAP_SYS_ADMIN for all access
In-Reply-To: <20191119100753.GA27787@zn.tnic>
Message-ID: <alpine.LRH.2.21.1911210724270.8834@namei.org>
References: <201911181308.63F06502A1@keescook> <20191119100753.GA27787@zn.tnic>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Nov 2019, Borislav Petkov wrote:

> >  arch/x86/kernel/cpu/mtrr/if.c | 21 ++-------------------
> >  1 file changed, 2 insertions(+), 19 deletions(-)
> 
> Yap, LGTM, thanks!
> 
> Reviewed-by: Borislav Petkov <bp@suse.de>


Acked-by: James Morris <jamorris@linux.microsoft.com>

-- 
James Morris
<jmorris@namei.org>

