Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E691DC31E51
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 08:35:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C430520863
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 08:35:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729129AbfFRIfo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 04:35:44 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:59762 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725913AbfFRIfn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 04:35:43 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 423C427E950
Subject: Re: [RFC PATCH chrome-platform-linux] platform/chrome:
 cros_ec_debugfs: cros_ec_uptime_fops can be static
To:     kbuild test robot <lkp@intel.com>,
        Tim Wawrzynczak <twawrzynczak@chromium.org>
Cc:     kbuild-all@01.org, Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        linux-kernel@vger.kernel.org
References: <201906151827.DYouSmoA%lkp@intel.com>
 <20190615105512.GA152427@lkp-kbuild11>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <bd518a39-8aa4-d22f-0fad-6cd24697b218@collabora.com>
Date:   Tue, 18 Jun 2019 10:35:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <20190615105512.GA152427@lkp-kbuild11>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 15/6/19 12:55, kbuild test robot wrote:
> 
> Fixes: 909447f683b3 ("platform/chrome: cros_ec_debugfs: Add debugfs entry to retrieve EC uptime")
> Signed-off-by: kbuild test robot <lkp@intel.com>
> ---
>  cros_ec_debugfs.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/platform/chrome/cros_ec_debugfs.c b/drivers/platform/chrome/cros_ec_debugfs.c
> index 970ba13d..d40902e 100644
> --- a/drivers/platform/chrome/cros_ec_debugfs.c
> +++ b/drivers/platform/chrome/cros_ec_debugfs.c
> @@ -285,7 +285,7 @@ static const struct file_operations cros_ec_pdinfo_fops = {
>  	.llseek = default_llseek,
>  };
>  
> -const struct file_operations cros_ec_uptime_fops = {
> +static const struct file_operations cros_ec_uptime_fops = {
>  	.owner = THIS_MODULE,
>  	.open = simple_open,
>  	.read = cros_ec_uptime_read,
> 

applied for chrome-platform-5.3
