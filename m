Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90374C282DD
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 21:16:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 693AA20678
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 21:16:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729897AbgAGVQN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 16:16:13 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:38140 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727762AbgAGVQM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 16:16:12 -0500
Received: from localhost (unknown [IPv6:2601:601:9f00:1c3::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 2B11C15A15DD4;
        Tue,  7 Jan 2020 13:16:11 -0800 (PST)
Date:   Tue, 07 Jan 2020 13:16:10 -0800 (PST)
Message-Id: <20200107.131610.393612253415658528.davem@davemloft.net>
To:     bjorn.andersson@linaro.org
Cc:     aneela@codeaurora.org, clew@codeaurora.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v3 2/5] net: qrtr: Implement outgoing flow control
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20200107054713.3909260-3-bjorn.andersson@linaro.org>
References: <20200107054713.3909260-1-bjorn.andersson@linaro.org>
        <20200107054713.3909260-3-bjorn.andersson@linaro.org>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Tue, 07 Jan 2020 13:16:11 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bjorn Andersson <bjorn.andersson@linaro.org>
Date: Mon,  6 Jan 2020 21:47:10 -0800

>  static void __qrtr_node_release(struct kref *kref)
>  {
> +	struct radix_tree_iter iter;
>  	struct qrtr_node *node = container_of(kref, struct qrtr_node, ref);
> +	void __rcu **slot;

Reverse christmas tree here, please.

Thank you.
