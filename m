Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B88CFC10F14
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 15:35:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8746F2082E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 15:35:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=aol.com header.i=@aol.com header.b="eGnU9uej"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727064AbfDLPfU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 11:35:20 -0400
Received: from sonic310-21.consmr.mail.gq1.yahoo.com ([98.137.69.147]:35126
        "EHLO sonic310-21.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726788AbfDLPfU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 11:35:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048; t=1555083318; bh=uaciLfy/VoqVdDClyYl9VeSjZLwDdIqd5BtE+jH39Zg=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=eGnU9uejDGyxKQ1sepxiGDdQmIFixIbU0N9Xg3u7NsHGlajCZkgWQVMoEp9lqA97twdHkKu8vXwRJOvpH09tTAuuoKmUdS30qJ5o82Ki8MgRVl0/HGsLXD83p3YS/J86azxUjXy4e0PPj/Y/9MAyR/33W/cg/Hyit828cBf+cUWfUbO8++ITQs23fe05pJlcMt7tf+o6LF7BAm213HPncoB6T+Jskl6qPX4+0OK3Viu6HaG0pA9opJtA4uOLNSexPRyIrHhEyB1lZnQISRQ+XEX+iJshLSRH0vgAI01UY7YchKl7CoY7vzS9cAbSElaTsPU4BcfDIqtnW4iJAXad7Q==
X-YMail-OSG: wTITPocVM1n5cA7ffP8ZfvIJ4xUVKhgSnlq2GtZobYAQrYuaMtERtm.OEihbyGL
 JJvlqQ_71tgSs5tJaFsk_oZrRvRHa4_EYUZx7s7OUtQTdPBlzoQmeQHMjRE27ARI8FFjQjpVl_zv
 2I9kn8jDx_hfCAY.cIjqYt_XXRnz6hdXwta8UGlN_cOxuK_qcBvC5IQHR8R9f2rk5cVdE5G19QjK
 SyoqnSwViglxVpnypn_Ip8E2UEq5AjOUJX_l9V28v2FucwUOoUtg4i8PYdSuNNPIfKxxlJ2rI8hX
 oMdMzxgpE0tIYMZXiVUCbAi5Jtz88iLB0VVxnfu3BrAROCEqEZpYeX2Rp8.2_Ae2W2tXFHR2BDt2
 ISpb7E3VitE1XH8bdfAE.qaMhFaa0YVfz.Ki00t0stB4INhIj5aT1YM59b3F8lpVepWL5.FoepcF
 T_RNjzdJu3QQ_bu9hYMjsppZnrxkeVC279PnalP0RXBqwQUffQgB5w0vqyyG.e0Ye5u.XnTP7wOu
 psdsSQExTmOTHW218mWTVnI7A9BBxiI0cg29pQYCOXD37KLK6z._6R4m0OfdUsQXZdK9PoBeu5b3
 3zj65RFaBNq9gHUx5HcFjR8tKJ1qWSYQ1UpxzMsjKQ60aWyujiVWgJ8AfarZHEit5F04sSes0Crq
 9IgbN3UH2cLXZkVoazdB3HwoM0Y5hS9KUgQ7XB8kaOrYHKUDO2FIx02ZfyXR9_zekUfr8VqB4HOZ
 lL_QH.GUyZWPlNnHoHetElUY_UfOO64wm34b33iVHI.F.1N1mmUMkLpTcM04rwqSpRSUbHa1bjSV
 S2kPHbZs0IfDmkK99MzYALRiSjMBkWoHEOlcNv_ZDFx.h2GzEmgWmp_E1Ybaz0h79ChkVUnow.Cy
 we_.vyOct6AO5D6BuNSrAcR2M6K8GY0_VvPlIvFYTsQJUwzdWCxj3OxufHpc8XgDaaaLqkuKfxkV
 20AqLPTWoLN4A13nI3u9lMv77YPa3Zt2ULTIT1.sUI1jNVlG4mkap11qi_or2IxrCdrpKHccGwqg
 ifmh.fynOvCapKUh_kzheaN6JSHhTe3G_.t.UbqUOREtVr835XVglxQ1HPs2AoA--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic310.consmr.mail.gq1.yahoo.com with HTTP; Fri, 12 Apr 2019 15:35:18 +0000
Received: from 183.134.187.219 (EHLO [10.1.1.220]) ([183.134.187.219])
          by smtp432.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 53db40ec785a159b4a67631c6d11b77f;
          Fri, 12 Apr 2019 15:35:16 +0000 (UTC)
Subject: Re: [PATCH] staging: erofs: fix unexpected out-of-bound data access
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Gao Xiang <gaoxiang25@huawei.com>, devel@driverdev.osuosl.org,
        Chao Yu <chao@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Miao Xie <miaoxie@huawei.com>, Chao Yu <yuchao0@huawei.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Ming Lei <ming.lei@redhat.com>, weidu.du@huawei.com,
        Fang Wei <fangwei1@huawei.com>, linux-erofs@lists.ozlabs.org
References: <20190411105555.133551-1-gaoxiang25@huawei.com>
 <20190412150633.GA20776@infradead.org>
From:   Gao Xiang <hsiangkao@aol.com>
Message-ID: <a34cb628-ca2f-0497-2a51-5d1ddf318650@aol.com>
Date:   Fri, 12 Apr 2019 23:35:08 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190412150633.GA20776@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christoph,

On 2019/4/12 23:06, Christoph Hellwig wrote:
>> +++ b/drivers/staging/erofs/data.c
>> @@ -304,7 +304,7 @@ static inline struct bio *erofs_read_raw_page(struct bio *bio,
>>  	*last_block = current_block;
>>  
>>  	/* shift in advance in case of it followed by too many gaps */
>> -	if (unlikely(bio->bi_vcnt >= bio->bi_max_vecs)) {
>> +	if (bio->bi_iter.bi_size >= bio->bi_max_vecs * PAGE_SIZE) {
> 
> This is still a very odd check.  bi_max_vecs * PAGE_SIZE is rather
> arbitrary… and more importantly bi_max_vecs is not really a public
> field, in fact this is the only place every using it outside the
> core block layer.
> 
> I think the logic in this function should be reworked to what we
> do elsewhere in the kernel, that is just add to the bio until
> bio_add_page fails, in which case you submit the bio and start
> a new one.  Then once you are done with your operation just submit
> the bio.  Which unless I'm missing something is what the code does,
> except for the goto loop obsfucation that is trying to hide it.
> 
> So why not something like:
> 
> 
> diff --git a/drivers/staging/erofs/data.c b/drivers/staging/erofs/data.c
> index 0714061ba888..122714e19079 100644
> --- a/drivers/staging/erofs/data.c
> +++ b/drivers/staging/erofs/data.c
> @@ -296,20 +296,9 @@ static inline struct bio *erofs_read_raw_page(struct bio *bio,
>  		}
>  	}
>  
> -	err = bio_add_page(bio, page, PAGE_SIZE, 0);
> -	/* out of the extent or bio is full */
> -	if (err < PAGE_SIZE)
> +	if (bio_add_page(bio, page, PAGE_SIZE, 0) != PAGE_SIZE)
>  		goto submit_bio_retry;

Thanks for your kindly reply. I think it doesn't work for the current logic
since nblocks also indicates the block(page) distance of end of map_blocks
bound (see my explanation in the email [1])...

[1] https://lore.kernel.org/lkml/cb392476-a00e-09ce-fa6b-9e088242ecc6@huawei.com/

and
 nblocks = min(distance to the end of mapping, nr of remaining pages to read, BIO_MAX_PAGES)
 bio->bi_max_vecs = nblocks (which is the worst case if pages cannot be merged)
 

Currently I think a patch is needed to fix for linux-5.1, iomap is in consideration
as well months ago [2]. However it needs to be done later and with some careful tests.

[2] https://lore.kernel.org/lkml/c742194d-4207-e7b9-b679-c1f207961f17@huawei.com/

So I think let's fix it as it is in linux-5.1, and I will turn into iomap in my free time.

Thanks,
Gao Xiang

> -
>  	*last_block = current_block;
> -
> -	/* shift in advance in case of it followed by too many gaps */
> -	if (unlikely(bio->bi_vcnt >= bio->bi_max_vecs)) {
> -		/* err should reassign to 0 after submitting */
> -		err = 0;
> -		goto submit_bio_out;
> -	}
> -
>  	return bio;
>  
>  err_out:
> @@ -323,9 +312,7 @@ static inline struct bio *erofs_read_raw_page(struct bio *bio,
>  
>  	/* if updated manually, continuous pages has a gap */
>  	if (bio)
> -submit_bio_out:
>  		__submit_bio(bio, REQ_OP_READ, 0);
> -
>  	return unlikely(err) ? ERR_PTR(err) : NULL;
>  }
>  
> @@ -387,8 +374,7 @@ static int erofs_raw_access_readpages(struct file *filp,
>  	}
>  	DBG_BUGON(!list_empty(pages));
>  
> -	/* the rare case (end in gaps) */
> -	if (unlikely(bio))
> +	if (bio)
>  		__submit_bio(bio, REQ_OP_READ, 0);
>  	return 0;
>  }
> 
>>  		/* err should reassign to 0 after submitting */
>>  		err = 0;
>>  		goto submit_bio_out;
>> -- 
>> 2.17.1
>>
> ---end quoted text---
> _______________________________________________
> devel mailing list
> devel@linuxdriverproject.org
> http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
> 
