Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38C19C28CC0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 15:43:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1761B23BAE
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 15:43:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727047AbfE2PnZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 11:43:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40548 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726097AbfE2PnX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 11:43:23 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4905A3082B71;
        Wed, 29 May 2019 15:43:15 +0000 (UTC)
Received: from [10.36.116.67] (ovpn-116-67.ams2.redhat.com [10.36.116.67])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 43C75272BB;
        Wed, 29 May 2019 15:43:09 +0000 (UTC)
From:   Auger Eric <eric.auger@redhat.com>
Subject: Re: [PATCH v5 3/7] iommu/vt-d: Introduce is_downstream_to_pci_bridge
 helper
To:     Christoph Hellwig <hch@infradead.org>
Cc:     eric.auger.pro@gmail.com, joro@8bytes.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        dwmw2@infradead.org, robin.murphy@arm.com,
        jean-philippe.brucker@arm.com, alex.williamson@redhat.com
References: <20190528115025.17194-1-eric.auger@redhat.com>
 <20190528115025.17194-4-eric.auger@redhat.com>
 <20190529062125.GC26055@infradead.org>
Message-ID: <f8edf6af-0c67-0e31-d28c-731e77f22a29@redhat.com>
Date:   Wed, 29 May 2019 17:43:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190529062125.GC26055@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Wed, 29 May 2019 15:43:23 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christoph,

On 5/29/19 8:21 AM, Christoph Hellwig wrote:
>> +/* is_downstream_to_pci_bridge - test if a device belongs to the
>> + * PCI sub-hierarchy of a candidate PCI-PCI bridge
>> + *
>> + * @dev: candidate PCI device belonging to @bridge PCI sub-hierarchy
>> + * @bridge: the candidate PCI-PCI bridge
>> + *
>> + * Return: true if @dev belongs to @bridge PCI sub-hierarchy
>> + */
> 
> This is not valid kerneldoc comment.  Try something like this:
> 
> /**
>  * is_downstream_to_pci_bridge - test if a device belongs to the PCI
>  *				 sub-hierarchy of a candidate PCI-PCI bridge
>  * @dev: candidate PCI device belonging to @bridge PCI sub-hierarchy
>  * @bridge: the candidate PCI-PCI bridge
>  *
>  * Returns true if @dev belongs to @bridge PCI sub-hierarchy, else false.
>  */
> 
Sure,

just replaced Returns by Return:

Thanks

Eric
