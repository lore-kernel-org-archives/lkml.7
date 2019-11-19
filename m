Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1303DC432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 02:58:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8CAD22316
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 02:58:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727334AbfKSC6e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 21:58:34 -0500
Received: from mga05.intel.com ([192.55.52.43]:29917 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727014AbfKSC6e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 21:58:34 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Nov 2019 18:58:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,322,1569308400"; 
   d="scan'208";a="204263224"
Received: from allen-box.sh.intel.com (HELO [10.239.159.136]) ([10.239.159.136])
  by fmsmga008.fm.intel.com with ESMTP; 18 Nov 2019 18:58:32 -0800
Cc:     baolu.lu@linux.intel.com, iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        Raj Ashok <ashok.raj@intel.com>, Yi Liu <yi.l.liu@intel.com>
Subject: Re: [PATCH v2 01/10] iommu/vt-d: Introduce native SVM capable flag
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Auger Eric <eric.auger@redhat.com>
References: <1574106153-45867-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1574106153-45867-2-git-send-email-jacob.jun.pan@linux.intel.com>
 <cb44724d-a396-0291-63c4-0039788fd26b@redhat.com>
 <20191118134809.66b9fda4@jacob-builder>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <efe5a47d-1209-2c09-bc66-b1ebbc671439@linux.intel.com>
Date:   Tue, 19 Nov 2019 10:55:29 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191118134809.66b9fda4@jacob-builder>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 11/19/19 5:48 AM, Jacob Pan wrote:
> On Mon, 18 Nov 2019 21:33:53 +0100
> Auger Eric <eric.auger@redhat.com> wrote:
> 
>> Hi Jacob,
>>
>> On 11/18/19 8:42 PM, Jacob Pan wrote:
>>> Shared Virtual Memory(SVM) is based on a collective set of hardware
>>> features detected at runtime. There are requirements for matching
>>> CPU and IOMMU capabilities.
>>>
>>> This patch introduces a flag which will be used to mark and test the
>>> capability of SVM.
>>>
>>> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
>>> Acked-by: Lu Baolu <baolu.lu@linux.intel.com>
>>> ---
>>>   include/linux/intel-iommu.h | 1 +
>>>   1 file changed, 1 insertion(+)
>>>
>>> diff --git a/include/linux/intel-iommu.h
>>> b/include/linux/intel-iommu.h index ed11ef594378..63118991824c
>>> 100644 --- a/include/linux/intel-iommu.h
>>> +++ b/include/linux/intel-iommu.h
>>> @@ -433,6 +433,7 @@ enum {
>>>   
>>>   #define VTD_FLAG_TRANS_PRE_ENABLED	(1 << 0)
>>>   #define VTD_FLAG_IRQ_REMAP_PRE_ENABLED	(1 << 1)
>>> +#define VTD_FLAG_SVM_CAPABLE		(1 << 2)
>>
>> I think I would rather squash this into the next patch as there is no
>> user here.
>>
> Sure, I don't have strong preference. Baolu, what is your call?

It's okay for me.

Best regards,
baolu
