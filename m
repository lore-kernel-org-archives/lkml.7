Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F370AC43603
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 22:27:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBF0B20637
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 22:27:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727002AbfLIW1x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 17:27:53 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:36474 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726156AbfLIW1x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 17:27:53 -0500
Received: from localhost (unknown [IPv6:2601:601:9f00:1c3::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id BBF93154925DC;
        Mon,  9 Dec 2019 14:27:52 -0800 (PST)
Date:   Mon, 09 Dec 2019 14:27:52 -0800 (PST)
Message-Id: <20191209.142752.72047324724544266.davem@davemloft.net>
To:     maowenan@huawei.com
Cc:     gregkh@linuxfoundation.org, alexios.zavras@intel.com,
        oneukum@suse.com, tglx@linutronix.de, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        hulkci@huawei.com
Subject: Re: [PATCH v2 -next] NFC: port100: Convert
 cpu_to_le16(le16_to_cpu(E1) + E2) to use le16_add_cpu().
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20191209130845.47777-1-maowenan@huawei.com>
References: <20191209130845.47777-1-maowenan@huawei.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 09 Dec 2019 14:27:53 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mao Wenan <maowenan@huawei.com>
Date: Mon, 9 Dec 2019 21:08:45 +0800

> Convert cpu_to_le16(le16_to_cpu(frame->datalen) + len) to
> use le16_add_cpu(), which is more concise and does the same thing. 
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Mao Wenan <maowenan@huawei.com>

Applied, thanks.
