Return-Path: <SRS0=7o0M=UP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 030B5C31E50
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Jun 2019 15:43:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB2CD2063F
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Jun 2019 15:43:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727254AbfFPPn5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Jun 2019 11:43:57 -0400
Received: from smtp2-4.goneo.de ([85.220.129.36]:52690 "EHLO smtp2-4.goneo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726038AbfFPPn5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jun 2019 11:43:57 -0400
Received: from localhost (localhost [127.0.0.1])
        by smtp2.goneo.de (Postfix) with ESMTP id DFA0123F32D;
        Sun, 16 Jun 2019 17:43:53 +0200 (CEST)
X-Virus-Scanned: by goneo
Received: from smtp2.goneo.de ([127.0.0.1])
        by localhost (smtp2.goneo.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 6saBBGMF-nQY; Sun, 16 Jun 2019 17:43:52 +0200 (CEST)
Received: from [192.168.1.127] (dyndsl-178-142-132-231.ewe-ip-backbone.de [178.142.132.231])
        by smtp2.goneo.de (Postfix) with ESMTPSA id 9E01923F051;
        Sun, 16 Jun 2019 17:43:50 +0200 (CEST)
Subject: Re: [PATCH 14/14] docs: sphinx/kernel_abi.py: fix UTF-8 support
To:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
References: <cover.1560477540.git.mchehab+samsung@kernel.org>
 <62c8ffe86df40c90299e80619a1cb5d50971c2c6.1560477540.git.mchehab+samsung@kernel.org>
 <20190614161837.GA25206@kroah.com> <20190614132530.7a013757@coco.lan>
From:   Markus Heiser <markus.heiser@darmarit.de>
Message-ID: <28aca947-4e88-7186-7f07-9a3ccb379649@darmarit.de>
Date:   Sun, 16 Jun 2019 17:43:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190614132530.7a013757@coco.lan>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: de-DE
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Am 14.06.19 um 18:25 schrieb Mauro Carvalho Chehab:
> Em Fri, 14 Jun 2019 18:18:37 +0200
> Greg Kroah-Hartman <gregkh@linuxfoundation.org> escreveu:
> 
>> On Thu, Jun 13, 2019 at 11:04:20PM -0300, Mauro Carvalho Chehab wrote:
>>> The parser breaks with UTF-8 characters with Sphinx 1.4.
>>>
>>> Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
>>> ---
>>>   Documentation/sphinx/kernel_abi.py | 10 ++++++----
>>>   1 file changed, 6 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/Documentation/sphinx/kernel_abi.py b/Documentation/sphinx/kernel_abi.py
>>> index 7fa7806532dc..460cee48a245 100644
>>> --- a/Documentation/sphinx/kernel_abi.py
>>> +++ b/Documentation/sphinx/kernel_abi.py
>>> @@ -1,4 +1,5 @@
>>> -# -*- coding: utf-8; mode: python -*-
>>> +# coding=utf-8
>>> +#
>>
>> Is this an emacs vs. vim fight?
> 
> No. This is a python-specific thing:
> 
> 	https://www.python.org/dev/peps/pep-0263/

No need to change, the emacs notation is also OK, see your link

   """or (using formats recognized by popular editors):"""

   https://www.python.org/dev/peps/pep-0263/#defining-the-encoding

I prefer emacs notation, this is also evaluated by many other editors / tools.

-- Markus --
