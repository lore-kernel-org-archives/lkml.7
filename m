Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D62E4C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 08:17:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF52A204FD
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 08:17:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729457AbfDJIRb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 04:17:31 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:42088 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729080AbfDJIRb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 04:17:31 -0400
Received: from 79.184.255.221.ipv4.supernova.orange.pl (79.184.255.221) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.213)
 id 6b94f61ed903f552; Wed, 10 Apr 2019 10:17:28 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Yangtao Li <tiny.windzz@gmail.com>
Cc:     len.brown@intel.com, pavel@ucw.cz, gregkh@linuxfoundation.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] PM / core: Introduce dpm_async_fn() helper
Date:   Wed, 10 Apr 2019 10:15:17 +0200
Message-ID: <1823590.m8T6rWHPoh@aspire.rjw.lan>
In-Reply-To: <20190316045928.31934-2-tiny.windzz@gmail.com>
References: <20190316045928.31934-1-tiny.windzz@gmail.com> <20190316045928.31934-2-tiny.windzz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday, March 16, 2019 5:59:25 AM CEST Yangtao Li wrote:
> When we want to execute device pm functions asynchronously, we'll
> do the following for the device:
> 
>   1) reinit_completion(&dev->power.completion);
>   2) Check if the device enables asynchronous suspend.
>   3) If necessary, execute the corresponding function asynchronously.
> 
> There are a lot of such repeated operations here, in fact we can avoid
> this. So introduce dpm_async_fn() to have better code readability and
> reuse.
> 
> And use this function to do some cleanup.
> 
> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>

I'm queuing up this one, but the [2-4/4] are not convincing.

Thanks!

