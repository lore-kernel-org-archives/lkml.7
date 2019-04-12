Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E4A6C10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 14:59:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 735652083E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 14:59:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726836AbfDLO74 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 10:59:56 -0400
Received: from 8bytes.org ([81.169.241.247]:34498 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726714AbfDLO74 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 10:59:56 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id A3DEF2DE; Fri, 12 Apr 2019 16:59:54 +0200 (CEST)
Date:   Fri, 12 Apr 2019 16:59:54 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Cc:     "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "christian.koenig@amd.com" <christian.koenig@amd.com>,
        "kevin.tian@intel.com" <kevin.tian@intel.com>,
        "jacob.jun.pan@linux.intel.com" <jacob.jun.pan@linux.intel.com>,
        "ashok.raj@intel.com" <ashok.raj@intel.com>,
        "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
        "zhangfei.gao@foxmail.com" <zhangfei.gao@foxmail.com>
Subject: Re: [PATCH v3 1/1] iommu: Bind process address spaces to devices
Message-ID: <20190412145954.GD29810@8bytes.org>
References: <20190410151516.47754-1-jean-philippe.brucker@arm.com>
 <20190410151516.47754-2-jean-philippe.brucker@arm.com>
 <20190411152803.GB29810@8bytes.org>
 <aa213d61-2351-73f4-629c-08a18320fbec@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aa213d61-2351-73f4-629c-08a18320fbec@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Jean-Philippe,

On Fri, Apr 12, 2019 at 01:23:51PM +0100, Jean-Philippe Brucker wrote:
> I pushed a cleaner version to git://linux-arm.org/linux-jpb.git sva/api
> (with the below mistake fixed as well) and can resend if necessary.

No need to do that, I solved the conflicts I've seen and compile-testing
looked good so far, so I've pushed it out already. Maybe you can
double-check my tree if everything is as it should be?

Regards,

	Joerg
