Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79A5FC17440
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 10:28:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 462E821783
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 10:28:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726949AbfKLK2U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 05:28:20 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:46656 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725834AbfKLK2T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 05:28:19 -0500
Received: from p54ac5726.dip0.t-ipconnect.de ([84.172.87.38] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1iUTPE-0003ag-9W; Tue, 12 Nov 2019 10:28:16 +0000
Date:   Tue, 12 Nov 2019 11:28:15 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Adrian Reber <areber@redhat.com>
Cc:     Shuah Khan <shuah@kernel.org>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] selftests: add tests for clone3()
Message-ID: <20191112102814.xkml5etvogzsr7xq@wittgenstein>
References: <20191112095851.811884-1-areber@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191112095851.811884-1-areber@redhat.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 12, 2019 at 10:58:51AM +0100, Adrian Reber wrote:
> This adds tests for clone3() with different values and sizes
> of struct clone_args.
> 
> This selftest was initially part of of the clone3() with PID selftest.
> After that patch was almost merged Eugene sent out a couple of patches
> to fix problems with these test.
> 
> This commit now only contains the clone3() selftest after the LPC
> decision to rework clone3() with PID to allow setting the PID in
> multiple PID namespaces including all of Eugene's patches.
> 
> Signed-off-by: Eugene Syromiatnikov <esyr@redhat.com>
> Signed-off-by: Adrian Reber <areber@redhat.com>

Queuing up for 5.5.
Thanks, Adrian!

Reviewed-by: Christian Brauner <christian.brauner@ubuntu.com>
