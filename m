Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 307F8C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 16:51:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBD662087C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 16:51:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727371AbfCNQvq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 12:51:46 -0400
Received: from mga17.intel.com ([192.55.52.151]:20881 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727131AbfCNQvq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 12:51:46 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Mar 2019 09:51:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,478,1544515200"; 
   d="scan'208";a="282689880"
Received: from unknown (HELO [10.7.201.133]) ([10.7.201.133])
  by orsmga004.jf.intel.com with ESMTP; 14 Mar 2019 09:51:43 -0700
Subject: Re: Kernel bug with MPX?
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Richard Biener <rguenther@suse.de>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        the arch/x86 maintainers <x86@kernel.org>
References: <alpine.LSU.2.20.1903060944550.7898@zhemvz.fhfr.qr>
 <ba1d2d3c-e616-611d-3cff-acf6b8aaeb66@intel.com>
 <20190308071249.GJ30234@dhcp22.suse.cz>
 <20190308073949.GA5232@dhcp22.suse.cz>
From:   Dave Hansen <dave.hansen@intel.com>
Openpgp: preference=signencrypt
Autocrypt: addr=dave.hansen@intel.com; keydata=
 mQINBE6HMP0BEADIMA3XYkQfF3dwHlj58Yjsc4E5y5G67cfbt8dvaUq2fx1lR0K9h1bOI6fC
 oAiUXvGAOxPDsB/P6UEOISPpLl5IuYsSwAeZGkdQ5g6m1xq7AlDJQZddhr/1DC/nMVa/2BoY
 2UnKuZuSBu7lgOE193+7Uks3416N2hTkyKUSNkduyoZ9F5twiBhxPJwPtn/wnch6n5RsoXsb
 ygOEDxLEsSk/7eyFycjE+btUtAWZtx+HseyaGfqkZK0Z9bT1lsaHecmB203xShwCPT49Blxz
 VOab8668QpaEOdLGhtvrVYVK7x4skyT3nGWcgDCl5/Vp3TWA4K+IofwvXzX2ON/Mj7aQwf5W
 iC+3nWC7q0uxKwwsddJ0Nu+dpA/UORQWa1NiAftEoSpk5+nUUi0WE+5DRm0H+TXKBWMGNCFn
 c6+EKg5zQaa8KqymHcOrSXNPmzJuXvDQ8uj2J8XuzCZfK4uy1+YdIr0yyEMI7mdh4KX50LO1
 pmowEqDh7dLShTOif/7UtQYrzYq9cPnjU2ZW4qd5Qz2joSGTG9eCXLz5PRe5SqHxv6ljk8mb
 ApNuY7bOXO/A7T2j5RwXIlcmssqIjBcxsRRoIbpCwWWGjkYjzYCjgsNFL6rt4OL11OUF37wL
 QcTl7fbCGv53KfKPdYD5hcbguLKi/aCccJK18ZwNjFhqr4MliQARAQABtEVEYXZpZCBDaHJp
 c3RvcGhlciBIYW5zZW4gKEludGVsIFdvcmsgQWRkcmVzcykgPGRhdmUuaGFuc2VuQGludGVs
 LmNvbT6JAjgEEwECACIFAlQ+9J0CGwMGCwkIBwMCBhUIAgkKCwQWAgMBAh4BAheAAAoJEGg1
 lTBwyZKwLZUP/0dnbhDc229u2u6WtK1s1cSd9WsflGXGagkR6liJ4um3XCfYWDHvIdkHYC1t
 MNcVHFBwmQkawxsYvgO8kXT3SaFZe4ISfB4K4CL2qp4JO+nJdlFUbZI7cz/Td9z8nHjMcWYF
 IQuTsWOLs/LBMTs+ANumibtw6UkiGVD3dfHJAOPNApjVr+M0P/lVmTeP8w0uVcd2syiaU5jB
 aht9CYATn+ytFGWZnBEEQFnqcibIaOrmoBLu2b3fKJEd8Jp7NHDSIdrvrMjYynmc6sZKUqH2
 I1qOevaa8jUg7wlLJAWGfIqnu85kkqrVOkbNbk4TPub7VOqA6qG5GCNEIv6ZY7HLYd/vAkVY
 E8Plzq/NwLAuOWxvGrOl7OPuwVeR4hBDfcrNb990MFPpjGgACzAZyjdmYoMu8j3/MAEW4P0z
 F5+EYJAOZ+z212y1pchNNauehORXgjrNKsZwxwKpPY9qb84E3O9KYpwfATsqOoQ6tTgr+1BR
 CCwP712H+E9U5HJ0iibN/CDZFVPL1bRerHziuwuQuvE0qWg0+0SChFe9oq0KAwEkVs6ZDMB2
 P16MieEEQ6StQRlvy2YBv80L1TMl3T90Bo1UUn6ARXEpcbFE0/aORH/jEXcRteb+vuik5UGY
 5TsyLYdPur3TXm7XDBdmmyQVJjnJKYK9AQxj95KlXLVO38lcuQINBFRjzmoBEACyAxbvUEhd
 GDGNg0JhDdezyTdN8C9BFsdxyTLnSH31NRiyp1QtuxvcqGZjb2trDVuCbIzRrgMZLVgo3upr
 MIOx1CXEgmn23Zhh0EpdVHM8IKx9Z7V0r+rrpRWFE8/wQZngKYVi49PGoZj50ZEifEJ5qn/H
 Nsp2+Y+bTUjDdgWMATg9DiFMyv8fvoqgNsNyrrZTnSgoLzdxr89FGHZCoSoAK8gfgFHuO54B
 lI8QOfPDG9WDPJ66HCodjTlBEr/Cwq6GruxS5i2Y33YVqxvFvDa1tUtl+iJ2SWKS9kCai2DR
 3BwVONJEYSDQaven/EHMlY1q8Vln3lGPsS11vSUK3QcNJjmrgYxH5KsVsf6PNRj9mp8Z1kIG
 qjRx08+nnyStWC0gZH6NrYyS9rpqH3j+hA2WcI7De51L4Rv9pFwzp161mvtc6eC/GxaiUGuH
 BNAVP0PY0fqvIC68p3rLIAW3f97uv4ce2RSQ7LbsPsimOeCo/5vgS6YQsj83E+AipPr09Caj
 0hloj+hFoqiticNpmsxdWKoOsV0PftcQvBCCYuhKbZV9s5hjt9qn8CE86A5g5KqDf83Fxqm/
 vXKgHNFHE5zgXGZnrmaf6resQzbvJHO0Fb0CcIohzrpPaL3YepcLDoCCgElGMGQjdCcSQ+Ci
 FCRl0Bvyj1YZUql+ZkptgGjikQARAQABiQIfBBgBAgAJBQJUY85qAhsMAAoJEGg1lTBwyZKw
 l4IQAIKHs/9po4spZDFyfDjunimEhVHqlUt7ggR1Hsl/tkvTSze8pI1P6dGp2XW6AnH1iayn
 yRcoyT0ZJ+Zmm4xAH1zqKjWplzqdb/dO28qk0bPso8+1oPO8oDhLm1+tY+cOvufXkBTm+whm
 +AyNTjaCRt6aSMnA/QHVGSJ8grrTJCoACVNhnXg/R0g90g8iV8Q+IBZyDkG0tBThaDdw1B2l
 asInUTeb9EiVfL/Zjdg5VWiF9LL7iS+9hTeVdR09vThQ/DhVbCNxVk+DtyBHsjOKifrVsYep
 WpRGBIAu3bK8eXtyvrw1igWTNs2wazJ71+0z2jMzbclKAyRHKU9JdN6Hkkgr2nPb561yjcB8
 sIq1pFXKyO+nKy6SZYxOvHxCcjk2fkw6UmPU6/j/nQlj2lfOAgNVKuDLothIxzi8pndB8Jju
 KktE5HJqUUMXePkAYIxEQ0mMc8Po7tuXdejgPMwgP7x65xtfEqI0RuzbUioFltsp1jUaRwQZ
 MTsCeQDdjpgHsj+P2ZDeEKCbma4m6Ez/YWs4+zDm1X8uZDkZcfQlD9NldbKDJEXLIjYWo1PH
 hYepSffIWPyvBMBTW2W5FRjJ4vLRrJSUoEfJuPQ3vW9Y73foyo/qFoURHO48AinGPZ7PC7TF
 vUaNOTjKedrqHkaOcqB185ahG2had0xnFsDPlx5y
Message-ID: <ec2110b1-abae-4df5-fcd7-244620634a00@intel.com>
Date:   Thu, 14 Mar 2019 09:51:42 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190308073949.GA5232@dhcp22.suse.cz>
Content-Type: multipart/mixed;
 boundary="------------4B1430DFFB257B969B0701CD"
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------4B1430DFFB257B969B0701CD
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

For those just joining the thread now, here's the background:

> https://lkml.kernel.org/r/alpine.LSU.2.20.1903060944550.7898@zhemvz.fhfr.qr

Turning on a bunch of kernel debugging found the culprit:

>         /*
>          * mpx unmap needs to be called with mmap_sem held for write.
>          * It is safe to call it before unmap_region().
>          */
>         arch_unmap(mm, vma, start, end);
> 
>         if (downgrade)
>                 downgrade_write(&mm->mmap_sem);
> 
>         unmap_region(mm, vma, prev, start, end);

arch_unmap() can, in some cases, free 'prev'.  unmap_region() uses
'prev' to calculate the page table ranges that it frees.  It's probably
working on incorrect or garbage ranges at times.

I have some patches to really fix this by pre-calculating the
page-table-free ranges before arch_unmap().  They're not *too* bad, but
they do involve mucking with mm/mmap.c a bit to pass some new parameters
around.

The other option would be to just use this opportunity to start removing
MPX and apply the attached patch so this is no longer able to be triggered.

I'm inclined to opt for the patch to addle MPX rather than trying to fix
it for real.

--------------4B1430DFFB257B969B0701CD
Content-Type: text/x-patch;
 name="mpx-remove-apis.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="mpx-remove-apis.patch"


From: Dave Hansen <dave.hansen@linux.intel.com>

MPX is being removed from the kernel due to a lack of support
in the toolchain going forward (gcc).

The first thing we need to do is remove the userspace-visible
ABIs so that applications will stop using it.  The most visible
one are the enable/disable prctl()s.  Remove them first.

This is the most minimal and least invasive patch needed to
start removing MPX.

Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
---

 b/include/uapi/linux/prctl.h |    2 +-
 b/kernel/sys.c               |   16 ++--------------
 2 files changed, 3 insertions(+), 15 deletions(-)

diff -puN include/uapi/linux/prctl.h~mpx-remove-apis include/uapi/linux/p=
rctl.h
--- a/include/uapi/linux/prctl.h~mpx-remove-apis	2019-01-04 14:40:06.8535=
14089 -0800
+++ b/include/uapi/linux/prctl.h	2019-01-04 14:40:06.860514089 -0800
@@ -181,7 +181,7 @@ struct prctl_mm_map {
 #define PR_GET_THP_DISABLE	42
=20
 /*
- * Tell the kernel to start/stop helping userspace manage bounds tables.=

+ * No longer implemented, but left here to ensure the numbers stay reser=
ved:
  */
 #define PR_MPX_ENABLE_MANAGEMENT  43
 #define PR_MPX_DISABLE_MANAGEMENT 44
diff -puN kernel/sys.c~mpx-remove-apis kernel/sys.c
--- a/kernel/sys.c~mpx-remove-apis	2019-01-04 14:40:06.857514089 -0800
+++ b/kernel/sys.c	2019-01-04 14:40:06.860514089 -0800
@@ -103,12 +103,6 @@
 #ifndef SET_TSC_CTL
 # define SET_TSC_CTL(a)		(-EINVAL)
 #endif
-#ifndef MPX_ENABLE_MANAGEMENT
-# define MPX_ENABLE_MANAGEMENT()	(-EINVAL)
-#endif
-#ifndef MPX_DISABLE_MANAGEMENT
-# define MPX_DISABLE_MANAGEMENT()	(-EINVAL)
-#endif
 #ifndef GET_FP_MODE
 # define GET_FP_MODE(a)		(-EINVAL)
 #endif
@@ -2448,15 +2442,9 @@ SYSCALL_DEFINE5(prctl, int, option, unsi
 		up_write(&me->mm->mmap_sem);
 		break;
 	case PR_MPX_ENABLE_MANAGEMENT:
-		if (arg2 || arg3 || arg4 || arg5)
-			return -EINVAL;
-		error =3D MPX_ENABLE_MANAGEMENT();
-		break;
 	case PR_MPX_DISABLE_MANAGEMENT:
-		if (arg2 || arg3 || arg4 || arg5)
-			return -EINVAL;
-		error =3D MPX_DISABLE_MANAGEMENT();
-		break;
+		/* No longer implemented: */
+		return -EINVAL;
 	case PR_SET_FP_MODE:
 		error =3D SET_FP_MODE(me, arg2);
 		break;
_

--------------4B1430DFFB257B969B0701CD--
