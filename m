Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30BBEC0650F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 16:55:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E75220657
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 16:55:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729170AbfG3Qzf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 12:55:35 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:51880 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727576AbfG3Qzf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 12:55:35 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::d71])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 934681264EC66;
        Tue, 30 Jul 2019 09:55:34 -0700 (PDT)
Date:   Tue, 30 Jul 2019 09:55:34 -0700 (PDT)
Message-Id: <20190730.095534.1629843557426676625.davem@davemloft.net>
To:     h.feurstein@gmail.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        andrew@lunn.ch, f.fainelli@gmail.com, hkallweit1@gmail.com
Subject: Re: [PATCH] net: phy: fixed_phy: print gpio error only if gpio
 node is present
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190730094623.31640-1-h.feurstein@gmail.com>
References: <20190730094623.31640-1-h.feurstein@gmail.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Tue, 30 Jul 2019 09:55:34 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hubert Feurstein <h.feurstein@gmail.com>
Date: Tue, 30 Jul 2019 11:46:23 +0200

> It is perfectly ok to not have an gpio attached to the fixed-link node. So
> the driver should not throw an error message when the gpio is missing.
> 
> Signed-off-by: Hubert Feurstein <h.feurstein@gmail.com>

Applied and queued up for -stable, thanks.
