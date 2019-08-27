Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7169EC3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 15:23:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 441C52070B
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 15:23:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="VbqIUTEV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730239AbfH0PXt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 11:23:49 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:1613 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727219AbfH0PXs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 11:23:48 -0400
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7RFLUt5007886;
        Tue, 27 Aug 2019 17:23:36 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=STMicroelectronics;
 bh=SMKi/mX7zvq/yrjJa5DU8JTV4hHp8R0QThyzkk9s3nA=;
 b=VbqIUTEVJwBhsOXMzWDDM0WvEpGE8M1Fpzxc2dYPMy6ExSX4mLoDAaBLGp0xoV3psUrN
 mrc3zFMXTWIe16z1EzNMiMSfbFZy7ftoqLjmFYBILsTiBut8g6JZQd5nEI98DH322Wln
 ASDN4IZp3FXfucqYou5miezHC83yJBffg2S5FNlcIPC+HGTat3x7bXkz7KJgtCJ+aBGI
 VmJ/Iloca7rnS74AbeTEj9+CiJosfGB28SXarYrcEHbXI/W8pmIhK9hTQd83Y8HhjuMO
 grAuIuqZ2Mwmgsu4JYZvPXmKNXB4OZtpVs2GtNYceuB59H8KhZJ8NoMxsvftLAo9WGkC 6w== 
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
        by mx08-00178001.pphosted.com with ESMTP id 2ujtcbjk3r-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Tue, 27 Aug 2019 17:23:36 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 768AE24;
        Tue, 27 Aug 2019 15:23:32 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id A90C72AC1B6;
        Tue, 27 Aug 2019 17:23:31 +0200 (CEST)
Received: from lmecxl0912.lme.st.com (10.75.127.44) by SFHDAG3NODE2.st.com
 (10.75.127.8) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Tue, 27 Aug
 2019 17:23:31 +0200
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
From:   Alexandre Torgue <alexandre.torgue@st.com>
Message-ID: <5257eff7-418b-8e94-1ced-30718dd3f5dc@st.com>
Date:   Tue, 27 Aug 2019 17:23:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190827074825.64a28e88@lwn.net>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.44]
X-ClientProxiedBy: SFHDAG1NODE3.st.com (10.75.127.3) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-27_03:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jonathan,

On 8/27/19 3:48 PM, Jonathan Corbet wrote:
> On Tue, 27 Aug 2019 12:19:32 +0000
> Gerald BAEZA <gerald.baeza@st.com> wrote:
> 
>> Link to the online stm32mp157 documentation added
>> in the overview.
>>
>> Signed-off-by: Gerald Baeza <gerald.baeza@st.com>
>> ---
>>   Documentation/arm/stm32/stm32mp157-overview.rst | 6 ++++++
>>   1 file changed, 6 insertions(+)
>>
>> diff --git a/Documentation/arm/stm32/stm32mp157-overview.rst b/Documentation/arm/stm32/stm32mp157-overview.rst
>> index f62fdc8..8d5a476 100644
>> --- a/Documentation/arm/stm32/stm32mp157-overview.rst
>> +++ b/Documentation/arm/stm32/stm32mp157-overview.rst
>> @@ -14,6 +14,12 @@ It features:
>>   - Standard connectivity, widely inherited from the STM32 MCU family
>>   - Comprehensive security support
>>   
>> +Resources
>> +---------
>> +
>> +Datasheet and reference manual are publicly available on ST website:
>> +.. _STM32MP157: https://www.st.com/en/microcontrollers-microprocessors/stm32mp157.html
>> +
> 
> Adding the URL is a fine idea.  But you don't need the extra syntax to
> create a link if you're not going to actually make a link out of it.  So
> I'd take the ".. _STM32MP157:" part out and life will be good.
> 

We also did it for older stm32 product. Idea was to not have the "full" 
address but just a shortcut of the link when html file is read. It maybe 
makes no sens ? (if yes we will have to update older stm32 overview :))

thanks
Alex


> Thanks,
> 
> jon
> 
