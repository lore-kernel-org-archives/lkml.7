Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C9A9C282E1
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 11:25:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 175902084B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 11:25:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727113AbfDYLZF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 07:25:05 -0400
Received: from ns.iliad.fr ([212.27.33.1]:48474 "EHLO ns.iliad.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726088AbfDYLZE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 07:25:04 -0400
Received: from ns.iliad.fr (localhost [127.0.0.1])
        by ns.iliad.fr (Postfix) with ESMTP id 125CE204DF;
        Thu, 25 Apr 2019 13:25:01 +0200 (CEST)
Received: from [192.168.108.49] (freebox.vlq16.iliad.fr [213.36.7.13])
        by ns.iliad.fr (Postfix) with ESMTP id EC57E20564;
        Thu, 25 Apr 2019 13:25:00 +0200 (CEST)
Subject: Re: [PATCH v2 00/13] qcom: dts: thermal cleanups
To:     Amit Kucheria <amit.kucheria@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        MSM <linux-arm-msm@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Sibi Sankar <sibis@codeaurora.org>
References: <cover.1553853990.git.amit.kucheria@linaro.org>
 <5583cae1-8fea-724a-24a4-59b38a205ac3@free.fr>
 <CAP245DUNo02QUkGDPFfzow9535GKO9x6ZusETRjEgTmnHL4D2g@mail.gmail.com>
 <842b06c6-15b2-7ba6-702e-c8b043d390a6@free.fr>
 <CAP245DVqGQ6MEfcYjr2PYnD=BR86vC=BsRMpZe0jsgbAc6jFGg@mail.gmail.com>
 <903fa0a6-5c40-97b4-1c01-fd84f3e51c62@free.fr>
 <8e53ea22-d248-8c63-bcda-15b502eb9699@free.fr>
 <CAHLCerPj6MQ0LeqUHM_91NOW1cP0z75DD7oBnR7Q3-8rpCmnww@mail.gmail.com>
From:   Marc Gonzalez <marc.w.gonzalez@free.fr>
Message-ID: <fa265928-d858-80e8-5055-5605fc39fe33@free.fr>
Date:   Thu, 25 Apr 2019 13:25:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAHLCerPj6MQ0LeqUHM_91NOW1cP0z75DD7oBnR7Q3-8rpCmnww@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: ClamAV using ClamSMTP ; ns.iliad.fr ; Thu Apr 25 13:25:01 2019 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/04/2019 08:31, Amit Kucheria wrote:

> Andy, patches 1 and 2 fix problems that already exist upstream. They
> were not introduced by my series.

On IRC, you wrote: "can you send me the same output against mainline
(or linux-next) w/o my patches applied?"

$ git show 58ad5ab73152
commit 58ad5ab731521a80a848033512467675de06b1f2
Merge: 596a434369f6 10518bb15940
Author: Andy Gross <agross@kernel.org>
Date:   Tue Apr 9 23:08:50 2019 -0500

    Merge branch 'arm64-thermal-for-5.2' into arm64-for-5.2

$ git revert -m 1 58ad5ab73152


Below, I only see an error when reading /sys/class/thermal/thermal_zone9/temp
(/sys/class/thermal/thermal_zone9/type = pm8998)


# for F in $(find /sys/class/thermal/thermal_zone?/ /sys/class/thermal/thermal_zone??/ -type f); do echo $F; cat $F; done
/sys/class/thermal/thermal_zone0/uevent
/sys/class/thermal/thermal_zone0/trip_point_0_hyst
2000
/sys/class/thermal/thermal_zone0/mode
enabled
/sys/class/thermal/thermal_zone0/power/runtime_active_time
0
/sys/class/thermal/thermal_zone0/power/runtime_status
unsupported
/sys/class/thermal/thermal_zone0/power/autosuspend_delay_ms
cat: read error: Input/output error
/sys/class/thermal/thermal_zone0/power/runtime_suspended_time
0
/sys/class/thermal/thermal_zone0/power/control
auto
/sys/class/thermal/thermal_zone0/available_policies
step_wise
/sys/class/thermal/thermal_zone0/policy
step_wise
/sys/class/thermal/thermal_zone0/trip_point_1_type
critical
/sys/class/thermal/thermal_zone0/k_d
0
/sys/class/thermal/thermal_zone0/sustainable_power
0
/sys/class/thermal/thermal_zone0/type
cpu-thermal0
/sys/class/thermal/thermal_zone0/offset
0
/sys/class/thermal/thermal_zone0/slope
1
/sys/class/thermal/thermal_zone0/trip_point_0_type
passive
/sys/class/thermal/thermal_zone0/k_po
0
/sys/class/thermal/thermal_zone0/integral_cutoff
0
/sys/class/thermal/thermal_zone0/k_i
0
/sys/class/thermal/thermal_zone0/trip_point_1_temp
110000
/sys/class/thermal/thermal_zone0/k_pu
0
/sys/class/thermal/thermal_zone0/temp
31000
/sys/class/thermal/thermal_zone0/trip_point_1_hyst
2000
/sys/class/thermal/thermal_zone0/trip_point_0_temp
75000
/sys/class/thermal/thermal_zone1/uevent
/sys/class/thermal/thermal_zone1/trip_point_0_hyst
2000
/sys/class/thermal/thermal_zone1/mode
enabled
/sys/class/thermal/thermal_zone1/power/runtime_active_time
0
/sys/class/thermal/thermal_zone1/power/runtime_status
unsupported
/sys/class/thermal/thermal_zone1/power/autosuspend_delay_ms
cat: read error: Input/output error
/sys/class/thermal/thermal_zone1/power/runtime_suspended_time
0
/sys/class/thermal/thermal_zone1/power/control
auto
/sys/class/thermal/thermal_zone1/available_policies
step_wise
/sys/class/thermal/thermal_zone1/policy
step_wise
/sys/class/thermal/thermal_zone1/trip_point_1_type
critical
/sys/class/thermal/thermal_zone1/k_d
0
/sys/class/thermal/thermal_zone1/sustainable_power
0
/sys/class/thermal/thermal_zone1/type
cpu-thermal1
/sys/class/thermal/thermal_zone1/offset
0
/sys/class/thermal/thermal_zone1/slope
1
/sys/class/thermal/thermal_zone1/trip_point_0_type
passive
/sys/class/thermal/thermal_zone1/k_po
0
/sys/class/thermal/thermal_zone1/integral_cutoff
0
/sys/class/thermal/thermal_zone1/k_i
0
/sys/class/thermal/thermal_zone1/trip_point_1_temp
110000
/sys/class/thermal/thermal_zone1/k_pu
0
/sys/class/thermal/thermal_zone1/temp
32000
/sys/class/thermal/thermal_zone1/trip_point_1_hyst
2000
/sys/class/thermal/thermal_zone1/trip_point_0_temp
75000
/sys/class/thermal/thermal_zone2/uevent
/sys/class/thermal/thermal_zone2/trip_point_0_hyst
2000
/sys/class/thermal/thermal_zone2/mode
enabled
/sys/class/thermal/thermal_zone2/power/runtime_active_time
0
/sys/class/thermal/thermal_zone2/power/runtime_status
unsupported
/sys/class/thermal/thermal_zone2/power/autosuspend_delay_ms
cat: read error: Input/output error
/sys/class/thermal/thermal_zone2/power/runtime_suspended_time
0
/sys/class/thermal/thermal_zone2/power/control
auto
/sys/class/thermal/thermal_zone2/available_policies
step_wise
/sys/class/thermal/thermal_zone2/policy
step_wise
/sys/class/thermal/thermal_zone2/trip_point_1_type
critical
/sys/class/thermal/thermal_zone2/k_d
0
/sys/class/thermal/thermal_zone2/sustainable_power
0
/sys/class/thermal/thermal_zone2/type
cpu-thermal2
/sys/class/thermal/thermal_zone2/offset
0
/sys/class/thermal/thermal_zone2/slope
1
/sys/class/thermal/thermal_zone2/trip_point_0_type
passive
/sys/class/thermal/thermal_zone2/k_po
0
/sys/class/thermal/thermal_zone2/integral_cutoff
0
/sys/class/thermal/thermal_zone2/k_i
0
/sys/class/thermal/thermal_zone2/trip_point_1_temp
110000
/sys/class/thermal/thermal_zone2/k_pu
0
/sys/class/thermal/thermal_zone2/temp
30700
/sys/class/thermal/thermal_zone2/trip_point_1_hyst
2000
/sys/class/thermal/thermal_zone2/trip_point_0_temp
75000
/sys/class/thermal/thermal_zone3/uevent
/sys/class/thermal/thermal_zone3/trip_point_0_hyst
2000
/sys/class/thermal/thermal_zone3/mode
enabled
/sys/class/thermal/thermal_zone3/power/runtime_active_time
0
/sys/class/thermal/thermal_zone3/power/runtime_status
unsupported
/sys/class/thermal/thermal_zone3/power/autosuspend_delay_ms
cat: read error: Input/output error
/sys/class/thermal/thermal_zone3/power/runtime_suspended_time
0
/sys/class/thermal/thermal_zone3/power/control
auto
/sys/class/thermal/thermal_zone3/available_policies
step_wise
/sys/class/thermal/thermal_zone3/policy
step_wise
/sys/class/thermal/thermal_zone3/trip_point_1_type
critical
/sys/class/thermal/thermal_zone3/k_d
0
/sys/class/thermal/thermal_zone3/sustainable_power
0
/sys/class/thermal/thermal_zone3/type
cpu-thermal3
/sys/class/thermal/thermal_zone3/offset
0
/sys/class/thermal/thermal_zone3/slope
1
/sys/class/thermal/thermal_zone3/trip_point_0_type
passive
/sys/class/thermal/thermal_zone3/k_po
0
/sys/class/thermal/thermal_zone3/integral_cutoff
0
/sys/class/thermal/thermal_zone3/k_i
0
/sys/class/thermal/thermal_zone3/trip_point_1_temp
110000
/sys/class/thermal/thermal_zone3/k_pu
0
/sys/class/thermal/thermal_zone3/temp
31000
/sys/class/thermal/thermal_zone3/trip_point_1_hyst
2000
/sys/class/thermal/thermal_zone3/trip_point_0_temp
75000
/sys/class/thermal/thermal_zone4/uevent
/sys/class/thermal/thermal_zone4/trip_point_0_hyst
2000
/sys/class/thermal/thermal_zone4/mode
enabled
/sys/class/thermal/thermal_zone4/power/runtime_active_time
0
/sys/class/thermal/thermal_zone4/power/runtime_status
unsupported
/sys/class/thermal/thermal_zone4/power/autosuspend_delay_ms
cat: read error: Input/output error
/sys/class/thermal/thermal_zone4/power/runtime_suspended_time
0
/sys/class/thermal/thermal_zone4/power/control
auto
/sys/class/thermal/thermal_zone4/available_policies
step_wise
/sys/class/thermal/thermal_zone4/policy
step_wise
/sys/class/thermal/thermal_zone4/trip_point_1_type
critical
/sys/class/thermal/thermal_zone4/k_d
0
/sys/class/thermal/thermal_zone4/sustainable_power
0
/sys/class/thermal/thermal_zone4/type
cpu-thermal4
/sys/class/thermal/thermal_zone4/offset
0
/sys/class/thermal/thermal_zone4/slope
1
/sys/class/thermal/thermal_zone4/trip_point_0_type
passive
/sys/class/thermal/thermal_zone4/k_po
0
/sys/class/thermal/thermal_zone4/integral_cutoff
0
/sys/class/thermal/thermal_zone4/k_i
0
/sys/class/thermal/thermal_zone4/trip_point_1_temp
110000
/sys/class/thermal/thermal_zone4/k_pu
0
/sys/class/thermal/thermal_zone4/temp
32000
/sys/class/thermal/thermal_zone4/trip_point_1_hyst
2000
/sys/class/thermal/thermal_zone4/trip_point_0_temp
75000
/sys/class/thermal/thermal_zone5/uevent
/sys/class/thermal/thermal_zone5/trip_point_0_hyst
2000
/sys/class/thermal/thermal_zone5/mode
enabled
/sys/class/thermal/thermal_zone5/power/runtime_active_time
0
/sys/class/thermal/thermal_zone5/power/runtime_status
unsupported
/sys/class/thermal/thermal_zone5/power/autosuspend_delay_ms
cat: read error: Input/output error
/sys/class/thermal/thermal_zone5/power/runtime_suspended_time
0
/sys/class/thermal/thermal_zone5/power/control
auto
/sys/class/thermal/thermal_zone5/available_policies
step_wise
/sys/class/thermal/thermal_zone5/policy
step_wise
/sys/class/thermal/thermal_zone5/trip_point_1_type
critical
/sys/class/thermal/thermal_zone5/k_d
0
/sys/class/thermal/thermal_zone5/sustainable_power
0
/sys/class/thermal/thermal_zone5/type
cpu-thermal5
/sys/class/thermal/thermal_zone5/offset
0
/sys/class/thermal/thermal_zone5/slope
1
/sys/class/thermal/thermal_zone5/trip_point_0_type
passive
/sys/class/thermal/thermal_zone5/k_po
0
/sys/class/thermal/thermal_zone5/integral_cutoff
0
/sys/class/thermal/thermal_zone5/k_i
0
/sys/class/thermal/thermal_zone5/trip_point_1_temp
110000
/sys/class/thermal/thermal_zone5/k_pu
0
/sys/class/thermal/thermal_zone5/temp
30400
/sys/class/thermal/thermal_zone5/trip_point_1_hyst
2000
/sys/class/thermal/thermal_zone5/trip_point_0_temp
75000
/sys/class/thermal/thermal_zone6/uevent
/sys/class/thermal/thermal_zone6/trip_point_0_hyst
2000
/sys/class/thermal/thermal_zone6/mode
enabled
/sys/class/thermal/thermal_zone6/power/runtime_active_time
0
/sys/class/thermal/thermal_zone6/power/runtime_status
unsupported
/sys/class/thermal/thermal_zone6/power/autosuspend_delay_ms
cat: read error: Input/output error
/sys/class/thermal/thermal_zone6/power/runtime_suspended_time
0
/sys/class/thermal/thermal_zone6/power/control
auto
/sys/class/thermal/thermal_zone6/available_policies
step_wise
/sys/class/thermal/thermal_zone6/policy
step_wise
/sys/class/thermal/thermal_zone6/trip_point_1_type
critical
/sys/class/thermal/thermal_zone6/k_d
0
/sys/class/thermal/thermal_zone6/sustainable_power
0
/sys/class/thermal/thermal_zone6/type
cpu-thermal6
/sys/class/thermal/thermal_zone6/offset
0
/sys/class/thermal/thermal_zone6/slope
1
/sys/class/thermal/thermal_zone6/trip_point_0_type
passive
/sys/class/thermal/thermal_zone6/k_po
0
/sys/class/thermal/thermal_zone6/integral_cutoff
0
/sys/class/thermal/thermal_zone6/k_i
0
/sys/class/thermal/thermal_zone6/trip_point_1_temp
110000
/sys/class/thermal/thermal_zone6/k_pu
0
/sys/class/thermal/thermal_zone6/temp
31200
/sys/class/thermal/thermal_zone6/trip_point_1_hyst
2000
/sys/class/thermal/thermal_zone6/trip_point_0_temp
75000
/sys/class/thermal/thermal_zone7/uevent
/sys/class/thermal/thermal_zone7/trip_point_0_hyst
2000
/sys/class/thermal/thermal_zone7/mode
enabled
/sys/class/thermal/thermal_zone7/power/runtime_active_time
0
/sys/class/thermal/thermal_zone7/power/runtime_status
unsupported
/sys/class/thermal/thermal_zone7/power/autosuspend_delay_ms
cat: read error: Input/output error
/sys/class/thermal/thermal_zone7/power/runtime_suspended_time
0
/sys/class/thermal/thermal_zone7/power/control
auto
/sys/class/thermal/thermal_zone7/available_policies
step_wise
/sys/class/thermal/thermal_zone7/policy
step_wise
/sys/class/thermal/thermal_zone7/trip_point_1_type
critical
/sys/class/thermal/thermal_zone7/k_d
0
/sys/class/thermal/thermal_zone7/sustainable_power
0
/sys/class/thermal/thermal_zone7/type
cpu-thermal7
/sys/class/thermal/thermal_zone7/offset
0
/sys/class/thermal/thermal_zone7/slope
1
/sys/class/thermal/thermal_zone7/trip_point_0_type
passive
/sys/class/thermal/thermal_zone7/k_po
0
/sys/class/thermal/thermal_zone7/integral_cutoff
0
/sys/class/thermal/thermal_zone7/k_i
0
/sys/class/thermal/thermal_zone7/trip_point_1_temp
110000
/sys/class/thermal/thermal_zone7/k_pu
0
/sys/class/thermal/thermal_zone7/temp
30600
/sys/class/thermal/thermal_zone7/trip_point_1_hyst
2000
/sys/class/thermal/thermal_zone7/trip_point_0_temp
75000
/sys/class/thermal/thermal_zone8/uevent
/sys/class/thermal/thermal_zone8/passive
0
/sys/class/thermal/thermal_zone8/mode
enabled
/sys/class/thermal/thermal_zone8/power/runtime_active_time
0
/sys/class/thermal/thermal_zone8/power/runtime_status
unsupported
/sys/class/thermal/thermal_zone8/power/autosuspend_delay_ms
cat: read error: Input/output error
/sys/class/thermal/thermal_zone8/power/runtime_suspended_time
0
/sys/class/thermal/thermal_zone8/power/control
auto
/sys/class/thermal/thermal_zone8/available_policies
step_wise
/sys/class/thermal/thermal_zone8/policy
step_wise
/sys/class/thermal/thermal_zone8/k_d
0
/sys/class/thermal/thermal_zone8/sustainable_power
0
/sys/class/thermal/thermal_zone8/type
gpu-thermal
/sys/class/thermal/thermal_zone8/offset
0
/sys/class/thermal/thermal_zone8/slope
1
/sys/class/thermal/thermal_zone8/k_po
0
/sys/class/thermal/thermal_zone8/integral_cutoff
0
/sys/class/thermal/thermal_zone8/k_i
0
/sys/class/thermal/thermal_zone8/k_pu
0
/sys/class/thermal/thermal_zone8/temp
30600
/sys/class/thermal/thermal_zone9/uevent
/sys/class/thermal/thermal_zone9/trip_point_0_hyst
2000
/sys/class/thermal/thermal_zone9/mode
disabled
/sys/class/thermal/thermal_zone9/power/runtime_active_time
0
/sys/class/thermal/thermal_zone9/power/runtime_status
unsupported
/sys/class/thermal/thermal_zone9/power/autosuspend_delay_ms
cat: read error: Input/output error
/sys/class/thermal/thermal_zone9/power/runtime_suspended_time
0
/sys/class/thermal/thermal_zone9/power/control
auto
/sys/class/thermal/thermal_zone9/available_policies
step_wise
/sys/class/thermal/thermal_zone9/policy
step_wise
/sys/class/thermal/thermal_zone9/trip_point_1_type
critical
/sys/class/thermal/thermal_zone9/k_d
0
/sys/class/thermal/thermal_zone9/sustainable_power
0
/sys/class/thermal/thermal_zone9/type
pm8998
/sys/class/thermal/thermal_zone9/offset
0
/sys/class/thermal/thermal_zone9/slope
1
/sys/class/thermal/thermal_zone9/trip_point_0_type
passive
/sys/class/thermal/thermal_zone9/k_po
0
/sys/class/thermal/thermal_zone9/integral_cutoff
0
/sys/class/thermal/thermal_zone9/k_i
0
/sys/class/thermal/thermal_zone9/trip_point_1_temp
125000
/sys/class/thermal/thermal_zone9/k_pu
0
/sys/class/thermal/thermal_zone9/temp
cat: read error: Invalid argument
/sys/class/thermal/thermal_zone9/trip_point_1_hyst
2000
/sys/class/thermal/thermal_zone9/trip_point_0_temp
105000
/sys/class/thermal/thermal_zone10/uevent
/sys/class/thermal/thermal_zone10/trip_point_0_hyst
2000
/sys/class/thermal/thermal_zone10/passive
0
/sys/class/thermal/thermal_zone10/mode
enabled
/sys/class/thermal/thermal_zone10/power/runtime_active_time
0
/sys/class/thermal/thermal_zone10/power/runtime_status
unsupported
/sys/class/thermal/thermal_zone10/power/autosuspend_delay_ms
cat: read error: Input/output error
/sys/class/thermal/thermal_zone10/power/runtime_suspended_time
0
/sys/class/thermal/thermal_zone10/power/control
auto
/sys/class/thermal/thermal_zone10/available_policies
step_wise
/sys/class/thermal/thermal_zone10/policy
step_wise
/sys/class/thermal/thermal_zone10/k_d
0
/sys/class/thermal/thermal_zone10/sustainable_power
0
/sys/class/thermal/thermal_zone10/type
battery-thermal
/sys/class/thermal/thermal_zone10/offset
0
/sys/class/thermal/thermal_zone10/slope
1
/sys/class/thermal/thermal_zone10/trip_point_0_type
critical
/sys/class/thermal/thermal_zone10/k_po
0
/sys/class/thermal/thermal_zone10/integral_cutoff
0
/sys/class/thermal/thermal_zone10/k_i
0
/sys/class/thermal/thermal_zone10/k_pu
0
/sys/class/thermal/thermal_zone10/temp
32300
/sys/class/thermal/thermal_zone10/trip_point_0_temp
60000
/sys/class/thermal/thermal_zone11/uevent
/sys/class/thermal/thermal_zone11/trip_point_0_hyst
2000
/sys/class/thermal/thermal_zone11/mode
enabled
/sys/class/thermal/thermal_zone11/power/runtime_active_time
0
/sys/class/thermal/thermal_zone11/power/runtime_status
unsupported
/sys/class/thermal/thermal_zone11/power/autosuspend_delay_ms
cat: read error: Input/output error
/sys/class/thermal/thermal_zone11/power/runtime_suspended_time
0
/sys/class/thermal/thermal_zone11/power/control
auto
/sys/class/thermal/thermal_zone11/available_policies
step_wise
/sys/class/thermal/thermal_zone11/policy
step_wise
/sys/class/thermal/thermal_zone11/trip_point_1_type
critical
/sys/class/thermal/thermal_zone11/k_d
0
/sys/class/thermal/thermal_zone11/sustainable_power
0
/sys/class/thermal/thermal_zone11/type
skin-thermal
/sys/class/thermal/thermal_zone11/offset
0
/sys/class/thermal/thermal_zone11/slope
1
/sys/class/thermal/thermal_zone11/trip_point_0_type
passive
/sys/class/thermal/thermal_zone11/k_po
0
/sys/class/thermal/thermal_zone11/integral_cutoff
0
/sys/class/thermal/thermal_zone11/k_i
0
/sys/class/thermal/thermal_zone11/trip_point_1_temp
70000
/sys/class/thermal/thermal_zone11/k_pu
0
/sys/class/thermal/thermal_zone11/temp
29900
/sys/class/thermal/thermal_zone11/trip_point_1_hyst
2000
/sys/class/thermal/thermal_zone11/trip_point_0_temp
44000
