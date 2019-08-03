Return-Path: <SRS0=Iotr=V7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60013C0650F
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Aug 2019 00:59:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 340522086A
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Aug 2019 00:59:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388508AbfHCA7I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 20:59:08 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:52908 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387633AbfHCA7I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 20:59:08 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::d71])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id C550612651D63;
        Fri,  2 Aug 2019 17:59:07 -0700 (PDT)
Date:   Fri, 02 Aug 2019 17:59:07 -0700 (PDT)
Message-Id: <20190802.175907.782623012805701434.davem@davemloft.net>
To:     h.feurstein@gmail.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        andrew@lunn.ch, vivien.didelot@gmail.com, f.fainelli@gmail.com,
        rasmus.villemoes@prevas.dk
Subject: Re: [PATCH net-next v2 0/6] net: dsa: mv88e6xxx: add support for
 MV88E6220
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190731082351.3157-1-h.feurstein@gmail.com>
References: <20190731082351.3157-1-h.feurstein@gmail.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Fri, 02 Aug 2019 17:59:08 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hubert Feurstein <h.feurstein@gmail.com>
Date: Wed, 31 Jul 2019 10:23:45 +0200

> This patch series adds support for the MV88E6220 chip to the mv88e6xxx driver.
> The MV88E6220 is almost the same as MV88E6250 except that the ports 2-4 are
> not routed to pins.
> 
> Furthermore, PTP support is added to the MV88E6250 family.
> 
> v2:
>  - insert all 6220 entries in correct numerical order
>  - introduce invalid_port_mask
>  - move ptp_cc_mult* to ptp_ops and restored original ptp_adjfine code
>  - added Andrews Reviewed-By to patch 2 and 4

Series applied, thank you.
