Return-Path: <SRS0=wu79=TZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A17CC07542
	for <linux-kernel@archiver.kernel.org>; Sat, 25 May 2019 23:37:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5524420815
	for <linux-kernel@archiver.kernel.org>; Sat, 25 May 2019 23:37:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727551AbfEYXhc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 May 2019 19:37:32 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:33022 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727431AbfEYXhc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 May 2019 19:37:32 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::3d8])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 5C98F1500AE49;
        Sat, 25 May 2019 16:37:31 -0700 (PDT)
Date:   Sat, 25 May 2019 16:35:45 -0700 (PDT)
Message-Id: <20190525.163545.974576953807440461.davem@davemloft.net>
To:     maxime.chevallier@bootlin.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        antoine.tenart@bootlin.com, thomas.petazzoni@bootlin.com,
        ecree@solarflare.com
Subject: Re: [PATCH net-next] net: ethtool: Document get_rxfh_context and
 set_rxfh_context ethtool ops
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190524100530.8445-1-maxime.chevallier@bootlin.com>
References: <20190524100530.8445-1-maxime.chevallier@bootlin.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sat, 25 May 2019 16:37:31 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Date: Fri, 24 May 2019 12:05:30 +0200

> ethtool ops get_rxfh_context and set_rxfh_context are used to create,
> remove and access parameters associated to RSS contexts, in a similar
> fashion to get_rxfh and set_rxfh.
> 
> Add a small descritopn of these callbacks in the struct ethtool_ops doc.
> 
> Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

As a doc fix, I'll put this into 'net'.

Thank you.
