Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1402CC4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 11:33:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB14E2082C
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 11:33:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726315AbfDCLd1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 07:33:27 -0400
Received: from mga03.intel.com ([134.134.136.65]:47506 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725935AbfDCLd1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 07:33:27 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Apr 2019 04:33:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,304,1549958400"; 
   d="scan'208";a="146236271"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by FMSMGA003.fm.intel.com with ESMTP; 03 Apr 2019 04:33:19 -0700
Received: from andy by smile with local (Exim 4.92)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1hBe8p-0001jQ-Nk; Wed, 03 Apr 2019 14:33:15 +0300
Date:   Wed, 3 Apr 2019 14:33:15 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andrey Abramov <st5pub@yandex.ru>
Cc:     vgupta <vgupta@synopsys.com>, benh <benh@kernel.crashing.org>,
        paulus <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
        tglx <tglx@linutronix.de>, mingo <mingo@redhat.com>,
        bp <bp@alien8.de>, hpa <hpa@zytor.com>, x86 <x86@kernel.org>,
        mark <mark@fasheh.com>, jlbec <jlbec@evilplan.org>,
        richard <richard@nod.at>, dedekind1 <dedekind1@gmail.com>,
        "adrian.hunter" <adrian.hunter@intel.com>,
        gregkh <gregkh@linuxfoundation.org>,
        "naveen.n.rao" <naveen.n.rao@linux.vnet.ibm.com>,
        jpoimboe <jpoimboe@redhat.com>,
        Dave Chinner <dchinner@redhat.com>,
        "darrick.wong" <darrick.wong@oracle.com>,
        "ard.biesheuvel" <ard.biesheuvel@linaro.org>,
        George Spelvin <lkml@sdf.org>,
        linux-snps-arc <linux-snps-arc@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        ocfs2-devel <ocfs2-devel@oss.oracle.com>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        sfr <sfr@canb.auug.org.au>, jannh <jannh@google.com>,
        jslaby <jslaby@suse.cz>, peterz <peterz@infradead.org>,
        "yamada.masahiro" <yamada.masahiro@socionext.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Morton Andrew <akpm@linux-foundation.org>
Subject: Re: [PATCH v3 5/5] Lib: sort.h: remove the size argument from the
 swap function
Message-ID: <20190403113315.GW9224@smile.fi.intel.com>
References: <824481554237711@sas1-23a37bc8251c.qloud-c.yandex.net>
 <793311554238525@sas1-87f9feb8d943.qloud-c.yandex.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <793311554238525@sas1-87f9feb8d943.qloud-c.yandex.net>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 02, 2019 at 11:55:25PM +0300, Andrey Abramov wrote:
> Removes size argument from the swap function because:
> 	1) It wasn't used.
> 	2) Custom swap function knows what kind of objects it swaps,
> 		so it already knows their sizes.
> 
> Signed-off-by: Andrey Abramov <st5pub@yandex.ru>
> Reviewed by: George Spelvin <lkml@sdf.org>

FWIW,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> ---
>  arch/x86/kernel/unwind_orc.c | 2 +-
>  include/linux/sort.h         | 2 +-
>  kernel/jump_label.c          | 2 +-
>  lib/extable.c                | 2 +-
>  lib/sort.c                   | 7 +++----
>  5 files changed, 7 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/x86/kernel/unwind_orc.c b/arch/x86/kernel/unwind_orc.c
> index 89be1be1790c..dc410b567189 100644
> --- a/arch/x86/kernel/unwind_orc.c
> +++ b/arch/x86/kernel/unwind_orc.c
> @@ -176,7 +176,7 @@ static struct orc_entry *orc_find(unsigned long ip)
>  	return orc_ftrace_find(ip);
>  }
>  
> -static void orc_sort_swap(void *_a, void *_b, int size)
> +static void orc_sort_swap(void *_a, void *_b)
>  {
>  	struct orc_entry *orc_a, *orc_b;
>  	struct orc_entry orc_tmp;
> diff --git a/include/linux/sort.h b/include/linux/sort.h
> index 2b99a5dd073d..13bb4635b5f1 100644
> --- a/include/linux/sort.h
> +++ b/include/linux/sort.h
> @@ -6,6 +6,6 @@
>  
>  void sort(void *base, size_t num, size_t size,
>  	  int (*cmp)(const void *, const void *),
> -	  void (*swap)(void *, void *, int));
> +	  void (*swap)(void *, void *));
>  
>  #endif
> diff --git a/kernel/jump_label.c b/kernel/jump_label.c
> index bad96b476eb6..6b1187b8a060 100644
> --- a/kernel/jump_label.c
> +++ b/kernel/jump_label.c
> @@ -45,7 +45,7 @@ static int jump_label_cmp(const void *a, const void *b)
>  	return 0;
>  }
>  
> -static void jump_label_swap(void *a, void *b, int size)
> +static void jump_label_swap(void *a, void *b)
>  {
>  	long delta = (unsigned long)a - (unsigned long)b;
>  	struct jump_entry *jea = a;
> diff --git a/lib/extable.c b/lib/extable.c
> index f54996fdd0b8..0515a94538ca 100644
> --- a/lib/extable.c
> +++ b/lib/extable.c
> @@ -28,7 +28,7 @@ static inline unsigned long ex_to_insn(const struct exception_table_entry *x)
>  #ifndef ARCH_HAS_RELATIVE_EXTABLE
>  #define swap_ex		NULL
>  #else
> -static void swap_ex(void *a, void *b, int size)
> +static void swap_ex(void *a, void *b)
>  {
>  	struct exception_table_entry *x = a, *y = b, tmp;
>  	int delta = b - a;
> diff --git a/lib/sort.c b/lib/sort.c
> index 50855ea8c262..8704750e6bde 100644
> --- a/lib/sort.c
> +++ b/lib/sort.c
> @@ -114,7 +114,7 @@ static void swap_bytes(void *a, void *b, size_t n)
>  	} while (n);
>  }
>  
> -typedef void (*swap_func_t)(void *a, void *b, int size);
> +typedef void (*swap_func_t)(void *a, void *b);
>  
>  /*
>   * The values are arbitrary as long as they can't be confused with
> @@ -138,7 +138,7 @@ static void do_swap(void *a, void *b, size_t size, swap_func_t swap_func)
>  	else if (swap_func == SWAP_BYTES)
>  		swap_bytes(a, b, size);
>  	else
> -		swap_func(a, b, (int)size);
> +		swap_func(a, b);
>  }
>  
>  /**
> @@ -186,8 +186,7 @@ static size_t parent(size_t i, unsigned int lsbit, size_t size)
>   * it less suitable for kernel use.
>   */
>  void sort(void *base, size_t num, size_t size,
> -	  int (*cmp_func)(const void *, const void *),
> -	  void (*swap_func)(void *, void *, int size))
> +	  int (*cmp_func)(const void *, const void *), swap_func_t swap_func)
>  {
>  	/* pre-scale counters for performance */
>  	size_t n = num * size, a = (num/2) * size;
> -- 
> 2.21.0
> 
> 

-- 
With Best Regards,
Andy Shevchenko


