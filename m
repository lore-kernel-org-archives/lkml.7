Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47CE9C28CC0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 16:57:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19BB525DE6
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 16:57:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727831AbfE3Q5F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 12:57:05 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:51575 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725961AbfE3Q5F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 12:57:05 -0400
Received: from 79.184.255.225.ipv4.supernova.orange.pl (79.184.255.225) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.213)
 id 166932c14ea010ad; Thu, 30 May 2019 18:57:03 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jon Masters <jcm@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Borislav Petkov <bp@suse.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH 01/22] ABI: sysfs-devices-system-cpu: point to the right docs
Date:   Thu, 30 May 2019 18:57:02 +0200
Message-ID: <2094851.6rFF3BcFrm@kreacher>
In-Reply-To: <557b33a4ed53fb1cd5da927c533e7fe283629869.1559171394.git.mchehab+samsung@kernel.org>
References: <cover.1559171394.git.mchehab+samsung@kernel.org> <557b33a4ed53fb1cd5da927c533e7fe283629869.1559171394.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, May 30, 2019 1:23:32 AM CEST Mauro Carvalho Chehab wrote:
> The cpuidle doc was split on two, one at the admin guide
> and another one at the driver API guide. Instead of pointing
> to a non-existent file, point to both (admin guide being
> the first one).
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> ---
>  Documentation/ABI/testing/sysfs-devices-system-cpu | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-devices-system-cpu b/Documentation/ABI/testing/sysfs-devices-system-cpu
> index 1528239f69b2..87478ac6c2af 100644
> --- a/Documentation/ABI/testing/sysfs-devices-system-cpu
> +++ b/Documentation/ABI/testing/sysfs-devices-system-cpu
> @@ -137,7 +137,8 @@ Description:	Discover cpuidle policy and mechanism
>  		current_governor: (RW) displays current idle policy. Users can
>  		switch the governor at runtime by writing to this file.
>  
> -		See files in Documentation/cpuidle/ for more information.
> +		See Documentation/admin-guide/pm/cpuidle.rst and
> +		Documentation/driver-api/pm/cpuidle.rst for more information.
>  
>  
>  What:		/sys/devices/system/cpu/cpuX/cpuidle/stateN/name
> 




