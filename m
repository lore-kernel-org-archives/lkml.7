Return-Path: <SRS0=A1VX=SJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA20AC282DA
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Apr 2019 01:32:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BC00213A2
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Apr 2019 01:32:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726578AbfDGBch (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Apr 2019 21:32:37 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:39760 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726144AbfDGBch (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Apr 2019 21:32:37 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::d71])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id C425C14BC08C8;
        Sat,  6 Apr 2019 18:32:36 -0700 (PDT)
Date:   Sat, 06 Apr 2019 18:32:36 -0700 (PDT)
Message-Id: <20190406.183236.1037754972349444691.davem@davemloft.net>
To:     m-karicheri2@ti.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        arvid.brodin@alten.se, a-kramer@ti.com
Subject: Re: [PATCH net 00/14] net: hsr: improvements and bug fixes
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190405173136.18050-1-m-karicheri2@ti.com>
References: <20190405173136.18050-1-m-karicheri2@ti.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sat, 06 Apr 2019 18:32:37 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Murali Karicheri <m-karicheri2@ti.com>
Date: Fri, 5 Apr 2019 13:31:22 -0400

> This series has some coding style fixes and other bug fixes.
> Patch 12/14, I have also done SPDX conversion. Not sure if
> that is the only thing needed and is correct. So please pay
> close attention to this patch before merge as I would like to
> avoid any issue related to licensing applicable for this code.

Series applied to net-next.
