Return-Path: <SRS0=31nU=WT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0061C3A5A2
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 09:37:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A0BE21726
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 09:37:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387519AbfHWJhI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Aug 2019 05:37:08 -0400
Received: from foss.arm.com ([217.140.110.172]:58534 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733010AbfHWJhE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Aug 2019 05:37:04 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6C295337;
        Fri, 23 Aug 2019 02:37:03 -0700 (PDT)
Received: from [10.1.196.133] (e112269-lin.cambridge.arm.com [10.1.196.133])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 886B83F246;
        Fri, 23 Aug 2019 02:37:02 -0700 (PDT)
Subject: Re: [PATCH] drm/panfrost: Add missing check for pfdev->regulator
To:     Rob Herring <robh@kernel.org>
Cc:     Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        David Airlie <airlied@linux.ie>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Dan Carpenter <dan.carpenter@oracle.com>
References: <20190822091512.GA32661@mwanda>
 <20190822093218.26014-1-steven.price@arm.com>
 <CAL_Jsq+1-qUxF3FSocVis6h4HV-=qnzWfK13hDq+Ns9kNEZuUg@mail.gmail.com>
From:   Steven Price <steven.price@arm.com>
Message-ID: <f6800b5c-0b43-e326-b435-5d626c99cc4b@arm.com>
Date:   Fri, 23 Aug 2019 10:37:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAL_Jsq+1-qUxF3FSocVis6h4HV-=qnzWfK13hDq+Ns9kNEZuUg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/08/2019 02:52, Rob Herring wrote:
> On Thu, Aug 22, 2019 at 4:32 AM Steven Price <steven.price@arm.com> wrote:
>>
>> When modifying panfrost_devfreq_target() to support a device without a
>> regulator defined I missed the check on the error path. Let's add it.
>>
>> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
>> Fixes: e21dd290881b ("drm/panfrost: Enable devfreq to work without regulator")
>> Signed-off-by: Steven Price <steven.price@arm.com>
>> ---
>>  drivers/gpu/drm/panfrost/panfrost_devfreq.c | 6 ++++--
>>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> Looks fine to me, but seems to be delayed getting to the list and
> patchwork. I'm guessing you're not subscribed to dri-devel because all
> your patches seem to get delayed.

Ah, yes I'm subscribed with a different email address - hopefully now
also subscribed with my @arm.com one.

Steve
