Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00C6FC10F12
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 10:31:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDF172173C
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 10:31:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731781AbfDQKbz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 06:31:55 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:9763 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728575AbfDQKby (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 06:31:54 -0400
X-IronPort-AV: E=Sophos;i="5.60,361,1549900800"; 
   d="scan'208";a="59526860"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 17 Apr 2019 18:31:53 +0800
Received: from G08CNEXCHPEKD01.g08.fujitsu.local (unknown [10.167.33.80])
        by cn.fujitsu.com (Postfix) with ESMTP id CAE014CD8478;
        Wed, 17 Apr 2019 18:31:48 +0800 (CST)
Received: from localhost.localdomain (10.167.225.56) by
 G08CNEXCHPEKD01.g08.fujitsu.local (10.167.33.89) with Microsoft SMTP Server
 (TLS) id 14.3.439.0; Wed, 17 Apr 2019 18:31:54 +0800
Date:   Wed, 17 Apr 2019 18:31:40 +0800
From:   Chao Fan <fanc.fnst@cn.fujitsu.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     Dave Young <dyoung@redhat.com>,
        Junichi Nomura <j-nomura@ce.jp.nec.com>,
        Baoquan He <bhe@redhat.com>, Kairui Song <kasong@redhat.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4] x86/boot: Use efi_setup_data for searching RSDP on
 kexec-ed kernel
Message-ID: <20190417103140.GB388@localhost.localdomain>
References: <20190412084956.GC19808@zn.tnic>
 <20190412133528.GD19808@zn.tnic>
 <cc2c1dbe-4fb3-fb7d-0540-c04734fc15cb@ce.jp.nec.com>
 <20190415090717.GA29317@zn.tnic>
 <20190415102525.GB29317@zn.tnic>
 <23309b73-d135-a207-564b-6003cee39184@ce.jp.nec.com>
 <20190416094024.GE27892@zn.tnic>
 <34d02ae0-7182-2983-b601-acbdb4085f33@ce.jp.nec.com>
 <20190417070250.GD8411@dhcp-128-65.nay.redhat.com>
 <20190417085434.GC20492@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20190417085434.GC20492@zn.tnic>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Originating-IP: [10.167.225.56]
X-yoursite-MailScanner-ID: CAE014CD8478.AAB30
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: fanc.fnst@cn.fujitsu.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 17, 2019 at 10:54:34AM +0200, Borislav Petkov wrote:
>On Wed, Apr 17, 2019 at 03:02:50PM +0800, Dave Young wrote:
>> How about move it after console_init,
>
>Sounds ok to me. That's still before KASLR gets setup and should work
>for Chao's movable regions too.

Yes, when debugging, I also put it after console_init().

Thanks,
Chao Fan

>
>> and at the same time skip efi_get_rsdp_addr in case kexec?
>
>If kexec_get_rsdp_addr() gets a correct address, efi_get_rsdp_addr()
>will be skipped.
>
>-- 
>Regards/Gruss,
>    Boris.
>
>Good mailing practices for 400: avoid top-posting and trim the reply.
>
>


