Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E46DC32757
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 17:24:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3113320665
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 17:24:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729862AbfHNRYo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 13:24:44 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:56720 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729237AbfHNRYl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 13:24:41 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::202])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 3A582154EA06E;
        Wed, 14 Aug 2019 10:24:41 -0700 (PDT)
Date:   Wed, 14 Aug 2019 13:24:37 -0400 (EDT)
Message-Id: <20190814.132437.1179749424846743135.davem@davemloft.net>
To:     efremov@linux.com
Cc:     linux-kernel@vger.kernel.org, joe@perches.com,
        sridhar.samudrala@intel.com, netdev@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: net_failover: Fix typo in a filepath
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190813060530.13138-1-efremov@linux.com>
References: <20190325212732.27253-1-joe@perches.com>
        <20190813060530.13138-1-efremov@linux.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 14 Aug 2019 10:24:41 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Denis Efremov <efremov@linux.com>
Date: Tue, 13 Aug 2019 09:05:30 +0300

> Replace "driver" with "drivers" in the filepath to net_failover.c
> 
> Cc: Sridhar Samudrala <sridhar.samudrala@intel.com>
> Cc: David S. Miller <davem@davemloft.net>
> Cc: netdev@vger.kernel.org
> Fixes: cfc80d9a1163 ("net: Introduce net_failover driver")
> Signed-off-by: Denis Efremov <efremov@linux.com>

Applied.
