Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14BE1C43603
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 20:30:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E05DE2073C
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 20:30:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728151AbfLDUaa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 15:30:30 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:36230 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727911AbfLDUaa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 15:30:30 -0500
Received: from localhost (unknown [IPv6:2601:601:9f00:1c3::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 44EE414D78B18;
        Wed,  4 Dec 2019 12:30:29 -0800 (PST)
Date:   Wed, 04 Dec 2019 12:30:28 -0800 (PST)
Message-Id: <20191204.123028.954480458693026520.davem@davemloft.net>
To:     ykaukab@suse.de
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, tharvey@gateworks.com,
        rric@kernel.org, sgoutham@cavium.com
Subject: Re: [PATCH] net: thunderx: start phy before starting
 autonegotiation
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20191204152651.13418-1-ykaukab@suse.de>
References: <20191204152651.13418-1-ykaukab@suse.de>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 04 Dec 2019 12:30:29 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mian Yousaf Kaukab <ykaukab@suse.de>
Date: Wed,  4 Dec 2019 16:26:51 +0100

> Since "2b3e88ea6528 net: phy: improve phy state checking"

As Sergei said, please format this properly and make it the
Fixes: tag.

Thank you.
