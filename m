Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75018C76186
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 21:41:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 520F521880
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 21:41:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388427AbfGXVlp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 17:41:45 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:52244 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388258AbfGXVlo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 17:41:44 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::d71])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 3B3D81543A7D7;
        Wed, 24 Jul 2019 14:41:44 -0700 (PDT)
Date:   Wed, 24 Jul 2019 14:41:43 -0700 (PDT)
Message-Id: <20190724.144143.2055459359936675888.davem@davemloft.net>
To:     jeffrey.t.kirsher@intel.com
Cc:     cai@lca.pw, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next v2] net/ixgbevf: fix a compilation error of
 skb_frag_t
From:   David Miller <davem@davemloft.net>
In-Reply-To: <4b5abf35a7b78ceae788ad7c2609d84dd33e5e9e.camel@intel.com>
References: <1563985079-12888-1-git-send-email-cai@lca.pw>
        <4b5abf35a7b78ceae788ad7c2609d84dd33e5e9e.camel@intel.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 24 Jul 2019 14:41:44 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Wed, 24 Jul 2019 09:39:26 -0700

> Dave I will pick this up and add it to my queue.

How soon will you get that to me?  The sooner this build fix is cured the
better.

Thanks.
