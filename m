Return-Path: <SRS0=MEBR=WM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44C75C3A59C
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 07:25:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2046220644
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 07:25:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726801AbfHPHZ5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Aug 2019 03:25:57 -0400
Received: from mga09.intel.com ([134.134.136.24]:24058 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726575AbfHPHZ4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 03:25:56 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Aug 2019 00:25:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,391,1559545200"; 
   d="scan'208";a="167978823"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga007.jf.intel.com with ESMTP; 16 Aug 2019 00:25:55 -0700
Received: from [10.226.38.74] (rtanwar-mobl.gar.corp.intel.com [10.226.38.74])
        by linux.intel.com (Postfix) with ESMTP id D29A3580522;
        Fri, 16 Aug 2019 00:25:52 -0700 (PDT)
Subject: Re: [PATCH 2/3] x86: cpu: Add new Intel Atom CPU type
To:     Borislav Petkov <bp@alien8.de>
Cc:     Tony Luck <tony.luck@intel.com>, tglx@linutronix.de,
        mingo@redhat.com, hpa@zytor.com, x86@kernel.org,
        andriy.shevchenko@intel.com, alan@linux.intel.com,
        ricardo.neri-calderon@linux.intel.com, rafael.j.wysocki@intel.com,
        linux-kernel@vger.kernel.org, qi-ming.wu@intel.com,
        cheol.yong.kim@intel.com, rahul.tanwar@intel.com
References: <cover.1565856842.git.rahul.tanwar@linux.intel.com>
 <16de4480ae1216d5949d4d36787811dae35d2eff.1565856842.git.rahul.tanwar@linux.intel.com>
 <20190815122222.GE15313@zn.tnic>
 <68ad47a7-ac6f-0a1b-0892-850bb95c002b@linux.intel.com>
 <20190816064318.GC18980@zn.tnic>
From:   "Tanwar, Rahul" <rahul.tanwar@linux.intel.com>
Message-ID: <d6452a93-16a7-451e-3abb-0bc65e89b0aa@linux.intel.com>
Date:   Fri, 16 Aug 2019 15:25:51 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190816064318.GC18980@zn.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 16/8/2019 2:43 PM, Borislav Petkov wrote:
> Now to another question: you see how I put my reply to the previous mail
> *below* the quoted text. Why is yours ontop? Why not put it after mine
> since you're replying to it, like it is usually done on the mailing
> lists and thus not confuse the reading order?
>
> All I'm trying to say is, please do not top-post.

So sorry for missing out on this point. Will always keep in mind from 
now on.


Regards,

Rahul

