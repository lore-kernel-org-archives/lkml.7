Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA3C1C10F14
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 16:05:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B00172073F
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 16:05:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727281AbfDLQFa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 12:05:30 -0400
Received: from foss.arm.com ([217.140.101.70]:35646 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727229AbfDLQF2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 12:05:28 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D64E415AB;
        Fri, 12 Apr 2019 09:05:27 -0700 (PDT)
Received: from [10.1.196.129] (ostrya.cambridge.arm.com [10.1.196.129])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9D3653F557;
        Fri, 12 Apr 2019 09:05:26 -0700 (PDT)
Subject: Re: [PATCH v3 1/1] iommu: Bind process address spaces to devices
To:     Joerg Roedel <joro@8bytes.org>
Cc:     "kevin.tian@intel.com" <kevin.tian@intel.com>,
        "ashok.raj@intel.com" <ashok.raj@intel.com>,
        "zhangfei.gao@foxmail.com" <zhangfei.gao@foxmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "christian.koenig@amd.com" <christian.koenig@amd.com>
References: <20190410151516.47754-1-jean-philippe.brucker@arm.com>
 <20190410151516.47754-2-jean-philippe.brucker@arm.com>
 <20190411152803.GB29810@8bytes.org>
 <aa213d61-2351-73f4-629c-08a18320fbec@arm.com>
 <20190412145954.GD29810@8bytes.org>
From:   Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Message-ID: <52decdcd-765a-4c1a-bb4c-99490629b310@arm.com>
Date:   Fri, 12 Apr 2019 17:05:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.3
MIME-Version: 1.0
In-Reply-To: <20190412145954.GD29810@8bytes.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/04/2019 15:59, Joerg Roedel wrote:
> Hey Jean-Philippe,
> 
> On Fri, Apr 12, 2019 at 01:23:51PM +0100, Jean-Philippe Brucker wrote:
>> I pushed a cleaner version to git://linux-arm.org/linux-jpb.git sva/api
>> (with the below mistake fixed as well) and can resend if necessary.
> 
> No need to do that, I solved the conflicts I've seen and compile-testing
> looked good so far, so I've pushed it out already. Maybe you can
> double-check my tree if everything is as it should be?

It looks fine, thanks!

Jean
