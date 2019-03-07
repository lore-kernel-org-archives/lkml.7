Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24DB6C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 08:58:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC23920675
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 08:58:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726140AbfCGI60 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 03:58:26 -0500
Received: from mail.aixigo.de ([5.145.142.10]:7618 "EHLO mail.aixigo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725747AbfCGI60 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 03:58:26 -0500
X-Greylist: delayed 400 seconds by postgrey-1.27 at vger.kernel.org; Thu, 07 Mar 2019 03:58:25 EST
Received: from srvvm01.ac.aixigo.de (mail.ac.aixigo.de [172.19.96.11])
        by gate5a.ac.aixigo.de (OpenSMTPD) with ESMTPS id afa529fb (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256:NO);
        Thu, 7 Mar 2019 09:51:44 +0100 (CET)
Received: from dpcl082.ac.aixigo.de (dpcl082.ac.aixigo.de [172.19.97.128])
        by srvvm01.ac.aixigo.de (8.15.2/8.15.2/Debian-8) with ESMTP id x278piER354142;
        Thu, 7 Mar 2019 09:51:44 +0100
Subject: Re: 4.20.1: BUG: unable to handle kernel paging request at
 0000100000000008
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <fd58236d-a939-ec7b-b666-706f6853c49d@aixigo.de>
 <4b1cdcac-e6ec-09ca-558a-1ff391f13e52@aixigo.de> <20190306231027.GF7915@amd>
From:   Harald Dunkel <harald.dunkel@aixigo.de>
Message-ID: <e0211b6c-93b9-e6f0-4120-821d0899524e@aixigo.de>
Date:   Thu, 7 Mar 2019 09:51:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.2
MIME-Version: 1.0
In-Reply-To: <20190306231027.GF7915@amd>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.101.1 at srvvm01.ac.aixigo.de
X-Virus-Status: Clean
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pavel,

On 3/7/19 12:10 AM, Pavel Machek wrote:
> On Tue 2019-01-22 11:15:39, Harald Dunkel wrote:
>> Is this the wrong list to report this problem? I haven't found a
>> "mem" mailing list on vger.
> 
> Right list, ugly looking problem. How reproducible is it?
> 

By now this was just a single incident. The server runs 24/7, but I try
to keep the kernel up-to-date, so it is rebootet frequently.

> You may want to look at MAINTAINERS file, cc x86 and memory management
> people...?
> 

I have created a bug report. https://bugzilla.kernel.org/show_bug.cgi?id=202257
Please ignore the hijacker.


Regards
Harri
