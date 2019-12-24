Return-Path: <SRS0=+gZy=2O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AF2EC2D0D2
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Dec 2019 14:35:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D668120706
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Dec 2019 14:35:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726245AbfLXOf3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Dec 2019 09:35:29 -0500
Received: from foss.arm.com ([217.140.110.172]:52536 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726128AbfLXOf3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Dec 2019 09:35:29 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C4B3F1FB;
        Tue, 24 Dec 2019 06:35:28 -0800 (PST)
Received: from [10.1.197.50] (e120937-lin.cambridge.arm.com [10.1.197.50])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 53CF43F534;
        Tue, 24 Dec 2019 06:35:28 -0800 (PST)
Subject: Re: [PATCH v2 07/11] firmware: arm_scmi: Skip protocol initialisation
 for additional devices
To:     Sudeep Holla <sudeep.holla@arm.com>,
        linux-arm <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20191218111742.29731-1-sudeep.holla@arm.com>
 <20191218111742.29731-8-sudeep.holla@arm.com>
 <CAPKp9uZznwOgpm=CEMMUDFvHVa=jsmG0-fd4q-_=c_d3HqbKTA@mail.gmail.com>
From:   Cristian Marussi <cristian.marussi@arm.com>
Message-ID: <4113a9cf-650c-e086-fcd9-b126da1597eb@arm.com>
Date:   Tue, 24 Dec 2019 14:35:27 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <CAPKp9uZznwOgpm=CEMMUDFvHVa=jsmG0-fd4q-_=c_d3HqbKTA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

On 24/12/2019 14:33, Sudeep Holla wrote:
> On Wed, Dec 18, 2019 at 11:19 AM Sudeep Holla <sudeep.holla@arm.com> wrote:
>>
>> The scmi bus now supports adding multiple devices per protocol,
>> and since scmi_protocol_init is called for each scmi device created,
>> we must avoid allocating protocol private data and initialising the
>> protocol itself if it is already initialised.
>>
>> In order to achieve the same, we can simple replace the idr pointer
>> from protocol initialisation function to a dummy function.
>>
>> Suggested-by: Cristian Marussi <cristian.marussi@arm.com>
> 
> 
> Hi Cristian,
> 
> Are you fine with this approach ? If yes, I plan to apply this series.
> 

Yes sure...forgot this was pending.

Reviewed-by: Cristian Marussi <cristian.marussi@arm.com>

Cristian
> --
> Regards,
> Sudeep
> 

