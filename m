Return-Path: <SRS0=k4ck=W3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FDAFC3A59B
	for <linux-kernel@archiver.kernel.org>; Sat, 31 Aug 2019 00:37:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDC1022CE9
	for <linux-kernel@archiver.kernel.org>; Sat, 31 Aug 2019 00:37:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728459AbfHaAhk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 20:37:40 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:44440 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727304AbfHaAhk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 20:37:40 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::d71])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 75DD215506595;
        Fri, 30 Aug 2019 17:37:39 -0700 (PDT)
Date:   Fri, 30 Aug 2019 17:37:36 -0700 (PDT)
Message-Id: <20190830.173736.77815828124625313.davem@davemloft.net>
To:     yzhai003@ucr.edu
Cc:     csong@cs.ucr.edu, zhiyunq@cs.ucr.edu, peppe.cavallaro@st.com,
        alexandre.torgue@st.com, maxime.ripard@free-electrons.com,
        wens@csie.org, netdev@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: stmmac: Variable "val" in function
 sun8i_dwmac_set_syscon() could be uninitialized
From:   David Miller <davem@davemloft.net>
In-Reply-To: <CABvMjLRzuUVh7FxVQj2O40Sbr+VygwSG8spMv0fW2RZVvaJ8rQ@mail.gmail.com>
References: <20190207174623.16712-1-yzhai003@ucr.edu>
        <20190208.230117.1867217574108955553.davem@davemloft.net>
        <CABvMjLRzuUVh7FxVQj2O40Sbr+VygwSG8spMv0fW2RZVvaJ8rQ@mail.gmail.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Fri, 30 Aug 2019 17:37:39 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yizhuo Zhai <yzhai003@ucr.edu>
Date: Fri, 30 Aug 2019 15:29:07 -0700

> Thanks for your feedback, this patch should work for v4.14.

You must always submit patches against the current tree.
