Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F4F8C0650F
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 01:12:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6311E2166E
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 01:12:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405319AbfHIBMf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 21:12:35 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:54060 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404550AbfHIBMe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 21:12:34 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::d71])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 2412814254E0D;
        Thu,  8 Aug 2019 18:12:34 -0700 (PDT)
Date:   Thu, 08 Aug 2019 18:12:33 -0700 (PDT)
Message-Id: <20190808.181233.1012759145511078443.davem@davemloft.net>
To:     hslester96@gmail.com
Cc:     vishal@chelsio.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] cxgb4: smt: Add lock for atomic_dec_and_test
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190806025846.17022-1-hslester96@gmail.com>
References: <20190806025846.17022-1-hslester96@gmail.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 08 Aug 2019 18:12:34 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chuhong Yuan <hslester96@gmail.com>
Date: Tue,  6 Aug 2019 10:58:46 +0800

> The atomic_dec_and_test() is not safe because it is
> outside of locks.
> Move the locks of t4_smte_free() to its caller,
> cxgb4_smt_release() to protect the atomic decrement.
> 
> Fixes: 3bdb376e6944 ("cxgb4: introduce SMT ops to prepare for SMAC rewrite support")
> Signed-off-by: Chuhong Yuan <hslester96@gmail.com>

Applied.
