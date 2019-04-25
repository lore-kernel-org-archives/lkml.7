Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1821CC10F03
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 10:42:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD398206BA
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 10:42:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730479AbfDYKmI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 06:42:08 -0400
Received: from mga03.intel.com ([134.134.136.65]:56407 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726040AbfDYKmI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 06:42:08 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Apr 2019 03:42:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,393,1549958400"; 
   d="scan'208";a="138712931"
Received: from cli6-desk1.ccr.corp.intel.com (HELO [10.239.161.118]) ([10.239.161.118])
  by orsmga006.jf.intel.com with ESMTP; 25 Apr 2019 03:42:05 -0700
Subject: Re: [PATCH v17 1/3] proc: add /proc/<pid>/arch_status
To:     "Enrico Weigelt, metux IT consult" <lkml@metux.net>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     mingo@redhat.com, peterz@infradead.org, hpa@zytor.com,
        ak@linux.intel.com, tim.c.chen@linux.intel.com,
        dave.hansen@intel.com, arjan@linux.intel.com, adobriyan@gmail.com,
        akpm@linux-foundation.org, aubrey.li@intel.com,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Lutomirski <luto@kernel.org>
References: <20190421183529.9141-1-aubrey.li@linux.intel.com>
 <alpine.DEB.2.21.1904242310040.1762@nanos.tec.linutronix.de>
 <da1fcb4f-e856-d31f-7c72-76c969af3935@linux.intel.com>
 <6a9e6bd9-8e1a-9fe5-135d-c7a49697b5a4@metux.net>
From:   "Li, Aubrey" <aubrey.li@linux.intel.com>
Message-ID: <4456cc68-5120-e820-90ed-cb5b5dfcd760@linux.intel.com>
Date:   Thu, 25 Apr 2019 18:42:04 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.1
MIME-Version: 1.0
In-Reply-To: <6a9e6bd9-8e1a-9fe5-135d-c7a49697b5a4@metux.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/4/25 18:11, Enrico Weigelt, metux IT consult wrote:
> On 25.04.19 03:50, Li, Aubrey wrote:
> 
>>>> +>>> +config PROC_PID_ARCH_STATUS>>> +	bool "Enable
> /proc/<pid>/arch_status file">>>> Why is this switchable? x86 selects it
> if PROC_FS is enabled and all other>> architectures are absolutely not
> interested in this.> > Above and this, I was trying to avoid an empty
> arch_file on other architectures.> In previous proposal the entry only
> exists on the platform with AVX512.
> Why not making it depend on those archs that actually support it ?

Yep, I'll make it disabled by default and not switchable and let arch select it.
