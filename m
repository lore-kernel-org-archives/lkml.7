Return-Path: <SRS0=YpA9=XT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACCFBC432C2
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 20:01:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B58D207FD
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 20:01:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2633413AbfIXUBj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Sep 2019 16:01:39 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:38677 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728014AbfIXUBj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Sep 2019 16:01:39 -0400
Received: from mon75-17-88-175-211-167.fbx.proxad.net ([88.175.211.167] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1iCr0C-0007jN-MJ; Tue, 24 Sep 2019 20:01:36 +0000
Date:   Tue, 24 Sep 2019 22:01:35 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     shuah@kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH] selftests: pidfd: Fix undefined reference to
 pthread_create()
Message-ID: <20190924200134.x7ij7y24z45hizs5@wittgenstein>
References: <20190924195237.30519-1-skhan@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190924195237.30519-1-skhan@linuxfoundation.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 24, 2019 at 01:52:37PM -0600, Shuah Khan wrote:
> Fix build failure:
> 
> undefined reference to `pthread_create'
> collect2: error: ld returned 1 exit status
> 
> Fix CFLAGS to include pthread correctly.
> 
> Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>

Reviewed-by: Christian Brauner <christian.brauner@ubuntu.com>

Thanks, Shuah!
Queued-up in my fixes branch and will be included after the merge window
closes. I'll also add a fixes tag and a cc for stable since this should
very likely be backported.

Christian
