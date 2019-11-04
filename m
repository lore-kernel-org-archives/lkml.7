Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AB5ACA9EB5
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 17:56:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2460F20B7C
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 17:56:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=firemail.cc header.i=@firemail.cc header.b="CN6ujrK0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729459AbfKDR4f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 12:56:35 -0500
Received: from mx1.cock.li ([185.10.68.5]:40735 "EHLO cock.li"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727469AbfKDR4f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 12:56:35 -0500
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=firemail.cc; s=mail;
        t=1572890193; bh=FO882cvk6FLWrnJGhHr1h2Rc0TjXZQ4KU4YXJIWlciU=;
        h=Date:From:To:Subject:In-Reply-To:References:From;
        b=CN6ujrK0obFpcxO/5AWoOof+HuehsvUMGifE1pPSxp6xSD1+gKk/5Hz2Q74Jb5Ysc
         ujNFKX/sbMnkF0Q0gaqLGEMbslj8R8D7vkAnbeI3Qm0EbjmAUnyus83xU+KAC0wnp1
         /ft9btcrNBA5SCLf/bOe/N1+yYinaohtNkSUJSJWl3ROM9/VVg2xPCVZOdS8SukTub
         bhZd+ZGMcAIewhemd3PkPrsaR+sHLjxz9kUIMdVRc0BWU24g78IDGBMXFN1MpQK1P6
         ZpKB/lfO2w6AF+c2gaNtwZiR+1LCv+Hf4DSK3NqmqrPBV9LLNCUAaFLT9fCAhsiNeS
         ixd+RJqrlwHQA==
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 04 Nov 2019 17:56:32 +0000
From:   nipponmail@firemail.cc
To:     linux-kernel@vger.kernel.org
Subject: Re: Will no-one sue GrSecurity for their blatant GPL violation (of
 GCC and the linux kernel)?
In-Reply-To: <E1iRgHg-0007e0-Gd@fencepost.gnu.org>
References: <b0668893d6fbfeca10a724e1c5846e92@firemail.cc>
 <E1iRgHg-0007e0-Gd@fencepost.gnu.org>
Message-ID: <f2f8761cb462b2576696c500cc57e257@firemail.cc>
X-Sender: nipponmail@firemail.cc
User-Agent: Roundcube Webmail/1.3.6
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

You are incorrect. GPL version 2 section 6 states that one shall not add 
additional restrictions between the agreement between the licensee and 
further licensees. It governs that relationship vis-a-vis the protected 
Work.

GrSecurity has, indeed, stipulated an additional restrictive term.
 From: You may distribute derivative works freely.
GrSecurity has forced customers to agree to: We shall not distribute the 
(non-separable) derivative work EXCEPT to our own customers (when 
required).

That is clearly an additional restrictive term.

Yes, I am a lawyer. A court would not be "tricked" by GrSecurity putting 
it's additional restrictive term in a separate writing. The license is 
instructions about what you are allowed to do with Copyright Holder's 
work; He EXPLICITLY forbade additional restrictive terms.

GrSecurity does not have a pre-existing legal right to create 
non-separable derivative works at all. The default rights are: nothing 
(all rights reservered).

On 2019-11-04 17:36, ams@gnu.org wrote:
> One is not under obligation to guarantee that new versions are
> distributed to someone, which also means obligations can be terminated
> for any reason.  So while grsecurity might not be doing the morally
> and ethically right thing, I do not think they are violating the GNU
> GPL.  You're still free to redistribute the patches, but grsecurity
> isn't under obligation to give you future updates.
> 
> Their agreement text is located at
> https://grsecurity.net/agree/agreement_faq
