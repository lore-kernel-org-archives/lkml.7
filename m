Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD536C3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 21:06:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9190E22DA7
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 21:06:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727009AbfH1VGs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 17:06:48 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:36936 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726583AbfH1VGs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 17:06:48 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::d71])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 60C3C1539AF06;
        Wed, 28 Aug 2019 14:06:47 -0700 (PDT)
Date:   Wed, 28 Aug 2019 14:06:44 -0700 (PDT)
Message-Id: <20190828.140644.534529249197568915.davem@davemloft.net>
To:     yash.shah@sifive.com
Cc:     netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        robh+dt@kernel.org, mark.rutland@arm.com,
        nicolas.ferre@microchip.com, palmer@sifive.com,
        paul.walmsley@sifive.com, ynezz@true.cz, sachin.ghadi@sifive.com
Subject: Re: [PATCH v2 0/2] Update ethernet compatible string for SiFive
 FU540
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1566882364-23891-1-git-send-email-yash.shah@sifive.com>
References: <1566882364-23891-1-git-send-email-yash.shah@sifive.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 28 Aug 2019 14:06:47 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yash Shah <yash.shah@sifive.com>
Date: Tue, 27 Aug 2019 10:36:02 +0530

> This patch series renames the compatible property to a more appropriate
> string. The patchset is based on Linux-5.3-rc6 and tested on SiFive
> Unleashed board

You should always base changes off of "net" or "net-next" and be explicitly
in your Subject lines which of those two trees your changes are for f.e.:

	Subject: [PATCH v2 net-next N/M] ...

> 
> Change history:
> Since v1:
> - Dropped PATCH3 because it's already merged
> - Change the reference url in the patch descriptions to point to a
>   'lore.kernel.org' link instead of 'lkml.org'

Series applied to 'net'.
