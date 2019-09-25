Return-Path: <SRS0=wETr=XU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07B38C432C1
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 09:40:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4EFF2082F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 09:40:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727233AbfIYJkf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Sep 2019 05:40:35 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:33514 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726816AbfIYJke (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 05:40:34 -0400
Received: from localhost (unknown [65.39.69.237])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 0E0731549287F;
        Wed, 25 Sep 2019 02:40:32 -0700 (PDT)
Date:   Wed, 25 Sep 2019 11:40:31 +0200 (CEST)
Message-Id: <20190925.114031.379108392028630817.davem@davemloft.net>
To:     bruno@wolff.to
Cc:     Jason@zx2c4.com, wireguard@lists.zx2c4.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: WireGuard to port to existing Crypto API
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190925091700.GA9970@wolff.to>
References: <CAHmME9pmfZAp5zd9BDLFc2fWUhtzZcjYZc2atTPTyNFFmEdHLg@mail.gmail.com>
        <20190925091700.GA9970@wolff.to>
X-Mailer: Mew version 6.8 on Emacs 26.2
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 25 Sep 2019 02:40:34 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bruno Wolff III <bruno@wolff.to>
Date: Wed, 25 Sep 2019 04:17:00 -0500

> Are there going to be two branches, one for using the current API and
> one using Zinc?

This is inapproprate to even discuss at this point.

Let's see what the crypto based stuff looks like, evaluate it,
and then decide how to proceed forward.

Thank you.
