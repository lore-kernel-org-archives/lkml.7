Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D506CC47404
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 05:32:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4D472133F
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 05:32:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730674AbfJIFc0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 01:32:26 -0400
Received: from mga09.intel.com ([134.134.136.24]:56666 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730451AbfJIFcZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 01:32:25 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Oct 2019 22:32:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,273,1566889200"; 
   d="scan'208";a="197913193"
Received: from shao2-debian.sh.intel.com (HELO [10.239.13.6]) ([10.239.13.6])
  by orsmga006.jf.intel.com with ESMTP; 08 Oct 2019 22:32:23 -0700
Subject: Re: [kbuild-all] Re: [PATCH] lis3lv02d: switch to using input device
 polling mode
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        kbuild test robot <lkp@intel.com>
Cc:     kbuild-all@01.org, Eric Piel <eric.piel@tremplin-utc.net>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
References: <20191002215658.GA134561@dtor-ws>
 <201910030738.k8Pojn6c%lkp@intel.com> <20191002235943.GC20549@dtor-ws>
 <20191003000348.GD20549@dtor-ws>
From:   Rong Chen <rong.a.chen@intel.com>
Message-ID: <2bd8d819-902e-0655-33af-f316a89d957d@intel.com>
Date:   Wed, 9 Oct 2019 13:32:07 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20191003000348.GD20549@dtor-ws>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 10/3/19 8:03 AM, Dmitry Torokhov wrote:
> On Wed, Oct 02, 2019 at 04:59:43PM -0700, Dmitry Torokhov wrote:
>> On Thu, Oct 03, 2019 at 07:30:23AM +0800, kbuild test robot wrote:
>>> Hi Dmitry,
>>>
>>> I love your patch! Yet something to improve:
>>>
>>> [auto build test ERROR on char-misc/char-misc-testing]
>>> [cannot apply to v5.4-rc1 next-20191002]
>> This is weird, I just tried applying it to both next-20191002 and Greg's
>> char-misc/char-misc-testing and it applied cleanly and compiled (on x86).
> You seem to have tried applying it to this commit:
>
> Merge tag 'char-misc-5.4-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc
>
> Pull char/misc driver updates from Greg KH:
>   "Here is the big char/misc driver pull request for 5.4-rc1...
>
> so of it failed because at that time Linus' tree did not have the
> necessary input changes. I am not sure why you decided to apply the
> patch to this particular commit.
>
> Thanks.

Thanks for your comment, robot applied the patch to the head of 
char-misc/char-misc-testing,
It seems the branch was still old at that moment. We'll fix it asap.

Best Regards,
Rong Chen
