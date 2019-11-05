Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EED27CA9ED3
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 00:37:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B18A2080F
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 00:37:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=firemail.cc header.i=@firemail.cc header.b="R5dfwoVX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387427AbfKEAha (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 19:37:30 -0500
Received: from mx1.cock.li ([185.10.68.5]:44497 "EHLO cock.li"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729693AbfKEAh3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 19:37:29 -0500
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=firemail.cc; s=mail;
        t=1572914245; bh=dl8FyeCITTZvxmAsfPamVtKVF2q0zQbdpcYf8wSQRFI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=R5dfwoVX4kF2FbHHgWlBgixsUgM5nkjRizYeqPW1VaoK1CM7IiBnl50XPUMZ5AWDB
         m5uQ1zB8oti1lhKWtQLZRczn5ixaKTznH8EoJNzqbjn1Kxw/WMSWgl7VC6dweWra0r
         OwzpUfKRHjAj6ubZ+e9EhsMAbPC4YxuypcKKHNDjdZq742VgmeoFnYDRzvXZG/TnwW
         nQZFjSn31rMTT3Fw5SvzKzeXF/0GkjBlA18+PIF5CS0NwWsKXxxtXKPE3titepXjNc
         xpRQA3GwVwjotzHxTHesGz95T8GPrXkCaIscVJtLLjOJgA8noJ/m6jlMJTak89AeoD
         XC8uOI52cpNuA==
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 05 Nov 2019 00:37:25 +0000
From:   nipponmail@firemail.cc
To:     linux-kernel@vger.kernel.org
Cc:     ruben@mrbrklyn.com, mrbrklyn@panix.com
Subject: Re: Will no-one sue GrSecurity for their blatant GPL violation (of
 GCC and the linux kernel)?
In-Reply-To: <87ftj3gx9h.fsf@mid.deneb.enyo.de>
References: <b0668893d6fbfeca10a724e1c5846e92@firemail.cc>
 <E1iRgHg-0007e0-Gd@fencepost.gnu.org>
 <2fbd35b601c740b3cf88b73df7a2c123@firemail.cc>
 <87ftj3gx9h.fsf@mid.deneb.enyo.de>
Message-ID: <4175aec5f562fed9b7b9395016abe6de@firemail.cc>
X-Sender: nipponmail@firemail.cc
User-Agent: Roundcube Webmail/1.3.6
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It does not matter how common this way of doing buisness is.
It is still a blatant violation of the Copyright holders terms.

The Copyright holder has allowed GrSecurity to do something they, by 
default, have no right to do (create and distribute [non-seperable] 
derivative works), ONLY if they follow the Copyright holder's 
directives.

The Copyright holder has stipulated that each distributee has the 
permission to FREELY create derivative works based on the work and 
FREELY distribute said original work and said derivative works, but that 
they ONLY have this permission IF they also extend those rights to 
down-the-line-distributees AND they DO NOT add ANY additional 
_RESTRICTIONS_ on that right.

If GrSecurity was _NOT_ adding an additional restriction it would NOT 
need an "access agreement" (no-redistribution agreement).

They are BLATANTLY violating section 6.

Please read:
perens.com/2017/06/28/warning-grsecurity-potential-contributory-infringement-risk-for-customers/

Please.

The reason why this business model works is because:

1)Not-any-old-lawyer can walk into Federal Court.
You have to be accepted into the Federal Bar for that 
district/circuit/etc (IIRC). Which means one of the 
allready-on-federal-bar lawyers has to allow you in and vouch for you. 
That makes for fewer high priced lawyers

2) The costs will be high: half a million plus in legal fees in the end.

3) You win court-costs ONLY if you have registered your copyright BEFORE 
the violation you are suing defendant over, and also BEFORE any 
same/similar violation. Otherwise you only get regular damages (revenue, 
or profits, or what the defendant would have paid you for a license (0 
dollars), whichever the court wishes). (Note: you have to register your 
copyright at the time of the suit atleast, but if it is after the 
violations you don't get statutory damages nor do you get attorney's 
fees)

Also read this EFF brief, page 10 etc. It has some discussion on the 
violation: 
perens.com/static/OSS_Spenger_v_Perens/0_2018cv15189/docs1/pdf/18.pdf

On 2019-11-04 21:14, Florian Weimer wrote:
> * nipponmail:
> 
>> You are incorrect. GPL version 2 section 6 states that one shall not 
>> add
>> additional restrictions between the agreement between the licensee and
>> further licensees. It governs that relationship vis-a-vis the 
>> protected
>> Work.
>> 
>> GrSecurity has, indeed, stipulated an additional restrictive term.
>>  From: You may distribute derivative works freely.
>> GrSecurity has forced customers to agree to: We shall not distribute 
>> the
>> (non-separable) derivative work EXCEPT to our own customers (when
>> required).
>> 
>> That is clearly an additional restrictive term.
> 
> I assume they did this as part of their subscription agreement.  Their
> customers are free to terminate that agreement and exercise their
> rights under the GPL.  They just can't have it both ways.
> 
> I believe this a fairly common approach to subscription and service
> agreements for GPL software.
