Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCA84C3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 19:42:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C66C214DA
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 19:42:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730760AbfHTTmv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 15:42:51 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:50236 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730669AbfHTTmv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 15:42:51 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::d71])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id BE2C9146EADFF;
        Tue, 20 Aug 2019 12:42:50 -0700 (PDT)
Date:   Tue, 20 Aug 2019 12:42:50 -0700 (PDT)
Message-Id: <20190820.124250.137103175958708086.davem@davemloft.net>
To:     terry.s.duncan@linux.intel.com
Cc:     sam@mendozajonas.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org,
        wak@google.com, joel@jms.id.au
Subject: Re: [PATCH v2] net/ncsi: Ensure 32-bit boundary for data cksum
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190820002402.39001-1-terry.s.duncan@linux.intel.com>
References: <20190820002402.39001-1-terry.s.duncan@linux.intel.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Tue, 20 Aug 2019 12:42:51 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Terry S. Duncan" <terry.s.duncan@linux.intel.com>
Date: Mon, 19 Aug 2019 17:24:02 -0700

> The NCSI spec indicates that if the data does not end on a 32 bit
> boundary, one to three padding bytes equal to 0x00 shall be present to
> align the checksum field to a 32-bit boundary.
> 
> Signed-off-by: Terry S. Duncan <terry.s.duncan@linux.intel.com>

Applied.
