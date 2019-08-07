Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 867D2C433FF
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 16:25:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CD74222FC
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 16:25:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565195127;
	bh=0YJZhuxybSXfTkrCYn3Xq0KGSSk6fV3f+W6vMNvDpIo=;
	h=Subject:To:References:From:Date:In-Reply-To:List-ID:From;
	b=dhYQVKXM4aysqyfTW2CF3JX2LcDUO3uResl7XXHJUa4fNOga7GNLsxkxB7BCLBQIo
	 wkweU0BbDAFtU1Tz5DTDL+cmQybX+QFLmTFdzZTXhpskoDG4JV+QaTwBjlyFbpBkTi
	 LWdlCzckibyRfM2owKCjCYkNSHv4q2CDeZSjUE6Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388951AbfHGQZ0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 12:25:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:57790 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388872AbfHGQZY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 12:25:24 -0400
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4AFDC21E6C;
        Wed,  7 Aug 2019 16:25:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565195123;
        bh=0YJZhuxybSXfTkrCYn3Xq0KGSSk6fV3f+W6vMNvDpIo=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=xxVnRE5hOwWszr8d7hmgxpcd3U6DLyNPQgnZuXmjWxvAOfLAKRv1FROVRlg75X2Qs
         V+9FBbYiSwf2h0XTQxXhf2vOzEqhj8onXxo4EmV4tR374jNXg+PqUaheXd74f6t1I0
         wWFPCiXzlK4rtKwEbVPxtb4nM13sBmT084HKsMMQ=
Subject: Re: [PATCH v2] selftests: kvm: Adding config fragments
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        linux-kernel@vger.kernel.org, drjones@redhat.com,
        sean.j.christopherson@intel.com, linux-kselftest@vger.kernel.org,
        kvm@vger.kernel.org, shuah <shuah@kernel.org>
References: <20190807135814.12906-1-naresh.kamboju@linaro.org>
 <b6b4f179-1fef-65db-8125-fa60e3627656@kernel.org>
 <769e7d1c-c3d4-278a-d623-3a1366065fb6@redhat.com>
From:   shuah <shuah@kernel.org>
Message-ID: <ace07599-7805-a75f-3af2-b61a5fb4053b@kernel.org>
Date:   Wed, 7 Aug 2019 10:25:22 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <769e7d1c-c3d4-278a-d623-3a1366065fb6@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/7/19 10:19 AM, Paolo Bonzini wrote:
> On 07/08/19 17:52, shuah wrote:
>>
>>
>> On 8/7/19 7:58 AM, Naresh Kamboju wrote:
>>> selftests kvm test cases need pre-required kernel configs for the test
>>> to get pass.
>>>
>>
>> Can you elaborate and add more information on which tests fail without
>> these configs. I am all for adding configs, however I would like to
>> see more information explaining which tests don't pass without this
>> change.
> 
> The KVM tests are skipped without these configs:
> 
>          dev_fd = open(KVM_DEV_PATH, O_RDONLY);
>          if (dev_fd < 0)
>                  exit(KSFT_SKIP);
> 

Thanks Paolo!

This would be great info. to add to the commit log.

thanks,
-- Shuah
