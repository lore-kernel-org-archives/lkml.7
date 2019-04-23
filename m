Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6220FC10F03
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 19:36:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DE41218C3
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 19:36:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556048214;
	bh=ZIfkNik/AuFwzGsh+JZClURgDmqYgsqaEYhSu+URsqU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=1yjg4hncoxmrjIR462doWTtW1obFAVah1FIpaRJp8xSJL67akfRi+9s2EvAm1Vwi+
	 NHCgCfdMlwQILzf+uWbH//yK4A+CF31ZwvdXzc1VAk47lk99uBWr3U5opXbTVlXuLX
	 ViRydXKXsaS3C10qNUs6JyTHpEIc9SG/6c1B5xKE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726890AbfDWTgw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 15:36:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:55038 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725945AbfDWTgw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 15:36:52 -0400
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9FDC921738;
        Tue, 23 Apr 2019 19:36:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556048211;
        bh=ZIfkNik/AuFwzGsh+JZClURgDmqYgsqaEYhSu+URsqU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TIyksEkcxIQDetFEdrwry/Ot+Pp8QO8ZbO029VAKylr+nRW63qP+4LKSc4X+Ug1p1
         KELZLZIRtGq9+zj26FGWpZG2zk78IOsOv0Jq73xItGsdC4EbNtq4auJClltMwuQz+m
         sKJqHgY5yIxGoE5V5YqWOxNbrz+XOTNVoQnME67A=
Date:   Tue, 23 Apr 2019 15:36:50 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     James Feeney <james@nurealm.net>
Cc:     Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Jiri Kosina <jikos@kernel.org>, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 2/2] HID: input: fix assignment of .value
Message-ID: <20190423193650.GQ17719@sasha-vm>
References: <20190423154615.18257-2-benjamin.tissoires@redhat.com>
 <20190423172117.CC66520835@mail.kernel.org>
 <37009110-5a11-7ed4-3315-e87b98cc45b7@nurealm.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <37009110-5a11-7ed4-3315-e87b98cc45b7@nurealm.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 23, 2019 at 11:54:07AM -0600, James Feeney wrote:
>On 4/23/19 11:21 AM, Sasha Levin wrote:
>> Hi,
>>
>> [This is an automated email]
>>
>> This commit has been processed because it contains a "Fixes:" tag,
>> fixing commit: 2dc702c991e3 HID: input: use the Resolution Multiplier for high-resolution scrolling.
>>
>> The bot has tested the following trees: v5.0.9.
>>
>> v5.0.9: Failed to apply! Possible dependencies:
>>     724f54bc0063 ("HID: input: make sure the wheel high resolution multiplier is set")
>>
>>
>> How should we proceed with this patch?
>>
>> --
>> Thanks,
>> Sasha
>>
>
>This patch will only apply *after* the application of the first patch, since they "overlap".
>
>Yes, that is probably not the best circumstance.  I think Benjamin wanted to keep the issue in patch 2/2 distinct.
>
>Was the first patch applied before attempting application of the second patch?

My script messed up and listed it as a dependency (even though it's not
upstream) rather than applying it. I'll look into it, sorry for the
noise.

--
Thanks,
Sasha
