Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D1FCC43603
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 18:29:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C0C02077B
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 18:29:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726602AbfLIS3w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 13:29:52 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:33894 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726354AbfLIS3w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 13:29:52 -0500
Received: from localhost (unknown [IPv6:2601:601:9f00:1c3::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id A4CDA1543B41A;
        Mon,  9 Dec 2019 10:29:50 -0800 (PST)
Date:   Mon, 09 Dec 2019 10:29:50 -0800 (PST)
Message-Id: <20191209.102950.2248756181772063368.davem@davemloft.net>
To:     arnd@arndb.de
Cc:     khc@pm.waw.pl, gregkh@linuxfoundation.org,
        devel@driverdev.osuosl.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, ebiggers@kernel.org,
        andrew.hendry@gmail.com, linux-x25@vger.kernel.org,
        kevin.curtis@farsite.com, bob.dunlop@farsite.com,
        qiang.zhao@nxp.com,
        syzbot+429c200ffc8772bfe070@syzkaller.appspotmail.com,
        syzbot+eec0c87f31a7c3b66f7b@syzkaller.appspotmail.com
Subject: Re: [PATCH 4/4] [RFC] staging/net: move AF_X25 into drivers/staging
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20191209151256.2497534-4-arnd@arndb.de>
References: <20191209151256.2497534-1-arnd@arndb.de>
        <20191209151256.2497534-4-arnd@arndb.de>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 09 Dec 2019 10:29:51 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>
Date: Mon,  9 Dec 2019 16:12:56 +0100

> syzbot keeps finding issues in the X.25 implementation that nobody is
> interested in fixing.  Given that all the x25 patches of the past years
> that are not global cleanups tend to fix user-triggered oopses, is it
> time to just retire the subsystem?

I have a bug fix that I'm currently applying to 'net' right now actually:

	https://patchwork.ozlabs.org/patch/1205973/

So your proposal might be a bit premature.
