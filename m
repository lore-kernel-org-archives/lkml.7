Return-Path: <SRS0=w4Fx=WO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCF7AC3A589
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Aug 2019 20:03:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A53FD21873
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Aug 2019 20:03:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727163AbfHRUDj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 18 Aug 2019 16:03:39 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:48152 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726089AbfHRUDj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Aug 2019 16:03:39 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::d71])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 428E114470B9C;
        Sun, 18 Aug 2019 13:03:38 -0700 (PDT)
Date:   Sun, 18 Aug 2019 13:03:37 -0700 (PDT)
Message-Id: <20190818.130337.1850671384098775638.davem@davemloft.net>
To:     wenwen@cs.uga.edu
Cc:     gregkh@linuxfoundation.org, allison@lohutok.net,
        tglx@linutronix.de, linux-usb@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: kalmia: fix memory leaks
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1565809005-8437-1-git-send-email-wenwen@cs.uga.edu>
References: <1565809005-8437-1-git-send-email-wenwen@cs.uga.edu>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sun, 18 Aug 2019 13:03:38 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wenwen Wang <wenwen@cs.uga.edu>
Date: Wed, 14 Aug 2019 13:56:43 -0500

> In kalmia_init_and_get_ethernet_addr(), 'usb_buf' is allocated through
> kmalloc(). In the following execution, if the 'status' returned by
> kalmia_send_init_packet() is not 0, 'usb_buf' is not deallocated, leading
> to memory leaks. To fix this issue, add the 'out' label to free 'usb_buf'.
> 
> Signed-off-by: Wenwen Wang <wenwen@cs.uga.edu>

Applied.
