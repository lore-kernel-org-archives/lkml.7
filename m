Return-Path: <SRS0=HtuS=UO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1DE3C31E44
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Jun 2019 02:26:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C02D8217F9
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Jun 2019 02:26:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726647AbfFOC0a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 22:26:30 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:57436 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725812AbfFOC03 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 22:26:29 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 7993D1341200A;
        Fri, 14 Jun 2019 19:26:29 -0700 (PDT)
Date:   Fri, 14 Jun 2019 19:26:29 -0700 (PDT)
Message-Id: <20190614.192629.1590309153811007708.davem@davemloft.net>
To:     tanhuazhong@huawei.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        salil.mehta@huawei.com, yisen.zhuang@huawei.com,
        linuxarm@huawei.com
Subject: Re: [PATCH net-next 00/12] net: hns3: some code optimizations &
 cleanups & bugfixes
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1560417152-53050-1-git-send-email-tanhuazhong@huawei.com>
References: <1560417152-53050-1-git-send-email-tanhuazhong@huawei.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Fri, 14 Jun 2019 19:26:29 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Huazhong Tan <tanhuazhong@huawei.com>
Date: Thu, 13 Jun 2019 17:12:20 +0800

> This patch-set includes code optimizations, cleanups and bugfixes for
> the HNS3 ethernet controller driver.
> 
> [patch 1/12 - 6/12] adds some code optimizations and bugfixes about RAS
> and MSI-X HW error.
> 
> [patch 7/12] fixes a loading issue.
> 
> [patch 8/12 - 11/12] adds some bugfixes.
> 
> [patch 12/12] adds some cleanups, which does not change the logic of code.

Series applied.
