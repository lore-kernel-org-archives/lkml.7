Return-Path: <SRS0=HtuS=UO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F398C31E44
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Jun 2019 02:32:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF3202173C
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Jun 2019 02:32:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726556AbfFOCcD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 22:32:03 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:57526 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725812AbfFOCcD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 22:32:03 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id A9B0113E91394;
        Fri, 14 Jun 2019 19:32:02 -0700 (PDT)
Date:   Fri, 14 Jun 2019 19:32:02 -0700 (PDT)
Message-Id: <20190614.193202.5277887275859796.davem@davemloft.net>
To:     willemdebruijn.kernel@gmail.com
Cc:     jakub.kicinski@netronome.com, peterz@infradead.org,
        netdev@vger.kernel.org, edumazet@google.com,
        linux-kernel@vger.kernel.org, willemb@google.com
Subject: Re: [PATCH net-next 0/2] enable and use static_branch_deferred_inc
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190613150816.83198-1-willemdebruijn.kernel@gmail.com>
References: <20190613150816.83198-1-willemdebruijn.kernel@gmail.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Fri, 14 Jun 2019 19:32:02 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date: Thu, 13 Jun 2019 11:08:14 -0400

> From: Willem de Bruijn <willemb@google.com>
> 
> 1. make static_branch_deferred_inc available if !CONFIG_JUMP_LABEL
> 2. convert the existing STATIC_KEY_DEFERRED_FALSE user to this api

Series applied.
