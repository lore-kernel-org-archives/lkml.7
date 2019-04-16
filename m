Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BE95C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 14:13:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2655223DA
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 14:13:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729422AbfDPONQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 10:13:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48574 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725861AbfDPONQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 10:13:16 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9C1523087946;
        Tue, 16 Apr 2019 14:13:15 +0000 (UTC)
Received: from [10.18.17.208] (dhcp-17-208.bos.redhat.com [10.18.17.208])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C81661001E92;
        Tue, 16 Apr 2019 14:13:13 +0000 (UTC)
Subject: Re: [PATCH v3 2/9] kbuild: Support for Symbols.list creation
To:     Miroslav Benes <mbenes@suse.cz>
Cc:     linux-kernel@vger.kernel.org, live-patching@vger.kernel.org,
        linux-kbuild@vger.kernel.org, Jessica Yu <jeyu@kernel.org>,
        Jiri Kosina <jikos@kernel.org>,
        Joao Moreira <jmoreira@suse.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michael Matz <matz@suse.de>, Nicolai Stange <nstange@suse.de>,
        Petr Mladek <pmladek@suse.com>
References: <20190410155058.9437-1-joe.lawrence@redhat.com>
 <20190410155058.9437-3-joe.lawrence@redhat.com>
 <alpine.LSU.2.21.1904112100400.18787@pobox.suse.cz>
From:   Joe Lawrence <joe.lawrence@redhat.com>
Message-ID: <b2b5b57e-ae55-8e7b-f4f4-fa4f15194d77@redhat.com>
Date:   Tue, 16 Apr 2019 10:13:13 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <alpine.LSU.2.21.1904112100400.18787@pobox.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Tue, 16 Apr 2019 14:13:15 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/11/19 3:04 PM, Miroslav Benes wrote:
> 
>> diff --git a/samples/livepatch/Makefile b/samples/livepatch/Makefile
>> index 2472ce39a18d..8b9b42a258ad 100644
>> --- a/samples/livepatch/Makefile
>> +++ b/samples/livepatch/Makefile
>> @@ -1,3 +1,4 @@
>> +LIVEPATCH_livepatch-sample := y
>>   obj-$(CONFIG_SAMPLE_LIVEPATCH) += livepatch-sample.o
>>   obj-$(CONFIG_SAMPLE_LIVEPATCH) += livepatch-shadow-mod.o
>>   obj-$(CONFIG_SAMPLE_LIVEPATCH) += livepatch-shadow-fix1.o
> 
> We discussed this and I think there has been no conclusion yet. Shouldn't
> we do the same (add LIVEPATCH_) for the other samples here as well?

In v2 review, I mentioned moving this hunk to ("modpost: Add modinfo 
flag to livepatch modules") along with the same change to the other 
sample modules.  I didn't apply that for v3, but can do so for the next 
spin if it makes the commits easier to review.

-- Joe
