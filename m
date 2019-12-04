Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A39C6C43603
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 17:35:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 727E8207DD
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 17:35:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728010AbfLDRfz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 12:35:55 -0500
Received: from foss.arm.com ([217.140.110.172]:59472 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726934AbfLDRfz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 12:35:55 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 821D331B;
        Wed,  4 Dec 2019 09:35:54 -0800 (PST)
Received: from [10.1.194.37] (e113632-lin.cambridge.arm.com [10.1.194.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 62F153F52E;
        Wed,  4 Dec 2019 09:35:53 -0800 (PST)
Subject: Re: [PATCH v2 1/4] sched/uclamp: Make uclamp_util_*() helpers use and
 return UL values
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Patrick Bellasi <patrick.bellasi@matbug.net>,
        Quentin Perret <qperret@google.com>,
        Qais Yousef <qais.yousef@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>
References: <20191203155907.2086-1-valentin.schneider@arm.com>
 <20191203155907.2086-2-valentin.schneider@arm.com>
 <CAKfTPtC-9nxGCAq8ck0Av6zuqCySvO87oP4hhBE=qKL3gxu+ow@mail.gmail.com>
 <7d6d959d-3767-1a12-4c80-e7d52a48c396@arm.com>
 <CAKfTPtA3ZLkNn4BEDctLo6VxvgHv_cvQSFx5N_+ERGToa+3FLg@mail.gmail.com>
 <2a244463-8010-ccf4-dc33-80831265ba9a@arm.com>
 <CAKfTPtDg2_Yc98o9SpUjm-qZw3bQ8d_zFJ9PL31EnFy2u_4_mA@mail.gmail.com>
From:   Valentin Schneider <valentin.schneider@arm.com>
Message-ID: <cedfd76c-0fc9-75ff-aac1-ecdf4b473f67@arm.com>
Date:   Wed, 4 Dec 2019 17:35:52 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CAKfTPtDg2_Yc98o9SpUjm-qZw3bQ8d_zFJ9PL31EnFy2u_4_mA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/12/2019 17:29, Vincent Guittot wrote:
>> True. I'm not too hot on having to handle rq clamp values
>> (rq->uclamp[x].value) and task clamp values (uclamp_eff_value())
>> differently (cast one but not the other), but I don't feel *too* strongly
>> about this, so if you want I can do that change for v3.
> 
> Yes please. This makes the code easier to read and understand.
> 

Will do.

> The rest of the patch series looks good to me. So feel free to add my
> reviewed by on the next version
> Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>> 

Thanks!
