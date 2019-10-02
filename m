Return-Path: <SRS0=zem1=X3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B6F0C4360C
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 23:42:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3780222BE
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 23:42:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728407AbfJBXmz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 19:42:55 -0400
Received: from mga05.intel.com ([192.55.52.43]:14831 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726811AbfJBXmz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 19:42:55 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Oct 2019 16:42:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,250,1566889200"; 
   d="scan'208";a="221580529"
Received: from cvannort-mobl2.amr.corp.intel.com (HELO [10.251.30.5]) ([10.251.30.5])
  by fmsmga002.fm.intel.com with ESMTP; 02 Oct 2019 16:42:53 -0700
Subject: Re: [PATCH 0/2] peci: aspeed: Add AST2600 compatible
To:     Joel Stanley <joel@jms.id.au>
Cc:     "Chia-Wei, Wang" <chiawei_wang@aspeedtech.com>,
        Jason M Biils <jason.m.bills@linux.intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Jeffery <andrew@aj.id.au>,
        linux-aspeed <linux-aspeed@lists.ozlabs.org>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ryan Chen <ryan_chen@aspeedtech.com>
References: <20191002061200.29888-1-chiawei_wang@aspeedtech.com>
 <70044749-785b-6ff3-7a28-fb049dcfec54@linux.intel.com>
 <CACPK8XfBxC+4PHHCkMoXr+twjfWaovcJ5c=hfCmHRJ6LpGNeFg@mail.gmail.com>
From:   Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
Message-ID: <03d21443-aa9a-a126-dc77-a21f14f708c9@linux.intel.com>
Date:   Wed, 2 Oct 2019 16:42:53 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CACPK8XfBxC+4PHHCkMoXr+twjfWaovcJ5c=hfCmHRJ6LpGNeFg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/2/2019 3:05 PM, Joel Stanley wrote:
> On Wed, 2 Oct 2019 at 18:11, Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com> wrote:
>>
>> Hi Chia-Wei,
>>
>> On 10/1/2019 11:11 PM, Chia-Wei, Wang wrote:
>>> Update the Aspeed PECI driver with the AST2600 compatible string.
>>> A new comptabile string is needed for the extended HW feature of
>>> AST2600.
>>>
>>> Chia-Wei, Wang (2):
>>>     peci: aspeed: Add AST2600 compatible string
>>>     dt-bindings: peci: aspeed: Add AST2600 compatible
>>>
>>>    Documentation/devicetree/bindings/peci/peci-aspeed.txt | 1 +
>>>    drivers/peci/peci-aspeed.c                             | 1 +
>>>    2 files changed, 2 insertions(+)
>>>
>>
>> PECI subsystem isn't in linux upstream yet so you should submit it into
>> OpenBMC dev-5.3 tree only.
> 
> OpenBMC has been carrying the out of tree patches for some time now. I
> haven't seen a new version posted for a while. Do you have a timeline
> for when you plan to submit it upstream?

Thanks for your effort for carrying the out of tree patches in OpenBMC.
I don't have a exact timeline but I'm gonna upstream it as soon as it
gets ready.

Thanks,

Jae
