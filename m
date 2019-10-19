Return-Path: <SRS0=/uHP=YM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA2F8CA9EAC
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Oct 2019 19:17:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96A85222C2
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Oct 2019 19:17:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726259AbfJSTRD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 19 Oct 2019 15:17:03 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:42668 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726101AbfJSTRC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Oct 2019 15:17:02 -0400
Received: from localhost (unknown [64.79.112.2])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 15CB6149111B4;
        Sat, 19 Oct 2019 12:17:02 -0700 (PDT)
Date:   Sat, 19 Oct 2019 12:17:01 -0700 (PDT)
Message-Id: <20191019.121701.1422979804966345191.davem@davemloft.net>
To:     chenwandun@huawei.com
Cc:     igor.russkikh@aquantia.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] net: aquantia: add an error handling in
 aq_nic_set_multicast_list
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1571394037-19978-1-git-send-email-chenwandun@huawei.com>
References: <1571394037-19978-1-git-send-email-chenwandun@huawei.com>
X-Mailer: Mew version 6.8 on Emacs 26.2
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sat, 19 Oct 2019 12:17:02 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chen Wandun <chenwandun@huawei.com>
Date: Fri, 18 Oct 2019 18:20:37 +0800

> From: Chenwandun <chenwandun@huawei.com>
> 
> add an error handling in aq_nic_set_multicast_list, it may not
> work when hw_multicast_list_set error; and at the same time
> it will remove gcc Wunused-but-set-variable warning.
> 
> Signed-off-by: Chenwandun <chenwandun@huawei.com>

Applied, thanks.
