Return-Path: <SRS0=3QRk=U6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDCADC06511
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 13:22:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0E46214AE
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 13:22:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728817AbfGANWW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 09:22:22 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:49456 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726329AbfGANWV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 09:22:21 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 77D48260DF9
Subject: Re: linux-next: build failure after merge of the battery tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Sebastian Reichel <sre@kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nick Crews <ncrews@chromium.org>
References: <20190628140304.76caf572@canb.auug.org.au>
 <20190628153146.c2lh4y55qvcmqhry@earth.universe>
 <d3515009-c922-7aa6-2ded-4ca39ed324f2@collabora.com>
 <20190629103317.421ed4b6@canb.auug.org.au>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <923f8554-7670-a2ab-dc5e-0f38eeeea6e0@collabora.com>
Date:   Mon, 1 Jul 2019 15:22:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190629103317.421ed4b6@canb.auug.org.au>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sebastian,

In case is not too late for you. Otherwise we will need to wait for next cycle.

The following changes since commit a188339ca5a396acc588e5851ed7e19f66b0ebd9:

  Linux 5.2-rc1 (2019-05-19 15:47:09 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/chrome-platform/linux.git
tags/ib-chrome-psy-5.3

for you to fetch changes up to 0c0b7ea23aed0b55ef2f9803f13ddaae1943713d:

  platform/chrome: wilco_ec: Add property helper library (2019-05-20 10:18:09 +0200)

----------------------------------------------------------------
Immutable branch between Power Supply and Chrome Platform due for the v5.3 merge
window

----------------------------------------------------------------
Nick Crews (1):
      platform/chrome: wilco_ec: Add property helper library

 drivers/platform/chrome/wilco_ec/Makefile     |   2 +-
 drivers/platform/chrome/wilco_ec/properties.c | 132 ++++++++++++++++++++++++++
 include/linux/platform_data/wilco-ec.h        |  71 ++++++++++++++
 3 files changed, 204 insertions(+), 1 deletion(-)
 create mode 100644 drivers/platform/chrome/wilco_ec/properties.c



On 29/6/19 2:33, Stephen Rothwell wrote:
> Hi Enric,
> 
> On Fri, 28 Jun 2019 18:56:56 +0200 Enric Balletbo i Serra <enric.balletbo@collabora.com> wrote:
>>
>> Hmm, I just applied this patch on top of linux-next and it build with
>> allmodconfig on x86_64
>>
>> I am wondering if the build was done without this commit, which is in
>> chrome-platform for-next branch. Could be this the problem?
>>
>> commit 0c0b7ea23aed0b55ef2f9803f13ddaae1943713d
>> Author: Nick Crews <ncrews@chromium.org>
>> Date:   Wed Apr 24 10:56:50 2019 -0600
>>
>>     platform/chrome: wilco_ec: Add property helper library
> 
> Exactly since I merge the battery tree before the chrome-platform
> tree ... Cross tree dependencies are a pain.
> 
>> Anyway, I think the proper way to do it is create an immutable branch for
>> Sebastian as the patch he picked depends on the above commit. I'll create one,
>> sorry about that missing dependency.
> 
> Thanks.
> 
