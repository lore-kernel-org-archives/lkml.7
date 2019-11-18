Return-Path: <SRS0=CA45=ZK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D400C432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 08:24:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0EB92073A
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 08:24:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726721AbfKRIYz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 03:24:55 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:49811 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726600AbfKRIYz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 03:24:55 -0500
Received: from [213.220.153.21] (helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1iWcL5-0000FM-Mr; Mon, 18 Nov 2019 08:24:51 +0000
Date:   Mon, 18 Nov 2019 09:24:51 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Andrei Vagin <avagin@gmail.com>
Cc:     Adrian Reber <areber@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] selftests/clone3: flush stdout and stderr before
 clone3() and _exit()
Message-ID: <20191118082450.5gd65af3o7lttp4r@wittgenstein>
References: <20191118064750.408003-1-avagin@gmail.com>
 <20191118073747.i2kc2vk6opmx4jei@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191118073747.i2kc2vk6opmx4jei@wittgenstein>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 18, 2019 at 08:37:47AM +0100, Christian Brauner wrote:
> On Sun, Nov 17, 2019 at 10:47:48PM -0800, Andrei Vagin wrote:
> > Buffers have to be flushed before clone3() to avoid double messages in
> > the log.
> > 
> > Signed-off-by: Andrei Vagin <avagin@gmail.com>
> 
> Thanks, Andrei!
> Acked-by: Christian Brauner <christian.brauner@ubuntu.com>

I pushed another small change on top of your changes which takes care to
skip clone3() tests whenever the syscall is not supported:

https://git.kernel.org/pub/scm/linux/kernel/git/brauner/linux.git/commit/?h=pidfd&id=11fde161ab37f2938504bf896b48afbd18ea71cd

	Christian
