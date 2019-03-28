Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2C69C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 11:49:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D12220700
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 11:49:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727058AbfC1Ltg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 07:49:36 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:48706 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726117AbfC1Ltf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 07:49:35 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2SBeirN116843
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2019 07:49:34 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2rgwkhr9w9-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2019 07:49:33 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <rppt@linux.ibm.com>;
        Thu, 28 Mar 2019 11:49:32 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 28 Mar 2019 11:49:28 -0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x2SBnRYN38207632
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 Mar 2019 11:49:27 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 259E2AE045;
        Thu, 28 Mar 2019 11:49:27 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 72F92AE04D;
        Thu, 28 Mar 2019 11:49:26 +0000 (GMT)
Received: from rapoport-lnx (unknown [9.148.8.112])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Thu, 28 Mar 2019 11:49:26 +0000 (GMT)
Date:   Thu, 28 Mar 2019 13:49:24 +0200
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        Albert Ou <aou@eecs.berkeley.edu>,
        Jonathan Corbet <corbet@lwn.net>,
        Palmer Dabbelt <palmer@sifive.com>,
        Stephen Bates <sbates@raithlin.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 2/7] RISC-V: doc: Add file describing the virtual memory
 map
References: <20190327213643.23789-1-logang@deltatee.com>
 <20190327213643.23789-3-logang@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190327213643.23789-3-logang@deltatee.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-GCONF: 00
x-cbid: 19032811-0016-0000-0000-000002686884
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19032811-0017-0000-0000-000032C3AAF6
Message-Id: <20190328114924.GD14864@rapoport-lnx>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-28_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1903280084
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Mar 27, 2019 at 03:36:38PM -0600, Logan Gunthorpe wrote:
> This file is similar to the x86_64 equivalent (in
> Documentation/x86/x86_64/mm.txt) and describes the virtuas address space
> usage for RISC-V.
> 
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: Palmer Dabbelt <palmer@sifive.com>
> Cc: Albert Ou <aou@eecs.berkeley.edu>
> ---
>  Documentation/riscv/mm.txt | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
>  create mode 100644 Documentation/riscv/mm.txt
> 
> diff --git a/Documentation/riscv/mm.txt b/Documentation/riscv/mm.txt
> new file mode 100644
> index 000000000000..725dc85f2c65
> --- /dev/null
> +++ b/Documentation/riscv/mm.txt
> @@ -0,0 +1,24 @@
> +Sv32:
> +
> +00000000 - 7fffffff   user space, different per mm (2G)
> +80000000 - 81ffffff   virtual memory map (32MB)
> +82000000 - bfffffff   vmalloc/ioremap space (1GB - 32MB)
> +c0000000 - ffffffff   direct mapping of lower phys. memory (1GB)
> +
> +Sv39:
> +
> +0000000000000000 - 0000003fffffffff  user space, different per mm (256GB)
> +hole caused by [38:63] sign extension
> +ffffffc000000000 - ffffffc0ffffffff  virtual memory map (4GB)
> +ffffffc100000000 - ffffffd0ffffffff  vmalloc/ioremap spac (64GB)
> +ffffffd100000000 - ffffffffffffffff  linear mapping of physical space (188GB)
> +  ffffffd200000000 - 0xfffffff200000000 linear mapping of all physical memory
> +
> +The RISC-V architecture defines virtual address bits in multiples of nine
> +starting from 39. These are referred to as Sv39, Sv48, Sv57 and Sv64.
> +Currently only Sv39 is supported. Bits 63 through to the most-significant
> +implemented bit are sign extended. This causes a hole between user space
> +and kernel addresses if you interpret them as unsigned.
> +
> +The direct mapping covers as much of the physical memory space as
> +possible so that it may cover some IO memory.

Please move the text before the tables, so that meaning of Sv32 and Sv39
would be clear.

> -- 
> 2.20.1
> 
> 
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
> 

-- 
Sincerely yours,
Mike.

