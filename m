Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55B31ECE59D
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 21:59:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BE5D2084B
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 21:59:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732405AbfJOV7P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 17:59:15 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:40758 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728723AbfJOV7P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 17:59:15 -0400
Received: from localhost (unknown [IPv6:2601:601:9f00:1e2::d71])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 0CBAC1265C1F1;
        Tue, 15 Oct 2019 14:59:15 -0700 (PDT)
Date:   Tue, 15 Oct 2019 14:59:11 -0700 (PDT)
Message-Id: <20191015.145911.716932933579995114.davem@davemloft.net>
To:     vcaputo@pengaru.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: core: datagram: tidy up copy functions a bit
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20191012115509.jrqe43yozs7kknv5@shells.gnugeneration.com>
References: <20191012115509.jrqe43yozs7kknv5@shells.gnugeneration.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Tue, 15 Oct 2019 14:59:15 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vito Caputo <vcaputo@pengaru.com>
Date: Sat, 12 Oct 2019 04:55:09 -0700

> +	if ((copy = min(start - offset, len)) > 0) {

As Eric said, we try to avoid this very construct these days.

I'm not applying this patch.

Thank you.
