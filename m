Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16430C10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 15:59:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3F042084C
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 15:59:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726709AbfDIP7W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 11:59:22 -0400
Received: from muru.com ([72.249.23.125]:45170 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726463AbfDIP7W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 11:59:22 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id DDFE38027;
        Tue,  9 Apr 2019 15:59:36 +0000 (UTC)
Date:   Tue, 9 Apr 2019 08:59:18 -0700
From:   Tony Lindgren <tony@atomide.com>
To:     Roger Quadros <rogerq@ti.com>
Cc:     s-anna@ti.com, t-kristo@ti.com, nsekhar@ti.com,
        linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] bus: ti-sysc: Add generic enable/disable functions
Message-ID: <20190409155918.GL2839@atomide.com>
References: <20190408095239.30378-1-rogerq@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190408095239.30378-1-rogerq@ti.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Roger Quadros <rogerq@ti.com> [190408 02:53]:
> For non legacy cases, add generic sysc_enable_module()
> and sysc_disable_module() functions.
> 
> Signed-off-by: Roger Quadros <rogerq@ti.com>
> ---
> Boot tested on
> - beagle-x15 (AM5728 GP EVM)
> - AM571x IDK
> - DRA7 EVM
> 
> Changelog:
> v2:
> - Add helper to get best idle mode.
> - Add comment about not preventing clockdomain autoidle
>   during enable/disable.
> - Omit PRU-ICSS specific handling. PRU-ICSS moudle can re-use omap4-simple.
>   The STANDBY_INIT and SUB_MWAIT bits are specific to PRUSS application
>   usage and should be managed by the PRUSS driver.

Thanks looks good to me, applying into omap-for-v5.2/ti-sysc.

Regards,

Tony
