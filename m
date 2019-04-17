Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91207C282DD
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 11:29:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67EA22073F
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 11:29:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731900AbfDQL3W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 07:29:22 -0400
Received: from foss.arm.com ([217.140.101.70]:43266 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731116AbfDQL3V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 07:29:21 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CE58F374;
        Wed, 17 Apr 2019 04:29:20 -0700 (PDT)
Received: from e110455-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9DA333F68F;
        Wed, 17 Apr 2019 04:29:20 -0700 (PDT)
Received: by e110455-lin.cambridge.arm.com (Postfix, from userid 1000)
        id 02301681DE6; Wed, 17 Apr 2019 12:29:18 +0100 (BST)
Date:   Wed, 17 Apr 2019 12:29:18 +0100
From:   Liviu Dudau <liviu.dudau@arm.com>
To:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        linux-hwmon@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        Sudeep Holla <sudeep.holla@arm.com>,
        Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v3 02/21] docs: hwmon: vexpress: convert to ReST format
Message-ID: <20190417112918.GV15144@e110455-lin.cambridge.arm.com>
References: <cover.1555494108.git.mchehab+samsung@kernel.org>
 <7f3e72d30c341b48d344110925a4f5fb3c92fe3c.1555494108.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7f3e72d30c341b48d344110925a4f5fb3c92fe3c.1555494108.git.mchehab+samsung@kernel.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 17, 2019 at 06:46:10AM -0300, Mauro Carvalho Chehab wrote:
> Convert vexpress to ReST format, in order to allow it to
> be parsed by Sphinx.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>

Acked-by: Liviu Dudau <liviu.dudau@arm.com>

Best regards,
Liviu

> ---
>  Documentation/hwmon/vexpress | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/hwmon/vexpress b/Documentation/hwmon/vexpress
> index 557d6d5ad90d..8c861c8151ac 100644
> --- a/Documentation/hwmon/vexpress
> +++ b/Documentation/hwmon/vexpress
> @@ -2,14 +2,21 @@ Kernel driver vexpress
>  ======================
>  
>  Supported systems:
> +
>    * ARM Ltd. Versatile Express platform
> +
>      Prefix: 'vexpress'
> +
>      Datasheets:
> +
>        * "Hardware Description" sections of the Technical Reference Manuals
> -        for the Versatile Express boards:
> -        http://infocenter.arm.com/help/topic/com.arm.doc.subset.boards.express/index.html
> +	for the Versatile Express boards:
> +
> +	- http://infocenter.arm.com/help/topic/com.arm.doc.subset.boards.express/index.html
> +
>        * Section "4.4.14. System Configuration registers" of the V2M-P1 TRM:
> -        http://infocenter.arm.com/help/index.jsp?topic=/com.arm.doc.dui0447-/index.html
> +
> +	- http://infocenter.arm.com/help/index.jsp?topic=/com.arm.doc.dui0447-/index.html
>  
>  Author: Pawel Moll
>  
> -- 
> 2.20.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ¯\_(ツ)_/¯
