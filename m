Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C04EC3A5A6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 11:32:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1E9A21A49
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 11:32:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389905AbfISLc4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 07:32:56 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:55150 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388181AbfISLcz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 07:32:55 -0400
Received: from localhost (unknown [86.58.254.34])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id AB563154FB2DF;
        Thu, 19 Sep 2019 04:32:52 -0700 (PDT)
Date:   Thu, 19 Sep 2019 13:32:50 +0200 (CEST)
Message-Id: <20190919.133250.1851009450153650293.davem@davemloft.net>
To:     poeschel@lemonage.de
Cc:     swinslow@gmail.com, tglx@linutronix.de,
        kstewart@linuxfoundation.org, allison@lohutok.net,
        opensource@jilayne.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, johan@kernel.org, horms@verge.net.au
Subject: Re: [PATCH v8 1/7] nfc: pn533: i2c: "pn532" as dt compatible string
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190919091645.16439-1-poeschel@lemonage.de>
References: <20190919091645.16439-1-poeschel@lemonage.de>
X-Mailer: Mew version 6.8 on Emacs 26.2
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 19 Sep 2019 04:32:55 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


As we are in the merge window, the net-next tree is closed, as shown
also at:

	http://vger.kernel.org/~davem/net-next.html

Please resubmit this after the merge window when the net-next tree opens
back up.

Please also provide an appropriate "[PATCH 0/N]" header posting
explaining what the patch series is doing, how it is doing it, and
why it is doing it that way.

Thank you.
