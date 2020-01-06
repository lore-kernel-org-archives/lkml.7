Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B150EC33C9A
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 06:04:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9037F20848
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 06:04:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726757AbgAFGES (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 01:04:18 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:4640 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726338AbgAFGER (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 01:04:17 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00663CPY125871
        for <linux-kernel@vger.kernel.org>; Mon, 6 Jan 2020 01:04:16 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2xb923y2su-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jan 2020 01:04:16 -0500
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <rppt@linux.ibm.com>;
        Mon, 6 Jan 2020 06:04:14 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 6 Jan 2020 06:04:11 -0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 00664BTl56164440
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 6 Jan 2020 06:04:11 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 13ABEAE04D;
        Mon,  6 Jan 2020 06:04:11 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A511FAE045;
        Mon,  6 Jan 2020 06:04:10 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.148.8.170])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Mon,  6 Jan 2020 06:04:10 +0000 (GMT)
Date:   Mon, 6 Jan 2020 08:04:09 +0200
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] memblock: Use __func__ in remaining memblock_dbg() call
 sites
References: <1578285510-28261-1-git-send-email-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1578285510-28261-1-git-send-email-anshuman.khandual@arm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-GCONF: 00
x-cbid: 20010606-4275-0000-0000-00000394F8F4
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20010606-4276-0000-0000-000038A8E0E1
Message-Id: <20200106060408.GA5413@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2020-01-06_01:2020-01-06,2020-01-06 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 impostorscore=0
 malwarescore=0 bulkscore=0 adultscore=0 phishscore=0 mlxscore=0
 mlxlogscore=999 priorityscore=1501 suspectscore=2 lowpriorityscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-2001060055
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 06, 2020 at 10:08:30AM +0530, Anshuman Khandual wrote:
> Replace open function name strings with %s (__func__) in all remaining
> memblock_dbg() call sites.
> 
> Cc: Mike Rapoport <rppt@linux.ibm.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>

Reviewed-by: Mike Rapoport <rppt@linux.ibm.com>

> ---
>  mm/memblock.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/mm/memblock.c b/mm/memblock.c
> index fc0d4db1d646..eba94ee3de0b 100644
> --- a/mm/memblock.c
> +++ b/mm/memblock.c
> @@ -694,7 +694,7 @@ int __init_memblock memblock_add(phys_addr_t base, phys_addr_t size)
>  {
>  	phys_addr_t end = base + size - 1;
>  
> -	memblock_dbg("memblock_add: [%pa-%pa] %pS\n",
> +	memblock_dbg("%s: [%pa-%pa] %pS\n", __func__,
>  		     &base, &end, (void *)_RET_IP_);
>  
>  	return memblock_add_range(&memblock.memory, base, size, MAX_NUMNODES, 0);
> @@ -795,7 +795,7 @@ int __init_memblock memblock_remove(phys_addr_t base, phys_addr_t size)
>  {
>  	phys_addr_t end = base + size - 1;
>  
> -	memblock_dbg("memblock_remove: [%pa-%pa] %pS\n",
> +	memblock_dbg("%s: [%pa-%pa] %pS\n", __func__,
>  		     &base, &end, (void *)_RET_IP_);
>  
>  	return memblock_remove_range(&memblock.memory, base, size);
> @@ -813,7 +813,7 @@ int __init_memblock memblock_free(phys_addr_t base, phys_addr_t size)
>  {
>  	phys_addr_t end = base + size - 1;
>  
> -	memblock_dbg("   memblock_free: [%pa-%pa] %pS\n",
> +	memblock_dbg("%s: [%pa-%pa] %pS\n", __func__,
>  		     &base, &end, (void *)_RET_IP_);
>  
>  	kmemleak_free_part_phys(base, size);
> @@ -824,7 +824,7 @@ int __init_memblock memblock_reserve(phys_addr_t base, phys_addr_t size)
>  {
>  	phys_addr_t end = base + size - 1;
>  
> -	memblock_dbg("memblock_reserve: [%pa-%pa] %pS\n",
> +	memblock_dbg("%s: [%pa-%pa] %pS\n", __func__,
>  		     &base, &end, (void *)_RET_IP_);
>  
>  	return memblock_add_range(&memblock.reserved, base, size, MAX_NUMNODES, 0);
> -- 
> 2.20.1
> 

-- 
Sincerely yours,
Mike.

