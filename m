Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31964C7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 21:43:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BDF721951
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 21:43:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732888AbfGVVnm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 17:43:42 -0400
Received: from 195-159-176-226.customer.powertech.no ([195.159.176.226]:45124
        "EHLO blaine.gmane.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730892AbfGVVnm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 17:43:42 -0400
Received: from list by blaine.gmane.org with local (Exim 4.89)
        (envelope-from <glk-linux-kernel-4@m.gmane.org>)
        id 1hpg5r-0014xo-Rd
        for linux-kernel@vger.kernel.org; Mon, 22 Jul 2019 23:43:39 +0200
X-Injected-Via-Gmane: http://gmane.org/
To:     linux-kernel@vger.kernel.org
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH][next] clk: Si5341/Si5340: remove redundant assignment to
 n_den
Date:   Mon, 22 Jul 2019 23:43:32 +0200
Message-ID: <d1cd2b10-8fd4-f224-3bcd-5b938f72d249@wanadoo.fr>
References: <20190701165020.19840-1-colin.king@canonical.com>
 <20190722212414.6EF8D21900@mail.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format="flowed"
Content-Transfer-Encoding: 8bit
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
In-Reply-To: <20190722212414.6EF8D21900@mail.kernel.org>
Content-Language: en-US
Cc:     linux-clk@vger.kernel.org, kernel-janitors@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Message-ID: <20190722214332.cZaGCjD70l69rcOBCyOb-iGoxBPL5LxVCVT9xEx-8pM@z>

Le 22/07/2019 à 23:24, Stephen Boyd a écrit :
> Please Cc authors of drivers so they can ack/review.
>
> Adding Mike to take a look.
>
> Quoting Colin King (2019-07-01 09:50:20)
>> From: Colin Ian King <colin.king@canonical.com>
>>
>> The variable n_den is initialized however that value is never read
>> as n_den is re-assigned a little later in the two paths of a
>> following if-statement.  Remove the redundant assignment.
>>
>> Addresses-Coverity: ("Unused value")
>> Signed-off-by: Colin Ian King <colin.king@canonical.com>
>> ---
>>   drivers/clk/clk-si5341.c | 1 -
>>   1 file changed, 1 deletion(-)
>>
>> diff --git a/drivers/clk/clk-si5341.c b/drivers/clk/clk-si5341.c
>> index 72424eb7e5f8..6e780c2a9e6b 100644
>> --- a/drivers/clk/clk-si5341.c
>> +++ b/drivers/clk/clk-si5341.c
>> @@ -547,7 +547,6 @@ static int si5341_synth_clk_set_rate(struct clk_hw *hw, unsigned long rate,
>>          bool is_integer;
>>   
>>          n_num = synth->data->freq_vco;
>> -       n_den = rate;
>>   
>>          /* see if there's an integer solution */
>>          r = do_div(n_num, rate);
>
Hi,

I got the same advise from some else no later than yesterday (i.e. email 
the author...)
Maybe 'get_maintainer.pl' could be improved to search for it and propose 
the mail automatically?

just my 2c.


CJ


