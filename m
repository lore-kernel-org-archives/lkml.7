Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7287AC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 09:45:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 471E42147C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 09:45:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726409AbfCLJpx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 05:45:53 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:39574 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725873AbfCLJpx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 05:45:53 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 88A9CA78;
        Tue, 12 Mar 2019 02:45:52 -0700 (PDT)
Received: from [10.1.194.37] (e113632-lin.cambridge.arm.com [10.1.194.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BD0A03F59C;
        Tue, 12 Mar 2019 02:45:51 -0700 (PDT)
Subject: Re: [PATCH 14/14] xtensa: entry: Remove unneeded need_resched() loop
To:     Max Filippov <jcmvbkbc@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Chris Zankel <chris@zankel.net>, linux-xtensa@linux-xtensa.org
References: <20190311224752.8337-1-valentin.schneider@arm.com>
 <20190311224752.8337-15-valentin.schneider@arm.com>
 <CAMo8Bf+iet+hQ2cbb5TjmYgUkuSAT=2VghyPs+jwttUqoHuZvQ@mail.gmail.com>
From:   Valentin Schneider <valentin.schneider@arm.com>
Message-ID: <92acf470-0a57-29c4-a8b4-8d8e400a08d7@arm.com>
Date:   Tue, 12 Mar 2019 09:45:50 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <CAMo8Bf+iet+hQ2cbb5TjmYgUkuSAT=2VghyPs+jwttUqoHuZvQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/03/2019 01:10, Max Filippov wrote:
[...]
> 
> Acked-by: Max Filippov <jcmvbkbc@gmail.com>
> 

Thanks!
