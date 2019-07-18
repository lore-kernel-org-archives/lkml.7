Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CC63C7618F
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 18:44:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 458DE208C0
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 18:44:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390914AbfGRSoh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jul 2019 14:44:37 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:53964 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726040AbfGRSoh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 14:44:37 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::d71])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 52B261527BF1B;
        Thu, 18 Jul 2019 11:44:36 -0700 (PDT)
Date:   Thu, 18 Jul 2019 11:44:33 -0700 (PDT)
Message-Id: <20190718.114433.373568579928431210.davem@davemloft.net>
To:     dsa@cumulusnetworks.com
Cc:     p.kosyh@gmail.com, shrijeet@gmail.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Signed-off-by: Peter Kosyh <p.kosyh@gmail.com>
From:   David Miller <davem@davemloft.net>
In-Reply-To: <213bada2-fe81-3c14-1506-11abf0f3ca22@cumulusnetworks.com>
References: <20190718094114.13718-1-p.kosyh@gmail.com>
        <213bada2-fe81-3c14-1506-11abf0f3ca22@cumulusnetworks.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 18 Jul 2019 11:44:36 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Ahern <dsa@cumulusnetworks.com>
Date: Thu, 18 Jul 2019 08:02:45 -0600

> your subject line needs a proper Subject - a one-line summary of the
> change starting with 'vrf:'. See examples from 'git log drivers/net/vrf.c'

Indeed, you really need to fix this even for your second submission as it
had the same exact problem.
