Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 398CEC76195
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 09:50:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B7CD2199C
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 09:50:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729390AbfGVJux (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 05:50:53 -0400
Received: from foss.arm.com ([217.140.110.172]:34572 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729203AbfGVJus (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 05:50:48 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EB82128;
        Mon, 22 Jul 2019 02:50:47 -0700 (PDT)
Received: from [10.162.41.186] (p8cg001049571a15.blr.arm.com [10.162.41.186])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4C5EB3F694;
        Mon, 22 Jul 2019 02:50:46 -0700 (PDT)
Subject: Re: [PATCH] memremap: move from kernel/ to mm/
To:     Christoph Hellwig <hch@lst.de>, dan.j.williams@intel.com,
        akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-nvdimm@lists.01.org,
        linux-kernel@vger.kernel.org
References: <20190722094143.18387-1-hch@lst.de>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <9cd09b82-ec86-b0c0-79d5-e26ed5ed0b23@arm.com>
Date:   Mon, 22 Jul 2019 15:21:23 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190722094143.18387-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 07/22/2019 03:11 PM, Christoph Hellwig wrote:
> memremap.c implements MM functionality for ZONE_DEVICE, so it really
> should be in the mm/ directory, not the kernel/ one.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

This always made sense.

FWIW

Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>
