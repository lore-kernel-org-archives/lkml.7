Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71887C43331
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 17:05:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51E7620870
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 17:05:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390936AbfIERFp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 13:05:45 -0400
Received: from foss.arm.com ([217.140.110.172]:47718 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387843AbfIERFp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 13:05:45 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8748228;
        Thu,  5 Sep 2019 10:05:44 -0700 (PDT)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.196.78])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 868103F718;
        Thu,  5 Sep 2019 10:05:42 -0700 (PDT)
Date:   Thu, 5 Sep 2019 18:05:40 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc:     hch@lst.de, wahrenst@gmx.net, marc.zyngier@arm.com,
        robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mm@kvack.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, f.fainelli@gmail.com,
        will@kernel.org, robin.murphy@arm.com, mbrugger@suse.com,
        linux-rpi-kernel@lists.infradead.org, phill@raspberrypi.org,
        m.szyprowski@samsung.com
Subject: Re: [PATCH v3 2/4] arm64: rename variables used to calculate
 ZONE_DMA32's size
Message-ID: <20190905170540.GE31268@arrakis.emea.arm.com>
References: <20190902141043.27210-1-nsaenzjulienne@suse.de>
 <20190902141043.27210-3-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190902141043.27210-3-nsaenzjulienne@suse.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 02, 2019 at 04:10:40PM +0200, Nicolas Saenz Julienne wrote:
> Let the name indicate that they are used to calculate ZONE_DMA32's size
> as opposed to ZONE_DMA.
> 
> Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
