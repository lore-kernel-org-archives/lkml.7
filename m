Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 464EDC10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 13:17:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1489A20821
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 13:17:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="cH/4NAbM";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="cH/4NAbM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729268AbfDPNRm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 09:17:42 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:36092 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726796AbfDPNRl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 09:17:41 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 7F8506119F; Tue, 16 Apr 2019 13:17:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1555420660;
        bh=z3ndeu30m7fA4kT+0k5LNWnkWoyl3MPtE622MvKZJZE=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=cH/4NAbMjnhImtksVWztciKFaioLgGD/ct+VKwWRYGWa8/53V6GFENjC9urHtjFzE
         rtgsp27JKefY6wvZ6p6Ohlre1xI6wabdslsWn0AEJJnuLIg2KTWOZirqA9spwtMx7y
         VZqyh5seBL1BX6QeV6IL0TFzNScR3Ins1bHmtnds=
Received: from [10.204.79.15] (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mojha@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id C026060FEA;
        Tue, 16 Apr 2019 13:17:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1555420660;
        bh=z3ndeu30m7fA4kT+0k5LNWnkWoyl3MPtE622MvKZJZE=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=cH/4NAbMjnhImtksVWztciKFaioLgGD/ct+VKwWRYGWa8/53V6GFENjC9urHtjFzE
         rtgsp27JKefY6wvZ6p6Ohlre1xI6wabdslsWn0AEJJnuLIg2KTWOZirqA9spwtMx7y
         VZqyh5seBL1BX6QeV6IL0TFzNScR3Ins1bHmtnds=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C026060FEA
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mojha@codeaurora.org
Subject: Re: [PATCH] reiserfs: fix spelling mistake "enrty" -> "entry"
To:     Colin King <colin.king@canonical.com>,
        reiserfs-devel@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190416112549.25175-1-colin.king@canonical.com>
From:   Mukesh Ojha <mojha@codeaurora.org>
Message-ID: <240c2888-01a9-184f-7f29-eb603bdd36c4@codeaurora.org>
Date:   Tue, 16 Apr 2019 18:47:36 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190416112549.25175-1-colin.king@canonical.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/16/2019 4:55 PM, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
>
> There are a couple of spelling mistakes, fix these.
>
> Signed-off-by: Colin Ian King <colin.king@canonical.com>


Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>

Cheers,
-Mukesh

> ---
>   fs/reiserfs/lbalance.c | 2 +-
>   fs/reiserfs/namei.c    | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/fs/reiserfs/lbalance.c b/fs/reiserfs/lbalance.c
> index f5cebd70d903..e7cebd05a882 100644
> --- a/fs/reiserfs/lbalance.c
> +++ b/fs/reiserfs/lbalance.c
> @@ -1164,7 +1164,7 @@ void leaf_cut_from_buffer(struct buffer_info *bi, int cut_item_num,
>   		if (pos_in_item == 0) {
>   			/* change key */
>   			RFALSE(cut_item_num,
> -			       "when 0-th enrty of item is cut, that item must be first in the node, not %d-th",
> +			       "when 0-th entry of item is cut, that item must be first in the node, not %d-th",
>   			       cut_item_num);
>   			/* change item key by key of first entry in the item */
>   			set_le_ih_k_offset(ih, deh_offset(B_I_DEH(bh, ih)));
> diff --git a/fs/reiserfs/namei.c b/fs/reiserfs/namei.c
> index 97f3fc4fdd79..c97c36b4a31c 100644
> --- a/fs/reiserfs/namei.c
> +++ b/fs/reiserfs/namei.c
> @@ -536,7 +536,7 @@ static int reiserfs_add_entry(struct reiserfs_transaction_handle *th,
>   		pathrelse(&path);
>   		return -EBUSY;
>   	}
> -	/* adjust offset of directory enrty */
> +	/* adjust offset of directory entry */
>   	put_deh_offset(deh, SET_GENERATION_NUMBER(deh_offset(deh), gen_number));
>   	set_cpu_key_k_offset(&entry_key, deh_offset(deh));
>   
