Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15AE4C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 13:19:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D64A62082E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 13:19:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729769AbfDDNTJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 09:19:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41212 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727053AbfDDNTJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 09:19:09 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A837472657;
        Thu,  4 Apr 2019 13:19:03 +0000 (UTC)
Received: from [10.18.17.208] (dhcp-17-208.bos.redhat.com [10.18.17.208])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id DFAED19C68;
        Thu,  4 Apr 2019 13:19:00 +0000 (UTC)
Subject: Re: [PATCH v2 0/8] klp-convert
To:     Miroslav Benes <mbenes@suse.cz>
Cc:     Joao Moreira <jmoreira@suse.de>, live-patching@vger.kernel.org,
        pmladek@suse.cz, jikos@suse.cz, nstange@suse.de,
        jpoimboe@redhat.com, khlebnikov@yandex-team.ru, jeyu@kernel.org,
        matz@suse.de, linux-kernel@vger.kernel.org,
        yamada.masahiro@socionext.com, linux-kbuild@vger.kernel.org,
        michal.lkml@markovi.net
References: <20190301141313.15057-1-jmoreira@suse.de>
 <20190318191843.GA22702@redhat.com>
 <3423e586-5ae7-1dd2-8e5f-3930f168143b@suse.de>
 <0580fe97-7882-68c1-54f2-5778f47c5564@redhat.com>
 <alpine.LSU.2.21.1904041346350.32428@pobox.suse.cz>
From:   Joe Lawrence <joe.lawrence@redhat.com>
Message-ID: <f52d29f7-7d1b-ad3d-050b-a9fa8878faf2@redhat.com>
Date:   Thu, 4 Apr 2019 09:19:00 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <alpine.LSU.2.21.1904041346350.32428@pobox.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Thu, 04 Apr 2019 13:19:09 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/4/19 7:49 AM, Miroslav Benes wrote:
>   
>> BTW, something I *just* noticed when putting together that toy out-of-tree
>> module to test out multi-object livepatch modules is that we aren't
>> considering out-of-tree symbols in Symbols.list.
>>
>> Perhaps we can save that for v4 or beyond, but maybe we want to re-arrange the
>> klp-convert arguments to "klp-convert <input.ko> <out.ko> <Symbols.list>
>> [Symbols.list ...]" where we treat everything after <out.ko> as a symbol list
>> file?  (This would assume we would generate a separate out-of-tree module
>> Symbols.list file.)    /thinking-out-loud
> 
> I understand it could help the testing quite a bit right now, but do we
> care about out-of-tree modules in general?
> 

Yeah, this was only something I hit because I found it easier to 
construct OOT modules to test and share with Joao.

I mentioned it because kpatch-build supports OOT and apparently some 
folks are using it:

   https://github.com/dynup/kpatch/pull/923

But like I said, we can push that off for another day for now.

-- Joe
