Return-Path: <SRS0=2uMJ=VL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BCF9C74A4B
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jul 2019 20:46:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FB93214AE
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jul 2019 20:46:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728871AbfGNUqR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Jul 2019 16:46:17 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:54640 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728371AbfGNUqR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Jul 2019 16:46:17 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::d71])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 5683D14EDFF0E;
        Sun, 14 Jul 2019 13:46:16 -0700 (PDT)
Date:   Sun, 14 Jul 2019 13:46:13 -0700 (PDT)
Message-Id: <20190714.134613.1481694238308689489.davem@davemloft.net>
To:     tasos@tasossah.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        stephen@networkplumber.org, mlindner@marvell.com
Subject: Re: [PATCH] sky2: Disable MSI on P5W DH Deluxe
From:   David Miller <davem@davemloft.net>
In-Reply-To: <14c872c3-09ac-7f51-dc3d-e68319459fcf@tasossah.com>
References: <14c872c3-09ac-7f51-dc3d-e68319459fcf@tasossah.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sun, 14 Jul 2019 13:46:16 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tasos Sahanidis <tasos@tasossah.com>
Date: Sun, 14 Jul 2019 13:31:11 +0300

> The onboard sky2 NICs send IRQs after S3, resulting in ethernet not
> working after resume.
> Maskable MSI and MSI-X are also not supported, so fall back to INTx.
> 
> Signed-off-by: Tasos Sahanidis <tasos@tasossah.com>

Applied, thanks.
