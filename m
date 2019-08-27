Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF3ADC3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 08:21:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92A95206BF
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 08:21:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729711AbfH0IV6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 04:21:58 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:23098 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729414AbfH0IV5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 04:21:57 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7R8Ik0d038098
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2019 04:21:56 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2umxgv5ftq-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2019 04:21:56 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <rppt@linux.ibm.com>;
        Tue, 27 Aug 2019 08:51:45 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 27 Aug 2019 08:51:40 +0100
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x7R7pd6A63242378
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 27 Aug 2019 07:51:39 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 57D43A4057;
        Tue, 27 Aug 2019 07:51:39 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6AF34A404D;
        Tue, 27 Aug 2019 07:51:38 +0000 (GMT)
Received: from rapoport-lnx (unknown [9.148.8.59])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Tue, 27 Aug 2019 07:51:38 +0000 (GMT)
Date:   Tue, 27 Aug 2019 10:51:36 +0300
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     Atish Patra <atish.patra@wdc.com>
Cc:     linux-kernel@vger.kernel.org, Albert Ou <aou@eecs.berkeley.edu>,
        Alan Kao <alankao@andestech.com>,
        Alexios Zavras <alexios.zavras@intel.com>,
        Anup Patel <anup@brainfault.org>,
        Palmer Dabbelt <palmer@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Gary Guo <gary@garyguo.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-riscv@lists.infradead.org,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [RFC PATCH 1/2] RISC-V: Mark existing SBI as legacy SBI.
References: <20190826233256.32383-1-atish.patra@wdc.com>
 <20190826233256.32383-2-atish.patra@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190826233256.32383-2-atish.patra@wdc.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-GCONF: 00
x-cbid: 19082707-0016-0000-0000-000002A36547
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19082707-0017-0000-0000-00003303AEC4
Message-Id: <20190827075136.GC682@rapoport-lnx>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-26_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908270093
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 26, 2019 at 04:32:55PM -0700, Atish Patra wrote:
> As per the new SBI specification, current SBI implementation is
> defined as legacy and will be removed/replaced in future.
> 
> Rename existing implementation to reflect that. This patch is just
> a preparatory patch for SBI v0.2 and doesn't introduce any functional
> changes.
> 
> Signed-off-by: Atish Patra <atish.patra@wdc.com>
> ---
>  arch/riscv/include/asm/sbi.h | 61 +++++++++++++++++++-----------------
>  1 file changed, 33 insertions(+), 28 deletions(-)
> 
> diff --git a/arch/riscv/include/asm/sbi.h b/arch/riscv/include/asm/sbi.h
> index 21134b3ef404..7f5ecaaaa0d7 100644
> --- a/arch/riscv/include/asm/sbi.h
> +++ b/arch/riscv/include/asm/sbi.h
> @@ -8,17 +8,18 @@
>  
>  #include <linux/types.h>
>  
> -#define SBI_SET_TIMER 0
> -#define SBI_CONSOLE_PUTCHAR 1
> -#define SBI_CONSOLE_GETCHAR 2
> -#define SBI_CLEAR_IPI 3
> -#define SBI_SEND_IPI 4
> -#define SBI_REMOTE_FENCE_I 5
> -#define SBI_REMOTE_SFENCE_VMA 6
> -#define SBI_REMOTE_SFENCE_VMA_ASID 7
> -#define SBI_SHUTDOWN 8
> -
> -#define SBI_CALL(which, arg0, arg1, arg2, arg3) ({		\
> +
> +#define SBI_EXT_LEGACY_SET_TIMER 0x0
> +#define SBI_EXT_LEGACY_CONSOLE_PUTCHAR 0x1
> +#define SBI_EXT_LEGACY_CONSOLE_GETCHAR 0x2
> +#define SBI_EXT_LEGACY_CLEAR_IPI 0x3
> +#define SBI_EXT_LEGACY_SEND_IPI 0x4
> +#define SBI_EXT_LEGACY_REMOTE_FENCE_I 0x5
> +#define SBI_EXT_LEGACY_REMOTE_SFENCE_VMA 0x6
> +#define SBI_EXT_LEGACY_REMOTE_SFENCE_VMA_ASID 0x7
> +#define SBI_EXT_LEGACY_SHUTDOWN 0x8

I can't say I'm closely following RISC-V development, but what will happen
when SBI v0.3 will come out and will render v0.2 legacy?
Won't we need another similar renaming then?

> +#define SBI_CALL_LEGACY(which, arg0, arg1, arg2, arg3) ({             \
>  	register uintptr_t a0 asm ("a0") = (uintptr_t)(arg0);	\
>  	register uintptr_t a1 asm ("a1") = (uintptr_t)(arg1);	\
>  	register uintptr_t a2 asm ("a2") = (uintptr_t)(arg2);	\
> @@ -32,58 +33,61 @@
>  })
>  
>  /* Lazy implementations until SBI is finalized */
> -#define SBI_CALL_0(which) SBI_CALL(which, 0, 0, 0, 0)
> -#define SBI_CALL_1(which, arg0) SBI_CALL(which, arg0, 0, 0, 0)
> -#define SBI_CALL_2(which, arg0, arg1) SBI_CALL(which, arg0, arg1, 0, 0)
> -#define SBI_CALL_3(which, arg0, arg1, arg2) \
> -		SBI_CALL(which, arg0, arg1, arg2, 0)
> -#define SBI_CALL_4(which, arg0, arg1, arg2, arg3) \
> -		SBI_CALL(which, arg0, arg1, arg2, arg3)
> +#define SBI_CALL_LEGACY_0(which) SBI_CALL_LEGACY(which, 0, 0, 0, 0)
> +#define SBI_CALL_LEGACY_1(which, arg0) SBI_CALL_LEGACY(which, arg0, 0, 0, 0)
> +#define SBI_CALL_LEGACY_2(which, arg0, arg1) \
> +		SBI_CALL_LEGACY(which, arg0, arg1, 0, 0)
> +#define SBI_CALL_LEGACY_3(which, arg0, arg1, arg2) \
> +		SBI_CALL_LEGACY(which, arg0, arg1, arg2, 0)
> +#define SBI_CALL_LEGACY_4(which, arg0, arg1, arg2, arg3) \
> +		SBI_CALL_LEGACY(which, arg0, arg1, arg2, arg3)
>  
>  static inline void sbi_console_putchar(int ch)
>  {
> -	SBI_CALL_1(SBI_CONSOLE_PUTCHAR, ch);
> +	SBI_CALL_LEGACY_1(SBI_EXT_LEGACY_CONSOLE_PUTCHAR, ch);
>  }
>  
>  static inline int sbi_console_getchar(void)
>  {
> -	return SBI_CALL_0(SBI_CONSOLE_GETCHAR);
> +	return SBI_CALL_LEGACY_0(SBI_EXT_LEGACY_CONSOLE_GETCHAR);
>  }
>  
>  static inline void sbi_set_timer(uint64_t stime_value)
>  {
>  #if __riscv_xlen == 32
> -	SBI_CALL_2(SBI_SET_TIMER, stime_value, stime_value >> 32);
> +	SBI_CALL_LEGACY_2(SBI_EXT_LEGACY_SET_TIMER, stime_value,
> +			  stime_value >> 32);
>  #else
> -	SBI_CALL_1(SBI_SET_TIMER, stime_value);
> +	SBI_CALL_LEGACY_1(SBI_EXT_LEGACY_SET_TIMER, stime_value);
>  #endif
>  }
>  
>  static inline void sbi_shutdown(void)
>  {
> -	SBI_CALL_0(SBI_SHUTDOWN);
> +	SBI_CALL_LEGACY_0(SBI_EXT_LEGACY_SHUTDOWN);
>  }
>  
>  static inline void sbi_clear_ipi(void)
>  {
> -	SBI_CALL_0(SBI_CLEAR_IPI);
> +	SBI_CALL_LEGACY_0(SBI_EXT_LEGACY_CLEAR_IPI);
>  }
>  
>  static inline void sbi_send_ipi(const unsigned long *hart_mask)
>  {
> -	SBI_CALL_1(SBI_SEND_IPI, hart_mask);
> +	SBI_CALL_LEGACY_1(SBI_EXT_LEGACY_SEND_IPI, hart_mask);
>  }
>  
>  static inline void sbi_remote_fence_i(const unsigned long *hart_mask)
>  {
> -	SBI_CALL_1(SBI_REMOTE_FENCE_I, hart_mask);
> +	SBI_CALL_LEGACY_1(SBI_EXT_LEGACY_REMOTE_FENCE_I, hart_mask);
>  }
>  
>  static inline void sbi_remote_sfence_vma(const unsigned long *hart_mask,
>  					 unsigned long start,
>  					 unsigned long size)
>  {
> -	SBI_CALL_3(SBI_REMOTE_SFENCE_VMA, hart_mask, start, size);
> +	SBI_CALL_LEGACY_3(SBI_EXT_LEGACY_REMOTE_SFENCE_VMA, hart_mask,
> +			  start, size);
>  }
>  
>  static inline void sbi_remote_sfence_vma_asid(const unsigned long *hart_mask,
> @@ -91,7 +95,8 @@ static inline void sbi_remote_sfence_vma_asid(const unsigned long *hart_mask,
>  					      unsigned long size,
>  					      unsigned long asid)
>  {
> -	SBI_CALL_4(SBI_REMOTE_SFENCE_VMA_ASID, hart_mask, start, size, asid);
> +	SBI_CALL_LEGACY_4(SBI_EXT_LEGACY_REMOTE_SFENCE_VMA_ASID, hart_mask,
> +			  start, size, asid);
>  }
>  
>  #endif
> -- 
> 2.21.0
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

