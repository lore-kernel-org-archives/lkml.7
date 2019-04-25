Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C29EC10F03
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 10:04:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9619206BA
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 10:04:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730232AbfDYKEJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 06:04:09 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:33316 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726628AbfDYKEH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 06:04:07 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 60BC526104F
Subject: Re: [PATCH v8 7/7] mfd: cros_ec: differentiate SCP from EC by feature
 bit.
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Pi-Hsun Shih <pihsun@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20190412071851.60332-1-pihsun@chromium.org>
 <20190412071851.60332-8-pihsun@chromium.org>
 <9bf20470-e5f6-7c12-9cc3-d9c6041a3bf8@collabora.com>
 <20190425090615.GG14758@dell>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <37f280a8-bacd-164c-246a-0938bfc476a3@collabora.com>
Date:   Thu, 25 Apr 2019 12:04:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190425090615.GG14758@dell>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lee,

On 25/4/19 11:06, Lee Jones wrote:
> On Mon, 15 Apr 2019, Enric Balletbo i Serra wrote:
>> On 12/4/19 9:18, Pi-Hsun Shih wrote:
>>> System Companion Processor (SCP) is Cortex M4 co-processor on some
>>> MediaTek platform that can run EC-style firmware. Since a SCP and EC
>>> would both exist on a system, and use the cros_ec_dev driver, we need to
>>> differentiate between them for the userspace, or they would both be
>>> registered at /dev/cros_ec, causing a conflict.
>>>
>>> Signed-off-by: Pi-Hsun Shih <pihsun@chromium.org>
>>
>> Acked-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
>>
>> Lee, there are several patches touching these files right now so you could have
>> to solve some trivial conflicts. If you want I send a series with all that apply
>> cleanly just let me know.
> 
> It would be ideal if you could bundle them to avoid conflicts.
> 

I first bundle was submitted here https://lkml.org/lkml/2019/4/8/270

I'll send a second bundle on top of the above.

- Enric
