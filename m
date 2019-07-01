Return-Path: <SRS0=3QRk=U6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B79B3C0650E
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 18:22:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DB752146F
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 18:22:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727295AbfGASWi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 14:22:38 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:46748 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726671AbfGASWi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 14:22:38 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::d71])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 64CBD14C6D77B;
        Mon,  1 Jul 2019 11:22:37 -0700 (PDT)
Date:   Mon, 01 Jul 2019 11:22:36 -0700 (PDT)
Message-Id: <20190701.112236.1672634172707343585.davem@davemloft.net>
To:     mcroce@redhat.com
Cc:     joe@perches.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, kuznet@ms2.inr.ac.ru,
        yoshfuji@linux-ipv6.org
Subject: Re: [PATCH net] ipv4: don't set IPv6 only flags to IPv4 addresses
From:   David Miller <davem@davemloft.net>
In-Reply-To: <CAGnkfhx9F1G8K6PjBdUnkCO07GR=ktWAnqOLTcOvg7VGwWb69Q@mail.gmail.com>
References: <20190701160805.32404-1-mcroce@redhat.com>
        <42624f83da71354a5daef959a4749cb75516d37f.camel@perches.com>
        <CAGnkfhx9F1G8K6PjBdUnkCO07GR=ktWAnqOLTcOvg7VGwWb69Q@mail.gmail.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 01 Jul 2019 11:22:37 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matteo Croce <mcroce@redhat.com>
Date: Mon, 1 Jul 2019 18:13:32 +0200

> Can this be edidet on patchwork instead of spamming with a v2?

"Spamming"?

It's never spamming, resends make my life SO much easier.
