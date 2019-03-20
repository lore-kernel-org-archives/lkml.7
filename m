Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 864E4C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 04:02:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A122204FD
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 04:02:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726123AbfCTECd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 00:02:33 -0400
Received: from edison.jonmasters.org ([173.255.233.168]:58958 "EHLO
        edison.jonmasters.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725900AbfCTECd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 00:02:33 -0400
X-Greylist: delayed 980 seconds by postgrey-1.27 at vger.kernel.org; Wed, 20 Mar 2019 00:02:32 EDT
Received: from [74.203.127.5] (helo=tonnant.bos.jonmasters.org)
        by edison.jonmasters.org with esmtpsa (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.71)
        (envelope-from <jcm@jonmasters.org>)
        id 1h6SB8-0000AO-R1; Wed, 20 Mar 2019 03:46:11 +0000
To:     Greg KH <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>
Cc:     Amir Goldstein <amir73il@gmail.com>,
        Steve French <smfrench@gmail.com>,
        lsf-pc@lists.linux-foundation.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Luis R. Rodriguez" <mcgrof@kernel.org>
References: <20190212170012.GF69686@sasha-vm>
 <CAH2r5mviqHxaXg5mtVe30s2OTiPW2ZYa9+wPajjzz3VOarAUfw@mail.gmail.com>
 <CAOQ4uxjMYWJPF8wFF_7J7yy7KCdGd8mZChfQc5GzNDcfqA7UAA@mail.gmail.com>
 <20190213073707.GA2875@kroah.com>
 <CAOQ4uxgQGCSbhppBfhHQmDDXS3TGmgB4m=Vp3nyyWTFiyv6z6g@mail.gmail.com>
 <20190213091803.GA2308@kroah.com> <20190213192512.GH69686@sasha-vm>
 <20190213195232.GA10047@kroah.com>
From:   Jon Masters <jcm@jonmasters.org>
Message-ID: <79d10599-70d2-7d06-1cee-6e52d36233bf@jonmasters.org>
Date:   Tue, 19 Mar 2019 23:46:09 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190213195232.GA10047@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 74.203.127.5
X-SA-Exim-Mail-From: jcm@jonmasters.org
Subject: Re: [LSF/MM TOPIC] FS, MM, and stable trees
X-SA-Exim-Version: 4.2.1 (built Sun, 08 Nov 2009 07:31:22 +0000)
X-SA-Exim-Scanned: Yes (on edison.jonmasters.org)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/13/19 2:52 PM, Greg KH wrote:
> On Wed, Feb 13, 2019 at 02:25:12PM -0500, Sasha Levin wrote:

>> So really, it sounds like a low hanging fruit: we don't really need to
>> write much more testing code code nor do we have to refactor existing
>> test suites. We just need to make sure the right tests are running on
>> stable kernels. I really want to clarify what each subsystem sees as
>> "sufficient" (and have that documented somewhere).
> 
> kernel.ci and 0-day and Linaro are starting to add the fs and mm tests
> to their test suites to address these issues (I think 0-day already has
> many of them).  So this is happening, but not quite obvious.  I know I
> keep asking Linaro about this :(

We're working on investments for LDCG[0] in 2019 that include kernel CI
changes for server use cases. Please keep us informed of what you folks
ultimately want to see, and I'll pass on to the steering committee too.

Ultimately I've been pushing for a kernel 0-day project for Arm. That's
probably going to require a lot of duplicated effort since the original
0-day project isn't open, but creating an open one could help everyone.

Jon.

[0] Linaro DataCenter Group (formerly "LEG")
