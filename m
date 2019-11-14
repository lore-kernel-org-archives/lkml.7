Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D54CC432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 08:00:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 697212070E
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 08:00:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726428AbfKNIAp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 03:00:45 -0500
Received: from mga03.intel.com ([134.134.136.65]:54828 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725838AbfKNIAo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 03:00:44 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Nov 2019 00:00:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,302,1569308400"; 
   d="scan'208";a="288142205"
Received: from crojewsk-mobl1.ger.corp.intel.com (HELO [10.237.137.172]) ([10.237.137.172])
  by orsmga001.jf.intel.com with ESMTP; 14 Nov 2019 00:00:41 -0800
Subject: Re: [PATCH v2 1/2] seq_buf: Add printing formatted hex dumps
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Piotr Maziarz <piotrx.maziarz@linux.intel.com>,
        linux-kernel@vger.kernel.org, mingo@redhat.com,
        andriy.shevchenko@intel.com, gustaw.lewandowski@intel.com
References: <1573130738-29390-1-git-send-email-piotrx.maziarz@linux.intel.com>
 <20191113160237.6b8efe12@gandalf.local.home>
From:   Cezary Rojewski <cezary.rojewski@intel.com>
Message-ID: <8d937230-9890-aabc-b268-c3a2e1f799b0@intel.com>
Date:   Thu, 14 Nov 2019 09:00:40 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <20191113160237.6b8efe12@gandalf.local.home>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-11-13 22:02, Steven Rostedt wrote:
> On Thu,  7 Nov 2019 13:45:37 +0100
> Piotr Maziarz <piotrx.maziarz@linux.intel.com> wrote:
> 
>> Provided function is an analogue of print_hex_dump().
>>
>> Implementing this function in seq_buf allows using for multiple
>> purposes (e.g. for tracing) and therefore prevents from code duplication
>> in every layer that uses seq_buf.
>>
>> print_hex_dump() is an essential part of logging data to dmesg. Adding
>> similar capability for other purposes is beneficial to all users.
>>
>> Example usage:
>> seq_buf_hex_dump(seq, "", DUMP_PREFIX_OFFSET, 16, 4, buf,
>> 		 ARRAY_SIZE(buf), true);
>> Example output:
>> 00000000: 00000000 ffffff10 ffffff32 ffff3210  ........2....2..
>> 00000010: ffff3210 83d00437 c0700000 00000000  .2..7.....p.....
>> 00000020: 02010004 0000000f 0000000f 00004002  .............@..
>> 00000030: 00000fff 00000000                    ........
>>
>> Signed-off-by: Piotr Maziarz <piotrx.maziarz@linux.intel.com>
>> Signed-off-by: Cezary Rojewski <cezary.rojewski@intel.com>
> 
> I'm curious about the two signed off bys? Was Cezary a co-author?
> 

Hello Steven,

Code is done by Piotr. I merely took part in shaping this idea and doing 
initial reviews. Kudos to Andy for helping us out here.

As a dev lead and maintainer for Intel ASoC team, patches coming from my 
team are also being signed off me so any reviewer has a person to 
complain to in case of any issues for extended period of time.

Czarek
