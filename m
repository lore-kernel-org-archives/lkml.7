Return-Path: <SRS0=kYop=UV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62F70C48BE8
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Jun 2019 13:42:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45C8120665
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Jun 2019 13:42:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726351AbfFVNmd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Jun 2019 09:42:33 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:54336 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726286AbfFVNmc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jun 2019 09:42:32 -0400
Received: from localhost (unknown [8.46.76.25])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id D3E6115394EED;
        Sat, 22 Jun 2019 06:42:22 -0700 (PDT)
Date:   Sat, 22 Jun 2019 09:42:12 -0400 (EDT)
Message-Id: <20190622.094212.1667441284428813985.davem@davemloft.net>
To:     poros@redhat.com
Cc:     netdev@vger.kernel.org, sathya.perla@broadcom.com,
        ajit.khaparde@broadcom.com, sriharsha.basavapatna@broadcom.com,
        somnath.kotur@broadcom.com, linux-kernel@vger.kernel.org,
        ivecera@redhat.com
Subject: Re: [PATCH v2 net] be2net: fix link failure after ethtool offline
 test
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190619122942.15497-1-poros@redhat.com>
References: <20190619122942.15497-1-poros@redhat.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sat, 22 Jun 2019 06:42:32 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Petr Oros <poros@redhat.com>
Date: Wed, 19 Jun 2019 14:29:42 +0200

> Certain cards in conjunction with certain switches need a little more
> time for link setup that results in ethtool link test failure after
> offline test. Patch adds a loop that waits for a link setup finish.
> 
> Changes in v2:
> - added fixes header
> 
> Fixes: 4276e47e2d1c ("be2net: Add link test to list of ethtool self tests.")
> Signed-off-by: Petr Oros <poros@redhat.com>

Applied, thanks.
