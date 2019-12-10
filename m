Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FORGED_MUA_MOZILLA,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D44AC2D0BF
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 09:09:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 240DD206E0
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 09:09:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="V736SuRI";
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="cRXaBDx9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727061AbfLJJJf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 04:09:35 -0500
Received: from a27-55.smtp-out.us-west-2.amazonses.com ([54.240.27.55]:60198
        "EHLO a27-55.smtp-out.us-west-2.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726884AbfLJJJe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 04:09:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=zsmsymrwgfyinv5wlfyidntwsjeeldzt; d=codeaurora.org; t=1575968974;
        h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:In-Reply-To:Content-Type:Content-Transfer-Encoding;
        bh=jZtRy3nkw9hulo7Hgdc4O28iEL1V/IFsOJ1tRSh1ams=;
        b=V736SuRIJNv12QDvfV/LNK8xSxuAxjxbfhrY0au7zOv+PwitvoU4B81Fpq1E4ISB
        /Phmhr4bVT24e8lwXax62eRlc9lnsiK4AWEUvUK5gnPyC0ksotINUTyWpE/i6RAPwrf
        6nBRAAn2UzqSRufjjB8OukqfbsayRbBPaWSmDbB8=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=gdwg2y3kokkkj5a55z2ilkup5wp5hhxx; d=amazonses.com; t=1575968974;
        h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:In-Reply-To:Content-Type:Content-Transfer-Encoding:Feedback-ID;
        bh=jZtRy3nkw9hulo7Hgdc4O28iEL1V/IFsOJ1tRSh1ams=;
        b=cRXaBDx9eSHLTwDjM535Z55ZMNmwzIz4IfAfQ7OFjaLQ/Hq66jOWs+4yftNz9ayU
        dbmupj3H4qoEdn3IDE4J2sNTu6Nw/8rAF4hnXYUKu3yy+4OPsq+XGJEEcJrQ+QhdTeh
        oMlQLiNQ9sBJGdhgvcQVXFUc8nbUreNXD8CC7aYo=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3BD8BC433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=mojha@codeaurora.org
Subject: Re: [PATCH] seqlock: Minor comment correction
To:     linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, mingo@redhat.com, will@kernel.org
References: <1570181084-4455-1-git-send-email-mojha@codeaurora.org>
From:   Mukesh Ojha <mojha@codeaurora.org>
Message-ID: <0101016eef12250c-9b276b04-01a9-4c6e-8cae-c458f9d5d203-000000@us-west-2.amazonses.com>
Date:   Tue, 10 Dec 2019 09:09:34 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <1570181084-4455-1-git-send-email-mojha@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-SES-Outgoing: 2019.12.10-54.240.27.55
Feedback-ID: 1.us-west-2.CZuq2qbDmUIuT3qdvXlRHZZCpfZqZ4GtG9v3VKgRyF0=:AmazonSES
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

gentle reminder.

On 10/4/2019 2:54 PM, Mukesh Ojha wrote:
> write_seqcountbeqin => write_seqcount_begin
>
> Signed-off-by: Mukesh Ojha <mojha@codeaurora.org>
> ---
>   include/linux/seqlock.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/linux/seqlock.h b/include/linux/seqlock.h
> index bcf4cf2..370ef8f 100644
> --- a/include/linux/seqlock.h
> +++ b/include/linux/seqlock.h
> @@ -42,7 +42,7 @@
>   /*
>    * Version using sequence counter only.
>    * This can be used when code has its own mutex protecting the
> - * updating starting before the write_seqcountbeqin() and ending
> + * updating starting before the write_seqcount_begin() and ending
>    * after the write_seqcount_end().
>    */
>   typedef struct seqcount {
