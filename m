Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2347C432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 18:09:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D04FB2071B
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 18:09:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727107AbfKVSJy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 13:09:54 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:38520 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726698AbfKVSJx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 13:09:53 -0500
Received: from localhost (c-73-35-209-67.hsd1.wa.comcast.net [73.35.209.67])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 8ECB715282F7A;
        Fri, 22 Nov 2019 10:09:52 -0800 (PST)
Date:   Fri, 22 Nov 2019 10:09:52 -0800 (PST)
Message-Id: <20191122.100952.137407515946118851.davem@davemloft.net>
To:     chenwandun@huawei.com
Cc:     vladimir.oltean@nxp.com, claudiu.manoil@nxp.com, andrew@lunn.ch,
        vivien.didelot@gmail.com, f.fainelli@gmail.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: dsa: ocelot: fix "should it be static?" warnings
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1574425965-97890-1-git-send-email-chenwandun@huawei.com>
References: <1574425965-97890-1-git-send-email-chenwandun@huawei.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Fri, 22 Nov 2019 10:09:52 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chen Wandun <chenwandun@huawei.com>
Date: Fri, 22 Nov 2019 20:32:45 +0800

> Fix following sparse warnings:
> drivers/net/dsa/ocelot/felix.c:351:6: warning: symbol 'felix_txtstamp' was not declared. Should it be static?
> 
> Signed-off-by: Chen Wandun <chenwandun@huawei.com>

Next time please indicate _explicitly_ which tree your patch is targetting,
because especially in this case the change is only relevant for "net-next"

Also, please provide a proper Fixes: tag.
