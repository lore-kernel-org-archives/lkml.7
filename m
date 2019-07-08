Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D886C48BE7
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 05:15:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D741F20651
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 05:15:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728389AbfGHFPh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 01:15:37 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:46698 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727286AbfGHFPg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 01:15:36 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::d71])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 32975152F705A;
        Sun,  7 Jul 2019 22:15:36 -0700 (PDT)
Date:   Sun, 07 Jul 2019 22:15:33 -0700 (PDT)
Message-Id: <20190707.221533.1451476107935716883.davem@davemloft.net>
To:     xuechaojing@huawei.com
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        luoshaokai@huawei.com, cloud.wangxiaoyun@huawei.com,
        chiqijun@huawei.com, wulike1@huawei.com
Subject: Re: [PATCH net-next] hinic: add fw version query
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190705024028.5768-1-xuechaojing@huawei.com>
References: <20190705024028.5768-1-xuechaojing@huawei.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sun, 07 Jul 2019 22:15:36 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xue Chaojing <xuechaojing@huawei.com>
Date: Fri, 5 Jul 2019 02:40:28 +0000

> This patch adds firmware version query in ethtool -i.
> 
> Signed-off-by: Xue Chaojing <xuechaojing@huawei.com>

Applied, thank you.
