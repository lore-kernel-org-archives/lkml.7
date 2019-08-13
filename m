Return-Path: <SRS0=Ecng=WJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B07BC32750
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 11:40:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 759E8204EC
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 11:40:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727327AbfHMLko (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 07:40:44 -0400
Received: from muru.com ([72.249.23.125]:57182 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725981AbfHMLko (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 07:40:44 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id BB8928179;
        Tue, 13 Aug 2019 11:41:11 +0000 (UTC)
Date:   Tue, 13 Aug 2019 04:40:41 -0700
From:   Tony Lindgren <tony@atomide.com>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     rogerq@ti.com, faiz_abbas@ti.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] bus: ti-sysc: remove set but not used variable
 'quirks'
Message-ID: <20190813114041.GQ52127@atomide.com>
References: <20190628041054.46216-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190628041054.46216-1-yuehaibing@huawei.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* YueHaibing <yuehaibing@huawei.com> [190627 21:17]:
> Fixes gcc '-Wunused-but-set-variable' warning:
> 
> drivers/bus/ti-sysc.c: In function sysc_reset:
> drivers/bus/ti-sysc.c:1452:50: warning: variable quirks set but not used [-Wunused-but-set-variable]
> 
> It is never used since commit e0db94fe87da ("bus: ti-sysc: Make
> OCP reset work for sysstatus and sysconfig reset bits")

Applying into omap-for-v5.4/ti-sysc thanks.

Tony
