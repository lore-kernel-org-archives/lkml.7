Return-Path: <SRS0=ebdT=SX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85757C282E3
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Apr 2019 18:24:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6233120859
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Apr 2019 18:24:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726363AbfDUSY2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Apr 2019 14:24:28 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:37688 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726197AbfDUSY1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Apr 2019 14:24:27 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::d71])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 2622C146EDF87;
        Sun, 21 Apr 2019 11:24:26 -0700 (PDT)
Date:   Sun, 21 Apr 2019 11:24:23 -0700 (PDT)
Message-Id: <20190421.112423.1624489720030404631.davem@davemloft.net>
To:     clabbe@baylibre.com
Cc:     mark.rutland@arm.com, robh+dt@kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: add an explanation for internal phy-mode
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1555784073-21679-1-git-send-email-clabbe@baylibre.com>
References: <1555784073-21679-1-git-send-email-clabbe@baylibre.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sun, 21 Apr 2019 11:24:26 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Corentin Labbe <clabbe@baylibre.com>
Date: Sat, 20 Apr 2019 18:14:33 +0000

> When working on the Allwinner internal PHY, the first work was to use
> the "internal" mode, but some answer was made my mail on what are really
> internal mean for PHY.
> 
> This patch write that in the doc.
> 
> Signed-off-by: Corentin Labbe <clabbe@baylibre.com>

Applied, thank you.
