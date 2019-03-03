Return-Path: <SRS0=GAfv=RG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5D5EC43381
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Mar 2019 21:51:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80A5B20830
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Mar 2019 21:51:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726688AbfCCVv5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Mar 2019 16:51:57 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:53560 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726639AbfCCVv4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Mar 2019 16:51:56 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 460C3146E7746;
        Sun,  3 Mar 2019 13:51:55 -0800 (PST)
Date:   Sun, 03 Mar 2019 13:51:53 -0800 (PST)
Message-Id: <20190303.135153.2209590754103346907.davem@davemloft.net>
To:     harini.katakam@xilinx.com
Cc:     nicolas.ferre@microchip.com, claudiu.beznea@microchip.com,
        andrew@lunn.ch, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, michal.simek@xilinx.com,
        harinikatakamlinux@gmail.com
Subject: Re: [PATCH v2 0/4] Macb power management support for ZynqMP
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1551437435-3462-1-git-send-email-harini.katakam@xilinx.com>
References: <1551437435-3462-1-git-send-email-harini.katakam@xilinx.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sun, 03 Mar 2019 13:51:56 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Harini Katakam <harini.katakam@xilinx.com>
Date: Fri, 1 Mar 2019 16:20:31 +0530

> This series adds support for macb suspend/resume with system power down.
> In relation to the above, this series also updates mdio_read/write
> function for PM and adds tsu clock management.

Series applied to net-next, thank you.
