Return-Path: <SRS0=V+Ds=VJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7935FC742D2
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 22:26:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 537E92146E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 22:26:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728099AbfGLW0n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jul 2019 18:26:43 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:34240 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727245AbfGLW0n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jul 2019 18:26:43 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::d71])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id AC5E414E01C12;
        Fri, 12 Jul 2019 15:26:42 -0700 (PDT)
Date:   Fri, 12 Jul 2019 15:26:42 -0700 (PDT)
Message-Id: <20190712.152642.1572187171713415392.davem@davemloft.net>
To:     efremov@linux.com
Cc:     andrew@lunn.ch, f.fainelli@gmail.com, hkallweit1@gmail.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: phy: make exported variables non-static
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190710180324.8131-1-efremov@linux.com>
References: <20190710180324.8131-1-efremov@linux.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Fri, 12 Jul 2019 15:26:42 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Denis Efremov <efremov@linux.com>
Date: Wed, 10 Jul 2019 21:03:24 +0300

> The variables phy_basic_ports_array, phy_fibre_port_array and
> phy_all_ports_features_array are declared static and marked
> EXPORT_SYMBOL_GPL(), which is at best an odd combination.
> Because the variables were decided to be a part of API, this commit
> removes the static attributes and adds the declarations to the header.
> 
> Fixes: 3c1bcc8614db ("net: ethernet: Convert phydev advertize and supported from u32 to link mode")
> Signed-off-by: Denis Efremov <efremov@linux.com>

Applied, thanks.
