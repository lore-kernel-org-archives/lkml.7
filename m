Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37869C76190
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 00:26:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 142B6217D4
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 00:26:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727036AbfGZA0C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 20:26:02 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:41378 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726920AbfGZA0C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 20:26:02 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::d71])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 7680F12650646;
        Thu, 25 Jul 2019 17:26:01 -0700 (PDT)
Date:   Thu, 25 Jul 2019 17:26:00 -0700 (PDT)
Message-Id: <20190725.172600.286178066068275828.davem@davemloft.net>
To:     yanhaishuang@cmss.chinamobile.com
Cc:     kuznet@ms2.inr.ac.ru, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ipip: validate header length in ipip_tunnel_xmit
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1564024076-13764-1-git-send-email-yanhaishuang@cmss.chinamobile.com>
References: <1564024076-13764-1-git-send-email-yanhaishuang@cmss.chinamobile.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 25 Jul 2019 17:26:01 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Haishuang Yan <yanhaishuang@cmss.chinamobile.com>
Date: Thu, 25 Jul 2019 11:07:55 +0800

> We need the same checks introduced by commit cb9f1b783850
> ("ip: validate header length on virtual device xmit") for
> ipip tunnel.
> 
> Signed-off-by: Haishuang Yan <yanhaishuang@cmss.chinamobile.com>

Applied and queued up for -stable.
