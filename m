Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98F36C48BD7
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 17:34:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AE252064A
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 17:34:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726721AbfF0ReZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 13:34:25 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:56962 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726405AbfF0ReZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 13:34:25 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::d71])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id D377914DB8767;
        Thu, 27 Jun 2019 10:34:24 -0700 (PDT)
Date:   Thu, 27 Jun 2019 10:34:24 -0700 (PDT)
Message-Id: <20190627.103424.2376390104509352.davem@davemloft.net>
To:     c0d1n61at3@gmail.com
Cc:     skhan@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [Linux-kernel-mentees][PATCH v2] packet: Fix undefined
 behavior in bit shift
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190627165726.p6k3tugjs2gzgnjh@rYz3n>
References: <7f6f44b2-3fe4-85f6-df3c-ad59f2eadba2@linuxfoundation.org>
        <20190627.092253.1878691006683087825.davem@davemloft.net>
        <20190627165726.p6k3tugjs2gzgnjh@rYz3n>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 27 Jun 2019 10:34:25 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiunn Chang <c0d1n61at3@gmail.com>
Date: Thu, 27 Jun 2019 11:57:28 -0500

> On Thu, Jun 27, 2019 at 09:22:53AM -0700, David Miller wrote:
>> From: Shuah Khan <skhan@linuxfoundation.org>
>> Date: Wed, 26 Jun 2019 21:32:52 -0600
>> 
>> > On 6/26/19 9:25 PM, Jiunn Chang wrote:
>> >> Shifting signed 32-bit value by 31 bits is undefined.  Changing most
>> >> significant bit to unsigned.
>> >> Changes included in v2:
>> >>    - use subsystem specific subject lines
>> >>    - CC required mailing lists
>> >> 
>> > 
>> > These version change lines don't belong in the change log.
>> 
>> For networking changes I actually like the change lines to be in the
>> commit log.  So please don't stray people this way, thanks.
> 
> Hello David,
> 
> Would you like me to send v3 with the change log in the patch description?

I'll use v2 which had this done correctly.
