Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C265AC28CC0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 18:45:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 961DD25FDD
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 18:45:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726666AbfE3SpS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 14:45:18 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:56986 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726100AbfE3SpS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 14:45:18 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id CE53314D99A83;
        Thu, 30 May 2019 11:45:17 -0700 (PDT)
Date:   Thu, 30 May 2019 11:45:17 -0700 (PDT)
Message-Id: <20190530.114517.2038537000773947362.davem@davemloft.net>
To:     92siuyang@gmail.com
Cc:     ecree@solarflare.com, mhabets@solarflare.com, fw@strlen.de,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] falcon: pass valid pointer from ef4_enqueue_unwind.
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1559096139-25698-1-git-send-email-92siuyang@gmail.com>
References: <1559096139-25698-1-git-send-email-92siuyang@gmail.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 30 May 2019 11:45:18 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Young Xiao <92siuyang@gmail.com>
Date: Wed, 29 May 2019 10:15:39 +0800

> The bytes_compl and pkts_compl pointers passed to ef4_dequeue_buffers
> cannot be NULL. Add a paranoid warning to check this condition and fix
> the one case where they were NULL.
> 
> Signed-off-by: Young Xiao <92siuyang@gmail.com>

EF4_TX_BUF_SKB will be clear in this situation, so your patch is not
necessary.
