Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C676CC10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 21:11:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 939272073F
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 21:11:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729092AbfDPVLN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 17:11:13 -0400
Received: from mga09.intel.com ([134.134.136.24]:54295 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727136AbfDPVLM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 17:11:12 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Apr 2019 14:11:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,359,1549958400"; 
   d="scan'208";a="151442439"
Received: from xshen14-mobl.ccr.corp.intel.com (HELO [10.254.213.238]) ([10.254.213.238])
  by orsmga002.jf.intel.com with ESMTP; 16 Apr 2019 14:11:09 -0700
Subject: Re: [PATCH 2/2] x86/resctrl: Initialize new resource group with
 default MBA values
To:     Borislav Petkov <bp@alien8.de>
Cc:     tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        tony.luck@intel.com, fenghua.yu@intel.com,
        reinette.chatre@intel.com, x86@kernel.org,
        linux-kernel@vger.kernel.org, pei.p.jia@intel.com,
        xiaochen.shen@intel.com
References: <1554839728-5544-1-git-send-email-xiaochen.shen@intel.com>
 <20190415113405.GC29317@zn.tnic>
 <9e99ed5f-d60a-717c-9322-c6f0b8090d6b@intel.com>
 <20190416205926.GO31772@zn.tnic>
From:   Xiaochen Shen <xiaochen.shen@intel.com>
Message-ID: <2817a0d5-fcaf-dc6c-8b01-4a423bd2e961@intel.com>
Date:   Wed, 17 Apr 2019 05:11:09 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20190416205926.GO31772@zn.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Boris,

On 4/17/2019 4:59, Borislav Petkov wrote:
> I guess but be conservative when adding too many words to a function's
> name - that might get heavy when reading the code later.
> 
> For example, there's an argument to not suffix it with "_cat": it is
> only called by rdtgroup_init_cat() - rdtgroup_init_mba() will not call
> it - so the path will remain unique anyway...
> 

I got it. I will use the function name "__init_one_rdt_domain()" you 
suggested.

Thank you.

> Anyway, something to think about - I personally don't have a strong
> preference here.


Best regards,
Xiaochen
