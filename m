Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82894C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 01:27:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A0DE20830
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 01:27:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726181AbfCDB1T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Mar 2019 20:27:19 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:65208 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726012AbfCDB1T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Mar 2019 20:27:19 -0500
X-IronPort-AV: E=Sophos;i="5.58,438,1544457600"; 
   d="scan'208";a="55827178"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 04 Mar 2019 09:27:18 +0800
Received: from G08CNEXCHPEKD01.g08.fujitsu.local (unknown [10.167.33.80])
        by cn.fujitsu.com (Postfix) with ESMTP id 1CE2846BA6D1;
        Mon,  4 Mar 2019 09:27:05 +0800 (CST)
Received: from localhost.localdomain (10.167.225.56) by
 G08CNEXCHPEKD01.g08.fujitsu.local (10.167.33.89) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Mon, 4 Mar 2019 09:27:25 +0800
Date:   Mon, 4 Mar 2019 09:27:10 +0800
From:   Chao Fan <fanc.fnst@cn.fujitsu.com>
To:     Baoquan He <bhe@redhat.com>
CC:     <bp@alien8.de>, <linux-kernel@vger.kernel.org>
Subject: Re: A quesiton about commit 3a63f70bf4c3
Message-ID: <20190304012710.GB28322@localhost.localdomain>
References: <20190301060631.GU14858@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20190301060631.GU14858@MiWiFi-R3L-srv>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Originating-IP: [10.167.225.56]
X-yoursite-MailScanner-ID: 1CE2846BA6D1.AA04C
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: fanc.fnst@cn.fujitsu.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 01, 2019 at 02:06:31PM +0800, Baoquan He wrote:
>
>Hi Chao,
Hi Baoquan,

Sorry for late reply, I was away from keyboard last Friday.
Your change looks good, I think you can format it as a real PATCH.
>
>I am back porting this commit to our distrols from tip.

Thanks for your effort.

Thanks,
Chao Fan

>3a63f70bf4c3 x86/boot: Early parse RSDP and save it in boot_params
>
>Findind out those SRAT handling related declarations are out of
>BOOT_COMPRESSED_MISC_H ifdeffery. Is this made on purpose? 
>
>Saw "misc.h" is included in several places, shouldn't be changed like
>below? Please correct me if I was wrong.


>
>Thanks
>Baoquan
>
>diff --git a/arch/x86/boot/compressed/misc.h b/arch/x86/boot/compressed/misc.h
>index fd13655..252091b 100644
>--- a/arch/x86/boot/compressed/misc.h
>+++ b/arch/x86/boot/compressed/misc.h
>@@ -120,8 +120,6 @@ static inline void console_init(void)
> 
> void set_sev_encryption_mask(void);
> 
>-#endif
>-
> /* acpi.c */
> #ifdef CONFIG_ACPI
> acpi_physical_address get_rsdp_addr(void);
>@@ -135,3 +133,4 @@ int count_immovable_mem_regions(void);
> #else
> static inline int count_immovable_mem_regions(void) { return 0; }
> #endif
>+#endif
>
>


