Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EE0FC433FF
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 04:51:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6DAB20B1F
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 04:51:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="sSrc3V8c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727057AbfHEEux (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 00:50:53 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:35352 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725902AbfHEEux (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 00:50:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:References:Cc:To:From:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=sLXXeMSWHflCyWkcO7IM2bCTcPWIWOqVom1tca6l2Z8=; b=sSrc3V8ccBP5hTHVXC8IYyZO8
        LOkx3HeDFqEi0Q8TBSoA3A8RrpIa1X/arHuoxrz2/nsKNfwm+7l3HZ2yZ+w1DKZZtM2v8z7c5qe5D
        A7e51tSOjcVCweHrs8l2ddDtrF6CTx8YHB5oeATODVKOidE4IKAHtnTZe0WXiALwqKyrM8Uy5a1P4
        MRHWJ7GCx+MteL0AZn6m4oVb1GeZKLGMc2WqO6cmdaENnKGGSzhuPTye2hCWnx78DFVWvy5Gaqf5Z
        ZZjwxw3ytRVQwosB/+s+d+eUDyJA5PM5nkkDJd+xQksfeQkCDFqGyajrIaN7Nl2EBQTNDe6rsXxYv
        JgjUR+7bA==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=[192.168.1.17])
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1huUxP-0005kR-Kt; Mon, 05 Aug 2019 04:50:51 +0000
Subject: Re: drivers/infiniband/core/.tmp_gl_uverbs_main.o:undefined reference
 to `__user_bad'
From:   Randy Dunlap <rdunlap@infradead.org>
To:     kbuild test robot <lkp@intel.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     kbuild-all@01.org, linux-kernel@vger.kernel.org,
        Leon Romanovsky <leonro@mellanox.com>,
        Michal Simek <monstr@monstr.eu>
References: <201902281750.jbpT0s0R%fengguang.wu@intel.com>
 <646013c8-5fcd-e7ab-0a87-3e0620563dfb@infradead.org>
Message-ID: <f19db95e-be92-302c-2aef-19c4f3f5c8b0@infradead.org>
Date:   Sun, 4 Aug 2019 21:50:50 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <646013c8-5fcd-e7ab-0a87-3e0620563dfb@infradead.org>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/2/19 7:38 PM, Randy Dunlap wrote:
> On 2/28/19 1:03 AM, kbuild test robot wrote:
>> Hi Jason,
>>
>> FYI, the error/warning still remains.
>>
>> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
>> head:   7d762d69145a54d169f58e56d6dac57a5508debc
>> commit: 3a6532c9af1a7836da2d597f1aaca73cb16c3b97 RDMA/uverbs: Use uverbs_attr_bundle to pass udata for write
>> date:   3 months ago
>> config: microblaze-allyesconfig (attached as .config)
>> compiler: microblaze-linux-gcc (GCC) 8.2.0
>> reproduce:
>>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>>         chmod +x ~/bin/make.cross
>>         git checkout 3a6532c9af1a7836da2d597f1aaca73cb16c3b97
>>         # save the attached .config to linux build tree
>>         GCC_VERSION=8.2.0 make.cross ARCH=microblaze 
>>
>> All errors (new ones prefixed by >>):
>>
>>    `.exit.data' referenced in section `.exit.text' of drivers/tty/n_hdlc.o: defined in discarded section `.exit.data' of drivers/tty/n_hdlc.o
>>    `.exit.data' referenced in section `.exit.text' of drivers/tty/n_hdlc.o: defined in discarded section `.exit.data' of drivers/tty/n_hdlc.o
>>    drivers/infiniband/core/uverbs_main.o: In function `ib_uverbs_write':
>>>> drivers/infiniband/core/.tmp_gl_uverbs_main.o:(.text+0x13a4): undefined reference to `__user_bad'
>>    drivers/android/binder.o: In function `binder_thread_write':
>>    drivers/android/.tmp_gl_binder.o:(.text+0xda6c): undefined reference to `__user_bad'
>>    drivers/android/.tmp_gl_binder.o:(.text+0xda98): undefined reference to `__user_bad'
>>    drivers/android/.tmp_gl_binder.o:(.text+0xdf10): undefined reference to `__user_bad'
>>    drivers/android/.tmp_gl_binder.o:(.text+0xe498): undefined reference to `__user_bad'
>>    drivers/android/binder.o:drivers/android/.tmp_gl_binder.o:(.text+0xea78): more undefined references to `__user_bad' follow
>>
>> ---
>> 0-DAY kernel test infrastructure                Open Source Technology Center
>> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
> 
> Hi Michal,
> 
> Would you comment on this, please?

[crickets]

> Jason has said more than once that these build errors are because
> arch/microblaze does not support get_user() of size 8 (bytes),
> although it does support a put_user() of size 8.
> 
> 
> See a previous report & comment at
> https://lore.kernel.org/lkml/20190101200742.GA5757@mellanox.com/
> 
> 
> thanks.

I currently don't have a cross-build environment set up, so I haven't
built this yet, but a patch like this might fix this nagging issue.

(It's clearly not high priority since arch/microblaze/ mostly seems to be
not well-maintained.)

---
From: Randy Dunlap <rdunlap@infradead.org>

arch/microblaze/ is missing support for get_user() of size 8 bytes,
so add it by using __copy_from_user().

Fixes these build errors:
   drivers/infiniband/core/uverbs_main.o: In function `ib_uverbs_write':
   drivers/infiniband/core/.tmp_gl_uverbs_main.o:(.text+0x13a4): undefined reference to `__user_bad'
   drivers/android/binder.o: In function `binder_thread_write':
   drivers/android/.tmp_gl_binder.o:(.text+0xda6c): undefined reference to `__user_bad'
   drivers/android/.tmp_gl_binder.o:(.text+0xda98): undefined reference to `__user_bad'
   drivers/android/.tmp_gl_binder.o:(.text+0xdf10): undefined reference to `__user_bad'
   drivers/android/.tmp_gl_binder.o:(.text+0xe498): undefined reference to `__user_bad'
   drivers/android/binder.o:drivers/android/.tmp_gl_binder.o:(.text+0xea78): more undefined references to `__user_bad' follow

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
---
 arch/microblaze/include/asm/uaccess.h |    6 ++++++
 1 file changed, 6 insertions(+)

--- lnx-53-rc3.orig/arch/microblaze/include/asm/uaccess.h
+++ lnx-53-rc3/arch/microblaze/include/asm/uaccess.h
@@ -186,6 +186,9 @@ extern long __user_bad(void);
 			__get_user_asm("lw", __gu_addr, __gu_val,	\
 				       __gu_err);			\
 			break;						\
+		case 8:							\
+			__gu_err = __copy_from_user(&__gu_val, __gu_addr, 8);\
+			break;						\
 		default:						\
 			__gu_err = __user_bad();			\
 			break;						\
@@ -212,6 +215,9 @@ extern long __user_bad(void);
 	case 4:								\
 		__get_user_asm("lw", (ptr), __gu_val, __gu_err);	\
 		break;							\
+	case 8:								\
+		__gu_err = __copy_from_user(&__gu_val, ptr, 8);		\
+		break;							\
 	default:							\
 		/* __gu_val = 0; __gu_err = -EINVAL;*/ __gu_err = __user_bad();\
 	}								\

