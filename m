Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E3B8C31E44
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 23:27:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C5B421721
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 23:27:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408103AbfFKX1v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 19:27:51 -0400
Received: from mga02.intel.com ([134.134.136.20]:26079 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404692AbfFKX1u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 19:27:50 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Jun 2019 16:27:50 -0700
X-ExtLoop1: 1
Received: from allen-box.sh.intel.com (HELO [10.239.159.136]) ([10.239.159.136])
  by orsmga004.jf.intel.com with ESMTP; 11 Jun 2019 16:27:48 -0700
Cc:     baolu.lu@linux.intel.com, James Sewart <jamessewart@arista.com>,
        Joerg Roedel <jroedel@suse.de>,
        iommu@lists.linux-foundation.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kashyap Desai <kashyap.desai@broadcom.com>,
        Sumit Saxena <sumit.saxena@broadcom.com>,
        Shivasharan S <shivasharan.srikanteshwara@broadcom.com>
Subject: Re: "iommu/vt-d: Delegate DMA domain to generic iommu" series breaks
 megaraid_sas
To:     Qian Cai <cai@lca.pw>
References: <1559941717.6132.63.camel@lca.pw>
 <1e4f0642-e4e1-7602-3f50-37edc84ced50@linux.intel.com>
 <1560174264.6132.65.camel@lca.pw> <1560178459.6132.66.camel@lca.pw>
 <2ff8404d-7103-a96d-2749-ac707ce74563@linux.intel.com>
 <AB191BD9-239D-4962-AED3-52AABED5C7C0@lca.pw>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <dfd86f69-e4b2-06f7-d99c-6e0580ae00d6@linux.intel.com>
Date:   Wed, 12 Jun 2019 07:20:40 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <AB191BD9-239D-4962-AED3-52AABED5C7C0@lca.pw>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 6/11/19 10:00 PM, Qian Cai wrote:
> 
>> On Jun 10, 2019, at 9:41 PM, Lu Baolu<baolu.lu@linux.intel.com>  wrote:
>>
>> Ah, good catch!
>>
>> The device failed to be attached by a DMA domain. Can you please try the
>> attached fix patch?
> It works fine.
> 

Thanks a lot for the report and verification.

Best regards,
Baolu
