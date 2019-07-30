Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89A29C0650F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 20:10:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CC9120693
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 20:10:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727884AbfG3UKM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 16:10:12 -0400
Received: from mga05.intel.com ([192.55.52.43]:46947 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726174AbfG3UKM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 16:10:12 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Jul 2019 13:10:11 -0700
X-IronPort-AV: E=Sophos;i="5.64,327,1559545200"; 
   d="scan'208";a="162781595"
Received: from rchatre-mobl.amr.corp.intel.com (HELO [10.24.14.51]) ([10.24.14.51])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/AES256-SHA; 30 Jul 2019 13:10:11 -0700
Subject: Re: [PATCH V2 00/10] x86/CPU and x86/resctrl: Support pseudo-lock
 regions spanning L2 and L3 cache
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     fenghua.yu@intel.com, bp@alien8.de, tony.luck@intel.com,
        kuo-lang.tseng@intel.com, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, linux-kernel@vger.kernel.org
References: <cover.1564504901.git.reinette.chatre@intel.com>
 <alpine.DEB.2.21.1907302158450.1786@nanos.tec.linutronix.de>
From:   Reinette Chatre <reinette.chatre@intel.com>
Message-ID: <f4fbbf48-a301-9d87-02cb-eb6327257a6c@intel.com>
Date:   Tue, 30 Jul 2019 13:10:08 -0700
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1907302158450.1786@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

On 7/30/2019 1:00 PM, Thomas Gleixner wrote:
> On Tue, 30 Jul 2019, Reinette Chatre wrote:
>> Patches 2 to 8 to the resctrl subsystem are preparing for the new feature
>> and should result in no functional change, but some comments do refer to
>> the new feature. Support for pseudo-locked regions spanning L2 and L3 cache
>> is introduced in patches 9 and 10.
>>
>> Your feedback will be greatly appreciated.
> 
> I've already skimmed V1 and did not find something horrible, but I want to
> hand the deeper review off to Borislav who should return from his well
> earned vacation soon.

Thank you very much. I look forward to working with Borislav on his return.

Reinette
