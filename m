Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E72DDC43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 14:23:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C59AB208E4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 14:23:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728340AbfFXOXf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 10:23:35 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:54666 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727170AbfFXOXf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 10:23:35 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::d71])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 4AA411504101A;
        Mon, 24 Jun 2019 07:23:34 -0700 (PDT)
Date:   Mon, 24 Jun 2019 07:23:33 -0700 (PDT)
Message-Id: <20190624.072333.2300932810459542260.davem@davemloft.net>
To:     j-keerthy@ti.com
Cc:     ivan.khoronzhuk@linaro.org, andrew@lunn.ch,
        ilias.apalodimas@linaro.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, linux-omap@vger.kernel.org,
        t-kristo@ti.com, grygorii.strashko@ti.com, nsekhar@ti.com
Subject: Re: [PATCH V2] net: ethernet: ti: cpsw: Fix suspend/resume break
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190624051619.20146-1-j-keerthy@ti.com>
References: <20190624051619.20146-1-j-keerthy@ti.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 24 Jun 2019 07:23:34 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Keerthy <j-keerthy@ti.com>
Date: Mon, 24 Jun 2019 10:46:19 +0530

> Commit bfe59032bd6127ee190edb30be9381a01765b958 ("net: ethernet:
> ti: cpsw: use cpsw as drv data")changes
> the driver data to struct cpsw_common *cpsw. This is done
> only in probe/remove but the suspend/resume functions are
> still left with struct net_device *ndev. Hence fix both
> suspend & resume also to fetch the updated driver data.
> 
> Fixes: bfe59032bd6127ee1 ("net: ethernet: ti: cpsw: use cpsw as drv data")
> Signed-off-by: Keerthy <j-keerthy@ti.com>

Applied but please make it clear that changes are targetting net-next in the
future by saying "[PATCH net-next v2] ...." in your Subject line.

Thank you.
