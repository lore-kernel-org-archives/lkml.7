Return-Path: <SRS0=5V/v=RU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EF1FC43381
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Mar 2019 01:21:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7317F20857
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Mar 2019 01:21:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727248AbfCQBVV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Mar 2019 21:21:21 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:46292 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726726AbfCQBVU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Mar 2019 21:21:20 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 13836133E9758;
        Sat, 16 Mar 2019 18:21:20 -0700 (PDT)
Date:   Sat, 16 Mar 2019 18:21:19 -0700 (PDT)
Message-Id: <20190316.182119.1641693988840475497.davem@davemloft.net>
To:     willemdebruijn.kernel@gmail.com
Cc:     maxime.chevallier@bootlin.com, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, willemb@google.com, edumazet@google.com,
        antoine.tenart@bootlin.com, thomas.petazzoni@bootlin.com
Subject: Re: [PATCH net] packets: Always register packet sk in the same
 order
From:   David Miller <davem@davemloft.net>
In-Reply-To: <CAF=yD-K1imzDHm2K8bvrtYu5j-MNrN_4xH2h2je6ornuqmi_QA@mail.gmail.com>
References: <20190316134130.28065-1-maxime.chevallier@bootlin.com>
        <CAF=yD-K1imzDHm2K8bvrtYu5j-MNrN_4xH2h2je6ornuqmi_QA@mail.gmail.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sat, 16 Mar 2019 18:21:20 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date: Sat, 16 Mar 2019 14:09:33 -0400

> Note that another consequence of this patch is that insertion on
> packet create is now O(N) with the number of active packet sockets,
> due to sklist being an hlist.

Exploitable...
