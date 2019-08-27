Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CBCFC3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 09:41:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FA9D20828
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 09:41:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729593AbfH0Jlm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 05:41:42 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:5222 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728806AbfH0Jlm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 05:41:42 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id D708052352A06A23A45C;
        Tue, 27 Aug 2019 17:41:38 +0800 (CST)
Received: from [10.177.253.249] (10.177.253.249) by smtp.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.439.0; Tue, 27 Aug 2019
 17:41:38 +0800
Subject: Re: [Virtio-fs] [PATCH 04/19] virtio: Implement get_shm_region for
 PCI transport
To:     Vivek Goyal <vgoyal@redhat.com>
References: <20190821175720.25901-1-vgoyal@redhat.com>
 <20190821175720.25901-5-vgoyal@redhat.com> <5D63392C.3030404@huawei.com>
 <20190826130607.GB3561@redhat.com>
CC:     <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-nvdimm@lists.01.org>, kbuild test robot <lkp@intel.com>,
        <kvm@vger.kernel.org>, <miklos@szeredi.hu>, <virtio-fs@redhat.com>,
        "Sebastien Boeuf" <sebastien.boeuf@intel.com>
From:   piaojun <piaojun@huawei.com>
Message-ID: <5D64FAD2.2050906@huawei.com>
Date:   Tue, 27 Aug 2019 17:41:38 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.2.0
MIME-Version: 1.0
In-Reply-To: <20190826130607.GB3561@redhat.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.253.249]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019/8/26 21:06, Vivek Goyal wrote:
> On Mon, Aug 26, 2019 at 09:43:08AM +0800, piaojun wrote:
> 
> [..]
>>> +static bool vp_get_shm_region(struct virtio_device *vdev,
>>> +			      struct virtio_shm_region *region, u8 id)
>>> +{
>>> +	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
>>> +	struct pci_dev *pci_dev = vp_dev->pci_dev;
>>> +	u8 bar;
>>> +	u64 offset, len;
>>> +	phys_addr_t phys_addr;
>>> +	size_t bar_len;
>>> +	char *bar_name;
>>
>> 'char *bar_name' should be cleaned up to avoid compiling warning. And I
>> wonder if you mix tab and blankspace for code indent? Or it's just my
>> email display problem?
> 
> Will get rid of now unused bar_name. 
> 
OK

> Generally git flags if there are tab/space issues. I did not see any. So
> if you see something, point it out and I will fix it.
> 

cohuck found the same indent problem and pointed them in another email.

Jun
