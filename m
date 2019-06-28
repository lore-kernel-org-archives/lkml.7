Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9A3BC4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 21:34:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DCDE2086D
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 21:34:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726789AbfF1Vex (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 17:34:53 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:52182 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725783AbfF1Vew (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 17:34:52 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::d71])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 1FE9613AECA1E;
        Fri, 28 Jun 2019 14:34:52 -0700 (PDT)
Date:   Fri, 28 Jun 2019 14:34:51 -0700 (PDT)
Message-Id: <20190628.143451.2154118272310072917.davem@davemloft.net>
To:     christian@brauner.io
Cc:     kuznet@ms2.inr.ac.ru, yoshfuji@linux-ipv6.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] ipv4: enable route flushing in network
 namespaces
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190624132923.16792-1-christian@brauner.io>
References: <20190624132923.16792-1-christian@brauner.io>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Fri, 28 Jun 2019 14:34:52 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christian Brauner <christian@brauner.io>
Date: Mon, 24 Jun 2019 15:29:23 +0200

> Tools such as vpnc try to flush routes when run inside network
> namespaces by writing 1 into /proc/sys/net/ipv4/route/flush. This
> currently does not work because flush is not enabled in non-initial
> network namespaces.
> Since routes are per network namespace it is safe to enable
> /proc/sys/net/ipv4/route/flush in there.
> 
> Link: https://github.com/lxc/lxd/issues/4257
> Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>

Applied.
