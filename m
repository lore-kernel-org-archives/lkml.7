Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D0BDCA9EAF
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 19:50:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC34C2070B
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 19:50:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gFfI4mK3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437404AbfJXTuA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 15:50:00 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:41720 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437127AbfJXTt7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 15:49:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=qOGOspI8Yp77UR3I2ZyXpP3n8duCcwhHM+XycuF+ITA=; b=gFfI4mK3vxFR5+ZE+1FRgfWgS
        FH1exvuK7nhQwFyEXoIp3RvDO13yc8MYshtgiNUVBi2K6H7oDhq7OmT+DFhFITrtOjoKVxI3gF2ri
        +NuOOVBlSKc7uozcSq13/kqJjdytV3VAEFl34iQsnuNWlpGTPJQn0zM0sna1HhFspZRgIbGLgV9A3
        aKhvWgkdxFvKje4zG5YnSzV0YX420w27S2tfduEVgcL0OeSp7hmMDUuua5dlT6FD/nsuUSRA3Qc3n
        rFValBFSHIEX80Mq0QfnAUIPG6lsAq3vaC6sMggXQXdVQvImi+si+ziv/UHqhoL9POO66D6+/KDD7
        6IdUawPNA==;
Received: from [2601:1c0:6280:3f0::9ef4]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iNj7O-0006Sb-49; Thu, 24 Oct 2019 19:49:58 +0000
Subject: Re: [PATCH v2 1/2] docs/core-api: memory-allocation: remove uses of
 c:func:
To:     Chris Packham <Chris.Packham@alliedtelesis.co.nz>,
        "corbet@lwn.net" <corbet@lwn.net>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
References: <20191022211438.3938-1-chris.packham@alliedtelesis.co.nz>
 <20191022211438.3938-2-chris.packham@alliedtelesis.co.nz>
 <20191024120227.0bd1ae92@lwn.net>
 <d053a8dc8e08b5b3ff4f2f4ff5b7c6ce4c3e773f.camel@alliedtelesis.co.nz>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <d5c282bd-42b7-7019-9964-30dc21ed0282@infradead.org>
Date:   Thu, 24 Oct 2019 12:49:57 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <d053a8dc8e08b5b3ff4f2f4ff5b7c6ce4c3e773f.camel@alliedtelesis.co.nz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/24/19 12:39 PM, Chris Packham wrote:
> Hi Jon,
> 
> On Thu, 2019-10-24 at 12:02 -0600, Jonathan Corbet wrote:
>> On Wed, 23 Oct 2019 10:14:37 +1300
>> Chris Packham <chris.packham@alliedtelesis.co.nz> wrote:
>>
>>> These are no longer needed as the documentation build will automatically
>>> add the cross references.
>>>
>>> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
>>> ---
>>>
>>>  Documentation/core-api/memory-allocation.rst | 49 +++++++++-----------
>>>  1 file changed, 23 insertions(+), 26 deletions(-)
>>
>> So I can't get this patch to apply, and I can't even figure out why.  If
>> you take the patch from the list, can you apply it to a docs-next (or
>> mainline) branch?
>>
> 
> I think it might be dependent on my other typo fix patch[1]. I'll
> rebase to v5.4-rc4 and send as a series of 3. Sorry for the hassle.
> 
> --
> [1] 
> https://lore.kernel.org/lkml/20191021003833.15704-1-chris.packham@alliedtelesis.co.nz/
> 
> 
>> Thanks,
>>
>> jon

patch tells me:
patch: **** malformed patch at line 84: -:c:func:`kmem_cache_destroy`.

-- 
~Randy

