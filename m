Return-Path: <SRS0=A1VX=SJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2966EC282DA
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Apr 2019 01:22:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E84602133F
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Apr 2019 01:22:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726584AbfDGBWN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Apr 2019 21:22:13 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:39638 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726144AbfDGBWM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Apr 2019 21:22:12 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::d71])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 83A6A14BC08B3;
        Sat,  6 Apr 2019 18:22:11 -0700 (PDT)
Date:   Sat, 06 Apr 2019 18:22:10 -0700 (PDT)
Message-Id: <20190406.182210.325909791725959336.davem@davemloft.net>
To:     mario.limonciello@dell.com
Cc:     linux-usb@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, hayeswang@realtek.com,
        sjg@google.com, campello@google.com, Ryan.Hong@Dell.com,
        Crag.Wang@dell.com
Subject: Re: [PATCH v2 0/2] Support runtime changes of vendor mac passthu
 policy
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1554403613-5970-1-git-send-email-mario.limonciello@dell.com>
References: <1554403613-5970-1-git-send-email-mario.limonciello@dell.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sat, 06 Apr 2019 18:22:11 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mario Limonciello <mario.limonciello@dell.com>
Date: Thu,  4 Apr 2019 13:46:51 -0500

> On some platforms ACPI method `\\_SB.AMAC` is dynamic and changes to it can
> influence changing the behavior of MAC pass through and what MAC address is used.
> 
> When running USB reset, re-read the MAC address to use to support tools that
> change the policy.
> 
> This is quite similar to using `SIOCSIFHWADDR` except that the actual MAC to use
> comes from ASL rather than from userspace.
> 
> Changes from v1:
>  * Remove an extra unneeded `ether_addr_copy` call
>  * Use `dev_set_mac_address` to ensure all notifiers are called
>  * Shuffle functions to allow code re-use.

Series applied to net-next.
