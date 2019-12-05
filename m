Return-Path: <SRS0=yQuH=Z3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96074C43603
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 00:32:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72D4E2073B
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 00:32:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728564AbfLEAce (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 19:32:34 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:38154 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728011AbfLEAce (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 19:32:34 -0500
Received: from localhost (unknown [IPv6:2601:601:9f00:1c3::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id CA86514F1748B;
        Wed,  4 Dec 2019 16:32:32 -0800 (PST)
Date:   Wed, 04 Dec 2019 16:32:32 -0800 (PST)
Message-Id: <20191204.163232.1306369201437008300.davem@davemloft.net>
To:     aconole@redhat.com
Cc:     netdev@vger.kernel.org, pshelar@ovn.org, jhs@mojatatu.com,
        xiyou.wangcong@gmail.com, jiri@resnulli.us, dev@openvswitch.org,
        linux-kernel@vger.kernel.org, mleitner@redhat.com,
        paulb@mellanox.com, roid@mellanox.com, nicolas.dichtel@6wind.com
Subject: Re: [PATCH 1/2] openvswitch: support asymmetric conntrack
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20191203213414.24109-1-aconole@redhat.com>
References: <20191203213414.24109-1-aconole@redhat.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 04 Dec 2019 16:32:33 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Aaron Conole <aconole@redhat.com>
Date: Tue,  3 Dec 2019 16:34:13 -0500

> The openvswitch module shares a common conntrack and NAT infrastructure
> exposed via netfilter.  It's possible that a packet needs both SNAT and
> DNAT manipulation, due to e.g. tuple collision.  Netfilter can support
> this because it runs through the NAT table twice - once on ingress and
> again after egress.  The openvswitch module doesn't have such capability.
> 
> Like netfilter hook infrastructure, we should run through NAT twice to
> keep the symmetry.
> 
> Fixes: 05752523e565 ("openvswitch: Interface with NAT.")
> Signed-off-by: Aaron Conole <aconole@redhat.com>
> ---
> NOTE: this is a repost to see if the email client issues go away.

Applied and queued up for -stable.
