Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C45E3C31E4B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 14:10:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9767621744
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 14:10:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728923AbfFNOKg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 10:10:36 -0400
Received: from smtp1.goneo.de ([85.220.129.30]:33886 "EHLO smtp1.goneo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727382AbfFNOKg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 10:10:36 -0400
Received: from localhost (localhost [127.0.0.1])
        by smtp1.goneo.de (Postfix) with ESMTP id 3119023F928;
        Fri, 14 Jun 2019 16:10:33 +0200 (CEST)
X-Virus-Scanned: by goneo
Received: from smtp1.goneo.de ([127.0.0.1])
        by localhost (smtp1.goneo.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id FT1qlhxzsnIq; Fri, 14 Jun 2019 16:10:32 +0200 (CEST)
Received: from [192.168.1.127] (dyndsl-031-150-103-038.ewe-ip-backbone.de [31.150.103.38])
        by smtp1.goneo.de (Postfix) with ESMTPSA id 103FD23FD2E;
        Fri, 14 Jun 2019 16:10:31 +0200 (CEST)
Subject: Re: [PATCH 12/14] doc-rst: add ABI documentation to the admin-guide
 book
To:     Jani Nikula <jani.nikula@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Mauro Carvalho Chehab <mchehab@s-opensource.com>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
References: <cover.1560477540.git.mchehab+samsung@kernel.org>
 <9da2a7f6ff57d9d53dcbb964eb310f7956522870.1560477540.git.mchehab+samsung@kernel.org>
 <87o930uvur.fsf@intel.com>
From:   Markus Heiser <markus.heiser@darmarit.de>
Message-ID: <2955920a-3d6a-8e41-e8fe-b7db3cefed8b@darmarit.de>
Date:   Fri, 14 Jun 2019 16:10:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <87o930uvur.fsf@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: de-DE
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Am 14.06.19 um 15:42 schrieb Jani Nikula:
> On Thu, 13 Jun 2019, Mauro Carvalho Chehab<mchehab+samsung@kernel.org>  wrote:
>> From: Mauro Carvalho Chehab<mchehab@s-opensource.com>
>>
>> As we don't want a generic Sphinx extension to execute commands,
>> change the one proposed to Markus to call the abi_book.pl
>> script.
>>
>> Use a script to parse the Documentation/ABI directory and output
>> it at the admin-guide.
> We had a legacy kernel-doc perl script so we used that instead of
> rewriting it in python. Just to keep it bug-for-bug compatible with the
> past. That was the only reason.
> 
> I see absolutely zero reason to add a new perl monstrosity with a python
> extension to call it. All of this could be better done in python,
> directly.
> 
> Please don't complicate the documentation build. I know you know we all
> worked hard to take apart the old DocBook Rube Goldberg machine to
> replace it with Sphinx. Please don't turn the Sphinx build to another
> complicated mess.
> 
> My strong preferences are, in this order:
> 
> 1) Convert the ABI documentation to reStructuredText
> 
> 2) Have the python extension read the ABI files directly, without an
>     extra pipeline.
> 

I agree with Jani. No matter how the decision ends, since I can't help here, I'd 
rather not show up in the copyright.

   -- Markus --
