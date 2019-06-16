Return-Path: <SRS0=7o0M=UP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DB0FC31E50
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Jun 2019 16:04:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58C4C20870
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Jun 2019 16:04:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726713AbfFPQEG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Jun 2019 12:04:06 -0400
Received: from smtp2-4.goneo.de ([85.220.129.36]:58286 "EHLO smtp2-4.goneo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725894AbfFPQEG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jun 2019 12:04:06 -0400
Received: from localhost (localhost [127.0.0.1])
        by smtp2.goneo.de (Postfix) with ESMTP id 7987623F5E1;
        Sun, 16 Jun 2019 18:04:03 +0200 (CEST)
X-Virus-Scanned: by goneo
Received: from smtp2.goneo.de ([127.0.0.1])
        by localhost (smtp2.goneo.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id SHiCPLpy8X2s; Sun, 16 Jun 2019 18:04:02 +0200 (CEST)
Received: from [192.168.1.127] (dyndsl-178-142-132-231.ewe-ip-backbone.de [178.142.132.231])
        by smtp2.goneo.de (Postfix) with ESMTPSA id 287DC23F881;
        Sun, 16 Jun 2019 18:04:02 +0200 (CEST)
Subject: Re: [PATCH 12/14] doc-rst: add ABI documentation to the admin-guide
 book
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Jani Nikula <jani.nikula@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mauro Carvalho Chehab <mchehab@s-opensource.com>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org
References: <cover.1560477540.git.mchehab+samsung@kernel.org>
 <9da2a7f6ff57d9d53dcbb964eb310f7956522870.1560477540.git.mchehab+samsung@kernel.org>
 <87o930uvur.fsf@intel.com> <2955920a-3d6a-8e41-e8fe-b7db3cefed8b@darmarit.de>
 <20190614081546.64101411@lwn.net>
From:   Markus Heiser <markus.heiser@darmarit.de>
Message-ID: <327067f6-2609-41e6-c987-e37620e7154e@darmarit.de>
Date:   Sun, 16 Jun 2019 18:04:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190614081546.64101411@lwn.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: de-DE
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 14.06.19 um 16:15 schrieb Jonathan Corbet:
> On Fri, 14 Jun 2019 16:10:31 +0200
> Markus Heiser <markus.heiser@darmarit.de> wrote:
> 
>> I agree with Jani. No matter how the decision ends, since I can't help here, I'd
>> rather not show up in the copyright.
> 
> Is there something specific you are asking us to do here?
> 


I have lost the overview, but there was a patch Mauro added a
kernel_abi.py.  There was my name (Markus Heiser) listed with a
copyright notation.

I guess Mauro picked up some old RFC or an other old patch of
mine from 2016 and made some C&P .. whatever .. ATM I do not have
time to give any support on parsing ABI and I'am not interested
in holding copyrights on a C&P of a old source  ;)

-- Markus --

