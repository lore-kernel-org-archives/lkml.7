Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAB2BC7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 19:13:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C66BE21955
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 19:13:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731542AbfGVTNS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 15:13:18 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:48000 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727474AbfGVTNR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 15:13:17 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::d71])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 51A4B15258BBE;
        Mon, 22 Jul 2019 12:13:17 -0700 (PDT)
Date:   Mon, 22 Jul 2019 12:13:16 -0700 (PDT)
Message-Id: <20190722.121316.472654771974510671.davem@davemloft.net>
To:     hslester96@gmail.com
Cc:     woojung.huh@microchip.com, UNGLinuxDriver@microchip.com,
        netdev@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: lan78xx: Merge memcpy + lexx_to_cpus to
 get_unaligned_lexx
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190719073614.1850-1-hslester96@gmail.com>
References: <20190719073614.1850-1-hslester96@gmail.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 22 Jul 2019 12:13:17 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chuhong Yuan <hslester96@gmail.com>
Date: Fri, 19 Jul 2019 15:36:15 +0800

> Merge the combo use of memcpy and lexx_to_cpus.
> Use get_unaligned_lexx instead.
> This simplifies the code.
> 
> Signed-off-by: Chuhong Yuan <hslester96@gmail.com>

Applied.
