Return-Path: <SRS0=rArk=2Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21DD3C2D0C0
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Dec 2019 21:22:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F22C620740
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Dec 2019 21:22:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727005AbfLZVWh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Dec 2019 16:22:37 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:43580 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726105AbfLZVWh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Dec 2019 16:22:37 -0500
Received: from localhost (unknown [IPv6:2601:601:9f00:1c3::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 927D91513DD33;
        Thu, 26 Dec 2019 13:22:36 -0800 (PST)
Date:   Thu, 26 Dec 2019 13:22:35 -0800 (PST)
Message-Id: <20191226.132235.1870219915908299554.davem@davemloft.net>
To:     martin.blumenstingl@googlemail.com
Cc:     andrew@lunn.ch, f.fainelli@gmail.com, netdev@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 0/2] RTL8211F: RGMII RX/TX delay configuration
 improvements
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20191226185148.3764251-1-martin.blumenstingl@googlemail.com>
References: <20191226185148.3764251-1-martin.blumenstingl@googlemail.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 26 Dec 2019 13:22:36 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date: Thu, 26 Dec 2019 19:51:46 +0100

> In discussion with Andrew [0] we figured out that it would be best to
> make the RX delay of the RTL8211F PHY configurable (just like the TX
> delay is already configurable).
> 
> While here I took the opportunity to add some logging to the TX delay
> configuration as well.
 ...

Series applied to net-next, thank you.
