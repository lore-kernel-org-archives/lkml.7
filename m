Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F9A7C76186
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 21:51:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA4BE21850
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 21:51:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387633AbfGXVvY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 17:51:24 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:52338 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726870AbfGXVvY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 17:51:24 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::d71])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id B375C1543B09A;
        Wed, 24 Jul 2019 14:51:23 -0700 (PDT)
Date:   Wed, 24 Jul 2019 14:51:23 -0700 (PDT)
Message-Id: <20190724.145123.912916059374852633.davem@davemloft.net>
To:     standby24x7@gmail.com
Cc:     shuah@kernel.org, linux-kernel@vger.kernel.org, jiri@mellanox.com,
        idosch@mellanox.com, linux-kselftest@vger.kernel.org,
        rdunlap@infradead.org, netdev@vger.kernel.org
Subject: Re: [PATCH net-next] selftests: mlxsw: Fix typo in qos_mc_aware.sh
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190724152951.4618-1-standby24x7@gmail.com>
References: <20190724152951.4618-1-standby24x7@gmail.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 24 Jul 2019 14:51:24 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masanari Iida <standby24x7@gmail.com>
Date: Thu, 25 Jul 2019 00:29:51 +0900

> This patch fix some spelling typo in qos_mc_aware.sh
> 
> Signed-off-by: Masanari Iida <standby24x7@gmail.com>
> Acked-by: Randy Dunlap <rdunlap@infradead.org>

Applied.
