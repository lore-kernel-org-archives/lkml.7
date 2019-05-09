Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82FBBC04A6B
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 00:12:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 551E2214AF
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 00:12:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727016AbfEIAML (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 20:12:11 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:54190 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726506AbfEIAMK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 20:12:10 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::3d8])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 0D8FA1479095F;
        Wed,  8 May 2019 17:12:10 -0700 (PDT)
Date:   Wed, 08 May 2019 17:12:09 -0700 (PDT)
Message-Id: <20190508.171209.2240089477300123652.davem@davemloft.net>
To:     hch@lst.de
Cc:     linux@roeck-us.net, sparclinux@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: fix SG list handling in the sparc32 iommu driver
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190416182347.18441-1-hch@lst.de>
References: <20190416182347.18441-1-hch@lst.de>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 08 May 2019 17:12:10 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christoph Hellwig <hch@lst.de>
Date: Tue, 16 Apr 2019 20:23:38 +0200

> this series fixes some long standing bugs in the sparc32 iommu driver,
> mostly the lack of handling of large sglist offsets in the map_sg
> method, but also a few other smaller bits.  These now show up all the
> time do some block layer changes in linux-next.

Series applied, thanks.
