Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9454C7618F
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 01:22:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 911E221BF6
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 01:22:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387727AbfGWBWh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 21:22:37 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:52534 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727088AbfGWBWh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 21:22:37 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::d71])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 473B015305A1D;
        Mon, 22 Jul 2019 18:22:36 -0700 (PDT)
Date:   Mon, 22 Jul 2019 18:22:35 -0700 (PDT)
Message-Id: <20190722.182235.195933962601112626.davem@davemloft.net>
To:     hslester96@gmail.com
Cc:     woojung.huh@microchip.com, UNGLinuxDriver@microchip.com,
        steve.glendinning@shawell.net, linux-usb@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: usb: Merge cpu_to_le32s + memcpy to
 put_unaligned_le32
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190722074133.17777-1-hslester96@gmail.com>
References: <20190722074133.17777-1-hslester96@gmail.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 22 Jul 2019 18:22:36 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chuhong Yuan <hslester96@gmail.com>
Date: Mon, 22 Jul 2019 15:41:34 +0800

> Merge the combo uses of cpu_to_le32s and memcpy.
> Use put_unaligned_le32 instead.
> This simplifies the code.
> 
> Signed-off-by: Chuhong Yuan <hslester96@gmail.com>

Isn't the skb->data aligned to 4 bytes in these situations?

If so, we should use the aligned variants.

Thank you.
