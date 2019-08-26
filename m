Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8091C3A5A5
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 09:21:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A31A522D6D
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 09:21:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730902AbfHZJVN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 05:21:13 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:41622 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726354AbfHZJVN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 05:21:13 -0400
Received: from 79.184.255.249.ipv4.supernova.orange.pl (79.184.255.249) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.275)
 id c30894ed6953de11; Mon, 26 Aug 2019 11:21:11 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Qian Cai <cai@lca.pw>, Tri Vo <trong@android.com>
Subject: Re: [PATCH v4 0/2] PM / wakeup: Fix wakeup class wrecakge in -next
Date:   Mon, 26 Aug 2019 11:21:11 +0200
Message-ID: <2610837.FtSX2PM0xo@kreacher>
In-Reply-To: <20190819224158.62954-1-swboyd@chromium.org>
References: <20190819224158.62954-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, August 20, 2019 12:41:56 AM CEST Stephen Boyd wrote:
> Resending the patch series to pick up the tags and fix the subject
> on patch #2. I didn't drop the "Fixes" tags even though they're
> just in -next and the patches have been dropped in the latest version.
> Please update them in the future so we know what commit they're fixing
> if the commits change in the pm tree.
> 
> Changes from v3:
>  * Picked up reviewed-by tags from Tri Vo
>  * Fixed Cc tag on patch 2
>  * Fixed subject on patch 2 to speak about proper symbols
> 
> Changes from v2:
>  * Fix logic for not adding the wakeup class from dpm_sysfs_add()
>  * Compile tested on !CONFIG_PM_SLEEP
> 
> Cc: Qian Cai <cai@lca.pw>
> Cc: Tri Vo <trong@android.com>
> 
> Stephen Boyd (2):
>   PM / wakeup: Register wakeup class kobj after device is added
>   PM / wakeup: Unexport wakeup_source_sysfs_{add,remove}()
> 
>  drivers/base/power/power.h        |  9 +++++++++
>  drivers/base/power/sysfs.c        |  6 ++++++
>  drivers/base/power/wakeup.c       | 10 ++++++----
>  drivers/base/power/wakeup_stats.c | 15 +++++++++++++--
>  4 files changed, 34 insertions(+), 6 deletions(-)
> 
> 
> base-commit: 0c3d3d648b3ed72b920a89bc4fd125e9b7aa5f23
> 

Both patches applied, thanks!




