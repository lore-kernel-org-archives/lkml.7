Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69681C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 01:02:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 415152082E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 01:02:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726515AbfDDBCp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 21:02:45 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:34530 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726099AbfDDBCp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 21:02:45 -0400
X-IronPort-AV: E=Sophos;i="5.60,306,1549900800"; 
   d="scan'208";a="58426839"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 04 Apr 2019 09:02:42 +0800
Received: from G08CNEXCHPEKD01.g08.fujitsu.local (unknown [10.167.33.80])
        by cn.fujitsu.com (Postfix) with ESMTP id 30B494CD7FE1;
        Thu,  4 Apr 2019 09:02:43 +0800 (CST)
Received: from localhost.localdomain (10.167.225.56) by
 G08CNEXCHPEKD01.g08.fujitsu.local (10.167.33.89) with Microsoft SMTP Server
 (TLS) id 14.3.439.0; Thu, 4 Apr 2019 09:02:48 +0800
Date:   Thu, 4 Apr 2019 09:02:38 +0800
From:   Chao Fan <fanc.fnst@cn.fujitsu.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     Dave Young <dyoung@redhat.com>, "bhe@redhat.com" <bhe@redhat.com>,
        Junichi Nomura <j-nomura@ce.jp.nec.com>,
        "kasong@redhat.com" <kasong@redhat.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] x86/boot: Use efi_setup_data for searching RSDP on
 kexec-ed kernel
Message-ID: <20190404010238.GK1555@localhost.localdomain>
References: <20190401000837.GA5170@jeru.linux.bs1.fc.nec.co.jp>
 <20190402120319.GA7605@dhcp-128-65.nay.redhat.com>
 <20190403053459.GD1555@localhost.localdomain>
 <20190403055340.GA11976@dhcp-128-65.nay.redhat.com>
 <20190403063911.GA2579@dhcp-128-65.nay.redhat.com>
 <20190403073023.GF1555@localhost.localdomain>
 <20190403075015.GQ7627@MiWiFi-R3L-srv>
 <20190403082313.GA14838@dhcp-128-65.nay.redhat.com>
 <20190403082634.GA14852@dhcp-128-65.nay.redhat.com>
 <20190403161429.GD6970@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20190403161429.GD6970@zn.tnic>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Originating-IP: [10.167.225.56]
X-yoursite-MailScanner-ID: 30B494CD7FE1.AD93B
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: fanc.fnst@cn.fujitsu.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 03, 2019 at 06:14:29PM +0200, Borislav Petkov wrote:
>On Wed, Apr 03, 2019 at 04:26:34PM +0800, Dave Young wrote:
>> Personally I would like to have a cmdline to bypass the early acpi code
>> because early code is hard to debug, if we have something weird happens
>> we can try to gate out these code, and then get some idea..
>
>No, this early crap better work on all machines by default.
>
>Also, Chao, are you telling me that you've only tested in a VM? Or

In VM, with all cases. In real machine, test boot and RSDP parsing,
not hotremove memory.

Thanks,
Chao Fan

>have you actually tested your code on an actual machine with memory
>hotremove?
>
>-- 
>Regards/Gruss,
>    Boris.
>
>Good mailing practices for 400: avoid top-posting and trim the reply.
>
>


