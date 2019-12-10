Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FORGED_MUA_MOZILLA,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19055C2D0BF
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 09:12:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF1C8206E0
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 09:12:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="a0Aqyhqd";
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="D+urQUfn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727039AbfLJJMs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 04:12:48 -0500
Received: from a27-187.smtp-out.us-west-2.amazonses.com ([54.240.27.187]:48098
        "EHLO a27-187.smtp-out.us-west-2.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726915AbfLJJMs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 04:12:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=zsmsymrwgfyinv5wlfyidntwsjeeldzt; d=codeaurora.org; t=1575969167;
        h=Subject:To:References:From:Message-ID:Date:MIME-Version:In-Reply-To:Content-Type:Content-Transfer-Encoding;
        bh=TScBMPq/nDfTHkFDfyWyAehGaHrxqEhpqCA1FJw7BXc=;
        b=a0AqyhqdFlrQxBmWxTaxrTl0BEV+0ewpTnKIpfdrLBtWe1004l7TBDc0DgIUwJhX
        TQnV35idQSvZUMb7C7/rrfJqV8CE6a/9ggb7kk4QiSfzvlpNlcVubTiTKDCASUio2wl
        0+ewklI6kuLNcqiHWRz/BD+EuL54E4deqqR1tDHs=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=gdwg2y3kokkkj5a55z2ilkup5wp5hhxx; d=amazonses.com; t=1575969167;
        h=Subject:To:References:From:Message-ID:Date:MIME-Version:In-Reply-To:Content-Type:Content-Transfer-Encoding:Feedback-ID;
        bh=TScBMPq/nDfTHkFDfyWyAehGaHrxqEhpqCA1FJw7BXc=;
        b=D+urQUfn2K4emL7em/QbbMhu2Vrm9Tx36Ol+U2ZwmLQSQZpINwrf9UE98T2h3TPZ
        DwMKL9j18+Q7YeU5lGJNoBqJjrS/gz2LPe0UNg8C0bV3AAyldDRnfXGOhkiSAH5PdeZ
        OIOCt3bcUwY4thcyDvHQv5OT6A1PGrce9GcPxUFg=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 9B56BC43383
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=mojha@codeaurora.org
Subject: Re: [PATCH 1/3] time/jiffies: Fixes some typo
To:     john.stultz@linaro.org, mingo@kernel.org,
        linux-kernel@vger.kernel.org
References: <1571124603-9334-1-git-send-email-mojha@codeaurora.org>
From:   Mukesh Ojha <mojha@codeaurora.org>
Message-ID: <0101016eef1518c1-29cd20a1-7171-43d5-9f1d-e75048a8ae31-000000@us-west-2.amazonses.com>
Date:   Tue, 10 Dec 2019 09:12:47 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <1571124603-9334-1-git-send-email-mojha@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-SES-Outgoing: 2019.12.10-54.240.27.187
Feedback-ID: 1.us-west-2.CZuq2qbDmUIuT3qdvXlRHZZCpfZqZ4GtG9v3VKgRyF0=:AmazonSES
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Gentle reminder.

On 10/15/2019 1:00 PM, Mukesh Ojha wrote:
> accuratly => accurately
>
> while at it change `clock source` to clocksource to make
> it align with its usage at other places.
>
> Signed-off-by: Mukesh Ojha <mojha@codeaurora.org>
> ---
>   kernel/time/jiffies.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/time/jiffies.c b/kernel/time/jiffies.c
> index d23b434..e7f08f2 100644
> --- a/kernel/time/jiffies.c
> +++ b/kernel/time/jiffies.c
> @@ -39,12 +39,12 @@ static u64 jiffies_read(struct clocksource *cs)
>   
>   /*
>    * The Jiffies based clocksource is the lowest common
> - * denominator clock source which should function on
> + * denominator clocksource which should function on
>    * all systems. It has the same coarse resolution as
>    * the timer interrupt frequency HZ and it suffers
>    * inaccuracies caused by missed or lost timer
>    * interrupts and the inability for the timer
> - * interrupt hardware to accuratly tick at the
> + * interrupt hardware to accurately tick at the
>    * requested HZ value. It is also not recommended
>    * for "tick-less" systems.
>    */
