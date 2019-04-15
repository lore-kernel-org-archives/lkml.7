Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DFABC10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 11:25:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1645F2087C
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 11:25:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727239AbfDOLZa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 07:25:30 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:60950 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726313AbfDOLZa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 07:25:30 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CA35280D;
        Mon, 15 Apr 2019 04:25:29 -0700 (PDT)
Received: from [10.162.43.203] (unknown [10.162.43.203])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BDE383F706;
        Mon, 15 Apr 2019 04:25:26 -0700 (PDT)
Subject: Re: [PATCH RESEND 2/3] mm: clean up is_device_*_page() definitions
To:     Robin Murphy <robin.murphy@arm.com>, linux-mm@kvack.org
Cc:     dan.j.williams@intel.com, ira.weiny@intel.com, jglisse@redhat.com,
        oohall@gmail.com, x86@kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
References: <cover.1555093412.git.robin.murphy@arm.com>
 <2adb3982a790078fe49fd454414a7b9c0fd60bcb.1555093412.git.robin.murphy@arm.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <a99d745b-af51-8389-e71e-7d16fcbfb79f@arm.com>
Date:   Mon, 15 Apr 2019 16:55:25 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <2adb3982a790078fe49fd454414a7b9c0fd60bcb.1555093412.git.robin.murphy@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 04/13/2019 12:31 AM, Robin Murphy wrote:
> Refactor is_device_{public,private}_page() with is_pci_p2pdma_page()
> to make them all consistent in depending on their respective config
> options even when CONFIG_DEV_PAGEMAP_OPS is enabled for other reasons.
> This allows a little more compile-time optimisation as well as the
> conceptual and cosmetic cleanup.
> 
> Suggested-by: Jerome Glisse <jglisse@redhat.com>
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>

Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>
