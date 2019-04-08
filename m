Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1676C10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 16:58:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 780FE20880
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 16:58:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729214AbfDHQ63 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 12:58:29 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:33333 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728654AbfDHQ62 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 12:58:28 -0400
Received: from static-50-53-47-167.bvtn.or.frontiernet.net ([50.53.47.167] helo=[192.168.192.153])
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <john.johansen@canonical.com>)
        id 1hDXbE-0007Yp-7T; Mon, 08 Apr 2019 16:58:24 +0000
Subject: Re: [PATCH] apparmor: Restore Y/N in /sys for apparmor's "enabled"
To:     Kees Cook <keescook@chromium.org>, James Morris <jmorris@namei.org>
Cc:     David Rheinsberg <david.rheinsberg@gmail.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190408160706.GA18786@beast>
From:   John Johansen <john.johansen@canonical.com>
Openpgp: preference=signencrypt
Autocrypt: addr=john.johansen@canonical.com; prefer-encrypt=mutual; keydata=
 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
Organization: Canonical
Message-ID: <73c80352-ded1-626b-0eb0-a9481165f25d@canonical.com>
Date:   Mon, 8 Apr 2019 09:58:21 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190408160706.GA18786@beast>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/8/19 9:07 AM, Kees Cook wrote:
> Before commit c5459b829b71 ("LSM: Plumb visibility into optional "enabled"
> state"), /sys/module/apparmor/parameters/enabled would show "Y" or "N"
> since it was using the "bool" handler. After being changed to "int",
> this switched to "1" or "0", breaking the userspace AppArmor detection
> of dbus-broker. This restores the Y/N output while keeping the LSM
> infrastructure happy.
> 
> Before:
> 	$ cat /sys/module/apparmor/parameters/enabled
> 	1
> 
> After:
> 	$ cat /sys/module/apparmor/parameters/enabled
> 	Y
> 
> Reported-by: David Rheinsberg <david.rheinsberg@gmail.com>
> Link: https://lkml.kernel.org/r/CADyDSO6k8vYb1eryT4g6+EHrLCvb68GAbHVWuULkYjcZcYNhhw@mail.gmail.com
> Fixes: c5459b829b71 ("LSM: Plumb visibility into optional "enabled" state")
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
> This fix, if John is okay with it, is needed in v5.1 to correct the
> userspace regression reported by David.
> ---
>  security/apparmor/lsm.c | 49 ++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 48 insertions(+), 1 deletion(-)
> 
> diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
> index 49d664ddff44..87500bde5a92 100644
> --- a/security/apparmor/lsm.c
> +++ b/security/apparmor/lsm.c
> @@ -1336,9 +1336,16 @@ module_param_named(path_max, aa_g_path_max, aauint, S_IRUSR);
>  bool aa_g_paranoid_load = true;
>  module_param_named(paranoid_load, aa_g_paranoid_load, aabool, S_IRUGO);
>  
> +static int param_get_aaintbool(char *buffer, const struct kernel_param *kp);
> +static int param_set_aaintbool(const char *val, const struct kernel_param *kp);
> +#define param_check_aaintbool param_check_int
> +static const struct kernel_param_ops param_ops_aaintbool = {
> +	.set = param_set_aaintbool,
> +	.get = param_get_aaintbool
> +};
>  /* Boot time disable flag */
>  static int apparmor_enabled __lsm_ro_after_init = 1;
> -module_param_named(enabled, apparmor_enabled, int, 0444);
> +module_param_named(enabled, apparmor_enabled, aaintbool, 0444);
>  
>  static int __init apparmor_enabled_setup(char *str)
>  {
> @@ -1413,6 +1420,46 @@ static int param_get_aauint(char *buffer, const struct kernel_param *kp)
>  	return param_get_uint(buffer, kp);
>  }
>  
> +/* Can only be set before AppArmor is initialized (i.e. on boot cmdline). */
> +static int param_set_aaintbool(const char *val, const struct kernel_param *kp)
> +{
> +	struct kernel_param kp_local;
> +	bool value;
> +	int error;
> +
> +	if (apparmor_initialized)
> +		return -EPERM;
> +
This isn't sufficient/correct. apparmor_initialized is only set after
apparmor has gone through and completed initialization. However if
apparmor is not selected as one of the LSMs to enable, then this check
won't stop apparmor_enabled from being set post boot.

However with the apparmor_enabled param being 0444 and the
apparmor_enabled_setup() fn handling boot cmdline do with even need
the set parameter fn?

> +	/* Create local copy, with arg pointing to bool type. */
> +	value = !!*((int *)kp->arg);
> +	memcpy(&kp_local, kp, sizeof(kp_local));
> +	kp_local.arg = &value;
> +
> +	error = param_set_bool(val, &kp_local);
> +	if (!error)
> +		*((int *)kp->arg) = *((bool *)kp_local.arg);
> +	return error;
> +}
> +
> +/*
> + * To avoid changing /sys/module/apparmor/parameters/enabled from Y/N to
> + * 1/0, this converts the "int that is actually bool" back to bool for
> + * display in the /sys filesystem, while keeping it "int" for the LSM
> + * infrastructure.
> + */
> +static int param_get_aaintbool(char *buffer, const struct kernel_param *kp)
> +{
> +	struct kernel_param kp_local;
> +	bool value;
> +
> +	/* Create local copy, with arg pointing to bool type. */
> +	value = !!*((int *)kp->arg);
> +	memcpy(&kp_local, kp, sizeof(kp_local));
> +	kp_local.arg = &value;
> +
> +	return param_get_bool(buffer, &kp_local);
> +}
> +
>  static int param_get_audit(char *buffer, const struct kernel_param *kp)
>  {
>  	if (!apparmor_enabled)
> 

