Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9A74C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 21:02:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9688B2147C
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 21:02:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (4096-bit key) header.d=kolabnow.com header.i=@kolabnow.com header.b="GyrCG0Om"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728265AbfCKVCH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 17:02:07 -0400
Received: from mx.kolabnow.com ([95.128.36.41]:64456 "EHLO mx.kolabnow.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727660AbfCKVCG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 17:02:06 -0400
Received: from localhost (unknown [127.0.0.1])
        by ext-mx-out002.mykolab.com (Postfix) with ESMTP id 1F5F415AD;
        Mon, 11 Mar 2019 22:02:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kolabnow.com; h=
        message-id:references:in-reply-to:subject:subject:from:from:date
        :date:content-transfer-encoding:content-type:content-type
        :mime-version:received:received:received; s=dkim20160331; t=
        1552338122; x=1554152523; bh=wZH+HhYZTwDHQBWhCTZTYdEZVt3BJUqk52M
        COIJmg8c=; b=GyrCG0Om3eh59I0r+uzfzYFExxkW/NCd0zy867zDnxJ+TawFgvn
        63ZCAI/D42uL8y8nDn4K4gMXElqmXlY6xwQaoVXtbOog/uiaIWrFCQILFt3oFj7m
        rh/6GFDgZV9DTwmItzm2uvrTZl+1lPs7iKFel823pbrlpLsguRFFCgnjTt4urvQn
        GosT3/RkYNkBSuMSfmgp2NmLMwrZ3e4sirHjfh1m2zezKM67HVVYES011CqMETZw
        IwMQYg3K6lJhHlXmnprQhNW5ZBU2Zg2pKJoDom7Och0GvyFfwjZ/wXO+QWpjE4sI
        gJoZX/bNfRnlFEEKTV5e8BT0mFzCiikM9PrbwGR2534lHcEMl6tS9/noxV5fBHPA
        yqXN0Qm20LKgNeOHI09E1H8di9dERRi70H3mueVlFkD5G81sH5GgszAzrVOHtNga
        o9rRZCyj8txs3slerMbzeOKnDLYcfF81mMrae6xj+sqWv5h8W7d1YNvn9KKLs3ft
        MN2R0qRgyPL7lkYRIpmhm9hmpPff1xn0iXrGPc4GuXWWqs1yM8U3ysk20mR+seTy
        C5KV2imsOcfnORlqJOYyQQXcQofl9zxYxliLpoyMPiylnjArvKlkUtMyParFyMTV
        OrX0/fv968QPjeJfgdxpb2yJQldx8EGDf9gPxCHU+zMhFssERj9qG12s=
X-Virus-Scanned: amavisd-new at mykolab.com
Received: from mx.kolabnow.com ([127.0.0.1])
        by localhost (ext-mx-out002.mykolab.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id B05SuR3O0VPC; Mon, 11 Mar 2019 22:02:02 +0100 (CET)
Received: from int-mx003.mykolab.com (unknown [10.9.13.3])
        by ext-mx-out002.mykolab.com (Postfix) with ESMTPS id B896815AC;
        Mon, 11 Mar 2019 22:02:02 +0100 (CET)
Received: from int-subm003.mykolab.com (unknown [10.9.37.3])
        by int-mx003.mykolab.com (Postfix) with ESMTPS id 6EA801916;
        Mon, 11 Mar 2019 22:02:02 +0100 (CET)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Mon, 11 Mar 2019 22:02:01 +0100
From:   Federico Vaga <federico.vaga@vaga.pv.it>
To:     Alex Shi <alex.shi@linux.alibaba.com>
Cc:     linux-doc@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, harryxiyou@gmail.com,
        Li Zefan <lizefan@huawei.com>,
        Shawn Guo <shawn.guo@linaro.org>,
        Fengguang Wu <fengguang.wu@intel.com>
Subject: Re: [RFC PATCH] doc: translation disclaimer
In-Reply-To: <8aad62be-e088-c5e1-e2df-a270c62ce1a1@linux.alibaba.com>
References: <20190305220611.13136-1-federico.vaga@vaga.pv.it>
 <02cb673f-eaf0-f78a-49f3-e95340748694@linux.alibaba.com>
 <1683884.6qb0gnyTyR@pcbe13614>
 <8aad62be-e088-c5e1-e2df-a270c62ce1a1@linux.alibaba.com>
Message-ID: <833e824cd99f7ed282dfe175ae59876d@vaga.pv.it>
X-Sender: federico.vaga@vaga.pv.it
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-03-07 05:03, Alex Shi wrote:
> On 2019/3/6 11:17 下午, Federico Vaga wrote:
> 
>> As I wrote in the commit message, this is just a  example to show
>> the
>> structure and share the main message.
>> 
>> What I wrote is just a 10 minutes sketch, to share an idea. This is
>> **not**
>> the text that I'm proposing; what I'm proposing here are the
>> structure and the
>> concepts/ideas/messages. The final patch will be written
>> appropriately, but
>> before doing it I would like to collect the messages that we want to
>> put in
>> it; I listed above what I think is necessary to say.
> 
> Got it. yes, it's a good idea, and we'd better figure out the more
> elegant, precise and legally words. :)

I wouldn't go that far with the legal jargon. There is nothing legal 
about
this, only that who read a translation must be aware of its limitations.


>> +
>> +Translations
>> +------------
>> +
>> 
>> .. toctree::
>> :maxdepth: 1
>> 
>> diff --git a/Documentation/translations/it_IT/disclaimer-ita.rst
>> b/Documentation/translations/it_IT/disclaimer-ita.rst index
>> d68e52de6a5d..aacc1a0346db 100644
>> --- a/Documentation/translations/it_IT/disclaimer-ita.rst
>> +++ b/Documentation/translations/it_IT/disclaimer-ita.rst
>> @@ -1,13 +1,6 @@
>> 
>> :orphan:
>> 
>> why the orphan here? does that mean no maintainer for it_IT
>> currently?
> 
> It is a Sphinx tag to avoid warnings at build time. Instead of
> re-writing
> exactly the same text in all files, this one is included at the top of
> all
> translated documents. But, since it is not a real document this is not
> 
> included in any TOC and sphinx complains; that's why we need the
> orphan tag
> 
> http://www.sphinx-doc.org/en/master/usage/restructuredtext/field-lists.html#metadata
> 
>  Thanks a lot for the explanations! :)

-- 
Federico Vaga
http://www.federicovaga.it/
