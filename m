Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12D43C28EB6
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 10:22:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E677A206E0
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 10:22:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728348AbfFFKWC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Jun 2019 06:22:02 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:57184 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727469AbfFFKWB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 06:22:01 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id ED140263967
Subject: Re: [PATCH v2 -next] platform/chrome: cros_ec: Make some symbols
 static
To:     Benson Leung <bleung@google.com>,
        YueHaibing <yuehaibing@huawei.com>
Cc:     bleung@chromium.org, groeck@chromium.org,
        linux-kernel@vger.kernel.org
References: <20190529150749.8032-1-yuehaibing@huawei.com>
 <20190530084932.2576-1-yuehaibing@huawei.com>
 <20190530175349.GA24982@google.com>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <9ccd33ea-7745-c5e8-317e-0f8c28e7be2e@collabora.com>
Date:   Thu, 6 Jun 2019 12:21:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190530175349.GA24982@google.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 30/5/19 19:53, Benson Leung wrote:
> Hello YueHaibing,
> 
> On Thu, May 30, 2019 at 04:49:32PM +0800, YueHaibing wrote:
>> Fix sparse warning:
>>
>> drivers/platform/chrome/cros_ec_debugfs.c:256:30: warning: symbol 'cros_ec_console_log_fops' was not declared. Should it be static?
>> drivers/platform/chrome/cros_ec_debugfs.c:265:30: warning: symbol 'cros_ec_pdinfo_fops' was not declared. Should it be static?
>> drivers/platform/chrome/cros_ec_lightbar.c:550:24: warning: symbol 'cros_ec_lightbar_attr_group' was not declared. Should it be static?
>> drivers/platform/chrome/cros_ec_sysfs.c:338:24: warning: symbol 'cros_ec_attr_group' was not declared. Should it be static?
>> drivers/platform/chrome/cros_ec_vbc.c:104:24: warning: symbol 'cros_ec_vbc_attr_group' was not declared. Should it be static?
>> drivers/platform/chrome/cros_ec_lpc.c:408:25: warning: symbol 'cros_ec_lpc_pm_ops' was not declared. Should it be static?
>>
>> Reported-by: Hulk Robot <hulkci@huawei.com>
>> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> 
> Reviewed-by: Benson Leung <bleung@chromium.org>

applied for 5.3

Thanks,
 Enric

> 
>> ---
>> v2: fix patch title
>> ---
>>  drivers/platform/chrome/cros_ec_debugfs.c  | 4 ++--
>>  drivers/platform/chrome/cros_ec_lightbar.c | 2 +-
>>  drivers/platform/chrome/cros_ec_lpc.c      | 2 +-
>>  drivers/platform/chrome/cros_ec_sysfs.c    | 2 +-
>>  drivers/platform/chrome/cros_ec_vbc.c      | 2 +-
>>  5 files changed, 6 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/platform/chrome/cros_ec_debugfs.c b/drivers/platform/chrome/cros_ec_debugfs.c
>> index 4c2a27f6a6d0..4578eb3e0731 100644
>> --- a/drivers/platform/chrome/cros_ec_debugfs.c
>> +++ b/drivers/platform/chrome/cros_ec_debugfs.c
>> @@ -241,7 +241,7 @@ static ssize_t cros_ec_pdinfo_read(struct file *file,
>>  				       read_buf, p - read_buf);
>>  }
>>  
>> -const struct file_operations cros_ec_console_log_fops = {
>> +static const struct file_operations cros_ec_console_log_fops = {
>>  	.owner = THIS_MODULE,
>>  	.open = cros_ec_console_log_open,
>>  	.read = cros_ec_console_log_read,
>> @@ -250,7 +250,7 @@ const struct file_operations cros_ec_console_log_fops = {
>>  	.release = cros_ec_console_log_release,
>>  };
>>  
>> -const struct file_operations cros_ec_pdinfo_fops = {
>> +static const struct file_operations cros_ec_pdinfo_fops = {
>>  	.owner = THIS_MODULE,
>>  	.open = simple_open,
>>  	.read = cros_ec_pdinfo_read,
>> diff --git a/drivers/platform/chrome/cros_ec_lightbar.c b/drivers/platform/chrome/cros_ec_lightbar.c
>> index d30a6650b0b5..23a82ee4c785 100644
>> --- a/drivers/platform/chrome/cros_ec_lightbar.c
>> +++ b/drivers/platform/chrome/cros_ec_lightbar.c
>> @@ -547,7 +547,7 @@ static struct attribute *__lb_cmds_attrs[] = {
>>  	NULL,
>>  };
>>  
>> -struct attribute_group cros_ec_lightbar_attr_group = {
>> +static struct attribute_group cros_ec_lightbar_attr_group = {
>>  	.name = "lightbar",
>>  	.attrs = __lb_cmds_attrs,
>>  };
>> diff --git a/drivers/platform/chrome/cros_ec_lpc.c b/drivers/platform/chrome/cros_ec_lpc.c
>> index c9c240fbe7c6..aaa21803633a 100644
>> --- a/drivers/platform/chrome/cros_ec_lpc.c
>> +++ b/drivers/platform/chrome/cros_ec_lpc.c
>> @@ -405,7 +405,7 @@ static int cros_ec_lpc_resume(struct device *dev)
>>  }
>>  #endif
>>  
>> -const struct dev_pm_ops cros_ec_lpc_pm_ops = {
>> +static const struct dev_pm_ops cros_ec_lpc_pm_ops = {
>>  	SET_LATE_SYSTEM_SLEEP_PM_OPS(cros_ec_lpc_suspend, cros_ec_lpc_resume)
>>  };
>>  
>> diff --git a/drivers/platform/chrome/cros_ec_sysfs.c b/drivers/platform/chrome/cros_ec_sysfs.c
>> index fe0b7614ae1b..3edb237bf8ed 100644
>> --- a/drivers/platform/chrome/cros_ec_sysfs.c
>> +++ b/drivers/platform/chrome/cros_ec_sysfs.c
>> @@ -335,7 +335,7 @@ static umode_t cros_ec_ctrl_visible(struct kobject *kobj,
>>  	return a->mode;
>>  }
>>  
>> -struct attribute_group cros_ec_attr_group = {
>> +static struct attribute_group cros_ec_attr_group = {
>>  	.attrs = __ec_attrs,
>>  	.is_visible = cros_ec_ctrl_visible,
>>  };
>> diff --git a/drivers/platform/chrome/cros_ec_vbc.c b/drivers/platform/chrome/cros_ec_vbc.c
>> index 8392a1ec33a7..2aaefed87eb4 100644
>> --- a/drivers/platform/chrome/cros_ec_vbc.c
>> +++ b/drivers/platform/chrome/cros_ec_vbc.c
>> @@ -101,7 +101,7 @@ static struct bin_attribute *cros_ec_vbc_bin_attrs[] = {
>>  	NULL
>>  };
>>  
>> -struct attribute_group cros_ec_vbc_attr_group = {
>> +static struct attribute_group cros_ec_vbc_attr_group = {
>>  	.name = "vbc",
>>  	.bin_attrs = cros_ec_vbc_bin_attrs,
>>  };
>> -- 
>> 2.17.1
>>
>>
> 
