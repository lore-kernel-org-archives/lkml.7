Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F041C2D0D2
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 18:00:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF6362072B
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 18:00:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="HckGBqUL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727456AbfLTSAT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Dec 2019 13:00:19 -0500
Received: from mout.web.de ([212.227.17.11]:54763 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727391AbfLTSAS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 13:00:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1576864810;
        bh=yce4km4FZO3qbZkUPuO0g1fDKgNurNILOxq/T6vHzLo=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=HckGBqULb5Mxm0O4ssaXfE0UlUgISlrHGK2TR2V6+I7sh+RtT2i+YlFhaDxD9Q+yc
         4AIdcwtAeblsogz7p8zWxbQzAQ4G6Jy0Tg6SmnMjEeyoNdzvd/ph9asRSYBdowQpu+
         UTOPBdYif3Wcev3YrrybrcjI3P9oqznsrsziAt/k=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([2.244.94.196]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0Lnj7L-1i1t1302RD-00hwQe; Fri, 20
 Dec 2019 19:00:10 +0100
Subject: Re: Improving documentation for programming interfaces
To:     "Theodore Y. Ts'o" <tytso@mit.edu>, linux-doc@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Cc:     LKML <linux-kernel@vger.kernel.org>
References: <350cd156-9080-24fe-c49e-96e758d3ca45@web.de>
 <20191220151945.GD59959@mit.edu>
 <0557f349-322c-92b3-9fc3-94e59538ca91@web.de>
 <20191220171753.GA234417@mit.edu>
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <f802d21a-e6cb-f947-2e52-8553f5e255d5@web.de>
Date:   Fri, 20 Dec 2019 19:00:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20191220171753.GA234417@mit.edu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:LoAsynVO+PRxJIKs2NhpXwhU1iobCJxOoTWd3LCJul4UJPH+PXF
 qTOJLdbk6KHEG55fVDkwo4QibPpjTojnbbFDm+rK/HeRNcXsRLneJP0HIvmrrPYjfRieCau
 bSqDEhGAP1gknXO8NrYALPQQMgAhLZuTi6gBWGKtuAGQQli0/pj1OFzGo1Crlru4bBWmTPR
 QnqCSuAq2/JHiI670XngA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:coKulRqyiR4=:Su7ID2SKVk14I+Z+WSsjwN
 8ue8N3Ls3shYE/wCleNadBDygT9R7KtSvvHcUcqLHhbpAAESCZSspEMatj9dBvdb8CdnfaU/7
 piVwuMQ/pXBzYgsdt3nd9kVcg1WShhI6gi5t9/mWH5AmKU8PEKPx0lHt3i4309HCQGX8mVHNc
 B91fbgCAeEg6YkKuctRZsCBEVcqhk8YuDJ8TtHQqHsNj1rwSSimwbTe2zNroICM+w24cjBKvB
 +X+OL3M9lOSSw5hf5E19KxS5hlS5e9i2Ruw4YAO9Do50HyZlIAeIkKyGLvjryPVicO5TAJDRg
 KMzlyK5Yr3m8TbARGAT6YNImZ92VgDWNpwhKV4R5BNOos/v19BldUV1XfqAQtG5BfrA5K0qsb
 /+U9z3WLAQumkxFfPhAjn0g9ZmoSoo0VWmRJgk+lh92egot+Sr2VPYZOs0C7WeGRn4ZoaT/ao
 2cMQSgbOuKldolWMZCWwUxsqA9ONvy2gt5oA1qf3LQXF5T+OO4YoQ/EKsVoyjO7Uk6gygOZ+Y
 XetH6FFktQVH8o+yxBS7Q6wMVxYXWwShfHQ4Fz+SQbwFWrtY2i5pmcWPq2y7+A1dlW5QI00/6
 vUALFxB0CUZYX+TRQ2lTo1Jf3k0hmvxph973PCsk5cxjsJ9eiTaHTTZdl9Z6brQ0O/6jcL4l2
 8rNZDBhzVwqq3exsmEtZTaJCtD6nhxnPmgSZ/0O+OatGG67nSKBvoRO2wQdroe9ltl95Et7Lh
 8bwYfSVQ2hh8lHXdVRNQHrYv8M/JZdMbjP7hLf0PckQ0wxvp95Y/SQVH1s48fXLSk2i2U6PlM
 LO3PPVBTY7KinRJoXTLCh8ncCZpzvHYOJN8HZgJ/YogHAOAVn87YzHBK2IqdvWFlyq3NDvJCM
 v8RtoLCUTLsybKJoJbmZuWozLjfd//d5+k5YJBVHkuMiLU9N0Cjm0E2mTOAzGfMriIkWo8uz8
 3xffBOro7LNxCeC4CjpKcGMusLFRB23yh9AEufkJU/8QXrPbOzJLTifHFVMureoNDiC4LFFqD
 VHE/7wjuBOMAwdaQkgzrnSm1ZKTD9xC62dJAr0O5CjyhAtlWSNMwR4R4Q3sHSHi7f4S4TngA4
 CeZ61BciYUhVb4mKKz5xNG4C+LTWw+Yir5culKgJXiQNGn9VHcVTC/zauqmaubmlOa5kdcYR9
 wO6i+qCGKgSroOwSvOR+pMBLsSGiK2ShZhxC53nhrEK6iWr9UtE7hxQhf8FIinEqTYMitRq5K
 p5ejlB9IyVAKFSsormFnbTx1GxPq1zogllxwI6ri91Bz66lMdk0L3PcWfVCQ=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> Further examples:
>> * kmalloc =E2=87=92 kfree
>> * kobject_create =E2=87=92 kobject_put
>> * device_register =E2=87=92 put_device
>>
>> Can preprocessor macros help to express any more relationships for simi=
lar function pairs?
>
> Sorry, this is still not making sense.

I suggest to reconsider such a view.


> =E2=80=A6  You said "a pointer would
> contain also the background information by which the resource should
> usually be released".  Huh?  There's no room for a pointer to also
> store context of whether it was allocated using kmalloc, or malloc, etc.

There are metadata (software documentation) to consider in the source code=
.

You get usually informed by comments for some allocation functions
which is the corresponding resource release function.
Such comments can vary. Thus I would appreciate to work with these data
in a more structured format.


> Did you have some concrete idea of how a preprocessor macros could be
> used to perform what appears to be completely impractical?

A macro can be chosen to which function names can be passed.

Example:
TRIGGER_RELEASE_AFTER(kfree, kmalloc, kcalloc, kzalloc, kmemdup)

Appropriate data type definitions could eventually be generated
by related macros.


> And how would that information be used by the kernel?

Documentation purposes.


> And for what benefit?

Consistent representation of relationships in a structured way.


> And can you show that the benefits will be worth the costs?

I propose to improve possibilities also for the support of better
source code analysis.

Regards,
Markus
