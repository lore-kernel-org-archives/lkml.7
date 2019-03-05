Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C398BC43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 04:43:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F0DC206DD
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 04:43:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727032AbfCEEnL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 23:43:11 -0500
Received: from sandeen.net ([63.231.237.45]:36700 "EHLO sandeen.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726522AbfCEEnL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 23:43:11 -0500
Received: from [10.0.0.4] (liberator [10.0.0.4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by sandeen.net (Postfix) with ESMTPSA id 369F5EE5;
        Mon,  4 Mar 2019 22:42:36 -0600 (CST)
Subject: Re: [PATCH] sysctl: Fix proc_do_large_bitmap for large input buffers
To:     Eric Sandeen <sandeen@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        fsdevel <linux-fsdevel@vger.kernel.org>, netdev@vger.kernel.org
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>
References: <53be40fc-6ec4-c714-a64e-f69c96f7058f@redhat.com>
From:   Eric Sandeen <sandeen@sandeen.net>
Openpgp: preference=signencrypt
Autocrypt: addr=sandeen@sandeen.net; prefer-encrypt=mutual; keydata=
 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 pA==
Message-ID: <0ffd0eea-ca64-0128-2835-a9856b224e07@sandeen.net>
Date:   Mon, 4 Mar 2019 22:43:09 -0600
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:60.0)
 Gecko/20100101 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <53be40fc-6ec4-c714-a64e-f69c96f7058f@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/20/19 5:32 PM, Eric Sandeen wrote:
> Today, proc_do_large_bitmap() truncates a large write input buffer
> to PAGE_SIZE - 1, which may result in misparsed numbers at the
> (truncated) end of the buffer.  Further, it fails to notify the caller
> that the buffer was truncated, so it doesn't get called iteratively
> to finish the entire input buffer.
> 
> Tell the caller if there's more work to do by adding the skipped
> amount back to left/*lenp before returning.
> 
> To fix the misparsing, reset the position if we have completely
> consumed a truncated buffer (or if just one char is left, which
> may be a "-" in a range), and ask the caller to come back for
> more.
> 
> Signed-off-by: Eric Sandeen <sandeen@redhat.com>

Would be nice to fix this bug.  I submitted the test node patch as well
as an attempt to integrate it into the test harness, though there's
wonkiness there still, and I could use more experienced eyes.

Can we move this forward?

Thanks,
-Eric

> ---
> 
> diff --git a/kernel/sysctl.c b/kernel/sysctl.c
> index ba4d9e85feb8..970a96659809 100644
> --- a/kernel/sysctl.c
> +++ b/kernel/sysctl.c
> @@ -3089,9 +3089,13 @@ int proc_do_large_bitmap(struct ctl_table *table, int write,
>  
>  	if (write) {
>  		char *kbuf, *p;
> +		size_t skipped = 0;
>  
> -		if (left > PAGE_SIZE - 1)
> +		if (left > PAGE_SIZE - 1) {
>  			left = PAGE_SIZE - 1;
> +			/* How much of the buffer we'll skip this pass */
> +			skipped = *lenp - left;
> +		}
>  
>  		p = kbuf = memdup_user_nul(buffer, left);
>  		if (IS_ERR(kbuf))
> @@ -3108,9 +3112,22 @@ int proc_do_large_bitmap(struct ctl_table *table, int write,
>  		while (!err && left) {
>  			unsigned long val_a, val_b;
>  			bool neg;
> +			size_t saved_left;
>  
> +			/* In case we stop parsing mid-number, we can reset */
> +			saved_left = left;
>  			err = proc_get_long(&p, &left, &val_a, &neg, tr_a,
>  					     sizeof(tr_a), &c);
> +			/*
> +			 * If we consumed the entirety of a truncated buffer or
> +			 * only one char is left (may be a "-"), then stop here,
> +			 * reset, & come back for more.
> +			 */
> +			if ((left <= 1) && skipped) {
> +				left = saved_left;
> +				break;
> +			}
> +
>  			if (err)
>  				break;
>  			if (val_a >= bitmap_len || neg) {
> @@ -3128,6 +3145,15 @@ int proc_do_large_bitmap(struct ctl_table *table, int write,
>  				err = proc_get_long(&p, &left, &val_b,
>  						     &neg, tr_b, sizeof(tr_b),
>  						     &c);
> +				/*
> +				 * If we consumed all of a truncated buffer or
> +				 * then stop here, reset, & come back for more.
> +				 */
> +				if (!left && skipped) {
> +					left = saved_left;
> +					break;
> +				}
> +
>  				if (err)
>  					break;
>  				if (val_b >= bitmap_len || neg ||
> @@ -3146,6 +3172,7 @@ int proc_do_large_bitmap(struct ctl_table *table, int write,
>  			proc_skip_char(&p, &left, '\n');
>  		}
>  		kfree(kbuf);
> +		left += skipped;
>  	} else {
>  		unsigned long bit_a, bit_b = 0;
>  
> 
> 
