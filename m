Return-Path: <SRS0=8t7v=ZS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C8EDC432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 18:09:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F17EA20727
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 18:09:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726504AbfKZSJo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Nov 2019 13:09:44 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:39890 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725870AbfKZSJn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Nov 2019 13:09:43 -0500
Received: from localhost (c-73-35-209-67.hsd1.wa.comcast.net [73.35.209.67])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 00CE014C25D3A;
        Tue, 26 Nov 2019 10:09:42 -0800 (PST)
Date:   Tue, 26 Nov 2019 10:09:42 -0800 (PST)
Message-Id: <20191126.100942.402030780937576711.davem@davemloft.net>
To:     mparab@cadence.com
Cc:     andrew@lunn.ch, antoine.tenart@bootlin.com,
        nicolas.ferre@microchip.com, netdev@vger.kernel.org,
        f.fainelli@gmail.com, hkallweit1@gmail.com,
        linux-kernel@vger.kernel.org, dkangude@cadence.com,
        pthombar@cadence.com
Subject: Re: [PATCH 0/3] net: macb: cover letter
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1574759354-102696-1-git-send-email-mparab@cadence.com>
References: <1574759354-102696-1-git-send-email-mparab@cadence.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Tue, 26 Nov 2019 10:09:43 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


You need to say something better than "cover letter", state what the overall
series is doing at a high level, in the most concise way.
