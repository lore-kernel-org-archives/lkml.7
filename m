Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EA9FC10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 15:43:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F91E2082E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 15:43:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726946AbfDLPnw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 11:43:52 -0400
Received: from muru.com ([72.249.23.125]:45640 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726780AbfDLPnw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 11:43:52 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 9F1A880F3;
        Fri, 12 Apr 2019 15:44:07 +0000 (UTC)
Date:   Fri, 12 Apr 2019 08:43:49 -0700
From:   Tony Lindgren <tony@atomide.com>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     Faiz Abbas <faiz_abbas@ti.com>, Rob Herring <robh@kernel.org>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH -next] bus: ti-sysc: Use PTR_ERR_OR_ZERO in
 sysc_init_resets()
Message-ID: <20190412154349.GX2839@atomide.com>
References: <20190411024708.123605-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190411024708.123605-1-yuehaibing@huawei.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* YueHaibing <yuehaibing@huawei.com> [190411 02:36]:
> Use PTR_ERR_OR_ZERO rather than if(IS_ERR(...)) + PTR_ERR

Thanks but I'll rather skip this one as I find it a bit hard
to read unless there's some reasoning other than compress
few lines out of the code.

Regards,

TOny
