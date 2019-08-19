Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED858C3A5A1
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 11:38:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDDC82087B
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 11:38:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727412AbfHSLiS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 07:38:18 -0400
Received: from foss.arm.com ([217.140.110.172]:53038 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726703AbfHSLiS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 07:38:18 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1130E28;
        Mon, 19 Aug 2019 04:38:18 -0700 (PDT)
Received: from [10.37.12.162] (unknown [10.37.12.162])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AF6B23F246;
        Mon, 19 Aug 2019 04:38:16 -0700 (PDT)
Subject: Re: [Xen-devel] [PATCH 04/11] xen/arm: remove xen_dma_ops
To:     Christoph Hellwig <hch@lst.de>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc:     xen-devel@lists.xenproject.org, iommu@lists.linux-foundation.org,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20190816130013.31154-1-hch@lst.de>
 <20190816130013.31154-5-hch@lst.de>
From:   Julien Grall <julien.grall@arm.com>
Message-ID: <316d2032-334d-9a4c-7512-79bec5f0bc56@arm.com>
Date:   Mon, 19 Aug 2019 12:38:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190816130013.31154-5-hch@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christoph,

On 8/16/19 2:00 PM, Christoph Hellwig wrote:
> arm and arm64 can just use xen_swiotlb_dma_ops directly like x86, no
> need for a pointer indirection.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Julien Grall <julien.grall@arm.com>

Cheers,

-- 
Julien Grall
