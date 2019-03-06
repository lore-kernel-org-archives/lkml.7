Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0ACDC43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 14:29:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE63320684
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 14:29:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551882543;
	bh=cim+pMS43UdIxBxNErZGjVL4p1j6SW6GdafOeha2S/w=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=saDQaPvtWnkUCDV/cY+xRED23dvDEQeaLxbSXPaPskywifZg7TGOff6OZcGCcFjgq
	 UOK/TW89S27mgFc2QcpHr0Mf1ktuRqDwCN5vnAjL1R/JIZYvJM09UXvu2Hce5bx3Yo
	 gMm3IsyXeNsK+8VPNoWclV2NL0inLixu8f5dQTsE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727311AbfCFO3C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 09:29:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:40432 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725788AbfCFO3B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 09:29:01 -0500
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ECBA420684;
        Wed,  6 Mar 2019 14:29:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551882541;
        bh=cim+pMS43UdIxBxNErZGjVL4p1j6SW6GdafOeha2S/w=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=SvKWtOEnCbE09X/HnZ+FsviV0Q2x0Hi4XxIv3Qu9+mLTAKXlShydoPnYzfF/bYklO
         buEbEq6TNcPCOdd8k26PkQzm09/EJZ61WwWlKorvezZ6Oz9fUgy44u288p8lr7dlW5
         Bisj3y8QCpUdITW6C4MIkKjDfqVi3c732D4ijXzY=
Subject: Re: [GIT PULL] cpupower update for Linux 5.1-rc1
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Thomas Renninger <trenn@suse.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>, shuah <shuah@kernel.org>
References: <cc753578-75ba-2030-553d-f7d7d16955ef@kernel.org>
 <CAJZ5v0jg5Z6RZJjeuftWb+MBxvhUc5mdKQLfea+e29TQDRuxVw@mail.gmail.com>
From:   shuah <shuah@kernel.org>
Message-ID: <e51b561d-bb96-39f6-dbe0-6a7316f28544@kernel.org>
Date:   Wed, 6 Mar 2019 07:28:53 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0jg5Z6RZJjeuftWb+MBxvhUc5mdKQLfea+e29TQDRuxVw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rafael,

On 3/6/19 2:44 AM, Rafael J. Wysocki wrote:
> Hi Shuah,
> 
> On Fri, Mar 1, 2019 at 5:47 PM shuah <shuah@kernel.org> wrote:
>>
>> Hi Rafael,
>>
>> Please pull the following cpupower update for Linux 5.1-rc1.
>>
>> This cpupower update for Linux 5.1-rc1 consists of a patch to add
>> support to display boost frequency separately from Abhishek Goel.
>>
>> diff is attached.
> 
> Pulled, but since my own pull requests have been sent already, this
> will have to wait for the second half of the merge window.
> 
> Thanks!
>

Second half of the merge window works just fine.

thanks,
-- Shuah


