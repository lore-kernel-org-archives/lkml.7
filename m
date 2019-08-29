Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 384CAC3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 23:58:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A4252166E
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 23:58:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727096AbfH2X6K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 19:58:10 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:55504 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726084AbfH2X6K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 19:58:10 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::d71])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 69BCC153C952A;
        Thu, 29 Aug 2019 16:58:09 -0700 (PDT)
Date:   Thu, 29 Aug 2019 16:58:08 -0700 (PDT)
Message-Id: <20190829.165808.749785938274688937.davem@davemloft.net>
To:     tanhuazhong@huawei.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        salil.mehta@huawei.com, yisen.zhuang@huawei.com,
        linuxarm@huawei.com
Subject: Re: [PATCH net-next 00/12] net: hns3: add some cleanups and
 optimizations
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1567002196-63242-1-git-send-email-tanhuazhong@huawei.com>
References: <1567002196-63242-1-git-send-email-tanhuazhong@huawei.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 29 Aug 2019 16:58:09 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Huazhong Tan <tanhuazhong@huawei.com>
Date: Wed, 28 Aug 2019 22:23:04 +0800

> This patch-set includes cleanups, optimizations and bugfix for
> the HNS3 ethernet controller driver.
 ...

Series applied, thanks.
