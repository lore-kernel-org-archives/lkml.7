Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF3D3C31E49
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 13:57:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC8EE2166E
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 13:57:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728903AbfFSN5R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 09:57:17 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:34470 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726047AbfFSN5R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 09:57:17 -0400
Received: from localhost (unknown [144.121.20.163])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id AFA1915216917;
        Wed, 19 Jun 2019 06:57:15 -0700 (PDT)
Date:   Wed, 19 Jun 2019 09:57:14 -0400 (EDT)
Message-Id: <20190619.095714.256356699322316004.davem@davemloft.net>
To:     matorola@gmail.com
Cc:     oftedal@gmail.com, thuth@redhat.com, sparclinux@vger.kernel.org,
        linux-kernel@vger.kernel.org, tglx@linutronix.de,
        pombredanne@nexb.com, kstewart@linuxfoundation.org
Subject: Re: [PATCH] sparc: Remove redundant copy of the LGPL-2.0
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190619075342.GA11485@yogzotot>
References: <CALMQjD-dAX8hU6sNxDWtdxc7CddO3KDd9Fu_J74tZ-6pn5_Z5Q@mail.gmail.com>
        <20190613.151456.1482983218638838740.davem@davemloft.net>
        <20190619075342.GA11485@yogzotot>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 19 Jun 2019 06:57:16 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Anatoly Pugachev <matorola@gmail.com>
Date: Wed, 19 Jun 2019 10:53:42 +0300

> Update arch/sparc/lib/* to LGPL-2.0+ to be in order with original arch/sparc/lib/COPYING.LIB
> 
> sed -i 's/SPDX-License-Identifier: \(.*\) */SPDX-License-Identifier: LGPL-2.0+ *\//' arch/sparc/lib/*
> 
> Fixes: b24413180f56 ("License cleanup: add SPDX GPL-2.0 license identifier to files with no license")
> Signed-off-by: Anatoly Pugachev <matorola@gmail.com>

Looks good.
