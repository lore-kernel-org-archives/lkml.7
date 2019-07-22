Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A91B5C76188
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 11:28:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D1DE217D6
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 11:28:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728931AbfGVL2D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 07:28:03 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:53251 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726339AbfGVL2D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 07:28:03 -0400
Received: from [192.168.1.110] ([77.2.59.209]) by mrelayeu.kundenserver.de
 (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MODeL-1i4gmS1upd-00OUzH; Mon, 22 Jul 2019 13:27:57 +0200
Subject: Re: [PATCH 3/3] platform//x86/pcengines-apuv2: update gpio button
 definition
To:     Florian Eckert <fe@dev.tdt.de>, Eckert.Florian@googlemail.com,
        info@metux.net, dvhart@infradead.org, andy@infradead.org
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190704090205.19400-1-fe@dev.tdt.de>
 <20190704090205.19400-4-fe@dev.tdt.de>
From:   "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Organization: metux IT consult
Message-ID: <cca95ba1-6ac0-a2eb-9ae6-914a8783c1ad@metux.net>
Date:   Mon, 22 Jul 2019 13:27:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190704090205.19400-4-fe@dev.tdt.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:m8w2I/efKtMX8Bj3Zxwxo4ylumLdLVBWDdm0jN/TSvI90qhVQn7
 RH2M9cFAAOxds7X3KkynFxrBdsbmfJLL5VBfAvJelgdE2aOEkVVVfqEw5vBYktV2KhcFdSu
 XP1/7+F3L/KAOKb5/kRk0U1V4q9vdefrDZ+YoWh552py9hb4SZ6MHq1RHsdXeUNpyFiahLu
 9q5/PmGvx+8/PrBFzUGQA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:BaLexRi1z78=:EtsBshB8Y5Kb9YOFM9kiBs
 DQwv4x4K4KKvQSHtbSGqqPcZ2AbsWCebhYpO2wNQffbjDZbf1YBIFZQR3wZd+IJZM1osDAtcM
 0fpwcKduYuby1YdFz3PmjgtseEPDbXub7phUWa2+G+lGH3YUJs1lNCj9K9XZZoxR6pne4iDWW
 5s/uU/onXJ1jZ+nL3KxhTGTnKB1cquCcRbfvSE47he6tJxoQeP7Of5hHWTQcRrvn8oqmWEaWC
 2SjjJoEAJodvOdExXdy9NSNmUMFYiRwJZAgMLxWGd5HZtp7ush4absHy8eOsO+luw2pNfig8+
 e+oexgzNW8V+MRztKD7mMPdBj9cGU/00wGLZb5drizXN+ULNpso09Oip6YOHzlC2mbRrAitD1
 EqrQHQq+6Rpl3Vi9Cv/hQCZdMOqSmv+FuLCDOZRKnfRPSBDcG6PhJIbP/G7AizftQ1PdY3eq1
 lx0+lguiiTdlD+VkNX1oxs2l/hwi/Fx9NjDr0pQAV061iuMwHHtUo0ga69K1si0Kd4m6cpR1+
 U4cr8AgqJhCjLJkcb7A6KvY5FZ1vuC5xvkFtcCxBFLUe+wxFKaEFprwcb4dd1ujeFgO7rZ8a1
 S0p/chLvSAOKn1ncxaj9hEhBFmyBsgfg8RLOypOMxFGwjJxOBqtczWlieVr/a0B+7oFiZMg3E
 j1XqGiZVz5WI5YgWwuwJ4kTYEBM19+PKg0Vo6OXyT+K32ohmsjKJjvlau2NDy05mybYvgyklj
 7/m2V0j/Y1WhpLxmLsQ+UBU0kQE8iFrYHhuhPxDQBb9XPf1wxl9nAVhiIGM=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04.07.19 11:02, Florian Eckert wrote:
> * Add the gpio number, so the button subsystem can find the right gpio.
> * Change also the keycode from KEY_SETUP to KEY_RESTART, because it
>    seems more expressive to me and in the Alix-Board, which is the
>    predecessor, there isthis keycode defined too. I think this is also
>    intended by Pcengines. Also many embedded systems defined in the kernel
>    use this key code as well.
> 
> Signed-off-by: Florian Eckert <fe@dev.tdt.de>
> ---
>   drivers/platform/x86/pcengines-apuv2.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/platform/x86/pcengines-apuv2.c b/drivers/platform/x86/pcengines-apuv2.c
> index d50a50e9d34c..370fd2686d59 100644
> --- a/drivers/platform/x86/pcengines-apuv2.c
> +++ b/drivers/platform/x86/pcengines-apuv2.c
> @@ -116,7 +116,8 @@ struct gpiod_lookup_table gpios_led_table = {
>   
>   static struct gpio_keys_button apu2_keys_buttons[] = {
>   	{
> -		.code			= KEY_SETUP,
> +		.code			= KEY_RESTART,
> +		.gpio			= 508,
>   		.active_low		= 1,
>   		.desc			= "front button",
>   		.type			= EV_KEY,
> 

I'd like to ack only the keycode change, but not the deprecated .gpio 
field. I'll post a separate patch for the keycode change only.


--mtx

-- 
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
