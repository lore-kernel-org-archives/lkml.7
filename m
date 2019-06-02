Return-Path: <SRS0=BIzH=UB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80513C28CC6
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Jun 2019 20:50:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 619A727973
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Jun 2019 20:50:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726869AbfFBUuN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Jun 2019 16:50:13 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:48296 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726270AbfFBUuM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jun 2019 16:50:12 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id ACB2F1411B403;
        Sun,  2 Jun 2019 13:50:10 -0700 (PDT)
Date:   Sun, 02 Jun 2019 13:50:10 -0700 (PDT)
Message-Id: <20190602.135010.1382762534390460032.davem@davemloft.net>
To:     horatiu.vultur@microchip.com
Cc:     alexandre.belloni@bootlin.com, UNGLinuxDriver@microchip.com,
        robh+dt@kernel.org, mark.rutland@arm.com, ralf@linux-mips.org,
        paul.burton@mips.com, jhogan@kernel.org,
        linux-mips@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v3 0/2] Add hw offload of TC flower on MSCC
 Ocelot
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1559287017-32397-1-git-send-email-horatiu.vultur@microchip.com>
References: <1559287017-32397-1-git-send-email-horatiu.vultur@microchip.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sun, 02 Jun 2019 13:50:11 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Horatiu Vultur <horatiu.vultur@microchip.com>
Date: Fri, 31 May 2019 09:16:55 +0200

> This patch series enables hardware offload for flower filter used in
> traffic controller on MSCC Ocelot board.
> 
> v2->v3 changes:
>  - remove the check for shared blocks
> 
> v1->v2 changes:
>  - when declaring variables use reverse christmas tree

Series applied, thanks.
