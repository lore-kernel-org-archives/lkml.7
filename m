Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14FB0C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 19:13:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E43012064A
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 19:13:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389568AbfC0TNG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 15:13:06 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:58652 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388883AbfC0TNC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 15:13:02 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::d71])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 6680E14CEC932;
        Wed, 27 Mar 2019 12:13:01 -0700 (PDT)
Date:   Wed, 27 Mar 2019 12:12:58 -0700 (PDT)
Message-Id: <20190327.121258.803916840105091769.davem@davemloft.net>
To:     mkubecek@suse.cz
Cc:     jiri@resnulli.us, netdev@vger.kernel.org,
        jakub.kicinski@netronome.com, andrew@lunn.ch, f.fainelli@gmail.com,
        linville@tuxdriver.com, stephen@networkplumber.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v5 00/22] ethtool netlink interface, part 1
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190327142806.GT26076@unicorn.suse.cz>
References: <cover.1553532199.git.mkubecek@suse.cz>
        <20190327130928.GC14297@nanopsycho>
        <20190327142806.GT26076@unicorn.suse.cz>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 27 Mar 2019 12:13:01 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michal Kubecek <mkubecek@suse.cz>
Date: Wed, 27 Mar 2019 15:28:06 +0100

> On Wed, Mar 27, 2019 at 02:09:28PM +0100, Jiri Pirko wrote:
>> Could you please perhaps split the patchset so it contains max ~15 patches?
> 
> Would 1-17 still be acceptable?

I'm OK with ~17 especially considering the scope of this work.

