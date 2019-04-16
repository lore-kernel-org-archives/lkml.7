Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6957AC10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 15:51:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34401204EC
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 15:51:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555429865;
	bh=ndE4xLI0Ql4DsxAa1GY5aDndCsFXDS7M9H3psus5MSw=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=rHz4ck/DRUgV/r/2c5gDG7DY5KQ5WP2IlPu6tD1XW5RYACSyestZe1anJwUmurPkB
	 jncgRSHWgF7O3PHATB0sJDlh6h+SPi25cGwcORE2LoLUdlAmJ7erIVEYkQcVcoJJBl
	 iz5JM1pz8TwNhRPjuOM/mbY4S+gvEQ/hGisPhEDY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729357AbfDPPvE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 11:51:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:56776 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726230AbfDPPvD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 11:51:03 -0400
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4E2CC204EC;
        Tue, 16 Apr 2019 15:51:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555429862;
        bh=ndE4xLI0Ql4DsxAa1GY5aDndCsFXDS7M9H3psus5MSw=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=l70t3Ra92TkAuRvtMO0H7ucHezjF5xTgxxIqQs/5kZlLIejbXQRjVKPgXtZBIFvZJ
         mwZGIjync8ey/A5PB+HPL34oPcjBim2T/yRcn8rQPxKUXZvKogVlgpXmboTS1F2Pqg
         OVObT7owxbS1qHtX7TJpjX0R05WeZL1+T0ZGb0Fo=
Subject: Re: [PATCH] doc: kselftest: Fix KBUILD_OUTPUT usage instructions
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, shuah <shuah@kernel.org>
References: <20190416142651.7048-1-shuah@kernel.org>
 <20190416092610.78b462de@lwn.net>
From:   shuah <shuah@kernel.org>
Message-ID: <90615fb4-ff56-af72-f4ea-f3dbc3db26df@kernel.org>
Date:   Tue, 16 Apr 2019 09:50:16 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190416092610.78b462de@lwn.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/16/19 9:26 AM, Jonathan Corbet wrote:
> On Tue, 16 Apr 2019 08:26:51 -0600
> Shuah Khan <shuah@kernel.org> wrote:
> 
>> Fix KBUILD_OUTPUT usage instructions. The current documentation
>> is incorrect.
>>
>> Signed-off-by: Shuah Khan <shuah@kernel.org>
> 
> So I'll confess to being a little confused by this one...

I generated the patch on a system with older .gitconfig. :)


> 
>>   Documentation/dev-tools/kselftest.rst | 8 ++++----
>>   1 file changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/Documentation/dev-tools/kselftest.rst b/Documentation/dev-tools/kselftest.rst
>> index c8c03388b9de..6c910ddaa9f9 100644
>> --- a/Documentation/dev-tools/kselftest.rst
>> +++ b/Documentation/dev-tools/kselftest.rst
>> @@ -39,9 +39,9 @@ Build and run from user specific object directory (make O=dir)::
>>   
>>     $ make O=/tmp/kselftest kselftest
>>   
>> -Build and run KBUILD_OUTPUT directory (make KBUILD_OUTPUT=)::
>> +Build and run from KBUILD_OUTPUT directory (make KBUILD_OUTPUT=)::
>>   
>> -  $ make KBUILD_OUTPUT=/tmp/kselftest kselftest
>> +  $ export KBUILD_OUTPUT=/tmp/kselftest; make kselftest
> 
> Is there a particular reason why this variable needs to be set in the
> environment rather than just in make?  More importantly, though, I don't
> think this would work if you run it from the KBUILD_OUTPUT directory.  What
> you're really doing is running with a separate output directory, right?
> 

That is correct. I am matching the instructions in the main Makefile:

# kbuild supports saving output files in a separate directory.
# To locate output files in a separate directory two syntaxes are supported.
# In both cases the working directory must be the root of the kernel src.
# 1) O=
# Use "make O=dir/to/store/output/files/"
#

# 2) Set KBUILD_OUTPUT
# Set the environment variable KBUILD_OUTPUT to point to the directory
# where the output files shall be placed.
# export KBUILD_OUTPUT=dir/to/store/output/files/
# make

kselftest documentation doesn't match the main Makefile. I am fixing
that with this patch.

For both cases the working directory is the src dir just like the main
Makefile.

I hope this helps.

thanks,
-- Shuah

