Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59ADDCA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 09:42:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CB6421D7B
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 09:42:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="pfsPbada"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438828AbfJYJmX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 05:42:23 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:43918 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2393261AbfJYJmW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 05:42:22 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x9P9fFW7024039;
        Fri, 25 Oct 2019 11:42:09 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=STMicroelectronics;
 bh=RPoKrF7AEx817/OL2i41RS5qsNRlWR+xIJ3AH01ejFY=;
 b=pfsPbadakRJV5PyG6pRbA2K2NermqenA9qN6oXX6bptKViweoSp/VjN+QV081EWnRw6w
 Jte0Y9xn3Dknfl062yqM7DvVN4bDr2/XsNVvrsOxG8d2isoCPNjp9A4uVJiKPgNqoz8h
 ZgRqSBFeqZevTD8M/Ps0UldPO52xFlhSsYjaZfVTMmzjjOi4yjgab8kXUXy02iZpM2Bw
 26LKNZt8C7sRrnBTowaJB61uX5yWWShLTGFHHJ0QS/pgK/s9RXwuzRURzbb0M6I59WCL
 UKMgI4cHN/7ccJupJ4qTOEvgPrikqw4dD4V25yabvrZ9kKXPIxARYgdmYgIAHwfwoa0Q tQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2vt9s4exhj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 25 Oct 2019 11:42:08 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 74850100039;
        Fri, 25 Oct 2019 11:42:06 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 65A392BF6A3;
        Fri, 25 Oct 2019 11:42:06 +0200 (CEST)
Received: from lmecxl0912.lme.st.com (10.75.127.44) by SFHDAG3NODE2.st.com
 (10.75.127.8) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Fri, 25 Oct
 2019 11:42:05 +0200
Subject: Re: [PATCH] Documentation: add link to stm32mp157 docs
To:     Jonathan Corbet <corbet@lwn.net>,
        Gerald BAEZA <gerald.baeza@st.com>
CC:     "mcoquelin.stm32@gmail.com" <mcoquelin.stm32@gmail.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <1566908347-92201-1-git-send-email-gerald.baeza@st.com>
 <20190827074825.64a28e88@lwn.net>
 <5257eff7-418b-8e94-1ced-30718dd3f5dc@st.com>
 <8d097a0486e94257952600bf6d20975d@SFHDAG5NODE1.st.com>
 <20191007093208.757554b0@lwn.net>
From:   Alexandre Torgue <alexandre.torgue@st.com>
Message-ID: <433bfc27-14cd-cf19-8460-7fd5230aaa55@st.com>
Date:   Fri, 25 Oct 2019 11:42:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191007093208.757554b0@lwn.net>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.44]
X-ClientProxiedBy: SFHDAG5NODE1.st.com (10.75.127.13) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-25_05:2019-10-23,2019-10-25 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jonathan

On 10/7/19 5:32 PM, Jonathan Corbet wrote:
> On Thu, 3 Oct 2019 10:05:46 +0000
> Gerald BAEZA <gerald.baeza@st.com> wrote:
> 
>>>> Adding the URL is a fine idea.  But you don't need the extra syntax to
>>>> create a link if you're not going to actually make a link out of it.
>>>> So I'd take the ".. _STM32MP157:" part out and life will be good.
>>>>   
>>>
>>> We also did it for older stm32 product. Idea was to not have the "full"
>>> address but just a shortcut of the link when html file is read. It maybe makes
>>> no sens ? (if yes we will have to update older stm32 overview :))
>>
>> Example in https://www.kernel.org/doc/html/latest/arm/stm32/stm32h743-overview.html
>>
>> Do you agree to continue like this ?
> 
> If you actually use the reference then it's OK, I guess; in the posted
> document that wasn't happening.  I still think it might be a bit more
> straightforward to just put the URL; that will make the plain-text file a
> little more readable.  In the end, though, it's up to you, go with
> whichever you prefer.
> 

Do you take this patch or do I have to add it in my STM32 pull request ?

Thanks in advance
Alex


> Thanks,
> 
> jon
> 
