Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A564FC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 18:41:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82086206DF
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 18:41:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732588AbfCZSlb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 14:41:31 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:48602 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731755AbfCZSlb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 14:41:31 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::d71])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 7B99214C5E7D5;
        Tue, 26 Mar 2019 11:41:30 -0700 (PDT)
Date:   Tue, 26 Mar 2019 11:41:30 -0700 (PDT)
Message-Id: <20190326.114130.1439471441091297640.davem@davemloft.net>
To:     Kavyasree.Kotagiri@microchip.com
Cc:     andrew@lunn.ch, f.fainelli@gmail.com, hkallweit1@gmail.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        quentin.schulz@bootlin.com
Subject: Re: [PATCH 0/1] net: phy: mscc: add support for VSC8514 PHY
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190325111548.25789-1-kavyasree.kotagiri@microchip.com>
References: <20190325111548.25789-1-kavyasree.kotagiri@microchip.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Tue, 26 Mar 2019 11:41:30 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


This is formatted improperly.

The "[PATCH 0/N]" posting should just provide a commit message that
explains what the patch series is doing, how it is doing it, and why
it is doing it that way.

Then you have "[PATCH 1/N]", "[PATCH 2/N]" that actually contain the
patches of the series.

Have a look at how other developers submit a patch series on this
list.

Thanks.
