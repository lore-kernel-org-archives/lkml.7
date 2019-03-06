Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D92AAC43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 20:03:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E72F20661
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 20:03:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (4096-bit key) header.d=wiesinger.com header.i=@wiesinger.com header.b="siPWQoZG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730945AbfCFUDK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 15:03:10 -0500
Received: from vps01.wiesinger.com ([46.36.37.179]:51294 "EHLO
        vps01.wiesinger.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726233AbfCFUDK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 15:03:10 -0500
Received: from wiesinger.com (wiesinger.com [84.113.44.87])
        by vps01.wiesinger.com (Postfix) with ESMTPS id 4F1FF9F318;
        Wed,  6 Mar 2019 21:03:05 +0100 (CET)
Received: from [192.168.0.14] ([192.168.0.14])
        (authenticated bits=0)
        by wiesinger.com (8.15.2/8.15.2) with ESMTPSA id x26K30w9014229
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 6 Mar 2019 21:03:02 +0100
DKIM-Filter: OpenDKIM Filter v2.11.0 wiesinger.com x26K30w9014229
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiesinger.com;
        s=default; t=1551902583;
        bh=j90UGS9eT/w6p4TIFU64M5KL0xqaPSoeGWmXmpq5sQE=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=siPWQoZGlVsNJx+7ayYT+22g6kezU20TQ8psrdU0jpkWkAl4eJ439FNt5OJLeodN/
         2iMpcNbMhxEAbFDbW1nBIHcM0V1SYcJnf7RnA747QfGb/HTyblz7CVooAgPzhU1w0r
         b4ZYOyzyKKd1e+tucYD9jG/qivAtMD9L0H93bJ7f8o+0Ic02vYCV1wHfT+WNQ9BOy9
         WdeHL32oszEOl2D8EFb0SFHpyNtFWSRvTeCW6e2w3e3pTSc9S3uqIykHyKGV3BeU0l
         l2fia6p7qB/LA138Hw8QNlFmt3NUAhi7Ta9//EEtYG4DWWc/XsU9nCaKJ0KIJxy7/y
         z3oUfGCkh9toaCi0SF42+xp3h+ZfdvWxGKyQ33Sl44OSWa8sXzNKfatrAftDnw1jk1
         XOZBFtvOyvI4gx5MvFRWAojkYeApdHJvRrR59b61duft818Y86WDfNcQAdhHqbMjcL
         0C0W7WPANhByUHp78gvAEVTIhJGhp9z4eiu11KSDdKVRdyHLmmma/EYFzQ72PlUw/A
         bL9DE0OS91TCWJPF3SW7DdGfMHo/ZSIqn/fv+NwP3ZGhyIPQkMPcVvX3Gf8/6R5332
         tzkDyWn86dsQRHA3uUJQAnZgYwkY/SuiVkOu16n59qWKs1IntMPSLG5FSwwhnXcaDf
         loqaaH65z7Hm8yVndi9557jQ=
Subject: Re: Banana Pi-R1 stabil
To:     Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     arm@lists.fedoraproject.org, Chen-Yu Tsai <wens@csie.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>, filbar@centrum.cz
References: <7b20af72-76ea-a7b1-9939-ca378dc0ed83@wiesinger.com>
 <20190227092023.nvr34byfjranujfm@flea>
 <5f63a2c6-abcb-736f-d382-18e8cea31b65@wiesinger.com>
 <20190228093516.abual3564dkvx6un@flea>
 <91c22ba4-39eb-dd3d-29bd-1bfa7a45e9cd@wiesinger.com>
 <20190301093038.oz56z22ivpntdcfw@flea>
 <8ad8fbeb-fad8-d39a-9cc6-e7f1deab0b4f@wiesinger.com>
 <20190305092830.ef45kxzhdnxlh63g@flea>
 <9f189569-bf76-22d2-3bf7-db710f616998@wiesinger.com>
 <20190306073605.modlx4yhdzbg7sfz@flea>
From:   Gerhard Wiesinger <lists@wiesinger.com>
Message-ID: <34300c49-fe89-77cb-444a-f6de02d41a62@wiesinger.com>
Date:   Wed, 6 Mar 2019 21:03:00 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.3
MIME-Version: 1.0
In-Reply-To: <20190306073605.modlx4yhdzbg7sfz@flea>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06.03.2019 08:36, Maxime Ripard wrote:
>
>> Yes, there might at least 2 scenarios:
>>
>> 1.) Frequency switching itself is the problem
> But that code is also the one being used by the BananaPro, which you
> reported as stable.


Yes, BananaPro is stable (with exactly same configuration as far as I 
know) ....


>
>> 2.) lower frequency/voltage operating points are not stable.
>>
>> For both scenarios: it might be possible that the crash happens on idle CPU,
>> high CPU load or just randomly. Therefore just "waiting" might be better
>> than 100% CPU utilization.But will test also 100% CPU.
>>
>> Therefore it would be good to see where the voltages for different
>> frequencies for the SoC are defined (to compare).
> In the device tree.
>
>> I'm currently testing 2 different settings on the 2 new Banana Pi R1 with
>> newest kernel (see below), so 2 static frequencies:
>>
>> # Set to specific frequency 144000 (currently testing on Banana Pi R1 #1)
>>
>> # Set to specific frequency 312000 (currently testing on Banana Pi R1 #2)
>>
>> If that's fine I'll test also further frequencies (with different loads).
> Look, you can come up with whatever program you want for this, but if
> I insist on running that cpustress program (for the 4th time now), is
> that it's actually good at it and caught all the cpufreq issues we've
> seen so far.

As I wrote, I run several stress tests also with the program you 
mention. But test combination require a minimum testing time to get 
verifiable results.

The combinations are:

- idle cpu vs. 100% CPU

- on demand governor vs. several fixed frequencies.


So far stable testing conditions for idle CPU and 100% CPU with command 
line below and cpuburn-a7 program:
# Set to max performance (stable)=> frequency 960000
# Set to specific frequency 144000 (stable)
# Set to specific frequency 312000 (stable)

TODO list to test with "idle" CPU and 100% CPU:
# Set to specific frequency 528000 (next step tested)
# Set to specific frequency 720000 (next step tested)
# Set to specific frequency 864000
# Set to specific frequency 912000
# Set to ondemand

My guess is (but it is just a guess which has to be verified):

- stable in all fixed frequencies in idle CPU and 100% CPU condition as 
well as on demand and 100% CPU

- not stable with ondemand and "idle" CPU (so real frequency switching 
will happen often)


>
> Feel free to not trust me on this, but I'm not sure how the discussion
> can continue if you do.
>
You missed my point from my previous mail: "But will test also 100% 
CPU.". See command line below.


Ciao,

Gerhard


Test script:

while true; do echo "========================================"; echo -n 
"CPU_FREQ0: "; cat 
/sys/devices/system/cpu/cpu0/cpufreq/cpuinfo_cur_freq; echo -n 
"CPU_FREQ1: "; cat 
/sys/devices/system/cpu/cpu1/cpufreq/cpuinfo_cur_freq; sleep 1; done& 
./stress/cpuburn-a7




