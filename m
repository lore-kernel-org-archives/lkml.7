Return-Path: <SRS0=KmSF=VS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE4B7C76191
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jul 2019 20:31:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8FC22085A
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jul 2019 20:31:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727605AbfGUUbi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Jul 2019 16:31:38 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:34708 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726748AbfGUUbi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Jul 2019 16:31:38 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::d71])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 79FD615265E1C;
        Sun, 21 Jul 2019 13:31:37 -0700 (PDT)
Date:   Sun, 21 Jul 2019 13:31:37 -0700 (PDT)
Message-Id: <20190721.133137.1744555681294107147.davem@davemloft.net>
To:     vvs@virtuozzo.com
Cc:     linux-kernel@vger.kernel.org, zbr@ioremap.net,
        stanislav.kinsburskiy@gmail.com, netdev@vger.kernel.org
Subject: Re: [PATCH] connector: remove redundant input callback from cn_dev
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1f53c1fb-c42e-fb78-7b2b-ad6c4712fe72@virtuozzo.com>
References: <1f53c1fb-c42e-fb78-7b2b-ad6c4712fe72@virtuozzo.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sun, 21 Jul 2019 13:31:37 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vasily Averin <vvs@virtuozzo.com>
Date: Thu, 18 Jul 2019 07:26:46 +0300

> A small cleanup: this callback is never used.
> Originally fixed by Stanislav Kinsburskiy <skinsbursky@virtuozzo.com>
> for OpenVZ7 bug OVZ-6877
> 
> cc: stanislav.kinsburskiy@gmail.com
> Signed-off-by: Vasily Averin <vvs@virtuozzo.com>

Applied.
