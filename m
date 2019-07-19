Return-Path: <SRS0=NvuC=VQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABC0BC7618F
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 02:25:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B39C2085A
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 02:25:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726728AbfGSCZp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jul 2019 22:25:45 -0400
Received: from mx0b-002e3701.pphosted.com ([148.163.143.35]:9650 "EHLO
        mx0b-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726015AbfGSCZp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 22:25:45 -0400
Received: from pps.filterd (m0134425.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6J2Ks5G001476;
        Fri, 19 Jul 2019 02:25:23 GMT
Received: from g9t5009.houston.hpe.com (g9t5009.houston.hpe.com [15.241.48.73])
        by mx0b-002e3701.pphosted.com with ESMTP id 2tu3mm0h9j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 19 Jul 2019 02:25:23 +0000
Received: from g9t2301.houston.hpecorp.net (g9t2301.houston.hpecorp.net [16.220.97.129])
        by g9t5009.houston.hpe.com (Postfix) with ESMTP id A588B6D;
        Fri, 19 Jul 2019 02:25:22 +0000 (UTC)
Received: from [16.116.130.82] (unknown [16.116.130.82])
        by g9t2301.houston.hpecorp.net (Postfix) with ESMTP id 5ED6A4C;
        Fri, 19 Jul 2019 02:25:21 +0000 (UTC)
Subject: Re: [PATCH v3 8/9] x86/mm/tlb: Remove UV special case
To:     Nadav Amit <namit@vmware.com>, Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@intel.com>
References: <20190719005837.4150-1-namit@vmware.com>
 <20190719005837.4150-9-namit@vmware.com>
From:   Mike Travis <mike.travis@hpe.com>
Message-ID: <54c082c5-ebee-8fd7-cf69-b8c15b60a329@hpe.com>
Date:   Thu, 18 Jul 2019 19:25:29 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <20190719005837.4150-9-namit@vmware.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-19_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1907190027
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is a fact that the UV is still the UV and SGI is now part of HPE. 
The current external product is known as SuperDome Flex.  It is both up 
to date as well as very well maintained.  The ACK I provided was an okay 
to change the code, but please make the description accurate.

On 7/18/2019 5:58 PM, Nadav Amit wrote:
> SGI UV support is outdated and not maintained, and it is not clear how
> it performs relatively to non-UV. Remove the code to simplify the code.
> 
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Dave Hansen <dave.hansen@intel.com>
> Acked-by: Mike Travis <mike.travis@hpe.com>
> Suggested-by: Andy Lutomirski <luto@kernel.org>
> Signed-off-by: Nadav Amit <namit@vmware.com>
> ---
>   arch/x86/mm/tlb.c | 25 -------------------------
>   1 file changed, 25 deletions(-)
> 
> diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
> index 89f83ad19507..40daad52ec7d 100644
> --- a/arch/x86/mm/tlb.c
> +++ b/arch/x86/mm/tlb.c
> @@ -684,31 +684,6 @@ void native_flush_tlb_multi(const struct cpumask *cpumask,
>   		trace_tlb_flush(TLB_REMOTE_SEND_IPI,
>   				(info->end - info->start) >> PAGE_SHIFT);
>   
> -	if (is_uv_system()) {
> -		/*
> -		 * This whole special case is confused.  UV has a "Broadcast
> -		 * Assist Unit", which seems to be a fancy way to send IPIs.
> -		 * Back when x86 used an explicit TLB flush IPI, UV was
> -		 * optimized to use its own mechanism.  These days, x86 uses
> -		 * smp_call_function_many(), but UV still uses a manual IPI,
> -		 * and that IPI's action is out of date -- it does a manual
> -		 * flush instead of calling flush_tlb_func_remote().  This
> -		 * means that the percpu tlb_gen variables won't be updated
> -		 * and we'll do pointless flushes on future context switches.
> -		 *
> -		 * Rather than hooking native_flush_tlb_multi() here, I think
> -		 * that UV should be updated so that smp_call_function_many(),
> -		 * etc, are optimal on UV.
> -		 */
> -		flush_tlb_func_local((void *)info);
> -
> -		cpumask = uv_flush_tlb_others(cpumask, info);
> -		if (cpumask)
> -			smp_call_function_many(cpumask, flush_tlb_func_remote,
> -					       (void *)info, 1);
> -		return;
> -	}
> -
>   	/*
>   	 * If no page tables were freed, we can skip sending IPIs to
>   	 * CPUs in lazy TLB mode. They will flush the CPU themselves
> 
