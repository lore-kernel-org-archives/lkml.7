Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B0AEC10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 17:28:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0724620659
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 17:28:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726291AbfJJR2j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 13:28:39 -0400
Received: from foss.arm.com ([217.140.110.172]:36680 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725862AbfJJR2i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 13:28:38 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AA45628;
        Thu, 10 Oct 2019 10:28:37 -0700 (PDT)
Received: from [10.1.194.37] (e113632-lin.cambridge.arm.com [10.1.194.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 545A83F71A;
        Thu, 10 Oct 2019 10:28:37 -0700 (PDT)
Subject: Re: Question about sched_prio_to_weight values
To:     Francesco Poli <invernomuto@paranoici.org>,
        linux-kernel@vger.kernel.org
References: <20191007003205.8888ac99da2dd732b6198387@paranoici.org>
 <506d5ee6-246a-a03d-ea11-227ff4de1467@arm.com>
 <20191007224143.d21abae57a3f32ac60afd53c@paranoici.org>
From:   Valentin Schneider <valentin.schneider@arm.com>
Message-ID: <21c11aca-e531-7d72-9a70-f52c12d5d408@arm.com>
Date:   Thu, 10 Oct 2019 18:28:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191007224143.d21abae57a3f32ac60afd53c@paranoici.org>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/10/2019 21:41, Francesco Poli wrote:
> The differences are probably due to the different precision
> of the computations: I don't know the precision of those originally
> carried out by Ingo Molnar (single precision? double?), but calc(1)
> is an arbitrary precision calculator and, by default, performs
> calculations with epsilon = 1e-20 !
> 
> Please note that, except for the first one, all the differing
> values obtained with the calc(1) script have slightly better
> errors than the ones found in kernel/sched/core.c ...
> 

As always patches are welcome, but I don't know how much there is to gain
from a tiny error correction in those factors.

Out of curiosity, what led you to stare at those numbers?

> 
> Thanks again for the clarification!
> Bye.
> 
