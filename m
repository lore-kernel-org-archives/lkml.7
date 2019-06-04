Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 847D3C282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 20:09:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 645AD2070D
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 20:09:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726589AbfFDUJl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 16:09:41 -0400
Received: from gloria.sntech.de ([185.11.138.130]:50970 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726211AbfFDUJl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 16:09:41 -0400
Received: from ip5f5a6320.dynamic.kabel-deutschland.de ([95.90.99.32] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1hYFkU-00035B-AC; Tue, 04 Jun 2019 22:09:34 +0200
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v2] pwm: rockchip: Use of_clk_get_parent_count()
Date:   Tue, 04 Jun 2019 22:09:33 +0200
Message-ID: <1745663.OII0xTbMCj@diego>
In-Reply-To: <20190527135509.184544-1-wangkefeng.wang@huawei.com>
References: <20190525115941.108309-1-wangkefeng.wang@huawei.com> <20190527135509.184544-1-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Montag, 27. Mai 2019, 15:55:09 CEST schrieb Kefeng Wang:
> Use of_clk_get_parent_count() instead of open coding.
> 
> Cc: Thierry Reding <thierry.reding@gmail.com>
> Cc: Heiko Stuebner <heiko@sntech.de>
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>

on multiple rockchip boards with multiple pwm-regulator and -backlight
Tested-by: Heiko Stuebner <heiko@sntech.de>


