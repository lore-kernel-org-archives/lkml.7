Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1312AC76186
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 21:00:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E135F21873
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 21:00:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387775AbfGXVAM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 17:00:12 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:51770 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726591AbfGXVAM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 17:00:12 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::d71])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id AF7D0153E8968;
        Wed, 24 Jul 2019 14:00:11 -0700 (PDT)
Date:   Wed, 24 Jul 2019 14:00:11 -0700 (PDT)
Message-Id: <20190724.140011.1839679169257474219.davem@davemloft.net>
To:     yanhaishuang@cmss.chinamobile.com
Cc:     kuznet@ms2.inr.ac.ru, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, u9012063@gmail.com
Subject: Re: [PATCH] ip6_gre: reload ipv6h in prepare_ip6gre_xmit_ipv6
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1563969642-11843-1-git-send-email-yanhaishuang@cmss.chinamobile.com>
References: <1563969642-11843-1-git-send-email-yanhaishuang@cmss.chinamobile.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 24 Jul 2019 14:00:11 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Haishuang Yan <yanhaishuang@cmss.chinamobile.com>
Date: Wed, 24 Jul 2019 20:00:42 +0800

> Since ip6_tnl_parse_tlv_enc_lim() can call pskb_may_pull()
> which may change skb->data, so we need to re-load ipv6h at
> the right place.
> 
> Fixes: 898b29798e36 ("ip6_gre: Refactor ip6gre xmit codes")
> Cc: William Tu <u9012063@gmail.com>
> Signed-off-by: Haishuang Yan <yanhaishuang@cmss.chinamobile.com>

Applied and queued up for -stable, thanks.
