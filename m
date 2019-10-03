Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE99CC4360C
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 00:25:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC1A5222C0
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 00:25:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729551AbfJCAZ2 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 20:25:28 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:38748 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725893AbfJCAZ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 20:25:27 -0400
Received: from localhost (unknown [IPv6:2601:601:9f00:1e2::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id E3C1B155283C1;
        Wed,  2 Oct 2019 17:25:26 -0700 (PDT)
Date:   Wed, 02 Oct 2019 17:25:26 -0700 (PDT)
Message-Id: <20191002.172526.1832563406015085740.davem@davemloft.net>
To:     j.neuschaefer@gmx.net
Cc:     linux-doc@vger.kernel.org, jeffrey.t.kirsher@intel.com,
        corbet@lwn.net, snelson@pensando.io, drivers@pensando.io,
        intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Documentation: networking: device drivers: Remove
 stray asterisks
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20191002150956.16234-1-j.neuschaefer@gmx.net>
References: <20191002150956.16234-1-j.neuschaefer@gmx.net>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 02 Oct 2019 17:25:27 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jonathan Neuschäfer <j.neuschaefer@gmx.net>
Date: Wed,  2 Oct 2019 17:09:55 +0200

> These asterisks were once references to a line that said:
>   "* Other names and brands may be claimed as the property of others."
> But now, they serve no purpose; they can only irritate the reader.
> 
> Fixes: de3edab4276c ("e1000: update README for e1000")
> Fixes: a3fb65680f65 ("e100.txt: Cleanup license info in kernel doc")
> Fixes: da8c01c4502a ("e1000e.txt: Add e1000e documentation")
> Fixes: f12a84a9f650 ("Documentation: fm10k: Add kernel documentation")
> Fixes: b55c52b1938c ("igb.txt: Add igb documentation")
> Fixes: c4e9b56e2442 ("igbvf.txt: Add igbvf Documentation")
> Fixes: d7064f4c192c ("Documentation/networking/: Update Intel wired LAN driver documentation")
> Fixes: c4b8c01112a1 ("ixgbevf.txt: Update ixgbevf documentation")
> Fixes: 1e06edcc2f22 ("Documentation: i40e: Prepare documentation for RST conversion")
> Fixes: 105bf2fe6b32 ("i40evf: add driver to kernel build system")
> Fixes: 1fae869bcf3d ("Documentation: ice: Prepare documentation for RST conversion")
> Fixes: df69ba43217d ("ionic: Add basic framework for IONIC Network device driver")
> Signed-off-by: Jonathan Neuschäfer <j.neuschaefer@gmx.net>

Jon, how do you want to handle changes like this?

I mean, there are unlikely to be conflicts from something like this so it
could simply go via the documentation tree.

Acked-by: David S. Miller <davem@davemloft.net>

I could also take it via net-next, either way is fine with me.

Just let me know.
