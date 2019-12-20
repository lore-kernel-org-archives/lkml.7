Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E5D8C43603
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 09:04:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DF05206EF
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 09:04:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727193AbfLTJEz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Dec 2019 04:04:55 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:58304 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727129AbfLTJEz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 04:04:55 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 2200128EA95
Subject: Re: [PATCH] platform/chrome: cros-ec: make init_lock static
To:     "Ben Dooks (Codethink)" <ben.dooks@codethink.co.uk>
Cc:     Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        linux-kernel@vger.kernel.org
References: <20191218100720.2420401-1-ben.dooks@codethink.co.uk>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <67800cf2-fb2c-11d4-87cb-18e6e426e437@collabora.com>
Date:   Fri, 20 Dec 2019 10:04:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20191218100720.2420401-1-ben.dooks@codethink.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ben,

Thanks for the patch.

On 18/12/19 11:07, Ben Dooks (Codethink) wrote:
> The init_lock is not declared or used outside of cros_ec_ishtp.c
> so make it static to avoid the following warning:
> 
> drivers/platform/chrome/cros_ec_ishtp.c:79:1: warning: symbol 'init_lock' was not declared. Should it be static?
> 
> Signed-off-by: Ben Dooks (Codethink) <ben.dooks@codethink.co.uk>

Applied for 5.6

> ---
> Cc: Benson Leung <bleung@chromium.org>
> Cc: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> Cc: Guenter Roeck <groeck@chromium.org>
> Cc: linux-kernel@vger.kernel.org
> ---
>  drivers/platform/chrome/cros_ec_ishtp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/platform/chrome/cros_ec_ishtp.c b/drivers/platform/chrome/cros_ec_ishtp.c
> index e5996821d08b..5f8e76f3022a 100644
> --- a/drivers/platform/chrome/cros_ec_ishtp.c
> +++ b/drivers/platform/chrome/cros_ec_ishtp.c
> @@ -76,7 +76,7 @@ struct cros_ish_in_msg {
>   *
>   * The writers are .reset() and .probe() function.
>   */
> -DECLARE_RWSEM(init_lock);
> +static DECLARE_RWSEM(init_lock);
>  
>  /**
>   * struct response_info - Encapsulate firmware response related
> 
