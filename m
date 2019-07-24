Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29D49C76186
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 22:29:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F401B21850
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 22:29:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728780AbfGXW3K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 18:29:10 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:52818 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726486AbfGXW3K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 18:29:10 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::d71])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id CC26F1543BD22;
        Wed, 24 Jul 2019 15:29:09 -0700 (PDT)
Date:   Wed, 24 Jul 2019 15:29:09 -0700 (PDT)
Message-Id: <20190724.152909.630985511198328199.davem@davemloft.net>
To:     jeffrey.t.kirsher@intel.com
Cc:     cai@lca.pw, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next v2] net/ixgbevf: fix a compilation error of
 skb_frag_t
From:   David Miller <davem@davemloft.net>
In-Reply-To: <8749f22284c5a557fe50a5dcc956c5d2c80037e2.camel@intel.com>
References: <4b5abf35a7b78ceae788ad7c2609d84dd33e5e9e.camel@intel.com>
        <20190724.144143.2055459359936675888.davem@davemloft.net>
        <8749f22284c5a557fe50a5dcc956c5d2c80037e2.camel@intel.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 24 Jul 2019 15:29:10 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Wed, 24 Jul 2019 15:02:15 -0700

> On Wed, 2019-07-24 at 14:41 -0700, David Miller wrote:
>> From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
>> Date: Wed, 24 Jul 2019 09:39:26 -0700
>> 
>> > Dave I will pick this up and add it to my queue.
>> 
>> How soon will you get that to me?  The sooner this build fix is cured
>> the
>> better.
> 
> Go ahead and pick it up, I was able to get it through an initial round
> of testing with no issues.  No need to wait for me to re-send it, I
> will go ahead and ACK Qian's patch.

Ok, done.

Thanks.
